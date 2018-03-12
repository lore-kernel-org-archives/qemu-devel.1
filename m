Received: from eggs.gnu.org ([2001:4830:134:3::10]:50378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evSbk-0003fS-Ti
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evSbh-0001pn-T0
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:55:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evSbh-0001pJ-NP
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:55:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E233480508
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:55:36 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 12 Mar 2018 15:55:00 -0300
Message-Id: <20180312185503.5746-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] scripts: Python 3 compatibility fixes
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

Fix a few incompatibilities, which should be enough to allow
device-crash-test to work with Python 3.

Eduardo Habkost (3):
  qemu.py: Use items() instead of iteritems()
  qmp.py: Encode json data before sending
  device-crash-test: Use 'python' binary

 scripts/qemu.py           | 2 +-
 scripts/qmp/qmp.py        | 2 +-
 scripts/device-crash-test | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--=20
2.14.3
