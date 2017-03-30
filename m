Received: from eggs.gnu.org ([2001:4830:134:3::10]:45164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ctbs9-0003Kz-98
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ctbs4-00029i-AQ
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:20:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ctbs4-00028P-3g
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:20:20 -0400
References: <20170330145719.12068-1-shah.suramya@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <db815d78-58c5-fead-3502-04d4dc4b717e@redhat.com>
Date: Thu, 30 Mar 2017 18:20:11 +0300
MIME-Version: 1.0
In-Reply-To: <20170330145719.12068-1-shah.suramya@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Suramya Shah <shah.suramya@gmail.com>, qemu-devel@nongnu.org

On 03/30/2017 05:57 PM, Suramya Shah wrote:
> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>

Hi,

Thank you for contributing to QEMU project.

I suggest to avoid details in the subject, use something like:
    "hw/unicore32: remove wrong assertion in puv machine init"

> ---
> Running QEMU with qemu-system-unicore32 without the kernel parameter results in an assertion error.


The description should appear before the "---" separator.
The patch cannot be applied.

Please use git format-patch to prepare the patch.
Please run ./scripts/checkpatch.pl before sending the patch.

> Fix this by..

This is not enough for a description.
Try to briefly explain how/why you fixed it.

     "Assert should not be used to check user provided parameters.
      Report an error and exit instead"

Thanks,
Marcel

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
