Received: from eggs.gnu.org ([2001:4830:134:3::10]:45584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fgBju-00005g-VQ
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fgBjq-00041b-5z
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:25:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fgBjp-00040p-If
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:25:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 19 Jul 2018 17:25:01 +0100
Message-Id: <20180719162501.32641-2-stefanha@redhat.com>
In-Reply-To: <20180719162501.32641-1-stefanha@redhat.com>
References: <20180719162501.32641-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-3.0 1/1] tracing: Use double-dash spelling
 for trace option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>

From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>

The '-trace' and '--trace' spellings are only both supported in qemu
binary, while for qemu-nbd or qemu-img only '--trace' spelling is
supported. So for the consistency of trace option invocation, we
should use double-dash spelling in our documentation.

This's also mentioned in
https://wiki.qemu.org/BiteSizedTasks#Consistent_option_usage_in_documentation
.

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 1530674247-31200-1-git-send-email-baiyaowei@cmss.chinamobile.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/devel/tracing.txt | 6 +++---
 trace/control.h        | 4 ++--
 trace/control.c        | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index 6f815ecbd7..bc52f12485 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -18,7 +18,7 @@ for debugging, profiling, and observing execution.
 
 3. Run the virtual machine to produce a trace file:
 
-    qemu -trace events=/tmp/events ... # your normal QEMU invocation
+    qemu --trace events=/tmp/events ... # your normal QEMU invocation
 
 4. Pretty-print the binary trace file:
 
@@ -157,11 +157,11 @@ The state of events can also be queried and modified through monitor commands:
 * trace-event NAME on|off
   Enable/disable a given trace event or a group of events (using wildcards).
 
-The "-trace events=<file>" command line argument can be used to enable the
+The "--trace events=<file>" command line argument can be used to enable the
 events listed in <file> from the very beginning of the program. This file must
 contain one event name per line.
 
-If a line in the "-trace events=<file>" file begins with a '-', the trace event
+If a line in the "--trace events=<file>" file begins with a '-', the trace event
 will be disabled instead of enabled.  This is useful when a wildcard was used
 to enable an entire family of events but one noisy event needs to be disabled.
 
diff --git a/trace/control.h b/trace/control.h
index eb65c8e320..0716f90f45 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -193,7 +193,7 @@ void trace_event_set_vcpu_state_dynamic(CPUState *vcpu,
 /**
  * trace_init_backends:
  * @file:   Name of trace output file; may be NULL.
- *          Corresponds to commandline option "-trace file=...".
+ *          Corresponds to commandline option "--trace file=...".
  *
  * Initialize the tracing backend.
  *
@@ -204,7 +204,7 @@ bool trace_init_backends(void);
 /**
  * trace_init_file:
  * @file:   Name of trace output file; may be NULL.
- *          Corresponds to commandline option "-trace file=...".
+ *          Corresponds to commandline option "--trace file=...".
  *
  * Record the name of the output file for the tracing backend.
  * Exits if no selected backend does not support specifying the
diff --git a/trace/control.c b/trace/control.c
index e40cfca775..43fb7868db 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -253,7 +253,7 @@ void trace_init_file(const char *file)
 #ifdef CONFIG_TRACE_SIMPLE
     st_set_trace_file(file);
 #elif defined CONFIG_TRACE_LOG
-    /* If both the simple and the log backends are enabled, "-trace file"
+    /* If both the simple and the log backends are enabled, "--trace file"
      * only applies to the simple backend; use "-D" for the log backend.
      */
     if (file) {
@@ -261,7 +261,7 @@ void trace_init_file(const char *file)
     }
 #else
     if (file) {
-        fprintf(stderr, "error: -trace file=...: "
+        fprintf(stderr, "error: --trace file=...: "
                 "option not supported by the selected tracing backends\n");
         exit(1);
     }
-- 
2.17.1
