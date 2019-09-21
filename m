Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F35AC49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2732073F
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uV1kKV2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2732073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBX82-0005L0-QM
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 00:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBX4y-0003Ih-1A
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBX4w-0006NW-E4
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:03 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37196)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBX4w-0006LW-2g
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:02 -0400
Received: by mail-pg1-x544.google.com with SMTP id c17so4987197pgg.4
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 21:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=Bv0ijY4ZvCut6ypRDGH+6rB0hF9DxDyueNqpNNGnGIg=;
 b=uV1kKV2TWvu0/+DiD4yf0rfGkDJvLQ1c1ZapvOuYGP5ZpMaHgPS2Pr/HINI1ZC3QVW
 eYqku29gFydbAJwtkOQYQ1F45Lsj3T8/IjSiJGvO3fLD0lrVqcR9wcZTU/Ha/1Gu1A5s
 HCVTbnPRuiXDUSgsoaiqRl8EP3U1wa0fy4YZUtiAwXs/ewQXDt3THfvHeuBjwbqF5IjK
 JtzO5maGe7ez3yddTi2ZcGgW+mu0JrtvXDboVTW3kbeYmE+rjcbACBil/9DcqFL1zt7I
 xleeW3IFRVC4ttK2yi+R53hWvDajmZpjQdWH4PD7NqnzMCcy0nX/S89ynKbrvqN4u990
 IjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Bv0ijY4ZvCut6ypRDGH+6rB0hF9DxDyueNqpNNGnGIg=;
 b=DjBwPwcDANYXdH+ujT3zzeIX2Rs774IXtOIA0cb260qcE942Aqp6anps15HdzLFfqV
 qIKS0o0UkOOnrFOkqVJ5HsFD4OmwPhV3ZSrouhAeTM3murgkTcnNoVyvWyswpRhmBkM+
 CRRfmXb5kOZhlevur65h/sJG2iIZiGUSX95FhpVJe+uBovq2iMIa5OJQofHejIkK8avT
 F0LZWxnaBPm+N21l4Iagjex9Gvw9hDf3Xw5Bj5aJKo9B/lVeGVTgyoq+/dx49qD8uSxt
 NGqExWCQawoUKJor7xzLxluJLcVJLlwdzOFkPINvgTNpcgh11l7a1eIqGFGtjrZqWxIz
 hS+Q==
X-Gm-Message-State: APjAAAWSl8ghI8qpK8A9wV2NWzZ07CYe88JW+85VsEhRfzArj6cAoZy/
 w61xFjeIS/jXtTGLN5pYeDh22nXyVBc=
X-Google-Smtp-Source: APXvYqz/V0Q6rqBoWeSUiqVc8VTVBkNowKuEFCICZkBgWTKOhv2FQv9/wQ5h734MDkt2fJMHp5nDRQ==
X-Received: by 2002:a63:b70a:: with SMTP id t10mr19310330pgf.25.1569040379897; 
 Fri, 20 Sep 2019 21:32:59 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 193sm4179986pfc.59.2019.09.20.21.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 21:32:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] target/alpha: Fix linux-user exception for CVTTQ
Date: Fri, 20 Sep 2019 21:32:49 -0700
Message-Id: <20190921043256.4575-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex's new float_convs test dies with SIGFPE for alpha-linux-user.

This is fixed in patch 6, where I mask the exception similar to how
the kernel would, when passed through the software completion handler.

Patches 2 & 3 fix bugs that I noticed in the process; the rest are
simple cleanup, trying to make the code better or easier.


r~


Richard Henderson (7):
  target/alpha: Use array for FPCR_DYN conversion
  target/alpha: Fix SWCR_MAP_UMZ
  target/alpha: Fix SWCR_TRAP_ENABLE_MASK
  target/alpha: Handle SWCR_MAP_DMZ earlier
  target/alpha: Write to fpcr_flush_to_zero once
  target/alpha: Mask IOV exception with INV for user-only
  target/alpha: Tidy helper_fp_exc_raise_s

 target/alpha/fpu_helper.c | 15 +++------
 target/alpha/helper.c     | 68 +++++++++++++++++++--------------------
 2 files changed, 38 insertions(+), 45 deletions(-)

-- 
2.17.1


