Received: from eggs.gnu.org ([2001:4830:134:3::10]:39401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhwP2-0001a5-BP
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhwP1-000283-Gb
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:26:56 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:32956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhwP1-00027e-An
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:26:55 -0400
Received: by mail-oi0-x242.google.com with SMTP id l10-v6so7122574oii.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 05:26:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5c3ec438-2265-94b4-4f35-71a79d838518@twiddle.net>
References: <20180713150945.12348-1-peter.maydell@linaro.org>
	<5c3ec438-2265-94b4-4f35-71a79d838518@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 13:26:34 +0100
Message-ID: <CAFEAcA8fFxKEbwC=rfp28cTMUT2eQVzGS8qc5tLowK3XYwEvrg@mail.gmail.com>
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
> Don't duplicate the assert; just move it.  Otherwise,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I propose to put this patch into my target-arm.for-3.1 branch
(with the duplicated assert deleted), unless you have another
preference.

thanks
-- PMM
