Received: from eggs.gnu.org ([2001:4830:134:3::10]:50796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fw3u7-0003Sl-El
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 07:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fw3u4-0000ix-9O
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 07:17:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53050 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fw3u4-0000if-4m
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 07:17:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 399668076895
	for <qemu-devel@nongnu.org>; Sat,  1 Sep 2018 11:17:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-191.ams2.redhat.com
	[10.36.116.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 116882166B41
	for <qemu-devel@nongnu.org>; Sat,  1 Sep 2018 11:17:18 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Sat,  1 Sep 2018 13:17:10 +0200
Message-Id: <20180901111716.1675-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] Monitor patches for 2018-09-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd2415574=
52:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27=
-v2' into staging (2018-08-27 16:44:20 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-09-01

for you to fetch changes up to 176160ce78b58f29d765ddace885e88a732df34a:

  monitor: no need to save need_resume (2018-08-30 16:08:54 +0200)

----------------------------------------------------------------
Monitor patches for 2018-09-01

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (5):
      monitor: accept input on resume
      monitor: consitify qmp_send_response() QDict argument
      qmp: constify qmp_is_oob()
      Revert "qmp: isolate responses into io thread"
      monitor: no need to save need_resume

Peter Xu (1):
      monitor: simplify monitor_qmp_setup_handlers_bh

 include/qapi/qmp/dispatch.h |   2 +-
 monitor.c                   | 150 ++++----------------------------------=
------
 qapi/qmp-dispatch.c         |   2 +-
 3 files changed, 15 insertions(+), 139 deletions(-)

--=20
2.17.1
