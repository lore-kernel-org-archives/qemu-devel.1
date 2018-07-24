Received: from eggs.gnu.org ([2001:4830:134:3::10]:59995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuT-0000rl-OF
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuP-0006P9-5D
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:17 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:55762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhuuO-0006Of-Um
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:13 -0400
Received: by mail-wm0-x243.google.com with SMTP id f21-v6so2054848wmc.5
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 03:51:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jul 2018 11:50:53 +0100
Message-Id: <20180724105109.8392-2-alex.bennee@linaro.org>
In-Reply-To: <20180724105109.8392-1-alex.bennee@linaro.org>
References: <20180724105109.8392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/17] tests/.gitignore: don't ignore docker
 tests
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

The .gitignore was being a little over enthusiastic hiding files.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/.gitignore b/tests/.gitignore
index 08e2df1ce1..72c18aaab0 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -9,6 +9,7 @@ qht-bench
 rcutorture
 test-*
 !test-*.c
+!docker/test-*
 test-qapi-commands.[ch]
 test-qapi-events.[ch]
 test-qapi-types.[ch]
-- 
2.17.1
