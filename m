Received: from eggs.gnu.org ([2001:4830:134:3::10]:42346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1ctbim-00073y-Hl
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1ctbil-0003GQ-4B
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:10:44 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:34793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shah.suramya@gmail.com>)
	id 1ctbik-0003GG-VZ
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:10:43 -0400
Received: by mail-it0-x243.google.com with SMTP id e75so13357956itd.1
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 08:10:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170330145719.12068-1-shah.suramya@gmail.com>
References: <20170330145719.12068-1-shah.suramya@gmail.com>
From: Suramya Shah <shah.suramya@gmail.com>
Date: Thu, 30 Mar 2017 20:40:42 +0530
Message-ID: <CABH=oPx91VFrT-DR+5L+WK8rOunjEZUmuvuaLT89UqjHMZmBwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/unicore32: fix a kernel_filename!=NULL
 assertion error in puv3.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, gxt@mprc.pku.edu.cn

Kindly have a look at the forwarded patch.

On 30-Mar-2017 8:28 PM, "Suramya Shah" <shah.suramya@gmail.com> wrote:

> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
> ---
> Running QEMU with qemu-system-unicore32 without the kernel parameter
> results in an assertion error.
> Fix this by..
>  hw/unicore32/puv3.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
> index 032078f..2c17cc9 100644
> --- a/hw/unicore32/puv3.c
> +++ b/hw/unicore32/puv3.c
> @@ -93,8 +93,11 @@ static void puv3_load_kernel(const char
> *kernel_filename)
>      if (kernel_filename == NULL && qtest_enabled()) {
>          return;
>      }
> -    assert(kernel_filename != NULL);
> -
> +    if (kernel_filename == NULL) {
> +        error_report("No kernel found");
> +        exit(1);
> +    }
> +
>      /* only zImage format supported */
>      size = load_image_targphys(kernel_filename, KERNEL_LOAD_ADDR,
>              KERNEL_MAX_SIZE);
> --
> 2.9.3
>
>
