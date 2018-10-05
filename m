Received: from eggs.gnu.org ([2001:4830:134:3::10]:38507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UQX-0000NC-Q1
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UQU-0003oU-Pn
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:13 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8UQU-0003lh-Ij
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:10 -0400
Received: by mail-ot1-x342.google.com with SMTP id p23so1882901otf.11
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 11:02:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Oct 2018 13:01:55 -0500
Message-Id: <20181005180201.11387-3-richard.henderson@linaro.org>
In-Reply-To: <20181005180201.11387-1-richard.henderson@linaro.org>
References: <20181005180201.11387-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 2/8] gitmodules: add berkeley's softfloat +
 testfloat version 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

These are BSD-licensed so we can add them as submodules.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitmodules                   | 6 ++++++
 tests/fp/berkeley-softfloat-3 | 1 +
 tests/fp/berkeley-testfloat-3 | 1 +
 3 files changed, 8 insertions(+)
 create mode 160000 tests/fp/berkeley-softfloat-3
 create mode 160000 tests/fp/berkeley-testfloat-3

diff --git a/.gitmodules b/.gitmodules
index d108478e0a..a48d2a764c 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -43,3 +43,9 @@
 [submodule "roms/u-boot-sam460ex"]
 	path = roms/u-boot-sam460ex
 	url = git://git.qemu.org/u-boot-sam460ex.git
+[submodule "tests/fp/berkeley-testfloat-3"]
+	path = tests/fp/berkeley-testfloat-3
+	url = git://github.com/cota/berkeley-testfloat-3
+[submodule "tests/fp/berkeley-softfloat-3"]
+	path = tests/fp/berkeley-softfloat-3
+	url = git://github.com/cota/berkeley-softfloat-3
diff --git a/tests/fp/berkeley-softfloat-3 b/tests/fp/berkeley-softfloat-3
new file mode 160000
index 0000000000..b64af41c32
--- /dev/null
+++ b/tests/fp/berkeley-softfloat-3
@@ -0,0 +1 @@
+Subproject commit b64af41c3276f97f0e181920400ee056b9c88037
diff --git a/tests/fp/berkeley-testfloat-3 b/tests/fp/berkeley-testfloat-3
new file mode 160000
index 0000000000..ca9fa2ba05
--- /dev/null
+++ b/tests/fp/berkeley-testfloat-3
@@ -0,0 +1 @@
+Subproject commit ca9fa2ba05625ba929958f163b01747e07dd39cc
-- 
2.17.1
