Received: from eggs.gnu.org ([2001:4830:134:3::10]:45381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAePt-00051m-8J
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAePo-0003iy-Ng
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:01:57 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:57213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAePo-0003ib-Eq
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:01:52 -0400
Received: by mail-wr0-x244.google.com with SMTP id r79so2907260wrb.13
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 09:01:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2cd7013c-f6c0-980b-0d8b-3ccd7d031299@mips.com>
References: <20171103120703.15749-1-james.cowgill@mips.com>
	<755effd6-c595-9487-75a6-073ade6be4bc@vivier.eu>
	<2cd7013c-f6c0-980b-0d8b-3ccd7d031299@mips.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2017 16:01:30 +0000
Message-ID: <CAFEAcA_xhN7OQZiXA8VcHkZT5yds5ZCcOcMsnUGNoAacuCp9OQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: return EINVAL from
 prctl(PR_*_SECCOMP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Cowgill <James.Cowgill@mips.com>
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>

On 3 November 2017 at 15:52, James Cowgill <James.Cowgill@mips.com> wrote:
> On 03/11/17 14:29, Laurent Vivier wrote:
>> I think we should allow PR_GET_SECCOMP, and at least all the modes
>> except SECCOMP_MODE_FILTER for PR_SET_SECCOMP.
>
> I tried allowing SECCOMP_MODE_STRICT and made a small test program. It
> seems that qemu is SIGKILLed when _exit is used because qemu itself
> tries to call rt_sigprocmask which is not an allowed syscall.
>
> PR_GET_SECCOMP can probably be allowed. My reasoning for disabling it
> was to match the kernel behavior for when seccomp is disabled by the
> Kconfig option.

I think I like "behave like a kernel with seccomp disabled" --
it's a clean line that we can assume won't confuse guest programs.
Laurent?

thanks
-- PMM
