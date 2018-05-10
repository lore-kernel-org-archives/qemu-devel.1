Received: from eggs.gnu.org ([2001:4830:134:3::10]:33691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fGmgC-0005Q4-A1
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fGmg8-0007yY-9s
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:36:24 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:44802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fGmg8-0007y3-2w
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:36:20 -0400
Received: by mail-pl0-x241.google.com with SMTP id e6-v6so1414134plt.11
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 07:36:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180510130024.31678-1-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <38c06afb-389d-7e10-42b0-df1f8c2a23eb@twiddle.net>
Date: Thu, 10 May 2018 07:36:17 -0700
MIME-Version: 1.0
In-Reply-To: <20180510130024.31678-1-peter.maydell@linaro.org>
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 05/10/2018 06:00 AM, Peter Maydell wrote:
> Usually the logging of the CPU state produced by -d cpu is sufficient
> to diagnose problems, but sometimes you want to see the state of
> the floating point registers as well. We don't want to enable that
> by default as it adds a lot of extra data to the log; instead,
> allow it to be optionally enabled via -d fpu.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I've found this helpful while tracking down fp-emulation related bugs.
> 
>  include/qemu/log.h   | 1 +
>  accel/tcg/cpu-exec.c | 9 ++++++---
>  util/log.c           | 2 ++
>  3 files changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I'll also note that only i386 and arm check this flag;
something to fix for the rest...


r~
