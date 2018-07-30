Received: from eggs.gnu.org ([2001:4830:134:3::10]:46509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <uli@fpond.eu>) id 1fk9wh-0001ck-EM
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <uli@fpond.eu>) id 1fk9wg-0005Q0-HL
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:18:51 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::12]:17092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <uli@fpond.eu>) id 1fk9wf-0005Of-Tt
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:18:50 -0400
Date: Mon, 30 Jul 2018 17:18:43 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
Message-ID: <1115027626.150336.1532963923061@webmail.strato.com>
In-Reply-To: <20180730130234.30020-1-geert+renesas@glider.be>
References: <20180730130234.30020-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH QEMU] hw/char/sh_serial: Add timeout
 handling to unbreak serial input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Peter Maydell <peter.maydell@linaro.org>
Cc: Rob Landley <rob@landley.net>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org


> On July 30, 2018 at 3:02 PM Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
> 
> As of commit 18e8cf159177100e ("serial: sh-sci: increase RX FIFO trigger
> defaults for (H)SCIF") in Linux v4.11-rc1, the serial console on the
> QEMU SH4 target is broken: it delays serial input until enough data has
> been received.
> 
> Since aformentioned commit, the Linux SCIF driver programs the Receive
> FIFO Data Count Trigger bits in the FIFO Control Register, to postpone
> generating a receive interrupt until:
>   1. At least the receive trigger count of bytes of data are available
>      in the receive FIFO, OR
>   2. No further data has been received for at least 15 etu after the
>      last received data.
> 
> While QEMU implements the former, it does not implement the latter.
> Hence the receive interrupt is not generated until the former condition
> is met.
> 
> Fix this by adding basic timeout handling.  As the QEMU SCIF emulation
> ignores any serial speed programming, the timeout value used conforms to
> a default speed of 9600 bps, which is fine for any interative console.
> 
> Reported-by: Rob Landley <rob@landley.net>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Works for me, kernel 4.18-rc7 for rts7751r2dplus.

Tested-by: Ulrich Hecht <uli@fpond.eu>

CU
Uli
