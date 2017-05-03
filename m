Received: from eggs.gnu.org ([2001:4830:134:3::10]:43477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d5sWr-0001XM-P1
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d5sWm-0001GO-SK
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:33:09 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56374)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d5sWm-0001Fg-KG
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:33:04 -0400
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Wed, 03 May 2017 14:33:04 +0300
Message-ID: <20170503113304.8704.13997.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] maintainers: add maintainer for replay*
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, dovgaluk@ispras.ru, armbru@redhat.com, pbonzini@redhat.com

Updating MAINTAINERS to set Pavel Dovgalyuk as record/replay maintainer
and Paolo Bonzini as a reviewer.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 MAINTAINERS |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a1d2b3a4d3..4e8bbb07aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1546,6 +1546,18 @@ F: net/colo*
 F: net/filter-rewriter.c
 F: net/filter-mirror.c
 
+Record/replay
+M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
+R: Paolo Bonzini <pbonzini@redhat.com>
+W: http://wiki.qemu.org/Features/record-replay
+S: Supported
+F: replay/*
+F: block/blkreplay.c
+F: net/filter-replay.c
+F: include/sysemu/replay.h
+F: docs/replay.txt
+F: stubs/replay.c
+
 Usermode Emulation
 ------------------
 Overall
