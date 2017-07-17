Received: from eggs.gnu.org ([2001:4830:134:3::10]:50316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2UJ-0007SV-Ob
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2UF-0000kK-RH
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:38:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX2UF-0000k4-Kd
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:38:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 914BD7CB85
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 09:38:42 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 11:38:36 +0200
Message-Id: <20170717093839.15341-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Ui 20170717 patches
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

The following changes since commit 6e2c46334385c7e295ac883c801c81b4925fb54f:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170711' into staging (2017-07-13 10:47:10 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20170717-pull-request

for you to fetch changes up to feb47cf2fac5a0b8fe8509b18edf077e065dc97f:

  keymaps: fr-ca: add missing keys (2017-07-17 11:36:41 +0200)

----------------------------------------------------------------
ui: vnc and keymap updates for 2.10

----------------------------------------------------------------

Alexander Graf (1):
  vnc: Set default kbd delay to 10ms

Dr. David Alan Gilbert (1):
  hmp: Update info vnc

Gerd Hoffmann (1):
  keymaps: fr-ca: add missing keys

 hmp.c                 | 104 +++++++++++++++++++++++++++++++++++---------------
 ui/vnc.c              |   2 +-
 pc-bios/keymaps/fr-ca |   2 +
 qemu-options.hx       |   2 +-
 4 files changed, 77 insertions(+), 33 deletions(-)

-- 
2.9.3
