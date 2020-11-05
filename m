Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE21DC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EB52065C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RVNE6zxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EB52065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaWIw-0006hV-Bf
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 22:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kaWHN-0005NY-Ih; Wed, 04 Nov 2020 22:49:41 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:42279 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kaWHL-0003wX-DQ; Wed, 04 Nov 2020 22:49:41 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CRTzb2bsCz9sTD; Thu,  5 Nov 2020 14:49:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1604548171;
 bh=OjxTdqml0JkNTFyhEHrZhmtd+j41envfmwID7MLyDvw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RVNE6zxv4ioloRbaj6RzMDQEAtIg0vhNR3CB7nSkLfDn/pU4kXOU+e1rAJUVqN5Kt
 J8/Q3+QcLYEWRL52FQNXkS4R9WLSM+nmlwQhQ/Oo6DtwhoAvHt9r3nMS5cNcI19m3q
 Y+mrSZMT7mD3Z2py7X7EqdS8sAeySfRbJAdGwx0c=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 2/3] spapr: Drop dead code in spapr_reallocate_hpt()
Date: Thu,  5 Nov 2020 14:49:18 +1100
Message-Id: <20201105034919.393653-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105034919.393653-1-david@gibson.dropbear.id.au>
References: <20201105034919.393653-1-david@gibson.dropbear.id.au>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

Sometimes QEMU needs to allocate the HPT in userspace, namely with TCG
or PR KVM. This is performed with qemu_memalign() because of alignment
requirements. Like glib's allocators, its behaviour is to abort on OOM
instead of returning NULL.

This could be changed to qemu_try_memalign(), but in the specific case
of spapr_reallocate_hpt(), the outcome would be to terminate QEMU anyway
since no HPT means no MMU for the guest. Drop the dead code instead.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160398562892.32380.15006707861753544263.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 227075103e..12a012d9dd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1522,12 +1522,6 @@ int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **errp)
         int i;
 
         spapr->htab = qemu_memalign(size, size);
-        if (!spapr->htab) {
-            error_setg_errno(errp, errno,
-                             "Could not allocate HPT of order %d", shift);
-            return -ENOMEM;
-        }
-
         memset(spapr->htab, 0, size);
         spapr->htab_shift = shift;
 
-- 
2.28.0


