Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3DCC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 20:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A20C206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 20:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQJTjS/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A20C206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYEe7-000641-4K
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 16:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras.c@gmail.com>)
 id 1jYEdM-0005TZ-Cl; Mon, 11 May 2020 16:02:40 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:42087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leobras.c@gmail.com>)
 id 1jYEdL-0008H9-I6; Mon, 11 May 2020 16:02:40 -0400
Received: by mail-qt1-x842.google.com with SMTP id x12so9124993qts.9;
 Mon, 11 May 2020 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JiciO0iEuz3Ix6g9dsBXqhhpVz+mJsN+11cGOCdnM8I=;
 b=qQJTjS/VHodMqRSsn+LaG2IBWdLDM/SL6/QDhyW3Z1TCFTQHS93wq/qq4YZA1WHHa/
 4AoD+pU0wjoqn4rXePjux0/q74eLbhFwqPXNWH0/aDqHHX5cbFDUD4ix2HDpBBVS/Vve
 Bsvbcb9aaIJqkgQ4aFsAV6p1azqCI6joc9raNJFygiMWGd6RDTyj3Ujt+1useousgLi1
 cg5XXBXqBILMWJPUURmiFnkcAW+TnOjFXWW/HuMHwQ9jFEuKxgFQfuMq1I8b/RDgdB0w
 vO2ML+gvjJet1/I0EgXEPLqlMifRe6GWiCDD9uDmRG1+gJWOy5JWyEv2ATLhwJhEbsfE
 we6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JiciO0iEuz3Ix6g9dsBXqhhpVz+mJsN+11cGOCdnM8I=;
 b=RmSL4zcV6Z9ppedwapJrN/9TCjd/lx4NioVzhFKQLwQQfmiJsRH5nSwztWhqY3Zcbp
 2ygZjM5siXn7gNkIWpO4xYFUNrbe67kKispJgsV51tbyrY4ejXiklhzNMLQ2gEtt8f0F
 2NLml64iRh4tQDBH2hNcz4UmT3iYsdhmX+hxT419XWt6DNmS37TUkpY7X3yuE558nJ8m
 PK9XAq0FeS6c1jvRR9jhMLLo18+64MXKgQSla7lkB3LDD+dPXccExmEKih8cikiAUGaT
 tIqkm82vR/RoGeTV1sRd6g6imOVbsZaCXhHusJagVjtf6mXDk5lLI9rgdKfMwiJea1aF
 t+cw==
X-Gm-Message-State: AGi0PubnPQ28Yf0B6qyikGxGes+/JZ4iTXnbrdWWr1/rH/JE2K5ELHr1
 aUFmV3GmDEfFT7+uzUnMEeY=
X-Google-Smtp-Source: APiQypL2ypwOXa7HrMZ920d3nYaY1BrSiHBMFJCTDwixKVL5GXjbmY+RlfjTzxxgwqnW1v5Nyr4Yhg==
X-Received: by 2002:ac8:6c6:: with SMTP id j6mr18181841qth.194.1589227357767; 
 Mon, 11 May 2020 13:02:37 -0700 (PDT)
Received: from LeoBras.aus.stglabs.ibm.com
 (143-255-224-253.dynamic.desktop.com.br. [143.255.224.253])
 by smtp.gmail.com with ESMTPSA id i23sm9208723qke.65.2020.05.11.13.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 13:02:36 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>,
 Bharata B Rao <bharata.rao@in.ibm.com>
Subject: [RESEND PATCH v3 1/1] ppc/spapr: Add hotremovable flag on DIMM LMBs
 on drmem_v2
Date: Mon, 11 May 2020 17:02:02 -0300
Message-Id: <20200511200201.58537-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=leobras.c@gmail.com; helo=mail-qt1-x842.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Leonardo Bras <leonardo@linux.ibm.com>,
 Bharata B Rao <bharata@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Leonardo Bras <leobras.c@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Leonardo Bras <leonardo@linux.ibm.com>

On reboot, all memory that was previously added using object_add and
device_add is placed in this DIMM area.

The new SPAPR_LMB_FLAGS_HOTREMOVABLE flag helps Linux to put this memory in
the correct memory zone, so no unmovable allocations are made there,
allowing the object to be easily hot-removed by device_del and
object_del.

This new flag was accepted in Power Architecture documentation.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Bharata B Rao <bharata@linux.ibm.com>

---
Changes since v1:
- Flag name changed from SPAPR_LMB_FLAGS_HOTPLUGGED to
	SPAPR_LMB_FLAGS_HOTREMOVABLE
---
 hw/ppc/spapr.c         | 3 ++-
 include/hw/ppc/spapr.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9a2bd501aa..fe662e297e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -446,7 +446,8 @@ static int spapr_dt_dynamic_memory_v2(SpaprMachineState *spapr, void *fdt,
         g_assert(drc);
         elem = spapr_get_drconf_cell(size / lmb_size, addr,
                                      spapr_drc_index(drc), node,
-                                     SPAPR_LMB_FLAGS_ASSIGNED);
+                                     (SPAPR_LMB_FLAGS_ASSIGNED |
+                                      SPAPR_LMB_FLAGS_HOTREMOVABLE);
         QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
         nr_entries++;
         cur_addr = addr + size;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 42d64a0368..93e0d43051 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -880,6 +880,7 @@ int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset);
 #define SPAPR_LMB_FLAGS_ASSIGNED 0x00000008
 #define SPAPR_LMB_FLAGS_DRC_INVALID 0x00000020
 #define SPAPR_LMB_FLAGS_RESERVED 0x00000080
+#define SPAPR_LMB_FLAGS_HOTREMOVABLE 0x00000100
 
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 
-- 
2.25.1


