Received: from eggs.gnu.org ([2001:4830:134:3::10]:47734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLDrb-0005u7-Qa
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLDra-0000Pe-Tj
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:21:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dLDra-0000PR-NL
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:21:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F1C1883A4
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 19:21:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Jun 2017 21:21:51 +0200
Message-Id: <1497468113-2874-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1497468113-2874-1-git-send-email-thuth@redhat.com>
References: <1497468113-2874-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] include/exec/poison: Mark some CONFIG
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

These are defined in config-target.h and thus should never be
used in common code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
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
