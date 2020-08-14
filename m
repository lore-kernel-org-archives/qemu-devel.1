Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B6CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5423206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3Pg4IoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5423206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ZnN-0002uI-T4
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 09:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6Zmg-0002Cv-Ma; Fri, 14 Aug 2020 09:30:14 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6Zmd-0001DY-UR; Fri, 14 Aug 2020 09:30:14 -0400
Received: by mail-wm1-x342.google.com with SMTP id c80so7493458wme.0;
 Fri, 14 Aug 2020 06:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+WN5+x/S52yPuJmxO8+ZTxpwug077ztvG/3BJTOgOtQ=;
 b=u3Pg4IoZRdTabEyPnFwUFrjkW18lkd9OvNH4S65UX57GRl2JJVQ7/wrjE1ASlJm3LR
 QHpopIwG8USNPwNLlfDAm/53eTXGSQJD77W/+q8FqsUE+0yVlPrBC8l35PeyYRn/MDWy
 kwVHcwElnxrZO/PIGtF2bQm27lMCn/NCbZ+YJn33yLVoFzqncjpU/EMNXJgAHkTSQpBJ
 kGJXh5NjaD0gKX23Bq//UOv9b1BG6LPq5auDNGNRDrUbVxK8x7sVrJmDZUQeeMA7SGyB
 7Yx76Qc5jlms5IUUFHjXZfUPtU/Nr0Gs7o4yeqg7NkGUUb91wdw8dwBHZ+HGve11/0te
 ohxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=+WN5+x/S52yPuJmxO8+ZTxpwug077ztvG/3BJTOgOtQ=;
 b=plVJj51As/Eqtepn/8OVY247zPObN3BFmFClz7wblbTmH71JZUzjyQ2Dglc/rrKBBE
 sqVFf9Q6n6IHEBSge5mMdzGIK3BVPr3dP32Hbzp4XwwuvL1NhAzzETo+iI0h70puWkJO
 l5/HkRXSqIJ/llMZ28GYk4kcQVBTgw5pkaq8cjQjAPuT0gCx61vXEu1mSN01ALZbVwyb
 0mpxIELYqwJ3oT8Xo2UxT/XGKW6zViyYiSPNpLBIE/e3hCELU+X8F6P/KjM1WLyQMeOw
 usJMyMMqp+UTuytuKOcq/KgDj4fwvx/m0NOPypW0snkt4ZG3Zm5HZ62pkAJXfHc88mNO
 VGMQ==
X-Gm-Message-State: AOAM532lanCKKo0mFkTn1j+iIlZ61jodOOiSu+S32arFcZmfhZHXCC0o
 xcngQ9OoAyX3q9tVFCBn9oW4//BhZT4=
X-Google-Smtp-Source: ABdhPJxkmQ4gixIw9LePIBH+v7mf1/iTJIn5q6ONVI8iOMZILkAc0jcyfl0zWd0PO0AOs9SWsN6Jtw==
X-Received: by 2002:a1c:4e0d:: with SMTP id g13mr2542782wmh.177.1597411809547; 
 Fri, 14 Aug 2020 06:30:09 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j4sm14708003wmi.48.2020.08.14.06.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 06:30:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/net/xilinx_axienet: Remove unused code
Date: Fri, 14 Aug 2020 15:30:07 +0200
Message-Id: <20200814133007.16850-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most of the MDIOBus fields are unused.  The ADVERTISE_10HALF
definition is unused.  Remove unused code.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/xilinx_axienet.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 1e48eb70c9..2e89f236b4 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -54,7 +54,6 @@
      TYPE_XILINX_AXI_ENET_CONTROL_STREAM)
 
 /* Advertisement control register. */
-#define ADVERTISE_10HALF        0x0020  /* Try for 10mbps half-duplex  */
 #define ADVERTISE_10FULL        0x0040  /* Try for 10mbps full-duplex  */
 #define ADVERTISE_100HALF       0x0080  /* Try for 100mbps half-duplex */
 #define ADVERTISE_100FULL       0x0100  /* Try for 100mbps full-duplex */
@@ -169,28 +168,6 @@ tdk_init(struct PHY *phy)
 }
 
 struct MDIOBus {
-    /* bus.  */
-    int mdc;
-    int mdio;
-
-    /* decoder.  */
-    enum {
-        PREAMBLE,
-        SOF,
-        OPC,
-        ADDR,
-        REQ,
-        TURNAROUND,
-        DATA
-    } state;
-    unsigned int drive;
-
-    unsigned int cnt;
-    unsigned int addr;
-    unsigned int opc;
-    unsigned int req;
-    unsigned int data;
-
     struct PHY *devs[32];
 };
 
-- 
2.21.3


