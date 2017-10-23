Received: from eggs.gnu.org ([2001:4830:134:3::10]:47267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6XhF-00076J-CY
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6XhC-0006TB-AI
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:02:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e6XhC-0006Sb-3r
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:02:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B17E85D9E5
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 08:02:48 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 10:02:42 +0200
Message-Id: <20171023080245.31300-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Fixes 20171023 patches
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

The following changes since commit e822e81e350825dd94f41ee2538ff1432b812eb9:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-10-20 15:04:00 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/fixes-20171023-pull-request

for you to fetch changes up to 8172bdb2d0c829462f8c4fb2cb54a768d295a747:

  scripts: don't throw away stderr when checking out git submodules (2017-10-23 08:10:18 +0200)

----------------------------------------------------------------
fixes for the fallout of the recent ui and keymap merges.

----------------------------------------------------------------

Daniel P. Berrange (1):
  scripts: don't throw away stderr when checking out git submodules

Gerd Hoffmann (1):
  ui: add qemu-keymap and shader to .gitignore

Laurent Vivier (1):
  configure: disable qemu-keymap for linux-user qemu

 configure                | 6 +++---
 .gitignore               | 2 ++
 scripts/git-submodule.sh | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.9.3
