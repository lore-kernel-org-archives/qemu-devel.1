Received: from eggs.gnu.org ([2001:4830:134:3::10]:54975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fZMRy-0006zC-7o
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 16:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fZMRx-00058S-Cy
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 16:26:30 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8u=R_wCbnuiAbzHCm_6r+Q7zMij-tCEDkNnLcaoi9jBw@mail.gmail.com>
References: <20180620130619.11362-1-peter.maydell@linaro.org>
	<20180620130619.11362-2-peter.maydell@linaro.org>
	<CAMo8BfLRr16q4_nj0vacK4N4fb0EBymXZB6SHon72h7BJ9M5jw@mail.gmail.com>
	<CAMo8Bf+iV3fTRtSKx8Y-Y4_e16i21shLOch2PS3v_xR_c+L0ww@mail.gmail.com>
	<CAFEAcA-dNr76uh_x98Uz_7h3xWxgd2Q_WdB5OSZVo6K9kruB=w@mail.gmail.com>
	<CAFEAcA8u=R_wCbnuiAbzHCm_6r+Q7zMij-tCEDkNnLcaoi9jBw@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 30 Jun 2018 13:26:20 -0700
Message-ID: <CAMo8BfL6Shx8Lu9ejSt5zzLkfc2kipBzkS_56PCAF7WFeDm2zQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/3] tcg: Support MMU protection regions
 smaller than TARGET_PAGE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Patch Tracking <patches@linaro.org>, Laurent Vivier <laurent@vivier.eu>

On Sat, Jun 30, 2018 at 1:10 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 30 June 2018 at 21:08, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 30 June 2018 at 20:42, Max Filippov <jcmvbkbc@gmail.com> wrote:
>>> On Sat, Jun 30, 2018 at 12:20 PM, Max Filippov <jcmvbkbc@gmail.com> wrote:
>>>> I'm observing the following failure with xtensa tests:
>>>>
>>>> (qemu) qemu: fatal: Unable to handle guest executing from RAM within a
>>>> small MPU region at 0xd0000804
>>>>
>>>> Bisection points to this patch. Any idea what happened?
>>>
>>> Ok, I think I've found the issue: the following check in the
>>> get_page_addr_code does not work correctly when -1 is in the
>>> addr_code in the QEMU TLB:
>>>
>>> if (unlikely(env->tlb_table[mmu_idx][index].addr_code & TLB_RECHECK))
>>
>> Yes, Laurent ran into that and I sent a fix out on Friday:
>> http://patchwork.ozlabs.org/project/qemu-devel/list/?series=52914
>
> ...oh, no, wait, you've hit the other bug I sent a fix for:
> http://patchwork.ozlabs.org/patch/937029/

Thanks, that last one fixes it for me.

-- 
Thanks.
-- Max
