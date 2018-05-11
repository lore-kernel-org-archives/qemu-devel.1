Received: from eggs.gnu.org ([2001:4830:134:3::10]:43455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fH4rH-0003An-CF
	for qemu-devel@nongnu.org; Fri, 11 May 2018 06:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fH4rD-0005sJ-2L
	for qemu-devel@nongnu.org; Fri, 11 May 2018 06:01:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48792 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fH4rC-0005s4-Sg
	for qemu-devel@nongnu.org; Fri, 11 May 2018 06:00:58 -0400
References: <20180510130024.31678-1-peter.maydell@linaro.org>
	<38c06afb-389d-7e10-42b0-df1f8c2a23eb@twiddle.net>
	<CAFEAcA_UdN=dYm36VqRnQN9-dJ1r=QoWdbyFzWUArS_LRJRAWA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ccaf1d7-991b-fa56-b8b8-0d10ed310d08@redhat.com>
Date: Fri, 11 May 2018 12:00:54 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_UdN=dYm36VqRnQN9-dJ1r=QoWdbyFzWUArS_LRJRAWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Optionally log FPU state in TCG -d
 cpu logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/05/2018 16:38, Peter Maydell wrote:
> On 10 May 2018 at 15:36, Richard Henderson <rth@twiddle.net> wrote:
>> On 05/10/2018 06:00 AM, Peter Maydell wrote:
>>> Usually the logging of the CPU state produced by -d cpu is sufficient
>>> to diagnose problems, but sometimes you want to see the state of
>>> the floating point registers as well. We don't want to enable that
>>> by default as it adds a lot of extra data to the log; instead,
>>> allow it to be optionally enabled via -d fpu.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> I've found this helpful while tracking down fp-emulation related bugs.
>>>
>>>  include/qemu/log.h   | 1 +
>>>  accel/tcg/cpu-exec.c | 9 ++++++---
>>>  util/log.c           | 2 ++
>>>  3 files changed, 9 insertions(+), 3 deletions(-)
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> I'll also note that only i386 and arm check this flag;
>> something to fix for the rest...
> 
> Mmm. It would also be nice not to have that TARGET_I386
> special case for CPU_DUMP_CCOP -- we should either care about
> that for everything, or for nothing (my vote would be for not
> printing it unless user-requested, since it's an internal
> tcg target detail.)

That's fine by me.

Paolo
