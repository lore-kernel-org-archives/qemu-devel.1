Received: from eggs.gnu.org ([2001:4830:134:3::10]:41432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dNC5G-0002Eh-TB
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 01:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dNC5F-0003Dm-08
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 01:52:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dNC5E-0003Df-Ph
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 01:52:12 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 20 Jun 2017 07:52:00 +0200
Message-Id: <1497937927-19738-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1497937927-19738-1-git-send-email-thuth@redhat.com>
References: <1497937927-19738-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/8] include/exec/poison: Add missing TARGET
 defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>

Since we've got some new CPU targets in QEMU during the last months
and years, we've got some new TARGET_xxx defines now which should
be marked as poisoned for common code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/exec/poison.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 3ca7929..859bd56 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -7,22 +7,38 @@
 
 #pragma GCC poison TARGET_I386
 #pragma GCC poison TARGET_X86_64
+#pragma GCC poison TARGET_AARCH64
 #pragma GCC poison TARGET_ALPHA
 #pragma GCC poison TARGET_ARM
 #pragma GCC poison TARGET_CRIS
+#pragma GCC poison TARGET_HPPA
 #pragma GCC poison TARGET_LM32
 #pragma GCC poison TARGET_M68K
+#pragma GCC poison TARGET_MICROBLAZE
 #pragma GCC poison TARGET_MIPS
+#pragma GCC poison TARGET_ABI_MIPSN32
+#pragma GCC poison TARGET_ABI_MIPSO32
 #pragma GCC poison TARGET_MIPS64
+#pragma GCC poison TARGET_ABI_MIPSN64
+#pragma GCC poison TARGET_MOXIE
+#pragma GCC poison TARGET_NIOS2
 #pragma GCC poison TARGET_OPENRISC
 #pragma GCC poison TARGET_PPC
 #pragma GCC poison TARGET_PPCEMB
 #pragma GCC poison TARGET_PPC64
 #pragma GCC poison TARGET_ABI32
+#pragma GCC poison TARGET_S390X
 #pragma GCC poison TARGET_SH4
 #pragma GCC poison TARGET_SPARC
 #pragma GCC poison TARGET_SPARC64
+#pragma GCC poison TARGET_TILEGX
+#pragma GCC poison TARGET_TRICORE
+#pragma GCC poison TARGET_UNICORE32
+#pragma GCC poison TARGET_XTENSA
 
+#pragma GCC poison TARGET_HAS_BFLT
+#pragma GCC poison TARGET_NAME
+#pragma GCC poison TARGET_SUPPORTS_MTTCG
 #pragma GCC poison TARGET_WORDS_BIGENDIAN
 #pragma GCC poison BSWAP_NEEDED
 
-- 
1.8.3.1
