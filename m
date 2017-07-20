Received: from eggs.gnu.org ([2001:4830:134:3::10]:51339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYESi-0004sL-1W
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYESh-0002cO-8x
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:38:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dYESh-0002bt-3I
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:38:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B678C806C9
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 16:29:11 +0000 (UTC)
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Thu, 20 Jul 2017 18:28:04 +0200
Message-Id: <20170720162815.19802-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/11] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ldoktor@redhat.com, apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, ehabkost@redhat.com

Hello guys,

I'm reading the available python modules to exercise qemu and while readi=
ng them
I fixed some issues that caught my attention. It usually starts with a si=
mple
pylint/docstring fixes and slowly graduates to more controversial ones so=
 I'm
open to suggestion to remove some of them.

Kind regards,
Luk=C3=A1=C5=A1

Luk=C3=A1=C5=A1 Doktor (11):
  qemu.py: Pylint/style fixes
  qemu.py: Avoid dangerous arguments
  qemu.py: Use iteritems rather than keys()
  qemu.py: Simplify QMP key-conversion
  qemu.py: Use custom exceptions rather than Exception
  qmp.py: Couple of pylint/style fixes
  qmp.py: Use object-based class for QEMUMonitorProtocol
  qmp.py: Avoid "has_key" usage
  qmp.py: Avoid overriding a builtin object
  qtest.py: Few pylint/style fixes
  qtest.py: Avoid using mutable list as default argument

 scripts/qemu.py    | 98 +++++++++++++++++++++++++++++++++++++++---------=
------
 scripts/qmp/qmp.py | 49 ++++++++++++++++-----------
 scripts/qtest.py   | 14 ++++----
 3 files changed, 108 insertions(+), 53 deletions(-)

--=20
2.9.4
