Received: from eggs.gnu.org ([2001:4830:134:3::10]:53123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSwf1-0002wH-8n
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 22:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSwex-000492-Ai
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 22:36:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dSwex-00048o-4u
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 22:36:51 -0400
References: <cover.1499276048.git.alistair.francis@xilinx.com>
	<170687a37cb487aec9b2b600e563f3d93440b2e8.1499276048.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <09e83b45-8b34-0639-3626-331fd828fc56@redhat.com>
Date: Thu, 6 Jul 2017 04:36:44 +0200
MIME-Version: 1.0
In-Reply-To: <170687a37cb487aec9b2b600e563f3d93440b2e8.1499276048.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v3 1/3] util/qemu-error: Rename
 error_print_loc() to be more generic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, philippe@mathieu-daude.net, armbru@redhat.com

On 05.07.2017 19:36, Alistair Francis wrote:
> Rename the error_print_loc() function in preparation for using it to
> print warnings as well.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>=20
>  util/qemu-error.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/util/qemu-error.c b/util/qemu-error.c
> index b331f8f4a4..1c5e35ecdb 100644
> --- a/util/qemu-error.c
> +++ b/util/qemu-error.c
> @@ -146,7 +146,7 @@ const char *error_get_progname(void)
>  /*
>   * Print current location to current monitor if we have one, else to s=
tderr.
>   */
> -static void error_print_loc(void)
> +static void print_loc(void)
>  {
>      const char *sep =3D "";
>      int i;
> @@ -197,7 +197,7 @@ void error_vreport(const char *fmt, va_list ap)
>          g_free(timestr);
>      }
> =20
> -    error_print_loc();
> +    print_loc();
>      error_vprintf(fmt, ap);
>      error_printf("\n");
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>
