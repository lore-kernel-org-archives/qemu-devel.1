Received: from eggs.gnu.org ([2001:4830:134:3::10]:35311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hanjiunit@gmail.com>) id 1e2k2U-0002N7-0F
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hanjiunit@gmail.com>) id 1e2k2T-0005Ha-75
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:25:06 -0400
MIME-Version: 1.0
From: hanji unit <hanjiunit@gmail.com>
Date: Thu, 12 Oct 2017 16:25:00 -0400
Message-ID: <CA+J4q6dO+V32yF11jFD2jAizigYoZS6eECyuDTgRVfe+a_JUJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] QEMU without X11 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-discuss@nongnu.org, qemu-devel@nongnu.org

Hello, is it possible to run (or rebuild modifying build flags) QEMU
without support for X11 window system integration? I keep seeing XSync
in libX11 being called, so i know QEMU is trying to talk to X. I am
running QEMU using Xvfb since I still need the SDL rendering to work.
Here is how i am running QEMU from a script:

export DISPLAY=:1
Xvfb :1 -screen 0 1024x768x16 &


Thanks.
