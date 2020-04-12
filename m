Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FE3C2BBFD
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E628C20656
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyRLCDzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E628C20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlfI-0003pe-4Y
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 19:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJf-0002Wp-Ns
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJe-0006Ny-HR
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:43:03 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51415)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJe-0006MW-BY; Sun, 12 Apr 2020 18:43:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id x4so7945697wmj.1;
 Sun, 12 Apr 2020 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X/mQ0/ksrnKYeCH9PXW2OPU9IIFVOFowuUUBw22B+TA=;
 b=AyRLCDzVUq1ImEY3a10im+mwz3jmG4NYRS0sVuF2Q/JTQvHSWwueJeuWcGXf+cE/Io
 OrN5KHWWd3XuDPsPYx1V9swSYM1II3GPJgUYW80dmnizOaOVZSjDz49aUtjFH0fYozSW
 Vlm6iYSQY0OruDS9OqL4stCcUTmErzQZbjK9Dwg66j1+WGz4i8ViC+AICv7vNF9biExB
 kgYRCcdSVC36O1td/zMGF8jODTAGgxRquzjhlZHbd5i70/ttFB7ct/n8LZraBYR0zg+y
 HKfrxmhg4ZVruKVMyC5/CS1KkJoiG4DvhOEIBSoSep5dp6y17mbD1onLJFxgtSeyEDNY
 PpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=X/mQ0/ksrnKYeCH9PXW2OPU9IIFVOFowuUUBw22B+TA=;
 b=ODuPz0MN3IFLhD4AuTttNWetYAaFy/kh+0bLEALwaIZdAWZATjD7tYfr5B+pKBtqZm
 nk3yNoZhNOarNHAi+wAvMR4mpP8kR8vVq7ZRArHIo2cOK769mQql5FZwcFwfupYIzni5
 IWM2UQIIK5NmxVprs10diTwZO0r12Te72fN6mBwbHqWSykPQGQlVypGO/OZHUZyrl/po
 dLsDRyeYLJK8Ce6+XQMU0TBw54zJaiqUAenBApOV1gODlpEux0QD1U76YFkNX/pVPoQC
 sK0kGBX2GQfG4NmTQZpCGKgH5bjtjjG+16an1JLwp/qHsAJN/On9Wjgrm1A1pfDMvR/S
 xSoQ==
X-Gm-Message-State: AGi0PuZk4OjorGJzjmjCBXzNJAsiCAI967JEjdyYiI53K5gfHumMcZSj
 vPtWu7ywbzMgmCf3XIO5xt6Te3FZytJrKg==
X-Google-Smtp-Source: APiQypJw83R2BkdnYi5TEAihs/FJFWZPVI7MtpC8uf9aw77CJvP5ws0fxTzcwMDJRNPep0i80xcLZw==
X-Received: by 2002:a1c:544c:: with SMTP id p12mr15868793wmi.88.1586731379149; 
 Sun, 12 Apr 2020 15:42:59 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f63sm12083825wma.47.2020.04.12.15.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:42:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 19/23] hw/mips/cps: Add missing error-propagation
 code
Date: Mon, 13 Apr 2020 00:41:40 +0200
Message-Id: <20200412224144.12205-20-f4bug@amsat.org>
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
    --sp-file scripts/coccinelle/add-missing-error_propagate.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Unfortunately the cocci script doesn't properly patch trailing
error_propagate() block and emitted duplicate if() block statements.
These 3 blocks were manually removed.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/cps.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 92b9b1a5f6..18943b64e0 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -102,9 +102,21 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         sysbus_init_child_obj(OBJECT(dev), "itu", &s->itu, sizeof(s->itu),
                               TYPE_MIPS_ITU);
         object_property_set_int(OBJECT(&s->itu), 16, "num-fifo", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_int(OBJECT(&s->itu), 16, "num-semaphores", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_bool(OBJECT(&s->itu), saar_present, "saar-present",
                                  &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         if (saar_present) {
             s->itu.saar = &env->CP0_SAAR;
         }
@@ -122,7 +134,15 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     sysbus_init_child_obj(OBJECT(dev), "cpc", &s->cpc, sizeof(s->cpc),
                           TYPE_MIPS_CPC);
     object_property_set_int(OBJECT(&s->cpc), s->num_vp, "num-vp", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_int(OBJECT(&s->cpc), 1, "vp-start-running", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->cpc), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
@@ -136,7 +156,15 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     sysbus_init_child_obj(OBJECT(dev), "gic", &s->gic, sizeof(s->gic),
                           TYPE_MIPS_GIC);
     object_property_set_int(OBJECT(&s->gic), s->num_vp, "num-vp", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_int(OBJECT(&s->gic), 128, "num-irq", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
@@ -152,10 +180,30 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     sysbus_init_child_obj(OBJECT(dev), "gcr", &s->gcr, sizeof(s->gcr),
                           TYPE_MIPS_GCR);
     object_property_set_int(OBJECT(&s->gcr), s->num_vp, "num-vp", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_int(OBJECT(&s->gcr), 0x800, "gcr-rev", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_int(OBJECT(&s->gcr), gcr_base, "gcr-base", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->gic.mr), "gic", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->cpc.mr), "cpc", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->gcr), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
-- 
2.21.1


