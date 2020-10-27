Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6160DC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C689820754
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="e1h5uF/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C689820754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPy5-0007UB-OO
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnX-0001zH-TS; Tue, 27 Oct 2020 10:18:03 -0400
Received: from ozlabs.org ([203.11.71.1]:34313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnV-0007aY-T5; Tue, 27 Oct 2020 10:18:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLDLf5glcz9shm; Wed, 28 Oct 2020 01:17:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603808266;
 bh=LxxlzQPzPW9/phU/w56M/4owvBfBJDEPVYgX6V5xpz4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e1h5uF/O7DnzE6Y0JH0sUxIzJyL2fMy5+Pmhti3sJFzvRAVaHLIyPd6Vt8VuFg5ly
 /7XXZlz199+pQ9ucbBy2YrcyPqetulOuPWOLq8nNiLzBCsmYOSjYqLAjCcKVwkjT2a
 xkxHAJir5G5a6B74K/XiQxyoN8juhnecmhmzzWx4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 07/18] spapr: Drop spapr_delete_vcpu() unused argument
Date: Wed, 28 Oct 2020 01:17:24 +1100
Message-Id: <20201027141735.728821-8-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027141735.728821-1-david@gibson.dropbear.id.au>
References: <20201027141735.728821-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 10:17:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The 'sc' argument is unused. Drop it.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160279671929.1808373.10333672533575251075.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index e4aeb93c02..45eb212187 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -212,7 +212,7 @@ static void spapr_cpu_core_reset_handler(void *opaque)
     spapr_cpu_core_reset(opaque);
 }
 
-static void spapr_delete_vcpu(PowerPCCPU *cpu, SpaprCpuCore *sc)
+static void spapr_delete_vcpu(PowerPCCPU *cpu)
 {
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
 
@@ -233,7 +233,7 @@ static void spapr_cpu_core_unrealize(DeviceState *dev)
         spapr_unrealize_vcpu(sc->threads[i], sc);
     }
     for (i = 0; i < cc->nr_threads; i++) {
-        spapr_delete_vcpu(sc->threads[i], sc);
+        spapr_delete_vcpu(sc->threads[i]);
     }
     g_free(sc->threads);
 }
@@ -345,7 +345,7 @@ err_unrealize:
     }
 err:
     while (--i >= 0) {
-        spapr_delete_vcpu(sc->threads[i], sc);
+        spapr_delete_vcpu(sc->threads[i]);
     }
     g_free(sc->threads);
 }
-- 
2.26.2


