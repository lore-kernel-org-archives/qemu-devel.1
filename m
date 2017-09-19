Received: from eggs.gnu.org ([2001:4830:134:3::10]:60517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfp-0004dQ-HF
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfl-0005nb-MH
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:45 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfl-0005n8-DR
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:41 -0400
Received: by mail-wm0-x242.google.com with SMTP id m127so3758157wmm.0
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:41 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:39 +0200
Message-Id: <1505824179-21541-51-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 50/50] docker: fix creation of archives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

The pixman submodule does not exist anymore, and its removal broke
docker-based tests.  Fix it.

Cc: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/Makefile.include | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index aaab1a4..aa566aa 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -34,7 +34,6 @@ $(DOCKER_SRC_COPY):
 	@mkdir $@
 	$(call make-archive-maybe, $(SRC_PATH), $@/qemu.tgz)
 	$(call make-archive-maybe, $(SRC_PATH)/dtc, $@/dtc.tgz)
-	$(call make-archive-maybe, $(SRC_PATH)/pixman, $@/pixman.tgz)
 	$(call quiet-command, cp $(SRC_PATH)/tests/docker/run $@/run, \
 		"COPY","RUNNER")
 
-- 
1.8.3.1
