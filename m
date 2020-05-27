Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8AFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98EA420787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UfsnTr2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98EA420787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdoqQ-0002uT-NX
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdoln-0001DY-2v; Wed, 27 May 2020 01:38:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58441 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdolm-0001ek-2p; Wed, 27 May 2020 01:38:26 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49X03r3Qwyz9sTN; Wed, 27 May 2020 15:38:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590557896;
 bh=ETSGs96TSR7w2U8n99R4HifZTQ3fmStvJb44mdxdVls=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UfsnTr2E2+KBrLhrugnzrB59nH1WDl4Tz1kg+Q1ZW2+YNeHUx90oOla3742s4Go+G
 EhYHVATEb1EWLThCyodlc4FGY2q0wfbhixZyfHAwjvUv2QWe+PVcktBARSh84mZN2l
 E56ElhMAKVo6ebJeeAtS2j+mk4HyC6Fty7eEgd6E=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 12/15] hw/pci-bridge/dec: Remove dead debug code
Date: Wed, 27 May 2020 15:38:06 +1000
Message-Id: <20200527053809.356168-13-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527053809.356168-1-david@gibson.dropbear.id.au>
References: <20200527053809.356168-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:38:16
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
Cc: lvivier@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Remove debug code never used since added in commit e1c6bbabee30.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200525033910.26166-1-f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-bridge/dec.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
index 3ae2f788a4..952bc71122 100644
--- a/hw/pci-bridge/dec.c
+++ b/hw/pci-bridge/dec.c
@@ -32,16 +32,6 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 
-/* debug DEC */
-//#define DEBUG_DEC
-
-#ifdef DEBUG_DEC
-#define DEC_DPRINTF(fmt, ...)                               \
-    do { printf("DEC: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DEC_DPRINTF(fmt, ...)
-#endif
-
 #define DEC_21154(obj) OBJECT_CHECK(DECState, (obj), TYPE_DEC_21154)
 
 typedef struct DECState {
-- 
2.26.2


