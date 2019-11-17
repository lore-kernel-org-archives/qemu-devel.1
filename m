Return-Path: <SRS0=ZAHP=ZJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558B4C432C3
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 09:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136E4206F4
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 09:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvrhEGsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136E4206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWGWr-0005VH-2l
	for qemu-devel@archiver.kernel.org; Sun, 17 Nov 2019 04:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWGW0-0004b7-4i
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 04:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWGVz-0004Tk-7B
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 04:06:40 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43977)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWGVz-0004TI-1J
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 04:06:39 -0500
Received: by mail-wr1-x441.google.com with SMTP id n1so15884877wra.10
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 01:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GBHzU6Z//QizyB6bDO7VHsofmNwhMhG9rJWVnZKGzow=;
 b=gvrhEGsUSn/iXKEwstQwEO77Uz2vHzCvyubwpzbVdV/gzzTZ75SemEFyAy5zK3Kv3p
 stbImImvfmCp5dRWiY8N8VRXUxrS6IDD5DevaaIWCnIjqWJjpY2cwPdkR9oTR/DGQP9s
 P/gU4sa2ChyWcx0c1JsV1KPb+ghyxQQvSEhtT2Fs8E/iyf/jQGDbSQ2mFrPISlSCpsXb
 /bUXHcx6ZCHGdqaVmr63efi2b/zaetQRax51our9CH8irlm8GIrh5zNrM9lGKoOlu9Ud
 dwR/2A2Q7Y3QCGya7h28Q5MXVN5pTaYCcXbfKCa1OhPUSjCnA8llVGgK4qCjSlJepe5B
 IshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GBHzU6Z//QizyB6bDO7VHsofmNwhMhG9rJWVnZKGzow=;
 b=QIsLVa0EQjzbbfPvXhw8QouUGdu45gYvZFo7s9yDWhidmrvXEDkfl1MI0yGdu/40RP
 /sor8n/UcMZdDchuLqoIIEtgQC/Y5oDlkWoV9Hz0/X12tgo5DEwvd7HPCzyztnuFv03r
 dCwhNNEtZ0JFeb12DB2TFyCDywynXwKtskml8aj1ax5mb8K7F7bwu8AsUnKjn7u9zKdD
 xCcTCmON2HrHORBoD9Fgl82oAtC3Va8oaMhMWpxx196JaWBq/3NNDsYBWZ69y3gIqcFP
 2d+dmMMoPpxxgb3g4r+t8XeSor5mzZudXmTnZRPUEVmLLpw/EWWNGqzTNwld50qRCfCe
 cUJQ==
X-Gm-Message-State: APjAAAVONy8G8wsEiPKmXekd9EYmpbg7ch7jtUWYZ+T2/286/3gn4E92
 f/B6PhNbt7li83u2zOUa4QKonq3Ns/MI3g==
X-Google-Smtp-Source: APXvYqzLlz5eHpIysjWaHL2J0rzx/CAgVD60VGTXTmEqDOVmOlD20kCf2Gn/undafpE34+EyKRSllQ==
X-Received: by 2002:adf:efcb:: with SMTP id i11mr3476142wrp.229.1573981597751; 
 Sun, 17 Nov 2019 01:06:37 -0800 (PST)
Received: from localhost.localdomain (180.red-80-27-55.dynamicip.rima-tde.net.
 [80.27.55.180])
 by smtp.gmail.com with ESMTPSA id 91sm19773679wrm.42.2019.11.17.01.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2019 01:06:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/arm: Do not reject rt == rt2 for strexd
Date: Sun, 17 Nov 2019 10:06:20 +0100
Message-Id: <20191117090621.32425-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191117090621.32425-1-richard.henderson@linaro.org>
References: <20191117090621.32425-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There was too much cut and paste between ldrexd and strexd,
as ldrexd does prohibit two output registers the same.

Fixes: af288228995
Reported-by: Michael Goffioul <michael.goffioul@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2ea9da7637..b285b23858 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8934,7 +8934,7 @@ static bool op_strex(DisasContext *s, arg_STREX *a, MemOp mop, bool rel)
         || (s->thumb && (a->rd == 13 || a->rt == 13))
         || (mop == MO_64
             && (a->rt2 == 15
-                || a->rd == a->rt2 || a->rt == a->rt2
+                || a->rd == a->rt2
                 || (s->thumb && a->rt2 == 13)))) {
         unallocated_encoding(s);
         return true;
-- 
2.17.1


