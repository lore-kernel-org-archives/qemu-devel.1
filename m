Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22FFC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2F820674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opoZ+f1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2F820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE4Qg-0001zK-KJ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 01:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jE4O0-00072M-M6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jE4Nz-0002dm-BK
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:03:28 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:35995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jE4Nw-0002CO-JM; Tue, 17 Mar 2020 01:03:24 -0400
Received: by mail-pj1-x1043.google.com with SMTP id nu11so6642855pjb.1;
 Mon, 16 Mar 2020 22:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=amo7tEPKLKAI4LAECmJK7fRz7zN6KrBvaL5VCtrB9GE=;
 b=opoZ+f1PJBBHSae1VU28wafJiBg312u0Y32s6moJ7ne8JRs3Imom3SpQMpe+LlFajp
 aOFMyTvrDQNvXgSNVo7zODg2qWU2AVY8W38eocq26WikWvoG11PxjseSWTsWEHuVX471
 lrQKXNFmiUd+SmGkEOd9AztW2z/RxB+ehvk4ulhCgmi1ZqAWHMIxMbGnDAM19yGKiUXV
 TuWuavT2zwmDvd+C7gBeWBYH8iqgp/TD0zDpntDzVClOTiO1qhOHtwH/Hn0zqJuVAnBx
 zWRu3xkmgWgfMqMv/bt8+awSRV4nG6Tdg0gd8ODO26L9HigthdE9QumUaMLi1Fs9vNv1
 8Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=amo7tEPKLKAI4LAECmJK7fRz7zN6KrBvaL5VCtrB9GE=;
 b=H36kD9csnktEQf4x+yO0Bk7vr+3+BvAjtAYQryGsyEFI3i8Ra5yHbz8ePhJ0B4KlPk
 guiN0+MjMVbxEGyF2mHla04Ll9KxDv857HhKyKzLELVWqEkvgPTuuG1MFnUSH+frIajE
 AJDlRoYlTpz7nQcou1dvRa4LUPVkh4Fa6Ctrfp8+eT9OQ27uYmM68mkgl6KkHbZONW8Q
 jwAP8Vr8eDIpKJpxVb89Wq9eYGO6+goIfqnKa0kPNbkDkJLTjhJ1HIuDKCR1tDaCF7kk
 V5hMFRUWy5jGBbgwWSs8wXTzzJpwJVyugldKmlbTljiBxLW+Gzm6U/WwjC7aLN7uV5S6
 hkIw==
X-Gm-Message-State: ANhLgQ2uO0jJe0MK+XpISvnpSjiwsQfDyA9XRuWqLHzLWUKs1pR026gH
 lYmmBfFoPv3yRYTUO62fg4CZbtmWcrE=
X-Google-Smtp-Source: ADFU+vtpZOSjgzNkEQr8+pR7DKgFMi5P/OoljaJw2SYbUvPB64vcjvtfXWmy5n4bnwKk3XeXwHp/hQ==
X-Received: by 2002:a17:902:b58b:: with SMTP id
 a11mr2716505pls.9.1584421403442; 
 Mon, 16 Mar 2020 22:03:23 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (14-202-190-183.tpgi.com.au.
 [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id k67sm994803pga.91.2020.03.16.22.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 22:03:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH 3/5] ppc/spapr: Add FWNMI machine check delivery warnings
Date: Tue, 17 Mar 2020 15:02:13 +1000
Message-Id: <20200317050215.159334-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200317050215.159334-1-npiggin@gmail.com>
References: <20200317050215.159334-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add some messages which explain problems and guest misbehaviour that
may be difficult to diagnose in rare cases of machine checks.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_events.c | 4 ++++
 hw/ppc/spapr_rtas.c   | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 05337f0671..d35151eeb0 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -807,6 +807,8 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
     /* get rtas addr from fdt */
     rtas_addr = spapr_get_rtas_addr();
     if (!rtas_addr) {
+        warn_report("FWNMI: Unable to deliver machine check to guest: "
+                    "rtas_addr not found.");
         qemu_system_guest_panicked(NULL);
         g_free(ext_elog);
         return;
@@ -848,6 +850,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
          * that CPU called "ibm,nmi-interlock")
          */
         if (spapr->fwnmi_machine_check_interlock == cpu->vcpu_id) {
+            warn_report("FWNMI: Unable to deliver machine check to guest: "
+                        "nested machine check.");
             qemu_system_guest_panicked(NULL);
             return;
         }
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 29abe66d01..12cd09701c 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -462,6 +462,10 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
     }
 
     if (spapr->fwnmi_machine_check_addr == -1) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "FWNMI: ibm,nmi-interlock RTAS called with FWNMI not "
+                       "registered.\n");
+
         /* NMI register not called */
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
-- 
2.23.0


