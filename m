Received: from eggs.gnu.org ([209.51.188.92]:49252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpKDr-0004iQ-Kh
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpKDq-0007T1-L4
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:50:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpKDq-0007NQ-FU
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:50:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so4060738wmb.3
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 13:50:05 -0800 (PST)
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-11-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4ccda5ba-d46e-1261-c972-fc6d7a926bc8@redhat.com>
Date: Thu, 31 Jan 2019 22:50:01 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-11-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/52] hw/mips/Makefile.objs: Create
 CONFIG_* for r4k, malta, mipssim boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>

On 1/25/19 11:06 AM, Paolo Bonzini wrote:
> From: Ákos Kovács <akoskovacs@gmx.com>
> 
> Add the new configs to default-configs/mips*-sofmmu.mak.
> 
> Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Message-Id: <20190123065618.3520-8-yang.zhong@intel.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/mips-softmmu-common.mak | 3 +++
>  hw/mips/Makefile.objs                   | 5 +++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
> index fae2347..479fb4d 100644
> --- a/default-configs/mips-softmmu-common.mak
> +++ b/default-configs/mips-softmmu-common.mak
> @@ -36,3 +36,6 @@ CONFIG_EMPTY_SLOT=y
>  CONFIG_MIPS_CPS=y
>  CONFIG_MIPS_ITU=y
>  CONFIG_I2C=y
> +CONFIG_R4K=y
> +CONFIG_MALTA=y
> +CONFIG_MIPSSIM=y
> diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
> index 17a311a..525809a 100644
> --- a/hw/mips/Makefile.objs
> +++ b/hw/mips/Makefile.objs
> @@ -1,7 +1,8 @@
> -obj-y += mips_r4k.o mips_malta.o mips_mipssim.o
>  obj-y += addr.o mips_int.o
> +obj-$(CONFIG_R4K) += mips_r4k.o
> +obj-$(CONFIG_MALTA) += gt64xxx_pci.o mips_malta.o
> +obj-$(CONFIG_MIPSSIM) += mips_mipssim.o
>  obj-$(CONFIG_JAZZ) += mips_jazz.o
>  obj-$(CONFIG_FULONG) += mips_fulong2e.o
> -obj-y += gt64xxx_pci.o
>  obj-$(CONFIG_MIPS_CPS) += cps.o
>  obj-$(CONFIG_MIPS_BOSTON) += boston.o
> 
