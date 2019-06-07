Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8503AC28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49750208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49750208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47578 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBPf-0000TO-Cl
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41452)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hZAuU-0000w1-O7
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hZAuP-0002xE-H4
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:11:42 -0400
Received: from mail01.asahi-net.or.jp ([202.224.55.13]:59748)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hZAuP-0002tb-4V
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:11:37 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail01.asahi-net.or.jp (Postfix) with ESMTPA id CC69C123C02;
 Fri,  7 Jun 2019 18:11:32 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 8982C240086;
 Fri,  7 Jun 2019 18:11:32 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 18:11:16 +0900
Message-Id: <20190607091116.49044-25-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190607091116.49044-1-ysato@users.sourceforge.jp>
References: <20190607091116.49044-1-ysato@users.sourceforge.jp>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.13
Subject: [Qemu-devel] [PATCH v17 24/24] target/rx: Remove suffix in cpu
 class.
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

New CPUs should not be suffixed like other devices.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/hw/rx/rx62n.h | 2 +-
 target/rx/cpu.h       | 3 +--
 target/rx/cpu.c       | 8 ++------
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
index 5f6912fe46..e57c5ec091 100644
--- a/include/hw/rx/rx62n.h
+++ b/include/hw/rx/rx62n.h
@@ -30,7 +30,7 @@
 #include "target/rx/cpu.h"
 #include "qemu/units.h"
 
-#define TYPE_RX62N "rx62n"
+#define TYPE_RX62N "rx62n-mcu"
 #define TYPE_RX62N_CPU RX_CPU_TYPE_NAME(TYPE_RX62N)
 #define RX62N(obj) OBJECT_CHECK(RX62NState, (obj), TYPE_RX62N)
 
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index a0b6975963..080ea604a3 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -164,8 +164,7 @@ static inline RXCPU *rx_env_get_cpu(CPURXState *env)
 
 #define ENV_OFFSET offsetof(RXCPU, env)
 
-#define RX_CPU_TYPE_SUFFIX "-" TYPE_RX_CPU
-#define RX_CPU_TYPE_NAME(model) model RX_CPU_TYPE_SUFFIX
+#define RX_CPU_TYPE_NAME(model) model
 #define CPU_RESOLVING_TYPE TYPE_RX_CPU
 
 extern const char rx_crname[][6];
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 41fe1de4bb..d8c662b231 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -72,9 +72,8 @@ static void rx_cpu_reset(CPUState *s)
 static void rx_cpu_list_entry(gpointer data, gpointer user_data)
 {
     const char *typename = object_class_get_name(OBJECT_CLASS(data));
-    int len = strlen(typename) - strlen(RX_CPU_TYPE_SUFFIX);
 
-    qemu_printf("  %.*s\n", len, typename);
+    qemu_printf("  %s\n",  typename);
 }
 
 void rx_cpu_list(void)
@@ -89,11 +88,8 @@ void rx_cpu_list(void)
 static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
-    char *typename;
 
-    typename = g_strdup_printf(RX_CPU_TYPE_NAME("%s"), cpu_model);
-    oc = object_class_by_name(typename);
-    g_free(typename);
+    oc = object_class_by_name(cpu_model);
 
     if (oc == NULL ||
         object_class_is_abstract(oc) ||
-- 
2.11.0


