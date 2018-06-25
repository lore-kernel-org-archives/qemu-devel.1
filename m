Received: from eggs.gnu.org ([2001:4830:134:3::10]:56760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXPX4-0004wv-OR
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXPX3-0008Cs-SX
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:19:42 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:33530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fXPX3-0008CW-Lu
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:19:41 -0400
Received: by mail-wm0-x233.google.com with SMTP id z6-v6so12195666wma.0
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 04:19:41 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 25 Jun 2018 12:19:29 +0100
Message-Id: <20180625111935.26108-5-alex.bennee@linaro.org>
In-Reply-To: <20180625111935.26108-1-alex.bennee@linaro.org>
References: <20180625111935.26108-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 04/10] .gitignore: add .gcov files
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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
