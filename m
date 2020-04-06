Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2C8C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30CB52064A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG0uoRxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CB52064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLW70-0005Lw-AK
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrF-0002IU-VO
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrE-0003FW-JW
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:25 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrE-0003Ch-2u; Mon, 06 Apr 2020 13:48:24 -0400
Received: by mail-wr1-x42b.google.com with SMTP id w10so515426wrm.4;
 Mon, 06 Apr 2020 10:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iPAKPkoi+HJFf28A5mZBn3JxaePmMb+vKpWg/g7b+Dc=;
 b=GG0uoRxUc8+VfK7SEVrlqHXsr7G6RT3PJlLFsn6OGv/t2KmIJPUbKP/whI/BTlWqnO
 1qxz/Itc2t7BK9pKeOkjDP+OZrLaapNGCwHA2LWy/q7G8PV+V9vh/ic3XmnYhJffKiaT
 WcrXEmAzgarapZSoF3Hq6rr0y+94bE4CCk0/sQxjYEiEWy2AEC20KzoHLOm7p+O31bW3
 gvAf4lEdziS8z4xnndf4riyap4R1nazyl4+x3ZF4swdiH8MEY8J80gN59vaQNPztuqVw
 b7j+75uDJrOCK+8cc8rgCX/ykrR3zAlhBgnNaxN71zsvGpAZUvWLzDAzvx6Oc8kT4TuH
 TMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=iPAKPkoi+HJFf28A5mZBn3JxaePmMb+vKpWg/g7b+Dc=;
 b=tkk1vMzhnrcwxlc7RqdW4nwmGGl1p0NryRgkJQ1gxTRuuB408VSipDDwM17WeSWqCR
 by0hR7aDGKBH18bUJNJvE4noeWSRgue2UYgPqNSUul5EtXROEakM1LPBJ3Ipp/DJQGk2
 mLHbnbLVhHxb+yFDkGPQea/0jdp/lXNek47CiMTXLmmXpga5Sa+vF3wbIq3eBbJQRLcq
 42Ux/IKwedTJ6rdrRiZ6qr5ahE7QYVv08Mmhfmw93Z0Q4hvIOjJA4Fm2KW5LiJPSAyys
 HEE+tngv7fZNW14DKX0moee/Sg55dEKp7tehHnh9JlUcsVcR7UeM87GrYjS2d7BfsxXd
 m0vQ==
X-Gm-Message-State: AGi0PuaLPg/+gvE1g3wRaaGwMONxLjG2ZRkc0gJZYQyYTgAzVpAodwUm
 jvwoUBgspUnU0Ki31aCQ+b9RbZT8Q74=
X-Google-Smtp-Source: APiQypK7A9mPm3O15qzUuzUEuuvqsU2cICUP2VTTYb9l8/WD5tnJHA2Lz9vO3G/E/yYKIY/ZrZL7Lg==
X-Received: by 2002:adf:a347:: with SMTP id d7mr350873wrb.21.1586195302796;
 Mon, 06 Apr 2020 10:48:22 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 27/54] hw/arm/stm32f*05_soc: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:16 +0200
Message-Id: <20200406174743.16956-28-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:STM32F205" <qemu-arm@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/stm32f205_soc.c | 6 +++++-
 hw/arm/stm32f405_soc.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 76b0b0e9be..b1be4fde40 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -106,7 +106,11 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
-                                     "memory", &error_abort);
+                                     "memory", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 4f10ce6176..2b8a84a695 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -121,7 +121,11 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(system_memory),
-                                     "memory", &error_abort);
+                                     "memory", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
-- 
2.21.1


