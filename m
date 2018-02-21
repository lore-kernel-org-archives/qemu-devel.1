Received: from eggs.gnu.org ([2001:4830:134:3::10]:39774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoXsY-0000Ta-F9
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoXsW-0005ca-2w
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53398 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoXsV-0005cK-V7
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:24 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Feb 2018 18:08:15 +0100
Message-Id: <20180221170820.15365-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 0/5] ui: add keyboard state and hotkey
 tracker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: programmingkidx@gmail.com, berrange@redhat.com, peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>

Ok, here is my alternative approach to hotkey configuration.

Downside: It does *not* allow to freely choose any keys for hotkeys.
Hotkeys are restricted to be one normal key combined with up to three
modifiers (no modifiers is fine too).

Upside:  The code is simpler.  We don't have to keep back events because
they might be part of a hotkey.  The code also supports multiple
hotkeys.

While being at it have the code also track all key state, so user
interfaces don't have to do that on their own any more.

The sdl2 ui is used to show this in action.  No command line option
parsing added yet, so hotkeys are not actually configurable for now.
The groundwork to change them at runtime is there though.

Gerd Hoffmann (5):
  kbd-state: add keyboard state tracker
  kbd-state: add hotkey registry
  kbd-state: use state tracker for sdl2
  kbd-state: register sdl2 hotkeys
  sdl2: use only QKeyCode in sdl2_process_key()

 include/ui/kbd-state.h |  49 ++++++++++++++++
 include/ui/sdl2.h      |   2 +
 ui/kbd-state.c         | 152 +++++++++++++++++++++++++++++++++++++++++++++++++
 ui/sdl2-input.c        |  54 ++----------------
 ui/sdl2.c              | 114 ++++++++++++++++++++-----------------
 ui/Makefile.objs       |   2 +-
 6 files changed, 270 insertions(+), 103 deletions(-)
 create mode 100644 include/ui/kbd-state.h
 create mode 100644 ui/kbd-state.c

-- 
2.9.3
