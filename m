Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12BDC35257
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636AF20719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VzEyCjgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636AF20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOT87-0004Py-Du
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 18:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOT5u-0002Rv-53
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:00:02 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:39159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOT5r-0007Lf-7G
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:00:01 -0400
Received: by mail-ot1-x332.google.com with SMTP id u25so2879004otq.6
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 14:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4Dp1ZT13R0EQdEu6dxQsq0XHxGgkkn7MNkTsVH0IryU=;
 b=VzEyCjgHWf9UwTPvOoMP79F1mljFfZrjrezkIMT1ct+0EQxESPVUG5zy82gV3bCHxS
 5q7e+N/iIdPmKDjZMpcXq6uiDAnDbeqhmr1XGSJTFMOSzMfqmOBbAt1HYTfPHGUVuIxN
 xVjHNRy7nqYnNhGT8Qwf4Sz5DQmUmToNLpwYHHqWyDdOXjyrKePYq5di6Zv7Dgy+/PgI
 QuXa7DNQeGMXm3Ual7YVI8e/67IDkxV0Qg9weMMWyAvjlcGMcerunNkMss1BZQ4gKzgI
 IzFGt+AZxsVce6C/Gw27EC3f5h0l2QtQQcGmFAK7Of+w4K3A9I22pcMQw0/bAtr2Yp7y
 tW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4Dp1ZT13R0EQdEu6dxQsq0XHxGgkkn7MNkTsVH0IryU=;
 b=t5MgYXigzFJlyqGflDz4ZuS/k7jPhOCXcBqhM1xBkXaH4lZFoDIJM86Wdde46cCXiJ
 a07cELUJZgVQ8CoiomAxMRDBDxhv/jZYbdeWiI1GanqgdVfh3NbOKc4omNfRD5K4rrfy
 eeX37eteQC5EgI5ZveXFCZCGuRf1qxCdcoc0ND5zv2yOVa03n3gabSzxQi0n+VLVOcjE
 PlRX9uUJyBmZGCDaEkU2DqTho09mYOeKPcYcr2Cp5ZjUvFIGabqlcHenMmQ8HKC7IC6H
 Bs6M9CU6j9X4pjChwss3JJV9zUR6075jqMgn7wCGBDUCaK0oCalAUXVaoTfgyLc+TxpK
 pdDQ==
X-Gm-Message-State: AOAM532VdLXUNBhg4YeSK87yK02tkeIQU7Qu5x1ziWaRTGYDXx0k4Uaj
 DWM9wjpGhLgal8uCuIPOXOymhG2V3u1m/vSR
X-Google-Smtp-Source: ABdhPJxAkhJGDjUn9YTztGdCrXIZTjZ/o/n1OZqcumcDuABOqW5J5Ym+wzgcnd0YtYlD+VVNisBiPA==
X-Received: by 2002:a9d:6950:: with SMTP id p16mr3124284oto.60.1601675997688; 
 Fri, 02 Oct 2020 14:59:57 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id k10sm684268ots.60.2020.10.02.14.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 14:59:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 0/8] linux-user: User support for AArch64 BTI
Date: Fri,  2 Oct 2020 16:59:47 -0500
Message-Id: <20201002215955.254866-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel abi for this was merged in v5.8, just as the qemu 5.1
merge window was closing, so this slipped to the next dev cycle.

Changes from v9:
  * Split what is now patch 7 into 3 more (pmm).
  * All prerequisites are now upstream.


r~


Richard Henderson (8):
  linux-user/aarch64: Reset btype for signals
  linux-user: Set PAGE_TARGET_1 for TARGET_PROT_BTI
  include/elf: Add defines related to GNU property notes for AArch64
  linux-user/elfload: Fix coding style in load_elf_image
  linux-user/elfload: Adjust iteration over phdr
  linux-user/elfload: Move PT_INTERP detection to first loop
  linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0 notes
  tests/tcg/aarch64: Add bti smoke test

 include/elf.h                     |  22 +++++
 include/exec/cpu-all.h            |   2 +
 linux-user/qemu.h                 |   4 +
 linux-user/syscall_defs.h         |   4 +
 target/arm/cpu.h                  |   5 +
 linux-user/aarch64/signal.c       |  10 +-
 linux-user/elfload.c              | 147 ++++++++++++++++++++++--------
 linux-user/mmap.c                 |  16 ++++
 target/arm/translate-a64.c        |   6 +-
 tests/tcg/aarch64/bti-1.c         |  62 +++++++++++++
 tests/tcg/aarch64/bti-crt.inc.c   |  51 +++++++++++
 tests/tcg/aarch64/Makefile.target |   7 ++
 tests/tcg/configure.sh            |   4 +
 13 files changed, 298 insertions(+), 42 deletions(-)
 create mode 100644 tests/tcg/aarch64/bti-1.c
 create mode 100644 tests/tcg/aarch64/bti-crt.inc.c

-- 
2.25.1


