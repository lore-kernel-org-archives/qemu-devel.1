Received: from eggs.gnu.org ([2001:4830:134:3::10]:34875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csrRf-0008O5-4I
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csrRb-0000Bd-NJ
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:45:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1csrRb-0000BC-Eb
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:45:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 743834ACB6
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 13:45:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 410F918990
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 13:45:54 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Mar 2017 15:45:51 +0200
Message-Id: <1490708752-26902-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9] Block patches for 2017-03-28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 0491c221547a38b58e41fade9953cd1cf015288b:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-mttcg-fixups-for-rc2-280317-1' into staging (2017-03-28 12:34:23 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-block-2017-03-28

for you to fetch changes up to 79b7a77eda5118f2661d251820d5ee9ee080354a:

  block: Declare blockdev-add and blockdev-del supported (2017-03-28 15:23:23 +0200)

----------------------------------------------------------------
Block patches for 2017-03-28

----------------------------------------------------------------
Markus Armbruster (1):
      block: Declare blockdev-add and blockdev-del supported

 blockdev.c             |  4 +--
 qapi/block-core.json   | 95 ++++++++++++++++++++------------------------------
 tests/qemu-iotests/139 |  8 ++---
 tests/qemu-iotests/141 |  4 +--
 tests/qemu-iotests/147 |  2 +-
 5 files changed, 47 insertions(+), 66 deletions(-)

Markus Armbruster (1):
  block: Declare blockdev-add and blockdev-del supported

 blockdev.c             |  4 +--
 qapi/block-core.json   | 95 ++++++++++++++++++++------------------------------
 tests/qemu-iotests/139 |  8 ++---
 tests/qemu-iotests/141 |  4 +--
 tests/qemu-iotests/147 |  2 +-
 5 files changed, 47 insertions(+), 66 deletions(-)

-- 
2.7.4
