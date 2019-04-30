Received: from eggs.gnu.org ([209.51.188.92]:57664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hLXGn-00028Y-Jy
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hLXGm-0007cG-IP
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:14:21 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:35691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hLXGm-0007c8-EF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:14:20 -0400
Received: by mail-yw1-xc42.google.com with SMTP id n188so4014133ywe.2
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 11:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-24-richard.henderson@linaro.org>
	<CAFEAcA_FZHKXJHg4819JOZkwwhE44Vx874GKrnxRrOau1HhzRw@mail.gmail.com>
	<CAMo8BfJVdDvYWEdN_08ed5OKBGXc+U8kSbmWaSWY9WCuvDj2pw@mail.gmail.com>
	<bd57c22c-1bdc-80b4-0415-565117f6ae3e@linaro.org>
In-Reply-To: <bd57c22c-1bdc-80b4-0415-565117f6ae3e@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 30 Apr 2019 11:14:08 -0700
Message-ID: <CAMo8BfJsC9aPYUhi5Rg6SAXT4dhaZaU=dqy=um+aBJtnPMSwdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 23/26] target/xtensa: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Apr 30, 2019 at 10:44 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 4/30/19 10:32 AM, Max Filippov wrote:
> > On Tue, Apr 30, 2019 at 3:11 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> >> ...but now we'll set it to whatever exception_cause_vaddr does,
> >> which is something more complicated based on the state of
> >> env->sregs[PS].
> >>
> >> We'll also end up setting env->sregs[PS] bits and env->pc, which
> >> the old code did not. (In particular since we set the PS_EXCM bit,
> >> the second time we take an exception won't we then end up
> >> setting exception_index to EXC_DOUBLE, not EXC_USER ?)
> >
> > I guess it doesn't matter, because linux-user userspace never handles
> > exceptions. PS, PC and similar must be fixed up by the linux-user
> > exception handler. But I haven't tested it.
>
> It does handle exceptions, in linux-user/xtensa/cpu_loop.c.
> And Peter's right that I should have kept EXC_USER.

PC must also either be preserved or restored from the EPC1
in the cpu_loop for the SYSCALL_CAUSE.

> > Richard, is there a branch with this series available somewhere?
> https://github.com/rth7680/qemu/tree/tcg-tlb-fill

Thanks, I'll try it.

-- 
Thanks.
-- Max
