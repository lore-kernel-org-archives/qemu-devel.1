Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAC1CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E7621906
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhouM6n4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E7621906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNg21-00055n-7M
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxV-0006ps-AZ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxS-0000eS-3N
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:32 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:41511)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxR-0000dz-TF
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:30 -0400
Received: by mail-wr1-x434.google.com with SMTP id p4so26806620wrm.8
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=eiQ4IS489mOFVCAyCVWUyEDk9Y5TrLD5uNTu22NV1VM=;
 b=bhouM6n4np/oeoSzuL4326RTK6Ue0NvudvGGjcz9DO3aFRfCy5pXgmwUYo66WfM2Vz
 /DnsmWd7L4wnz5uYQTc/htqKq2Vw43WrPa6afNtPk3uECmjxijpR1kPTfxiskTCVJZ1C
 qWSFJm41cCmJeRIiH95CiO0acODv/2JyHxT6vi638XDrPdSL+pTExeWAvcINujlz7ql8
 vm/4KmFXahTnL2X5xeziYHCSkHEge7YR9fX7u75pYzUFD9tev2oSu4yvyR9uxCRvA2N4
 Oy/OLG+CQ/zjYn3DglvSkt20XP1RDjt2ZuW4p00wYw3P8y7zNy3LJ8HMGZIQmkRZtAl6
 l0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eiQ4IS489mOFVCAyCVWUyEDk9Y5TrLD5uNTu22NV1VM=;
 b=ddBC4p3BC9b+Nq27GVameaFoN5CyJZmRGbolC6gLoS6B6JzMFTiJyBSxQLPFN+268s
 j9iwropIZ+ZE0xtc9ylXwM2pg/TQc+I0drzG3llwMJ+mFyOKpZL8va15xjCJ7hNp/lDq
 qbsrJWSR0dxhgk9HwOvkP9q1Ok7eH3nti5ojn9iHdy97W359OXfoJjrgZNMb0pZmbpR6
 HSfaxVdw0QkGZ0x+ULyxHWqs9/lZLLYDNHe6ujp7uw0IMm/74viN6QlguAYMfDRGnVVS
 XAyPF2ZRFvBZ8VYEzg+AULFK3xINAqEmHI4ZOwq41wkcw7ThVnSN4pn8pAGeYNXo2f+g
 vA2A==
X-Gm-Message-State: APjAAAUchNPzt/OBUe00rRsC90z/n3MxQxKXMEyiq5oVzACiLbujhjXy
 FZKuRyAsYXRnud9oTXtxONmVc3j+vjo=
X-Google-Smtp-Source: APXvYqyVSAs3uaX6ljv7+34I7QX0usgjH1U2z8T6nrM4sy9fIFwkuUoZnp0BhoWaORxIFooYzvT6yQ==
X-Received: by 2002:adf:e7c9:: with SMTP id e9mr4592574wrn.261.1571934448494; 
 Thu, 24 Oct 2019 09:27:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/51] hw/gpio: Fix property accessors of the AST2600 GPIO 1.8V
 model
Date: Thu, 24 Oct 2019 17:26:34 +0100
Message-Id: <20191024162724.31675-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

The property names of AST2600 GPIO 1.8V model are one character bigger
than the names of the other ASPEED GPIO model. Increase the string
buffer size by one and be more strict on the expected pattern of the
property name.

This fixes the QOM test of the ast2600-evb machine under :

  Apple LLVM version 10.0.0 (clang-1000.10.44.4)
  Target: x86_64-apple-darwin17.7.0
  Thread model: posix
  InstalledDir: /Library/Developer/CommandLineTools/usr/bin

Cc: Rashmica Gupta <rashmica.g@gmail.com>
Fixes: 36d737ee82b2 ("hw/gpio: Add in AST2600 specific implementation")
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191023130455.1347-2-clg@kaod.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/gpio/aspeed_gpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 196e47c2628..7acc5fa8e29 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -733,13 +733,13 @@ static void aspeed_gpio_get_pin(Object *obj, Visitor *v, const char *name,
 {
     int pin = 0xfff;
     bool level = true;
-    char group[3];
+    char group[4];
     AspeedGPIOState *s = ASPEED_GPIO(obj);
     int set_idx, group_idx = 0;
 
     if (sscanf(name, "gpio%2[A-Z]%1d", group, &pin) != 2) {
         /* 1.8V gpio */
-        if (sscanf(name, "gpio%3s%1d", group, &pin) != 2) {
+        if (sscanf(name, "gpio%3[18A-E]%1d", group, &pin) != 2) {
             error_setg(errp, "%s: error reading %s", __func__, name);
             return;
         }
@@ -760,7 +760,7 @@ static void aspeed_gpio_set_pin(Object *obj, Visitor *v, const char *name,
     Error *local_err = NULL;
     bool level;
     int pin = 0xfff;
-    char group[3];
+    char group[4];
     AspeedGPIOState *s = ASPEED_GPIO(obj);
     int set_idx, group_idx = 0;
 
@@ -771,7 +771,7 @@ static void aspeed_gpio_set_pin(Object *obj, Visitor *v, const char *name,
     }
     if (sscanf(name, "gpio%2[A-Z]%1d", group, &pin) != 2) {
         /* 1.8V gpio */
-        if (sscanf(name, "gpio%3s%1d", group, &pin) != 2) {
+        if (sscanf(name, "gpio%3[18A-E]%1d", group, &pin) != 2) {
             error_setg(errp, "%s: error reading %s", __func__, name);
             return;
         }
-- 
2.20.1


