Received: from eggs.gnu.org ([2001:4830:134:3::10]:58625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fhxNl-00042r-Tb
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fhxNl-0005JN-2m
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:29:41 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180713150945.12348-1-peter.maydell@linaro.org>
	<5c3ec438-2265-94b4-4f35-71a79d838518@twiddle.net>
	<CAFEAcA8fFxKEbwC=rfp28cTMUT2eQVzGS8qc5tLowK3XYwEvrg@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4b9f5913-ded1-c71f-9e57-70ad4f9f554b@twiddle.net>
Date: Tue, 24 Jul 2018 06:29:36 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8fFxKEbwC=rfp28cTMUT2eQVzGS8qc5tLowK3XYwEvrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 07/24/2018 05:26 AM, Peter Maydell wrote:
> On 15 July 2018 at 01:37, Richard Henderson <rth@twiddle.net> wrote:
>> On 07/13/2018 10:09 AM, Peter Maydell wrote:
>>> @@ -939,29 +935,21 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
>>>          }
>>>          assert(tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr));
>>>      }
>>> +    assert(tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr));
>>
>> Don't duplicate the assert; just move it.  Otherwise,
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> I propose to put this patch into my target-arm.for-3.1 branch
> (with the duplicated assert deleted), unless you have another
> preference.

That's fine by me.


r~
