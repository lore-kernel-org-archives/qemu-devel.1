Received: from eggs.gnu.org ([209.51.188.92]:50738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqk78-0007s9-TD
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqk0P-0000IH-MR
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:34:10 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:56104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqk0P-0000Hl-Go
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:34:09 -0500
Received: by mail-wm1-f51.google.com with SMTP id y139so1124886wmc.5
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 11:34:09 -0800 (PST)
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
	<1549305379-51117-51-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fbcafefd-39da-bb75-1e73-6e2d70e538a8@redhat.com>
Date: Mon, 4 Feb 2019 20:34:06 +0100
MIME-Version: 1.0
In-Reply-To: <1549305379-51117-51-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 50/77] build: actually use CONFIG_PAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>

Hi Paolo,

On 2/4/19 7:35 PM, Paolo Bonzini wrote:
> Do not link it unconditionally into all binaries.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20190202072456.6468-6-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I did review/test this patch:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg592471.html

Is patchew loosing mails?

> ---
>  default-configs/i386-softmmu.mak | 1 +
>  hw/pci-host/Makefile.objs        | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index 2f919df..48da996 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -67,3 +67,4 @@ CONFIG_I2C=y
>  CONFIG_SEV=$(CONFIG_KVM)
>  CONFIG_VTD=y
>  CONFIG_AMD_IOMMU=y
> +CONFIG_PAM=y
> diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
> index 073d512..a9cd3e0 100644
> --- a/hw/pci-host/Makefile.objs
> +++ b/hw/pci-host/Makefile.objs
> @@ -1,4 +1,4 @@
> -common-obj-y += pam.o
> +common-obj-$(CONFIG_PAM) += pam.o
>  
>  # PPC devices
>  common-obj-$(CONFIG_PREP_PCI) += prep.o
> 
