Received: from eggs.gnu.org ([209.51.188.92]:49592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <me@halfdog.net>) id 1giQVk-00080W-F3
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 16:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <me@halfdog.net>) id 1giQVj-0008J0-E2
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 16:08:08 -0500
Received: from mail.halfdog.net ([37.186.9.82]:52917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <me@halfdog.net>) id 1giQVj-0008Ex-5y
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 16:08:07 -0500
Received: from [169.254.0.1] (helo=localhost) by mail.halfdog.net with esmtpsa
	(TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92-RC4)
	(envelope-from <me@halfdog.net>) id 1giQVa-0001nr-Gq
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 21:07:58 +0000
From: halfdog <me@halfdog.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 12 Jan 2019 21:07:36 +0000
Message-ID: <859-1547327256.809979@17Vl.Lel1.CWHZ>
Subject: [Qemu-devel] Various GTK window display problems - sorting bugs
 from features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello List,

After filing a Debian bug, the package maintainer gave a hint,
that this might be more relevant here:


There seems to exist a (minor) usability issue with GTK frontend
and detaching a window, that seems to lead to full loss of keyboard
input to the guest, in the end.



With the first issue (usability), it is not clear if this is intended
behaviour. Maybe someone can give a short opinion to finish this
one as "little unexpected feature". See also [0].


When running a Qemu machine with "-display gtk" then selecting

Menu-bar -> View -> Detach tab

and 

Menu-bar -> View -> Fullscreen

will then display the menu bar into fullscreen mode, not the virtual
machine window.



As it is impossible to bring the detached window to fullscreen
mode, it has to be reattached to the main windows again, This
can be done by closing the windows. Everything looks nice afterwards
but keybord events are not forwarded to the guest any more
(mouse is still working).

There is no difference in behaviour when GTK window is scaling
the guest screen, guest display is in full screen mode or not,
input is grabbed.

Using the qemu monitor (with "-monitor stdio") still transports
the keystrokes, so the guest seems to be working still.

(qemu) sendkey x 
(qemu) sendkey ret 

Can anyone reproduce this behaviour? See also [1].



Background: the initial reason for exploring all window/fullscreen
variants was, that the mouse input stopped working with the
sdl -> gtk switch. The Debian package maintainer seems very
responsive and commited, so we are still sorting this one out
in [2].


Thanks for any feedback, opinions,
hd


[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=919056
[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=919116
[2] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=919057
