Received: from eggs.gnu.org ([2001:4830:134:3::10]:52495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj569-0005C3-RI
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj568-0004D5-LM
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:56:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34922 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fj568-0004Cl-Gl
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:56:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F372E7DAC3
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 15:56:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-135.ams2.redhat.com
	[10.36.116.135])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CE2B5111E418
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 15:56:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 27 Jul 2018 17:55:59 +0200
Message-Id: <20180727155602.10148-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] QObject patches for 2018-07-27 (3.0.0-rc3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 18a398f6a39df4b08ff86ac0d38384193ca5f4cc:

  Update version for v3.0.0-rc2 release (2018-07-24 22:06:31 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qobject-2018-07-27

for you to fetch changes up to 307fb894ce0608aede990ec40ce84eaeb358c8ec:

  qstring: Move qstring_from_substr()'s @end one to the right (2018-07-27 17:16:03 +0200)

----------------------------------------------------------------
QObject patches for 2018-07-27 (3.0.0-rc3)

This pull request fixes an integer overflow bug, and hardens the code
in question a bit.  Abuse of QMP can make the bug crash QEMU, so it
seems worth fixing at this late stage.

----------------------------------------------------------------
Markus Armbruster (2):
      qstring: Assert size calculations don't overflow
      qstring: Move qstring_from_substr()'s @end one to the right

liujunjie (1):
      qstring: Fix qstring_from_substr() not to provoke int overflow

 block/blkdebug.c           |  2 +-
 block/blkverify.c          |  2 +-
 block/nbd.c                |  2 +-
 include/qapi/qmp/qstring.h |  2 +-
 qobject/qstring.c          | 12 ++++++++----
 tests/check-qobject.c      |  2 +-
 tests/check-qstring.c      |  2 +-
 7 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.17.1
