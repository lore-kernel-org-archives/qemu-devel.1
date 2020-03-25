Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C89C54FD5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA6020789
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDy00brQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA6020789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH785-0008RZ-6A
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jH72r-0002NT-5Q
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jH72q-0002rm-2Y
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:30:13 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:35805)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jH72n-0002m7-N2; Wed, 25 Mar 2020 10:30:09 -0400
Received: by mail-pl1-x636.google.com with SMTP id g6so870720plt.2;
 Wed, 25 Mar 2020 07:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FriArxnM019D776ImdHSDTVH+8rk+AtrtUiHpYXliLw=;
 b=DDy00brQVfq7HtavWuuOAekUhAdlrQBExRIaR6gcYL4Ta9zjEJA6iIBzLrov0g1oY+
 BTwHH9QOtwgBUk3hBPlsG7VqORT2iMSTvXk+1stn7GOisnkr8geEs9QJJCMLvQqABgC6
 Xw+UkmJg926ShKPsxxU7YImMLHN8a/D+kwTsC/F9r7RCHEMrImIwl8MFjcn8hXznkv5g
 ctrTOsXvPnCCikE1GOsrXl9Rx81x3ppZj7lY7lQJXXQ5E/e54TbSYMHxmR72o0o075VJ
 4vCDvE+LDn9I+uthAv/18UHEeHM2fY+T7N5TFQYBdRAm4cruVHlPxt53ZHWA+eYoCSgE
 W71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FriArxnM019D776ImdHSDTVH+8rk+AtrtUiHpYXliLw=;
 b=aUjNRYCqJbMTJR4l6IUpDLbE2aN2NnbIs2lClN28gtidkNvEmQQ+zfYGzgnr+Yk9oV
 vcd4eL+ocquBpTTFOT1m7Hu9WAUYVyrBDbvUXIIDL3MEt8GzlUQg9RF1+thNO36XcTt1
 SLvoux8hTu+T3cpaLVAXJshllNgthzHfXVxSgj59z5dVXsoa1b6ilHsHHEtZ2JXB4mkj
 APPYJoYNnraXlXTPxwNfsXHbgLqO52LpDa3C58siE0xV170zgVZnNRsre0NY1+0Z4PHk
 WIyvAPe0vCs7WiQz/4pz3SCe6M6g24QfwlS/5RWWIFpMJ4oUPEVVyuMmTmCu5dzpDQ3k
 mY1g==
X-Gm-Message-State: ANhLgQ3PEGuXVz8J7PQB1ifk2+HJVAodA1vY0xM/WQq4TTiL56TIHXQg
 WCbuFJwjDZ/B/FHkdYOkowkVt2C9
X-Google-Smtp-Source: ADFU+vsdZK1O/6hcKrFldcyrmb23egqnikgILRhrpG5nHG8Hcx5jSklVCW5H3NcPdUlglsFljM141A==
X-Received: by 2002:a17:90a:bd01:: with SMTP id
 y1mr4097427pjr.26.1585146608483; 
 Wed, 25 Mar 2020 07:30:08 -0700 (PDT)
Received: from bobo.ibm.com (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id i20sm10609622pfd.89.2020.03.25.07.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 07:30:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v2 3/4] ppc/spapr: Add FWNMI machine check delivery warnings
Date: Thu, 26 Mar 2020 00:29:05 +1000
Message-Id: <20200325142906.221248-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200325142906.221248-1-npiggin@gmail.com>
References: <20200325142906.221248-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::636
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
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
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
 hw/ppc/spapr_rtas.c   | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index a908c5d0e9..c8964eb25d 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -833,6 +833,8 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
     /* get rtas addr from fdt */
     rtas_addr = spapr_get_rtas_addr();
     if (!rtas_addr) {
+        error_report(
+"FWNMI: Unable to deliver machine check to guest: rtas_addr not found.");
         qemu_system_guest_panicked(NULL);
         g_free(ext_elog);
         return;
@@ -874,6 +876,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
          * that CPU called "ibm,nmi-interlock")
          */
         if (spapr->fwnmi_machine_check_interlock == cpu->vcpu_id) {
+            error_report(
+"FWNMI: Unable to deliver machine check to guest: nested machine check.");
             qemu_system_guest_panicked(NULL);
             return;
         }
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 29abe66d01..bcac0d00e7 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -462,6 +462,9 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
     }
 
     if (spapr->fwnmi_machine_check_addr == -1) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+"FWNMI: ibm,nmi-interlock RTAS called with FWNMI not registered.\n");
+
         /* NMI register not called */
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
-- 
2.23.0


