Received: from eggs.gnu.org ([2001:4830:134:3::10]:60542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ctcaI-0004vx-Ou
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ctcaF-0001Lt-LV
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:06:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ctcaF-0001LR-Dw
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:05:59 -0400
References: <20170330154413.22014-1-shah.suramya@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <8611caeb-141e-d01c-64dc-c37834355b43@redhat.com>
Date: Thu, 30 Mar 2017 19:05:54 +0300
MIME-Version: 1.0
In-Reply-To: <20170330154413.22014-1-shah.suramya@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/unicore32: remove wrong assertion in
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

On 03/30/2017 06:44 PM, Suramya Shah wrote:

Hi,

> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>

Please add the SOB after the description.

> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Please do not add a reviewer to your patch
unless he approved /added his signature by himself.

>
> Running QEMU with qemu-system-unicore32 without the kernel parameter results in an assertion error.
> Assert should not be used to check user provided parameters. Report an error and exit instead
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

The patch can't be applied, please create the patch with "git format patch".

Thanks,
Marcel
