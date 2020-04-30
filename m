Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCABC47253
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2965220873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FezdsRUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2965220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUC1x-0007Rz-Aa
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUC01-0004uL-0K
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUBzS-0002MC-Kp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:25:20 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:43042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jUBzS-0002HC-75; Thu, 30 Apr 2020 12:24:46 -0400
Received: by mail-lf1-x141.google.com with SMTP id 188so1729495lfa.10;
 Thu, 30 Apr 2020 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZNzziBInvAuKeSzUBcGAhMLGYBRMfB9xg0LXI8OI7Wc=;
 b=FezdsRUH4YCAofm4n35odfxKHFSEAcG9OlZAhUb8KLYd4atHEEIYGK3gWwW2I/5pKD
 AycwVPXOzZzqeRnOTPopzbUSyV5bc/ExkqbtNqCSs5N9BL2U7jXouHBJaS2DREN0ICv8
 eqeIxDx8fNOX3m1f3mneW9ZeBeMsySherHOBP9HtC1FqiAitLJtSm/qFjpMLEh9heqMD
 AyIbc4FPAALuAN7J5MCE3SgTL5Jr2i5mHz7Eta/EOdzvt1KuqzGVpm4hb4CRf1SQ2Y0p
 HfoQvYiVQjZBSY2wismb3XmG6au8jM0ia3t5cn8iXEJ6T0W0UIm8BfN6dGaT7K7RWmD5
 fV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZNzziBInvAuKeSzUBcGAhMLGYBRMfB9xg0LXI8OI7Wc=;
 b=n8izKTMfsa4SFv9Mdhz1ky90KslN86cK4YEOpGTSUWUK12CpXBP4EBrsrvJ02FxD8L
 +yn1AMigP5ohWvl0OjT3h84eXpq8mRiswfT+7brOqZ3qxY1joi77HxeZkCGfKJHnURIA
 jvep2RGk1MxXnnJeWIIKg/tO/+YpoxuMHR+sSBmE+EZ0/Z/bWRThYEo2UV2t7o+/1t3/
 WW7IdkgmaJR06TbcebUGQPSct6inXickUcTqyWKqzr3QUu4hYKeaHwGgoUqpxVyX0kO2
 qKq1dxXVJxMZNvYQKDa/mSkye7Ock6gQDY2MnKyFq+J4U7bbLjRPiiN7SCqnGZZ0s/uB
 yshw==
X-Gm-Message-State: AGi0PuaaREUUCPVWaxa2l/bSCs1WQuBlpiTP7EHYGSlwqTCZLk3M7pV/
 AkefXR4o9PNBc8+wPGhryZ8UgHcD8T0=
X-Google-Smtp-Source: APiQypJlcOhXBzi210JI6xZWbnIBeH3xKrRLWgDT+ihar8xJbL5crZR+kI5PdaSR4Ze5vBETxi8UwQ==
X-Received: by 2002:a05:6512:308c:: with SMTP id
 z12mr2639019lfd.195.1588263883589; 
 Thu, 30 Apr 2020 09:24:43 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id j24sm147542ljg.60.2020.04.30.09.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:24:42 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/9] hw/net/xilinx_axienet: Cleanup stream->push assignment
Date: Thu, 30 Apr 2020 18:24:32 +0200
Message-Id: <20200430162439.2659-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162439.2659-1-edgar.iglesias@gmail.com>
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::141
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


