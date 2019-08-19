Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5902C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3329206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWA7DUzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3329206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzo7h-00011N-6f
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5o-0007gZ-2Q
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5g-0003Ha-UF
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:27 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hzo5g-0003Fe-PK
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:20 -0400
Received: by mail-ot1-x344.google.com with SMTP id e12so2880846otp.10
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 13:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Vieta1X04i/SCs0pvbOIwKwN90/dIHs868zzWk/WUvk=;
 b=jWA7DUzSZPMVzokcXtL7rkFMikpvEpXqHKjxus1qLgE9YpxhbMRmPLfLbGQ/AjAxRf
 0rM8yBO4PvBjOS292/cEKsEWxCA9rz80BS+ruhckdgtzxZIukwDkY2Mi3mqbvJG3Eo2C
 gv0mQUKRG4Ds5WBN7VNpFarlTIrTGdRA/i5Z2AuyR1GdVIdaRu+Zc3RQbDBU+90G5Xnk
 ksUkwXOr8T1OO1mVVLxdWjZvws/e5O/8JdxB2ZsgZF/QnkQXtmFQs7nhujpp80eEwhrJ
 vEF4xLdnMuFR1sc2XgxKFmt47POzuTaciU4t0XPUNQi+XJEQndQ2+D+4NbzybtLm0sJk
 cRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Vieta1X04i/SCs0pvbOIwKwN90/dIHs868zzWk/WUvk=;
 b=ll6u8qbLrj4KqANdZNO5nCJjQXFJMMO0IFt6jhJ8JeMc14xKOMhh4Di4j6LNe93qx7
 tdyz1B1Ys0HO/38Gm4DbhVdONCuVwuvK86kP6yVGdjm8BDtCHm+LUMmLaJHYX/r0zcFJ
 KE8mIIFwVRjR6BUnGQM8hW+k2L+e1LcdKYSRoYAm8QhDVIEbOnuB0qNMpj1K6zanJLMR
 8KUWW882lzOgKa2xzc+oMsycM/nCH1Fv73UeFsnrpXCaWSnlxWshJ9gcpDNAEpt1P4Db
 TWeptQWzonYDmCZ33uThx3wYeJtnCjtwXz8PyvujKDaxv0TCSWHaa8fM6hRd2Yee7d0h
 nXvQ==
X-Gm-Message-State: APjAAAXIn7Ua8FDQggvPoUoF/Orl22rZNuBrNcIfZSOx6ARmAsolxQIT
 hYYKrIbaabMDLtPifepraw==
X-Google-Smtp-Source: APXvYqzibQnQAo4oy6oRyWCNtONMZ8ruUvLLFV0w/NpIFSQMa0l7zGT0VvSxY/krvEKrhGgjduRlVg==
X-Received: by 2002:a9d:7aa:: with SMTP id 39mr19049654oto.178.1566245839287; 
 Mon, 19 Aug 2019 13:17:19 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
 by smtp.gmail.com with ESMTPSA id f84sm4594565oig.43.2019.08.19.13.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 13:17:17 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
 by serve.minyard.net (Postfix) with ESMTPA id 3FCD01800D4;
 Mon, 19 Aug 2019 20:17:16 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
 id C614F301176; Mon, 19 Aug 2019 15:17:15 -0500 (CDT)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Mon, 19 Aug 2019 15:16:51 -0500
Message-Id: <20190819201705.31633-2-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819201705.31633-1-minyard@acm.org>
References: <20190819201705.31633-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [PATCH 01/15] ipmi: Fix watchdog NMI handling
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
Cc: Corey Minyard <cminyard@mvista.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

The wrong logic was used for detection (so it wouldn't work at all)
and the wrong interface was used to inject the NMI if the detection
logic was correct.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/ipmi.c         | 6 +++---
 hw/ipmi/ipmi_bmc_sim.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index 136c86b7a7..cbe158f815 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -28,9 +28,8 @@
 #include "qom/object_interfaces.h"
 #include "sysemu/runstate.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/visitor.h"
 #include "qemu/module.h"
+#include "hw/nmi.h"
 
 static uint32_t ipmi_current_uuid = 1;
 
@@ -60,7 +59,8 @@ static int ipmi_do_hw_op(IPMIInterface *s, enum ipmi_op op, int checkonly)
         if (checkonly) {
             return 0;
         }
-        qmp_inject_nmi(NULL);
+        /* We don't care what CPU we use. */
+        nmi_monitor_handle(0, NULL);
         return 0;
 
     case IPMI_SHUTDOWN_VIA_ACPI_OVERTEMP:
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 246a6d390c..8f63bb7181 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -1194,7 +1194,7 @@ static void set_watchdog_timer(IPMIBmcSim *ibs,
         break;
 
     case IPMI_BMC_WATCHDOG_PRE_NMI:
-        if (!k->do_hw_op(s, IPMI_SEND_NMI, 1)) {
+        if (k->do_hw_op(s, IPMI_SEND_NMI, 1)) {
             /* NMI not supported. */
             rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
             return;
-- 
2.17.1


