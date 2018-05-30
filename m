Received: from eggs.gnu.org ([2001:4830:134:3::10]:37303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNywX-0008Nf-K5
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNywW-0001vp-GS
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:01 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:53879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fNywW-0001vG-9Y
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:00 -0400
Received: by mail-wm0-x234.google.com with SMTP id a67-v6so46904202wmf.3
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 04:07:00 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 30 May 2018 12:06:49 +0100
Message-Id: <20180530110655.22022-3-alex.bennee@linaro.org>
In-Reply-To: <20180530110655.22022-1-alex.bennee@linaro.org>
References: <20180530110655.22022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 2/8] docker: sort images list displayed by
 'make docker'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

we can now directly see different version sort consecutively.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index ef1a3e62eb..50cd51a54e 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -4,7 +4,7 @@
 
 DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
-DOCKER_IMAGES := $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))
+DOCKER_IMAGES := $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
 DOCKER_CCACHE_DIR := $$HOME/.cache/qemu-docker-ccache
-- 
2.17.0
