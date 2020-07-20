Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D71C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79FE208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HTYmFu40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79FE208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxSPF-0004un-3N
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jxRLD-0004Br-78
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:40:07 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jxRLB-0003ta-HI
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:40:06 -0400
Received: by mail-pg1-x543.google.com with SMTP id z5so9984355pgb.6
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 01:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JsLTfddsKgoMRSVCuJtsD4pLBNDevQya9a9kk1rBuvs=;
 b=HTYmFu40g+Oa9ygM0ZvoPP1PgQX2rz4Dr4B7FQOUoyPtgA74+p3GLJnMm1EwqAoPfq
 L6Zt+SOXvaJbp4E9H5OzgFZTk31lh5joGbmTEYBqxegHWHgKvG0wDecCAbV903cDH2/Y
 6CfYV1O9vl0wt+aUw6N8IxWNWOOJHAj0tUaUHtv5FJzS8vLEJMPX5H1z5AliINJ1p3XH
 oMCohpVDuEehbe4komI+eq/sPgj2WusEopgpneuMOTTQlcplMepk6qMcS1Fz50q9/DET
 J67XAJ49FhB8NetlWEpkLr2FKp+uNh5PI7QTpnt3MJT6plXriGX3WwcHEn60cH8o/xNA
 840w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JsLTfddsKgoMRSVCuJtsD4pLBNDevQya9a9kk1rBuvs=;
 b=OxZIFZK/MutMf0W+vBN64Y4rx4QJ28nVg52IoTznLu+Qihw4VZQ1L/ShxzjG//dHaq
 aPGjI92lp/YGWO5aTLi8dVzwbwG1gWUsCz9G3wQqpkWOv8HAdDKorsAHHQjuhW0Magnk
 ocq5HiHDICWSArTXhN5A6RWGVqq2PKtxM6UzgJSiFJ6ULTePm6g29G6kr+iUUEP5blN4
 piMoPFrmnfeZwB+tR82nGzQPIkJbCgnDUbOInoVZRAudZzW70hrh3jLkJ3JkJt1odbsB
 BbHh0+oHWoikuBiEaIKUIgQdRUggBGdwQgfHlo5ZYjE/tYpgFO1yu21QAx+qFcG+G7Rn
 tX+A==
X-Gm-Message-State: AOAM532gmN32nRN8zbl0XtLQW6ZyBTN6Dj7bu0HHw23TFPnA4a1Q+3zH
 8dfIO3F8gHfAw8jBV+syccbtGA==
X-Google-Smtp-Source: ABdhPJypxHssbOrUNASzWyJtBQzO8CXAyQLzJbyxtMYaWvDwcey4PU3MRhC5jWdAbMfOqBkuecE2mQ==
X-Received: by 2002:a63:6c0a:: with SMTP id h10mr17924212pgc.11.1595234404148; 
 Mon, 20 Jul 2020 01:40:04 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id o4sm11388151pjo.16.2020.07.20.01.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 01:40:03 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/riscv: Fix the range of pmpcfg of CSR funcion table
Date: Mon, 20 Jul 2020 16:39:56 +0800
Message-Id: <c01aa428c0b4dc9c3e5b24a3d04040a1253bb3a5.1595234208.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595234208.git.zong.li@sifive.com>
References: <cover.1595234208.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=zong.li@sifive.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 20 Jul 2020 05:44:43 -0400
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
Cc: Zong Li <zong.li@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The range of Physical Memory Protection should be from CSR_PMPCFG0
to CSR_PMPCFG3, not to CSR_PMPADDR9.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ac01c835e1..6a96a01b1c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1353,7 +1353,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MTINST] =              { hmode,   read_mtinst,      write_mtinst     },
 
     /* Physical Memory Protection */
-    [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
+    [CSR_PMPCFG0  ... CSR_PMPCFG3]   = { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
 
     /* Performance Counters */
-- 
2.27.0


