Received: from eggs.gnu.org ([2001:4830:134:3::10]:44785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb5rJ-000433-GN
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb5rI-00017L-PF
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:35:33 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:38808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb5rI-000178-G4
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:35:32 -0500
Received: by mail-qk0-x241.google.com with SMTP id j185so17028113qkc.5
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 06:35:32 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 15 Jan 2018 11:34:59 -0300
Message-Id: <20180115143500.22631-9-f4bug@amsat.org>
In-Reply-To: <20180115143500.22631-1-f4bug@amsat.org>
References: <20180115143500.22631-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 8/8] docker: fix typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 950ef51d35..a833c68cd8 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -47,7 +47,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 
 docker-image-debian-powerpc-cross: EXTRA_FILES:=$(SRC_PATH)/tests/docker/dockerfiles/debian-apt-fake.sh
 
-# Enforce dependancies for composite images
+# Enforce dependencies for composite images
 docker-image-debian: docker-image-debian9
 docker-image-debian8-mxe: docker-image-debian8
 docker-image-debian-amd64: docker-image-debian9
-- 
2.15.1
