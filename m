Received: from eggs.gnu.org ([2001:4830:134:3::10]:42279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7av-00050i-M8
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7ar-0005IM-UB
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:45:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cT7ar-0005Hz-OL
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:45:05 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 16 Jan 2017 13:44:55 +0000
Message-Id: <20170116134455.28636-5-stefanha@redhat.com>
In-Reply-To: <20170116134455.28636-1-stefanha@redhat.com>
References: <20170116134455.28636-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] trace: Add event "guest_cpu_exit"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

From: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>

Signals the hot-unplugging of a virtual (guest) CPU.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Message-id: 148278748597.1404.10546320797997984932.stgit@fimbulvetr.bsc.e=
s
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace/control.c | 3 +++
 trace-events    | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/trace/control.c b/trace/control.c
index cb79bb1..56a2632 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -26,6 +26,7 @@
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "monitor/monitor.h"
+#include "trace.h"
=20
 int trace_events_enabled_count;
=20
@@ -264,6 +265,8 @@ void trace_fini_vcpu(CPUState *vcpu)
     TraceEventIter iter;
     TraceEvent *ev;
=20
+    trace_guest_cpu_exit(vcpu);
+
     trace_event_iter_init(&iter, NULL);
     while ((ev =3D trace_event_iter_next(&iter)) !=3D NULL) {
         if (trace_event_is_vcpu(ev) &&
diff --git a/trace-events b/trace-events
index 2c66780..839a9d0 100644
--- a/trace-events
+++ b/trace-events
@@ -141,6 +141,12 @@ memory_region_ram_device_write(int cpu_index, void *=
mr, uint64_t addr, uint64_t
 # Targets: all
 vcpu guest_cpu_enter(void)
=20
+# Hot-unplug a virtual (guest) CPU
+#
+# Mode: user, softmmu
+# Targets: all
+vcpu guest_cpu_exit(void)
+
 # Reset the state of a virtual (guest) CPU
 #
 # Mode: user, softmmu
--=20
2.9.3
