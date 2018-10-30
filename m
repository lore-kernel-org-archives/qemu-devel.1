Received: from eggs.gnu.org ([2001:4830:134:3::10]:37687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHZVL-00031I-3B
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHZVI-0005rc-FY
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:16:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gHZVI-0005iq-7C
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:16:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8705C058CA2
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 19:16:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-34.ams2.redhat.com
	[10.36.117.34])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7853E6090A
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 19:16:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 30 Oct 2018 20:16:12 +0100
Message-Id: <20181030191620.32168-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] Monitor patches for 2018-10-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 3f3285491dd52014852a56135c90e428c8b507=
ea:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2018-10-30 14:09:25 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-10-30

for you to fetch changes up to 1a8de278dd3c93a7aa40f88486509fe0e2de04da:

  vl: Avoid crash when -mon is underspecified (2018-10-30 20:13:52 +0100)

----------------------------------------------------------------
Monitor patches for 2018-10-30

* Fix crash on shutdown with --daemonize
* Change out-of-band execution to stop reading instead of dropping
  commands
* Enable out-of-band execution by default
* Avoid crash when -mon lacks chardev=3D...

----------------------------------------------------------------
Eric Blake (1):
      vl: Avoid crash when -mon is underspecified

Peter Xu (5):
      monitor: Suspend monitor instead dropping commands
      monitor: remove "x-oob", turn oob on by default
      Revert "tests: Add parameter to qtest_init_without_qmp_handshake"
      tests: add oob functional test for test-qmp-cmds
      tests: qmp-test: add queue full test

Wolfgang Bumiller (2):
      monitor: guard iothread access by mon->use_io_thread
      monitor: delay monitor iothread creation

 docs/interop/qmp-spec.txt |   5 ++-
 include/monitor/monitor.h |   3 +-
 monitor.c                 | 111 +++++++++++++++++++++-------------------=
------
 qapi/misc.json            |  40 -----------------
 tests/libqtest.c          |  10 ++---
 tests/libqtest.h          |   4 +-
 tests/qmp-test.c          |  32 +++++++++++--
 tests/test-qmp-cmds.c     |  16 +++++++
 vl.c                      |   9 ++--
 9 files changed, 110 insertions(+), 120 deletions(-)

--=20
2.17.2
