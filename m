Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D34FC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5212053B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBOmFpim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5212053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04yl-0007mx-DM
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 11:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k04ud-0001f4-Cq
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:19:35 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k04ub-0001Ml-IX
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:19:35 -0400
Received: by mail-wr1-x442.google.com with SMTP id b6so15285376wrs.11
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=AgiFp36fAcCMfqysVIITkhhp2lHAb79FkVULIdw4Y1E=;
 b=DBOmFpimh2tlUmVZ1/YXoe9B2qz9EZzrBUJo1uyds+MQSJF5hIUo2f1CCGViEWniWK
 HZDlcHY+y3SFmPDEk6FqTUMGKFEyhyV7NDeEU1FAeSDZtfF0xqxxbB/TE/rlrQ6eB7JA
 rATdpZ2zUyMPhVaB5JIVb/7SlN9TGzcglZzPy4zOIPsmZ0hkyfi7G1pilHCKsAeu3HdY
 mMpOSZSalEVF+kH/1HjnX1fh1AWEC4+O1ZsEnKgqFwjS5yniI9WCmbo3Qq29GdHdn6SP
 GhgVPMFkHN/fh6uBAAn1RqkyK8KslkkiQaLk0/0EPcKCIM2NFCqwhvywrWRmDUw1MhyQ
 nffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AgiFp36fAcCMfqysVIITkhhp2lHAb79FkVULIdw4Y1E=;
 b=GfXfWWSKSXFi5SyQI5g0WtIy5kGBApYfHo+my3QRB917Q9i0WVQ++PDfwDAhqpD56G
 N3bCxTM5TDsXYFhwyzQjk7Au7HumIua/cgj5JJT6l8fZRRjcrJMsJmwHGE7arrrl4XbF
 J7pJMYRTGVa6G5V94M1RHVPbByCqUbo3GekiimGJT9Aqj4Ya2tBpZMVmLOXtn37J2pQI
 rWRWoZ1F6st+WXPKQAp4vsO6+M2CoorIWELUDCYnOVU2eibY022DRmEySD2wG8VIJ5BQ
 gl/rHEl1zPETPbIngDSXhtr3xbrCiJZGF74nn+v8P/wJsWGR/l5Ck6kEdtmXxF1yribn
 V+iw==
X-Gm-Message-State: AOAM531Am6V44Sm+K4uhMKLqiFDWeQw5jTlZPd0bJI/0wP+Xg1GIjwuA
 jDhzRZB7srHTbYvAYbhEkhyJYEaqAmyQ6A==
X-Google-Smtp-Source: ABdhPJyXx6FRYOyhx/dIFSAcskaMs0q+4lFQw/eBVLWDOdt0iHL/8T8aQhJbGwmo7OYojcKzbXhPoQ==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr19807738wrq.85.1595863171889; 
 Mon, 27 Jul 2020 08:19:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h199sm18744996wme.42.2020.07.27.08.19.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 08:19:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/7] hw/arm/boot: Fix MTE for EL3 direct kernel boot
Date: Mon, 27 Jul 2020 16:19:19 +0100
Message-Id: <20200727151920.19150-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727151920.19150-1-peter.maydell@linaro.org>
References: <20200727151920.19150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

When booting an EL3 cpu with -kernel, we set up EL3 and then
drop down to EL2.  We need to enable access to v8.5-MemTag
tag allocation at EL3 before doing so.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200724163853.504655-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index c44fd3382dd..3e9816af803 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -739,6 +739,9 @@ static void do_cpu_reset(void *opaque)
                     if (cpu_isar_feature(aa64_pauth, cpu)) {
                         env->cp15.scr_el3 |= SCR_API | SCR_APK;
                     }
+                    if (cpu_isar_feature(aa64_mte, cpu)) {
+                        env->cp15.scr_el3 |= SCR_ATA;
+                    }
                     /* AArch64 kernels never boot in secure mode */
                     assert(!info->secure_boot);
                     /* This hook is only supported for AArch32 currently:
-- 
2.20.1


