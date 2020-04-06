Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B95EC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C94D206F8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSQH5bdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C94D206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVuX-0007Ox-7b
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqs-0001cS-2s
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqn-0001bx-DV
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:02 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:34532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqn-0001bU-81; Mon, 06 Apr 2020 13:47:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id c195so139073wme.1;
 Mon, 06 Apr 2020 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xfGcmES3nPX8YvO+/YU0EwpyXu9u+QJWTYG9rfArCpE=;
 b=mSQH5bdYJwZO43gz051i5YGQvv7jfuiRVqkOL0va9nYORTZVaZeSHTMTfs7AjdAEiA
 uzD1O2sYFsWAhRzUwefyD9H+uCwloAapePGsZc9bI0qQqZRaTp26x3HUBFWfMHVyPXVx
 1h15gJrk5p3zF90+mue76guNwgtL38DTslpEUZASG4KQAiwAEbg1XksGXXjRfRDkobQW
 DVC7MyKKiVhdEe5DAxIj6sWn0qMhY6ZUsFeM3vQLvwucIMm8FaioDIvmMZypzA25d981
 /vKZKDlE1km3FzFKazhiF+BWPiU4A3sQbTLAgQM3TK8t4hNG/JiOg8dO8FgDa/tXiDNU
 n49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xfGcmES3nPX8YvO+/YU0EwpyXu9u+QJWTYG9rfArCpE=;
 b=fg8YRbTR3a1SMDKQQADg3FZy2dcYiVz1d0XWlc6mdCLjQEbxhX/uZ+SCD1CZtJI/9S
 WcL6CkTrZ0clcmmt0DwGA2bv0rQbzMi0jOX0zjMxw88JoBCbFRnI1MbcITZ1oEDe+Gmx
 YxBviALW/13AhdtaQuxfg1d9tJiIFTjDSX/Ru96ByVSsRCJeHvYgNC11U2lZKndqv9jM
 KczubSXpcW/Z5fOSUEvFFq2f8Ki7SJtHF2+HWpCOKTNMmFLDfUntDZ7UVoxN6CXoPNQr
 mm5JplYyIhTF6deFpW3w9PHTr7gK7zw1rJ8Zl7gUuSfRIjo5SRc4Quo1Jruz7a0iPre/
 aXTA==
X-Gm-Message-State: AGi0PuZUan3UUShGBlhIDK5RVbDiBHDGZD5XYqJft9BVSkALgtQF9FcC
 I6sZWNnrDMpYtQFGm3aZPlnRyvUvhQI=
X-Google-Smtp-Source: APiQypIpUgST85aW8J2H9SlKU4Lqx40BuTT/QiyG1Q0EViBSUycX0JBUuebvsyHIe3v8XfMWt/rrKg==
X-Received: by 2002:a1c:a344:: with SMTP id m65mr205469wme.20.1586195276046;
 Mon, 06 Apr 2020 10:47:56 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:47:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 07/54] hw/arm/aspeed_soc: Simplify use of Error*
Date: Mon,  6 Apr 2020 19:46:56 +0200
Message-Id: <20200406174743.16956-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the previous commit we noticed we don't need two different
Error*, drop the one less used.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/aspeed_soc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index debd7c8faa..aa6d739ad0 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -234,7 +234,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     int i;
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    Error *err = NULL, *local_err = NULL;
+    Error *err = NULL;
 
     /* IO space */
     create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOMEM],
@@ -413,9 +413,12 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]);
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &err);
+        if (err) {
+            error_propagate(errp, err);
+           return;
+        }
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "realized",
-                                 &local_err);
-        error_propagate(&err, local_err);
+                                 &err);
         if (err) {
             error_propagate(errp, err);
            return;
-- 
2.21.1


