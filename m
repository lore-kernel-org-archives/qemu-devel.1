Received: from eggs.gnu.org ([2001:4830:134:3::10]:55452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7yum-0001Is-Mq
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 04:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7ynD-0007Xr-Mr
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 04:15:36 -0400
References: <20181003132041.10075-1-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <aee68960-248e-6930-2375-2fbc767f1d5f@redhat.com>
Date: Thu, 4 Oct 2018 10:15:24 +0200
MIME-Version: 1.0
In-Reply-To: <20181003132041.10075-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: remove glib_subprocess check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On 2018-10-03 15:20, Marc-Andr=C3=A9 Lureau wrote:
> This should have been removed as part of commit
> 692fbdf9f4c6f6bafd0b3a4d4f94973effd3bbae.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  configure | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/configure b/configure
> index a7368044cc..4f6d6e03b1 100755
> --- a/configure
> +++ b/configure
> @@ -3557,12 +3557,6 @@ if ! compile_prog "$CFLAGS" "$LIBS" ; then
>  	       "build target"
>  fi
> =20
> -# g_test_trap_subprocess added in 2.38. Used by some tests.
> -glib_subprocess=3Dyes
> -if ! $pkg_config --atleast-version=3D2.38 glib-2.0; then
> -    glib_subprocess=3Dno
> -fi
> -
>  # Silence clang 3.5.0 warnings about glib attribute __alloc_size__ usa=
ge
>  cat > $TMPC << EOF
>  #include <glib.h>
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
