Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59241C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B5F206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ly8K5F9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B5F206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwUvg-0001Bk-AY
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 14:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwUuL-0008RK-Fu
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:16:29 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:33248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwUuJ-0003GH-6p
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:16:29 -0400
Received: by mail-pl1-x62a.google.com with SMTP id 72so5797291ple.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Eh/urPCZyEjBe0HBw89fGP5pnfezlB/ZwMVheBt3xTs=;
 b=ly8K5F9KKEZ3th0zchH9QHAaRWBruOElbEx/Xhc/F8GJOvkILX8pDWYSVMgvWKY+E+
 zAqyW9xtwFOt4WL0CS8VktfhZMlUrDAZDI6P7X4opA4adTowW7rzOZTj7mjGa9n5UyVd
 XfhISo+MwyaLV/yytCnXbIWqjoVd7UbY2BKw1eVTjIigeVQRnzD60MQGROvt2uknp64W
 7OibGueXDlXrqCN4vqWg0tGjx4lJC9txKGT65oDGdaPb1zAq+Vp7hAynQMMoN3BTtoZB
 1SVqsqUrHoYlR7U0W8YtYlOodM7A0YvzCsilEtbIcJCmnC4b/FOhpVHzbG+R32zEew5W
 Nh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Eh/urPCZyEjBe0HBw89fGP5pnfezlB/ZwMVheBt3xTs=;
 b=tNCvhd2wNiBmGBVnn60d3PcUKXY5eZFQoJIYBVhfg157fYJ8Nt0TQl2UTVQYJNHbJN
 jLvRR3t+3Zq3fp0r8SXW+Ks6F4eeQ01pYI8Rwdr90fNI6WK57nex5AKidFjTpxSZCELN
 VHv/XNepv1jghXF3RGyoAXD4JW6jH5jNHgPB5F1PKxLjUutkqWNI/v1x+o6qjnPDXlw9
 8d+XN3rygSOktOGi4kuh0/6rWS6/dTn0UkMMMX+uCpjG4bFuQvpsHIfRtKn82WF6NqsZ
 VwlXZgNdQgEslJcanAsh9GNsuZDqXZdn85cLcagurCzq8bPU+vYc32JdFJzGAQ5gULqJ
 eRIg==
X-Gm-Message-State: AOAM532zaYy2Ku4iB7viz9N/NmPT5i1ZRnq4KCs8s0m5N9qdr5hAl0r1
 umpW8+SKj+F0nIP1kSmg88aeMg5Utkw=
X-Google-Smtp-Source: ABdhPJxOHCXCkYiDBoZcCfq+9Cum2NMc07U/OZ8JjOEhuXuzHdZmjM3cMNBXCrImjNpuHkWHC8KnQA==
X-Received: by 2002:a17:902:9a42:: with SMTP id
 x2mr8704252plv.174.1595009785106; 
 Fri, 17 Jul 2020 11:16:25 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id r7sm8698578pgu.51.2020.07.17.11.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 11:16:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.1 0/3] tcg patch queue
Date: Fri, 17 Jul 2020 11:16:20 -0700
Message-Id: <20200717181623.2742758-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

The following changes since commit 95d1fbabae0cd44156ac4b96d512d143ca7dfd5e:

  Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200716-pull-request' into staging (2020-07-16 18:50:51 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20200717

for you to fetch changes up to ba3c35d9c4026361fd380b269dc6def9510b7166:

  tcg/cpu-exec: precise single-stepping after an interrupt (2020-07-17 11:09:34 -0700)

----------------------------------------------------------------
Fix vector min/max fallback expansion
Fix singlestep from exception and interrupt

----------------------------------------------------------------
Luc Michel (1):
      tcg/cpu-exec: precise single-stepping after an exception

Richard Henderson (2):
      tcg: Save/restore vecop_list around minmax fallback
      tcg/cpu-exec: precise single-stepping after an interrupt

 accel/tcg/cpu-exec.c | 19 ++++++++++++++++++-
 tcg/tcg-op-vec.c     |  2 ++
 2 files changed, 20 insertions(+), 1 deletion(-)

