Received: from eggs.gnu.org ([2001:4830:134:3::10]:58047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1diiEN-0008Ey-Mp
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1diiEK-0006EF-GF
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:26:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1diiEK-0006Ao-9k
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:26:32 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Fri, 18 Aug 2017 16:26:03 +0200
Message-Id: <20170818142613.32394-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 00/10] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ldoktor@redhat.com, famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org

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

Changes in v2
- Squashed 2nd and 10th patches into 2nd one
- Use repr() in MonitorResponseError's description
- Improved commit message of the 6th patch
- Two tweaks to docstrings changed in the 6th patch
- Also updated qmp-shell to use new-style super calls (7th patch)
- Fixed the accidental rename of qmp `cmd_id` (kept the id->cmd_id patch)
- Changed the style of the style-fix in the 10th commit

Changes in v3
- Don't use repr in the 5th patch in MonitorResponseError

Changes in v4
- Use correct git base (remove unwanted commits)

Changes in v5
- Avoid bool comparison
- Change report to return in one docstring
- Removed the unnecessary spaces around single-line docstring

Changes in v6
- Bunch of docstring tweaks by Markus Armbruster
- Line break in <80 chars
- result dict =3D> response dict
- Removed the "event_match" rename

Luk=C3=A1=C5=A1 Doktor (10):
  qemu.py: Pylint/style fixes
  qemu|qtest: Avoid dangerous arguments
  qemu.py: Use iteritems rather than keys()
  qemu.py: Simplify QMP key-conversion
  qemu.py: Use custom exceptions rather than Exception
  qmp.py: Couple of pylint/style fixes
  qmp.py: Use object-based class for QEMUMonitorProtocol
  qmp.py: Avoid "has_key" usage
  qmp.py: Avoid overriding a builtin object
  qtest.py: Few pylint/style fixes

 scripts/qemu.py       | 95 +++++++++++++++++++++++++++++++++++++++------=
------
 scripts/qmp/qmp-shell |  4 +--
 scripts/qmp/qmp.py    | 49 +++++++++++++++-----------
 scripts/qtest.py      | 13 ++++---
 4 files changed, 111 insertions(+), 50 deletions(-)

--=20
2.9.4
