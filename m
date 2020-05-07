Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BD9C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A1320735
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIWUJA3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A1320735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWf1x-0002PX-Py
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 07:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1jWf14-0001nF-JI; Thu, 07 May 2020 07:48:38 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1jWf13-00066T-LV; Thu, 07 May 2020 07:48:38 -0400
Received: by mail-pl1-x643.google.com with SMTP id t16so1964559plo.7;
 Thu, 07 May 2020 04:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IBT7B6CvDHf8I4ku+FpRwqydxDEojpZEtoiwU805UXI=;
 b=mIWUJA3WqFO2opScDNSUd6zJbsblza9F8ZruBxcJwL2i2CDvUzPsUBlqcEY5enHAl/
 0noJcAx0OE4df2BE/i0nkk3qZ/NCf/ErPZfXDfaglC8URjOe1T+bp1lfOCoYGRnDq1ZL
 ZTXIYuXhVCu9k6iTKT0hAd/RYM7tOE7rluJnfivHsywX/n6qxlwnSEQTMa94G/WhbM89
 HE7PyJBM8PdFiz5FbfF5gT4T/omR+CJLbQ2WGumnXfA2+l9EsprIJUSFaNdrs3UzNaNZ
 mn4BSURzd5ShMBADfZ0ascOvxxF3KuLXbtBeCLMNVTwSY335aqpSWnAG54vCK5Twy8ys
 WuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IBT7B6CvDHf8I4ku+FpRwqydxDEojpZEtoiwU805UXI=;
 b=GBxaIp5RQlm2Oi33hkM4sGiv7fVugsKwDeJqZpU/QhMsdwGEItAdBvRQF3fbnJRbr2
 xORfIxBOJ6cMb134aaPBmkSGvVjmTJvF+ha04Uty2Ay4S0wfPw0pPZGp5XYOdre/YX5X
 +TDEdBEzHfqXrw+pTEyzMtj0Hm+v96GcqY9eS+vlSrErRkYweC2Hfsb2F1KbFh0SjYrq
 TMitQf8FEO63+4ky/R/vgmdKzwwD3ZOU21TRoHJRETsx+GMTBUWY5jBLzaYKmGCFaooX
 nQrnuMoZOUkwkFRsYNtRifM/juECev8wdB6xCmKerGPwYD8W54Hy1lLAzzyqzYBd1Um4
 D+8g==
X-Gm-Message-State: AGi0PuZePuDmw0ztESqey7rpbpAfxRbQ9q8PXggKAxKTTdJ1H+jBzcWz
 taSraVIj9NJL2GkuXC8GukKCHm9Z
X-Google-Smtp-Source: APiQypIEfBh9T/QdQyc5vt8d/0TtAXkFQGNXhF8g4hEkL1grzJcDIIN8F2YEwPkNMzHHrG0f8P6qmg==
X-Received: by 2002:a17:902:403:: with SMTP id
 3mr12895545ple.102.1588852115101; 
 Thu, 07 May 2020 04:48:35 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-214-199.tpgi.com.au. [61.68.214.199])
 by smtp.gmail.com with ESMTPSA id 6sm4723446pfj.123.2020.05.07.04.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 04:48:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH] ppc/pnv: Fix NMI system reset SRR1 value
Date: Thu,  7 May 2020 21:48:24 +1000
Message-Id: <20200507114824.788942-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit a77fed5bd926 ("ppc/pnv: Add support for NMI interface") got the
SRR1 setting wrong for sresets that hit outside of power-save states.

Fix this, better documenting the source for the bit definitions.

Fixes: a77fed5bd926 ("ppc/pnv: Add support for NMI interface") got the
Cc: Cédric Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Thanks to Cedric for pointing out concerns with a previous MCE patch
that unearthed this as well. Linux does not actually care what these
SRR1[42:45] bits look like for non-powersave sresets, but we should
follow documented behaviour as far as possible.

 hw/ppc/pnv.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index a3b7a8d0ff..1b4748ce6d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1986,12 +1986,26 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
 
     cpu_synchronize_state(cs);
     ppc_cpu_do_system_reset(cs);
-    /*
-     * SRR1[42:45] is set to 0100 which the ISA defines as implementation
-     * dependent. POWER processors use this for xscom triggered interrupts,
-     * which come from the BMC or NMI IPIs.
-     */
-    env->spr[SPR_SRR1] |= PPC_BIT(43);
+    if (env->spr[SPR_SRR1] & PPC_BITMASK(46, 47)) {
+        /*
+	 * Power-save wakeups, as indicated by non-zero SRR1[46:47] put the
+	 * wakeup reason in SRR1[42:45], system reset is indicated with 0b0100
+	 * (PPC_BIT(43)).
+	 */
+        if (!(env->spr[SPR_SRR1] & PPC_BIT(43))) {
+            warn_report("ppc_cpu_do_system_reset does not set system reset wakeup reason");
+            env->spr[SPR_SRR1] |= PPC_BIT(43);
+        }
+    } else {
+        /*
+	 * For non-powersave system resets, SRR1[42:45] are defined to be
+	 * implementation-dependent. The POWER9 User Manual specifies that
+	 * an external (SCOM driven, which may come from a BMC nmi command or
+	 * another CPU requesting a NMI IPI) system reset exception should be
+	 * 0b0010 (PPC_BIT(44)).
+         */
+        env->spr[SPR_SRR1] |= PPC_BIT(44);
+    }
 }
 
 static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
-- 
2.23.0


