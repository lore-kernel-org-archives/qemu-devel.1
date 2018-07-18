Received: from eggs.gnu.org ([2001:4830:134:3::10]:55429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKc-0003A4-QW
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKY-00012p-Ag
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:14 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffjKY-00011E-3s
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id q10-v6so4057609wrd.4
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 03:05:10 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 18 Jul 2018 11:04:59 +0100
Message-Id: <20180718100505.7546-5-alex.bennee@linaro.org>
In-Reply-To: <20180718100505.7546-1-alex.bennee@linaro.org>
References: <20180718100505.7546-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 04/10] docker: don't include
 docker-arm64-cross on aarch64 hosts
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

Attempting to install the native compiler as a cross compiler rarely
goes well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 7d13ddd497..2cb180ff6c 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -148,6 +148,10 @@ DOCKER_PARTIAL_IMAGES += debian-powerpc-user-cross
 
 ifneq ($(ARCH),x86_64)
 
+ifeq ($(ARCH),aarch64)
+# no point having a cross compiler when it is the native one
+DOCKER_PARTIAL_IMAGES += debian-arm64-cross
+endif
 
 endif
 
-- 
2.17.1
