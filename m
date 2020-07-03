Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BDFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C360920782
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldiTWbkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C360920782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSCU-0005le-Mr
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9i-0008F3-3T; Fri, 03 Jul 2020 16:19:30 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9g-0001Vr-KU; Fri, 03 Jul 2020 16:19:29 -0400
Received: by mail-wm1-x341.google.com with SMTP id g10so11555568wmc.1;
 Fri, 03 Jul 2020 13:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5zz83s2aXXms/dZv8O4WT0VV9oFnKrxqm4zzQa37/7Q=;
 b=ldiTWbkdIwLYF3/DPDYXuf8mdH+9ddp6gI13TA9WuTbp0Wz4tqBi/J9Ba7Yrsd/FMx
 Q6B3uWhQEzhyEB6XBDiyupi1GwCfLZVnEFjR6D6+X2e5whIAJTzipK0bSw7sk71/RiWW
 nNMxEgAdFfhTdxHI5pebLbMhqWGSNTGOHSxgn1sAxqUzmu67mgn5awBaFbh4+CWK9AT5
 qQpSDu0nWqjW8ikXe0n/rPyGLT+et/XaMuPTcjOdMMM+B338RXSCpu+HRxfKnj7PlfUD
 w3GNmY4SOp0woMJyqHvQfX2qHkEIRTMx6oxvDkJBOKseCzCo31K/PfRmTFenn+lQBHbP
 FCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5zz83s2aXXms/dZv8O4WT0VV9oFnKrxqm4zzQa37/7Q=;
 b=E05uuifwNb4ev/WN4r2/Fs0PPiFjy8DQopPhc0DI9sY1/qs0Ce+wdkYD81pU1CaZhn
 Pjh768vpq8kniF1cFyYti4fpIZRnVTpcpuOKiVnqHBOaHZC7EU5Xa8gF/yvM/tnCIx4o
 zI76dfTuxwMqtVvGQ76Ko92zBpkRTz6mNc9Dc8fseK7WcoPr26zObxaliA5hJ56wriFz
 b8wg1F8iM8VFgb+Xz5bQMwu+KOKuXOghnyqQEWJH7x5AQYfQu8wU0/pYS/UkSrYBKyeY
 RCziNWu4c5VIw+UGSLn+xAbsguoEH24G+WeAxxAiNVbd43cHjlccOsk0typcAEbC036e
 hq6w==
X-Gm-Message-State: AOAM531wf+ZEByXfRo2aDoXE71akdmq0XrYKlUqrt5760OkRYfj4oOZu
 3iOIXLkZZVOQ3GQqe27izIJdddmywY4=
X-Google-Smtp-Source: ABdhPJwle8wm1WDLa2CYtkDoT4ukCNEWe6/zVb2J5uM9dMvViSCaSD0jgR9OOhzBfMZmLGovKMU/2w==
X-Received: by 2002:a1c:6354:: with SMTP id x81mr36687795wmb.98.1593807566780; 
 Fri, 03 Jul 2020 13:19:26 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u65sm14229625wmg.5.2020.07.03.13.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 13:19:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 09/18] hw/cpu/a9mpcore: Mark the device with no migratable
 fields
Date: Fri,  3 Jul 2020 22:19:02 +0200
Message-Id: <20200703201911.26573-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703201911.26573-1-f4bug@amsat.org>
References: <20200703201911.26573-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This device doesn't have fields to migrate. Be explicit
by using vmstate_qdev_no_state_to_migrate.

Add a more descriptive comment to keep a clear separation
between static property vs runtime changeable.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/cpu/a9mpcore.h | 3 ++-
 hw/cpu/a9mpcore.c         | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/cpu/a9mpcore.h b/include/hw/cpu/a9mpcore.h
index 5d67ca22c4..212f5db391 100644
--- a/include/hw/cpu/a9mpcore.h
+++ b/include/hw/cpu/a9mpcore.h
@@ -25,10 +25,11 @@ typedef struct A9MPPrivState {
     SysBusDevice parent_obj;
     /*< public >*/
 
+    /* Properties */
     uint32_t num_cpu;
-    MemoryRegion container;
     uint32_t num_irq;
 
+    MemoryRegion container;
     A9SCUState scu;
     GICState gic;
     A9GTimerState gtimer;
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 642363d2f4..5012c7a81a 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -176,6 +176,7 @@ static void a9mp_priv_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = a9mp_priv_realize;
+    dc->vmsd = vmstate_qdev_no_state_to_migrate;
     device_class_set_props(dc, a9mp_priv_properties);
 }
 
-- 
2.21.3


