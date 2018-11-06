Received: from eggs.gnu.org ([2001:4830:134:3::10]:53320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gK5LQ-0006SY-A2
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gK5LC-0000if-Sm
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:40:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gK5LC-0007Hw-0J
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:40:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16410307D84F
	for <qemu-devel@nongnu.org>; Tue,  6 Nov 2018 17:39:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-34.ams2.redhat.com
	[10.36.117.34])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D7B9919751
	for <qemu-devel@nongnu.org>; Tue,  6 Nov 2018 17:39:42 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  6 Nov 2018 18:39:38 +0100
Message-Id: <20181106173941.9449-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/3] Monitor patches for 2018-10-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 0ca70f19c010ccf0b10cf7cc1d2b9a87193fe7=
87:

  tests: Fix Python 3 detection on older GNU make versions (2018-11-06 14=
:58:13 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-10-30-v2

for you to fetch changes up to 0c57893d62596d1d91779452be3b38b4b72ecd04:

  vl: Avoid crash when -mon is underspecified (2018-11-06 17:03:29 +0100)

----------------------------------------------------------------
Monitor patches for 2018-10-30

* Fix crash on shutdown with --daemonize
* Avoid crash when -mon lacks chardev=3D...

----------------------------------------------------------------
Eric Blake (1):
      vl: Avoid crash when -mon is underspecified

Wolfgang Bumiller (2):
      monitor: guard iothread access by mon->use_io_thread
      monitor: delay monitor iothread creation

 monitor.c | 37 ++++++++++++++++++++++---------------
 vl.c      |  4 ++++
 2 files changed, 26 insertions(+), 15 deletions(-)

Eric Blake (1):
  vl: Avoid crash when -mon is underspecified

Wolfgang Bumiller (2):
  monitor: guard iothread access by mon->use_io_thread
  monitor: delay monitor iothread creation

 monitor.c | 37 ++++++++++++++++++++++---------------
 vl.c      |  4 ++++
 2 files changed, 26 insertions(+), 15 deletions(-)

--=20
2.17.2
