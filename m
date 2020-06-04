Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E714C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBAFD2065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ieXFvT7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAFD2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjdF-0000rt-Ti
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaD-0004y2-8v
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:42:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52547 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgjaB-0000mn-GQ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:42:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49cx6C2j6mz9sT2; Thu,  4 Jun 2020 16:42:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591252947;
 bh=b70ol4AwRW7a/EV2Hqh72SgevUQ9Bq55LIXZW4grnkk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ieXFvT7H9I8p+r5TBGCmnbCqn9mmAjMqFdhCy7CEoWvRW398LeE9UnLiJAbfFrv/2
 mdzqBCMWSPovIHs0+rXihDnEI6Yc0rvTAcEcb5oZg7jq8h4xC3SsvNixvDMeEwfCtS
 f/OmUkAokjmrBA38pmc8Vs3AwwErptIaeJUzob9w=
From: David Gibson <david@gibson.dropbear.id.au>
To: rth@twiddle.net, pbonzini@redhat.com, ekabkost@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 2/9] target/i386: sev: Move local structure definitions into
 .c file
Date: Thu,  4 Jun 2020 16:42:12 +1000
Message-Id: <20200604064219.436242-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604064219.436242-1-david@gibson.dropbear.id.au>
References: <20200604064219.436242-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 02:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: brijesh.singh@amd.com, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, dgilbert@redhat.com,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Neither QSevGuestInfo nor SEVState (not to be confused with SevState) is
used anywhere outside target/i386/sev.c, so they might as well live in
there rather than in a (somewhat) exposed header.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/sev.c      | 44 ++++++++++++++++++++++++++++++++++++++++++
 target/i386/sev_i386.h | 44 ------------------------------------------
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 2312510cf2..53def5f41a 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -29,6 +29,50 @@
 #include "trace.h"
 #include "migration/blocker.h"
 
+#define TYPE_QSEV_GUEST_INFO "sev-guest"
+#define QSEV_GUEST_INFO(obj)                  \
+    OBJECT_CHECK(QSevGuestInfo, (obj), TYPE_QSEV_GUEST_INFO)
+
+typedef struct QSevGuestInfo QSevGuestInfo;
+
+/**
+ * QSevGuestInfo:
+ *
+ * The QSevGuestInfo object is used for creating a SEV guest.
+ *
+ * # $QEMU \
+ *         -object sev-guest,id=sev0 \
+ *         -machine ...,memory-encryption=sev0
+ */
+struct QSevGuestInfo {
+    Object parent_obj;
+
+    char *sev_device;
+    uint32_t policy;
+    uint32_t handle;
+    char *dh_cert_file;
+    char *session_file;
+    uint32_t cbitpos;
+    uint32_t reduced_phys_bits;
+};
+
+struct SEVState {
+    QSevGuestInfo *sev_info;
+    uint8_t api_major;
+    uint8_t api_minor;
+    uint8_t build_id;
+    uint32_t policy;
+    uint64_t me_mask;
+    uint32_t cbitpos;
+    uint32_t reduced_phys_bits;
+    uint32_t handle;
+    int sev_fd;
+    SevState state;
+    gchar *measurement;
+};
+
+typedef struct SEVState SEVState;
+
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
 
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
index 4f193642ac..8eb7de1bef 100644
--- a/target/i386/sev_i386.h
+++ b/target/i386/sev_i386.h
@@ -28,10 +28,6 @@
 #define SEV_POLICY_DOMAIN       0x10
 #define SEV_POLICY_SEV          0x20
 
-#define TYPE_QSEV_GUEST_INFO "sev-guest"
-#define QSEV_GUEST_INFO(obj)                  \
-    OBJECT_CHECK(QSevGuestInfo, (obj), TYPE_QSEV_GUEST_INFO)
-
 extern bool sev_enabled(void);
 extern uint64_t sev_get_me_mask(void);
 extern SevInfo *sev_get_info(void);
@@ -40,44 +36,4 @@ extern uint32_t sev_get_reduced_phys_bits(void);
 extern char *sev_get_launch_measurement(void);
 extern SevCapability *sev_get_capabilities(void);
 
-typedef struct QSevGuestInfo QSevGuestInfo;
-
-/**
- * QSevGuestInfo:
- *
- * The QSevGuestInfo object is used for creating a SEV guest.
- *
- * # $QEMU \
- *         -object sev-guest,id=sev0 \
- *         -machine ...,memory-encryption=sev0
- */
-struct QSevGuestInfo {
-    Object parent_obj;
-
-    char *sev_device;
-    uint32_t policy;
-    uint32_t handle;
-    char *dh_cert_file;
-    char *session_file;
-    uint32_t cbitpos;
-    uint32_t reduced_phys_bits;
-};
-
-struct SEVState {
-    QSevGuestInfo *sev_info;
-    uint8_t api_major;
-    uint8_t api_minor;
-    uint8_t build_id;
-    uint32_t policy;
-    uint64_t me_mask;
-    uint32_t cbitpos;
-    uint32_t reduced_phys_bits;
-    uint32_t handle;
-    int sev_fd;
-    SevState state;
-    gchar *measurement;
-};
-
-typedef struct SEVState SEVState;
-
 #endif
-- 
2.26.2


