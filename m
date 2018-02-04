Received: from eggs.gnu.org ([2001:4830:134:3::10]:40938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiE77-0006bw-3y
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 01:49:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiE72-0003lV-VO
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 01:49:21 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:45061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiE72-0003kG-Pc
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 01:49:16 -0500
Received: by mail-pg0-x242.google.com with SMTP id m136so16071344pga.12
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 22:49:16 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	c1sm10622114pfa.119.2018.02.03.22.49.13 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 03 Feb 2018 22:49:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 22:49:11 -0800
Message-Id: <20180204064911.9828-2-richard.henderson@linaro.org>
In-Reply-To: <20180204064911.9828-1-richard.henderson@linaro.org>
References: <20180204064911.9828-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] tests: Enable boot-serial-test for hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/boot-serial-test.c | 1 +
 tests/Makefile.include   | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 418c5b92dc..ea87a80be7 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -87,6 +87,7 @@ static testdef_t tests[] = {
       sizeof(kernel_plml605), kernel_plml605 },
     { "moxie", "moxiesim", "", "TT", sizeof(bios_moxiesim), 0, bios_moxiesim },
     { "arm", "raspi2", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
+    { "hppa", "hppa", "", "SeaBIOS wants SYSTEM HALT" },
 
     { NULL }
 };
diff --git a/tests/Makefile.include b/tests/Makefile.include
index ca82e0c0cc..83def6994c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -299,6 +299,8 @@ gcov-files-x86_64-y = $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-files-i386-y)
 
 check-qtest-alpha-y = tests/boot-serial-test$(EXESUF)
 
+check-qtest-hppa-y = tests/boot-serial-test$(EXESUF)
+
 check-qtest-m68k-y = tests/boot-serial-test$(EXESUF)
 
 check-qtest-microblaze-y = tests/boot-serial-test$(EXESUF)
-- 
2.14.3
