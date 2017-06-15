Received: from eggs.gnu.org ([2001:4830:134:3::10]:41222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPQ-0000E9-KD
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPP-0007k9-V7
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:52 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSPP-0007jH-Mm
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:51 -0400
Received: by mail-wr0-x241.google.com with SMTP id z45so2764942wrb.2
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:51 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:56 +0200
Message-Id: <1497523981-38449-37-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 36/41] include/exec/poison: Add missing TARGET
 defines
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

Since we've got some new CPU targets in QEMU during the last months
and years, we've got some new TARGET_xxx defines now which should
be marked as poisoned for common code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1497468113-2874-2-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/poison.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 3ca7929..9356d5f 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -12,17 +12,28 @@
 #pragma GCC poison TARGET_CRIS
 #pragma GCC poison TARGET_LM32
 #pragma GCC poison TARGET_M68K
+#pragma GCC poison TARGET_MICROBLAZE
 #pragma GCC poison TARGET_MIPS
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
+#pragma GCC poison TARGET_TRICORE
+#pragma GCC poison TARGET_UNICORE32
+#pragma GCC poison TARGET_XTENSA
 
+#pragma GCC poison TARGET_NAME
+#pragma GCC poison TARGET_SUPPORTS_MTTCG
 #pragma GCC poison TARGET_WORDS_BIGENDIAN
 #pragma GCC poison BSWAP_NEEDED
 
-- 
1.8.3.1
