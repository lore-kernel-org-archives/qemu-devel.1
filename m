Received: from eggs.gnu.org ([2001:4830:134:3::10]:41243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPR-0000FC-Gh
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPQ-0007ko-Qa
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:53 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSPQ-0007kG-KU
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:52 -0400
Received: by mail-wr0-x243.google.com with SMTP id y25so548668wrd.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:52 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:57 +0200
Message-Id: <1497523981-38449-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 37/41] include/exec/poison: Mark some CONFIG
 defines as poisoned, too
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

These are defined in config-target.h and thus should never be
used in common code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1497468113-2874-3-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/poison.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 9356d5f..5ffed4d 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -61,5 +61,25 @@
 #pragma GCC poison CPU_INTERRUPT_TGT_INT_1
 #pragma GCC poison CPU_INTERRUPT_TGT_INT_2
 
+#pragma GCC poison CONFIG_ALPHA_DIS
+#pragma GCC poison CONFIG_ARM_A64_DIS
+#pragma GCC poison CONFIG_ARM_DIS
+#pragma GCC poison CONFIG_CRIS_DIS
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
