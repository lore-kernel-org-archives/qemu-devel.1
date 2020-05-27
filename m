Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124F0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC65620787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UywGzckC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC65620787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdos2-0005cC-0Q
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdoln-0001DW-3K; Wed, 27 May 2020 01:38:27 -0400
Received: from ozlabs.org ([203.11.71.1]:54151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdoll-0001eg-Sr; Wed, 27 May 2020 01:38:26 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49X03r1D5Pz9sT8; Wed, 27 May 2020 15:38:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590557896;
 bh=NroXLSplW0fTmfDs0p6T8iGM8Pup0FipWinzYIQ5+Ho=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UywGzckCJdLypLhjvdL03+VVOkYorcuyjK582idPg4ijKWj4wQgJhhILA7XN2d0BE
 LYCn1hZBAzlouiaxCqOyXOpsk+n7GZMs7hwSQVZUKuQEnlXz+DR+xgyF6Wyhf7701y
 IuAbiMCa4pOzh2lpoKnDsuP/xgd3wrDTH2Gif1H8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 09/15] target/ppc: Add missing braces in
 ppc_radix64_partition_scoped_xlate()
Date: Wed, 27 May 2020 15:38:03 +1000
Message-Id: <20200527053809.356168-10-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

As per CODING_STYLE.

Fixes: d04ea940c597 "target/ppc: Add support for Radix partition-scoped translation"
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <158941062665.240484.2663106458734800894.stgit@bahia.lan>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-radix64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 07f956c986..fb7dfe25ba 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -286,8 +286,9 @@ static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu, int rwx,
                               pate.dw0 & PRTBE_R_RPDS, h_raddr, h_page_size,
                               &pte, &fault_cause, &pte_addr) ||
         ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, h_prot, true)) {
-        if (pde_addr) /* address being translated was that of a guest pde */
+        if (pde_addr) { /* address being translated was that of a guest pde */
             fault_cause |= DSISR_PRTABLE_FAULT;
+        }
         if (cause_excp) {
             ppc_radix64_raise_hsi(cpu, rwx, eaddr, g_raddr, fault_cause);
         }
-- 
2.26.2


