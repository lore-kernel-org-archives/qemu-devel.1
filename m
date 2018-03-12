Received: from eggs.gnu.org ([208.118.235.92]:51009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evPsD-0004u7-I5
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evPs9-0000fw-Ex
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44872 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1evPs9-0000fS-8G
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 12 Mar 2018 16:00:09 +0000
Message-Id: <20180312160014.6804-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

The following changes since commit e4ae62b802cec437f877f2cadc4ef059cc0eca=
76:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2018-03-09 17:28:16 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 73ff061032efa0b260bcd1a177ac89b57a1642d3:

  trace: only permit standard C types and fixed size integer types (2018-=
03-12 11:10:20 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (3):
  trace: include filename when printing parser error messages
  trace: remove use of QEMU specific types from trace probes
  trace: only permit standard C types and fixed size integer types

Peter Maydell (1):
  log-for-trace.h: Split out parts of log.h used by trace.h

Stefan Hajnoczi (1):
  simpletrace: fix timestamp argument type

 include/qemu/log-for-trace.h     | 35 +++++++++++++++++++++++++++
 include/qemu/log.h               | 18 ++++----------
 scripts/simpletrace.py           |  6 ++---
 scripts/tracetool.py             |  2 +-
 scripts/tracetool/__init__.py    | 52 ++++++++++++++++++++++++++++++++++=
++++--
 scripts/tracetool/backend/log.py | 13 +++++-----
 trace-events                     |  6 ++---
 7 files changed, 102 insertions(+), 30 deletions(-)
 create mode 100644 include/qemu/log-for-trace.h

--=20
2.14.3
