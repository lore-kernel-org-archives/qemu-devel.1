Received: from eggs.gnu.org ([2001:4830:134:3::10]:42162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cdJVd-0005PX-LY
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cdJVc-0006P7-BP
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:29:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cdJVc-0006Ok-5D
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:29:48 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 13 Feb 2017 16:29:40 +0000
Message-Id: <20170213162940.13428-3-stefanha@redhat.com>
In-Reply-To: <20170213162940.13428-1-stefanha@redhat.com>
References: <20170213162940.13428-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] Makefile: Make "install" depend on
 "trace-events-all"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Fam Zheng <famz@redhat.com>

We install this file to data dir but since 0ab8ed18 it's no longer
required by any objects during "make". List it explicitly as a depended
target of install and fix the broken "make install" command.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20170204143245.15974-1-famz@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4b72a4c..b993741 100644
--- a/Makefile
+++ b/Makefile
@@ -589,7 +589,7 @@ endif
 endif
 
 
-install: all $(if $(BUILD_DOCS),install-doc) \
+install: all $(if $(BUILD_DOCS),install-doc) $(BUILD_DIR)/trace-events-all \
 install-datadir install-localstatedir
 ifneq ($(TOOLS),)
 	$(call install-prog,$(subst qemu-ga,qemu-ga$(EXESUF),$(TOOLS)),$(DESTDIR)$(bindir))
-- 
2.9.3
