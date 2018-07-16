Received: from eggs.gnu.org ([2001:4830:134:3::10]:56507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ff5Pk-0001NF-Ky
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ff5Ph-0006CK-IG
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:27:52 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ff5Ph-0006Bc-B9
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:27:49 -0400
Received: by mail-pf0-x243.google.com with SMTP id d14-v6so2696710pfo.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 08:27:49 -0700 (PDT)
References: <20180713141636.18665-1-peter.maydell@linaro.org>
	<20180713141636.18665-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bb637742-827f-1189-5da8-1fc6ee2b9c23@linaro.org>
Date: Mon, 16 Jul 2018 08:27:45 -0700
MIME-Version: 1.0
In-Reply-To: <20180713141636.18665-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0 1/2] accel/tcg: Use correct test
 when looking in victim TLB for code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 07/13/2018 07:16 AM, Peter Maydell wrote:
> @@ -967,7 +967,7 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
>      index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
>      mmu_idx = cpu_mmu_index(env, true);
>      if (unlikely(!tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr))) {
> -        if (!VICTIM_TLB_HIT(addr_read, addr)) {
> +        if (!VICTIM_TLB_HIT(addr_code, addr)) {

Oh geez.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
