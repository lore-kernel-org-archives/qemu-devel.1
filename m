Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C6EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07877214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF/uwU0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07877214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzoHM-0006ub-4I
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5n-0007gO-Sc
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5f-0003De-MK
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:27 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:47089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hzo5f-0003CI-HW
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:19 -0400
Received: by mail-oi1-x242.google.com with SMTP id t24so2309550oij.13
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5IGB425rPWZv6PIAxxgYjNsziWO2Aym53s828C6B59k=;
 b=OF/uwU0LaCw324pFQiZ6uos9fVMs/qFL2HKTzwzIyYsBtNTq5tZGQmGJgMSiRvEDL3
 Vm80KH8k5cd2JIbm+mMqn0/S/vkaWeWnNcp2Dis9KchLqNF9GY0IAnpH3Uo/koSxwPif
 fEwIV8Log9Gh4r5bSz6dUfJVPDoKD3SowwhTf5LoCPHRfSyL6Zj4EyLCb1B0e/Y+uixq
 aFwIN3uWHnKMEPHXW12SU7W8LaQfdFlyRlP1Oe+tgiLOULVVIubHICj3OLl+4DrdxFj+
 JfjbKnpL1J9UlfjqG/SHOVMj/p2ZifeBrmgXOkoKf+T8x4+EwFe82quA+dwbS0zjMqew
 Fpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=5IGB425rPWZv6PIAxxgYjNsziWO2Aym53s828C6B59k=;
 b=qeL6v/xHTJhxv/mUf3HNnoMfI9nsCDnWI1hBfKLKf5QdGAZHhizDA5MK2JLJIqPPqg
 RNV0zYrQdVQlBupUAxHQoB04TJZBJlTa5OVEMOk5fhdjZKiFlDb19G1Wa9IyDbfRUInz
 45GAdmDEBvwtmNzTPwXMsBDVCwTkPENirnRnp6UgT53Sevg4n43fFba0LOQO6eeMjchc
 OZVPMyIfs0A3tH6SJf7c9HNFxlMWAlyK7bKwhlyPys6mMCpgG5Zw6Pakg2hyyC02TfPC
 ieTHAC3SK5vQMKhS9XwVODeC6l3Je/k4mh8vhA0Ap2PZq2ouOqUv7tv5FVgMqnHe34Sr
 dwfQ==
X-Gm-Message-State: APjAAAV3ul42nLH8nY6whfKixeh/RbNkoJI1CwF80ogvcP3P1S7G+9p0
 2TUehBmvLAXxqi8CBg+5tg==
X-Google-Smtp-Source: APXvYqwRm2zgXmr3ibwCvPlnpHRgRM0Z8EY1Ba8Pl1uvEfL8HZLl7OkAiVDx8gX07S/Fy+PmV09TWw==
X-Received: by 2002:a05:6808:342:: with SMTP id
 j2mr15128760oie.34.1566245837999; 
 Mon, 19 Aug 2019 13:17:17 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id w139sm4940407oiw.0.2019.08.19.13.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 13:17:17 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
 by serve.minyard.net (Postfix) with ESMTPA id 6B5711800D5;
 Mon, 19 Aug 2019 20:17:16 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
 id 2C956301220; Mon, 19 Aug 2019 15:17:15 -0500 (CDT)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Mon, 19 Aug 2019 15:16:52 -0500
Message-Id: <20190819201705.31633-3-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819201705.31633-1-minyard@acm.org>
References: <20190819201705.31633-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: [Qemu-devel] [PATCH 02/15] ipmi: Fix the get watchdog command
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

It wasn't returning the set timeout like it should have been.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 8f63bb7181..afb99e33d7 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -1228,6 +1228,8 @@ static void get_watchdog_timer(IPMIBmcSim *ibs,
     rsp_buffer_push(rsp, ibs->watchdog_action);
     rsp_buffer_push(rsp, ibs->watchdog_pretimeout);
     rsp_buffer_push(rsp, ibs->watchdog_expired);
+    rsp_buffer_push(rsp, ibs->watchdog_timeout & 0xff);
+    rsp_buffer_push(rsp, (ibs->watchdog_timeout >> 8) & 0xff);
     if (ibs->watchdog_running) {
         long timeout;
         timeout = ((ibs->watchdog_expiry - ipmi_getmonotime() + 50000000)
-- 
2.17.1


