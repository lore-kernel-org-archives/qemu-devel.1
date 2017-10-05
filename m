Received: from eggs.gnu.org ([2001:4830:134:3::10]:35633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e09pG-0004ZP-Ui
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 13:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e09pF-0000fK-55
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 13:20:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e09pE-0000ex-VO
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 13:20:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1ADB57F415
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 17:20:44 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  5 Oct 2017 14:20:10 -0300
Message-Id: <20171005172013.3098-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] scripts: Remove 'debug' parameter from
 QEMUMachine & QEMUMonitorProtocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>

Changes v1 -> v2:
* Rebased to python-next (some patches from v1 are already queued
  there)S
* guestperf: Inline init_logging() method on all callers because
  not all classes derive from BaseShell (reported by Luk=C3=A1=C5=A1
  Doktor)

This series removes the 'debug' parameter from QEMUMachine and
QEMUMonitorProtocol and lets scripts use the logging module to
enable debugging messages.

Eduardo Habkost (3):
  guestperf: Configure logging on all shell frontends
  scripts: Remove debug parameter from QEMUMonitorProtocol
  scripts: Remove debug parameter from QEMUMachine

 scripts/qemu.py                     |  9 +++------
 scripts/qmp/qmp.py                  | 16 +++++++---------
 tests/migration/guestperf/engine.py |  6 ++----
 tests/migration/guestperf/shell.py  | 13 +++++++++++++
 tests/qemu-iotests/iotests.py       |  2 --
 5 files changed, 25 insertions(+), 21 deletions(-)

--=20
2.13.6
