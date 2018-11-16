Received: from eggs.gnu.org ([2001:4830:134:3::10]:48623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gNbAB-0001bg-SV
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gNbA7-0006QT-Pp
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:15:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56457)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1gNbA7-0006Pb-KB
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:15:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BE243B71B
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 10:15:41 +0000 (UTC)
From: Erik Skultety <eskultet@redhat.com>
Date: Fri, 16 Nov 2018 11:14:41 +0100
Message-Id: <cover.1542362949.git.eskultet@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] Introduce 'rendernode' option for
 egl-headless display type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Erik Skultety <eskultet@redhat.com>, kraxel@redhat.com

https://bugzilla.redhat.com/show_bug.cgi?id=3D1648236

Changes since v1:
- adjusted the QAPI version and description commentaries for egl-headless

Erik Skultety (3):
  qapi: Add "rendernode" display option for egl-headless
  ui: Allow specifying 'rendernode' display option for egl-headless
  help: Provide help for egl-headless

 qapi/ui.json      | 17 ++++++++++++++++-
 qemu-options.hx   |  6 +++++-
 ui/egl-headless.c |  2 +-
 3 files changed, 22 insertions(+), 3 deletions(-)

--
2.19.1
