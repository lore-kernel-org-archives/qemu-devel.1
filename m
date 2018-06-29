Received: from eggs.gnu.org ([2001:4830:134:3::10]:56182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZ0Nk-00083o-Jn
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZ0Ni-0006Mw-W4
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:40 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fZ0Ni-0006LK-O8
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:38 -0400
Received: by mail-wm0-x236.google.com with SMTP id n17-v6so3300424wmh.2
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 13:52:38 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 29 Jun 2018 21:52:15 +0100
Message-Id: <20180629205232.27190-5-alex.bennee@linaro.org>
In-Reply-To: <20180629205232.27190-1-alex.bennee@linaro.org>
References: <20180629205232.27190-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/21] .gitignore: add .gcov files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

These are temporary files generated on gcov runs and shouldn't be
included in the source tree.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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
