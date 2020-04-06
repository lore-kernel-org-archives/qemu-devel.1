Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ED4C2BA1B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A90D20672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePE6RsG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A90D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWMX-0007AN-Fg
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrS-0002Wy-98
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrQ-0003NH-6P
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:38 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:37133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrQ-0003Mq-0E; Mon, 06 Apr 2020 13:48:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id j19so224931wmi.2;
 Mon, 06 Apr 2020 10:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=74G8KHhadiGPyGitkFydcSDSAs1meyukZBFpYk9pD6I=;
 b=ePE6RsG1CEc0Y4fP5dt+8+emPTpD/Ih7zbwBNWAwYrK2Zb9fi/4BGDmqYGl3IHioN6
 THNjNH8nzneT5eGy7s0X78BpMzMOnUMXXStcISlrd/t0Tow1q8AOosCwUp5jNj0nm+l8
 DppPSo4hJosWL/XGXEth0TSw4LUXXXrVdpF3g3fYQ4PYVfLHcHXn2e34M7h4mr7cn7Ol
 b8NTiSDNOwfPzzc2eOMaX+ipqrxer9sYqW7slYlo8GXfWjGMytVmQoM3wuY4jVc45PYs
 DKCUOapPDSU+XoFfYxhX336mvL9LLm79YKlTrhmwuOsUtrab5xeFAkGJ1w1AaHSmO8jN
 V0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=74G8KHhadiGPyGitkFydcSDSAs1meyukZBFpYk9pD6I=;
 b=r1OQ2O4QOTPMve4kGkBXUCgmd0H3Qa3DB4aMaTC2MrvcBi8h0D6FHeDKGceoUfuc5v
 xS0aN+F7McG4w8wJeOMYpCIb0t5sGKoFlZrcV+1lbm/AMoTVnZtVZS0FWXctBN86GMha
 zXb1mSWbiMtPJ6sK32KlAY/AhRxTBHWI/zkWoQ7rrqJBT3WY95Bu+y8Gwwd6Gh3KIR4U
 4h/R/ZxRr2V76Qq6LaNc6l/PZs3hI9V2UknUwmVZ0spYg9OxdV5aOpHu0AlwWeAar9+c
 mdHECBJBivfBWz/CtojIYIVVxHFlIyhhkdrICa/NNaScPXZJIhKY0Q98wngnw/ghYjf4
 iEkQ==
X-Gm-Message-State: AGi0PuYdyVYe8Nxg1YNvyZfrXs1zNOCuKLT1646oZdyzu8aweGiRmfHg
 ZC+o1jEFVnS5TlTfZzP1EFN0JMTOVTY=
X-Google-Smtp-Source: APiQypK/q/IVYaN6qURbBPVowpIN1qrXinNowX2GLuV7bUI18lWfmeH+KGKl939DsEJA6OJOZNVxag==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr476504wmi.31.1586195314802;
 Mon, 06 Apr 2020 10:48:34 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 36/54] hw/block/onenand: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:25 +0200
Message-Id: <20200406174743.16956-37-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/block/onenand.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index 898ac563a3..1f68dba28b 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -810,7 +810,11 @@ static void onenand_realize(DeviceState *dev, Error **errp)
     s->otp = memset(g_malloc((64 + 2) << PAGE_SHIFT),
                     0xff, (64 + 2) << PAGE_SHIFT);
     memory_region_init_ram_nomigrate(&s->ram, OBJECT(s), "onenand.ram",
-                           0xc000 << s->shift, &error_fatal);
+                           0xc000 << s->shift, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     vmstate_register_ram_global(&s->ram);
     ram = memory_region_get_ram_ptr(&s->ram);
     s->boot[0] = ram + (0x0000 << s->shift);
-- 
2.21.1


