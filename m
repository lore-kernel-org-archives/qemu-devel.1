Received: from eggs.gnu.org ([2001:4830:134:3::10]:37492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYqc1-0002vo-I8
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:59:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYqZx-00005U-Qq
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:56:58 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:53190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gYqZx-00004t-JP
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:56:53 -0500
Received: by mail-wm1-x32b.google.com with SMTP id m1so11884997wml.2
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 02:56:53 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Dec 2018 10:56:37 +0000
Message-Id: <20181217105650.27361-3-alex.bennee@linaro.org>
In-Reply-To: <20181217105650.27361-1-alex.bennee@linaro.org>
References: <20181217105650.27361-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 02/15] MAINTAINERS: update status of FPU
 emulation
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

Given I've spent a fair amount of time around this code now I'm
putting myself forward as a maintainer. Also given that the code has
been extensively re-written and has testing and new incoming features
it is probably more than just Odd Fixes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 83c127f0d6..d676c73f88 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -127,9 +127,11 @@ F: include/sysemu/cpus.h
 FPU emulation
 M: Aurelien Jarno <aurelien@aurel32.net>
 M: Peter Maydell <peter.maydell@linaro.org>
-S: Odd Fixes
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Maintained
 F: fpu/
 F: include/fpu/
+F: tests/fp/
 
 Alpha
 M: Richard Henderson <rth@twiddle.net>
-- 
2.17.1
