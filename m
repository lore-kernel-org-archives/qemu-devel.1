Received: from eggs.gnu.org ([2001:4830:134:3::10]:50201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPRxY-0003c8-Hy
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPRxV-00027p-Ey
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:13:36 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPRxV-00027V-B4
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:13:33 -0400
Received: by mail-qk0-x243.google.com with SMTP id 16so13977592qkg.2
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 04:13:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1498454578-18709-1-git-send-email-thuth@redhat.com>
	<1498454578-18709-8-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <25f0004b-fab9-c510-759a-bf9180f6f0fd@amsat.org>
Date: Mon, 26 Jun 2017 08:13:30 -0300
MIME-Version: 1.0
In-Reply-To: <1498454578-18709-8-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 7/7] hw/misc/edu: Compile the edu device
 as common object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 06/26/2017 02:22 AM, Thomas Huth wrote:
> edu.c does not contain any target-specific code, so we can put
> it into common-obj-y to compile it only once for all targets.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/misc/Makefile.objs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 2019846..7fc4e41 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -6,6 +6,7 @@ common-obj-$(CONFIG_ISA_DEBUG) += debugexit.o
>   common-obj-$(CONFIG_SGA) += sga.o
>   common-obj-$(CONFIG_ISA_TESTDEV) += pc-testdev.o
>   common-obj-$(CONFIG_PCI_TESTDEV) += pci-testdev.o
> +common-obj-$(CONFIG_EDU) += edu.o
>   
>   common-obj-y += unimp.o
>   
> @@ -53,7 +54,6 @@ obj-$(CONFIG_MIPS_CPS) += mips_cpc.o
>   obj-$(CONFIG_MIPS_ITU) += mips_itu.o
>   
>   obj-$(CONFIG_PVPANIC) += pvpanic.o
> -obj-$(CONFIG_EDU) += edu.o
>   obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
>   obj-$(CONFIG_AUX) += auxbus.o
>   obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
> 
