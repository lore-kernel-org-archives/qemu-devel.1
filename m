Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00879C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED55206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2gka5dA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED55206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrgt-00022E-0l
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxre7-0007So-CB; Tue, 21 Jul 2020 08:45:23 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:44351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxre5-0005Nk-Hu; Tue, 21 Jul 2020 08:45:22 -0400
Received: by mail-wr1-x435.google.com with SMTP id b6so21046002wrs.11;
 Tue, 21 Jul 2020 05:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WTGLuOqhqj69Pag6VxaIwWSrmHIZ+AovhPPzMX0ni9g=;
 b=m2gka5dA1Mf7rnIYYF8c32Qxv3RtmbhiddSYDn03ji1AQU3cnbZEAPq3wWVsg+6JWR
 NjRyCfYnt1O5xTfiUh5gE8SL26WNzlLEGxSb/Vg3MhwkDFznlC/DHGOjxj1pewYs8erq
 Aj2spwDXuOOINKUv9KfUqGpej1oR5VJlWrCPJFy5SazLITBuVkdu/6XkV8zQ1AU9RV28
 wmQnRoZRnQH/mej4pP1Fl+7Dsr6UuqeiJdY1QyRZ2zlEXKWdUHc19D+GR4YJR+5yP4FH
 VVEaWCoLvM2hmpTC/pi3GHDjwgn1XGaxQTEGkrIrY6k5IZx1DMlBc2KHHrmE0YNJRF29
 QyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=WTGLuOqhqj69Pag6VxaIwWSrmHIZ+AovhPPzMX0ni9g=;
 b=WDr/Hfz1wUCHaDXRVoTnkPtV+heePmM0iUTSK/KuoW/BsvfFK9bFWiv2ueXNqnNq5A
 mnI+Uts/w9J2fFt5zD7i+sHnqKNCHZZreOxw9SEL2+E27RFtY0shDChpaG4bLhO8XhiA
 zLH7krGA7k+v6FIyAL3eHe+r5Ux2+bNDVaZI9kZNJwAcsGbyx8pu/8JM95QSPm5tLzmV
 cGO+AsDnfyygfnSw+C4C74avOO8KTqWPO4xk7Vj4yeHOIYZ1LHrGFy4IMUuZpotuPaxx
 FQ/qRka77iAqhiek7IQKRacJZaW+UqLBiq2HvDnKwPtGqWHwLv0iRbp86vj7Ovwp1MH2
 J/DQ==
X-Gm-Message-State: AOAM532ohsA61PjmQH6YoqsA8BiI6nsUaEvm7ydtInImcQfhhY+GvhSp
 gsBdeCkhjfooaRh+JbToeMPdTWyagL8=
X-Google-Smtp-Source: ABdhPJyeSv9jiDx3n+STX1b/clvP2PkK7WDE0QTluuDQ1dAwVE1wW4M8jyJVT7WhTlAhY0iWrU8xTQ==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr27197060wro.317.1595335518933; 
 Tue, 21 Jul 2020 05:45:18 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u65sm3499302wmg.5.2020.07.21.05.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 05:45:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v2] hw/isa/isa-superio: Fix IDE controller realization
Date: Tue, 21 Jul 2020 14:45:16 +0200
Message-Id: <20200721124516.9602-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x435.google.com
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When realizing a Super I/O with IDE controller [*], we get:

  qom/object.c:1684: object_property_try_add_child: Assertion `!child->parent' failed.
  Aborted (core dumped)

This is because the device is already realized when we try to
add the QOM property to the parent. Fix by realizing *after*
adding the QOM relationship.

[*] Set ISASuperIOClass::ide.count = N with N not zero
    (no such thing currently exists; the bug is latent)

Fixes: e508430619 ("hw/isa/superio: Make the components QOM children")
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Reword bug is latent (Markus)
---
 hw/isa/isa-superio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index e2e47d8fd9..179c185695 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -158,8 +158,8 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
         if (k->ide.get_irq) {
             qdev_prop_set_uint32(d, "irq", k->ide.get_irq(sio, 0));
         }
-        isa_realize_and_unref(isa, bus, &error_fatal);
         object_property_add_child(OBJECT(sio), "isa-ide", OBJECT(isa));
+        isa_realize_and_unref(isa, bus, &error_fatal);
         sio->ide = isa;
         trace_superio_create_ide(0,
                                  k->ide.get_iobase ?
-- 
2.21.3


