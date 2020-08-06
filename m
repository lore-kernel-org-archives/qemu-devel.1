Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635FBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B3F221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT4mV6Re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B3F221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3azh-0007hO-2T
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 04:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3ax5-0002UQ-AM; Thu, 06 Aug 2020 04:08:39 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:33009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3ax3-0005gs-Jo; Thu, 06 Aug 2020 04:08:38 -0400
Received: by mail-wr1-x431.google.com with SMTP id p20so8172616wrf.0;
 Thu, 06 Aug 2020 01:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7eAZ0/8yiggvPhkOUdkJ91QA34FcT2pw/7CIAHLDBoI=;
 b=gT4mV6Re+G81D1DVLg9KyuO+IJIuIezbYCwieNnxvT+udghu7NEpXuqp0bMRBEHHsZ
 pEJIUgOclMIRZ+DtmjrLYx9yEx0+6MQwMK2maW2bd2/S98LWdc7hjLvwZaodgtUDXBDA
 KZKG2cmbD6SydenFWC+tM/YpDnlP17JwQEBbShY+OpLWifR9/CmZ5DLQ2nogsQaM38NZ
 /rBF41Wa8P+vB2UeEjwGr2WXvxHDSSarzobR6q43IZOx8Fj9H8mwhih3pSE+b0mDJjYt
 qRnpCRPcEnRB1+Tugj7NiDIl4a5POWas5hehqknBekmZWT5aLJPKUt2fUKwxDtrj0pvq
 pHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7eAZ0/8yiggvPhkOUdkJ91QA34FcT2pw/7CIAHLDBoI=;
 b=P4WK3EQdM/MptmLXffSLte+RwKSzkZr46w7kzLpcLFbrEilfxToLKKjk+O7bgcT5mo
 6EtGM86wy66Qn50OFTBd2+jM5hkOPM6IGlch/XbzTmbn0fBOBpPqNZPu8Cp09eGXMqKW
 Wku1DlQBr7R9o59A8YEhl73pGiWRkj8T+4KrRb8q6/kHRkiht+snCR569ya4G9sdcBe3
 YUKGxiiqkTXiwmyVeaRP1xijqLRZg5kqU46DgOyyrBdnxDv9eGaX0Z/A3MIw7BV9v0NT
 1M4wIUz64SUn+cbiNvn9nzqCdmgjzUzeQvuw0cHcsMgBV1/9zvaOGnvjj+uI8C9507TW
 p5VQ==
X-Gm-Message-State: AOAM5327s4zpw9o/yG7UIsXmJrvyuvAqYL/t2n14r1kGqKgDsjZ6pIlF
 AowFCtMi+Hyi7/3+a/hpHHMNshJ3
X-Google-Smtp-Source: ABdhPJyyNSbtrPbc8vneLMA2gswDfr9U65erO/ZXRdVXi1BT3/35+DwLFTbnaUFVx0lQPaam955IpQ==
X-Received: by 2002:adf:cd12:: with SMTP id w18mr6399520wrm.352.1596701315485; 
 Thu, 06 Aug 2020 01:08:35 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w2sm6039587wre.5.2020.08.06.01.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 01:08:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 7/7] hw/block/fdc: Add ASCII art schema of QOM
 relations
Date: Thu,  6 Aug 2020 10:08:24 +0200
Message-Id: <20200806080824.21567-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200806080824.21567-1-f4bug@amsat.org>
References: <20200806080824.21567-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Without knowing the QEMU history, it is hard to relate QEMU objects
with the hardware datasheet.

For example, one naively expects:

* a floppy disk is plugged / unplugged on the bus

  Wrong! QEMU floppy disks always sit on the bus. The block drives
  are plugged / unplugged on the disks, and the disks magically
  re-adapt their proprieties to match the block drive.

* a floppy controller has a fixed number of disks pluggable on the bus

  Wrong! QEMU floppy controllers have as much slots as the number of
  floppy drive provided when a machine is created. Then the ACPI table
  are generated and the number of slots can not be modified. So if you
  expect a dual slot controller being created with slot A and B, if
  the machine is created with a single drive attached, the controller
  will only have slot A created, and you will never be able to plug
  drive B without risking a mismatch in the ACPI tables.

* a floppy controller supporting 4 disks uses 2 buses

  Wrong! QEMU uses a single bus to plug the 4 disks.

As all these false assumptions are not obvious (we don't plug a disk,
we plug a block drive into a disk, etc...), start documenting the QOM
relationships with a simple ASCII schema.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/block/fdc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 6944b06e4b..b109f37050 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -47,6 +47,28 @@
 #include "qemu/module.h"
 #include "trace.h"
 
+/*
+ * QOM relationship:
+ * =================
+ *
+ *                  +-------------------+
+ *                  |                   |
+ * isa/sysbus  <--->|                   |
+ *                  |                   |
+ *  irq/dma    <----|        fdc        |
+ *                  |
+ *      clk    ---->|                   |        +-+------+-+    +-+------+-+
+ *                  |                   |        | | blk  | |    | | blk  | |
+ *                  +--------+----------+        | |      | |    | |      | |
+ *                           |                   | +------+ |    | +------+ |
+ *                           |                   |          |    |          |
+ *                           |                   |  floppy  |    |  floppy  |
+ *                           |                   +----+-----+    +----+-----+
+ *                           |   floppy-bus           |               |
+ *                           +------------------------v---------------v---
+ *
+ */
+
 /********************************************************/
 /* debug Floppy devices */
 
-- 
2.21.3


