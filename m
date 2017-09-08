Received: from eggs.gnu.org ([2001:4830:134:3::10]:40008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1dqDvS-0001Na-Dk
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 03:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1dqDvN-0004MI-MO
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 03:42:06 -0400
Received: from bran.ispras.ru ([83.149.199.196]:46969 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1dqDvN-0004Kz-Fg
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 03:42:01 -0400
Message-ID: <59B249C7.2000400@ispras.ru>
Date: Fri, 08 Sep 2017 10:41:59 +0300
From: Sergey Smolov <smolov@ispras.ru>
MIME-Version: 1.0
References: <59B17425.1050701@ispras.ru>
	<CAFEAcA-QP7J_Rjre_RmwuYFnBU84gPFXuH4efeSddwgXhgq5Vg@mail.gmail.com>
In-Reply-To: <CAFEAcA-QP7J_Rjre_RmwuYFnBU84gPFXuH4efeSddwgXhgq5Vg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] emulation cycle number implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


On 07.09.2017 19:37, Peter Maydell wrote:
> On 7 September 2017 at 17:30, Sergey Smolov <smolov@ispras.ru> wrote:
>> I'm running MIPS assembler programs on QEMU. I need to log some events that
>> happen through emulation (writes to some registers, for example). When an
>> event happens, I need to print not only the event-related information, but
>> an "emulation cycle number" also. This number should be an integer
>> increasing value that is similar to real hardware clock.
>>
>> How to implement this in QEMU? May QEMU timers be helpful in solving such a
>> problem?
> You can use cpu_get_ticks(), though if we're not in icount mode
> you may find it doesn't behave quite as helpfully as you might like
> (in that case it roughly tracks host hardware cycles.)
>
> thanks
> -- PMM

Thank you, Peter!

But what if I like to track guest hardware cycles? I run the same 
program on QEMU and RTL model of MIPS microprocessor, and I want to 
compare simulation traces. I expect, that emulation will start from 0 
tick in both cases, at least.

-- 
Sincerely yours,
Sergey Smolov
