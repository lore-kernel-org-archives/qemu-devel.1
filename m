Received: from eggs.gnu.org ([2001:4830:134:3::10]:50337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eJyh4-00048P-8A
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eJyh1-0007L7-2i
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:30:14 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:44996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eJyh0-0007Jk-SB
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:30:11 -0500
Received: by mail-wm0-x241.google.com with SMTP id t8so4740416wmc.3
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 01:30:10 -0800 (PST)
References: <1511890447-13601-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1c99d190-5154-556f-caaf-5abcf4341f96@linaro.org>
Date: Wed, 29 Nov 2017 09:30:07 +0000
MIME-Version: 1.0
In-Reply-To: <1511890447-13601-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user/arm/nwfpe: Check coprocessor
 number for FPA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 11/28/2017 05:34 PM, Peter Maydell wrote:
> Our copy of the nwfpe code for emulating of the old FPA11 floating
> point unit doesn't check the coprocessor number in the instruction
> when it emulates it.  This means that we might treat some
> instructions which should really UNDEF as being FPA11 instructions by
> accident.
> 
> The kernel's copy of the nwfpe code doesn't make this error; I suspect
> the bug was noticed and fixed as part of the process of mainlining
> the nwfpe code more than a decade ago.
> 
> Add a check that the coprocessor number (which is always in bits
> [11:8] of the instruction) is either 1 or 2, which is where the
> FPA11 lives.
> 
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Tested with a chroot of arm debian lenny, which is the last one that
> still used the calling convention that mandated use of the old FPA11 FPU
> and thus needs nwfpe emulation.
> ---
>  linux-user/arm/nwfpe/fpa11.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
