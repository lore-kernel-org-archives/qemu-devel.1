Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7980ACA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 20:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41677205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 20:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWHVRa35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41677205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPunF-0007ZD-1c
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 16:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iPsPv-0003ux-91
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 14:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iPsPs-0006SY-TW
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 14:09:58 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:42804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iPsPs-0006Pq-MP
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 14:09:56 -0400
Received: by mail-wr1-x431.google.com with SMTP id a15so3378359wrf.9
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xSeZDkLwEVTssoJX+QVCXaZ98b8wT4AcO2nXdLSZxaw=;
 b=TWHVRa35v4AixZFOiLu4/cO6GeQAwV/NZ2/ajz4MlIjP2dkxbT+dRhOQ68mdvbpwJx
 Iup+FQc5bw3Lh7BoWtzthHXZm8KrNw9dBxskYgzu3Q42+k2FWY7+m3vsPLLJBy4aFr0L
 UTgAFUPkMZFy0PZltQ377wrLe13KgW6rjYVSBo8kLp4ORUhH27ttKSJiaj7j9wA/nodU
 P/bncRi3EouuYhAbjjinHRHQbwwMNpPh44FTOscM0qNwOYVmUiZ0fJA4d7yoazWkx+Ti
 WjU6a8SzUC/kdfQG9s+qDXQMhpqmi0MgLi7lwG2MXaNTTNwrmZcrndQS4mgqtNJD9C5I
 KuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xSeZDkLwEVTssoJX+QVCXaZ98b8wT4AcO2nXdLSZxaw=;
 b=K88cb7BEXxhKvHyUJh53qQBet14UVCs7yCveBfxfrZpSW8E1M2ZkbdamUZ6WT5+ojx
 9abEnpNHuL1yiS38H4L4bJo2zrrVRFStGHUPpWKomB21taGY8vbD/ZnmPGtACGDk/SKb
 SmAkMB0mTFdxvOCXnuiorthcFRTjAir/iTOACzysMKbIxX5ec2nke+ays0F5VjX4OD3B
 XOzM9JlAsXrHb7mrxbk+c05WGH/ib6U64+mXD9p1PiDG7jadDWVMg7zN3BJnA2xTqfsu
 iGnQHfEoo9JgjAY31ilQ8VYXDCT9SYAFnW6Rwst+GIu9IT0iOfYc9hjyPdHoXr1LvY4h
 JH7Q==
X-Gm-Message-State: APjAAAVnSzXTcBdOiMQgRbk3HX/fwVpX/UHXlwAXa2yqyI9NsfgzevvY
 9I5Cjv85wo9rJKcFCzN440lDfenB60xYAQ==
X-Google-Smtp-Source: APXvYqwJ+B6TDXpppKhnSEfb4Nla57J/ixTtejirq+ZfBrJ9DxpficQlTSplA7/RTtiV9KdixK7Ebg==
X-Received: by 2002:a05:6000:350:: with SMTP id
 e16mr1201569wre.276.1572458995071; 
 Wed, 30 Oct 2019 11:09:55 -0700 (PDT)
Received: from localhost.localdomain (248.42.142.88.rev.sfr.net.
 [88.142.42.248])
 by smtp.gmail.com with ESMTPSA id t133sm6931299wmb.1.2019.10.30.11.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2019 11:09:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-4.2 1/1] softfp: Added hardfloat conversion from float32 to
 float64
Date: Wed, 30 Oct 2019 19:09:53 +0100
Message-Id: <20191030180953.24180-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030180953.24180-1-richard.henderson@linaro.org>
References: <20191030180953.24180-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: peter.maydell@linaro.org, Matus Kysel <mkysel@tachyum.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Matus Kysel <mkysel@tachyum.com>

Reintroduce float32_to_float64 that was removed here:
https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg00455.html

 - nbench test it not actually calling this function at all
 - SPECS 2006 significat number of tests impoved their runtime, just
   few of them showed small slowdown

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Matus Kysel <mkysel@tachyum.com>
Message-Id: <20191017142133.59439-1-mkysel@tachyum.com>
[rth: Add comment about impossible inexact exceptions.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 0638c9f4e0..301ce3b537 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1920,13 +1920,30 @@ float16 float32_to_float16(float32 a, bool ieee, float_status *s)
     return float16a_round_pack_canonical(pr, s, fmt16);
 }
 
-float64 float32_to_float64(float32 a, float_status *s)
+static float64 QEMU_SOFTFLOAT_ATTR
+soft_float32_to_float64(float32 a, float_status *s)
 {
     FloatParts p = float32_unpack_canonical(a, s);
     FloatParts pr = float_to_float(p, &float64_params, s);
     return float64_round_pack_canonical(pr, s);
 }
 
+float64 float32_to_float64(float32 a, float_status *s)
+{
+    if (likely(float32_is_normal(a))) {
+        /* Widening conversion can never produce inexact results.  */
+        union_float32 uf;
+        union_float64 ud;
+        uf.s = a;
+        ud.h = uf.h;
+        return ud.s;
+    } else if (float32_is_zero(a)) {
+        return float64_set_sign(float64_zero, float32_is_neg(a));
+    } else {
+        return soft_float32_to_float64(a, s);
+    }
+}
+
 float16 float64_to_float16(float64 a, bool ieee, float_status *s)
 {
     const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
-- 
2.17.1


