Received: from eggs.gnu.org ([2001:4830:134:3::10]:53987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fppzd-0000k3-D2
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fppzT-00083r-AB
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:13:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fppzS-00082R-SB
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:13:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F41840216E8
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:13:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-62.ams2.redhat.com
	[10.36.117.62])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 450AB1012331
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:13:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Aug 2018 09:13:03 +0200
Message-Id: <20180815071308.11777-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Miscellaneous patches for 2018-08-15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 38441756b70eec5807b5f60dad11a93a911998=
66:

  Update version for v3.0.0 release (2018-08-14 16:38:43 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-misc-2018-08-15

for you to fetch changes up to cb9ec42f33c07cd07d2e2971422bf7636c761202:

  monitor: fix oob command leak (2018-08-15 08:12:57 +0200)

----------------------------------------------------------------
Miscellaneous patches for 2018-08-15

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (4):
      qmp-shell: learn to send commands with quoted arguments
      tests: change /0.15/* tests to /qmp/*
      tests: fix crumple/recursive leak
      monitor: fix oob command leak

Markus Armbruster (1):
      qapi: Fix some pycodestyle-3 complaints

 monitor.c                      |  2 ++
 scripts/qapi/common.py         | 15 +++++++++------
 scripts/qapi/visit.py          |  2 +-
 scripts/qmp/qmp-shell          |  3 ++-
 tests/check-block-qdict.c      |  1 +
 tests/qapi-schema/test-qapi.py | 13 +++++++------
 tests/test-qmp-cmds.c          | 10 +++++-----
 7 files changed, 27 insertions(+), 19 deletions(-)

--=20
2.17.1
