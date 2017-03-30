Received: from eggs.gnu.org ([2001:4830:134:3::10]:43932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ctdBY-0007C0-IH
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ctdBV-0006Ao-Dr
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:44:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ctdBV-0006AX-80
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:44:29 -0400
References: <20170330163407.26263-1-shah.suramya@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <eebc1434-09e7-6b35-1e86-c9a1462344ca@redhat.com>
Date: Thu, 30 Mar 2017 19:44:20 +0300
MIME-Version: 1.0
In-Reply-To: <20170330163407.26263-1-shah.suramya@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] hw/unicore32: remove wrong assertion in
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
Cc: gxt@mprc.pku.edu.cn

On 03/30/2017 07:34 PM, Suramya Shah wrote:

Hi,
Much better now, only a nit..

> Running QEMU with qemu-system-unicore32 without the kernel parameter results in an assertion error.Assert should not be used to check user provided parameters. Report an error and exit instead

You should break the above into a few lines, we don't "like" long lines.

Thanks,
Marcel

> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
> ---
>  hw/unicore32/puv3.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
> index 032078f..2c17cc9 100644
> --- a/hw/unicore32/puv3.c
> +++ b/hw/unicore32/puv3.c
> @@ -93,8 +93,11 @@ static void puv3_load_kernel(const char *kernel_filename)
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
>
