Received: from eggs.gnu.org ([2001:4830:134:3::10]:37686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUuq1-0000xl-CU
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUuq0-0000SP-Cu
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:08:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56322 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fUuq0-0000S5-7o
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:08:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CAC66401B3A0
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 14:08:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-237.ams2.redhat.com
	[10.36.117.237])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A6414111AF15
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 14:08:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Jun 2018 16:08:47 +0200
Message-Id: <20180618140854.17824-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] monitor: Thread safety improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799fa2:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180615a' into staging (2018-06-15 18:13:35 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-06-18

for you to fetch changes up to 474514668b47c9d2148b526e379ffbb6764d9a9e:

  monitor: add lock to protect mon_fdsets (2018-06-18 15:48:22 +0200)

----------------------------------------------------------------
Monitor patches for 2018-06-18

----------------------------------------------------------------
Peter Xu (7):
      monitor: rename out_lock to mon_lock
      monitor: protect mon->fds with mon_lock
      monitor: more comments on lock-free elements
      monitor: fix comment for monitor_lock
      monitor: remove event_clock_type
      monitor: move init global earlier
      monitor: add lock to protect mon_fdsets

 monitor.c     | 168 ++++++++++++++++++++++++++++++++++++++++------------------
 stubs/fdset.c |   2 +-
 util/osdep.c  |   3 +-
 vl.c          |   7 +--
 4 files changed, 121 insertions(+), 59 deletions(-)

Peter Xu (7):
  monitor: rename out_lock to mon_lock
  monitor: protect mon->fds with mon_lock
  monitor: more comments on lock-free elements
  monitor: fix comment for monitor_lock
  monitor: remove event_clock_type
  monitor: move init global earlier
  monitor: add lock to protect mon_fdsets

 monitor.c     | 168 +++++++++++++++++++++++++++++++++++---------------
 stubs/fdset.c |   2 +-
 util/osdep.c  |   3 +-
 vl.c          |   7 +--
 4 files changed, 121 insertions(+), 59 deletions(-)

-- 
2.17.1
