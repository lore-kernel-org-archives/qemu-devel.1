Received: from eggs.gnu.org ([2001:4830:134:3::10]:47731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLDrb-0005u6-I9
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLDrZ-0000PH-HM
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:21:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dLDrZ-0000P0-Ai
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:21:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63BE685542
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 19:21:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Jun 2017 21:21:50 +0200
Message-Id: <1497468113-2874-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1497468113-2874-1-git-send-email-thuth@redhat.com>
References: <1497468113-2874-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] include/exec/poison: Add missing TARGET
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

Since we've got some new CPU targets in QEMU during the last months
and years, we've got some new TARGET_xxx defines now which should
be marked as poisoned for common code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
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
