Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044D7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B4720782
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk96nhEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B4720782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSHv-000076-0g
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9t-0000FW-9K; Fri, 03 Jul 2020 16:19:41 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9r-0001Ye-P1; Fri, 03 Jul 2020 16:19:40 -0400
Received: by mail-wm1-x343.google.com with SMTP id 22so33117352wmg.1;
 Fri, 03 Jul 2020 13:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UXJvzBp5XXWV6ZmNLki/P3wnGb416mLql6yjwQiSGLo=;
 b=dk96nhEsndhNP4xeuzSzx4n20E7xj1RWaS7XVjFRRTT6rSCabTEvtrC97OcWbc0bDG
 AshQzlE6ysirgPlO51z/UM4EDuT+D/gX7H/bk3H6HF0+kPSK8L9itcSB1ZPPWcTsq4m3
 jjCtrviGIPzoGStubB44BZAq7MdLn6VExBjuNwcDlTEXpTGgedklSYjwIAA8NmgcDkRx
 HnzhWaDz3GRecXJlcIe/4uG9n6Suxd19pAGszUM9CQz3zIK0YxuK3bwjwky6UbblGS6C
 OsV0cB2ky6OAAi8UPN49+z1ODjzSLTZTiZ7Mjr2WrHBivOFreYGrhxrLfg8YWomWmG9V
 LDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=UXJvzBp5XXWV6ZmNLki/P3wnGb416mLql6yjwQiSGLo=;
 b=H/o5TJmK0n2Yvuryde9GZ68wUkGxr+mbx9eMHsS9aP6/WULdMgwzShm1iFHeufvS9W
 UK9MJ/tFP2ryu3OtMNHwEyuXULU9Sp4JGFfNH9rG0XtbZ3oIZ0SQHyzDvQXgyBDD+CUY
 2G5v2tSH2ZaG3MFh1qKGLUhs4oY1/aFkmgT/Y0otl5RyTySYZj6e0BbhsGkctK4r1y2o
 I3FsF0z9P5BKoC/lcEnhgDXRbr6UOB3Ad3DjoO4cvru1yDBqbO5lGECPWLEWdO3hHX+f
 fOo3TpRUdJ9ljpCxGsErN0GmkqDmIxbFX8LRvvQpUsPhm5DevUCWhQJ+/EvZI8mnscaB
 B5TA==
X-Gm-Message-State: AOAM532NXWoHa4EFI8x5ZL9Ke1lU8i/tbOfrNGj0O+qEDCs4mUDjDlVW
 LffpI3FLhwmLRnRTYP8Jk4QTq3Ub1Mw=
X-Google-Smtp-Source: ABdhPJwvtbSsSw6vNyrRlwFYBAZyIhPE0cKxDdNOvXndT0qPeQxN2rSEPxKTbng+N702slL+Bssozw==
X-Received: by 2002:a05:600c:21ca:: with SMTP id
 x10mr37960285wmj.63.1593807578015; 
 Fri, 03 Jul 2020 13:19:38 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u65sm14229625wmg.5.2020.07.03.13.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 13:19:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 17/18] hw/sparc64/sun4u: Mark devices with no migratable fields
Date: Fri,  3 Jul 2020 22:19:10 +0200
Message-Id: <20200703201911.26573-18-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703201911.26573-1-f4bug@amsat.org>
References: <20200703201911.26573-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
 hw/sparc64/sun4u.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 9c8655cffc..2653893625 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -82,12 +82,15 @@ struct hwdef {
 typedef struct EbusState {
     /*< private >*/
     PCIDevice parent_obj;
+    /*< public >*/
 
     ISABus *isa_bus;
     qemu_irq isa_bus_irqs[ISA_NUM_IRQS];
-    uint64_t console_serial_base;
     MemoryRegion bar0;
     MemoryRegion bar1;
+
+    /* Properties */
+    uint64_t console_serial_base;
 } EbusState;
 
 #define TYPE_EBUS "ebus"
@@ -384,6 +387,7 @@ static void ebus_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_SUN_EBUS;
     k->revision = 0x01;
     k->class_id = PCI_CLASS_BRIDGE_OTHER;
+    dc->vmsd = vmstate_qdev_no_state_to_migrate;
     device_class_set_props(dc, ebus_properties);
 }
 
@@ -476,6 +480,7 @@ static void prom_class_init(ObjectClass *klass, void *data)
 
     device_class_set_props(dc, prom_properties);
     dc->realize = prom_realize;
+    dc->vmsd = vmstate_qdev_no_state_to_migrate;
 }
 
 static const TypeInfo prom_info = {
-- 
2.21.3


