Received: from eggs.gnu.org ([2001:4830:134:3::10]:48524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIW6u-0004Du-8e
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIW6s-0001VN-Ls
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:19:08 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 15 May 2018 11:18:51 +0200
Message-Id: <20180515091901.27774-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 00/10] Ui 20180515 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit fbd3a489df9953e2a5d017c922f3c103b2426952:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180514' into staging (2018-05-14 18:53:42 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180515-pull-request

for you to fetch changes up to 677b490501823c1cb6946d8bb9e7907c12cd0c71:

  gtk: disable the F10 menubar key (2018-05-15 10:47:01 +0200)

----------------------------------------------------------------
ui: qapi parser for -display cmd line.
gtk: multiple fixes.
sdl: opts bugfix.
vnc: magic cookie.

----------------------------------------------------------------

Gerd Hoffmann (7):
  sdl2: move opts assignment into loop
  vnc: add magic cookie to VncState
  ui: add qapi parser for -display
  ui: switch trivial displays to qapi parser
  ui: switch gtk display to qapi parser
  ui: document non-qapi parser cases.
  console: use linked list for QemuConsoles

Peter Wu (2):
  gtk: make it possible to hide the menu bar
  gtk: disable the F10 menubar key

Tomeu Vizoso (1):
  ui/gtk: Only try to initialize EGL/X11 if GtkGlArea failed

 ui/vnc.h      |   3 ++
 ui/console.c  | 105 ++++++++++++++++++++++++++++++++--------------------------
 ui/gtk.c      |  60 +++++++++++++++++++++++++++++++--
 ui/sdl2.c     |   2 +-
 ui/vnc-jobs.c |   4 +++
 ui/vnc.c      |  10 +++++-
 vl.c          |  76 ++++++++++++++++++++----------------------
 7 files changed, 168 insertions(+), 92 deletions(-)

-- 
2.9.3
