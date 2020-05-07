Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61343C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC4520753
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RePgC9sU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC4520753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWYo3-0003gp-AR
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 01:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYi1-0007p9-QM; Thu, 07 May 2020 01:04:33 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52145 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYi0-0007wr-RE; Thu, 07 May 2020 01:04:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49HhFq6Cr5z9sTV; Thu,  7 May 2020 15:04:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588827855;
 bh=RLcrEp5ciotLnSvcyKdcp6FX0xjzer2/eNqhxMGJdjk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RePgC9sUoMJjwQX2sla0RmuP2O0hNXP2JyRm5tTcmPfIOkc9YFCrIsuEBAFSlrdVT
 ZoO2dwPLN2phGNjZ6J0MnyBaGuB/LnsKX4ikmplorvG01xc0QIkdiUAOMO79fFsEDE
 dRhftli3fX+NcvwISQbYXLssKOXOQGTZE7p6JVK4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 17/18] spapr_nvdimm: Tweak error messages
Date: Thu,  7 May 2020 15:02:27 +1000
Message-Id: <20200507050228.802395-18-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507050228.802395-1-david@gibson.dropbear.id.au>
References: <20200507050228.802395-1-david@gibson.dropbear.id.au>
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, npiggin@gmail.com, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The restrictions here (which are checked at pre-plug time) are PAPR
specific, rather than being inherent to the NVDIMM devices.  Adjust the
error messages to be clearer about this.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_nvdimm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 9abcdcc26b..81410aa63f 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -39,13 +39,13 @@ void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
 
     if (object_property_get_int(OBJECT(nvdimm), NVDIMM_LABEL_SIZE_PROP,
                                 &error_abort) == 0) {
-        error_setg(errp, "NVDIMM device requires label-size to be set");
+        error_setg(errp, "PAPR requires NVDIMM devices to have label-size set");
         return;
     }
 
     if (size % SPAPR_MINIMUM_SCM_BLOCK_SIZE) {
-        error_setg(errp, "NVDIMM memory size excluding the label area"
-                   " must be a multiple of %" PRIu64 "MB",
+        error_setg(errp, "PAPR requires NVDIMM memory size (excluding label)"
+                   " to be a multiple of %" PRIu64 "MB",
                    SPAPR_MINIMUM_SCM_BLOCK_SIZE / MiB);
         return;
     }
-- 
2.26.2


