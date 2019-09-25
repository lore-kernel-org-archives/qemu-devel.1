Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CD6C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 18:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122182146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 18:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AonRu9B4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122182146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCLP-0003Ya-IU
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 14:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIU-0001ee-AA
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIS-00048P-SE
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:45:53 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:44040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCIS-00047H-L2
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:45:52 -0400
Received: by mail-pl1-x630.google.com with SMTP id q15so2907446pll.11
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E/opTQx6WaD0jbTM2lFpAL80XVPTdHGWKhJl1a4TZDI=;
 b=AonRu9B41EhiRgLn6WdTcpcbgqywbzlHz9el2CnIKYzoVs96uO23yA2sSIPVyw6jw+
 p1iPwsI/ZwjdSs3YX3moh10B0eRG/wqjt5e+wAUrguDYgYcZTVzUV3XnMIMZ+cj984vA
 TcQEudXJcHnJ3FWxCbN3BcfQNKRL0obuoao0PCSUsbOOu/mAOKZnc6D6WR3iII77xrvo
 c7RMeakPYu9GiNbCwbLpcQuxYGc1uZOc1WoLzxUfyeXvd6uE3uzAlKOkbzaywQBD2IyX
 C+fHIoRFB1fExbOpQQVGv3kxSRZipnQ2RpslraWiKdoygDcD1Y1E8Q8lZIcvdZhQGKQb
 R/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E/opTQx6WaD0jbTM2lFpAL80XVPTdHGWKhJl1a4TZDI=;
 b=F8BzcK1dyk1MH12+uEJ/r0L4wskeocnQCadgvAni6sl30ccnd10oHWZjiSmfRXsvSC
 ps8FaHp18fTSWG/zVKMXtDFsKNsTOIa7y9zMO3YXnjmHJnFOI2KCDFN12km0XrkvwE2s
 OyOVepKySdqtDhv17NHD9jXC7c0ny5xKMNyfT9NoOeXCZhZ+bJWuyY79jLTSXO9yZcKl
 7/ettux0O7HjhvpCli9qSGSkNebE8X/jxsSJ7vjthlSTFUO1cBEMcUjTfkYhSCsDgaM4
 AKsfb4T+S6iL/Dyx6nxa9tQ6Rq1PIHBsU/uQv63tkGG4JhiglfjbI153Bba0AyIW/fBf
 XwnA==
X-Gm-Message-State: APjAAAXz1P5DzXbQ/QgDdVdwbueQiQBa6dzM1VNCv19Cv+xJEeRx7o0s
 RGo+0EpRZ9hJq7RbAnibLHOJXjkUJgM=
X-Google-Smtp-Source: APXvYqxeZZrpvLCIc7u31w9dyBqOocRkqUdSmpn4KbCbl/8BSLdF2rZ2GRpTVXUS46Sz5XSwms0YXQ==
X-Received: by 2002:a17:902:7615:: with SMTP id
 k21mr10524360pll.116.1569437150915; 
 Wed, 25 Sep 2019 11:45:50 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id l24sm6133229pff.151.2019.09.25.11.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 11:45:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] tcg patch queue
Date: Wed, 25 Sep 2019 11:45:32 -0700
Message-Id: <20190925184548.30673-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::630
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

This is v4 of my notdirty + rom patch set with two suggested name
changes (qemu_build_not_reached, TLB_DISCARD_WRITE) from David and Alex.


r~


The following changes since commit 240ab11fb72049d6373cbbec8d788f8e411a00bc:

  Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20190924' into staging (2019-09-24 15:36:31 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190925

for you to fetch changes up to ae57db63acf5a0399232f852acc5c1d83ef63400:

  cputlb: Pass retaddr to tb_check_watchpoint (2019-09-25 10:56:28 -0700)

----------------------------------------------------------------
Fixes for TLB_BSWAP
Coversion of NOTDIRTY and ROM handling to cputlb
Followup cleanups to cputlb

----------------------------------------------------------------
Richard Henderson (16):
      exec: Use TARGET_PAGE_BITS_MIN for TLB flags
      cputlb: Disable __always_inline__ without optimization
      qemu/compiler.h: Add qemu_build_not_reached
      cputlb: Use qemu_build_not_reached in load/store_helpers
      cputlb: Split out load/store_memop
      cputlb: Introduce TLB_BSWAP
      exec: Adjust notdirty tracing
      cputlb: Move ROM handling from I/O path to TLB path
      cputlb: Move NOTDIRTY handling from I/O path to TLB path
      cputlb: Partially inline memory_region_section_get_iotlb
      cputlb: Merge and move memory_notdirty_write_{prepare,complete}
      cputlb: Handle TLB_NOTDIRTY in probe_access
      cputlb: Remove cpu->mem_io_vaddr
      cputlb: Remove tb_invalidate_phys_page_range is_cpu_write_access
      cputlb: Pass retaddr to tb_invalidate_phys_page_fast
      cputlb: Pass retaddr to tb_check_watchpoint

 accel/tcg/translate-all.h      |   8 +-
 include/exec/cpu-all.h         |  23 ++-
 include/exec/cpu-common.h      |   3 -
 include/exec/exec-all.h        |   6 +-
 include/exec/memory-internal.h |  65 --------
 include/hw/core/cpu.h          |   2 -
 include/qemu/compiler.h        |  26 +++
 accel/tcg/cputlb.c             | 348 +++++++++++++++++++++++++----------------
 accel/tcg/translate-all.c      |  51 +++---
 exec.c                         | 158 +------------------
 hw/core/cpu.c                  |   1 -
 memory.c                       |  20 ---
 trace-events                   |   4 +-
 13 files changed, 288 insertions(+), 427 deletions(-)

