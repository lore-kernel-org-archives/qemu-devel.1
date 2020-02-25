Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8297C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:00:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963C22176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpfAJJ9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963C22176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Ysd-0007iW-ME
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkL-0000NA-5u
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkH-00066f-5C
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:29 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:35849)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkG-00062l-U9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:25 -0500
Received: by mail-wm1-x32f.google.com with SMTP id p17so2858572wma.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d7xi3dVIX7J8J64QMOzYiUCiOj+8+itqf0kVFh9ZFA4=;
 b=PpfAJJ9IZTz9Ve/G52dW+av3hQc2qsyHVI5s2rQVdeuqT4ICpVrhmT0ETWLLsOjTrM
 nigTLKEGb3H9lgUult4poIt9TT9twq56KbBh4pzL3iMSUMEEzgPo50uYTaW5t6NPPJDq
 YHSJypct/c+9pEHYqLXT0cwHZfxqN6VC6d5mqWqpa5DM1DIzW/LHQM3R5e62eW9rthXx
 TcYASTp8e+FKVB44DcAYgWIma0QyfC8U2rkSQP/PNbVH2lMRup82DJowKeMw9RmnSqbs
 Iwf/AJtMvmTgOCMjQXKkI1QQhK5z01Tsg4VFze3F+tsbClZpPgiEeCOd/r7Nv3sj2X6W
 bQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=d7xi3dVIX7J8J64QMOzYiUCiOj+8+itqf0kVFh9ZFA4=;
 b=GcIeOf9oZyCHq9wvDHapRvmi/H3vvERhb3sXJjhpQ0ZiV5wCC9sgprK2ce8meINJ/5
 BdHTlw9bigdPyaRgSQhWZxbGGwr+Qp+HNe75nEMHaWYXzA7/+5Ap9ZvAmLg7i5fD5BqF
 25O4BsTZQUoWO8+WzSTp7mGRPOtn26HScwmdkMF9nie4qAbzfUzoYIa/oLQNpCBPp/E2
 mJy4x3717ontcieYgdyMEVntoeJHtp6fQUdCXkuebl18CIqZ4QRH8k55NeV1MG3kc6tg
 L+mlim1kpZaivWKqkUn8JeVZ18hbKxyXyWxc03YeqnS1xiFoLz0ogkHTF6DP3JA1vtuI
 sJFg==
X-Gm-Message-State: APjAAAWracfG2W6JvfeiGcEWl3xpS4IeniVaZbPxWoilXoNPJnqo3qdF
 FN6IpDYjtJmnVpgaPj5PulQUAKBp
X-Google-Smtp-Source: APXvYqyQzRdx2KoXCE/Ag7cy9DnZHDLb6VrhW9df1SJy6R2/Url+nTyKDlUl0nrnLoSgBU0bUoIJKg==
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr4905192wmj.175.1582631483752; 
 Tue, 25 Feb 2020 03:51:23 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 018/136] arm/kzm: drop RAM size fixup
Date: Tue, 25 Feb 2020 12:49:08 +0100
Message-Id: <1582631466-13880-18-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

If the user provided too large a RAM size, the code used to
complain and trim it to the max size.  Now that RAM is allocated by
generic code, that's no longer possible, so generate an error and
exit instead.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Chubb <peter.chubb@data61.csiro.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-19-imammedo@redhat.com>
---
 hw/arm/kzm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 1d5ef28..94cbac1 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -25,6 +25,7 @@
 #include "hw/char/serial.h"
 #include "sysemu/qtest.h"
 #include "sysemu/sysemu.h"
+#include "qemu/cutils.h"
 
 /* Memory map for Kzm Emulation Baseboard:
  * 0x00000000-0x7fffffff See i.MX31 SOC for support
@@ -78,10 +79,10 @@ static void kzm_init(MachineState *machine)
 
     /* Check the amount of memory is compatible with the SOC */
     if (machine->ram_size > (FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE)) {
-        warn_report("RAM size " RAM_ADDR_FMT " above max supported, "
-                    "reduced to %x", machine->ram_size,
-                    FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE);
-        machine->ram_size = FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE;
+        char *sz = size_to_str(FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE);
+        error_report("RAM size more than %s is not supported", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
     }
 
     memory_region_allocate_system_memory(&s->ram, NULL, "kzm.ram",
-- 
1.8.3.1



