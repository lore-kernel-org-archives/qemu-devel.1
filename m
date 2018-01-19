Received: from eggs.gnu.org ([2001:4830:134:3::10]:38968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecPKK-0001l0-IV
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecPKH-0001hT-GC
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:34:56 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:41205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ecPKH-0001hD-9y
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:34:53 -0500
Received: by mail-pg0-x241.google.com with SMTP id 136so620106pgd.8
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 21:34:53 -0800 (PST)
References: <20180118193846.24953-1-laurent@vivier.eu>
	<20180118193846.24953-3-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5a4f2c76-e074-8b17-f211-3feb95a7f9b0@linaro.org>
Date: Thu, 18 Jan 2018 21:34:49 -0800
MIME-Version: 1.0
In-Reply-To: <20180118193846.24953-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/7] target/m68k: add MC68040 MMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <huth@tuxfamily.org>

On 01/18/2018 11:38 AM, Laurent Vivier wrote:
> Only add MC68040 MMU page table processing and related
> registers (Special Status Word, Translation Control Register,
> User Root Pointer and Supervisor Root Pointer).
> 
> Transparent Translation Registers, DFC/SFC and pflush/ptest
> will be added later.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> v4: align logical/physical on TARGET_PAGE_SIZE for tlb_set_page()
> v3: s/smaller/smallest/
> v2: move mmu_fault to CPUM68KState
>     set TARGET_PAGE_BITS to 12 to avoid tlb_add_large_page() path
>     use -page_size to mask address instead of TARGET_PAGE_MASK
>     add ACCESS_DEBUG to not update page table USED/MODIFIED bits
>     on gdb access
>     rename ACCESS_INT to ACCESS_DATA
> 
> v2: move mmu_fault to CPUM68KState
>     set TARGET_PAGE_BITS to 12 to avoid tlb_add_large_page() path
>     use -page_size to mask address instead of TARGET_PAGE_MASK
>     add ACCESS_DEBUG to not update page table USED/MODIFIED bits
>     on gdb access
>     rename ACCESS_INT to ACCESS_DATA

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
