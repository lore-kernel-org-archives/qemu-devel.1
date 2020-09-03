Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ADFC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3201720709
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFoUDl3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3201720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxOT-0007f1-BN
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDwyk-0007Qy-UU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:41:12 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:34103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDwyf-0004a5-Vc
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:41:10 -0400
Received: by mail-pf1-x42e.google.com with SMTP id v196so3408593pfc.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 14:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1fNDseZ9SDGoXgNKePUMNTLK7Q+5VcyxB+0nZHQz/II=;
 b=bFoUDl3+7NnwfzNh+xyJsfFiPBEbiiERKNZliR/gWMZ/ZZgz4aVutXH+Bj4++fW0zF
 jtZMfmEX3wDtKUuHC4BVnGIBIfc4hxNBat+vKY9NNr3UuuKCNVsTKSh+/0JMxIpjsfn/
 VE+NKqB4UlNzXMCx515yoeuIfnNJFD2pfO6hqxIiJ4sH80Ve5jLp5S0A+dBs7NRr3Qu7
 mVK3gcY+Ue6bLpDuIbpYrX6Bqgu6ulkw3Y1fJsHPXolMxs99JJZOAgCol80Ys6lEoZG7
 Z8VOlyS2ANYw4R3jVqBqFCLRW0f6owD3rHmObTb4SO4kj83cpAc2Hv64GTazKcJvIQJl
 SRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1fNDseZ9SDGoXgNKePUMNTLK7Q+5VcyxB+0nZHQz/II=;
 b=QRBuGJvdPSZkS526opUE5X/kSJTNh86rit8ONYSIZIP1j9tRiX5h9iF/kzmTdsDdD0
 ftSfbVGH8WpEYt0Jm4nWCzUFPsrrRHySCZKsxN1WbVvKZVRzT58aOx/FMNHrb372wWSS
 K7GhCjeyg2xy0f6Uxox1IKiClvIvU8xstvPjvgQiBGe24RhWBc3ws58fYqBQt8zZuzWj
 N3yP7FwK7HILVvrJx5UW1fQAApIGWsxQVmvRb3lH6I+kxaq6YnT6LsSXUSOQ8IpeqcVl
 UiqCvPvGxIRinllP7wWPjkG2hlalqRPHmhV7K1GmtWoO0eMT5i4wL89WrVb9vSYPS6eP
 F/hA==
X-Gm-Message-State: AOAM530J/Q0DCP+/Y4rQ6a/bQNgU0HtYR2ZWG2m7QZlURdJ92B0JNzb9
 Dc6e3U5kHJKRql6AjVTNsqjfHtwRznluog==
X-Google-Smtp-Source: ABdhPJwUQSGU/7g3dmCDEwu9ykwBjQax1enWUKH3Setglu6yhdfcC6lrVh6GWbyplYMek+WRmmQEBg==
X-Received: by 2002:a05:6a00:814:: with SMTP id
 m20mr5677866pfk.50.1599169263693; 
 Thu, 03 Sep 2020 14:41:03 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v17sm4113290pfn.24.2020.09.03.14.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 14:41:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] tcg patch queue
Date: Thu,  3 Sep 2020 14:40:56 -0700
Message-Id: <20200903214101.1746878-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

The following changes since commit 3dd23a4fb8fd72d2220a90a809f213999ffe7f3a:

  Merge remote-tracking branch 'remotes/legoater/tags/pull-aspeed-20200901' into staging (2020-09-03 14:12:48 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20200903

for you to fetch changes up to fe4b0b5bfa96c38ad1cad0689a86cca9f307e353:

  tcg: Implement 256-bit dup for tcg_gen_gvec_dup_mem (2020-09-03 13:13:58 -0700)

----------------------------------------------------------------
Improve inlining in cputlb.c.
Fix vector abs fallback.
Only set parallel_cpus for SMP.
Add vector dupm for 256-bit elements.

----------------------------------------------------------------
Richard Henderson (4):
      cputlb: Make store_helper less fragile to compiler optimizations
      softmmu/cpus: Only set parallel_cpus for SMP
      tcg: Eliminate one store for in-place 128-bit dup_mem
      tcg: Implement 256-bit dup for tcg_gen_gvec_dup_mem

Stephen Long (1):
      tcg: Fix tcg gen for vectorized absolute value

 accel/tcg/cputlb.c | 138 ++++++++++++++++++++++++++++++-----------------------
 softmmu/cpus.c     |  11 ++++-
 tcg/tcg-op-gvec.c  |  61 ++++++++++++++++++++---
 3 files changed, 143 insertions(+), 67 deletions(-)

