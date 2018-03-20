Received: from eggs.gnu.org ([2001:4830:134:3::10]:43056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eyPyT-0003V6-U1
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 18:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eyPyQ-0003rR-RA
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 18:43:21 -0400
Date: Tue, 20 Mar 2018 23:43:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.21.1803202324320.13789@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: [Qemu-devel] Monitor and serial output window broken with SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Hello,

With SDL2 the monitor and serial output windows behave differently than 
they used to with SDL1.2 in that they are opening in separate windows. 
This is an unexpected change we've discussed before but other than this 
there are actual bugs with SDL2:

1. Scrollback does not work. With SDL1.2 it is possible to scroll the 
monitor (and maybe other output windows as well, I'm not sure about that) 
with Ctrl+PgUp/PgDn but this does not work with SDL2. Without this the 
small monitor window is not really usable.

2. With at least qemu-system-ppc the serial and parallel output are not 
accessible (Ctrl+Alt+3 opens an empty window and Ctrl+Alt+4 does nothing) 
while the serial output seems to be behind the monitor output in the 
window opening with Ctrl+Alt+2 and flashes when I type in this window. 
(This doesn't seem to happen with qemu-system-x86_64, maybe that's why it 
was not catched.)

Could these be fixed please to make SDL2 a viable alternative before 
deprecating SDL1.2?

Thank you,
BALATON Zoltan
