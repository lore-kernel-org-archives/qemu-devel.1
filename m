Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2DFC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47B22067C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLJ0b1JJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47B22067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5yr-0006xZ-St
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kD5qX-0001b0-Ix; Tue, 01 Sep 2020 08:57:09 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:41835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kD5qV-0002o4-Os; Tue, 01 Sep 2020 08:57:09 -0400
Received: by mail-qt1-x843.google.com with SMTP id t20so738474qtr.8;
 Tue, 01 Sep 2020 05:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0Dg2hr+Km79kta4Vbo921CtoCw0M28LSvQZWr2OX06o=;
 b=nLJ0b1JJpiYHL1Kmgp8cgZm05Jy9SjjnxYGhrYEEEG+M0IhcOgtgpHLUN/adTN4F3T
 XrjA3Kp3Pl0FRBWMuBgsCdli3UhvMy9E/HIRUhp22FKu9h8SstnBf9XKCJ1v5LxtDgPt
 Gv/5DkAPP6WpzRsYfgUrGT8I26p6OJ54c2aidYb+RPyQDvqaxpU6t2LI1/X/dlHZd40i
 pB9lWVl34DZADLkIh5ruylqNVCkz0mVvBRY+moEGpZcxkRpgFlIbcyzxNPALyknGk1X2
 IlXATIU6vU80apcQIDBM/6rJ4CQE37PdQKVse1IrCiwK2tNRS2GmhjCgQwMIof8GPduZ
 NKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0Dg2hr+Km79kta4Vbo921CtoCw0M28LSvQZWr2OX06o=;
 b=VZnnamAkdj7aLRzt54eT58MhWVTNFgy5Mr01uE7u29Y/aMd3u77eKVq9obtXKpuI8p
 7c+V5OFOfeO5LTU5Zl8cMFjVt3+eDSf/g8oP6kX/UjzAnNN2qArZIpRpxY6US73Yf+qn
 ZfvOyOeEvPo9hovJFZUqh7hAXyZ+dlaG6EnA4a0mwjrulcz4G0TvvMHSr++3Xft4X9Vx
 iCapkhkkB1eumpfsJYBMb6ysIzGszuOL/aWttVc2OJvC2f4EtqC5WX+8021XxkcvUR6N
 yTG8z9bNzK3E3U2G9ee2nWAuLUxVR+hu55VZgXTlL6YVezIfWg2PfJmTci7FvE0zsdHn
 Ut8Q==
X-Gm-Message-State: AOAM532Eo8tZDyyum84Yve0aw/2hRPts1XaiWqp0Ds/bUOA/BOY4foYz
 vwC3k4OyS4vuqKULBqMTryivrrzoiI501A==
X-Google-Smtp-Source: ABdhPJyjHI22maHuZj4Nu78N30tCOAZbtGlbn/gbZUzB6gVQTfCMadpCg7lxIFQ0BD5kOTFMwEUK3g==
X-Received: by 2002:ac8:614b:: with SMTP id d11mr1579767qtm.271.1598965026369; 
 Tue, 01 Sep 2020 05:57:06 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:6be:f6e3:c671:cefe:b943])
 by smtp.gmail.com with ESMTPSA id q7sm1430164qkf.35.2020.09.01.05.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 05:57:05 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/7] spapr_hcall: h_home_node_associativity now reads
 numa_assoc_array
Date: Tue,  1 Sep 2020 09:56:45 -0300
Message-Id: <20200901125645.118026-8-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901125645.118026-1-danielhb413@gmail.com>
References: <20200901125645.118026-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x843.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

home_node_associativity reply now uses the associativity
values for tcpu->node_id provided by numa_assoc_array.

This will avoid further changes in this code when numa_assoc_array
changes values, but it won't be enough to prevent further changes
if (falar aqui q se mudar o tamanho do array tem q mexer nessa
funcao tambem, falar q a macro associativity() deixa a automacao
de tudo mto unreadable)

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_hcall.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index c1d01228c6..2ec30efdcb 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1878,9 +1878,13 @@ static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
                                               target_ulong opcode,
                                               target_ulong *args)
 {
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     target_ulong flags = args[0];
     target_ulong procno = args[1];
     PowerPCCPU *tcpu;
+    uint32_t assoc_domain1;
+    uint32_t assoc_domain2;
+    uint32_t assoc_domain3;
     int idx;
 
     /* only support procno from H_REGISTER_VPA */
@@ -1893,13 +1897,21 @@ static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
         return H_P2;
     }
 
+    /*
+     * Index 0 is the ibm,associativity size of the node,
+     * which isn't relevant here.
+     */
+    assoc_domain1 = smc->numa_assoc_array[tcpu->node_id][1];
+    assoc_domain2 = smc->numa_assoc_array[tcpu->node_id][2];
+    assoc_domain3 = smc->numa_assoc_array[tcpu->node_id][3];
+
     /* sequence is the same as in the "ibm,associativity" property */
 
     idx = 0;
 #define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
                              ((uint64_t)(b) & 0xffffffff))
-    args[idx++] = ASSOCIATIVITY(0, 0);
-    args[idx++] = ASSOCIATIVITY(0, tcpu->node_id);
+    args[idx++] = ASSOCIATIVITY(assoc_domain1, assoc_domain2);
+    args[idx++] = ASSOCIATIVITY(assoc_domain3, tcpu->node_id);
     args[idx++] = ASSOCIATIVITY(procno, -1);
     for ( ; idx < 6; idx++) {
         args[idx] = -1;
-- 
2.26.2


