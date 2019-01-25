Received: from eggs.gnu.org ([209.51.188.92]:33664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn2nH-0008Kl-06
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn2nE-0003gA-RU
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:49:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:29679)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gn2nE-0003fm-JF
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:49:16 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-2-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <df5457d4-d3c1-ff0d-3a01-a67057d8a574@redhat.com>
Date: Fri, 25 Jan 2019 15:49:13 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-2-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/52] arm: disable CONFIG_SERIAL_ISA
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

On 2019-01-25 11:06, Paolo Bonzini wrote:
> ARM does not have an ISA bus, this device should not be enabled.  Kconfig
> catches the contradiction because ARM does not define CONFIG_ISA_BUS.

That description is a little bit wrong, since ARM includes pci.mak, and
pci.mak enables CONFIG_ISA_BUS=y for the IDE code.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 2420491..3c9351f 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -6,7 +6,6 @@ CONFIG_VGA=y
>  CONFIG_NAND=y
>  CONFIG_ECC=y
>  CONFIG_SERIAL=y
> -CONFIG_SERIAL_ISA=y
>  CONFIG_PTIMER=y
>  CONFIG_SD=y
>  CONFIG_MAX7310=y

Anyway, looking through the code and the description of commit
1401c322c8d431fa750cff8276 I think you're right that CONFIG_SERIAL_ISA
is not required for ARM, so if you change the commit message a little bit:

Reviewed-by: Thomas Huth <thuth@redhat.com>
