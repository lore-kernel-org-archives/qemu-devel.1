Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2A6C33CAA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77EA3217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeHUlVgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EA3217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itfCJ-00082T-An
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6o-0001Z1-Hh
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6n-0005q5-2s
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:22 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36869)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6j-0005nT-NX
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:21 -0500
Received: by mail-wm1-x342.google.com with SMTP id f129so933061wmf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PgExqrTGwY7vrn4B1c+MG4krYS866xKGizW5SQhXiUI=;
 b=FeHUlVgt5lgtH4sYtv46yYy96b6RnMFqiCXToC4zAldQ6BDCp49Pcvcx3G4Zue8H3h
 7qu5isu5R9hPYet1c0VW2TjvoJWeDYl9Tqdvtn00dNV8sBgZOsfZ0q2ehMLvZ4ZPmCUZ
 R8JKdl9wuCvqf1xkF6hZTZP7b2As5itfR7pmdiqS4nMVukIsdMMU0UkGymGZRWWGc9EF
 UsEDgoaoqYz8h5TKGiNWw+5FJE7DIf9vXYCSqxfZW6oA7hYiE4M51Ds82W2i5igSNNm2
 6PZ0arLVbYURDLy94dNu1rBA61M5l5a/mnApSyk31lWKNXGnvHeWKXrvc4caujNkDGmU
 BhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PgExqrTGwY7vrn4B1c+MG4krYS866xKGizW5SQhXiUI=;
 b=QnC/PdYmnFP7HrmjUM6bUTpxdlCLi09AB3xpPx6iy+aZ0oa4oftlukmZysR5C4wE+1
 T+pSUmUZXfq9eHOGb1YXfh984nB7ThQnWGnsPQN8/SzMSs5Y1pkSvbVKOAem18VC3SaN
 l6Xx9pizgRNGbBvnJOaL8nzCTepppiL7R7xrJh+n+E4iv7lAilMUpaPfJ08srD6lVhai
 QvguVPlT2bAsAJFHZ78rSCCY9GPEg0DivTc6GL6V6LyuJFTP18NlWVDCgW4x+WZihR+f
 CS9zcr7cay3Jm2AL4IArjjbhhHdhrHaSTuSc6xVDga3kZRBeOV2vzYRNL7LooNTzi2f5
 pS6A==
X-Gm-Message-State: APjAAAXhnd/WExDuiL/Z5vy8sH/eWZA/ryAhC8Avg6V5dKHH7rmXLDIR
 TfqPXh8GXEi/+uQQ8ODi+o2KfI84
X-Google-Smtp-Source: APXvYqzUe3C0CkyTNZj1F30dRNwV6ahcZe8bINEMUphMigVFNuGU1QtMkBFXeDaVbM0bunH+L0iilQ==
X-Received: by 2002:a05:600c:2108:: with SMTP id
 u8mr833358wml.183.1579557676673; 
 Mon, 20 Jan 2020 14:01:16 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm904341wmc.45.2020.01.20.14.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 14:01:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/18] hw/char/avr: Reduce USART I/O size
Date: Mon, 20 Jan 2020 23:00:54 +0100
Message-Id: <20200120220107.17825-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
References: <20200120220107.17825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per the datasheet the USART uses 7 consecutive 8-bit registers.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/avr_usart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index cb307fe23d..becdb87847 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -280,7 +280,7 @@ static void avr_usart_init(Object *obj)
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rxc_irq);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->dre_irq);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->txc_irq);
-    memory_region_init_io(&s->mmio, obj, &avr_usart_ops, s, TYPE_AVR_USART, 8);
+    memory_region_init_io(&s->mmio, obj, &avr_usart_ops, s, TYPE_AVR_USART, 7);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
     qdev_init_gpio_in(DEVICE(s), avr_usart_pr, 1);
     s->enabled = true;
-- 
2.21.1


