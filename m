Received: from eggs.gnu.org ([2001:4830:134:3::10]:35570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1db4rw-0005mr-EC
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1db4rm-0008LY-D5
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:59:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1db4rm-0008L2-3c
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:59:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E569C10F893
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 12:59:41 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 28 Jul 2017 14:59:32 +0200
Message-Id: <20170728125935.18167-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Ui 20170728 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit e01151de165070c25a1b202e9e2392950bd7c8da:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20170727-pull-request' into staging (2017-07-27 15:27:06 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20170728-pull-request

for you to fetch changes up to ef58430d5daeac4c18e4072f5860e25700aa8af6:

  ui: add pause key to linux_to_qcode (2017-07-28 12:35:40 +0200)

----------------------------------------------------------------
ui: more keymap fixes for 2.10

----------------------------------------------------------------

Daniel P. Berrange (1):
  ui: correctly detect spice PAUSE scancode sequence

Gerd Hoffmann (2):
  ui: drop ac_search and ac_stop
  ui: add pause key to linux_to_qcode

 hw/input/ps2.c    |  8 ++++----
 ui/input-keymap.c |  9 +++++----
 ui/spice-input.c  | 32 +++++++++++++-------------------
 qapi-schema.json  |  5 +----
 4 files changed, 23 insertions(+), 31 deletions(-)

-- 
2.9.3
