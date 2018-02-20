Received: from eggs.gnu.org ([2001:4830:134:3::10]:49067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eoAN8-0003q6-3a
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eoAN4-0006ax-3b
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:02:26 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:45586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1eoAN3-0006al-Sx
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:02:22 -0500
References: <20180219061827.2112-1-david.brenken@efs-auto.org>
	<20180219061827.2112-4-david.brenken@efs-auto.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <ae382bd7-adba-543c-6ae8-8a1c1a3408b2@mail.uni-paderborn.de>
Date: Tue, 20 Feb 2018 16:59:33 +0100
MIME-Version: 1.0
In-Reply-To: <20180219061827.2112-4-david.brenken@efs-auto.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/5] tricore: fixed wrong masking of IE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Brenken <david.brenken@efs-auto.org>, qemu-devel@nongnu.org
Cc: Florian Artmeier <florian.artmeier@efs-auto.de>, David Brenken <david.brenken@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>

On 02/19/2018 07:18 AM, David Brenken wrote:
> From: David Brenken <david.brenken@efs-auto.de>
> 
> Signed-off-by: David Brenken <david.brenken@efs-auto.de>
> Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
> Signed-off-by: Florian Artmeier <florian.artmeier@efs-auto.de>
> ---
>  target/tricore/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
> index c295763..6ed474c 100644
> --- a/target/tricore/cpu.h
> +++ b/target/tricore/cpu.h
> @@ -257,7 +257,7 @@ void tricore_cpu_dump_state(CPUState *cpu, FILE *f,
>  #define MASK_CPUID_REV     0x000000ff
>  
>  #define MASK_ICR_PIPN 0x00ff0000
> -#define MASK_ICR_IE   0x00000100
> +#define MASK_ICR_IE   0x00008000
>  #define MASK_ICR_CCPN 0x000000ff
>  
>  #define MASK_FCX_FCXS 0x000f0000
> 

This is architecture specific. You propose the mask for 1.6+ CPUs. The
original is for 1.3 CPUs. You could rename the original mask to
something like MASK_ICR_IE_1_3 and add your own MASK_ICR_IE_1_6 mask.

Cheers,
Bastian
