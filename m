Received: from eggs.gnu.org ([2001:4830:134:3::10]:43421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1faj2j-00014h-Ef
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1faj2g-0006u0-Sx
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:46:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1faj2g-0006sy-Nd
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:46:02 -0400
Date: Wed, 4 Jul 2018 16:45:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180704164558.6af5fc3f.cohuck@redhat.com>
In-Reply-To: <20180704143014.8670-1-f4bug@amsat.org>
References: <20180704143014.8670-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Do not display host compilers
 as cross-compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, "Dr . David Alan
	Gilbert" <dgilbert@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On Wed,  4 Jul 2018 11:30:14 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> This silent (since d75402b5ee2):

s/silent/silences/

>=20
>   ./configure
>   [...]
>   NOTE: cross-compilers enabled:  'cc'
>=20
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index b99ebdde24..fbb53ab6bb 100755
> --- a/configure
> +++ b/configure
> @@ -7328,7 +7328,7 @@ echo "QEMU_CFLAGS+=3D$cflags" >> $config_target_mak
> =20
>  done # for target in $targets
> =20
> -if test -n "$enabled_cross_compilers"; then
> +if test -n "$target_compiler" -a -n "$enabled_cross_compilers"; then
>      echo
>      echo "NOTE: cross-compilers enabled: $enabled_cross_compilers"
>  fi

Yeah, noticed that as well.

Acked-by: Cornelia Huck <cohuck@redhat.com>
