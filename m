Received: from eggs.gnu.org ([2001:4830:134:3::10]:54797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jI-0008Lc-M8
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6jH-0007yE-O5
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:36 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:54424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fb6jH-0007xI-HO
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:03:35 -0400
Received: by mail-wm0-x233.google.com with SMTP id i139-v6so12061384wmf.4
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:03:35 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  5 Jul 2018 17:03:14 +0100
Message-Id: <20180705160329.30386-6-alex.bennee@linaro.org>
In-Reply-To: <20180705160329.30386-1-alex.bennee@linaro.org>
References: <20180705160329.30386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 05/20] .gitignore: add .gcov files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

These are temporary files generated on gcov runs and shouldn't be
included in the source tree.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

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
