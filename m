Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41761C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11EE820782
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPwyELxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EE820782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSEG-0000Ll-BK
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9d-00084W-Mq; Fri, 03 Jul 2020 16:19:25 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9c-0001VG-79; Fri, 03 Jul 2020 16:19:25 -0400
Received: by mail-wr1-x42b.google.com with SMTP id q5so33921631wru.6;
 Fri, 03 Jul 2020 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4dCqkHJumkeBEkkock7OzqH4CRnyFrOofj4WDwKTygk=;
 b=TPwyELxkzqXteWDD8dRjWlY3Fcmpax+cDByBHyaXGNbLhSvmbO8oTDMp8juaPo/cLG
 m6pIB6b/Kc9dOvxA4TSCgWhlW67yyuGPg4baH/unRGPohy3ujHyX9GwYA1GM1mvBMle4
 224InrZ1erE6XWKnb2/+hWUo7pk7kP0sYrtKhVzFH8dSrbGCTSEGBwS0qlFGIr9S/g9d
 pCoJmxIsgwR4qUTrQCdo18WDw8fhoN8Ja+hAbUovRGaU/Z2zIL6cB4pwsBZ2tOA+q2NH
 gRLt5byYfm4lwVerYB5D4AcOVwQEP7mRKNrzi3ArA6+8KV4Rsql5hyNm0G/tvV2R1E4c
 ZSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4dCqkHJumkeBEkkock7OzqH4CRnyFrOofj4WDwKTygk=;
 b=CGn1IPgewilDjuM/XioyHDP1UDuRAH6umZKbTyfKKi2onF1L8HfzYmatDTfZpGE/NY
 XiK+mtnPw4JYX6MqW3ShEogchC4Q8jK6eZTwEiUSpPTHr0axNz71GHq926jlJ5BGToP9
 wpjZT9eKgq0ddi3H4sUrXJTLCLyhLrDJuIvmRxP5qIIIMjdVvmMKXELAK0B4mVV0r6O4
 GHxeppefgQOzTE55g8iNlqnhefffRk3vmf1nBXlCiYSOVcOyDdLk1vblQr8W3hhPgKfM
 YYRKfcjDoxKPX6eympY5NRXTdjloAE0KsI/86GV0nbEcpmipqQ0NODtpac1G4g9GxWmJ
 6mVA==
X-Gm-Message-State: AOAM5335UbajCzu1TEhwF0RY8lDJWBg+55h2LHeXBX7oHxaffuanUNpT
 Bw23e+Kp8LaQI0xpc37EvtXoDM4T2Tk=
X-Google-Smtp-Source: ABdhPJx3+FxIj1sVKvIkknByeYjPQVA0/t1sjPalHkVSBi6FT6PqzNESmIRLytIcrBdZtEeCifs/4A==
X-Received: by 2002:a5d:6b8c:: with SMTP id n12mr38589422wrx.352.1593807562362; 
 Fri, 03 Jul 2020 13:19:22 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u65sm14229625wmg.5.2020.07.03.13.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 13:19:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 06/18] hw/arm/bcm283x: Mark devices with no migratable fields
Date: Fri,  3 Jul 2020 22:18:59 +0200
Message-Id: <20200703201911.26573-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703201911.26573-1-f4bug@amsat.org>
References: <20200703201911.26573-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42b.google.com
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

These devices don't have fields to migrate. Be explicit
by using vmstate_qdev_no_state_to_migrate.

Add a more descriptive comment to keep a clear separation
between static property vs runtime changeable.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/bcm2836.h     | 7 ++++---
 hw/arm/bcm2835_peripherals.c | 1 +
 hw/arm/bcm2836.c             | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 024af8aae4..66e3621bb9 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -33,14 +33,15 @@ typedef struct BCM283XState {
     DeviceState parent_obj;
     /*< public >*/
 
-    char *cpu_type;
-    uint32_t enabled_cpus;
-
     struct {
         ARMCPU core;
     } cpu[BCM283X_NCPUS];
     BCM2836ControlState control;
     BCM2835PeripheralState peripherals;
+
+    /* Properties */
+    char *cpu_type;
+    uint32_t enabled_cpus;
 } BCM283XState;
 
 typedef struct BCM283XInfo BCM283XInfo;
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 7ffdf62067..f33500dc27 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -401,6 +401,7 @@ static void bcm2835_peripherals_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = bcm2835_peripherals_realize;
+    dc->vmsd = vmstate_qdev_no_state_to_migrate;
 }
 
 static const TypeInfo bcm2835_peripherals_type_info = {
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index ed1793f7b7..5fc67b6777 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -173,6 +173,7 @@ static void bcm283x_class_init(ObjectClass *oc, void *data)
     device_class_set_props(dc, bcm2836_props);
     /* Reason: Must be wired up in code (see raspi_init() function) */
     dc->user_creatable = false;
+    dc->vmsd = vmstate_qdev_no_state_to_migrate;
 }
 
 static const TypeInfo bcm283x_type_info = {
-- 
2.21.3


