Received: from eggs.gnu.org ([209.51.188.92]:34899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gogOX-0004w7-9w
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gogOW-0006aS-Kk
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:18:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gogOW-0006Zf-FU
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:18:32 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 30 Jan 2019 11:18:11 +0800
Message-Id: <20190130031817.27780-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

The following changes since commit f6b06fcceef465de0cf2514c9f76fe01928967=
81:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190121-pull-requ=
est' into staging (2019-01-23 17:57:47 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 57b7bdf426445d8356171135308dfe6d7d5fb612:

  trace: rerun tracetool after ./configure changes (2019-01-30 10:57:03 +=
0800)

----------------------------------------------------------------
Pull request

User-visible changes:
 * The new qemu-trace-stap script makes it convenient to collect traces w=
ithout
   writing SystemTap scripts.  See "man qemu-trace-stap" for details.

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (4):
  display: ensure qxl log_buf is a nul terminated string
  trace: enforce that every trace-events file has a final newline
  trace: forbid use of %m in trace event format strings
  trace: add ability to do simple printf logging via systemtap

Stefan Hajnoczi (1):
  trace: rerun tracetool after ./configure changes

Vladimir Sementsov-Ogievskiy (1):
  trace: improve runstate tracing

 MAINTAINERS                          |   1 +
 docs/devel/tracing.txt               |   4 +
 Makefile                             |  26 ++--
 Makefile.target                      |  11 +-
 hw/display/qxl.c                     |  14 ++-
 hw/vfio/pci.c                        |   2 +-
 vl.c                                 |   7 +-
 hw/display/trace-events              |   2 +-
 hw/gpio/trace-events                 |   2 +-
 hw/vfio/trace-events                 |   2 +-
 scripts/qemu-trace-stap              | 175 +++++++++++++++++++++++++++
 scripts/qemu-trace-stap.texi         | 140 +++++++++++++++++++++
 scripts/tracetool/__init__.py        |   6 +
 scripts/tracetool/format/log_stap.py | 127 +++++++++++++++++++
 trace-events                         |   4 +-
 15 files changed, 502 insertions(+), 21 deletions(-)
 create mode 100755 scripts/qemu-trace-stap
 create mode 100644 scripts/qemu-trace-stap.texi
 create mode 100644 scripts/tracetool/format/log_stap.py

--=20
2.20.1
