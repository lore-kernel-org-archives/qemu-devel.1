Received: from eggs.gnu.org ([209.51.188.92]:50357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1gwNJz-0000FQ-VI
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 03:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1gwNI5-0002tn-GV
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 03:31:43 -0500
Received: from isrv.corpit.ru ([86.62.121.231]:38681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mjt@tls.msk.ru>) id 1gwNI4-0002oC-AF
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 03:31:41 -0500
Reply-To: qemu-devel qemu-devel <qemu-devel@nongnu.org>, 919057@bugs.debian.org
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <7287de8f-b1af-9285-0ac1-173ed7197f94@msgid.tls.msk.ru>
Date: Wed, 20 Feb 2019 11:31:22 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Qemu GTK display mouse pointer visibility/position
 problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>

Forwarding from Debian bug report #919057,
http://bugs.debian.org/919057

Apparently there's some prob with qemu 3.1 GTK frontend and mouse pointer
visibility.  Especially this part:

----
I have similar problems as the original reporter, specifically, after
upgrading to qemu 3.1 from stretch [from qemu 2.8 -- mjt], mouse pointer
is invisible in guest systems iff the pointer is grabbed,
with -display gtk and qxl is used.

When using -vga std, both linux and windows guests show a mouse pointer.
likewise, with -vga qxl and/or additional -device qxl, a mouse pointer is
shown *iff* the input isn't grabbed.

The behaviour is perfectly repeatable here: if I press ctrl-alt-g, mouse
pointer becomes invisible, ctrl-alt-g again, pointer becomes visible
again.

Note that the mouse otherwise behaves normally, i.e. with -device
usb-tablet it is where the X11 pointer is, and it is "fully usable" in the
guest, if you ignore the fact that you have to work blind :)

This happens regardless of -device usb-tablet.

I have tried this with both ubuntu 17.10 and windows 10 + qxl-dod driver
(virtio 0.141 and 0.164), and the behaviour is consistent, so I think
this is a bug in the gtk+ interface of qemu when qxl is used (or when a
hardware pointer is used, as I guess -vga std does not emulate a hardware
pointer).

Basically, it seems that the gtk+ interface simply doesn't show the
hardware pointer when input is grabbed, for whatever reason.

Interestingly enough, when I change the shape of the pointer under both
ubuntu and windows 10 guests, the shape is reflected by qemu (as long
as input isn't grabbed, orf course), so the gtk interface is able to
corretcly access the hardware pointer graphics form the guest.

Googling around, I saw recommendations to use -show-cursor - I have no
clue what it does, it didn't have any effect, either.
----



Thanks,

/mjt
