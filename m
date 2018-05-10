Received: from eggs.gnu.org ([2001:4830:134:3::10]:34232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGmiB-0006hH-EH
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGmiA-0000PE-K8
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:38:27 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:44342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGmiA-0000P6-EB
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:38:26 -0400
Received: by mail-oi0-x244.google.com with SMTP id e80-v6so1936583oig.11
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 07:38:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <38c06afb-389d-7e10-42b0-df1f8c2a23eb@twiddle.net>
References: <20180510130024.31678-1-peter.maydell@linaro.org>
	<38c06afb-389d-7e10-42b0-df1f8c2a23eb@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 15:38:05 +0100
Message-ID: <CAFEAcA_UdN=dYm36VqRnQN9-dJ1r=QoWdbyFzWUArS_LRJRAWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 10 May 2018 at 15:36, Richard Henderson <rth@twiddle.net> wrote:
> On 05/10/2018 06:00 AM, Peter Maydell wrote:
>> Usually the logging of the CPU state produced by -d cpu is sufficient
>> to diagnose problems, but sometimes you want to see the state of
>> the floating point registers as well. We don't want to enable that
>> by default as it adds a lot of extra data to the log; instead,
>> allow it to be optionally enabled via -d fpu.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> I've found this helpful while tracking down fp-emulation related bugs.
>>
>>  include/qemu/log.h   | 1 +
>>  accel/tcg/cpu-exec.c | 9 ++++++---
>>  util/log.c           | 2 ++
>>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> I'll also note that only i386 and arm check this flag;
> something to fix for the rest...

Mmm. It would also be nice not to have that TARGET_I386
special case for CPU_DUMP_CCOP -- we should either care about
that for everything, or for nothing (my vote would be for not
printing it unless user-requested, since it's an internal
tcg target detail.)

thanks
-- PMM
