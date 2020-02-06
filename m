Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F2EC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58FB20661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jyc0WFcr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58FB20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izVun-0001Op-RU
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo7-0000Hy-Vm
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo6-0002BL-UO
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:15 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo6-00024a-Na; Wed, 05 Feb 2020 20:18:14 -0500
Received: by mail-wm1-x343.google.com with SMTP id q9so4473833wmj.5;
 Wed, 05 Feb 2020 17:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W2XB7avCzY/On5eAKW5ymwIRtI2E5aDh8P+f+vF2jdQ=;
 b=Jyc0WFcrxYoKMiOxbcPKERxqQug5mK3/ZyHPNMIW3WFOT8LxPxDcBO17kVpLJlFFIE
 4hy98q/k4tobPbyxRmDYCWqVd3AxL+HNRy2kLrN4aGUITPthE4J2AZtFqdOFaZaJsqMp
 YY48MZOeKrlqYc1NXqgfM2OvT1RfwQGbdeMfyJk75HBvYkmvvHwXhpBfmuEBSfS2FOdt
 dldFCXO47BnmcK/55UWFP/oo1i7W8qY2cWV73FrXLRzqmmXdG2k9w6otEy7jIN6wSWPA
 o5KpxF355R0rFOmcgP0u6dphHQ2iPGPfg4T7UfCrGZnFkHoGUvaCk65gzNTg9APHTDqW
 fGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=W2XB7avCzY/On5eAKW5ymwIRtI2E5aDh8P+f+vF2jdQ=;
 b=Res+HPN/vS/iPwE9GvYW1SX5NhA7o4lYVKNHHxmWBQHiQuRtXR0W4bQ0UPGaENIFFF
 r+bF7BQJRg7bfPrjMXqNjgCtrAY8PR0s3N62Mi2HMksA0syHG4rlv0Lo90ft1eGR6y9d
 IWYIs48t++rVTm7AknrvpwpEns6fdcmjDoGmykKjIAkxXuFqFzSa/rIKAjQON0WlUmqT
 fHY7JFW3/qXqmlmzmmd4AMO1Lz1hfxErbjDKPIkpo3lYYz76fnmYiI136ES3+NqgiVdK
 T76jzl8VQXytdxXCd5mg5zPxInrrcdaKWrnF51+kBbpE0XFxe7+pi2dfXv5rkSX9uB6o
 p6Ug==
X-Gm-Message-State: APjAAAXCu5JIvlvKgezNJGNAroQURNQlad355xSPb37ZM2PYNvEVWq0o
 aFKW+dcaWrbu2Ydw+cYMrz1HmLdj
X-Google-Smtp-Source: APXvYqz85deY74w3KyntT+LwF1bq55/fJ8GhkiGkDO9Ok1137DIGA+7gf9B7K+pnFVBNgYF1E/w7lQ==
X-Received: by 2002:a1c:e488:: with SMTP id b130mr606177wmh.108.1580951893551; 
 Wed, 05 Feb 2020 17:18:13 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/30] hw/arm/raspi: Trivial code movement
Date: Thu,  6 Feb 2020 02:17:32 +0100
Message-Id: <20200206011756.2413-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 "open list:Trivial patches" <qemu-trivial@nongnu.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Laurent Vivier <laurent@vivier.eu>, Esteban Bosse <estebanbosse@gmail.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no point in creating the SoC object before allocating the RAM.
Move the call to keep all the SoC-related calls together.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 20195227eb..fab361939c 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -226,9 +226,6 @@ static void raspi_init(MachineState *machine, uint32_t board_rev)
         exit(1);
     }
 
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            board_soc_type(board_rev), &error_abort, NULL);
-
     /* Allocate and map RAM */
     memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram",
                                          machine->ram_size);
@@ -236,6 +233,8 @@ static void raspi_init(MachineState *machine, uint32_t board_rev)
     memory_region_add_subregion_overlap(get_system_memory(), 0, &s->ram, 0);
 
     /* Setup the SOC */
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
+                            board_soc_type(board_rev), &error_abort, NULL);
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
                                    &error_abort);
     object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
-- 
2.21.1


