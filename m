Received: from eggs.gnu.org ([2001:4830:134:3::10]:46914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rbraun@sceen.net>) id 1ek56C-00033i-Ax
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rbraun@sceen.net>) id 1ek568-0005e7-Br
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:36:04 -0500
Received: from shattrath.sceen.net ([151.80.19.218]:36612 helo=mail.sceen.net)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rbraun@sceen.net>) id 1ek568-0005dV-55
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:36:00 -0500
Date: Fri, 9 Feb 2018 10:35:58 +0100
From: Richard Braun <rbraun@sceen.net>
Message-ID: <20180209093558.GB27456@shattrath>
References: <1517776881-14115-1-git-send-email-rbraun@sceen.net>
	<CAFEAcA_XagA3SuqNTHd06nH4nTXTNztRBAYOQxF8cJmaVXBhoQ@mail.gmail.com>
	<20180209092313.GA27456@shattrath>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209092313.GA27456@shattrath>
Subject: Re: [Qemu-devel] [PATCH] hw/char/stm32f2xx_usart: improve TXE/TC
 bit handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>

On Fri, Feb 09, 2018 at 10:23:13AM +0100, Richard Braun wrote:
> On Thu, Feb 08, 2018 at 02:58:29PM +0000, Peter Maydell wrote:
> > The guest can clear the TC and TXE bits by writing to the USART_SR
> > directly, so this code should set both of them, I think ?
> 
> Right, nice catch.

Although, after reading the manual again, TXE is actually read-only and
only set by hardware.

-- 
Richard Braun
