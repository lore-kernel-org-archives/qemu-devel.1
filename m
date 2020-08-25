Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FB5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7893F20706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JGPKiPy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7893F20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAWz4-0002iD-KW
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 07:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kAWwY-00075D-Mf; Tue, 25 Aug 2020 07:16:46 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40573)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kAWwV-00054x-Lp; Tue, 25 Aug 2020 07:16:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BbRJl13vqz9sTY; Tue, 25 Aug 2020 21:16:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1598354199;
 bh=4t5MAMMK6onGP/lGX+I5BpEIIRqMhE3LhB0EH21vbJk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JGPKiPy5fQ9NqHxHTQZMbkxFLA2suYwNAb8gFG5Ax8QzE6MVTK6f37uyTuErNAY0s
 Qlji+AoeHDGznfxmt6VrTuAHt4jPva1JTtx93tl1gRzCVI8jFjcwlfxcZnmdD0uKJU
 nJzc6u45rA5886q2J3H1u/Q6rxV8J604GYRvN6lI=
From: David Gibson <david@gibson.dropbear.id.au>
To: ehabkost@redhat.com
Subject: [PATCH 3/3] spapr: Correct type for SPAPR_DRC_PCI
Date: Tue, 25 Aug 2020 21:16:27 +1000
Message-Id: <20200825111627.2007820-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825111627.2007820-1-david@gibson.dropbear.id.au>
References: <20200825111627.2007820-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TYPE_SPAPR_DRC_PCI inherits from TYPE_SPAPR_DRC_PHYSICAL, so its checker
macro should use the corresponding instance type.  We got away with it
because we never actually used that checker macro.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/spapr_drc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 21af8deac1..baaaba3c1f 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -59,7 +59,7 @@
         OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PCI)
 #define SPAPR_DRC_PCI_CLASS(klass) \
         OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_PCI)
-#define SPAPR_DRC_PCI(obj) OBJECT_CHECK(SpaprDrc, (obj), \
+#define SPAPR_DRC_PCI(obj) OBJECT_CHECK(SpaprDrcPhysical, (obj), \
                                         TYPE_SPAPR_DRC_PCI)
 
 #define TYPE_SPAPR_DRC_LMB "spapr-drc-lmb"
-- 
2.26.2


