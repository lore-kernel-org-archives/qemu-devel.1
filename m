Received: from eggs.gnu.org ([209.51.188.92]:49330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpKEQ-00059g-KA
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpKEO-0007ut-Ln
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:50:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpKEM-0007sO-Io
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:50:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so4021793wmc.5
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 13:50:40 -0800 (PST)
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-6-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <92632491-d7b5-1995-d9e9-bf5edc9045f9@redhat.com>
Date: Thu, 31 Jan 2019 22:50:38 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-6-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/52] build: actually use CONFIG_PAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

On 1/25/19 11:06 AM, Paolo Bonzini wrote:
> Do not link it unconditionally into all binaries.

Nice :)

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20190123065618.3520-3-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
