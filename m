Received: from eggs.gnu.org ([2001:4830:134:3::10]:59741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dwnhF-00051j-HF
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dwnhC-0001Hp-ER
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dwnhC-0001HO-8v
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A9C3128B
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 11:06:33 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 26 Sep 2017 13:06:26 +0200
Message-Id: <20170926110628.2705-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Fw 20170926 patches
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

The following changes since commit 1e3ee834083227f552179f6e43902cba5a866e6b:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2017-09-25 20:31:24 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/fw-20170926-pull-request

for you to fetch changes up to 3d5eecab4a5a00df897253dda5792411a1872732:

  Add --firmwarepath to configure (2017-09-26 13:05:32 +0200)

----------------------------------------------------------------
add --firmwarepath to configure

----------------------------------------------------------------

Gerd Hoffmann (2):
  add qemu_add_data_dir()
  Add --firmwarepath to configure

 configure             |  6 ++++++
 vl.c                  | 44 +++++++++++++++++++++++++++++++-------------
 scripts/create_config |  2 +-
 3 files changed, 38 insertions(+), 14 deletions(-)

-- 
2.9.3
