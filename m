Received: from eggs.gnu.org ([2001:4830:134:3::10]:55819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPTQ5-0000yH-HX
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPTQ4-0007lL-Gz
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:14:53 -0500
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:33580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPTQ4-0007lD-9k
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:14:52 -0500
Received: by mail-ua0-x231.google.com with SMTP id i68so300284541uad.0
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 04:14:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1476792973-18508-1-git-send-email-peter.maydell@linaro.org>
References: <1476792973-18508-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 12:14:31 +0000
Message-ID: <CAFEAcA-ycRY_BEJTy7Q+juWsUhv9HUeOj-GdYRFNdEGTwfJ_Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target-arm: Implement new HLT
 trap for semihosting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 18 October 2016 at 13:16, Peter Maydell <peter.maydell@linaro.org> wrote:
> Version 2.0 of the semihosting specification introduces new trap
> instructions for AArch32: HLT 0xF000 for A32 and HLT 0x3C for T32.
> Implement these (in the same way we implement the existing HLT
> semihosting trap for A64).
>
> The old traps via SVC and BKPT are unaffected.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The public doc for the new spec is not quite done yet, but I
> wanted to get support for the new trap insns into QEMU 2.8
> (they're the only thing where a semihosting user can't probe
> to see whether the new-in-2.0 feature they want is present).

Just for the record, the public doc is now up:

https://developer.arm.com/docs/100863/latest/

thanks
-- PMM
