Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E15C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE6D20835
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCTwwwpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE6D20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jih57-0001of-VD
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jih3n-000063-76
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:25:11 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:37122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jih3l-0000Sa-E2
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:25:10 -0400
Received: by mail-pf1-x42c.google.com with SMTP id j1so10128416pfe.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A8xa0HH5bE0G78/TNjauK05gt2+9cNe+UPKq7I1z8fQ=;
 b=CCTwwwpvMbD2UqMR38nnMJm1j5R3oitczS7CcXmhXaYja2Zm3NoOAsWW2yrnCrZeYK
 rchJdVSvRHcIHDuX8YzkDyG2IGrUHupbuG6OPVARY2zVh/tpldeqO5oS+ZP+2zsNfidV
 augxmMUxG9cR8Mu4+sKrMvZU5tRUnIuVceWf7G8rv4NpXuTvUXTbbO2V2QlmQfSD2wtA
 JFtrYqeuqo5KzW6aRz2/Of3tIphqhawb8P66E5MqASlcy1YISk3IiFl2NFTUXaAu8zQY
 ++Gxj5pCYXU8F3xmQ2jqEj6T5S9uEbbrzVMtTTi3NgLk2n2RgMGOC2xeZhfhhzET06Fy
 1efQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A8xa0HH5bE0G78/TNjauK05gt2+9cNe+UPKq7I1z8fQ=;
 b=QLiP+gXpUCDkHCbl3JwDKHa6csMv5Ew1hsoX5q7mz21wpA1ts8VBdfTZfjOfFBJ07C
 7ZssNdnwx6mcZv4j+XhZcV8j1V6AW4HOy4ZTyjgfC03kkwIYFHTPHRh1u2t4FUUpi0J1
 S116lwVvLhDEsqxmkPCK0QT5Pw590XodxTRgOeSpQMjeQ6T9wjNovOs1fpkz0YKdzgOC
 yWH07sTofvmxGWKnB/+abvkjoSLW0gxuatIdjDDIrsEcy9l1TQpjnJtlreMyP1j1u7jI
 INA78Flh0Ed7WedVAoyL80vQlEYmQidxloVaevBwB2O8NslV2i4AVHq3jhO5shxIYoFI
 FQ8g==
X-Gm-Message-State: AOAM531cDSAiDTuz84so1uAuvMHeM+Rzr15wCMk72NT1weuxo2CHoC3n
 tFUy67cwclY+ynBAPRIlIdYOhExVNL0=
X-Google-Smtp-Source: ABdhPJxB9aiKxM6bsSjb3k753k3XgAv3EjDxWsO2p+Y5vsJ16MECBcPUBNxqyMzekVNrwQ+U6eNZww==
X-Received: by 2002:a63:6c8:: with SMTP id 191mr24499665pgg.22.1591719906354; 
 Tue, 09 Jun 2020 09:25:06 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s188sm7580101pfb.118.2020.06.09.09.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:25:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] decodetree: Add non-overlapping groups
Date: Tue,  9 Jun 2020 09:24:55 -0700
Message-Id: <20200609162504.780080-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

The following changes since commit 49ee11555262a256afec592dfed7c5902d5eefd2:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-request' into staging (2020-06-08 11:04:57 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-dt-20200609

for you to fetch changes up to d6084fba47bb9aef79775c1102d4b647eb58c365:

  target/arm: Use a non-overlapping group for misc control (2020-06-09 09:21:19 -0700)

----------------------------------------------------------------
Add non-overlapping groups

----------------------------------------------------------------
Richard Henderson (9):
      decodetree: Tidy error_with_file
      decodetree: Rename MultiPattern to IncMultiPattern
      decodetree: Split out MultiPattern from IncMultiPattern
      decodetree: Allow group covering the entire insn space
      decodetree: Move semantic propagation into classes
      decodetree: Implement non-overlapping groups
      tests/decode: Test non-overlapping groups
      decodetree: Drop check for less than 2 patterns in a group
      target/arm: Use a non-overlapping group for misc control

 target/arm/t32.decode                        |   4 +-
 tests/decode/err_pattern_group_nest1.decode  |  11 +-
 tests/decode/err_pattern_group_nest2.decode  |   6 +
 tests/decode/err_pattern_group_nest3.decode  |  14 +
 tests/decode/succ_pattern_group_nest2.decode |  13 +
 tests/decode/succ_pattern_group_nest3.decode |  11 +
 tests/decode/succ_pattern_group_nest4.decode |  13 +
 scripts/decodetree.py                        | 513 +++++++++++++++------------
 8 files changed, 360 insertions(+), 225 deletions(-)
 create mode 100644 tests/decode/err_pattern_group_nest2.decode
 create mode 100644 tests/decode/err_pattern_group_nest3.decode
 create mode 100644 tests/decode/succ_pattern_group_nest2.decode
 create mode 100644 tests/decode/succ_pattern_group_nest3.decode
 create mode 100644 tests/decode/succ_pattern_group_nest4.decode

