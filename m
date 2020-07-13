Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349E4C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043BA2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WO6+T7xV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043BA2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzBx-0006k1-6T
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAo-0004vC-19
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:51354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAm-0006c3-9L
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id 22so13464976wmg.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ThbookUz1zgsdvCKld312FzMkynGTVCEmFDPRgdidJc=;
 b=WO6+T7xVUb+gHhYwaQj8LyFgWWriMtvap0ZmQ/asqALD0XK0TWPBod5ylUg1bAwU3N
 pf5aYrzrgvOBPHnaAJjAv4X+jyT6yyOh+3GR5zW7UY6l29QKo/ZC1+crC/lSSDL7aKeT
 OuDAKEVAvsjDLQs+7+o7XiGEi2gkQ4Adj91aM+VOkpQsTBGypHMxiat97Jd2ABO3rrmR
 FG4rORazyVDwbwQuQV6Flv+PCf9SyWwtmdNb6va1naJ0tbNoV9P/vFtYzQ5ldkbnO6oo
 4V47zzgtfqbHMTKckdg7oWtbV7ebugeKyJ2/KpcEVRanEhtqVhFAd9CTzUWo7hLiAzOz
 1VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ThbookUz1zgsdvCKld312FzMkynGTVCEmFDPRgdidJc=;
 b=uZK8BzTryJlH3F6zMgF0TIA2FuCVZvXZo3RNWpX2kCrYhziDWKrwN8FOB44D1K1GDV
 pHb2YSTFokAdbCL9WbqACbOkcPx/FVsFalpe6nbGZlZGMpRNZ/yjm1oGLKVs96huKjPZ
 TeFsdcCBHRb15JKy1diDr64gXnOGLcu8vOYR+YiqAy6U5JRXI8B+MNjWjNTxbBKzETu0
 WNLvp2/G8qfrCM8x+FJTZCX4kYM73WNK6msP9cVygZss+rK+5uN488r2f9s9hn16SnKX
 6HqwoAPp2NrHTZUIpo1o7bhlIMmtWljCib5g4+985mchSbpk75Moj5ZERV8eiNAbEQ1Q
 bi6A==
X-Gm-Message-State: AOAM533zdWIWmvtV9CRaMqo8XNKKIVtdXQuQQXRvODyu3MMOXKCkJPDu
 rPw7q8uZqNimoCboBqQOqjQ/YBFI/gaRGQ==
X-Google-Smtp-Source: ABdhPJwV4fvk4EvqSETggtljkJDYK5w9xJnfKq72BH29gJIvAMR6lE0RbDfcHjp8tkRNcqmz20fR+g==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr159718wmi.148.1594649470383; 
 Mon, 13 Jul 2020 07:11:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/25] Add the ability to change the FEC PHY MDIO device number
 on i.MX25 processor
Date: Mon, 13 Jul 2020 15:10:42 +0100
Message-Id: <20200713141104.5139-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jean-Christophe Dubois <jcd@tribudubois.net>

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Message-id: 9f8923ecd974160ae8f634c275b1100c2cbe66d7.1593806826.git.jcd@tribudubois.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: updated for object_property_set_uint() argument reordering]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx25.h | 1 +
 hw/arm/fsl-imx25.c         | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 9e228daceae..54ee1bfd780 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -65,6 +65,7 @@ typedef struct FslIMX25State {
     MemoryRegion   rom[2];
     MemoryRegion   iram;
     MemoryRegion   iram_alias;
+    uint32_t       phy_num;
 } FslIMX25State;
 
 /**
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index b4ddceae45a..08a98f828fc 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -171,6 +171,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                             epit_table[i].irq));
     }
 
+    object_property_set_uint(OBJECT(&s->fec), "phy-num", s->phy_num, &err);
     qdev_set_nic_properties(DEVICE(&s->fec), &nd_table[0]);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fec), errp)) {
@@ -315,10 +316,16 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                 &s->iram_alias);
 }
 
+static Property fsl_imx25_properties[] = {
+    DEFINE_PROP_UINT32("fec-phy-num", FslIMX25State, phy_num, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void fsl_imx25_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, fsl_imx25_properties);
     dc->realize = fsl_imx25_realize;
     dc->desc = "i.MX25 SOC";
     /*
-- 
2.20.1


