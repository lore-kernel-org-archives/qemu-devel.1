Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC12BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87988206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wk9JJdWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87988206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSgl-0007FG-Os
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSN-0004wQ-Lu; Wed, 17 Jun 2020 03:25:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSM-0002cb-8b; Wed, 17 Jun 2020 03:25:59 -0400
Received: by mail-wr1-x441.google.com with SMTP id c3so1123553wru.12;
 Wed, 17 Jun 2020 00:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9KNJnLBp1OneKNvTmDgKiylMxA5dVLV/Msl/G9txJEk=;
 b=Wk9JJdWnn47gUikPT/UsTBJChpT1zX90gL9MYuUOJEFJ55CjRQZQQhtseGBDiO3Z9V
 jU+pdtF5Ck746xqivTRxcNhu2v0AXG1E/PHFZOACjK/VrfNSGgYKE9tt3BJsr9uQqV0m
 duG9X6y3ak9OZ3uuculJGDUB5lxKv2p9DbBvYx4qeiDfadMjuwNhquv5hyzrziybuqx0
 QYUx+wLpFPKSNSvKeC/kK6ZserYkoos8/T1X3spZB5v0A6zZy7UTv/TOQgT/HiRT7T9t
 FQfbfVCcR67nZ2Dcq50jdSgLL1NdBBXvB58tVUocK91Qmjd9mfZSDGcPfcevTBkKrv7A
 lDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9KNJnLBp1OneKNvTmDgKiylMxA5dVLV/Msl/G9txJEk=;
 b=P4Fl6aZ4evWVKH+uEqSI4iDVDVyAqjV9xOjeEbsIvuLT/7PX6G6d2O5myEmbKBXjuq
 7skkaYTJADGSwyida1sKQDBzjwjIqRdI50+steYZuoyxLAff8PkJbGDLBTSPdrnOQc+8
 p3HhChyullqS/QZQ9g3NYzAmv/AtqEpML7MNe94Qe4B6Gtmwu7f70M0Wsnw8wGIqFvAs
 EMA/Q+WD+DsIn4c9369plLrLVjUsbPV0uEBWdfY5X3FvUOnVpyoBGdJBCpCCuGIGmsnu
 fRB39L35QYNheJ1LzDVzYKhamUmqNC2BhDIhVtI+wd8iylFwFI2lO+V4Mg+msD57rEM0
 GVBA==
X-Gm-Message-State: AOAM533ryvjdGshRspOw0X13RGWaBMVmKjHQiu0my/CyUNyaNqgFJpCf
 yGOJd/m2CCvjUBG5sPFcw0/pERbV
X-Google-Smtp-Source: ABdhPJwo8N8VOJweH0Y9AYyF3O4e//pad9jP2aknn1Xwf6OxRBSY5sv84W7T8SYayUbK5S7OdKLPUA==
X-Received: by 2002:adf:aa94:: with SMTP id h20mr6536393wrc.327.1592378756378; 
 Wed, 17 Jun 2020 00:25:56 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id j5sm32894781wrq.39.2020.06.17.00.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 00:25:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/14] hw/arm/mps2: Add audio I2S interface as
 unimplemented device
Date: Wed, 17 Jun 2020 09:25:38 +0200
Message-Id: <20200617072539.32686-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617072539.32686-1-f4bug@amsat.org>
References: <20200617072539.32686-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/mps2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 2f6acbf2c2..d1653a7e6e 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -373,6 +373,7 @@ static void mps2_common_init(MachineState *machine)
                                          0x4002a000};   /* Shield1 */
         sysbus_create_simple(TYPE_ARM_SBCON_I2C, i2cbase[i], NULL);
     }
+    create_unimplemented_device("i2s", 0x40024000, 0x400);
 
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
-- 
2.21.3


