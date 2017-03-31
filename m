Received: from eggs.gnu.org ([2001:4830:134:3::10]:36218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ctw65-0007Fk-V3
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ctw61-00060C-0P
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:56:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ctw60-0005zM-QT
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:56:04 -0400
References: <20170330165008.26419-1-shah.suramya@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6ea9c34f-3dd5-95de-4915-1009215a67c8@redhat.com>
Date: Fri, 31 Mar 2017 14:55:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170330165008.26419-1-shah.suramya@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5] hw/unicore32: remove wrong assertion in
 puv machine init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suramya Shah <shah.suramya@gmail.com>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, gxt@mprc.pku.edu.cn

On 30.03.2017 18:50, Suramya Shah wrote:
> Running QEMU with qemu-system-unicore32 without the kernel parameter re=
sults in an assertion error.
> Assert should not be used to check user provided parameters. Report an =
error and exit instead
> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>

Nit: There should be a blank line between the description and the
"Signed-off-by" line.
And another nit: Since some people are still using 80-columns terminal
windows, it's also nicer to wrap the description at the 80 columns
barrier (or even 76 columns already) instead.

> ---
>  hw/unicore32/puv3.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
> index 032078f..2c17cc9 100644
> --- a/hw/unicore32/puv3.c
> +++ b/hw/unicore32/puv3.c
> @@ -93,8 +93,11 @@ static void puv3_load_kernel(const char *kernel_file=
name)
>      if (kernel_filename =3D=3D NULL && qtest_enabled()) {
>          return;
>      }
> -    assert(kernel_filename !=3D NULL);
> -
> +    if (kernel_filename =3D=3D NULL) {
> +        error_report("No kernel found");

It's maybe better to give clear instructions to the user, like:
"Need a kernel, please provide one with the '-kernel' option"

> +        exit(1);
> +    }
> +
>      /* only zImage format supported */
>      size =3D load_image_targphys(kernel_filename, KERNEL_LOAD_ADDR,
>              KERNEL_MAX_SIZE);
>=20

 Thomas
