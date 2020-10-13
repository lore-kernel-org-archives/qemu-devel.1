Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A868AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E34920878
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfgRosG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E34920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSRHR-0000j9-4M
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 16:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSREs-0005uu-Nr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:49:42 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:54342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSREp-0002sU-QA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:49:42 -0400
Received: by mail-wm1-x331.google.com with SMTP id p15so141637wmi.4
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 13:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gOH6Q54y5+3ER9eqXc0qEYERFLAXoc2wlUjL0YVFDAk=;
 b=DfgRosG+nVYuSBFgCGpyby5/NTTaj+746Y2zNUvEuMmcK2fPOCZxBcQwS01wuIDDUh
 NzBBgyOcN4qp//vogkO5tHGNUMflMQUjp+J45EMynVVWXiT/ZNK6fTnr/qQ9AvaRrKie
 259D4Or4PvLFI7u8wbnz1wsicS6nlfZYBkrwMUT5tLCbSupWArujCmtHzum0U+H1N1is
 yDLUFJ0KPLLg+BWBqA5soF3zJaMjf2aEITQxxxVuI+/RrexAc2ig+DO6R9ibo3kgtORa
 k2DpXhtyfMD7RN4APxcX4DUDdOTo9BsOsy6XFVdJCBnrFs5WlAc0c7XOEIKY1oLbB8oY
 sCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gOH6Q54y5+3ER9eqXc0qEYERFLAXoc2wlUjL0YVFDAk=;
 b=IMsHKtbw63nr+/+SpejTHahGGFR08MWptWy5UG6WxvkR8HwPP9f2OK7uVy3ijx9m2E
 6RkN6ZmwL6DfkbpL+XdmOqnUHssoodqNE8nvEek2eFEM1miHjqxDafqMZgSGE4YaCSFb
 DGbSqisznp06CqDs5+rcd2rvdW8rgt9WvjBWp+YvrpUhgUGCr7wUmR7ScTF9vbZ/C823
 vya8Qrwdofwqj1i/0VSGW192WPRI2WEasQSuSJsosCMgznagNrCIY4fMu68LbjQYVo7/
 ZhZDzvCGYX1yHqbj1t+/Pmc74gz8CkYEPZx+rwLnce5G1MgIAyuYgBXNUjcsOIhlAMU+
 S7Qw==
X-Gm-Message-State: AOAM532eViy+OV198H/d15bYglDupHqW6CJ3kr1Rur56+EuSD/Y9+kee
 hgLscrGxLsoA/B5fiaXHOtrGBXh/llA=
X-Google-Smtp-Source: ABdhPJxpnTXUtFP8iTI7SqGS2RLgkGowP5G6P7QV3AciA5M0y4ij9MSgKkQKUhvzeKvL8EDv0P2KPA==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr166452wmi.84.1602622178176;
 Tue, 13 Oct 2020 13:49:38 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y4sm1001930wrp.74.2020.10.13.13.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 13:49:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/misc/mac_via: Replace via2_irq_request() with
 via_irq_request()
Date: Tue, 13 Oct 2020 22:49:26 +0200
Message-Id: <20201013204927.3660030-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013204927.3660030-1-f4bug@amsat.org>
References: <20201013204927.3660030-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/mac_via.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 9e64c2521fc..54088b6625a 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -362,22 +362,6 @@ static void via1_one_second(void *opaque)
     via1_one_second_update(v1s);
 }
 
-static void via2_irq_request(void *opaque, int irq, int level)
-{
-    MOS6522Q800VIA2State *v2s = opaque;
-    MOS6522State *s = MOS6522(v2s);
-    MOS6522DeviceClass *mdc = MOS6522_GET_CLASS(s);
-
-    if (level) {
-        s->ifr |= 1 << irq;
-    } else {
-        s->ifr &= ~(1 << irq);
-    }
-
-    mdc->update_irq(s);
-}
-
-
 static void pram_update(MacVIAState *m)
 {
     if (m->blk) {
@@ -1238,7 +1222,7 @@ static void mos6522_q800_via2_reset(DeviceState *dev)
 
 static void mos6522_q800_via2_init(Object *obj)
 {
-    qdev_init_gpio_in_named(DEVICE(obj), via2_irq_request, "via2-irq",
+    qdev_init_gpio_in_named(DEVICE(obj), via_irq_request, "via2-irq",
                             VIA2_IRQ_NB);
 }
 
-- 
2.26.2


