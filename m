Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7971C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2270D20878
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWSeAvpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2270D20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzsD-0000SA-8U
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzq4-0006Lr-IU
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:16 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzq1-0007DB-1s
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:16 -0400
Received: by mail-wm1-x343.google.com with SMTP id q5so17953545wmq.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KoCaGxW6EMM71vBXs/YRZpSQP62pAwedz2Y/ryLytRg=;
 b=UWSeAvpqEUcDx9zW3wfdb3t3+089b1ZsWhK+JKH+jy0h5yWPgcSz+jt6de5L0rNhJA
 XXejKZUmy6tWNk/awFS+hUdbE18XiNxDF+o5OTCsJ0VML5GsaJiQI6Ycx/R7krLvVM6n
 h+kNd168/kd5AlXxn8Fe1rHuUEfWAbkNYGOrwr/QRilmxb9aNHShvKXiTJquFSLQ0jE0
 Hyi30JQUOd8T5YcJWb9EvntvHC4k4VWt2goKahyEWlw94uRXXv9hADNMhrvSdia3Gycd
 kiDLxxVWtAmCPqoFfOAk7RnOC2wEFLv73ByFVjD9CZDNt4Rk246/Bu4VPj1dCRmYwrdU
 aBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KoCaGxW6EMM71vBXs/YRZpSQP62pAwedz2Y/ryLytRg=;
 b=t41RuT0iiDrHn07mqKw5Q/TfX6hMXmwl2xJPf/B3WsWybO18qIs4IrXktnqkNfUOe/
 JtWrY7FMVanPU7eWitaPl2Z4pNc6DMkYqzkaCwS+FqRv7AafGJy5P8J9S3Sgl4FT69mB
 TrcKiE4mUMqzj6rNwrO5NdiFJQifoiT3xbvzW8ICrUXxCSLZZaiHifyeN1wb+DKivV4A
 I2gffo/sf74HDPK88+qRgHFWUAq6A/4yWQDXtLn5XHGYPnnMomNSEDlT4xSgPq1T/n/y
 Q8uhLlXunE0aDARUSxtkShY5i/NgOLNYuyFNhUzNwl3h8lS2gYRPKkboVCrRxXGVO8KC
 ANmQ==
X-Gm-Message-State: AOAM5328v4nb81ZBDuY4w0B4PaWRAQ3mf/vtxhtIeOZ4GzxajwNVhj4t
 gDQtNweXdr98K6FJj30R+MEqsQ==
X-Google-Smtp-Source: ABdhPJwCKkR4uMIfWwixqzNE5Y9dZriEu8xz3e84znZ1jNkYFUVALuGosGDB9cjk+Ii4zq2A6rrRdA==
X-Received: by 2002:a1c:ddc2:: with SMTP id u185mr11716584wmg.21.1602516851416; 
 Mon, 12 Oct 2020 08:34:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] Deprecate TileGX port
Date: Mon, 12 Oct 2020 16:33:24 +0100
Message-Id: <20201012153408.9747-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Deprecate our TileGX target support:
 * we have no active maintainer for it
 * it has had essentially no contributions (other than tree-wide cleanups
   and similar) since it was first added
 * the Linux kernel dropped support in 2018, as has glibc

Note the deprecation in the manual, but don't try to print a warning
when QEMU runs -- printing unsuppressable messages is more obtrusive
for linux-user mode than it would be for system-emulation mode, and
it doesn't seem worth trying to invent a new suppressible-error
system for linux-user just for this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
We discussed dropping this target last year:
 https://patchew.org/QEMU/20191012071210.13632-1-philmd@redhat.com/
and before that in 2018, when Chen told us he didn't have time
to work on tilegx any more:
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg03955.html
Given that tilegx is no longer in upstream Linux I think it makes sense
to finally deprecate-and-drop our linux-user support for it.

 docs/system/deprecated.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 3a255591c34..e9097e089bb 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -387,6 +387,17 @@ The above, converted to the current supported format::
 
   json:{"file.driver":"rbd", "file.pool":"rbd", "file.image":"name"}
 
+linux-user mode CPUs
+--------------------
+
+``tilegx`` CPUs (since 5.1.0)
+'''''''''''''''''''''''''''''
+
+The ``tilegx`` guest CPU support (which was only implemented in
+linux-user mode) is deprecated and will be removed in a future version
+of QEMU. Support for this CPU was removed from the upstream Linux
+kernel in 2018, and has also been dropped from glibc.
+
 Related binaries
 ----------------
 
-- 
2.20.1


