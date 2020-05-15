Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0EDC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D89E20728
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vVy6/+c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D89E20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZfNz-0000xY-Nk
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 14:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfMl-00082U-TB
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:47:28 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:35432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfMk-0005sH-I7
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:47:27 -0400
Received: by mail-pj1-x1033.google.com with SMTP id ms17so1370597pjb.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 11:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rSQnHi9YM0VnoofWyqTDDQT6SfQk+0/emzRT61cZY8I=;
 b=vVy6/+c7AXG+CCtrtVqwjCNL7LaW4fvp8VGuaN7bvEDetIJmpVnQK0ig8fJJgNXkbl
 sEohvZVnK2+7yVCc+SutBsRy8itZ2XWbKjgjzhOuqpk7konYAVSm2nYM+dwLckazD0K1
 7A99Qhv/DuW3OJ+8xWAGfAdiF6R67i9htAVAr+HoSZ8Dso5nxkiWKDK7TEJzf7Bd5+Rk
 VYRdY64TDwRaZoywP3Kc0zT3+iANoNIw+FXapizIb30z9ZkttzdEcqSu82MURdM4ncuI
 cIpupxanoT7PCN55/9qQwXtLpeQo5uUSu3Na0Sm1nw53FT2k0BdYmO+bzPYSv7T3KovL
 e0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rSQnHi9YM0VnoofWyqTDDQT6SfQk+0/emzRT61cZY8I=;
 b=lVx8AZ/gPGhyeIkTjEDxS0Q0GgCuy9XFR/Q2NkhvaD8UK2aLTBYVGyMNNA7KezNeqz
 2eM/0rAzq34Z9nOJ0s6X7cA7kh51KyQwnGw0DEFMYAJSBrsT+Z3FEPA8dVZmz3GU6Tle
 4NOc5Ddwda/KClaYqMj0BA20pESOznk1S/klZ8Zc2JhCXfKPNb/8Rcb1tVgRo/ScNd1p
 Eef2y8dzNF77Ch0OY152iCNv5kWNNUGU3Z6Kb/xYs0sban4QaA2DZ65dQBQlDZB3p5z1
 ciGJ0+nibzpnjbEpkEpFflgkuobWLGwEbxHT2tyAPO+od2acTi9B0T3uFqqoCe4FvLsK
 T5iw==
X-Gm-Message-State: AOAM531iuEwomw+L9aB6VEfeutQ3sUsGFDKTiiGnQlqfvfxYRbtu33s+
 72AZ8Z9SQtUyvVFfzjg+LoOz4K/W4AQ=
X-Google-Smtp-Source: ABdhPJy9YT1fIhChkJccbzqAuN7r+QiH5/fOS/kqJz89TUOqxq/FiFPM7OPg97CmcOH92ZTCBfQxIg==
X-Received: by 2002:a17:90b:f12:: with SMTP id
 br18mr5359858pjb.67.1589568444357; 
 Fri, 15 May 2020 11:47:24 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u73sm2743630pfc.0.2020.05.15.11.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 11:47:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] softfloat patch queue
Date: Fri, 15 May 2020 11:47:18 -0700
Message-Id: <20200515184722.31182-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I got distracted this week and never posted my follow-on
patches.  So flush the queue now and I'll post the other
patches for review soon.


r~


The following changes since commit 66706192de113c82ecf849f6943878c453b5d2ba:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-tcg-plugins-150520-2' into staging (2020-05-15 15:47:47 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-fpu-20200515

for you to fetch changes up to 9ecaf5ccec13ff2e8fe1e72f6e0f3367d2169c1c:

  softfloat: fix floatx80 pseudo-denormal round to integer (2020-05-15 11:04:50 -0700)

----------------------------------------------------------------
floatx80 x87 pseudo-denormal fixes

----------------------------------------------------------------
Joseph Myers (4):
      softfloat: silence sNaN for conversions to/from floatx80
      softfloat: fix floatx80 pseudo-denormal addition / subtraction
      softfloat: fix floatx80 pseudo-denormal comparisons
      softfloat: fix floatx80 pseudo-denormal round to integer

 fpu/softfloat.c                            | 39 ++++++++++++++----
 tests/tcg/i386/test-i386-pseudo-denormal.c | 38 ++++++++++++++++++
 tests/tcg/i386/test-i386-snan-convert.c    | 63 ++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-pseudo-denormal.c
 create mode 100644 tests/tcg/i386/test-i386-snan-convert.c

