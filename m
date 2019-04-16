Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC30C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8934A20693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RKFUdtwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8934A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36326 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNjP-00086k-M4
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:02:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNes-0004MJ-Jw
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNep-00010k-Kz
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNeo-0000zR-04
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id y7so26891092wrn.11
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=oi+/NMTgWcniQ1uRjJ9edfUCRKrBUoRB3Mi7KKBbAVI=;
	b=RKFUdtwEX2Jd/yW0RWC4jOR3ZIXgW0xHANLvgIA7VoFGH89Ev9CSnzAeqFP+F1ISqp
	T1J49VMgozfR9y8fYsj6GshFPt38dRNtirdH3l4AIUL97l1FiZT2QSeSsiS+Z5mO0F9Q
	14o+k8bo+mQdEfJsuePghsBiBTE8xEKCewAtWrcGxJTTE+E+r3yI9fUl+gqExegOR2AI
	5hkPjbmQANE12RaSXrXtnmCY8o35v9wY6Ru8ThqWvcQxQ4kddRiNhJFjW1XeJ0ctZ4aM
	aB9RblAyHG2MiAFJ1vaidRZJ63VV6+XJ0wr/pZLIt5xr+Bvg/GNRGYRxtBaSKr00e0BE
	hxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=oi+/NMTgWcniQ1uRjJ9edfUCRKrBUoRB3Mi7KKBbAVI=;
	b=BkgestdmbGGUy0sjT+xud+9tS2qn6QQCCKqXR1LWyJ4qH7JT/Jt2NnpLp2MJDbRuaN
	8HLEGOIYhJLCqK+7RjIlSX7bQeaQ7LclVGItiQhJehj5YrvjEKaMyjo09PrFP7rHODkW
	+11dD1Bs0nyfvoHViX045msken5UilGox1uEc7m2UTVb0bVaph6Qw5cQo3hBfmrdBauV
	5hOflMnE2TGqDGPfSGPcYJpL95T7bCuXes7i5po9M90F5Cr+j50wqVPer+iM6I0GlwVB
	E7Ox9xxjp1PLIrj7mOfA6Hdlq9QQD58q/BJZ2hneBEjh+/1O0mvHVz2tX3Bi3Rh8zKra
	F8+g==
X-Gm-Message-State: APjAAAXrMTSxnF13VFofjPED98EFDW5ZqD9Btoq0qK1ciqSxfA82QJx/
	EqWWHU5eRzgFNAWQUtMCF1gpNg==
X-Google-Smtp-Source: APXvYqxgPQTRRISEjbj2a67tkJPzukDp/ed70jr6b2hBxpnwxQhchsItRAFtkgFrLB7AP3AzXR9FOA==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr18982199wrq.218.1555419469079;
	Tue, 16 Apr 2019 05:57:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.57.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:57:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:19 +0100
Message-Id: <20190416125744.27770-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 01/26] target/arm: Make sure M-profile FPSCR
 RES0 bits are not settable
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416125719.hsOjIb2w9rWXuBrX6baIkp4lMSa_vNQppgwJWeCH8Nw@z>

Enforce that for M-profile various FPSCR bits which are RES0 there
but have defined meanings on A-profile are never settable. This
ensures that M-profile code can't enable the A-profile behaviour
(notably vector length/stride handling) by accident.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 2468fc16294..7a46d991486 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -105,6 +105,14 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
         val &= ~FPCR_FZ16;
     }
 
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        /*
+         * M profile FPSCR is RES0 for the QC, STRIDE, FZ16, LEN bits
+         * and also for the trapped-exception-handling bits IxE.
+         */
+        val &= 0xf7c0009f;
+    }
+
     /*
      * We don't implement trapped exception handling, so the
      * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
-- 
2.20.1


