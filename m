Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838DCC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D99D20679
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxyBq/CT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D99D20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSbm-0001XR-JQ
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSF-0004c4-Qr; Wed, 17 Jun 2020 03:25:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSE-0002am-Bo; Wed, 17 Jun 2020 03:25:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id x13so1158111wrv.4;
 Wed, 17 Jun 2020 00:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cg5OZZgeFdkySmBsDID4sS8qarnHbFdRK4wloQNjZ2E=;
 b=WxyBq/CT8LXOW4E5V+/A0w8zrfcbhF1dNDtfG6ReYLAVJtIVIq60RQmseVEBmok4QQ
 7mVoAygiKuIx9lNekuRaAwh+SBz2MkDQmeT6xipA6vVlM4Xuc2IFO2tVa6lTedvZ2lfo
 x3Gnn6entwDK9FcfROKe91PEAQzIiQL7S3EDditKhZXkaXrNlN6IOnpfTRc+D88BQcZL
 usX6+0r0pe4L9Tvvh57gb0yFH6HM3fl35EphYuI7nGwUOJiHG/ytt+zxgCwU84/s0S7m
 7zIlJz4m7jW2rCr0gmbpQrV4+z4Ap2MJ544oJOuyEGVPDDQTUMUcXNsM8F6k/t0tZX+U
 0O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cg5OZZgeFdkySmBsDID4sS8qarnHbFdRK4wloQNjZ2E=;
 b=Sv4oC0EQDQvS66p56ssmZeFWRiD6gwv/9NQWqcGSnFKzzROEjhMkzRpG8GFSuDIAo+
 /4Al6thJTbqsHEsfaqnZLf49vUdQmS64CRqjveijZV2+QP3Anl+v06DFm3H81b5xI6PQ
 5SZHiUbsFEP8ZTG2ZWvi1e5dZ7wKGU/Oh0uN2Txx0v4hzBNd9cnWySRYrlzZzDV+sTlV
 bCsVAXgQoiXPJR8OJcem/pVVpyX2Wbt6ur3c6nd5nnLAQduoNCnsQHp+86Ig6CjPXrMf
 gw+JFfNHWy13drGAUnmLeV8mbs9yukCNJZEem6D/K0n9VzrgZ/0bKxx6P0eA+0XFG/wB
 kLRg==
X-Gm-Message-State: AOAM532z9VS8te6vjtcs6/lol0/TsjjS0V758akZvRIFMKLGw1C2WG3T
 2cXPM64dYs9fDXvzDphzocCWbo+f
X-Google-Smtp-Source: ABdhPJyc7+CALWLO+rIqmvQiRPxJ/Ga7GBYa666G1mSH9fHq0m0vgOrjm1uQ6U/HPWtgxUBJixMScQ==
X-Received: by 2002:a05:6000:108c:: with SMTP id
 y12mr6678792wrw.88.1592378748225; 
 Wed, 17 Jun 2020 00:25:48 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id j5sm32894781wrq.39.2020.06.17.00.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 00:25:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/14] hw/arm/mps2: Document CMSDK/FPGA APB subsystem
 sections
Date: Wed, 17 Jun 2020 09:25:31 +0200
Message-Id: <20200617072539.32686-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617072539.32686-1-f4bug@amsat.org>
References: <20200617072539.32686-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
 hw/arm/mps2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index daa55f730b..ee555f919d 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -65,7 +65,9 @@ typedef struct {
     MemoryRegion blockram_m2;
     MemoryRegion blockram_m3;
     MemoryRegion sram;
+    /* FPGA APB subsystem */
     MPS2SCC scc;
+    /* CMSDK APB subsystem */
     CMSDKAPBDualTimer dualtimer;
 } MPS2MachineState;
 
@@ -299,9 +301,9 @@ static void mps2_common_init(MachineState *machine)
         g_assert_not_reached();
     }
 
+    /* CMSDK APB subsystem */
     cmsdk_apb_timer_create(0x40000000, qdev_get_gpio_in(armv7m, 8), SYSCLK_FRQ);
     cmsdk_apb_timer_create(0x40001000, qdev_get_gpio_in(armv7m, 9), SYSCLK_FRQ);
-
     object_initialize_child(OBJECT(mms), "dualtimer", &mms->dualtimer,
                             TYPE_CMSDK_APB_DUALTIMER);
     qdev_prop_set_uint32(DEVICE(&mms->dualtimer), "pclk-frq", SYSCLK_FRQ);
@@ -310,6 +312,7 @@ static void mps2_common_init(MachineState *machine)
                        qdev_get_gpio_in(armv7m, 10));
     sysbus_mmio_map(SYS_BUS_DEVICE(&mms->dualtimer), 0, 0x40002000);
 
+    /* FPGA APB subsystem */
     object_initialize_child(OBJECT(mms), "scc", &mms->scc, TYPE_MPS2_SCC);
     sccdev = DEVICE(&mms->scc);
     qdev_prop_set_uint32(sccdev, "scc-cfg4", 0x2);
-- 
2.21.3


