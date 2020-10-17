Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2F9C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76EDD20708
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck0FbkPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EDD20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnKi-00042E-Dv
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmq1-0004f5-Fv
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:37 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:43716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpz-00044t-Sh
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:37 -0400
Received: by mail-wr1-x42e.google.com with SMTP id g12so6557392wrp.10
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=caX0J3KNwUejhzwLnMOSmDSfVNvC5iRRJWagljbsOKk=;
 b=ck0FbkPUrdz4mwnnM3EyhjmHiIqnhCR5WdHBavj8JPCjQ/3/gyGW7PeeeHLN2/0Ihk
 bKAKMOTxbMPVlVOABagTYXeMr40766AtyMHUwqKH7ufnmgOH24zVseMgDavPxTksZMQg
 bEZD2/O1RQvZAUyCmRa92uXxmckx3d9rnKSc9ZWVXcmKDZdD3fgGXA5le3NFxw9m5uYU
 bZ7rhIH8kIiUoMD2q/umODCgrbVlltEDAOEjJ1XRwlLg1TPh+No9+V6aLmzXkv8ZyqBq
 6JJB8MurPVsiI+WK8D2STzSD9MTmfNqogPmEKykNsnxxWJIge0jFX4hq7DlpsL1S7Afb
 OqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=caX0J3KNwUejhzwLnMOSmDSfVNvC5iRRJWagljbsOKk=;
 b=TeKnJxatzFYxWnqER6kGKK3jJ2aLsg6QFKEkzwVD8+cMWhaWQPx9Y2C9l6O8uUP08n
 kXzEuHV2Nt3m/QSOazmzGNJ56OoWIFKI1mtbrKNSbmB3rnQjjlatnNQOwcVxB2jUbm3D
 M0NhRoFMxPLZKU0YM54AFX8VxHO1UwHAd+2mKUSt/FZzjnp0Mb1w6AJ7TaDw+aFV/5Aa
 lW6CFoMfG/amKKggcXeJ7gTLTBzyx6vWdqQ5HK1Mgd1oxGc7am4aKz6byoU1MUMIXRcv
 GxByGztCy4ula1r5LM7P/e6iGAcs0HNH+tSntjgCS2hB71y/u8XffU5da90Eu5ioTOfk
 L90A==
X-Gm-Message-State: AOAM532W7qz/Rwy4FmkKjdMG61bW6OgiGsQ5RYcfzUyS6oYaxj7VHdA+
 jlN/BgW56kDhBBZuQoS49wUWhN8wiXk=
X-Google-Smtp-Source: ABdhPJz9AuRcxJaUzRsYHKt34wzsz1mIZOJ47V5Ha8DNGC4cmMEEQAKetV/nq2Xab+fEQMZtTU7uog==
X-Received: by 2002:a5d:4409:: with SMTP id z9mr10121883wrq.236.1602943534305; 
 Sat, 17 Oct 2020 07:05:34 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id v189sm7976153wmg.14.2020.10.17.07.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:05:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/44] hw/mips: Rename TYPE_MIPS_BOSTON to TYPE_BOSTON
Date: Sat, 17 Oct 2020 16:02:35 +0200
Message-Id: <20201017140243.1078718-37-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200902224311.1321159-19-ehabkost@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/boston.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index cf2296f4488..74c18edbb34 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -44,10 +44,10 @@
 #include <libfdt.h>
 #include "qom/object.h"
 
-#define TYPE_MIPS_BOSTON "mips-boston"
+#define TYPE_BOSTON "mips-boston"
 typedef struct BostonState BostonState;
 DECLARE_INSTANCE_CHECKER(BostonState, BOSTON,
-                         TYPE_MIPS_BOSTON)
+                         TYPE_BOSTON)
 
 struct BostonState {
     SysBusDevice parent_obj;
@@ -262,7 +262,7 @@ static void mips_boston_instance_init(Object *obj)
 }
 
 static const TypeInfo boston_device = {
-    .name          = TYPE_MIPS_BOSTON,
+    .name          = TYPE_BOSTON,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(BostonState),
     .instance_init = mips_boston_instance_init,
@@ -455,7 +455,7 @@ static void boston_mach_init(MachineState *machine)
         exit(1);
     }
 
-    dev = qdev_new(TYPE_MIPS_BOSTON);
+    dev = qdev_new(TYPE_BOSTON);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     s = BOSTON(dev);
-- 
2.26.2


