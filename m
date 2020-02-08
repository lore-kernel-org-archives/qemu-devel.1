Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A2FC35242
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 17:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6585C20733
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 17:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnUYEJaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6585C20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0TZs-0006Mg-KL
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 12:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPt-0005pV-VG
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPs-0001kd-TO
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:13 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TPs-0001jx-NK; Sat, 08 Feb 2020 11:57:12 -0500
Received: by mail-wr1-x443.google.com with SMTP id k11so2466698wrd.9;
 Sat, 08 Feb 2020 08:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p0CIm4ZyNmzBVoqBIDDC/4y2EAVfboHjJlAZjEgSztE=;
 b=pnUYEJaVU8+Xl58FKRdO4JOjksL0si64wFTdea5tr+GkVN7pmE2QIAf+bV+fg+90H5
 9qUKjzAQ0vJg/zb/0xCnlCUP1w3eLIsfs2P1C1EYInLLDyEX7h4Bw/h/DAQV5IFrtF9y
 8Mhklh94hQCB0WljY8+pbZ5KPDDvj+mYfoYBsQoRRohJaevZ28PqerjMSgIOv46alWHQ
 31HPUOz1a0f5ens1Sk4YYSf4xPPsqZekq9frznqhUijoAktGzWUo2ZZlNA3ysjhT6CoT
 nWHQACYQe2U5j9dR+BNqzDGl9htsun1eOr6xygkImZdA1DbCfQayKpIzNLTN92d6m0Fs
 BVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=p0CIm4ZyNmzBVoqBIDDC/4y2EAVfboHjJlAZjEgSztE=;
 b=ZBa2vcueQ5u1xZ+FKk2GkTUSxP0bmwvRGvFiQ+REuk4qP3pIe1Iq7fLiFgiVkIZ7+U
 Isu5DPzHJNuuupm0Fu755ySbCdhnymztdhB9/kTTf5GiN10JF/RV4fu5BNBt/pfmSEzG
 Cf5W5fPwBSRCggXnQDSgXzbzEGbM6pY3FCz6cZldCXrkHlRMa4NXCHB5KN05N79QdNnw
 1D37KFdBuPmPDqMWIBbP918mlvK7T5DoTJ/q+C/LNvzL6fxlz+I971datzuMO3hslK3I
 BWeNobO0NOhXpTNEs1X06lqepPW2YkMmmsA93wJL5XSr3qVbF8gdE8uu0scCFGGoUKBn
 Itcg==
X-Gm-Message-State: APjAAAU7wqzAsE3wKRyD0rpaPP2MuI1HVIE3TYFZvjlIip96EPzzKGZw
 oTAhqxO6KgFGLTL2j5ONUOVrYNV1
X-Google-Smtp-Source: APXvYqzLGb0CHBz/BoAxnqK1EKwMATPdV9oSxFoAOvAy/EA+JA3TYTZWkg8+Ud3g0yUwLClf+nme2g==
X-Received: by 2002:a5d:4d12:: with SMTP id z18mr6158740wrt.139.1581181031477; 
 Sat, 08 Feb 2020 08:57:11 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a5sm7872763wmb.37.2020.02.08.08.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 08:57:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/13] hw/arm/raspi: Trivial code movement
Date: Sat,  8 Feb 2020 17:56:38 +0100
Message-Id: <20200208165645.15657-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200208165645.15657-1-f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
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
index 7a2ca97347..b3e6f72b55 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -227,9 +227,6 @@ static void raspi_init(MachineState *machine, uint32_t board_rev)
         exit(1);
     }
 
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            board_soc_type(board_rev), &error_abort, NULL);
-
     /* Allocate and map RAM */
     memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram",
                                          machine->ram_size);
@@ -237,6 +234,8 @@ static void raspi_init(MachineState *machine, uint32_t board_rev)
     memory_region_add_subregion_overlap(get_system_memory(), 0, &s->ram, 0);
 
     /* Setup the SOC */
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
+                            board_soc_type(board_rev), &error_abort, NULL);
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
                                    &error_abort);
     object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
-- 
2.21.1


