Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A24C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 14:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7070A20738
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 14:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC0+WZMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7070A20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jflF5-0004Os-K9
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 10:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jflE8-0002x8-Ee; Mon, 01 Jun 2020 10:15:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:35067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jflE7-0007y2-L0; Mon, 01 Jun 2020 10:15:44 -0400
Received: by mail-wm1-x32a.google.com with SMTP id q25so2627213wmj.0;
 Mon, 01 Jun 2020 07:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ks98JFnorqslz3pudbIM/w6sYSe24kUiwz6PGkfW0g8=;
 b=HC0+WZMPT1uqb+hp7P5vAinAsviLAIk0Xtms1FRVnzsNwd4bWzgcPV6v5GLLqkUfVc
 dReDrZ/4r9cJzA29roWv1V8QvEA/WDSuQhx0hhyLVZZ3y0NsBNJhHCpXW5Mivi2e68S0
 r+dp0tW7apoNmf9hQgCn29dmZI7JsLvPypPsZ9cqXzNF8UjUAv2bVmCTYsigVk/tldY9
 kUuo4aNREf14rpSJ8uQFjE3OV9LWYTKdi092jzVPBYjYuurS8kOCkbpAVa9Q7j/LGPpX
 kYrvlP06aOE/kvMsfC+IJ5YFDeFuLstPKMnTH3Fcn4Mktgd7NCUNiUlJ/1QCyfKtbyMh
 aDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Ks98JFnorqslz3pudbIM/w6sYSe24kUiwz6PGkfW0g8=;
 b=rhqSawQTZLsV5NF5qGL/U7COL6c7dagtWdGShpWrXrpif21Om0c/J3hg5YO+MXVjQV
 AAiH1290a/k51kWybY2VYGGPa9BvAKhtmrWw85h0s0O6vCYhqivEaDXLrQp193UkTiBk
 gakEXmIjezNWvjKPoU9fz1q7HQf5Ed86tBdWU9CwZt/dsb7wW+hfvw6yjqwKK9Dco6bh
 SRJCIiT3bfGYHPfgz7ZoY1mC9RpIwDDWN3PM+a1/PXhin/aGL/tvKd1gWR6XjYRhiNPL
 SYQXRxiFTRXHpq0KyjwNIhWma8yHeCZov4EJa1d3NbblBGKoLW+f5U9hLYZDQTeZx/xI
 cwTA==
X-Gm-Message-State: AOAM530YrzNEAf52tAxUm10hNsXH7lsZLHMB6PP8ZThudNpl8r++Pynq
 A5c7dgorPk4Wj6pLzjQJ/1QDynsE
X-Google-Smtp-Source: ABdhPJz90XqotrmA5ojwauHyYaH3FXGh2yAGULmYyHXgdm0frqBw8BeqXsqkBJ6NjFqqcq0eFQf05Q==
X-Received: by 2002:a1c:b654:: with SMTP id g81mr21399129wmf.128.1591020940747; 
 Mon, 01 Jun 2020 07:15:40 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a124sm12864182wmh.4.2020.06.01.07.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 07:15:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] exec/memory: Remove unused MemoryRegionMmio type
Date: Mon,  1 Jun 2020 16:15:34 +0200
Message-Id: <20200601141536.15192-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200601141536.15192-1-f4bug@amsat.org>
References: <20200601141536.15192-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 62a0db942dec ('memory: Remove old_mmio accessors')
this structure is unused. Remove it.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/exec/memory.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e000bd2f97..3cdc171583 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -50,12 +50,6 @@
 extern bool global_dirty_log;
 
 typedef struct MemoryRegionOps MemoryRegionOps;
-typedef struct MemoryRegionMmio MemoryRegionMmio;
-
-struct MemoryRegionMmio {
-    CPUReadMemoryFunc *read[3];
-    CPUWriteMemoryFunc *write[3];
-};
 
 typedef struct IOMMUTLBEntry IOMMUTLBEntry;
 
-- 
2.21.3


