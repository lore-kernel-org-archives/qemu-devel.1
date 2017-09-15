Received: from eggs.gnu.org ([2001:4830:134:3::10]:56108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0BC-0004rP-Qo
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0B9-0000yA-CS
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:37:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0B9-0000xV-7d
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:37:47 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Sep 2017 20:37:24 -0300
Message-Id: <20170915233739.26860-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/15] Python queue, 2017-09-15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amador Pahim <apahim@redhat.com>

I have been queueing some patches for Python modules and scripts,
recently, and submitted a MAINTAINERS patch to include Cleber and
me as maintainers.

However, I don't want to delay this pull request to avoid
conflicts if people send additional patches for those scripts, so
I'm sending this pull request before the MAINTAINERS patch is
applied.

The following changes since commit 5faf2d376af3cb4eb92da44c2580e08d39832c=
aa:

  Merge remote-tracking branch 'remotes/huth/tags/check-20170915' into st=
aging (2017-09-15 20:29:44 +0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to b92a0011b1220aff549ae82c6104014d25e339ef:

  qemu.py: include debug information on launch error (2017-09-15 20:12:00=
 -0300)

----------------------------------------------------------------
Python queue, 2017-09-15

----------------------------------------------------------------

Amador Pahim (5):
  qemu.py: fix is_running() return before first launch()
  qemu.py: avoid writing to stdout/stderr
  qemu.py: use os.path.null instead of /dev/null
  qemu.py: improve message on negative exit code
  qemu.py: include debug information on launch error

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

 scripts/qemu.py       | 145 +++++++++++++++++++++++++++++++++++++++-----=
------
 scripts/qmp/qmp.py    |  49 ++++++++++-------
 scripts/qtest.py      |  13 +++--
 scripts/qmp/qmp-shell |   4 +-
 4 files changed, 151 insertions(+), 60 deletions(-)

--=20
2.13.5
