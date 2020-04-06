Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A63AC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B90206F8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koP1HxoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B90206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVus-0008Gf-Cc
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVql-0001Tt-VC
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqk-0001Yx-UZ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:47:55 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:38917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqk-0001T2-5T; Mon, 06 Apr 2020 13:47:54 -0400
Received: by mail-wm1-x336.google.com with SMTP id y20so305235wma.4;
 Mon, 06 Apr 2020 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zYpWb46Zb3WjHhWYjAhvTjDn7e4H1J5r3AnlR5BkDdA=;
 b=koP1HxoOe+IJv1RQ3fCFQAEZSOvw6wlwL/SCXUKZhAeCZZuYMB0jG9um6nWoiuCTo9
 kxIu1UszPucOy1Qkdgr81e/B8udpNOc4uRShRk04JCDMIui6SAUC3tu4tPeCndbYGLLu
 A+vf1TbyyAgPh7nDuWhkecv6YZEo1X+RXRJP8x42fNSi510mH90ALerwaVZd2n8Dwnds
 yZZrkhLm9Iw7Cc0oaUgqR9dWT+WnYD8NLRTNI34x22U7zWat1omWjb2OzRC50kIJnXLy
 P0N6qwCVqTmzZvlKF7GlVcjpxFufJobkI4HLhROsZLiOOz7TmlLtoU2SoDc6NTicQI+D
 b4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zYpWb46Zb3WjHhWYjAhvTjDn7e4H1J5r3AnlR5BkDdA=;
 b=XIdAa94uXkImMK80VktLEbdkGS2tDbq0xgByJnWOZb4a7NjrADz+VGRFKgkJw3tuei
 NkpRjkZ2gsZX+zEzh7FJsy0xfZVa348qKp8PMlt/CKo0YF/13BabUUjy4WxnhcqXlio1
 nw5r86vvffKOC76iE3g3tNgBpeW9QJaY3zLz8QZrZMB0e2mZ5KGZ5mAEDsmBNNq+s3+r
 PRH60i/pJ1a6BXc3dlMPNWIqii+I7eNFWEzXPnuLG+tXL9W430FXZ2w7A1y8PmByq/HY
 tfw3KTNpCQCewsrpb7eYn7Ro8FvRCFjseUeIfm9/I4d+YoTTPgo/zQvNUY/nYXDggaI4
 bzrg==
X-Gm-Message-State: AGi0PubOYlgQ36RgU9Mk5dtERLHPsGV/oknywZjOZsi+S9BTv7t/R8dC
 B+VDjXAEvL7j/B38tZXu5tNTAVIHTes=
X-Google-Smtp-Source: APiQypKtwRFL4fc3eY/xqGBEYKsKQFhOVUhc6KROsodXLlAaCZU6zWo6CmhOpWYmFhZRiVWmcFAzog==
X-Received: by 2002:a1c:2d41:: with SMTP id t62mr181523wmt.128.1586195271901; 
 Mon, 06 Apr 2020 10:47:51 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:47:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 04/54] hw/arm/aspeed_ast2600: Simplify use of Error*
Date: Mon,  6 Apr 2020 19:46:53 +0200
Message-Id: <20200406174743.16956-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/arm/aspeed_ast2600.c
  >>> possible moves from aspeed_soc_ast2600_init() to aspeed_soc_ast2600_realize() in ./hw/arm/aspeed_ast2600.c:243

While reviewing we notice we don't need two different Error*,
drop the one less used.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/aspeed_ast2600.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 1a869e09b9..b08359f3ef 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -245,7 +245,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     int i;
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    Error *err = NULL, *local_err = NULL;
+    Error *err = NULL;
     qemu_irq irq;
 
     /* IO space */
@@ -418,9 +418,12 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
             return;
         }
         object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
+        if (err) {
+            error_propagate(errp, err);
+           return;
+        }
         object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",
-                                 &local_err);
-        error_propagate(&err, local_err);
+                                 &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -472,9 +475,12 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
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


