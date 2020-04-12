Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B671C2BB86
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC86020692
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeWVKbwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC86020692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlT7-00056k-1J
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlIl-0000a7-Pz
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlIk-0005lf-Gs
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:42:07 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlIk-0005gp-Aa; Sun, 12 Apr 2020 18:42:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id f13so8503285wrm.13;
 Sun, 12 Apr 2020 15:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DVvHZN6pNMjS63zKUqHDX/HjbfNz01Q6piyIEWw/Gxw=;
 b=SeWVKbwkgCy1BfFAupgKAptkoWp225ePEX6YbcwRFzXjPK5YvyONEJhUB7ssQiKcDs
 lw4JCUxaH8WMKS9HaTLgUVjNXDbPbg9NZ18suZeHdepD2EvWOc/MPgBTnqJ5MYi/CpBa
 yy+6vjx0XcJK2DE3u/7PduHCUxUmIPoz24qL5LUtzghFjBjddMyaa+wEivDVutSqEBlC
 9WBoZz8r73DtwdjskMW+OOzilMyT8oTyz+j3Wg4da6X5gwq1lmeazM3qVpQ3XiqgleX6
 YXM9U7Jz3xjsfvVCdWIH9qXVM5QhEHQT7UmnhKxlDDvJ/ds2KJ7tK1X9Ztp68rqGiFLs
 g2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DVvHZN6pNMjS63zKUqHDX/HjbfNz01Q6piyIEWw/Gxw=;
 b=gzs/qoC3/20IPNaJBcECxYXHTQmVzJbRv+XoUvku1bF3RQ0DOkF1N5MoVMtcmWmCEa
 z4Ag71YQiP6NbQ6QHjBKPHxPbmdnYzl63mKGm0gE3ScMPvUm/bkqMJyfuaOwDSilYde4
 KOXhkx/m/ZQJyo44Hx0sTl7l85M97hPmoofrnaZsJN80mCUrcBtclGLZ6WVQson+9ltm
 uGUDu1qHB2K4oKvfJqkfSQwahA4cyO7kpIk6f+DQRuqxC3BuNfB9xVFzcUL5P13lZaN7
 Rt7VKjPoQR5TxvCzTYAWY4IwR8gg5QFgc9FDZjLGGocBO0JlwNEH3EaEBr8iGO9qGeQ+
 nnSw==
X-Gm-Message-State: AGi0PuYCPfkt8dxC9/WGs34BXhPXLG+wCnACEhLOB6v2eijf8/6K+cjY
 XXsNaoKvjX424Zn9hq5vL1u7vBWeUZaUgg==
X-Google-Smtp-Source: APiQypKvvhg/w+kNNCyhw7xzlfIZoPq1EThd4RvWrquNW2z7JK8BUGVCtlqvz3lgKi0NUPBzkWujwQ==
X-Received: by 2002:adf:9441:: with SMTP id 59mr15576166wrq.211.1586731323017; 
 Sun, 12 Apr 2020 15:42:03 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f63sm12083825wma.47.2020.04.12.15.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:42:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 04/23] hw/arm/aspeed: Add missing error-propagation
 code
Date: Mon, 13 Apr 2020 00:41:25 +0200
Message-Id: <20200412224144.12205-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412224144.12205-1-f4bug@amsat.org>
References: <20200412224144.12205-1-f4bug@amsat.org>
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/aspeed_ast2600.c | 36 ++++++++++++++++++++++++++++++------
 hw/arm/aspeed_soc.c     | 12 ++++++++++--
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 64512f95c9..504f540369 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -277,7 +277,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         if (s->num_cpus > 1) {
             object_property_set_int(OBJECT(&s->cpu[i]),
                                     ASPEED_A7MPCORE_ADDR,
-                                    "reset-cbar", &error_abort);
+                                    "reset-cbar", &err);
+            if (err) {
+                error_propagate(errp, err);
+                return;
+            }
         }
         /*
          * TODO: the secondary CPUs are started and a boot helper
@@ -293,10 +297,18 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* A7MPCORE */
     object_property_set_int(OBJECT(&s->a7mpcore), s->num_cpus, "num-cpu",
-                            &error_abort);
+                            &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
 
     object_property_set_bool(OBJECT(&s->a7mpcore), true, "realized",
-                             &error_abort);
+                             &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, ASPEED_A7MPCORE_ADDR);
 
     for (i = 0; i < s->num_cpus; i++) {
@@ -343,7 +355,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl),
-                             OBJECT(&s->scu), "scu", &error_abort);
+                             OBJECT(&s->scu), "scu", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->timerctrl), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -459,7 +475,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
 
         object_property_set_link(OBJECT(&s->wdt[i]),
-                                 OBJECT(&s->scu), "scu", &error_abort);
+                                 OBJECT(&s->scu), "scu", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
@@ -490,7 +510,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                            aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
 
         object_property_set_link(OBJECT(&s->mii[i]), OBJECT(&s->ftgmac100[i]),
-                                 "nic", &error_abort);
+                                 "nic", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_bool(OBJECT(&s->mii[i]), true, "realized",
                                  &err);
         if (err) {
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 4ee991ec16..1762c7aebd 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -301,7 +301,11 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl),
-                             OBJECT(&s->scu), "scu", &error_abort);
+                             OBJECT(&s->scu), "scu", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->timerctrl), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -398,7 +402,11 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
 
         object_property_set_link(OBJECT(&s->wdt[i]),
-                                 OBJECT(&s->scu), "scu", &error_abort);
+                                 OBJECT(&s->scu), "scu", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
-- 
2.21.1


