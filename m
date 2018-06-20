Received: from eggs.gnu.org ([2001:4830:134:3::10]:54991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVd2N-0007y9-DR
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVd2K-0002kU-Qa
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:39 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:52981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVd2K-0002k8-K8
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:36 -0400
Received: by mail-wm0-x241.google.com with SMTP id p126-v6so5990738wmb.2
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 06:20:36 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 20 Jun 2018 14:20:29 +0100
Message-Id: <20180620132032.12952-3-alex.bennee@linaro.org>
In-Reply-To: <20180620132032.12952-1-alex.bennee@linaro.org>
References: <20180620132032.12952-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/5] .gitignore: add .gcov files
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

These are temporary files generated on gcov runs and shouldn't be
included in the source tree.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 9da3b3e626..5668d02782 100644
--- a/.gitignore
+++ b/.gitignore
@@ -155,6 +155,7 @@
 .sdk
 *.gcda
 *.gcno
+*.gcov
 /pc-bios/bios-pq/status
 /pc-bios/vgabios-pq/status
 /pc-bios/optionrom/linuxboot.asm
-- 
2.17.1
