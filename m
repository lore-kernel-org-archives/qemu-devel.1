Received: from eggs.gnu.org ([2001:4830:134:3::10]:44918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fb45W-0004f5-VI
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fb45T-0004bJ-0E
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:14:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36198 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fb45S-0004a8-Sc
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:14:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DFC8401EF14
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 13:14:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-19.ams2.redhat.com
	[10.36.116.19])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4ABDF111DD01
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 13:14:18 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  5 Jul 2018 15:14:16 +0200
Message-Id: <20180705131417.1847-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Coverity model patches for 2018-07-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 4fd1cbaf146d4ab35f465bba0fe23115c33cd5a7:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2018-07-03-v2' into staging (2018-07-05 11:25:14 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-cov-model-2018-07-05

for you to fetch changes up to 19020d41759c7d34eae78d6afbec27c523d55bcd:

  coverity-model: Fix replay_get_byte() (2018-07-05 15:09:52 +0200)

----------------------------------------------------------------
Coverity model patches for 2018-07-05

----------------------------------------------------------------
Markus Armbruster (1):
      coverity-model: Fix replay_get_byte()

 scripts/coverity-model.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

-- 
2.17.1
