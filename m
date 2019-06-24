Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84B4C4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AA820665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUPbJUzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AA820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfX6C-0001VJ-OL
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54786)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX22-0007ou-4u
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX1w-0003oR-5x
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:43 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX1s-00033n-HY
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:38 -0400
Received: by mail-wm1-x341.google.com with SMTP id v19so807816wmj.5
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7EKnYYpyGahwvPODw7K+rdbzpGs5lyX2fVIZtlw39Ss=;
 b=HUPbJUzp6naDPiSwVSrTpjQtDbZCEXj2cgITN39xZ8EunxLI0qageWQUHIebM+4l1Y
 XaOKHqKO9gZcC50S1jR4EllADgWgNG+gmt7UdqB1hXTuWGk4KFRWteSfZ5cc0yyytfx9
 wpKDO5EbqfSRnGRkNEKDNJ+W3pNruML4Jqjnn2qWr9FVDDzUVuANltydxhGa4kszP8oj
 g9RxQhq0+dcd18cLZFq6FnIymn2DyhCY2pi+s99WYSJyvJPa8/TOiJ+XYCSDtgy+huqt
 gCg9jNtsXWo19qgzz/jFYYVpMQ1OPbW25J9X2AnUWiI0blFsdB8ySiXBFJJn2h2w/rxX
 8sJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7EKnYYpyGahwvPODw7K+rdbzpGs5lyX2fVIZtlw39Ss=;
 b=LgefAkbF/3tqmyK+TfL7XKlwCM0o/rtvlcfSF3QDqAJBjHJdShLg0+nYG93Tce6gL+
 1tUGMWkVf10V0hsOEZE8/NJwHu7MwvmH9gaYGrG+5/BJULybUPHBhxZn7uB3EVjblsfO
 ima7HltFQbKYrusMSkZYftfP3YGApWSDA3NAGxlKVGLWD+Brml0G3FNsrQnRozQFR0J0
 /NCOrQtQ90kommaAPdXU2ZNekR6yx8NACLXj8o3P8dRFDLY47DIWvh3XuEMTw2C5krVe
 s7fqQ4mdDF5zlAD4E/eMzkY9y6gl6e4RXe7GgOVgLRLMhRBk1hV8krXgoB+vL2F0qtvt
 TRXw==
X-Gm-Message-State: APjAAAUHZoKgk4iZ8PRs8xqKVJplSp0rfcjYfZDlXDfqdgoG5maUiJvi
 Q6zyU3yvtqHrdsDjn5ztvS/R8kSV
X-Google-Smtp-Source: APXvYqzrYVm6NXE2JYf5KrL9FmnssWwgsfD+6CgcTrDGvAYAxebTOIwGU2m1zN1CD0F1GQCmJf4b3w==
X-Received: by 2002:a1c:be0a:: with SMTP id o10mr17176260wmf.91.1561413662818; 
 Mon, 24 Jun 2019 15:01:02 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id z126sm1118612wmb.32.2019.06.24.15.01.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:01:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:00:50 +0200
Message-Id: <20190624220056.25861-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624220056.25861-1-f4bug@amsat.org>
References: <20190624220056.25861-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH 3/9] hw/misc/empty_slot: Allow overide by
 device with higher priority
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'empty_slot' models a ChipEnable (or ChipSelect) MMIO device
pluggable on a bus.
The bus allow such slots to be not connected ('empty), thus no
bus errors are generated when this range is accessed.

The device is mapped at priority -10000 to allow other devices
to be mapped on top of it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/empty_slot.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
index 0adf7a26dc..53299cdbd1 100644
--- a/hw/misc/empty_slot.c
+++ b/hw/misc/empty_slot.c
@@ -68,7 +68,11 @@ void empty_slot_init(hwaddr addr, uint64_t slot_size)
 
         qdev_init_nofail(dev);
 
-        sysbus_mmio_map(s, 0, addr);
+        /*
+         * We use a priority lower than the default UNIMPLEMENTED_DEVICE
+         * to be able to plug a UnimplementedDevice on an EmptySlot.
+         */
+        sysbus_mmio_map_overlap(s, 0, addr, -10000);
     }
 }
 
-- 
2.19.1


