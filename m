Received: from eggs.gnu.org ([2001:4830:134:3::10]:51077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGpoe-0002AP-Nq
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGpob-0001Pi-NG
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:57:20 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGpob-0001PK-JN
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:57:17 -0400
Received: by mail-qt0-x243.google.com with SMTP id q6-v6so3700973qtn.3
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 10:57:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180510130024.31678-1-peter.maydell@linaro.org>
	<38c06afb-389d-7e10-42b0-df1f8c2a23eb@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d6971c32-162d-fbcf-67ac-d1501896c388@amsat.org>
Date: Thu, 10 May 2018 14:57:12 -0300
MIME-Version: 1.0
In-Reply-To: <38c06afb-389d-7e10-42b0-df1f8c2a23eb@twiddle.net>
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
To: Richard Henderson <rth@twiddle.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/10/2018 11:36 AM, Richard Henderson wrote:
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

Indeed, this would reduce mips_cpu_dump_state() output.
