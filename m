Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ACDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 21:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62E22089D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 21:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbyDvhox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62E22089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv65k-0000J0-1h
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 17:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv655-0007yM-QV
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 17:33:47 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv654-0004WX-97
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 17:33:47 -0400
Received: by mail-pf1-x444.google.com with SMTP id q17so6610383pfu.8
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 14:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8WL7mHqVeto3seRdphAbDKBPOvWdqFs/rTUbtyz8qVc=;
 b=jbyDvhoxGatE/yIvVxseno334gAwMrDkufLcDtUlhMZYxUWkGyJem8sHcntV1JoNZz
 0EsZUCsOmP9LQFQvjbZUIpLsNF9NP42iT+xfbR9cyZyMCmGdp1H2qcKmwbi+dTOhJuwH
 8zVytfC1XFsHhrInzuj3PXd1GT6bznFcUg//iqBtrlnOzolLL4IZytvWYPRkNlq7WGy2
 RDCPLShThzmY3dvNzcFcjTc4kM2K5HZ7aXdOgEASkW8pttivmznn/qcq8cisKp47Trb/
 Zbo70l3fl+QNAbKvgdKSbfv2t1Nd+TM7clfWL80uoqolyQXyX1jPcbn71REax5ZcNPrM
 qSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8WL7mHqVeto3seRdphAbDKBPOvWdqFs/rTUbtyz8qVc=;
 b=P6NI67LH7Gd67d4LesKm2MJMDBUiN2EVD6UUDS2i976BaUZHr5xZ/UyVGL4K0wgYvJ
 myv6xOWfGGQneAOMG/9R3xT0sxey/XRRJWYbIYjbXCOk/HKW2TFRYBnYfxQPq68t3Y9M
 rH7GGaX7rNEN0DfKRieo61Yku/zcCI59LcAwrawR57/rfDegdYhba43Zw7NAmJa7Eo3s
 CwxmEMySpjnhG2fvTZGnTCNXSgLwy4UrkobON+HdbpM5eku2k6a5pAzT6Oai7qSVe1ck
 f2HptXWhTPdREdYSVtsMH37WFk+qxwskgckRYEzAB22Z89hO3yOo6XaJ5fWvQowWBoCr
 Rz5Q==
X-Gm-Message-State: AOAM533x5WWRpqru+Okt8kk4w5B08hhTlooBTWDbLSGNk791ZH6fa59T
 jGe2mJxXqsEVnePsVRtcf4xLVK0+UdQ=
X-Google-Smtp-Source: ABdhPJy838hkxVdNDAX2NhYaBW60Bkxj8oQ4XYrLy9npfFqnIBAbiRDPaRjmFptn/qeUYM/ApOa2jA==
X-Received: by 2002:a62:86cc:: with SMTP id x195mr1575843pfd.39.1594676024311; 
 Mon, 13 Jul 2020 14:33:44 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id l207sm3591565pfd.79.2020.07.13.14.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 14:33:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 0/3] target/arm: MTE improvements
Date: Mon, 13 Jul 2020 14:33:38 -0700
Message-Id: <20200713213341.590275-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since MTE is new, and guest support for MTE is still under
development, let's disable it by default.

Peter mentioned memory hotplug on IRC as something that
would break MTE's assumptions.  By putting the enable flag
on the machine it's much easier to control.

For 5.1, we won't have kvm support, so error for that combo.


r~


Richard Henderson (3):
  hw/arm/virt: Enable MTE via a machine property
  hw/arm/virt: Error for MTE enabled with KVM
  hw/arm/virt: Disable memory hotplug when MTE is enabled

 include/hw/arm/virt.h |  1 +
 hw/arm/virt.c         | 50 ++++++++++++++++++++++++++++++++++++++-----
 target/arm/cpu.c      | 19 +++++++++-------
 target/arm/cpu64.c    |  5 +++--
 4 files changed, 60 insertions(+), 15 deletions(-)

-- 
2.25.1


