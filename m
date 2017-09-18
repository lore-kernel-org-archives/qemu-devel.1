Received: from eggs.gnu.org ([2001:4830:134:3::10]:35307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dtu3q-0005MR-Lv
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 07:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dtu3n-00055V-RW
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 07:17:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dtu3n-000559-LO
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 07:17:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C33F3C0587C6
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 11:17:54 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 18 Sep 2017 13:17:48 +0200
Message-Id: <20170918111750.15965-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Audio 20170918 patches
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

The following changes since commit f75637badd76ae0f3bd51a128e1a2da0d2bb1d6b:

  qemu.py: Fix syntax error (2017-09-18 11:32:22 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/audio-20170918-pull-request

for you to fetch changes up to a6b0bdc8fb4ca57a4274205659bbe91d78c23f22:

  audio: intel-hda: do not use old_mmio accesses (2017-09-18 13:13:32 +0200)

----------------------------------------------------------------
audio: bugfixes for wm8750 and intel-hda.

----------------------------------------------------------------

Gerd Hoffmann (1):
  wm8750: add record buffer underrun check

Matt Parker (1):
  audio: intel-hda: do not use old_mmio accesses

 hw/audio/intel-hda.c | 58 ++++++++++------------------------------------------
 hw/audio/wm8750.c    |  6 +++++-
 2 files changed, 16 insertions(+), 48 deletions(-)

-- 
2.9.3
