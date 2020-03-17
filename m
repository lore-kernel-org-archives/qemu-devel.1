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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BCBC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D98C20674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrGYtHhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D98C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE4PC-0008RY-HD
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 01:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jE4Nv-0006qW-DB
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jE4Nu-0001v8-6Z
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:03:23 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jE4Nr-0001Qj-KJ; Tue, 17 Mar 2020 01:03:19 -0400
Received: by mail-pl1-x641.google.com with SMTP id h11so9065376plk.7;
 Mon, 16 Mar 2020 22:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8ZYw6lvEvF1npHa5ZX6HcYXupR8cZnIrf1sZZ0UGhPA=;
 b=VrGYtHhV5M4XrGBGw3HFJwa+d3kZ/cVK988ufqLL8+d/yRL6qGnPkT0j281IngHKqs
 6wS5qbtf5zVvpNosPirSpacoU67qwyKTM+TpVR2oK3oDGcoV4D3MHaU3AOPzG4wBb6l6
 nh6t/5C/f5SizwEkjA+SyrbcvKgBJ2nbcHqlXwMDwCaCCc4HailoDdKu5OCe6bMMR0+W
 IW1eLENc6otVxhVvAQsS9aYhChWM/KZ+ZUWzvurDGxnJfE8P+phwNeDq7UZ0Kgw1aDch
 n0YNTQcTj2P0J1oR2Obr9FRTPljNZdZ3zSQ8p0wqj+xIRjORkS3IUqs6uxUG6XYPxtJj
 g8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8ZYw6lvEvF1npHa5ZX6HcYXupR8cZnIrf1sZZ0UGhPA=;
 b=gu9JtD1m4aFedhU+NfH9XHEUCZ3PaIETr9x/8u/hGhtgxD8NGmD4WU8qWcJ7KVhW3Q
 MNmSAlCvVtOaPFDuaVrefEnPsm/Q60AVfqpRveqsGe9D2Nd7xcYz4OVRWUDOfOqE6mXr
 DLH9OHUoOHRWVRVLmCPy3eN7seGmrJly87X/D6PGSS9Og9egjLmb9Zf+CO8UyOEca6Yb
 HD+J2tuVkQfbNUDaT0TnYXQl0DtIM6GGguCKY79TeaXVOySl9T802+tE/FA622/G31G4
 RG1IPSi2MlKowCC3r1uJ9kqdlhBRAyLIoRcqjaBkR48CnkZ+T3t/aMzXL5PLYIewqUJl
 z0rw==
X-Gm-Message-State: ANhLgQ2eBi7iR1cqjiw6DCQzZgVo4Ff8FqnKDnoyPeEGFYykvuESWReE
 Wtu1eHv8YfjbHcq8zbXpftUKpQVQqN8=
X-Google-Smtp-Source: ADFU+vvXKd0g1JsmcLYvfK+2EVOTxkWQy8Nqt+mujMDKcN+btEkrxog7FsmGuusb57xGL3m2uWE/qg==
X-Received: by 2002:a17:902:6bcb:: with SMTP id
 m11mr2708697plt.10.1584421398447; 
 Mon, 16 Mar 2020 22:03:18 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (14-202-190-183.tpgi.com.au.
 [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id k67sm994803pga.91.2020.03.16.22.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 22:03:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH 2/5] ppc/spapr: Improve FWNMI machine check delivery corner
 case comments
Date: Tue, 17 Mar 2020 15:02:12 +1000
Message-Id: <20200317050215.159334-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200317050215.159334-1-npiggin@gmail.com>
References: <20200317050215.159334-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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

Some of the conditions are not as clearly documented as they could be.
Also the non-FWNMI case does not need a large comment.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_events.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 323fcef4aa..05337f0671 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -834,17 +834,13 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
     Error *local_err = NULL;
 
     if (spapr->fwnmi_machine_check_addr == -1) {
-        /*
-         * This implies that we have hit a machine check either when the
-         * guest has not registered FWNMI (i.e., "ibm,nmi-register" not
-         * called) or between system reset and "ibm,nmi-register".
-         * Fall back to the old machine check behavior in such cases.
-         */
+        /* Non-FWNMI case, deliver it like an architected CPU interrupt. */
         cs->exception_index = POWERPC_EXCP_MCHECK;
         ppc_cpu_do_interrupt(cs);
         return;
     }
 
+    /* Wait for FWNMI interlock. */
     while (spapr->fwnmi_machine_check_interlock != -1) {
         /*
          * Check whether the same CPU got machine check error
@@ -856,8 +852,13 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
             return;
         }
         qemu_cond_wait_iothread(&spapr->fwnmi_machine_check_interlock_cond);
-        /* Meanwhile if the system is reset, then just return */
         if (spapr->fwnmi_machine_check_addr == -1) {
+            /*
+             * If the machine was reset while waiting for the interlock,
+             * abort the delivery. The machine check applies to a context
+             * that no longer exists, so it wouldn't make sense to deliver
+             * it now.
+             */
             return;
         }
     }
@@ -868,7 +869,9 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
          * We don't want to abort so we let the migration to continue.
          * In a rare case, the machine check handler will run on the target.
          * Though this is not preferable, it is better than aborting
-         * the migration or killing the VM.
+         * the migration or killing the VM. It is okay to call
+         * migrate_del_blocker on a blocker that was not added (which the
+         * nmi-interlock handler would do when it's called after this).
          */
         warn_report("Received a fwnmi while migration was in progress");
     }
-- 
2.23.0


