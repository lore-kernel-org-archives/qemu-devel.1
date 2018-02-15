Received: from eggs.gnu.org ([2001:4830:134:3::10]:50201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNQo-0005Ls-Sm
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNQl-0000hB-Q5
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:34:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59004 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1emNQl-0000gv-L2
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:34:47 -0500
Date: Thu, 15 Feb 2018 17:34:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180215173429.GB24818@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180215172306.10389-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180215172306.10389-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: dump 'config.log' if ./configure
 fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On Thu, Feb 15, 2018 at 02:23:06PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/docker/common.rc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index 7951555e3f..dd011cdf1e 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -30,7 +30,9 @@ build_qemu()
>                   $@"
>      echo "Configure options:"
>      echo $config_opts
> -    $QEMU_SRC/configure $config_opts && make $MAKEFLAGS
> +    $QEMU_SRC/configure $config_opts || \
> +        (cat config.log && prep_fail "Failed to run 'configure'")
> +    make $MAKEFLAGS
>  }

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Slightly nicer than my patch thanks to the prep_fail addition.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
