Received: from eggs.gnu.org ([2001:4830:134:3::10]:38466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coPSs-00020i-TW
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coPSp-00061H-Nu
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:04:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1coPSp-000619-IW
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:04:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 16 Mar 2017 15:04:26 +0800
Message-Id: <20170316070427.17120-3-stefanha@redhat.com>
In-Reply-To: <20170316070427.17120-1-stefanha@redhat.com>
References: <20170316070427.17120-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] makefile: generate trace-events-all upfront
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Files should not be created in the build dir during the
'make install' phase. List 'trace-events-all' as a
generated file so that it gets created upfront during
build.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20170228122901.24520-3-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a8024c0..6291764 100644
--- a/Makefile
+++ b/Makefile
@@ -82,6 +82,7 @@ endif
 
 GENERATED_FILES += $(TRACE_HEADERS)
 GENERATED_FILES += $(TRACE_SOURCES)
+GENERATED_FILES += $(BUILD_DIR)/trace-events-all
 
 trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
 
@@ -592,8 +593,7 @@ endif
 endif
 
 
-install: all $(if $(BUILD_DOCS),install-doc) $(BUILD_DIR)/trace-events-all \
-install-datadir install-localstatedir
+install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-localstatedir
 ifneq ($(TOOLS),)
 	$(call install-prog,$(subst qemu-ga,qemu-ga$(EXESUF),$(TOOLS)),$(DESTDIR)$(bindir))
 endif
-- 
2.9.3
