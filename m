Received: from eggs.gnu.org ([2001:4830:134:3::10]:48453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emk5v-0008Ey-Fz
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emk5r-0000lA-Fh
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:46:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48882 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1emk5r-0000l1-AO
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:46:43 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 16 Feb 2018 17:46:39 +0000
Message-Id: <20180216174640.21765-2-dgilbert@redhat.com>
In-Reply-To: <20180216174640.21765-1-dgilbert@redhat.com>
References: <20180216174640.21765-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] monitor: Remove legacy "-mon default=on"
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, thuth@redhat.com, t.pagef.lt@gmail.com

From: Thomas Huth <thuth@redhat.com>

The "default" parameter of the "-mon" option is useless since
QEMU v2.4.0, and marked as deprecated since QEMU v2.8.0. That
should have been long enough to let people update their scripts,
so time to remove it now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1513700253-10045-1-git-send-email-thuth@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor.c     | 3 ---
 qemu-doc.texi | 9 ---------
 vl.c          | 4 ----
 3 files changed, 16 deletions(-)

diff --git a/monitor.c b/monitor.c
index f4992505b1..9a0d480c53 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4142,9 +4142,6 @@ QemuOptsList qemu_mon_opts = {
         },{
             .name = "chardev",
             .type = QEMU_OPT_STRING,
-        },{
-            .name = "default",  /* deprecated */
-            .type = QEMU_OPT_BOOL,
         },{
             .name = "pretty",
             .type = QEMU_OPT_BOOL,
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 137f5814a8..56388b5b33 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2628,15 +2628,6 @@ setting ``-machine kernel_irqchip=off''.
 The ``-no-kvm'' argument is now a synonym for setting
 ``-machine accel=tcg''.
 
-@subsection -mon default=on (since 2.4.0)
-
-The ``default'' option to the ``-mon'' argument is
-now ignored. When multiple monitors were enabled, it
-indicated which monitor would receive log messages
-from the various subsystems. This feature is no longer
-required as messages are now only sent to the monitor
-in response to explicitly monitor commands.
-
 @subsection -vnc tls (since 2.5.0)
 
 The ``-vnc tls'' argument is now a synonym for setting
diff --git a/vl.c b/vl.c
index 7a5554bc41..81724f5f17 100644
--- a/vl.c
+++ b/vl.c
@@ -2423,10 +2423,6 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
     if (qemu_opt_get_bool(opts, "pretty", 0))
         flags |= MONITOR_USE_PRETTY;
 
-    if (qemu_opt_get_bool(opts, "default", 0)) {
-        error_report("option 'default' does nothing and is deprecated");
-    }
-
     chardev = qemu_opt_get(opts, "chardev");
     chr = qemu_chr_find(chardev);
     if (chr == NULL) {
-- 
2.14.3
