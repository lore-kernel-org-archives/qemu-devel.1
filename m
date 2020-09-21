Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30094C4347E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 923842223E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLon5PQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923842223E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKPrC-0001TL-HI
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 13:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKPoe-00085J-V1
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:41:31 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:51160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKPoa-0000Gi-8w
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:41:27 -0400
Received: by mail-pj1-x1030.google.com with SMTP id fa1so169753pjb.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JhQrswFWtXkW7zh73QbRSHRG8o2YQ8bcQ9ITeWC+23k=;
 b=aLon5PQlrA674ndKex3OBqaPWd/11cL/PqMKvUHLtwT4drbkMCypL3mjPzQfASScsn
 63pt3XZNSzElaN1z9jJ1yxjnzzm9f7QapDJEgMY1XiyjY2frRVCd5jFceCNtZNMSchOS
 sLjeSJygvB+aWKDGEr+S2YfvcooGbME9QccUWSLXNzF0zPPQdjxLOAKykrP7JkMeDsDB
 vKQmAAoCyPCftiFzFLVKCsAquHnlIgfPqGI+5+z8MjLotjT/3qNGZg5tfSrmaKcChIHf
 zclDyPncRYTx84x3o0lZ0JUz6QOm7G83MmmoZ0F4o6MzTtg2q4Hx6eqb7APNlj5aEJX6
 mtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JhQrswFWtXkW7zh73QbRSHRG8o2YQ8bcQ9ITeWC+23k=;
 b=cMxCBs76xWnIMco5Mc1Jiea+tvSm57ajThNCHhEiJE5N6vk+aH0aClzRTeMFvQxMXg
 r/RkG2l8jkLXBHEiRnTTrB9udBfyWv0eOei5aqLHWJef/q7ZgkyvKfEcpzjto7ZzP0Hk
 5B7mDKiTyzaZwBIJ5n7vwuegDAoci27grR9kqoMrhgDIVR5wBtoU9yZGuNCsHa9Rfte5
 OTVhLu+bdf3gz+R7uO+W18MykuDQBVKxxqnj/Fqz/7WPiAUrSooH6OR9vce3IaLiJqb3
 AZpsQuu//ujyt5BK5Tsklg62sbw/R36Vl38cVODOIbNfh6asuYbN+lHvNN6RUYQhaDuA
 APkA==
X-Gm-Message-State: AOAM531SnKojHyS9NmRzxxWPqbPzUm1A3Jd8f/bnBnpaEw4B6pp6eVi2
 sVBUbtklGIeD2BOTXyK+7pmCng7JW6lfKA==
X-Google-Smtp-Source: ABdhPJzdbiqTso8cd+v2tG+ItgKqasfPXVyHM+5JGf+GZPkCojeS0rEbuHiKrlBiykHCedahdQkSNA==
X-Received: by 2002:a17:90a:65ca:: with SMTP id
 i10mr400513pjs.137.1600710081338; 
 Mon, 21 Sep 2020 10:41:21 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x4sm12585379pfm.86.2020.09.21.10.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 10:41:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/11] capstone + disassembler patches
Date: Mon, 21 Sep 2020 10:41:07 -0700
Message-Id: <20200921174118.39352-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patches lacking review:

0002-capstone-Update-to-upstream-next-branch.patch
0003-capstone-Require-version-4.0-from-a-system-librar.patch
0007-disas-Cleanup-plugin_disas.patch
0009-disas-Split-out-capstone-code-to-disas-capstone.c.patch

Changes for v4:
  * Require v4.0 from the system library.
    Fixes an issue AJB found from v3.0.5 from ubuntu 18.

Changes for v3:
  * Fix default value for capstone in meson_options.txt.
  * Add "Submodules" separator in meson.build (paolo).
  * Remove form-feed characters in dis-asm.h (thuth).

Changes for v2:
  * Several configury changes in patch 1, along the lines
    of that suggested by Paolo, but not exactly the same.
  * Drop sparc capstone enablement (I suddenly have a memory
    of doing the same thing last year).


r~


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

 configure                 |  64 +---
 Makefile                  |  16 -
 include/disas/dis-asm.h   | 104 +++---
 include/disas/disas.h     |   2 +-
 include/exec/log.h        |   4 +-
 accel/tcg/translate-all.c |  24 +-
 disas.c                   | 703 +++++++++-----------------------------
 disas/capstone.c          | 326 ++++++++++++++++++
 target/s390x/cpu.c        |   4 +
 tcg/tcg.c                 |   4 +-
 capstone                  |   2 +-
 disas/meson.build         |   1 +
 meson.build               | 124 ++++++-
 meson_options.txt         |   4 +
 14 files changed, 678 insertions(+), 704 deletions(-)
 create mode 100644 disas/capstone.c

-- 
2.25.1


