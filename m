Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA94C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37FDD217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTdA5HCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FDD217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itfEy-0003HG-OI
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6q-0001au-KC
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6o-0005rg-N1
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:24 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6o-0005pJ-3G
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:22 -0500
Received: by mail-wm1-x341.google.com with SMTP id b19so895367wmj.4
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KFlHsYD314AzFD5CqSiDjK4Q0Xckkln012an+E5d5po=;
 b=BTdA5HCsAjdY3W6kZaDCC8eVXhMfoqzR6bXvko8qunF4PRJTYV8dAxYFbW/p03kYzP
 yC8iR3weIp95Wb2FC/meU9RInlIJX0/pxsMj9MxvAzBW19VZZqvXUj1hZ5E9LsO8EapL
 QD5m4otVZ54dQM15gmBH9RDuhIkTsNLut+iu0omNQCv7iGwH5359X3ROqiubv8Qe6cqI
 KtD5NqJEtM5NcO7yWnxEOYN6dgVzjRqdufgbWT8ApIwwfLdXvylDaOUktpxfp0wIljK1
 Wqt7BzAyqtOfR22WgHlp9m83AOzrxYe0yJjX+5mp9llfRvPe5FbIOnAQau7q4jKFOXim
 HKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KFlHsYD314AzFD5CqSiDjK4Q0Xckkln012an+E5d5po=;
 b=UL6od6rlJ4z9F+rMJ911Aa8+qFUnTwt6AERNvo81TCsuO32uRn721jr9/j4TTHzo6p
 5bEY/VItS5ySMrQ3kRhzKrGHN657qqGhLbUsQoGDRWwWMXBk1IRJIfyPkhiOHXSVSX1f
 07SHv7GLfGGWY53qiOAm4ou3dPD10vdCov5HLEMgJ1tTB/n++cmPen2XLVVtCaHyOjFR
 DKuVwWa86DFRKZaKUfHjRg5HrGf/OXkC8hEwuP7w9AoSv6vPx40B9Xe0uFmNS0Kz2BJh
 oitN0RUgsr58QhlE3js+VA5O/58h4gPuRccmm6Jaqu+3aNXsaoBOFIN/1Kj3HhYPdVSX
 YqaQ==
X-Gm-Message-State: APjAAAWy6cykn5uD3QLD9O85RhEz7WBp4Y67h74rmc9Y6AT8pYDYenix
 U2lRxdD+MLz/lXZTqsPUvZoly21P
X-Google-Smtp-Source: APXvYqxEJOk6i9I5V3EHHzsjoey36rQ+/Bps5Q7DwAsfgKYGI7Zgg9hHsqUQ9xJqTDHJwuGkmCtzLw==
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr848200wmg.163.1579557677877; 
 Mon, 20 Jan 2020 14:01:17 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm904341wmc.45.2020.01.20.14.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 14:01:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/18] hw/timer/avr_timer16: Rename memory region debugging
 name
Date: Mon, 20 Jan 2020 23:00:55 +0100
Message-Id: <20200120220107.17825-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
References: <20200120220107.17825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
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
2.21.1


