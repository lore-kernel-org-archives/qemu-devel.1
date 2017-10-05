Received: from eggs.gnu.org ([2001:4830:134:3::10]:38698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e02xy-00055M-8l
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e02xs-0005OF-C5
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:01:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e02xs-0005Nf-6w
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 06:01:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1517F7F415
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 10:01:11 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  5 Oct 2017 12:01:00 +0200
Message-Id: <20171005100106.30118-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/6] Ui 20171005 patches
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

The following changes since commit d147f7e815f97cb477e223586bcb80c316ae10ea:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-10-03 16:27:24 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20171005-pull-request

for you to fetch changes up to 47247520ac44592cc7343138380bd6099f83262f:

  ui: don't export qemu_input_event_new_key (2017-10-05 11:21:51 +0200)

----------------------------------------------------------------
ui: use keycodemapdb for key code mappings, part one

----------------------------------------------------------------

Daniel P. Berrange (6):
  build: automatically handle GIT submodule checkout for dtc
  docker: don't rely on submodules existing in the main checkout
  ui: add keycodemapdb repository as a GIT submodule
  ui: convert common input code to keycodemapdb
  ui: convert key events to QKeyCodes immediately
  ui: don't export qemu_input_event_new_key

 configure                 |  52 ++++---
 Makefile                  |  46 ++++++-
 include/ui/input.h        |  12 +-
 ui/input-keymap.c         | 336 +++-------------------------------------------
 ui/input.c                |  24 +++-
 .gitignore                |   2 +
 .gitmodules               |   3 +
 MAINTAINERS               |   6 +
 scripts/archive-source.sh |  34 ++++-
 scripts/git-submodule.sh  |  38 ++++++
 ui/keycodemapdb           |   1 +
 11 files changed, 202 insertions(+), 352 deletions(-)
 create mode 100755 scripts/git-submodule.sh
 create mode 160000 ui/keycodemapdb

-- 
2.9.3
