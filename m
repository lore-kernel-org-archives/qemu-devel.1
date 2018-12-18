Received: from eggs.gnu.org ([2001:4830:134:3::10]:41637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gZDFY-0001Wg-4F
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gZD11-0006wE-I7
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:54:23 -0500
Received: from chuckie.co.uk ([82.165.15.123]:56667
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gZD10-0006sc-1n
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:54:18 -0500
References: <alpine.BSF.2.21.1803202324320.13789@zero.eik.bme.hu>
	<20180321140654.7h3nkkdlztu6mtrq@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1803211803590.78606@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1812171549220.8888@zero.eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <f3d7a0ed-785d-4176-147d-26a4d58d1a36@ilande.co.uk>
Date: Tue, 18 Dec 2018 10:54:06 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1812171549220.8888@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Monitor and serial output window broken with SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On 17/12/2018 14:56, BALATON Zoltan wrote:

> I still have this problem after updating everything on my machine, latest QEMU and
> SDL 2.0.9 so it's not likely to be a bug in some external component. If I just start
> qemu-system-ppc (compiled with --disable-gtk) and try to open monitor console with
> Ctrl-Alt-2 I see QEMU monitor but when I type in this window the serial output window
> contents flash in this window. At the same time the window that opens for Ctrl-Alt-3
> which should have the serial output is empty. It looks like an index may be off
> somewhere or window contents are not associated with the right window but I have no
> idea where to look for it. Can you reproduce it now and do you have any idea what
> could cause this?

Are you using Fedora Core 29 at all? I know Howard has been experiencing redraw
issues since upgrading from FC 28 to FC 29. A couple of other things to check:

1) Does QEMU 3.0 work correctly? If so, a bisection would help.
2) Are you using an Nvidia graphics card with the nouveau driver?


ATB,

Mark.
