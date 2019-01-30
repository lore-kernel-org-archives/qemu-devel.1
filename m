Received: from eggs.gnu.org ([209.51.188.92]:47674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gooVq-0004VB-S6
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gooVo-00084T-St
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:58:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gooVm-0007zt-Ul
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:58:36 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-42-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b6ac9950-4640-0eac-2bbe-0283b8b051f6@redhat.com>
Date: Wed, 30 Jan 2019 12:58:23 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-42-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 41/52] isa: express dependencies with
 kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com

On 2019-01-25 11:07, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Message-Id: <20190123065618.3520-36-yang.zhong@intel.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
[...]
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index d50e301..6d15720 100644
> --- a/hw/net/Kconfig
> +++ b/hw/net/Kconfig
> @@ -48,6 +48,9 @@ config LAN9118
>  
>  config NE2000_ISA
>      bool
> +    default y
> +    depends on ISA_BUS
> +    depends on PCI # for NE2000State

 Yang,

for the time being, could you please change the last line into

 depends on NE2000_PCI

instead? Otherwise, it's still possible to enable NE2000_ISA while
NE2000_PCI is disabled, and this will currently result in linking errors.

In the long run, we should likely put the common functions into a
separate file, but that's future work, after your series has been
merged, I think.

 Thanks,
  Thomas
