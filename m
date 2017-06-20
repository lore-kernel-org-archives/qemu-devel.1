Received: from eggs.gnu.org ([2001:4830:134:3::10]:41435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dNC5H-0002Ei-7z
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 01:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dNC5G-0003Dy-63
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 01:52:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dNC5F-0003Dt-Vu
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 01:52:14 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 20 Jun 2017 07:52:01 +0200
Message-Id: <1497937927-19738-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1497937927-19738-1-git-send-email-thuth@redhat.com>
References: <1497937927-19738-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/8] include/exec/poison: Mark some CONFIG
 defines as poisoned, too
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

These are defined in config-target.h and thus should never be
used in common code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/exec/poison.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 859bd56..7a025b2 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -66,5 +66,26 @@
 #pragma GCC poison CPU_INTERRUPT_TGT_INT_1
 #pragma GCC poison CPU_INTERRUPT_TGT_INT_2
 
+#pragma GCC poison CONFIG_ALPHA_DIS
+#pragma GCC poison CONFIG_ARM_A64_DIS
+#pragma GCC poison CONFIG_ARM_DIS
+#pragma GCC poison CONFIG_CRIS_DIS
+#pragma GCC poison CONFIG_HPPA_DIS
+#pragma GCC poison CONFIG_I386_DIS
+#pragma GCC poison CONFIG_LM32_DIS
+#pragma GCC poison CONFIG_M68K_DIS
+#pragma GCC poison CONFIG_MICROBLAZE_DIS
+#pragma GCC poison CONFIG_MIPS_DIS
+#pragma GCC poison CONFIG_MOXIE_DIS
+#pragma GCC poison CONFIG_NIOS2_DIS
+#pragma GCC poison CONFIG_PPC_DIS
+#pragma GCC poison CONFIG_S390_DIS
+#pragma GCC poison CONFIG_SH4_DIS
+#pragma GCC poison CONFIG_SPARC_DIS
+#pragma GCC poison CONFIG_XTENSA_DIS
+
+#pragma GCC poison CONFIG_LINUX_USER
+#pragma GCC poison CONFIG_VHOST_NET
+
 #endif
 #endif
-- 
1.8.3.1
