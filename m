Received: from eggs.gnu.org ([2001:4830:134:3::10]:54007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAeua-0006Ri-OE
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAeuX-0008Oi-Lt
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:33:40 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60159)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eAeuX-0008Nf-Cz
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:33:37 -0400
References: <20171103120703.15749-1-james.cowgill@mips.com>
	<755effd6-c595-9487-75a6-073ade6be4bc@vivier.eu>
	<2cd7013c-f6c0-980b-0d8b-3ccd7d031299@mips.com>
	<CAFEAcA_xhN7OQZiXA8VcHkZT5yds5ZCcOcMsnUGNoAacuCp9OQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9966e07f-ce54-4470-bcb9-980248c8a17b@vivier.eu>
Date: Fri, 3 Nov 2017 17:33:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_xhN7OQZiXA8VcHkZT5yds5ZCcOcMsnUGNoAacuCp9OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>, James Cowgill <James.Cowgill@mips.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>

Le 03/11/2017 à 17:01, Peter Maydell a écrit :
> On 3 November 2017 at 15:52, James Cowgill <James.Cowgill@mips.com> wrote:
>> On 03/11/17 14:29, Laurent Vivier wrote:
>>> I think we should allow PR_GET_SECCOMP, and at least all the modes
>>> except SECCOMP_MODE_FILTER for PR_SET_SECCOMP.
>>
>> I tried allowing SECCOMP_MODE_STRICT and made a small test program. It
>> seems that qemu is SIGKILLed when _exit is used because qemu itself
>> tries to call rt_sigprocmask which is not an allowed syscall.
>>
>> PR_GET_SECCOMP can probably be allowed. My reasoning for disabling it
>> was to match the kernel behavior for when seccomp is disabled by the
>> Kconfig option.
> 
> I think I like "behave like a kernel with seccomp disabled" --
> it's a clean line that we can assume won't confuse guest programs.
> Laurent?

I agree. I didn't think about all the syscalls QEMU can do aside of the
executed program. So your solution is the good one.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent
