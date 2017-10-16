Received: from eggs.gnu.org ([2001:4830:134:3::10]:56312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e45GE-00067m-Hk
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e45GC-0004sS-Sj
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:16:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e45GC-0004ri-Kn
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:16:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C00CB641C2
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 13:16:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 16 Oct 2017 15:16:33 +0200
Message-Id: <20171016131644.9565-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 00/11] Ui 20171016 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit f90ea7ba7c5ae7010ee0ce062207ae42530f57d6:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20171012' into staging (2017-10-12 17:06:50 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20171016-pull-request

for you to fetch changes up to 2ff408de9c080f2fb5a94ebf6a209c6180c64933:

  gtk: fix wrong id between texture and framebuffer (2017-10-16 14:50:54 +0200)

----------------------------------------------------------------
ui: use keycodemapdb for key code mappings, part one (v2)
ui: add qemu-keymap, update reverse keymaps (for qemu -k $map)
ui: fix for vte 0.50
ui: gtk texture fix

----------------------------------------------------------------

Anthoine Bourgeois (1):
  gtk: fix wrong id between texture and framebuffer

Anthony PERARD (1):
  ui/gtk: Fix deprecation of vte_terminal_copy_clipboard

Daniel P. Berrange (6):
  build: automatically handle GIT submodule checkout for dtc
  docker: don't rely on submodules existing in the main checkout
  ui: add keycodemapdb repository as a GIT submodule
  ui: convert common input code to keycodemapdb
  ui: convert key events to QKeyCodes immediately
  ui: don't export qemu_input_event_new_key

Gerd Hoffmann (3):
  tools: add qemu-keymap
  Add pc-bios/keymaps/Makefile
  pc-bios/keymaps: keymaps update

 configure                 |   75 ++-
 Makefile                  |   54 ++-
 include/ui/input.h        |   12 +-
 qemu-keymap.c             |  258 +++++++++++
 ui/gtk-gl-area.c          |    3 +-
 ui/gtk.c                  |    5 +
 ui/input-keymap.c         |  336 +-------------
 ui/input.c                |   24 +-
 .gitignore                |    2 +
 .gitmodules               |    3 +
 MAINTAINERS               |    6 +
 pc-bios/keymaps/Makefile  |   56 +++
 pc-bios/keymaps/ar        |  819 +++++++++++++++++++++++++++++----
 pc-bios/keymaps/bepo      | 1108 +++++++++++++++++++++++++++++++--------------
 pc-bios/keymaps/cz        |  861 ++++++++++++++++++++++++++++++++---
 pc-bios/keymaps/da        |  732 +++++++++++++++++++++++++++++-
 pc-bios/keymaps/de        |  767 ++++++++++++++++++++++++++++++-
 pc-bios/keymaps/de-ch     |  915 ++++++++++++++++++++++++++++++++-----
 pc-bios/keymaps/en-gb     |  724 ++++++++++++++++++++++++++++-
 pc-bios/keymaps/en-us     |  718 ++++++++++++++++++++++++++++-
 pc-bios/keymaps/es        |  744 +++++++++++++++++++++++++++++-
 pc-bios/keymaps/et        |  818 +++++++++++++++++++++++++++++----
 pc-bios/keymaps/fi        |  814 ++++++++++++++++++++++++++++++---
 pc-bios/keymaps/fo        |  881 ++++++++++++++++++++++++++++++++---
 pc-bios/keymaps/fr        |  704 +++++++++++++++++++++++++++-
 pc-bios/keymaps/fr-be     |  724 ++++++++++++++++++++++++++++-
 pc-bios/keymaps/fr-ca     |  804 ++++++++++++++++++++++++++++++--
 pc-bios/keymaps/fr-ch     |  800 ++++++++++++++++++++++++++++++--
 pc-bios/keymaps/hr        |  752 +++++++++++++++++++++++++++++-
 pc-bios/keymaps/hu        |  887 ++++++++++++++++++++++++++++++++----
 pc-bios/keymaps/is        |  802 +++++++++++++++++++++++++++++---
 pc-bios/keymaps/it        |  757 ++++++++++++++++++++++++++++++-
 pc-bios/keymaps/ja        |  792 +++++++++++++++++++++++++++++---
 pc-bios/keymaps/lt        |  844 ++++++++++++++++++++++++++++++++--
 pc-bios/keymaps/lv        |  766 +++++++++++++++++++++++++++++--
 pc-bios/keymaps/mk        |  814 +++++++++++++++++++++++++++++----
 pc-bios/keymaps/nl        |  794 +++++++++++++++++++++++++++++++-
 pc-bios/keymaps/no        |  758 ++++++++++++++++++++++++++++++-
 pc-bios/keymaps/pl        |  789 ++++++++++++++++++++++++++++++--
 pc-bios/keymaps/pt        |  737 +++++++++++++++++++++++++++++-
 pc-bios/keymaps/pt-br     |  775 ++++++++++++++++++++++++++++++-
 pc-bios/keymaps/ru        |  835 ++++++++++++++++++++++++++++++----
 pc-bios/keymaps/th        |  878 +++++++++++++++++++++++++++++------
 pc-bios/keymaps/tr        |  819 ++++++++++++++++++++++++++++++---
 scripts/archive-source.sh |   34 +-
 scripts/git-submodule.sh  |   38 ++
 ui/keycodemapdb           |    1 +
 47 files changed, 24564 insertions(+), 2075 deletions(-)
 create mode 100644 qemu-keymap.c
 create mode 100644 pc-bios/keymaps/Makefile
 create mode 100755 scripts/git-submodule.sh
 create mode 160000 ui/keycodemapdb

-- 
2.9.3
