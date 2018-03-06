Received: from eggs.gnu.org ([2001:4830:134:3::10]:57485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et7Dj-0002jZ-CI
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et7Di-0000GP-Az
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:41:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36061 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1et7Di-0000Fh-78
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:41:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D8DF84221
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 07:40:59 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Mar 2018 08:40:49 +0100
Message-Id: <20180306074053.22856-4-kraxel@redhat.com>
In-Reply-To: <20180306074053.22856-1-kraxel@redhat.com>
References: <20180306074053.22856-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] build: enable audio modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Add audio/ to common-obj-m variable.

Also run both audio and ui variables through unnest-vars.
This avoids sdl.mo (exists in both audio/ and ui/) name clashes.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Makefile      | 4 ++++
 Makefile.objs | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 4df1f67fe4..20abbe66ad 100644
--- a/Makefile
+++ b/Makefile
@@ -425,6 +425,10 @@ dummy := $(call unnest-vars,, \
                 io-obj-y \
                 common-obj-y \
                 common-obj-m \
+                ui-obj-y \
+                ui-obj-m \
+                audio-obj-y \
+                audio-obj-m \
                 trace-obj-y)
 
 include $(SRC_PATH)/tests/Makefile.include
diff --git a/Makefile.objs b/Makefile.objs
index 69413d33b1..ffae665ea9 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -104,6 +104,7 @@ common-obj-$(CONFIG_LINUX) += fsdev/
 common-obj-y += migration/
 
 common-obj-y += audio/
+common-obj-m += audio/
 common-obj-y += hw/
 
 common-obj-y += replay/
-- 
2.9.3
