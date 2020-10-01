Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08631C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 997AC207F7
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tGRiWZ4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997AC207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0C6-0005aU-9E
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsf-0005GU-M1
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsd-000309-Pv
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:25 -0400
Received: by mail-wr1-x443.google.com with SMTP id t10so6134951wrv.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1TKuqdKYSMqANiZvdGq2s6JBaVSnghGWY2T9WlsB/o0=;
 b=tGRiWZ4DG87JRyfWPN2OhkeTFYrZy09ZvFLNp/E5M78BzuVRoGIact4AmW+aogE4Wx
 n+hOS7nSSM6sc4wpaJsU/iRdVZq24BxNUV/SdRgDA81Wuf3L8dts6L7aehWZGnglHOHl
 QNdhHlACIsBgkAwtygFeaKMt/QgNFIGu8Jho6fAVC1plFLQQ7OD4/Ke9tPaCyfM+1JK+
 lP5YHbEQ3fF5+px7OjxvICEIur3wkgTYMMM+HmB+wkWikXKnrKLqh/27E2CxGTywUbPw
 gl5aYlrskTealvAP46yQJ72SZo33e6Kw0DsMpqEB6SKnskxbqeG0OZaa8M4gjXOXmpl4
 HOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1TKuqdKYSMqANiZvdGq2s6JBaVSnghGWY2T9WlsB/o0=;
 b=VHurTw87nRD0JXd9EcuvqfT3DYSf2TSkeGuRlfGmPs4dw+4JsTfXaVO/dgtJp2TRjt
 7DkaVAuiFtSk/1Qgw82aVVqvRQepaBwu6EAs+iV9aEwXvXIEv/qJggUF/M+CGa06H6Vo
 Uux4X0xbZCdbLEVP3+nwwgQ6XSSDKnwuXGFH3fQT/njZ0It7LEfhg6zdMJQUJ72NyyPF
 x4SeWT4Lh1PRgdkutN5tAaaTYBBr0P3j0JMrZfGCI1CjiO4qmGHZEYcv5y3TzIZQ75Xe
 Rq4NXh3k1dK2galnKZHulDS9xP6NgMBsdY8zBjYVw3HcvhszW9HcxcFatidb7Yenm+P9
 mEVA==
X-Gm-Message-State: AOAM533GTfqPphnqqlbhGCOBCyUOMwxwN/l3oKpUuJeA0oczyVi73qrM
 MzgSNkXEYU5Wj0J84EOzqxlHzrpxM6+FYKuz
X-Google-Smtp-Source: ABdhPJyAi/+YBZke/4hVDlYZOkGuB1GgV2JuKuGkGJddGL2BIrGNFKHq8tcjmlkZfiMR0e9zu0degw==
X-Received: by 2002:adf:e488:: with SMTP id i8mr10055037wrm.116.1601563702150; 
 Thu, 01 Oct 2020 07:48:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 70sm342052wme.15.2020.10.01.07.48.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:48:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/18] hw/arm/raspi: Use more specific machine names
Date: Thu,  1 Oct 2020 15:47:56 +0100
Message-Id: <20201001144759.5964-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001144759.5964-1-peter.maydell@linaro.org>
References: <20201001144759.5964-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Now that we can instantiate different machines based on their
board_rev register value, we can have various raspi2 and raspi3.

In commit fc78a990ec103 we corrected the machine description.
Correct the machine names too. For backward compatibility, add
an alias to the previous generic name.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200924111808.77168-6-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 3000e6d57e6..3426521379e 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -327,6 +327,7 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
 
+    mc->alias = "raspi2";
     rmc->board_rev = 0xa21041;
     raspi_machine_class_common_init(mc, rmc->board_rev);
 };
@@ -337,6 +338,7 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
 
+    mc->alias = "raspi3";
     rmc->board_rev = 0xa02082;
     raspi_machine_class_common_init(mc, rmc->board_rev);
 };
@@ -344,12 +346,12 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo raspi_machine_types[] = {
     {
-        .name           = MACHINE_TYPE_NAME("raspi2"),
+        .name           = MACHINE_TYPE_NAME("raspi2b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
 #ifdef TARGET_AARCH64
     }, {
-        .name           = MACHINE_TYPE_NAME("raspi3"),
+        .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
 #endif
-- 
2.20.1


