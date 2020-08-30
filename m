Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C627C433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 02:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A20A2075B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 02:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkfDKHa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A20A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCD9d-000432-HJ
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 22:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCD8c-0002ZL-1v
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 22:32:10 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCD8a-0002X4-1Y
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 22:32:09 -0400
Received: by mail-pl1-x643.google.com with SMTP id c15so1429139plq.4
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 19:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QUATfVzo9sxokHaAsKproXP/s5VcubsLJBB8CG5CLRc=;
 b=PkfDKHa+TUIZuyqGIrT8etG1SivpLQkFXW5lJfNU2/b01DRJmL6ko84bjlWuAWcmKW
 JYZNnxcXsopEy+vpZEoBiWrtPSufXab3KsCRv69pKrnRz/omA5CodZXVEenC37aHBBRv
 lFGVMgekX5JXegZ3uX/06WFO9I0fsezBmp/BljIMVDcKb2ro+TXPfj6+IG1QZwIX1Xzy
 WJjbSA3MoJw1roGVYlsfPBqbeHs4309q8IoEOTdP74uPHr/DU2ANrXdaIuD88O2ipEWc
 ZeFJc3+cNUkvbASt02hysUqb6cc6cof7IxOw4GaPPe7QA3MsRDNX2HxaxK4bzuH2RY32
 1Iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QUATfVzo9sxokHaAsKproXP/s5VcubsLJBB8CG5CLRc=;
 b=f/0W8L0qyPz1XW2CKOej06IUMQa1v/EEv2lanxd16o8CLBJQHwgJFcl72/Q6rbZE4a
 AlleqArr9VEtmFNuGB97sCaSOWD2roWmcebzWbaY2nfYLMJkzdq/iG1qs8xruX2Uglqn
 edKWK9Ctvnm59+xCBtmLfjqVFEuzAtImIQzM5t7vEZ/GMOs6SwViyjYv9/EShmtI2bS8
 3It4vGszB2ydBoFxsPH9idnP3ypEGX/89zps4GDyoSGMXc3hz+kBhRoCe8GXyyZdinwZ
 oWqdReixQ0acQrolcyiqGFiBv3x/GuDVfDlE0y4Hj0fMFJMhbkwYiRVa0gESVUoNJoqv
 ilpw==
X-Gm-Message-State: AOAM532BLqWBKN8vcYukBNci4upbAkloL3MQgSTYdpi3VX5bHeb0p41J
 vulSHKTn5UeWM6Q5Zw/Lhb2QwZsuZbg8hw==
X-Google-Smtp-Source: ABdhPJzAw1GbBoSMRnIQ2SmXhLxFU6tJ4iVwaEpAjfaI7vaktkUgCxg5vfrDHa4hwMvxJCq5c/OWyQ==
X-Received: by 2002:a17:90b:3197:: with SMTP id
 hc23mr4925067pjb.60.1598754725957; 
 Sat, 29 Aug 2020 19:32:05 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l23sm3546269pgt.16.2020.08.29.19.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2020 19:32:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] softfloat patch queue
Date: Sat, 29 Aug 2020 19:31:56 -0700
Message-Id: <20200830023203.612312-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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

The following changes since commit ea1bb830cb021cca2e361091cf728aaabc8c0654:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200828' into staging (2020-08-28 15:14:40 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-sf-20200829

for you to fetch changes up to c53b1079334c41b342a8ad3b7ccfd51bf5427f5a:

  softfloat: Define comparison operations for bfloat16 (2020-08-29 19:25:42 -0700)

----------------------------------------------------------------
* float16 comparison wrappers
* float16 conversions to/from 8-bit integers
* bfloat16 support

----------------------------------------------------------------
Frank Chang (1):
      softfloat: Add fp16 and uint8/int8 conversion functions

Kito Cheng (1):
      softfloat: Implement the full set of comparisons for float16

LIU Zhiwei (3):
      softfloat: Define operations for bfloat16
      softfloat: Define convert operations for bfloat16
      softfloat: Define misc operations for bfloat16

Richard Henderson (1):
      softfloat: Define comparison operations for bfloat16

Stephen Long (1):
      softfloat: Add float16_is_normal

 include/fpu/softfloat-types.h  |   5 +
 include/fpu/softfloat.h        | 235 +++++++++++++++++++++++
 fpu/softfloat.c                | 425 +++++++++++++++++++++++++++++++++++++++++
 target/riscv/vector_helper.c   |  25 ---
 fpu/softfloat-specialize.c.inc |  38 ++++
 5 files changed, 703 insertions(+), 25 deletions(-)

