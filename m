Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83966C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 06:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 523B12076E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 06:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="a3jP50fJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523B12076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joi4p-0005wC-KV
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 02:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joi2O-0001Pm-KN; Fri, 26 Jun 2020 02:40:36 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:33727 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joi2L-0001EO-AJ; Fri, 26 Jun 2020 02:40:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49tS1l5GXJz9sSn; Fri, 26 Jun 2020 16:40:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593153627;
 bh=Zyd+21TNwqZFVKinK1W1M3pyiXHfAgldAX7SQP9sG7M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=a3jP50fJ/pRcUgCgBjAiNZy64+/5W/KehzC+xNUPrDW9YwsW26QsaryGKwMAa7Doa
 JOXoUKGA590YmrbLMpRdFyCWHWPEZyEredUtsDLmmE2DXenDmqcvvURfecN/1JKvQG
 O/1VzUDrD4D+saf7I+GzARIyuRLOYvnqcMz0mWMM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 2/4] spapr: Fix typos in comments and macro indentation
Date: Fri, 26 Jun 2020 16:40:22 +1000
Message-Id: <20200626064024.383996-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626064024.383996-1-david@gibson.dropbear.id.au>
References: <20200626064024.383996-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
Cc: Gustavo Romero <gromero@linux.ibm.com>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gustavo Romero <gromero@linux.ibm.com>

This commit fixes typos in spapr_vio_reg_to_irq() comments and a macro
indentation.

Signed-off-by: Gustavo Romero <gromero@linux.ibm.com>
Message-Id: <1590710681-12873-1-git-send-email-gromero@linux.ibm.com>
Acked-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_vio.c         | 6 +++---
 include/hw/ppc/xive_regs.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 4318ed9638..731080d989 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -420,7 +420,7 @@ static void spapr_vio_busdev_reset(DeviceState *qdev)
 }
 
 /*
- * The register property of a VIO device is defined in livirt using
+ * The register property of a VIO device is defined in libvirt using
  * 0x1000 as a base register number plus a 0x1000 increment. For the
  * VIO tty device, the base number is changed to 0x30000000. QEMU uses
  * a base register number of 0x71000000 and then a simple increment.
@@ -450,7 +450,7 @@ static inline uint32_t spapr_vio_reg_to_irq(uint32_t reg)
 
     } else if (reg >= 0x30000000) {
         /*
-         * VIO tty devices register values, when allocated by livirt,
+         * VIO tty devices register values, when allocated by libvirt,
          * are mapped in range [0xf0 - 0xff], gives us a maximum of 16
          * vtys.
          */
@@ -459,7 +459,7 @@ static inline uint32_t spapr_vio_reg_to_irq(uint32_t reg)
     } else {
         /*
          * Other VIO devices register values, when allocated by
-         * livirt, should be mapped in range [0x00 - 0xef]. Conflicts
+         * libvirt, should be mapped in range [0x00 - 0xef]. Conflicts
          * will be detected when IRQ is claimed.
          */
         irq = (reg >> 12) & 0xff;
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 09f243600c..7879692825 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -71,7 +71,7 @@
  * QW word 2 contains the valid bit at the top and other fields
  * depending on the QW.
  */
-#define TM_WORD2                0x8
+#define   TM_WORD2              0x8
 #define   TM_QW0W2_VU           PPC_BIT32(0)
 #define   TM_QW0W2_LOGIC_SERV   PPC_BITMASK32(1, 31) /* XX 2,31 ? */
 #define   TM_QW1W2_VO           PPC_BIT32(0)
-- 
2.26.2


