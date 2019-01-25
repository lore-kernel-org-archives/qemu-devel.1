Received: from eggs.gnu.org ([209.51.188.92]:41531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn3UC-0000tu-Ln
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn3UA-0002Hf-TG
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:33:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:2558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gn3U8-0002GX-OC
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:33:38 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-24-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9bb8de22-7821-b103-2717-76bb8c4ee22f@redhat.com>
Date: Fri, 25 Jan 2019 16:33:25 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-24-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 23/52] hw/moxie/Makefile.objs:
 Conditionally build moxie
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, Anthony Green <green@moxielogic.com>

On 2019-01-25 11:06, Paolo Bonzini wrote:
> From: Yang Zhong <yang.zhong@intel.com>
> 
> CONFIG_MOXIE added for moxiesim board.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Message-Id: <20190123065618.3520-20-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/moxie-softmmu.mak | 1 +
>  hw/moxie/Makefile.objs            | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/moxie-softmmu.mak b/default-configs/moxie-softmmu.mak
> index e00d099..b176563 100644
> --- a/default-configs/moxie-softmmu.mak
> +++ b/default-configs/moxie-softmmu.mak
> @@ -5,3 +5,4 @@ CONFIG_MC146818RTC=y
>  CONFIG_SERIAL=y
>  CONFIG_SERIAL_ISA=y
>  CONFIG_VGA=y
> +CONFIG_MOXIE=y
> diff --git a/hw/moxie/Makefile.objs b/hw/moxie/Makefile.objs
> index bfc9001..cb575ef 100644
> --- a/hw/moxie/Makefile.objs
> +++ b/hw/moxie/Makefile.objs
> @@ -1,2 +1,2 @@
>  # moxie boards
> -obj-y += moxiesim.o
> +obj-$(CONFIG_MOXIE) += moxiesim.o

<bikeshedding>
Let's call it CONFIG_MOXIESIM - like the machine, not the CPU.
</bikeshedding>

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>
