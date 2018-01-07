Received: from eggs.gnu.org ([2001:4830:134:3::10]:53341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patricktsen@gmail.com>) id 1eY8tl-0000hv-5v
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 06:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patricktsen@gmail.com>) id 1eY8tj-0005Lt-Vy
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 06:13:53 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:42988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <patricktsen@gmail.com>)
	id 1eY8tj-0005L8-Pp
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 06:13:51 -0500
Received: by mail-pl0-x244.google.com with SMTP id bd8so5932974plb.9
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 03:13:51 -0800 (PST)
From: byxk <patricktsen@gmail.com>
Date: Sun,  7 Jan 2018 03:13:40 -0800
Message-Id: <20180107111341.8879-1-patricktsen@gmail.com>
Subject: [Qemu-devel] [PATCH 0/1] input-linux: provide hotkeys for evdev
 toggle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, byxk <patricktsen@gmail.com>

Hi QEMU,

This patch allows one to pass either one or both of
--evdev-lhotkey {keycode} and --evdev-rhotkey {keycode}
to change the default key combo to toggle evdev grab.

I had trouble figuring out where to set defaults
(LCTRL +  RCTRL), so ended up setting it directly.

This is my first patch ever to anything so any help/feedback is
appreciated.

Thanks,
    byxk

byxk (1):
  input-linux: provide hotkeys for evdev toggle

 include/ui/input.h |  3 +++
 qemu-options.hx    | 13 +++++++++++++
 ui/input-linux.c   |  4 ++--
 vl.c               |  8 ++++++++
 4 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.15.1
