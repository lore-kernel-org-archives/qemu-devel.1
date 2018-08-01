Received: from eggs.gnu.org ([2001:4830:134:3::10]:50185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dalias@aerifal.cx>) id 1fl0ZA-0005E6-2f
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 19:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dalias@aerifal.cx>) id 1fl0Z5-0004Um-UU
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 19:30:04 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:58030
	helo=brightrain.aerifal.cx) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dalias@aerifal.cx>) id 1fl0Z5-0004UY-O8
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 19:29:59 -0400
Date: Wed, 1 Aug 2018 19:03:44 -0400
From: Rich Felker <dalias@libc.org>
Message-ID: <20180801230344.GJ1392@brightrain.aerifal.cx>
References: <20180730130234.30020-1-geert+renesas@glider.be>
	<1115027626.150336.1532963923061@webmail.strato.com>
	<97622558-a520-6ab2-b61f-8038ae61b451@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97622558-a520-6ab2-b61f-8038ae61b451@landley.net>
Sender: Rich Felker <dalias@aerifal.cx>
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
To: Rob Landley <rob@landley.net>
Cc: Ulrich Hecht <uli@fpond.eu>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Maydell <peter.maydell@linaro.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, Jul 31, 2018 at 11:36:46AM -0500, Rob Landley wrote:
> On 07/30/2018 10:18 AM, Ulrich Hecht wrote:>> On July 30, 2018 at 3:02 PM Geert
> Uytterhoeven <geert+renesas@glider.be> wrote:
> >> Fix this by adding basic timeout handling.  As the QEMU SCIF emulation
> >> ignores any serial speed programming, the timeout value used conforms to
> >> a default speed of 9600 bps, which is fine for any interative console.
> >>
> >> Reported-by: Rob Landley <rob@landley.net>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > Works for me, kernel 4.18-rc7 for rts7751r2dplus.
> 
> Works for me too.
> 
> Tested-by: Rob Landley <rob@landley.net>

Me too. This would be a very welcome fix for a longstanding and
annoying problem.

Tested-by: Rich Felker <dalias@libc.org>

Rich
