Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A1FC2BA1E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F8B20731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDE3vpKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F8B20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWSn-00010x-QC
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrh-0002xG-9Q
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrc-0003WQ-D9
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:53 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:36755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrc-0003W8-74
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id d202so328157wmd.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PEHTVvrf5Pm+Jom3wPMXvD0+JJqVe46WaOi392HQB5U=;
 b=YDE3vpKxS1ahS6WZQYGQ5BsbWpk/jT6NYHZajiT55etah2+eqvbEwZPEpBKC597ynI
 BRXH4eSKfiMD1xwJwhvG7wc/xDVFIFpy/LYXt2SFRH5i9wbNFooEA0BAL4XsZbiol5sv
 PN2+xMNKX+u8uuDePIKN2d8taA2+cxXIgSAlX1RZszCIZaReHSnAMoQGf0c+z9ESWGRm
 8klfG4CpUeoux7/+RXBscbYCNDj9Wp0HbG9A5OSeqQ51IWriNbIZxfu7dzK1RQ5/HTRo
 A9H9Eb7nLhIOIP3GNybzWApI6mFLFX3IK8evK8Wd3SCgM4qMlTDeiOccYDSfd3d5EGiQ
 ktqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PEHTVvrf5Pm+Jom3wPMXvD0+JJqVe46WaOi392HQB5U=;
 b=V9/Y9e13/C/txVR4+8RQn7PtkRY2V8EQHDXwqZj1LtwUS3Pa0b2cLImlNQ6HBI19L2
 fpxqLirl+6npFmvFPgBPuoiihzfmjexyzqpDbXmoEYDoAuC/dpcgS93yWZnSl8z9YyWD
 PnKX5DwtHCTlWK3stQger/9whgL4SIKfR7kmC4RNc0wUO+dBTO9ZsTMlOR4GZUpDptcO
 +UxoMDKd3WF7HZpbZC8hKSXF8uuZyv0VnDO55+rNjcBZXM0PyBERZTHDEIWMHfwKQ0j3
 8axY1X5uK1W/ewDnocCgrjj/JT3aH5Mj9Tfv07dcNwARUxurefxfQRsQy81m50j7FBMA
 WxHQ==
X-Gm-Message-State: AGi0PuZPafucs+Fr334isEAF5g8Wja+UV/QUwmuy5KNFSONysGOsv/7b
 zeqOtm8lvp8OTisKgDru5xPxBppXgjQ=
X-Google-Smtp-Source: APiQypJDVOA05tidm3PgFhJNZMnKiQoCASE2z/ozeyeGOArqYGwv1eqTooLnfg7fJsZQZckhholW2Q==
X-Received: by 2002:a1c:c302:: with SMTP id t2mr160254wmf.85.1586195326597;
 Mon, 06 Apr 2020 10:48:46 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 43/54] hw/mips/cps: Add missing error-propagation
 code
Date: Mon,  6 Apr 2020 19:47:32 +0200
Message-Id: <20200406174743.16956-44-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/object_property_missing_error_propagate.cocci \
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


