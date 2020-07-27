Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD621C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B57A2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHuE0QPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B57A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k07II-0006sm-Ns
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 13:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k07HS-000683-Bb
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 13:51:18 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:46907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k07HQ-0006nE-SL
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 13:51:18 -0400
Received: by mail-ej1-x643.google.com with SMTP id l4so17891168ejd.13
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gDx7vRp/dC5Z+gEH9ieQ1MOATOcdTERt+j/Nr4IggWM=;
 b=FHuE0QPu7Zk0wyiEDY6BU4qIiW3D3bhym7uXTqXYCwlc37iejEBOWuinYgeSokW0yx
 xDQce9w260gp4izvEo0KB7sKvuGXK06iYQAi4W4G4vBfILSViKn1bPjxqcEKF4TBR2Ff
 +ffj8ZrbTZS2ePMB3v/HmsFbrpXL4AQ7bZpjqAZf1fcMoHfTefvgJ3Lze+iAYVmBqzbp
 z+t1UsMQhe1OSXak+aIq9kKXnW9ZNoe7j2phMxG4KDgOq40NIsWteTaDzb6XIMVF7Zk4
 fhNSM+wnI4C6tteSvJUySS+6yiS3+/xnSnswdqrwOuvU7zzPSbEgnYsMtY9KbuSgXeoE
 64Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=gDx7vRp/dC5Z+gEH9ieQ1MOATOcdTERt+j/Nr4IggWM=;
 b=eccnQuSkc1yzKwu7jZZFjcn7VO8gSMxEpfnMAaIbvAq9qhY+KPDKt4Y42XLQrMOjwX
 DjerGdEMzw1M0J5+Stse14KPy1aemc/uQfzI+Lr1uq66aFrKvcGlYFhayvRc78erWr/D
 GMEsBT3hwFJBV27YP120eqIwPDUVEgLCenX2pVWoi1B2Kg17Irp+1IRnSKg1Q6Z0Pmjp
 /jcR229wxKqyOvYwuLJSQBsr1nQwkDZVQJoMPHLzJSymAT6RfrRK5PDwUznOLA98lLTF
 KFn+kCLa1iLpefztb0MrI8eIuUvtRi9SnZnjm0WkplWhWJLppPJJhgnZdmDJHy3g6gT4
 3G9w==
X-Gm-Message-State: AOAM5318sIKGDUnP7OJbD+ylNk4Qh8nmJmruFe1+yyf7Biyc6zltcG6T
 B1JffQqoCqAFDCT00GjYFdPfcmkK
X-Google-Smtp-Source: ABdhPJwDZZTiGPKp6Dk9uVIdQqvDgVWPk2j0Qn1Q0M1nSkJ5KeQagiMEc5x1KroOrIQ9OyLbAL0qYw==
X-Received: by 2002:a17:906:85d6:: with SMTP id
 i22mr4045364ejy.194.1595872275056; 
 Mon, 27 Jul 2020 10:51:15 -0700 (PDT)
Received: from x1w.redhat.com (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id w3sm7877927edq.65.2020.07.27.10.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 10:51:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v4] hw/core/qdev: Increase qdev_realize() kindness
Date: Mon, 27 Jul 2020 19:51:12 +0200
Message-Id: <20200727175112.6820-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 510ef98dca5, qdev_realize() aborts if bus-less
device is realized on a bus. While commits 514db7710b..007d1dbf72
took care of converting all mainstream uses, QEMU forks weren't
converted.

These forks are usually maintained by hobbyist with interest in
following mainstream development, but with limited time, so usually
rebase from time to time. To avoid them to spend time on debugging
and reading git-log history, display a kind hint about what is wrong.

Before:

  qemu-system-mipsel: hw/core/qdev.c:376: qdev_realize: Assertion `!DEVICE_GET_CLASS(dev)->bus_type' failed.
  Aborted (core dumped)

After:

  Unexpected error in qdev_realize() at hw/core/qdev.c:376:
  qemu-system-mipsel: Unexpected bus 'System' for bus-less device 'unimplemented-device'
  Aborted (core dumped)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/qdev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 2131c7f951..a16f1270f1 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -392,8 +392,11 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
 
     if (bus) {
         qdev_set_parent_bus(dev, bus);
-    } else {
-        assert(!DEVICE_GET_CLASS(dev)->bus_type);
+    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
+        error_setg(errp, "Unexpected bus '%s' for bus-less device '%s'",
+                   DEVICE_GET_CLASS(dev)->bus_type,
+                   object_get_typename(OBJECT(dev)));
+        return false;
     }
 
     object_property_set_bool(OBJECT(dev), true, "realized", &err);
-- 
2.21.3


