Received: from eggs.gnu.org ([2001:4830:134:3::10]:35286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPMUO-0004VK-Aj
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 01:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPMUJ-000608-Qb
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 01:23:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPMUJ-0005y3-KX
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 01:23:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0340C83F42
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 05:23:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 26 Jun 2017 07:22:52 +0200
Message-Id: <1498454578-18709-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1498454578-18709-1-git-send-email-thuth@redhat.com>
References: <1498454578-18709-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/7] include/exec/poison: Add some more
 missing TARGET and CONFIG defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

The defines of some *-linux-user targets were still missing.

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/exec/poison.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 5ffed4d..7a025b2 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -7,13 +7,16 @@
 
 #pragma GCC poison TARGET_I386
 #pragma GCC poison TARGET_X86_64
+#pragma GCC poison TARGET_AARCH64
 #pragma GCC poison TARGET_ALPHA
 #pragma GCC poison TARGET_ARM
 #pragma GCC poison TARGET_CRIS
+#pragma GCC poison TARGET_HPPA
 #pragma GCC poison TARGET_LM32
 #pragma GCC poison TARGET_M68K
 #pragma GCC poison TARGET_MICROBLAZE
 #pragma GCC poison TARGET_MIPS
+#pragma GCC poison TARGET_ABI_MIPSN32
 #pragma GCC poison TARGET_ABI_MIPSO32
 #pragma GCC poison TARGET_MIPS64
 #pragma GCC poison TARGET_ABI_MIPSN64
@@ -28,10 +31,12 @@
 #pragma GCC poison TARGET_SH4
 #pragma GCC poison TARGET_SPARC
 #pragma GCC poison TARGET_SPARC64
+#pragma GCC poison TARGET_TILEGX
 #pragma GCC poison TARGET_TRICORE
 #pragma GCC poison TARGET_UNICORE32
 #pragma GCC poison TARGET_XTENSA
 
+#pragma GCC poison TARGET_HAS_BFLT
 #pragma GCC poison TARGET_NAME
 #pragma GCC poison TARGET_SUPPORTS_MTTCG
 #pragma GCC poison TARGET_WORDS_BIGENDIAN
@@ -65,6 +70,7 @@
 #pragma GCC poison CONFIG_ARM_A64_DIS
 #pragma GCC poison CONFIG_ARM_DIS
 #pragma GCC poison CONFIG_CRIS_DIS
+#pragma GCC poison CONFIG_HPPA_DIS
 #pragma GCC poison CONFIG_I386_DIS
 #pragma GCC poison CONFIG_LM32_DIS
 #pragma GCC poison CONFIG_M68K_DIS
-- 
1.8.3.1
