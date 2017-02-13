Received: from eggs.gnu.org ([2001:4830:134:3::10]:44566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cdCvI-0008LD-5u
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cdCvD-0005WD-21
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:27:52 -0500
Received: from victor.provo.novell.com ([137.65.250.26]:42991
	helo=prv3-mh.provo.novell.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1cdCvC-0005U6-Op
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:27:46 -0500
From: Lin Ma <lma@suse.com>
Date: Mon, 13 Feb 2017 17:27:09 +0800
Message-Id: <20170213092709.24711-1-lma@suse.com>
Subject: [Qemu-devel] [PATCH] trace: fix trace-events-all dependencies in
 Makefile.objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, berrange@redhat.com

It causes that file trace-events-all isn't generated during build, make
install reports 'No such file or directory'. The patch fixes it.

Signed-off-by: Lin Ma <lma@suse.com>
---
 trace/Makefile.objs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index 7de840a..8e5e85a 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -17,7 +17,7 @@ $(BUILD_DIR)/trace-events-all: $(trace-events-files)
 
 $(obj)/generated-helpers-wrappers.h: $(obj)/generated-helpers-wrappers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers-wrappers.h-timestamp: $(trace-events-files) $(BUILD_DIR)/config-host.mak $(tracetool-y)
+$(obj)/generated-helpers-wrappers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=tcg-helper-wrapper-h \
@@ -26,7 +26,7 @@ $(obj)/generated-helpers-wrappers.h-timestamp: $(trace-events-files) $(BUILD_DIR
 
 $(obj)/generated-helpers.h: $(obj)/generated-helpers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers.h-timestamp: $(trace-events-files) $(BUILD_DIR)/config-host.mak $(tracetool-y)
+$(obj)/generated-helpers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=tcg-helper-h \
@@ -35,7 +35,7 @@ $(obj)/generated-helpers.h-timestamp: $(trace-events-files) $(BUILD_DIR)/config-
 
 $(obj)/generated-helpers.c: $(obj)/generated-helpers.c-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers.c-timestamp: $(trace-events-files) $(BUILD_DIR)/config-host.mak $(tracetool-y)
+$(obj)/generated-helpers.c-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=tcg-helper-c \
@@ -49,7 +49,7 @@ target-obj-y += generated-helpers.o
 
 $(obj)/generated-tcg-tracers.h: $(obj)/generated-tcg-tracers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-tcg-tracers.h-timestamp: $(trace-events-files) $(BUILD_DIR)/config-host.mak $(tracetool-y)
+$(obj)/generated-tcg-tracers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=tcg-h \
-- 
2.9.2
