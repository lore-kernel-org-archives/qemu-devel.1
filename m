Received: from eggs.gnu.org ([2001:4830:134:3::10]:37561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cigtz-0002TW-SU
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cigtz-0004S2-04
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:29:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cigty-0004Rh-RJ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:29:10 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 28 Feb 2017 12:29:01 +0000
Message-Id: <20170228122901.24520-3-berrange@redhat.com>
In-Reply-To: <20170228122901.24520-1-berrange@redhat.com>
References: <20170228122901.24520-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] makefile: generate trace-events-all upfront
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Files should not be created in the build dir during the
'make install' phase. List 'trace-events-all' as a
generated file so that it gets created upfront during
build.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
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
