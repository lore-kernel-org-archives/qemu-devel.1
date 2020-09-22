Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195D2C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 934812376F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ew6/Mjpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934812376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmUP-0005uQ-KG
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOJ-0007v7-J9
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:47:47 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:44486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOH-0004Jv-Kv
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:47:47 -0400
Received: by mail-pg1-x52e.google.com with SMTP id 7so12551974pgm.11
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=76echFVw2ywmxS9ADqK3GamihoGZpJPMGPkXUnxNrY8=;
 b=ew6/MjppoqnjQkZTeDezFqgQKjFIn1nVqFTFDmoKDZ+1pA8PyA/lTCuEXIpRsubL7X
 31WDEzEdTlNmW5XuHIv4MPTBXkDT9Wzboq1VMhwWFyZoUrSGEyUGoV5P2AABWmOsMmd2
 KanHnaUVXg+7nWgCnTrCWAmt3LMmKtRpLwBasXz9SdJKVs4hMalkkM33JOcObic5JeVE
 OA5rbbRD6MSs9EG0TszqDv9CxEhTRgvhEmNaZHiqxvYXQCVmwGeDIthbWpTeRu5/5+sj
 kf4JIHz8WR9t119s3RmwjEYGc68UbWpglE2e3r+enU9zTwLt3/HwNrEygHSq5nSdx2MZ
 LGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=76echFVw2ywmxS9ADqK3GamihoGZpJPMGPkXUnxNrY8=;
 b=e0M2S1V9O5s46UcTIiaE1qyEV2XqOBhdasu77bLJC55P4qZ2PNaNadCn1V/vfiD9lL
 xs8oFdPDKsJYPkREF1DVQCkig/ilPe4PlwJWKNQLoyl2LaIZBBcFConPEOog0By17qRB
 ostvjWRW9KKqKP1btlzEOVC3I9Ft6Hu3de7cArHXS/AUZpyvM7njs2jWz6WMP4mjO0I7
 ocvNq1U2upLu2sm46+Ptcf0o4TEq8m5OGPB+15PtJuzBQKGuEnyaHXEBhfvTmF+NUUg7
 8P7J7fLQVUvIMqb1Z7FBifXQJkfHiZgYY9hCyDWndAz2mjcMzru0imJVlCkLVyxguDWJ
 2lKg==
X-Gm-Message-State: AOAM530DojzFomQJ2Hkc2flEtyqliF7E4pXZDmW6Aaflh+tbahLKjYcg
 O+1tqk4qlDrZpGtsldWEi3KNtFOfWeytmQ==
X-Google-Smtp-Source: ABdhPJx3R+TnEADMMZA/EnDfHPjmPmIz1gMrCx3Bxxku697JlEUuFu/zaxmJb3ylHiIr7pwFHku7mw==
X-Received: by 2002:a63:31c5:: with SMTP id x188mr4250940pgx.1.1600796863643; 
 Tue, 22 Sep 2020 10:47:43 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r1sm14825310pgl.66.2020.09.22.10.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 10:47:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] capstone + disassembler patch queue
Date: Tue, 22 Sep 2020 10:47:30 -0700
Message-Id: <20200922174741.475876-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

The following changes since commit 834b9273d5cdab68180dc8c84d641aaa4344b057:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-for-5.2-pull-request' into staging (2020-09-22 15:42:23 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-cap-20200922

for you to fetch changes up to fcfea6ced053045beb1dc8d22bdeaacc9c03d0b9:

  disas/capstone: Add skipdata hook for s390x (2020-09-22 08:59:28 -0700)

----------------------------------------------------------------
Update capstone submodule from v3.0.5 to v5 ("next").
Convert submodule build to meson.
Enable capstone disassembly for s390x.
Code cleanups in disas.c

----------------------------------------------------------------
Richard Henderson (11):
      capstone: Convert Makefile bits to meson bits
      capstone: Update to upstream "next" branch
      capstone: Require version 4.0 from a system library
      disas: Move host asm annotations to tb_gen_code
      disas: Clean up CPUDebug initialization
      disas: Use qemu/bswap.h for bfd endian loads
      disas: Cleanup plugin_disas
      disas: Configure capstone for aarch64 host without libvixl
      disas: Split out capstone code to disas/capstone.c
      disas: Enable capstone disassembly for s390x
      disas/capstone: Add skipdata hook for s390x

 configure                 |  64 +----
 Makefile                  |  16 --
 meson.build               | 124 +++++++-
 include/disas/dis-asm.h   | 104 +++----
 include/disas/disas.h     |   2 +-
 include/exec/log.h        |   4 +-
 accel/tcg/translate-all.c |  24 +-
 disas.c                   | 707 +++++++++++-----------------------------------
 disas/capstone.c          | 326 +++++++++++++++++++++
 target/s390x/cpu.c        |   4 +
 tcg/tcg.c                 |   4 +-
 capstone                  |   2 +-
 disas/meson.build         |   1 +
 meson_options.txt         |   4 +
 14 files changed, 681 insertions(+), 705 deletions(-)
 create mode 100644 disas/capstone.c

