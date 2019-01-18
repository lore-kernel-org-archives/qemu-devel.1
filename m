Received: from eggs.gnu.org ([209.51.188.92]:58366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkXzR-0002vE-I5
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkXzQ-0003Xp-B1
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:31:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gkXzQ-0003Dk-0x
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:31:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77E6F58E49
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 17:31:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 18 Jan 2019 17:30:59 +0000
Message-Id: <20190118173103.4903-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/4] trace: make systemtap easier to use for
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This is a followup to

 v1: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg04173.html

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

 Makefile                             |   3 +
 Makefile.target                      |  11 +-
 docs/devel/tracing.txt               |  32 +++++
 hw/display/qxl.c                     |   3 +-
 hw/display/trace-events              |   2 +-
 hw/gpio/trace-events                 |   2 +-
 hw/vfio/pci.c                        |   2 +-
 hw/vfio/trace-events                 |   2 +-
 scripts/qemu-trace-stap              | 167 +++++++++++++++++++++++++++
 scripts/tracetool/__init__.py        |   6 +
 scripts/tracetool/format/log_stap.py | 127 ++++++++++++++++++++
 11 files changed, 351 insertions(+), 6 deletions(-)
 create mode 100755 scripts/qemu-trace-stap
 create mode 100644 scripts/tracetool/format/log_stap.py

--=20
2.20.1
