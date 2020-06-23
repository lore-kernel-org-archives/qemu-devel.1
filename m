Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA41BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94AC9206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm9mvciU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AC9206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jncVM-0000yq-TO
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 02:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jncSy-00063T-Vb; Tue, 23 Jun 2020 02:31:33 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jncSw-0008IZ-K7; Tue, 23 Jun 2020 02:31:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id 17so1937749wmo.1;
 Mon, 22 Jun 2020 23:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G6O8qbdcLVHLDykRRDmqLztglRp+5s1IRFSC3NSpvoY=;
 b=Lm9mvciUAj2y8ov18DkCi7KNVfKSQZIYdlQhLZcRQ1yplUJt3x7G6zmVJNfoXWQHLG
 Vuyjfxgegn+n3X4+PXAzbZLs/ezwbVLhkmU7LSa1I42WY+bqOfegL9E4WhfIoXQSjrbq
 TngaVoQ4wn4fHRj4sDTI3E1zm0UJz7Ozpd71tjUrLEtFR7iXv3LeCEbOfJqWWkAFNFNw
 0OMfrd5n+9f2GzyZrAJJ0FFQ50B0gzkD3GpCn1TSsIFCcv983qWuMMARnBjLJVK7ztpE
 mhUrB988Vb32UqSdu+bZioX78VF62V3nE+NZ3AOz1nbeh95xM7TnCRq+zRnNmCd44jS4
 ZjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=G6O8qbdcLVHLDykRRDmqLztglRp+5s1IRFSC3NSpvoY=;
 b=KRHGc/mknkmzRylzPZ/HbKDnNEh4tWRU/kRsJYFhV0WRPGnvEcA7iKA2d9ngtCbP0G
 gHJo6jWkZJoljO4KSUt3QlOOnooIioAcbyJb4UvJDP3Ypu4HwkYiYIq59L52QZ8GxnLN
 h6i99CNxTdY75YYK0Unyi4QhRl0oeDci0if5/udtw4U4Rik5IJAry8LlqMi7d3y0Pyez
 szE0ZLBzYcxREs0xFMeAyKLsfmFEJGpxPcryXZmqsIU26CaEyNi7Sjb4H0zB4XjP4MQB
 v9YFAoBL2ia1Tv0bZS7ODNCMPui0rSp91ZAk7L0/r/mvm85cHZqmEDrF+Dml8xWSmg3c
 KjSA==
X-Gm-Message-State: AOAM531vTljzj75aWTLlecKczr9NyNc3Iq0yF0GqX92EOLT7/ojVx9Hi
 upsfBdLrgUjEfd3JwBH676aurUkA
X-Google-Smtp-Source: ABdhPJzDVFUizzllAqjMxD/XtB+sLNs1eR9JiTNfuSzMwB0y/JrWRDLNbEs9vv2yWvr/SZnf9PTLcA==
X-Received: by 2002:a1c:5ad6:: with SMTP id o205mr2195769wmb.54.1592893888573; 
 Mon, 22 Jun 2020 23:31:28 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x205sm2407188wmx.21.2020.06.22.23.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 23:31:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 2/3] i2c: Make i2c_start_transfer() direction argument a
 boolean
Date: Tue, 23 Jun 2020 08:31:22 +0200
Message-Id: <20200623063123.20776-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623063123.20776-1-f4bug@amsat.org>
References: <20200623063123.20776-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Corey Minyard <cminyard@mvista.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

Make the argument representing the direction of the transfer a
boolean type.
Rename the boolean argument as 'is_recv' to match i2c_recv_send().
Document the function prototype.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20200621145235.9E241745712@zero.eik.bme.hu>
[PMD: Split patch, added docstring]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i2c/i2c.h | 11 ++++++++++-
 hw/i2c/core.c        |  4 ++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index bc70c5b43d..a9e725bd6f 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -72,7 +72,16 @@ struct I2CBus {
 I2CBus *i2c_init_bus(DeviceState *parent, const char *name);
 void i2c_set_slave_address(I2CSlave *dev, uint8_t address);
 int i2c_bus_busy(I2CBus *bus);
-int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv);
+/**
+ * i2c_start_transfer: start a transfer on an I2C bus.
+ *
+ * @bus: #I2CBus to be used
+ * @address: address of the slave
+ * @is_recv: indicates the transfer direction
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int i2c_start_transfer(I2CBus *bus, uint8_t address, bool is_recv);
 void i2c_end_transfer(I2CBus *bus);
 void i2c_nack(I2CBus *bus);
 /**
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index b83c2b5b89..6f091837c9 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -91,7 +91,7 @@ int i2c_bus_busy(I2CBus *bus)
  * without releasing the bus.  If that fails, the bus is still
  * in a transaction.
  */
-int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv)
+int i2c_start_transfer(I2CBus *bus, uint8_t address, bool is_recv)
 {
     BusChild *kid;
     I2CSlaveClass *sc;
@@ -144,7 +144,7 @@ int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv)
 
         if (sc->event) {
             trace_i2c_event("start", s->address);
-            rv = sc->event(s, recv ? I2C_START_RECV : I2C_START_SEND);
+            rv = sc->event(s, is_recv ? I2C_START_RECV : I2C_START_SEND);
             if (rv && !bus->broadcast) {
                 if (bus_scanned) {
                     /* First call, terminate the transfer. */
-- 
2.21.3


