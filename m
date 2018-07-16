Received: from eggs.gnu.org ([2001:4830:134:3::10]:33990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ff47r-0001pu-Pu
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ff47o-0007vj-FY
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39146 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ff47o-0007vR-8a
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE6DB7A7E0
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 14:05:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-125.ams2.redhat.com
	[10.36.116.125])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B71DE7C49
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 14:05:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 16 Jul 2018 16:05:09 +0200
Message-Id: <20180716140514.1490-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Miscellaneous patches for 2018-07-16
 (3.0.0-rc1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 633e824037210a60c0b23d6c0e42420db1fe4c=
08:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-3.0-20180716=
' into staging (2018-07-16 11:04:24 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-misc-2018-07-16

for you to fetch changes up to 8720e63e09fa1e48dbd244d89d6fed6b5c50889d:

  monitor: Fix tracepoint crash on JSON syntax error (2018-07-16 15:46:57=
 +0200)

----------------------------------------------------------------
Miscellaneous patches for 2018-07-16 (3.0.0-rc1)

This pull request consists of a late but necessary external interface
update, a documentation rearrangement to make tracking feature
deprecation easier, and a crash bug fix.

----------------------------------------------------------------
Markus Armbruster (5):
      qapi: Do not expose "allow-preconfig" in query-qmp-schema
      cli qmp: Mark --preconfig, exit-preconfig experimental
      qemu-doc: Move appendix "Deprecated features" to its own file
      MAINTAINERS: New section "Incompatible changes", copy libvir-list
      monitor: Fix tracepoint crash on JSON syntax error

 MAINTAINERS                |   4 +
 hmp.c                      |   2 +-
 monitor.c                  |   2 +-
 qapi/introspect.json       |   5 +-
 qapi/misc.json             |   6 +-
 qemu-deprecated.texi       | 234 +++++++++++++++++++++++++++++++++++++++=
+++++
 qemu-doc.texi              | 235 +--------------------------------------=
------
 qemu-options.hx            |   9 +-
 qemu-tech.texi             |  11 +--
 qmp.c                      |   2 +-
 scripts/qapi/introspect.py |   4 +-
 tests/numa-test.c          |   2 +-
 tests/qmp-test.c           |   6 +-
 13 files changed, 261 insertions(+), 261 deletions(-)
 create mode 100644 qemu-deprecated.texi
