Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AD5C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221ED206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6Ulz+Bh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221ED206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFPs-0001Xf-8f
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWFMn-0004eb-CD; Wed, 06 May 2020 04:25:21 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:34777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWFMm-0006v9-DB; Wed, 06 May 2020 04:25:21 -0400
Received: by mail-lj1-x243.google.com with SMTP id f11so1422056ljp.1;
 Wed, 06 May 2020 01:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lMH/u7Oj5tLeyniMPvnIISL2brcdK2XDklGgIHlpRtY=;
 b=K6Ulz+Bh5OQhZUSM8TQ/4hS5Y5fLyGEvm0M8Ylow6zAdh++d0dE+5iU9J/S4mzZ0tC
 rUTZXe3vpTdl/RmL6Jtq6WNBMPPo0HDXnleQTwQgoYyNO/r+YT9woxub+Gr8QwikGBkX
 BQIT7zN4FShvb6sgbFDngubtGtDTVy4yNfSaIAYiZ+V+zgMckj4Umrn9fDFTlMW+q2iJ
 q8SgQ+oG8vqbXTqlFBrNNeLUBW9+ZJ4pp+VoOcSZF4vccOohY7C03Fg7nz8ESr65Id/Z
 5dnViZjQzh1i1yott90vuUx7FL+PRdgrqO2XtIQ/9o2r5k3zqqWm11whrBWQDzxzmREg
 qFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lMH/u7Oj5tLeyniMPvnIISL2brcdK2XDklGgIHlpRtY=;
 b=ggICDpvhbS/TTnDIQ2Xxtulh6aHrf9WDx0x4WSEIuDye1HzvsdEwGhmLXpkLri1Nd4
 lsQ1oBWb6kkCFD8rt2Q6Uej29opRuXKBdwZNRWpEU0Is7/Ka7c8/Gki+wOvMTx+3XMzy
 n7BDBmhXTVm/N8cusH4RVVfGu5taKYSyKogjzMPrRxzs1u/M6V2uHRbbEkZINsenknoW
 hMOk+Ba/gGEJ3LhK3itLIYFFbqUw7P+1cOWC0NWo4QdZRRrHB2rX6uPeW2x/wI5FCQkB
 fYXse6qap8LtJcvF6GyHafzktJdKw5Ps3vyt29RJ1eJqhStzSdKk8sQtFP+BTmXqj8UK
 KFQA==
X-Gm-Message-State: AGi0PuaZ2rPFkm5IoM/oy+kAeBuQ/LxnD4Ui8dkimrJ/K/CpwFqem5Tz
 N5ZUmtQFVe/B+rXMpPmMzomB087MP84=
X-Google-Smtp-Source: APiQypKFLz9m204mFkRkhZnPL4OQyA9/au8f9vfbMfLCCZnZxE3oW0CidpZZBwokxxLpQogRlLWdFg==
X-Received: by 2002:a2e:3a0a:: with SMTP id h10mr3950339lja.54.1588753517711; 
 Wed, 06 May 2020 01:25:17 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id o6sm798746lja.70.2020.05.06.01.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 01:25:17 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/9] hw/net/xilinx_axienet: Cleanup stream->push assignment
Date: Wed,  6 May 2020 10:25:06 +0200
Message-Id: <20200506082513.18751-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506082513.18751-1-edgar.iglesias@gmail.com>
References: <20200506082513.18751-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.399, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, jasowang@redhat.com, alistair@alistair23.me,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Split the shared stream_class_init function to assign
stream->push with better type-safety.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/xilinx_axienet.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 0f97510d8a..84073753d7 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -1029,11 +1029,19 @@ static void xilinx_enet_class_init(ObjectClass *klass, void *data)
     dc->reset = xilinx_axienet_reset;
 }
 
-static void xilinx_enet_stream_class_init(ObjectClass *klass, void *data)
+static void xilinx_enet_control_stream_class_init(ObjectClass *klass,
+                                                  void *data)
 {
     StreamSlaveClass *ssc = STREAM_SLAVE_CLASS(klass);
 
-    ssc->push = data;
+    ssc->push = xilinx_axienet_control_stream_push;
+}
+
+static void xilinx_enet_data_stream_class_init(ObjectClass *klass, void *data)
+{
+    StreamSlaveClass *ssc = STREAM_SLAVE_CLASS(klass);
+
+    ssc->push = xilinx_axienet_data_stream_push;
 }
 
 static const TypeInfo xilinx_enet_info = {
@@ -1048,8 +1056,7 @@ static const TypeInfo xilinx_enet_data_stream_info = {
     .name          = TYPE_XILINX_AXI_ENET_DATA_STREAM,
     .parent        = TYPE_OBJECT,
     .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
-    .class_init    = xilinx_enet_stream_class_init,
-    .class_data    = xilinx_axienet_data_stream_push,
+    .class_init    = xilinx_enet_data_stream_class_init,
     .interfaces = (InterfaceInfo[]) {
             { TYPE_STREAM_SLAVE },
             { }
@@ -1060,8 +1067,7 @@ static const TypeInfo xilinx_enet_control_stream_info = {
     .name          = TYPE_XILINX_AXI_ENET_CONTROL_STREAM,
     .parent        = TYPE_OBJECT,
     .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
-    .class_init    = xilinx_enet_stream_class_init,
-    .class_data    = xilinx_axienet_control_stream_push,
+    .class_init    = xilinx_enet_control_stream_class_init,
     .interfaces = (InterfaceInfo[]) {
             { TYPE_STREAM_SLAVE },
             { }
-- 
2.20.1


