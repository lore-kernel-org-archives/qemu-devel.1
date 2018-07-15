Received: from eggs.gnu.org ([2001:4830:134:3::10]:38285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1feoLy-0006Th-2w
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 17:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1feoLx-00023C-0b
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 17:14:50 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1feoLw-00021W-Qz
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 17:14:48 -0400
Received: by mail-oi0-x243.google.com with SMTP id w126-v6so71253484oie.7
	for <qemu-devel@nongnu.org>; Sun, 15 Jul 2018 14:14:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5c3ec438-2265-94b4-4f35-71a79d838518@twiddle.net>
References: <20180713150945.12348-1-peter.maydell@linaro.org>
	<5c3ec438-2265-94b4-4f35-71a79d838518@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 15 Jul 2018 22:14:27 +0100
Message-ID: <CAFEAcA_d41+M=tu5DTDrB9=6s5qTQnPZau42s4UyfNWFU8AkZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] accel/tcg: Check whether TLB entry is RAM
 consistently with how we set it up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 15 July 2018 at 01:37, Richard Henderson <rth@twiddle.net> wrote:
> On 07/13/2018 10:09 AM, Peter Maydell wrote:
>> @@ -939,29 +935,21 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
>>          }
>>          assert(tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr));
>>      }
>> +    assert(tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr));
>
> Don't duplicate the assert; just move it.

Yeah, the duplicate is unwanted: I probably ended upit
from a botched conflict resolution at some point in a rebase
when I was moving it around.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

thanks
-- PMM
