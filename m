Received: from eggs.gnu.org ([2001:4830:134:3::10]:52704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxC0M-0000sW-0T
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxC0G-0006aL-G8
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:03:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55879)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxC0G-0006Zu-AI
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:03:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F343C61462
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 13:03:50 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 10:03:34 -0300
Message-Id: <20170927130339.21444-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/5] scripts: Remove 'debug' parameter from
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
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>

This series removes the 'debug' parameter from QEMUMachine and
QEMUMonitorProtocol and lets scripts use the logging module to
enable debugging messages.

Eduardo Habkost (5):
  guestperf: Configure logging on all shell frontends
  iotests: Set up Python logging
  basevm: Call logging.basicConfig()
  scripts: Remove debug parameter from QEMUMonitorProtocol
  scripts: Remove debug parameter from QEMUMachine

 scripts/qemu.py                     |  9 +++------
 scripts/qmp/qmp.py                  | 13 ++++++-------
 tests/migration/guestperf/engine.py |  6 ++----
 tests/migration/guestperf/shell.py  |  9 +++++++++
 tests/qemu-iotests/iotests.py       |  5 +++--
 tests/vm/basevm.py                  |  4 ++--
 6 files changed, 25 insertions(+), 21 deletions(-)

--=20
2.13.5
