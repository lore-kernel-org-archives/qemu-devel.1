Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B61DC2D0D1
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472A4207FF
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR1OpQob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472A4207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilhLi-00049c-1m
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 17:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhJB-0002N3-6d
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:45:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhJA-0001Za-7r
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:45:13 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhJA-0001XZ-1W
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:45:12 -0500
Received: by mail-wr1-x442.google.com with SMTP id z3so31286113wru.3
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 14:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4mY/ASfFa+L6MgkG5wasYIvByt5ZiA6M1XaZ87Cc7sU=;
 b=oR1OpQob9K2Ra9I9/EFBke8w+PiGQpff2hBU9Rm7s4fLn08Mi7rM4QZd5hhoPZ6JXo
 Custs38ioiWVLfaIvICAyu/f6y4QNeEMMGAjH6tA0ejFuCIFOxvbRQCPOq7usAF93Hut
 SjNFKZBipJQVeblVZsREAwz8UyEN13jDu595IrDTZvPViekmsnWo4gx69z5e/HdXH8sV
 LI2K0b9dcTuELR/tECOJk1gL/pB/zGMH2B/5HXrxwlMTlPdMOXgoYi6U5bFRS4lBA/w7
 NSafNK++gWcKNLWZ1N1QLXCbvWW5dOTJabhfFZ0jCKgMvL4MjKpJNChhFonZwpkg8mJ5
 +f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4mY/ASfFa+L6MgkG5wasYIvByt5ZiA6M1XaZ87Cc7sU=;
 b=Q+cu9U21MowwhFHi1VlsEEiuM5D3tYxJn28vnV9yvi8/797iXkBKOMsrnUz9NVzKue
 6vSsWxjok3SK9JJhsdBmaEplpyddW8HUEukadiA3NkN0Bdx/qvo2PwcJYP+vR/8Jr4gU
 XB3VDlMHCUvRqjNMJECRzBkC5aspWrmXuqwx2zSEp2ntGq6CGRw+hVp00Hnx40kIY96D
 g6t99AELj2SRneIivLgnU1NFUdu3jvoXbrYl9ZdeOuH7duGMtx69yxkXTFYpw7ccOke/
 fUtmdzc+BrXQyZJjSxyJPWoaPgVhlNNhZP4Rh3FQq4PIDptvimqoEGsvNq429/8FRBs6
 8pZw==
X-Gm-Message-State: APjAAAXkEetHmGuggur0B+2kqFivur65gTUVP5GohMLogjAtUD7zN4M5
 8hPxAXSq4bu2+BjeXxCaHG20ZVrL1gw=
X-Google-Smtp-Source: APXvYqxMCxqU5MP3jhmSPrPNPK/2aGofPGmWl0uvOa2d7XBn/jhNlhxhGrYEWPvxqSmUAiwZ9IfOSw==
X-Received: by 2002:adf:f288:: with SMTP id k8mr66933168wro.301.1577659510908; 
 Sun, 29 Dec 2019 14:45:10 -0800 (PST)
Received: from x1w.home ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id x1sm42709188wru.50.2019.12.29.14.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Dec 2019 14:45:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/8] hw/timer/avr_timer16: Rename memory region debugging
 name
Date: Sun, 29 Dec 2019 23:44:59 +0100
Message-Id: <20191229224505.24466-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191229224505.24466-1-f4bug@amsat.org>
References: <20191229224505.24466-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This device expose 3 different I/O regions. Name them differently
to have a clearer 'info mtree' output.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/timer/avr_timer16.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
index aea1bf009e..a27933a18a 100644
--- a/hw/timer/avr_timer16.c
+++ b/hw/timer/avr_timer16.c
@@ -563,11 +563,11 @@ static void avr_timer16_init(Object *obj)
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->ovf_irq);
 
     memory_region_init_io(&s->iomem, obj, &avr_timer16_ops,
-                          s, TYPE_AVR_TIMER16, 0xe);
+                          s, "avr-timer16", 0xe);
     memory_region_init_io(&s->imsk_iomem, obj, &avr_timer16_imsk_ops,
-                          s, TYPE_AVR_TIMER16, 0x1);
+                          s, "avr-timer16-intmask", 0x1);
     memory_region_init_io(&s->ifr_iomem, obj, &avr_timer16_ifr_ops,
-                          s, TYPE_AVR_TIMER16, 0x1);
+                          s, "avr-timer16-intflag", 0x1);
 
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->imsk_iomem);
-- 
2.21.0


