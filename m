Received: from eggs.gnu.org ([2001:4830:134:3::10]:35871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYAq3-0002ZK-33
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYApy-0003hc-UL
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:50:26 -0400
Received: from mail-pl0-x229.google.com ([2607:f8b0:400e:c01::229]:46778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYApy-0003gI-Av
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:50:22 -0400
Received: by mail-pl0-x229.google.com with SMTP id 30-v6so1064022pld.13
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 06:50:22 -0700 (PDT)
References: <20180618184046.6270-1-richard.henderson@linaro.org>
	<20180618184046.6270-14-richard.henderson@linaro.org>
	<CAAfxs74pe4BnScaFdmUBbX=-kD5qp2pQN-JgnFy4QGfGXNe9oQ@mail.gmail.com>
	<CAAfxs77w97-8iNRf_XfqDewrgm61SroT-WcCedM9hvg8E+kMYQ@mail.gmail.com>
	<d80aae07-404e-ada2-9a9b-4d1d96c9e63b@linaro.org>
	<20180627125953.GK24595@lianli.shorne-pla.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ad0fc460-02ee-ca79-de48-ab01e19f0ce7@linaro.org>
Date: Wed, 27 Jun 2018 06:50:18 -0700
MIME-Version: 1.0
In-Reply-To: <20180627125953.GK24595@lianli.shorne-pla.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/22] target/openrisc: Fix cpu_mmu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 06/27/2018 05:59 AM, Stafford Horne wrote:
> The index is negative... this patch should fix that.
> 
> @@ -78,6 +78,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr,
> target_ulong rb)
>      case TO_SPR(0, 1024) ... TO_SPR(0, 1024 + (16 * 32)): /* Shadow GPRs */
>          idx = (spr - 1024);
>          env->shadow_gpr[idx / 32][idx % 32] = rb;
> +        break;
>  
>      case TO_SPR(1, 512) ... TO_SPR(1, 512 + TLB_SIZE - 1): /* DTLBW0MR 0-127 */

OMG.  That's embarrasing...


r~
