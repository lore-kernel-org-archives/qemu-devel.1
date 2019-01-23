Received: from eggs.gnu.org ([209.51.188.92]:38553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmHOp-0002UZ-Ac
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:12:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmHCq-0003oT-Ho
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:00:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmHCo-0003ky-Fv
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:00:32 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8021F81DE5
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 12:00:26 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 23 Jan 2019 12:00:12 +0000
Message-Id: <20190123120016.4538-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/4] trace: make systemtap easier to use for
 simple logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This is a followup to

 v1: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg04173.html
 v2: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg04759.html
 v3: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05477.html

Changed in v4:

 - Fix license to be GPLv2-or-later (Eric)
 - Misc typo fixes (Eric)

Changed in v3:

 - g_strndup the QXL log_buf before printing to avoid a race
   with guest removing the nul terminator (Stefan)
 - Add filtering of PIDs with "-p PID" arg to qemu-trace-stap
 - Add a man page for qemu-trace-stap (Eric)
 - Remove examples in docs/devel/tracing.txt and just refer
   people to the above man page.
 - Use strerror(errno) instead of raw errno in vfio traces (Eric/Alex)
 - Quote probe wildcards to be shell glob safe (Eric)
 - Mention explicitly that it is launched separately from QEMU (Eric)

Changed in v2:

 - Fix safety of QXL logging
 - Handle format specifier macros is a more reliable manner
 - Fix trace-events files missing newline
 - Remove use of %m formats

Daniel P. Berrang=C3=A9 (4):
  display: ensure qxl log_buf is a nul terminated string
  trace: enforce that every trace-events file has a final newline
  trace: forbid use of %m in trace event format strings
  trace: add ability to do simple printf logging via systemtap

 MAINTAINERS                          |   1 +
 Makefile                             |  10 ++
 Makefile.target                      |  11 +-
 docs/devel/tracing.txt               |   4 +
 hw/display/qxl.c                     |  14 ++-
 hw/display/trace-events              |   2 +-
 hw/gpio/trace-events                 |   2 +-
 hw/vfio/pci.c                        |   2 +-
 hw/vfio/trace-events                 |   2 +-
 scripts/qemu-trace-stap              | 175 +++++++++++++++++++++++++++
 scripts/qemu-trace-stap.texi         | 140 +++++++++++++++++++++
 scripts/tracetool/__init__.py        |   6 +
 scripts/tracetool/format/log_stap.py | 127 +++++++++++++++++++
 13 files changed, 487 insertions(+), 9 deletions(-)
 create mode 100755 scripts/qemu-trace-stap
 create mode 100644 scripts/qemu-trace-stap.texi
 create mode 100644 scripts/tracetool/format/log_stap.py

--=20
2.20.1
