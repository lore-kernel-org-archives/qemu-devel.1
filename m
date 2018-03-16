Received: from eggs.gnu.org ([2001:4830:134:3::10]:54054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eweGF-0004Ys-Nf
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 21:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eweGC-00082W-LC
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 21:34:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46176 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eweGC-00082B-Gx
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 21:34:20 -0400
Date: Fri, 16 Mar 2018 09:34:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180316013402.GA13063@lemon.usersys.redhat.com>
References: <20180315142713.30960-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180315142713.30960-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] docker: dump 'config.log' if
 ./configure fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>

On Thu, 03/15 15:27, Philippe Mathieu-Daud=E9 wrote:
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
> v2:
> - avoid subshell using { ; } (Eric)
> - use test_fail() instead of prep_fail() (Fam)
>=20
>  tests/docker/common.rc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index 7951555e3f..046f8a5921 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -30,7 +30,9 @@ build_qemu()
>                   $@"
>      echo "Configure options:"
>      echo $config_opts
> -    $QEMU_SRC/configure $config_opts && make $MAKEFLAGS
> +    $QEMU_SRC/configure $config_opts || \
> +        { cat config.log && test_fail "Failed to run 'configure'"; }
> +    make $MAKEFLAGS
>  }
> =20
>  test_fail()
> --=20
> 2.16.2
>=20

Queued, thanks!

Fam
