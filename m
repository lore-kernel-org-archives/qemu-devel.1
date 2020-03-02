Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7526CC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6A82173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rx6Enlj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6A82173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pM8-0000AB-Ap
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pKs-0006aN-GZ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pKr-0007X6-87
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:34 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:44638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8pKr-0007Wo-31
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:33 -0500
Received: by mail-pg1-x52c.google.com with SMTP id a14so167394pgb.11
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9C1wlp8smjmp404ViBx+09KVCvZn3cMFmruSUtBUGyI=;
 b=rx6Enlj24DsMW9PHpcIavuaDcnAp6zntEtNmcmQ7NGyUvsIj6oHq71izN4zK2zNSU8
 O+1fKfdKJNFEfPvqU08vmz9vt6hw/jznXzhSG1B9p5c/drlDnXOa0jMIqo08h5A9Qp6v
 Uf66eKXlhfGX5n4QmdrP7ZavC9PoRKXw6DadMUmpLsd0QYNo3nW3iue50pr0NyytAC2m
 ALopL3ND3jiKX16spYPhu/0cf9BwHUhMvPc/7drMJth+sDbRCrC7SB/Zb9eMPONms3Gr
 9bYlK1wpz67JBZbcdbb+aDD1/h5ahqbjIghzJ6QMcaj5i9gD9JM8Z0aFXVyDEFQJCFNe
 GIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9C1wlp8smjmp404ViBx+09KVCvZn3cMFmruSUtBUGyI=;
 b=oTU8PVu66nLSCyEB5NXLN0GnWxwbF050ZTk/9riAhudSBM6PAzt4BizlVKJC0PsAtt
 PuUnAez19WYd0SvZE+3hfqA9TTcvBYGs8GFXEuFK7frA9yeLy9EmNnl5S68yHoHak57q
 d9CnA5ex1eccMA0+JaYbflVOVLdjTI1rsYnoMJYUD43LaWZNZg+Nesw3mbnRVSTDIi8z
 VWy3xksSNLgjy7L1UIhvsEwJzUIT2wW9e+Hv104vhKzwh2TOpesMN5pWoR9Kpqfg++rl
 dD4TAaYQ9eA4PsnJE7hPM4emBWErapt2EthfEsqqUl91gZJVe0D6q/sIbwrwixLn9WSv
 vN7g==
X-Gm-Message-State: ANhLgQ3os1uYxLn29+XXXyunDUOYoVeXx7DmGC+Jk3BOiTq7Wjdn3kPR
 GyaFdYSxe00kXnxBgBgMpa4WOy7miZE=
X-Google-Smtp-Source: ADFU+vtrYcxAHEW1XybOugjK/Eutf4BSM/kqtGlyqOXAl2H2MwbTItHnxnhsPhqekSqpk93GAWwgbg==
X-Received: by 2002:a63:df0a:: with SMTP id u10mr112178pgg.282.1583171911542; 
 Mon, 02 Mar 2020 09:58:31 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id s18sm99510pjp.24.2020.03.02.09.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 09:58:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/9] target/arm: Misc cleanups surrounding TBI
Date: Mon,  2 Mar 2020 09:58:20 -0800
Message-Id: <20200302175829.2183-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52c
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes for v2:
  * Improve commit message in "Optimize cpu_mmu_index".
  * Add "Introduce core_to_aa64_mmu_idx".
  * Use it in "Apply TBI to ESR_ELx in helper_exception_return".

Blurb for v1:

We have a bug at present wherein we do not supply the memory tag to
the memory system, so that on fault FAR_ELx does not contain the
correct value.

For system mode, we already handle ignoring TBI in get_phys_addr_lpae,
as long as we don't actually drop the tag during translation.
For user mode, we don't have that option, so for now we must simply
accept that we'll get the wrong value in the siginfo_t.

In the process of looking at all that I found:

  * Exception return was not applying TBI in copying ELR_ELx to PC,
    - Extracting the current mmu_idx can be improved,
    - Replicating the TBI bits can allow bit 55 to be used
      unconditionally, eliminating a test.

  * DC_ZVA was not handling TBI (now only for user-mode)
    - The helper need not have been in op_helper.c,
    - The helper could have better tcg markup.

  * TBI still applies when translation is disabled, and we weren't
    raising AddressSpace for bad physical addresses.

  * SVE hasn't been updated to handle TBI.  I have done nothing about
    this for now.  For the moment, system mode will work properly, while
    user-only will only work without tags.  I'll have to touch the same
    places to add MTE support, so it'll get done shortly.


r~


Richard Henderson (9):
  target/arm: Replicate TBI/TBID bits for single range regimes
  target/arm: Optimize cpu_mmu_index
  target/arm: Introduce core_to_aa64_mmu_idx
  target/arm: Apply TBI to ESR_ELx in helper_exception_return
  target/arm: Move helper_dc_zva to helper-a64.c
  target/arm: Use DEF_HELPER_FLAGS for helper_dc_zva
  target/arm: Clean address for DC ZVA
  target/arm: Check addresses for disabled regimes
  target/arm: Disable clean_data_tbi for system mode

 target/arm/cpu.h           |  23 ++++----
 target/arm/helper-a64.h    |   1 +
 target/arm/helper.h        |   1 -
 target/arm/internals.h     |   6 ++
 target/arm/helper-a64.c    | 114 ++++++++++++++++++++++++++++++++++++-
 target/arm/helper.c        |  44 +++++++++++---
 target/arm/op_helper.c     |  93 ------------------------------
 target/arm/translate-a64.c |  15 ++++-
 8 files changed, 182 insertions(+), 115 deletions(-)

-- 
2.20.1


