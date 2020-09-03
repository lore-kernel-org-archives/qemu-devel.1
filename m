Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1BEC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A69F206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZl/kgeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A69F206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDvkL-0007U8-PS
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 16:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDvj5-00069q-0L
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:20:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDvj2-00084a-IQ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:20:54 -0400
Received: by mail-wm1-x341.google.com with SMTP id w2so4113854wmi.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iMf7PrtIvi+uTaRRjwphBu6nmGC3imxNmq1uK0cxKrA=;
 b=OZl/kgehL8aVAhLxdcIUVooRvRiqWFsnQWtwOxAxC/ZJcNYL0S/hXps/zWYg3jG78X
 i2KkS0a4x90Iy5XfKXZnxxonw93bwFbo0KRHINYlefWrySh1rSGCUCtlVySzj4rz+tJO
 XT7YtFpJKb5alarKSrhBCmGayReJ7InJp2NLF9/ryXOM4hD+rLOIggfQI638LfMEXQHF
 wQqmU4MsY3CXVmu6htTtzz+2mGoJNO/yWYzmGt7t4zYmduIrrzYVTSYedXmsT2kMjMeK
 zKbTDyriD2NWcGbiCtzc+plHKK1yd5ji4QbgCa8Pwsn1popIkEV7MBjKcjD8KnbbFaRM
 THZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iMf7PrtIvi+uTaRRjwphBu6nmGC3imxNmq1uK0cxKrA=;
 b=D6+z7QODei804mtNoHKIkwZIlrCjaDUyIXUf7bhbxMPStFIF0ed/ha+e34ml64ZK1t
 rIrqKvY9SDX+OvRnv7OcFVL3juWt3ZKZgcQl9sIQltv/MDNsn86ub03jUlQqHYHsG6Lr
 Wai5FArfm1mMrGWrOd47iMxwthn5hebliFzXzgDY8jjiGE3f9E9WoxvdXf5Kr+3Nqyv3
 1jhKMYorV68EdMO62/Czkqfs2ejvLY/Xqa99ta6o/wGJ3xUyfaGHHxmcmbD3YV6FLrdR
 RJw+f+wfPKXjm7oJjHcvQ7clClcwS2aCJNvOGZgJdfKEwbzFUsCEmFb0is+3RvkM7OTD
 Z8YQ==
X-Gm-Message-State: AOAM533NrlBOC9c5ThwKhIlKU9gD6EJ8YuKwQP2IaoiDq4iK/CzK5Llq
 eMKwKTKx2SPznIUpqjGNwxRMzg==
X-Google-Smtp-Source: ABdhPJwGfGR+AOvliDc6Os4eIrAFDvSv2a6hHDttELV+LSN3Oj4jawjG0h/qphW90aqbpjr0Du/k1w==
X-Received: by 2002:a05:600c:2146:: with SMTP id
 v6mr4076180wml.159.1599164450958; 
 Thu, 03 Sep 2020 13:20:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p14sm7285023wrg.96.2020.09.03.13.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 13:20:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] target/arm: New boards mps2-an386, mps2-an500
Date: Thu,  3 Sep 2020 21:20:45 +0100
Message-Id: <20200903202048.15370-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Kumar Gala <kumar.gala@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds two new board models in the mps2 family.
The AN386 is identical to the AN385 but with a Cortex-M4.
The AN500 is a Cortex-M7 image which is almost the same as
the AN385 but has a few minor differences, most notably the
base address of the PSRAM and of the ethernet controller.

The AN500 is interesting because we don't currently have any
boards in-tree which use the Cortex-M7.

Changes since v1:
 * patch 1 now also updates the docs to mention the new board
 * new patch 2 defines the mps2-an500 board
 * new patch 3 makes some minor cleanup to the docs for these boards

Richard, Philippe: I kept your reviewed-by tags on patch 1
because the only change was the trivial docs addition and
there were no code changes.

thanks
-- PMM

Peter Maydell (3):
  hw/arm/mps2: New board model mps2-an386
  hw/arm/mps2: New board model mps2-an500
  docs/system/arm/mps2.rst: Make board list consistent

 docs/system/arm/mps2.rst | 20 +++++----
 hw/arm/mps2.c            | 97 ++++++++++++++++++++++++++++++++++------
 2 files changed, 95 insertions(+), 22 deletions(-)

-- 
2.20.1


