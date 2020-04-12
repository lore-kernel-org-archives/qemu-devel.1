Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283B3C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E25A320692
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwEg30j7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25A320692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlYl-0007HN-SK
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlIh-0000TA-Gp
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlIg-0005fl-BT
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:42:03 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlIg-0005dJ-4x; Sun, 12 Apr 2020 18:42:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id r26so8425330wmh.0;
 Sun, 12 Apr 2020 15:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iPAKPkoi+HJFf28A5mZBn3JxaePmMb+vKpWg/g7b+Dc=;
 b=VwEg30j7okioBqC5v8hh9XNEyUEYRALhR2q0/MnYPPK7LyE21JtGuoVyV0NXjAsDeE
 W0GWYtStFWWOKyZkl28oxnjsb+pz1XWK8VGcezDQtttU1Z2u4eW7JmomrUMR1yn1xd7V
 7TUs03mj9nF0gln12G0GI1j2sRegPQRLnT9sV8y5/ZYayK5iopYAmkss4rLodYk6oquC
 9zIXcsbvPzZ24mWl8pJ1g21LbigEV95opjpkBNSPTFSsv74W6D4h0A1egoFrSTogUnbH
 rY6YggXdoxYCgblP5ptbe3tCwVzNu8aitBsCiTyQpnjxL9jaxPnumnNLiglUlr1WYBOY
 YMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=iPAKPkoi+HJFf28A5mZBn3JxaePmMb+vKpWg/g7b+Dc=;
 b=pk9yVtD4O0vmbl5a5fapNyE5mgLvk9WJamnTcsIl2Rz69c5zgftxA8QX3BtvVKUu96
 mTB+7fK+Gq5IPQRXmeUNFae5lnPJ2hyKjNDNN9i9rvU0Uu9ALsUfoRjZlDPcsgSltiAb
 YYHbXE1ZQ/pMpRO5soR6tjq+QLdbf7LsHzNsLPkIXz1F4MJa88UPOm+jpHN14FqqJi3q
 oX6M4ypD9znq1s6uJ8lpH0KefbC7uDHeE2F0/pJ958o24jSl4HDQcLaYWbzuHZ0X0y+N
 nUeqJ4z3VtmhXpc64x+nQWV7MYsSj0tZ+4aWimDyPb1IrhfvabPbegfocE/bQa5WtJrc
 OZHw==
X-Gm-Message-State: AGi0Puavvl2hGEh8msiyObLGOsOn1zPv9GG4EczDMCgjfCmwwHJyaTiH
 1d7SnUB2nGRVTU1pb6kndY82FMX2hITMbQ==
X-Google-Smtp-Source: APiQypLoMBgMjMAYgxmiv9CulGiG8SVPdmk9LQbOeIgOFsyfMFuYuaEPw4YCKEiXsvWsgIeveqjkwA==
X-Received: by 2002:a1c:1f8e:: with SMTP id
 f136mr15479105wmf.166.1586731319651; 
 Sun, 12 Apr 2020 15:41:59 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f63sm12083825wma.47.2020.04.12.15.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:41:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 03/23] hw/arm/stm32f*05_soc: Add missing
 error-propagation code
Date: Mon, 13 Apr 2020 00:41:24 +0200
Message-Id: <20200412224144.12205-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412224144.12205-1-f4bug@amsat.org>
References: <20200412224144.12205-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 Alistair Francis <alistair.francis@wdc.com>,
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


