Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98636C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258E620789
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYugD1hK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258E620789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhnH-0000Cw-4y
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhi3-0002gt-JK
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:48:31 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhi2-0003lD-1t
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:48:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id k10so12273228wru.6
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oFWLyt6kWARZltFpBlg1mJTxorWVjFMh4mO9BoqNxBs=;
 b=PYugD1hKhEzYHvUXlbxLS8m9aNtp/jmcAXFLx8LlWwyk7dfWwI+zpkQ19MU/L0tvEX
 4rPvHeHVSil6JUWsCLQ4f14xcJmdyPzGamGC30bmSM4JYYqJXoPD0tavL8EwpSB9Kyjf
 /pMgW6ryoRk2ru1CfDAztF207MDPlBgEtXpmbK01IS1bDY7Z5ELycy7hG71BXU4SaKC7
 Ow0H9LaUwo6uVilgYMYuDcHi/8XD4EWwk+Uwwz2lNfIxY4zhjvrq80H8qqlg7uWoXaxZ
 BHRRAKwM61O6CB+AVbbwf2oar+TfviblgqBOMq7XhxpR8seyyBu8p+DMI51l6kT+jdCh
 YNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=oFWLyt6kWARZltFpBlg1mJTxorWVjFMh4mO9BoqNxBs=;
 b=euAmZJ8dBNvKYHf0NO3Ceoj4fkeV/UDnw6YQgV++qKGaLbhY/Zv2BDrDV8H4iN/vn3
 W2jCDrdoYOuCpMPMtERIXd/FEqfqO8AM2/9YGz78gAAkmzF64Vag+PbAQTHqVP9FjgDW
 +wSc1k469K9BHFm7XKJmpeelj0QmulOGPkHfL5L4kbxvhZ3OohzERc1GfSBYauWeuv4M
 WMmNR5KCPCURrtBOskndXn9yS5cu9k536MKj6tRdySZR/yET+n4stSEDNGCl1PFEVwbU
 k/urWdSPDaXu/O2qQwqi2v2zAOUZslJ0UqN1KPj5PBzBSKkTzaC2pQE37t5QehAcNd8/
 z3Pg==
X-Gm-Message-State: AOAM531LkPTKCkHrdz/0HaZ+vZtbPhNZtYrFiO0NYzjf1FO0bEEkYl75
 i7lNohgLCKxTFGOy2o8cRBcBb1YpZTY=
X-Google-Smtp-Source: ABdhPJyMrfrOURnL5Hk8+Mh1yxwNkL+XN30U1X/f+55ZiyucPIZf20apkJ4GDKnkyZfyJ7Dhhbr43g==
X-Received: by 2002:adf:90a2:: with SMTP id i31mr3698157wri.276.1601970508005; 
 Tue, 06 Oct 2020 00:48:28 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id a17sm3195272wra.29.2020.10.06.00.48.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:48:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: avoid theoretical leak on MCE injection
Date: Tue,  6 Oct 2020 09:48:29 +0200
Message-Id: <20201006074829.488968-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

g_strdup_printf is used twice to write to the same variable, which
can theoretically cause a leak.  In practice, it is extremely
unlikely that a guest is seeing a recursive MCE and has disabled
CR4.MCE between the first and the second error, but we can fix it
and we can also make a slight improvement on the logic: CR4.MCE=0
causes a triple fault even for a non-recursive machine check, so
let's place its test first.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 32fa21a7bb..f64379367d 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -908,16 +908,14 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
             return;
         }
 
-        if (recursive) {
-            need_reset = true;
-            msg = g_strdup_printf("CPU %d: Previous MCE still in progress, "
-                                  "raising triple fault", cs->cpu_index);
-        }
-
         if (!(cenv->cr[4] & CR4_MCE_MASK)) {
             need_reset = true;
             msg = g_strdup_printf("CPU %d: MCE capability is not enabled, "
                                   "raising triple fault", cs->cpu_index);
+        } else if (recursive) {
+            need_reset = true;
+            msg = g_strdup_printf("CPU %d: Previous MCE still in progress, "
+                                  "raising triple fault", cs->cpu_index);
         }
 
         if (need_reset) {
-- 
2.26.2


