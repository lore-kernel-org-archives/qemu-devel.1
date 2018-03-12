Received: from eggs.gnu.org ([2001:4830:134:3::10]:41478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evKur-00029u-Vo
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evKup-0000kD-2W
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35364 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evKuo-0000iA-Pg
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E09CC4023BB3
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 10:42:48 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Mar 2018 11:42:37 +0100
Message-Id: <20180312104241.24965-5-kraxel@redhat.com>
In-Reply-To: <20180312104241.24965-1-kraxel@redhat.com>
References: <20180312104241.24965-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/8] build: enable audio modules
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
Message-id: 20180306074053.22856-4-kraxel@redhat.com
---
 Makefile      | 4 ++++
 Makefile.objs | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 9a75c48ae0..f198f19ba2 100644
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
index d8b44a2d3c..c6c9b8fc21 100644
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
