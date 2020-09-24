Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22729C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A3A2395B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShotNMr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A3A2395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPKP-0001VK-FJ
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLPGX-0004Mz-FB; Thu, 24 Sep 2020 07:18:21 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLPGV-0003vv-Mw; Thu, 24 Sep 2020 07:18:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id k18so3160624wmj.5;
 Thu, 24 Sep 2020 04:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PocNKqZn4p1bTkwGmp+nEPuAjYmk0VY+dPd4muqyYJI=;
 b=ShotNMr6DAnlxQtldQDuMt5c4YW74YxTLbKH1//mF+LUqs6vJxHj0RjtrplEGcL19j
 sRAxHfiFeQrRPVCWuEb1IGrMWuvv/g/yCamgsv/zbp3ginzFAcVZ5F9SkUnTcp5Biu6y
 yiDEYrwVsp8IABGxBROqCBwN3MnptKgxyZ5SThaBE7FQ8s8fMy6d3TaQh/kyUNNlQILj
 BAdfyG92NXa2WKrdbmUNaugWUh0ZqrnhyMHLtvGDaqo//lcMpCdbDrf6V9MtQJ4oLYJd
 upgLlI7gBQmjvPvrUHHxR9GnJed0r/jnJGGuTc9EKaDMqOfgETjRpgt7qVguClf+N2LH
 y5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PocNKqZn4p1bTkwGmp+nEPuAjYmk0VY+dPd4muqyYJI=;
 b=mOL4yuDjhf9/VO8ShnGZOKkinhgPRK1RerDpmPq8Lu2zjwToP2lSqIqyy66PrzLpw9
 NoK+2dabB0h+T6WdQPpRQ74rKzHV01YIa38AnDjMYJg6JJ0Wcm+USwl7ctBktHct36U1
 PtaL379lUWqu0FrcjHgD/W+POKeUAuuaLR1BaL0N2Uc9dYBbiRJ7Vf5c5LIjOiOARfRv
 RrMUQIHZ+KyuRX4ULRqLc02LRmBjH1hNmgKp3xr4xI8GsqjFfijjB/tp1R5X/YFNxcVd
 AQaf/wp0quT1LatWrEi5OmAZkzJY3CNOlqFpYdcMzJMjnCS10WFujCdrFepb0wxFPZ0L
 hZ9Q==
X-Gm-Message-State: AOAM530DnkOrI52/iu8hLHBABuvsjtfBoNX5EsnwSbhcWQZnFFyK4Zdc
 WANVShM3JyyzBR/5swWftHVlo7ZMYwA=
X-Google-Smtp-Source: ABdhPJwiIBjKw1WHonGQh/aBe4NDBJJ6f1zBukZR8FP06cuTY1aGAS11ckgQxAAmXZ7ptqAUsSQwGA==
X-Received: by 2002:a1c:8f:: with SMTP id 137mr4232847wma.158.1600946297860;
 Thu, 24 Sep 2020 04:18:17 -0700 (PDT)
Received: from x1w.redhat.com (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id h76sm3400363wme.10.2020.09.24.04.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 04:18:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 6/8] hw/arm/raspi: Introduce RaspiProcessorId enum
Date: Thu, 24 Sep 2020 13:18:06 +0200
Message-Id: <20200924111808.77168-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924111808.77168-1-f4bug@amsat.org>
References: <20200924111808.77168-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we only support a reduced set of the REV_CODE_PROCESSOR id
encoded in the board revision, define the PROCESSOR_ID values
as an enum. We can simplify the board_soc_type and cores_count
methods.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 3426521379e..0d8e5a34c78 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -69,16 +69,33 @@ FIELD(REV_CODE, MANUFACTURER,      16, 4);
 FIELD(REV_CODE, MEMORY_SIZE,       20, 3);
 FIELD(REV_CODE, STYLE,             23, 1);
 
+typedef enum RaspiProcessorId {
+    PROCESSOR_ID_BCM2836 = 1,
+    PROCESSOR_ID_BCM2837 = 2,
+} RaspiProcessorId;
+
+static const struct {
+    const char *type;
+    int cores_count;
+} soc_property[] = {
+    [PROCESSOR_ID_BCM2836] = {TYPE_BCM2836, BCM283X_NCPUS},
+    [PROCESSOR_ID_BCM2837] = {TYPE_BCM2837, BCM283X_NCPUS},
+};
+
 static uint64_t board_ram_size(uint32_t board_rev)
 {
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
     return 256 * MiB << FIELD_EX32(board_rev, REV_CODE, MEMORY_SIZE);
 }
 
-static int board_processor_id(uint32_t board_rev)
+static RaspiProcessorId board_processor_id(uint32_t board_rev)
 {
+    int proc_id = FIELD_EX32(board_rev, REV_CODE, PROCESSOR);
+
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
-    return FIELD_EX32(board_rev, REV_CODE, PROCESSOR);
+    assert(proc_id < ARRAY_SIZE(soc_property) && soc_property[proc_id].type);
+
+    return proc_id;
 }
 
 static int board_version(uint32_t board_rev)
@@ -88,32 +105,12 @@ static int board_version(uint32_t board_rev)
 
 static const char *board_soc_type(uint32_t board_rev)
 {
-    static const char *soc_types[] = {
-        NULL, TYPE_BCM2836, TYPE_BCM2837,
-    };
-    int proc_id = board_processor_id(board_rev);
-
-    if (proc_id >= ARRAY_SIZE(soc_types) || !soc_types[proc_id]) {
-        error_report("Unsupported processor id '%d' (board revision: 0x%x)",
-                     proc_id, board_rev);
-        exit(1);
-    }
-    return soc_types[proc_id];
+    return soc_property[board_processor_id(board_rev)].type;
 }
 
 static int cores_count(uint32_t board_rev)
 {
-    static const int soc_cores_count[] = {
-        0, BCM283X_NCPUS, BCM283X_NCPUS,
-    };
-    int proc_id = board_processor_id(board_rev);
-
-    if (proc_id >= ARRAY_SIZE(soc_cores_count) || !soc_cores_count[proc_id]) {
-        error_report("Unsupported processor id '%d' (board revision: 0x%x)",
-                     proc_id, board_rev);
-        exit(1);
-    }
-    return soc_cores_count[proc_id];
+    return soc_property[board_processor_id(board_rev)].cores_count;
 }
 
 static const char *board_type(uint32_t board_rev)
-- 
2.26.2


