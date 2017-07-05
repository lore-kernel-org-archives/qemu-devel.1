Received: from eggs.gnu.org ([2001:4830:134:3::10]:46304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWZ-0004NS-0D
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWX-0007TN-FF
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:58 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWX-0007S0-9z
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:57 -0400
Received: by mail-wm0-x243.google.com with SMTP id p204so30533639wmg.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:14:57 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:09 +0200
Message-Id: <1499238885-26161-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/42] include/exec/poison: Add some more
 missing TARGET and CONFIG defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The defines of some *-linux-user targets were still missing.

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1498454578-18709-2-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
