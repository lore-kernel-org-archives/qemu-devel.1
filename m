Received: from eggs.gnu.org ([2001:4830:134:3::10]:43919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ij-0005Fo-HZ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8if-0007xC-8E
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8ie-0007wA-Ul
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:53 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JF521064216
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:52 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyhx2hbf8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:51 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:49 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:43 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-23-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 22/54] i386: Add spec-ctrl CPUID bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Eduardo Habkost <ehabkost@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

Add the feature name and a CPUID_7_0_EDX_SPEC_CTRL macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180109154519.25634-4-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit a2381f0934432ef2cd47a335348ba8839632164c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 63279526a1..dddd62207c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -458,7 +458,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "spec-ctrl", NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid_eax = 7,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 03de74a8d3..8bf9879f3e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -642,6 +642,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
+#define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
 
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
-- 
2.11.0
