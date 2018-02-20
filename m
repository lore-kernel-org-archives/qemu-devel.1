Received: from eggs.gnu.org ([2001:4830:134:3::10]:50094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eoARP-0006be-AH
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eoARL-0001Sf-8Y
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:06:51 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:46662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1eoARL-0001SN-0o
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:06:47 -0500
References: <20180219061827.2112-1-david.brenken@efs-auto.org>
	<20180219061827.2112-5-david.brenken@efs-auto.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <f576ed4b-d2b3-d2a8-bab9-728d474b102d@mail.uni-paderborn.de>
Date: Tue, 20 Feb 2018 17:03:58 +0100
MIME-Version: 1.0
In-Reply-To: <20180219061827.2112-5-david.brenken@efs-auto.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] tricore: fixed wrong mask of PCXI_PIE
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
> index 6ed474c..3f8c029 100644
> --- a/target/tricore/cpu.h
> +++ b/target/tricore/cpu.h
> @@ -230,7 +230,7 @@ void tricore_cpu_dump_state(CPUState *cpu, FILE *f,
>  
>  
>  #define MASK_PCXI_PCPN 0xff000000
> -#define MASK_PCXI_PIE  0x00800000
> +#define MASK_PCXI_PIE  0x00200000
>  #define MASK_PCXI_UL   0x00400000
>  #define MASK_PCXI_PCXS 0x000f0000
>  #define MASK_PCXI_PCXO 0x0000ffff
> 

This is the same architecture problem as in patch 03/05.
Also, please squash patch 04 and 05 together.

Cheer,
Bastian
