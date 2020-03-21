Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1470DC4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 19:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D045620663
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 19:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Spczl3WS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D045620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFjaF-0007Y5-1d
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 15:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jFjYd-0005Pv-Js
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jFjYc-0005lq-Il
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:13:19 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39241)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jFjYc-0005lR-DG
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:13:18 -0400
Received: by mail-wr1-x42e.google.com with SMTP id h6so11584098wrs.6
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 12:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=m5gz0JlOnw+UpHFzqPtGTuq9wcw2D7Vvrwm78V+zTTA=;
 b=Spczl3WShUBDAAAiGAH+IkAENIeXGMdDUPKjyyVMgfI519Tx/7gS79lH84TjFFqoFk
 2ZZ9MI4XVzkyTkHkfiRek7OGK/R6gwJiKaZQ7kwUCPx+beP9uxm5OpVih//esfENKcFr
 mWxogw5I0FkPUVan4aOZakQehte/YuFgOmj69Z1AVjwjfN4zcNCPxq1AWSzbzazSmwkt
 TCItf2BKQpMUvC40wUBDecFUpb0gv4lSKFHBNyC750zhZJenGfwCRINbmso2+Fm/AnBt
 RV7zp1LQmqBU1/usFZZ1FIdymopU5y/KgirEqJbIiI0ulIlUYcIJYT5qyJNQTUNPPRxN
 MRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=m5gz0JlOnw+UpHFzqPtGTuq9wcw2D7Vvrwm78V+zTTA=;
 b=lZmbYgo4avr8B9U/rLr8WntIWBxMOkz9lWO2uEGula1/SlX6jQES8vL98FKnBhzH2L
 /zOrsEY2p4lIVGUzeZZN7Vfd/GJsXJ3t9wpKx6fewfD0v6fVDWzqxUJNIebXhfdU519D
 SPnHFhTEXIme4ptOK23WKXieMIVaYf27IRuGzjrQdDhfGvjygztZAWLBavgJtpUiEBD0
 DQCbczSwneIC3sHd0Rs5AsJ3GjIcw9VpnpKtqcHRjIdkf1NiHIF4lGhVU0yfJuPq2HBT
 Vo8R4mGNT9Jv99ppDS5WKnLiipuPX8SAVP7vwlD8CLYWp2o60P3BvmWCVSn57IeGFJOp
 KQVw==
X-Gm-Message-State: ANhLgQ343M7GFnYjoF4AdQmLatjwa0sLtjBmmJcm3s9LJ0Wd9oYKOdJn
 /Ogd6P+X4sNv/L6tVl3IQ0SjRZ4D
X-Google-Smtp-Source: ADFU+vv9GSFIqG6UcxLJQW/zlCVT1FdtUstZ3Nl/GHHBgwiCrhEnate9bzidEAy5Nu7ddzY6iRQwzw==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr18629386wro.193.1584817997161; 
 Sat, 21 Mar 2020 12:13:17 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id i1sm15226252wrs.18.2020.03.21.12.13.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 21 Mar 2020 12:13:16 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [Qemu-devel] [PATCH PULL 1/4] hw/rdma/vmw/pvrdma_dev_ring: Replace
 strncpy with pstrcpy
Date: Sat, 21 Mar 2020 21:13:08 +0200
Message-Id: <20200321191311.31537-2-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200321191311.31537-1-marcel.apfelbaum@gmail.com>
References: <20200321191311.31537-1-marcel.apfelbaum@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: jusual@redhat.com, stefanha@redhat.com, yuval.shaia.ml@gmail.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Julia Suvorova <jusual@redhat.com>

ring->name is defined as 'char name[MAX_RING_NAME_SZ]'. Replace untruncated
strncpy with QEMU function.
This case prevented QEMU from compiling with --enable-sanitizers.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
Message-Id: <20200318134849.237011-1-jusual@redhat.com>
Reviewed-by: Yuval Shaia <yuval.shaia.ml.gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_dev_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma_dev_ring.c b/hw/rdma/vmw/pvrdma_dev_ring.c
index d7bc7f5ccc..c2b3dd70a9 100644
--- a/hw/rdma/vmw/pvrdma_dev_ring.c
+++ b/hw/rdma/vmw/pvrdma_dev_ring.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "cpu.h"
+#include "qemu/cutils.h"
 
 #include "trace.h"
 
@@ -30,8 +31,7 @@ int pvrdma_ring_init(PvrdmaRing *ring, const char *name, PCIDevice *dev,
     int i;
     int rc = 0;
 
-    strncpy(ring->name, name, MAX_RING_NAME_SZ);
-    ring->name[MAX_RING_NAME_SZ - 1] = 0;
+    pstrcpy(ring->name, MAX_RING_NAME_SZ, name);
     ring->dev = dev;
     ring->ring_state = ring_state;
     ring->max_elems = max_elems;
-- 
2.17.2


