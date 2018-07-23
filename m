Received: from eggs.gnu.org ([2001:4830:134:3::10]:48799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fhaf5-0002lv-4O
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fhaf0-00051q-8a
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:14:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fhaf0-00051f-3s
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:13:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1B658790F
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 13:13:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-135.ams2.redhat.com
	[10.36.116.135])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A4C92156892
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 13:13:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 23 Jul 2018 15:13:54 +0200
Message-Id: <20180723131356.27466-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] QAPI and monitor patches for 2018-07-23
 (3.0.0-rc2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 6598f0cdad6acc6674c4f060fa46e537228c2c=
47:

  po: Don't include comments with location (2018-07-23 10:50:54 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2018-07-23

for you to fetch changes up to 62aa1d887ff9fc76adb488d31447d126a78f4b8f:

  monitor: Fix unsafe sharing of @cur_mon among threads (2018-07-23 14:00=
:03 +0200)

----------------------------------------------------------------
QAPI and monitor patches for 2018-07-23 (3.0.0-rc2)

This pull request consists of a late external interface tweak and a
thread safety fix, both related to QMP out-of-band execution.

----------------------------------------------------------------
Markus Armbruster (1):
      qapi: Make 'allow-oob' optional in SchemaInfoCommand

Peter Xu (1):
      monitor: Fix unsafe sharing of @cur_mon among threads

 include/monitor/monitor.h  |  2 +-
 monitor.c                  |  2 +-
 qapi/introspect.json       |  6 +++---
 scripts/qapi/introspect.py | 10 +++++-----
 stubs/monitor.c            |  2 +-
 tests/test-util-sockets.c  |  2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)
armbru@dusky:~/work/qemu$ rm *patch
armbru@dusky:~/work/qemu$ git-format-patch --subject-prefix PULL master
0000-cover-letter.patch
0001-qapi-Make-allow-oob-optional-in-SchemaInfoCommand.patch
0002-monitor-Fix-unsafe-sharing-of-cur_mon-among-threads.patch

--=20
2.17.1
