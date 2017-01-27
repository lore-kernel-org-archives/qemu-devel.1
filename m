Received: from eggs.gnu.org ([2001:4830:134:3::10]:35047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cX0yR-0007pV-RT
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cX0yG-0005Jp-TK
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:29:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cX0yG-0005JQ-Kd
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:29:20 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6B527E9C5
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 07:29:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 73EA31CADC8
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 07:29:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 27 Jan 2017 08:29:14 +0100
Message-Id: <1485502157-25445-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] QAPI/QMP patches for 2017-01-27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit c7f1cf01b8245762ca5864e835d84f6677ae8b=
1f:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into sta=
ging (2017-01-25 17:54:14 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-01-27

for you to fetch changes up to 7a8c153f0e59cccdc0425cdebe43765008def01a:

  qmp: Fix argument name in error message of device-list-properties (2017=
-01-27 08:23:06 +0100)

----------------------------------------------------------------
QAPI/QMP patches for 2017-01-27

----------------------------------------------------------------
Lin Ma (1):
      qmp: Fix argument name in error message of device-list-properties

Markus Armbruster (1):
      build-sys: Minor qapi doc generation target cleanups

Stefan Weil (1):
      qapi: Remove unwanted commas after #optional keyword

 Makefile             |  6 +++---
 qapi-schema.json     |  4 ++--
 qapi/block-core.json | 10 +++++-----
 qapi/event.json      |  6 +++---
 qmp.c                |  4 ++--
 5 files changed, 15 insertions(+), 15 deletions(-)

Lin Ma (1):
  qmp: Fix argument name in error message of device-list-properties

Markus Armbruster (1):
  build-sys: Minor qapi doc generation target cleanups

Stefan Weil (1):
  qapi: Remove unwanted commas after #optional keyword

 Makefile             |  6 +++---
 qapi-schema.json     |  4 ++--
 qapi/block-core.json | 10 +++++-----
 qapi/event.json      |  6 +++---
 qmp.c                |  4 ++--
 5 files changed, 15 insertions(+), 15 deletions(-)

--=20
2.7.4
