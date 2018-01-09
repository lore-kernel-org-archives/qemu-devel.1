Received: from eggs.gnu.org ([2001:4830:134:3::10]:43126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYw65-0002x1-8E
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYw64-0003lr-JB
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:45:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eYw64-0003lM-DV
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:45:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8287B25B89
	for <qemu-devel@nongnu.org>; Tue,  9 Jan 2018 15:45:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  9 Jan 2018 13:45:15 -0200
Message-Id: <20180109154519.25634-4-ehabkost@redhat.com>
In-Reply-To: <20180109154519.25634-1-ehabkost@redhat.com>
References: <20180109154519.25634-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] i386: Add spec-ctrl CPUID bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

Add the feature name and a CPUID_7_0_EDX_SPEC_CTRL macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 1 +
 target/i386/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 07f47997d6..de387c1311 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -667,6 +667,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
+#define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
 
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9f4f949899..1be1642eb2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -459,7 +459,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "spec-ctrl", NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid_eax = 7,
-- 
2.14.3
