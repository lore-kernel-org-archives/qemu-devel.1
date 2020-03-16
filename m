Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B68C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853DE20719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qylmKxlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853DE20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsjf-0004AF-O0
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jDqi6-0007Xa-UW
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jDqi5-0003hk-Ux
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:27:18 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:51649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jDqi2-00039i-Ur; Mon, 16 Mar 2020 10:27:15 -0400
Received: by mail-pj1-x1044.google.com with SMTP id hg10so4504244pjb.1;
 Mon, 16 Mar 2020 07:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WGscwySBJ+mmGr8x/aCZBlSdJwehrHHaibadIEnOpac=;
 b=qylmKxlKYVPmUd7CNMmuSDb2FENNyhCy/diuVxqFsvm5sspqnTie1L7DtgIp+xE6bG
 9QYaFPl2Ao9wVa0llzunLtqRWWU9AwAC5UyMys6QHG/y0JDis7T9lRPhzGWYdtRKpC2g
 8VcmIhS7V/hDoVwNhwW4bwgvXR1G/t7IpxqeYt/AbTWvfFMTPdNKA0JV5kQnrbLnZ8gX
 T7kNvPBPCrqM9NuUyAsQOKwh9/TZEYk1rhzqj4a431etdQG3Uhmp3FcHwZ4ebKazLtJ2
 hVz9JDDT39PDkShRip3YCr0fkidWPAZxYuWBJjnjc5X+bTuTxiMn9lBrGZifa6dGwt1L
 KyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WGscwySBJ+mmGr8x/aCZBlSdJwehrHHaibadIEnOpac=;
 b=HqVC5zN86IHjp/WBavlQqxDUK8WakQeZp4SrxpgbCjsgKAweDi1Bt+1LNsWeKG398g
 nwB6OwvhoR2WCzgYlVGDlWQLSCFpYPwlTkuFn0MVqEnpWJN454o3FhNzefqqqe9PVvB9
 ol7u2jQsUlTjVa1qhFb+ZwXEX0SRaw1VdFmy3pjFSS/M+6I5dL5BDYgirIeBYTBzH0pt
 N59ywKYkAmvLROlvQ7AiJPYtTohueCo+rzIPUHjAnBS/cQ2EI2sovcL4lZPXYixBdNGr
 UuS/RMC/QN1jkfy8La+F5o6zzLlpMeID6nirIvgAYzItdHnm7k/qU9IhBA8pXkQ7Tu5r
 p1Qw==
X-Gm-Message-State: ANhLgQ071MBl/spu4plzdxETMR5gjsmeZGE477Paq1X/mvilz/jLEGaN
 KiX3hfblm1AZog9vacEzb/LbO1mskMA=
X-Google-Smtp-Source: ADFU+vturzh+vwilJ7ryTaK4b7Oup0VEh4pR//wnrdYxQANxyIicFYAGzikRkHIydCiO1Wp6m5c+vQ==
X-Received: by 2002:a17:902:b617:: with SMTP id
 b23mr27776794pls.285.1584368833846; 
 Mon, 16 Mar 2020 07:27:13 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.63.160.49])
 by smtp.gmail.com with ESMTPSA id v1sm45564pjy.35.2020.03.16.07.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 07:27:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v2 5/8] ppc/spapr: Allow FWNMI on TCG
Date: Tue, 17 Mar 2020 00:26:10 +1000
Message-Id: <20200316142613.121089-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200316142613.121089-1-npiggin@gmail.com>
References: <20200316142613.121089-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There should no longer be a reason to prevent TCG providing FWNMI.
System Reset interrupts are generated to the guest with nmi monitor
command and H_SIGNAL_SYS_RESET. Machine Checks can not be injected
currently, but this could be implemented with the mce monitor cmd
similarly to i386.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_caps.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index f626d769a0..679ae7959f 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -516,10 +516,7 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
         return; /* Disabled by default */
     }
 
-    if (tcg_enabled()) {
-        warn_report("Firmware Assisted Non-Maskable Interrupts(FWNMI) not "
-                    "supported in TCG");
-    } else if (kvm_enabled()) {
+    if (kvm_enabled()) {
         if (kvmppc_set_fwnmi() < 0) {
             error_setg(errp, "Firmware Assisted Non-Maskable Interrupts(FWNMI) "
                              "not supported by KVM");
-- 
2.23.0


