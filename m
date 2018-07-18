Received: from eggs.gnu.org ([2001:4830:134:3::10]:55392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKa-00038Q-Kg
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKZ-00014o-Bo
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:12 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffjKZ-00012y-5L
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id g6-v6so4059160wrp.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 03:05:11 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 18 Jul 2018 11:04:58 +0100
Message-Id: <20180718100505.7546-4-alex.bennee@linaro.org>
In-Reply-To: <20180718100505.7546-1-alex.bennee@linaro.org>
References: <20180718100505.7546-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 03/10] docker: add a placeholder for
 handling non-x86 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We want to keep all our variations in one place. This is that place.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 22adf6ac73..7d13ddd497 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -139,6 +139,18 @@ DOCKER_USER_IMAGES += debian-powerpc-user
 # tests due to missing system call: 249 which causes an abort
 DOCKER_PARTIAL_IMAGES += debian-powerpc-user-cross
 
+# Modifications for non-x86 hosts
+#
+# While docker itself is now multiarch aware and will generally do the
+# right thing (assuming the source also supports multiple
+# architectures) there are still variations we need to take into
+# account. These are all done here.
+
+ifneq ($(ARCH),x86_64)
+
+
+endif
+
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES)), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
-- 
2.17.1
