Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FB8C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA828206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYtKflbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA828206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWDB-0000Y7-Mg
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrU-0002aT-8S
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrT-0003PP-AJ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:40 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:34527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrT-0003Ol-4W; Mon, 06 Apr 2020 13:48:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id c195so140616wme.1;
 Mon, 06 Apr 2020 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aa+iNBsUIc02tXQoILWJv3WLGp8FOp4Qp/JxXw+sxRg=;
 b=gYtKflbxtv0KOO93GxMUFEEez7VBfiz39wC1pLQhhLlrVnwUvt27kQtjecwGYQGh24
 WwWrubbOug/megiCEdA+R+D7nl62mzfjdtvk0AoxKdGgkk59Qa4w2BTRvOW/dBB/IqTu
 PPJ12leEEvSmiv4C+p5ykHilzo3eGjjOZ3hNrdd6BGlfbWcNE2m37ZmNoB96H9eLTkcP
 ex5EcJqt6SjKn9Jv8v3z1yriYPAsKeb7isB7S/NJkvyHPVLcTZ4Vn3h01s7oI7u2yHf6
 /W1/YOlP/g0cw67BtLP7wIjh0uKfg0FuGK6disZtEixghWP2+SEI53bTZr9r2PGFiSeY
 +zUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aa+iNBsUIc02tXQoILWJv3WLGp8FOp4Qp/JxXw+sxRg=;
 b=rZ35EDLqmytOgxKQVJbSw/vycJjROmOGF35xwpDB2r+hVOjpDjK40/r+RF1PkFqwjB
 oOdQ6Yxknmpbidn1ID3MkfPvl3g9Cz4pM6a1+jl/M4RLLp8Akd0GhrDdydQ1yVkg8u8T
 FVcSuwHlT4JwRSngPenAT1uJ7MihiSxEcDJFIYf/ZMo+Xy2VOHnJ6TMoVlkNJkYsWtPJ
 DRQ9Y+h5xQm+kxYe24iVH1fMjcjDORRdv8zwFAvjBmsy6DCkYTkOKBdJSmf0NUAqeEbw
 IyyEH4nCrd3afyU6e71U5u+CLNdgl9LkezAckfK7KpMnDpz8FN7oTzlqewdIBQfhWeZr
 46Sg==
X-Gm-Message-State: AGi0PuaVQLehZuL805KJ+3vIs1FFcM7DvKSvNSinlvMheIAlxWp+1la8
 KzmxFHxhszO/zmqBgwwrx/UY6gJEXm8=
X-Google-Smtp-Source: APiQypJQ4laCv081ZH32hm3VoCAbr7epFHV+qnueGIIHv6FVELl0qHwwNj64ATISb3bLHpuHYBJkoA==
X-Received: by 2002:a1c:e242:: with SMTP id z63mr207222wmg.72.1586195318004;
 Mon, 06 Apr 2020 10:48:38 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 38/54] hw/arm/bcm2835_peripherals: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:27 +0200
Message-Id: <20200406174743.16956-39-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 "open list:Raspberry Pi" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/object_property_missing_error_propagate.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index edcaa4916d..a111e91069 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -289,8 +289,16 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
      *   SD3.0_Host_AHB_eMMC4.4_Usersguide_ver5.9_jan11_10.pdf
      */
     object_property_set_uint(OBJECT(&s->sdhci), 3, "sd-spec-version", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_uint(OBJECT(&s->sdhci), BCM2835_SDHC_CAPAREG, "capareg",
                              &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->sdhci), true, "pending-insert-quirk",
                              &err);
     if (err) {
-- 
2.21.1


