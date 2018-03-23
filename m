Received: from eggs.gnu.org ([2001:4830:134:3::10]:37654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezKYC-0007Y4-PW
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 07:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezKYB-0002Ct-PD
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 07:08:00 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:41492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezKYB-0002BW-JY
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 07:07:59 -0400
Received: by mail-ot0-x244.google.com with SMTP id i28-v6so12795247otf.8
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 04:07:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180320013657.25038-1-tpiepho@impinj.com>
References: <20180320013657.25038-1-tpiepho@impinj.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 11:07:38 +0000
Message-ID: <CAFEAcA_nHaMqGBdEW+yV7O1oA1ovrWGgB5zOE1OXey2AnCS=dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] i.MX: Support serial RS-232 break properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Trent Piepho <tpiepho@impinj.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>

On 20 March 2018 at 01:36, Trent Piepho <tpiepho@impinj.com> wrote:
> Linux does not detect a break from this IMX serial driver as a magic
> sysrq.  Nor does it note a break in the port error counts.
>
> The former is because the Linux driver uses the BRCD bit in the USR2
> register to trigger the RS-232 break handler in the kernel, which is
> where sysrq hooks in.  The emulated UART was not setting this status
> bit.
>
> The latter is because the Linux driver expects, in addition to the BRK
> bit, that the ERR bit is set when a break is read in the FIFO.  A break
> should also count as a frame error, so add that bit too.
>
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>

Yep, the data sheet is nice and clear here about the requirements.

Applied to target-arm.next, thanks.

-- PMM
