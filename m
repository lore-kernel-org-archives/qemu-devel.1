Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7419C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99874204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v846qUMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99874204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpa5N-00042X-0c
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 11:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46760)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpa4o-0002hs-CS
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpa4n-00022y-8z
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:18:10 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpa4n-00021j-1K
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:18:09 -0400
Received: by mail-wm1-x343.google.com with SMTP id g67so31624865wme.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7NuZl7Nb2dd8ZP9m/KLdrWknEwI2f29c5aTVGOoUdS0=;
 b=v846qUMWCBksoBHVeIdglUUh1NWQtNQ1JPjcWHdknQ44a8oLT9U1IxE5RI3qGPUUS5
 fovw3cYbzeMQ97TMxFDDkJpnSvO7vG6AJgfbXy38mc+gE+iooRcbEo7lrn3/MZc+EkFu
 f+5YhY47qNiZlxWupvzdGFqoQkGn1wOtECS/F88gphpemzk/vb334SwrEL9Lxj+JZQew
 TrQhwOty43CCHw10icp/JSdb6MCfDmvTw1zypgQE6OLX9Oit6qfRDvIgNWKGdgnmRip1
 n2kJwGYmVPmwyf1ZTmIZbZsHM0ZoFK5NSvXJ9y4FFB5X76wgd6YrpA4Zhh+5xnIEE7Km
 gMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7NuZl7Nb2dd8ZP9m/KLdrWknEwI2f29c5aTVGOoUdS0=;
 b=fTyalCPgL3NcTPzoQdEVVVRn2xSr4PeJt+e7XjseEizxkgQGGF0K+JnwDsut7My8Du
 VB4GrBwq370LP1+9hN+kRLZF1wG0ua0yPdizQXppiB0JP5IO1Zikw3spT1WOA/usIuIZ
 rpnP91XopEdx597k8NZIXYeQY/+Sl1wlthGr/HTkuK9HgfP84A6E/vJVVyCjZrTDGlFH
 Kkaqu7yV3MgQeYuADnG5iRhPuFEUUZn5hKZXQRWwKV93dpBRhPkvKCsQeYmGE4E+V3gS
 CFjM/A3LM8QARd8dgsCJrdXYUCVNWhH9CwJWulGY+tGydupn/vvPGlg4DhkW5I7/+tVE
 hWzA==
X-Gm-Message-State: APjAAAWOklzZwzm28ygivBlosTHU9OgTM0KQOTUUpStHw+D9mTzQUasH
 lzNONdYDwehJiI14a0c78Fqheg==
X-Google-Smtp-Source: APXvYqyCbm/Xdz3t0kY55iRE/S2Mc6DA33PFfvq+TfywB6WQpEp4cmfrrQ+IOz+DNGPCPV74gWB43g==
X-Received: by 2002:a1c:cfc7:: with SMTP id f190mr61139905wmg.85.1563808686810; 
 Mon, 22 Jul 2019 08:18:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s15sm23163990wrw.21.2019.07.22.08.18.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 08:18:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 16:18:02 +0100
Message-Id: <20190722151804.25467-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH for-4.1? 0/2] arm: further improve initrd
 positioning
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit e6b2b20d9735d4ef we made the boot loader code try to avoid
putting the initrd on top of the kernel.  However the expression used
to calculate the start of the initrd:

    info->initrd_start = info->loader_start +
        MAX(MIN(info->ram_size / 2, 128 * 1024 * 1024), kernel_size);

incorrectly uses 'kernel_size' as the offset within RAM of the
highest address to avoid.  This is incorrect because the kernel
doesn't start at address 0, but slightly higher than that.  This
means that we can still incorrectly end up overlaying the initrd on
the kernel in some cases, for example:

* The kernel's image_size is 0x0a7a8000
* The kernel was loaded at   0x40080000
* The end of the kernel is   0x4A828000
* The DTB was loaded at      0x4a800000

To get this right we need to track the actual highest address used
by the kernel and use that rather than kernel_size. We already
trace the low_addr and high_addr for ELF images; set them
also for the various other image types we support, and then use
high_addr as the lowest allowed address for the initrd.

Patch 1 just does a preliminary variable rename; patch 2 is the meat.

Only very lightly tested...

Marked as 'maybe for 4.1' because it is a bug fix and to code which
is new in 4.1. OTOH cases that fail now would have failed with 4.0
so it is not a regression strictly speaking. And we're getting
steadily closer to release and I haven't very heavily tested this
patch. I incline towards including it, overall.

thanks
-- PMM

Peter Maydell (2):
  hw/arm/boot: Rename elf_{low,high}_addr to image_{low,high}_addr
  hw/arm/boot: Further improve initrd positioning code

 hw/arm/boot.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

-- 
2.20.1


