Received: from eggs.gnu.org ([2001:4830:134:3::10]:59255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9LwG-0004MQ-Le
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9Lgw-0000s5-1z
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:54:46 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:33185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9Lgv-0000rp-ET
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:54:41 -0400
Received: by mail-pg1-x533.google.com with SMTP id y18-v6so7158377pge.0
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 19:54:41 -0700 (PDT)
References: <20181006214508.5331-1-cota@braap.org>
	<20181006214508.5331-4-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0bde4853-ac6c-d189-e7cf-5cb4bc5c1950@linaro.org>
Date: Sun, 7 Oct 2018 19:54:37 -0700
MIME-Version: 1.0
In-Reply-To: <20181006214508.5331-4-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 3/6] cputlb: track TLB use rates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/6/18 2:45 PM, Emilio G. Cota wrote:
> @@ -753,6 +763,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
>      }
>  
>      copy_tlb_helper_locked(te, &tn);
> +    env->tlb_desc[mmu_idx].used++;
>      qemu_spin_unlock(&env->tlb_lock);
>  }

So.. you're computing what?  Total TLB occupancy?
Perhaps a better name than "used"?

Otherwise the patch looks plausible.


r~
