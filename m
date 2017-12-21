Received: from eggs.gnu.org ([2001:4830:134:3::10]:53545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRwBS-0008O1-DB
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRwBP-0007X3-BZ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:26:30 -0500
Received: from chuckie.co.uk ([82.165.15.123]:43148
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eRwBP-0007WH-4l
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:26:27 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 21 Dec 2017 08:20:44 +0000
Message-Id: <20171221082045.14022-16-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
References: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv3 15/16] sparc64: introduce trace-events for
 hw/sparc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

This is in preparation for switching code in hw/sparc64 from DPRINTF over to
trace events.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 Makefile.objs           | 1 +
 hw/sparc64/trace-events | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 hw/sparc64/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 285c6f3c15..c8b1bba593 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -140,6 +140,7 @@ trace-events-subdirs += hw/input
 trace-events-subdirs += hw/timer
 trace-events-subdirs += hw/dma
 trace-events-subdirs += hw/sparc
+trace-events-subdirs += hw/sparc64
 trace-events-subdirs += hw/sd
 trace-events-subdirs += hw/isa
 trace-events-subdirs += hw/mem
diff --git a/hw/sparc64/trace-events b/hw/sparc64/trace-events
new file mode 100644
index 0000000000..9284b1fbad
--- /dev/null
+++ b/hw/sparc64/trace-events
@@ -0,0 +1 @@
+# See docs/devel/tracing.txt for syntax documentation.
-- 
2.11.0
