Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B722BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874C4206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYPATk30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874C4206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsWFZ-0002W6-RV
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 14:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsWEY-0000qr-B3
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:52:54 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:47042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsWEW-0000fC-Nc
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:52:54 -0400
Received: by mail-pl1-x635.google.com with SMTP id j7so2332073plk.13
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 11:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GVTDiY0ZsA/nF7FM/+lifohaf9ERBm26oBV/l0jEJ6o=;
 b=OYPATk30bDHCZ0Syi2yg+G7tKhzFdgzbG7soVynVqyMeATXYaKlub6u72RS10h3Ar/
 SsP9gK4y1Kex64z8x+thR4Ro1g7fovuOTXNDgwUvmjZjmMuZ4vtJX3ctfgjuFCjOWKKM
 G5c/YP6SS5zlVa9NCgwsfXO0G7MX9E8aapdN3u6oZJBNy5mMdVVezlu6azcsO3fgtEQH
 43PRDTFrBN3K5IIoutu++g+RxC8V6eK6wKgSI9JRO9TUy9wV5JkPukDjzjj8Sql5kViP
 YeiOjI0T0VKp6TBVGkZ+I2lYC8nIVkHlxkWit9hxyF4uhWi6+4iVXyZZn51+iol/kH64
 CNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GVTDiY0ZsA/nF7FM/+lifohaf9ERBm26oBV/l0jEJ6o=;
 b=nmJpZkw4HgPrceYzCGqdbMwTZI+T0memR+ujO5X0txOm8HAD/eSR9e6Xmu86TXgzmn
 mfjdHmk0c6twwj/3yByPwouSOXmGDqvM7e0HNqZqA0o4DKPa/0rczcgDdACpjdWauJyn
 21AUiMnsYGvfcjtp3K20i2/2/fjGS5JwaC9mCVh1LoIv2LnVDUMRZOa4wnvyRTuRaFbV
 c5k1oBqHhwHIp26avegzWw7IbFZ5yYSYVmh3CvlrhqhCUbSRTmkL6NeIxXw7qhH5hMxa
 qoYbxVVhBXAhHbo0LxxRA22We0IkSQkd8sav7IhxolH2MHt1GfTll7UX23QqqmSnbmvW
 Rwrw==
X-Gm-Message-State: AOAM530s1r3940ftXAZ1yawMUy6kObuePesj/zle1X3gDTDID/vU7mti
 TBOd7AD/aLlCRoYGXrNUVLPZjXf8zSg=
X-Google-Smtp-Source: ABdhPJxAApUR4Gah6kboMdUyJs8aC3Rcb7iiTz9SMkTFvMcVLsfl8/g4nqUADcZVl7fwM80iZl2SVQ==
X-Received: by 2002:a17:90a:df0f:: with SMTP id
 gp15mr580205pjb.98.1594061570268; 
 Mon, 06 Jul 2020 11:52:50 -0700 (PDT)
Received: from localhost.localdomain (097-090-106-114.biz.spectrum.com.
 [97.90.106.114])
 by smtp.gmail.com with ESMTPSA id q6sm19988179pfg.76.2020.07.06.11.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 11:52:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] tcg patch queue
Date: Mon,  6 Jul 2020 11:52:45 -0700
Message-Id: <20200706185248.118447-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

The following changes since commit eb6490f544388dd24c0d054a96dd304bc7284450:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200703' into staging (2020-07-04 16:08:41 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20200706

for you to fetch changes up to 852f933e482518797f7785a2e017a215b88df815:

  tcg: Fix do_nonatomic_op_* vs signed operations (2020-07-06 10:58:19 -0700)

----------------------------------------------------------------
Fix for ppc shifts
Fix for non-parallel atomic ops

----------------------------------------------------------------
Catherine A. Frederick (1):
      tcg/ppc: Sanitize immediate shifts

Richard Henderson (1):
      tcg: Fix do_nonatomic_op_* vs signed operations

 tcg/ppc/tcg-target.inc.c | 15 ++++++++++-----
 tcg/tcg-op.c             | 10 ++++++----
 2 files changed, 16 insertions(+), 9 deletions(-)

