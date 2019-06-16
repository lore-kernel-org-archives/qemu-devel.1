Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499D0C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 14:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177AC2147A
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 14:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177AC2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40362 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcWI5-0002k3-BP
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 10:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36366)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hcW9Y-0005Kz-8V
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hcW9W-0002NB-V9
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:29:04 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:55650)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hcW9W-00025o-IN
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:29:02 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail02.asahi-net.or.jp (Postfix) with ESMTPA id 0AD3D42A52;
 Sun, 16 Jun 2019 23:28:47 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id C7C26240087;
 Sun, 16 Jun 2019 23:28:46 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Sun, 16 Jun 2019 23:28:17 +0900
Message-Id: <20190616142836.10614-6-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190616142836.10614-1-ysato@users.sourceforge.jp>
References: <20190616142836.10614-1-ysato@users.sourceforge.jp>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.14
Subject: [Qemu-devel] [PATCH v20 05/24] target/rx: simplify
 rx_cpu_class_by_name
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

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 target/rx/cpu.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index a6dde613ab..e3d76af55d 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -72,9 +72,8 @@ static void rx_cpu_reset(CPUState *s)
 static void rx_cpu_list_entry(gpointer data, gpointer user_data)
 {
     const char *typename = object_class_get_name(OBJECT_CLASS(data));
-    int len = strlen(typename) - strlen(RX_CPU_TYPE_SUFFIX);
 
-    qemu_printf("%.*s\n", len, typename);
+    qemu_printf("%s\n", typename);
 }
 
 void rx_cpu_list(void)
@@ -88,25 +87,12 @@ void rx_cpu_list(void)
 static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
-    char *typename;
 
     oc = object_class_by_name(cpu_model);
-    if (oc != NULL && object_class_dynamic_cast(oc, TYPE_RX_CPU) != NULL &&
-        !object_class_is_abstract(oc)) {
-        return oc;
-    }
-
-    typename = g_strdup_printf(RX_CPU_TYPE_NAME("%s"), cpu_model);
-    oc = object_class_by_name(typename);
-    if (oc != NULL && object_class_is_abstract(oc)) {
+    if (object_class_dynamic_cast(oc, TYPE_RX_CPU) == NULL ||
+        object_class_is_abstract(oc)) {
         oc = NULL;
     }
-    g_free(typename);
-
-    if (!oc) {
-        /* default to rx62n */
-        oc = object_class_by_name(TYPE_RX62N_CPU);
-    }
 
     return oc;
 }
-- 
2.11.0


