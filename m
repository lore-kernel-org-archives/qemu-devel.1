Received: from eggs.gnu.org ([2001:4830:134:3::10]:44862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fToj2-0000cn-3w
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fToiy-0007eu-V2
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:25:12 -0400
References: <20180604152941.20374-1-peter.maydell@linaro.org>
	<20180604152941.20374-7-peter.maydell@linaro.org>
	<45d89f39-7397-bd71-5cd4-fdb1ea47595e@redhat.com>
	<CAFEAcA_OpQYq6XuKhAsP-W9pimWpF49XVcttcV7rqpOgJu2ihA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b3163a63-ae4a-9526-79a9-42cce6ae0eb7@redhat.com>
Date: Fri, 15 Jun 2018 15:24:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_OpQYq6XuKhAsP-W9pimWpF49XVcttcV7rqpOgJu2ihA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/13] hw/misc/tz-mpc.c: Implement
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>

Hi Peter,

On 06/15/2018 11:04 AM, Peter Maydell wrote:
> On 14 June 2018 at 21:36, Auger Eric <eric.auger@redhat.com> wrote:
>> Hi Peter,
>>
>> On 06/04/2018 05:29 PM, Peter Maydell wrote:
>>> Implement the missing registers for the TZ MPC.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
>>> +    case A_INT_CLEAR:
>>> +        if (value & R_INT_CLEAR_IRQ_MASK) {
>>> +            s->int_stat = 0;
>>> +            tz_mpc_irq_update(s);
>> don't you need to clear the info regs. spec says:
>> the [info] register retains its value until mpc_irq is cleared.
> 
> The full sentence is "Subsequent security violating transfers
> remain blocked, that is, not captured in this register
> and the register retains its value until mpc_irq is cleared."
> I interpret "until mpc_irq is cleared" as applying to the
> entire thing, ie mpc_irq being cleared is what allows a
> subsequent transfer to be captured in this register.
> (Hardware actively clearing itself to zero is unlikely,
> because that costs extra gates which designers don't tend
> to do unless there's a reason for it.)
> 
> From a guest point of view (which is kind of the pov the
> docs are written from), the guest can't rely on the register
> value once mpc_irq is cleared (because another transaction
> might come along and cause the value to be overwritten).
OK

Thanks

Eric
> 
> thanks
> -- PMM
> 
