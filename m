Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88611ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 18:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502692089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 18:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pjFbZYsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502692089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLAtp-0003Bh-5F
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 14:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLArk-000125-4L
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLAri-0000oK-Ox
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:15 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:41127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLAri-0000nx-Gp
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:14 -0400
Received: by mail-pf1-x432.google.com with SMTP id q7so2206578pfh.8
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1nvchNn+VWtn/WVfmFkMyvJoEKsssvYDkhUOA8bdyeU=;
 b=pjFbZYsHERgxd0UTphjzgIl1XGCwLM9sm0zge6jhrNA5FoAbgAIAGlgXOPacrBR7VZ
 a7+LXPT9k/9cXBjB9rCUMN2itliSMl2+Sz3haIPLBT7KOd+2pxylbPfw+tUY8cTSBeK+
 W0a6DeoKFq3LFJWolQzQt+Qr3CZFKp0OmdXYYF1knCNWgtEw9GRlaawrVLKVEFudiLSt
 6EC2O6LNl5GnpWwQDA0TMwoUbWyssKm189E+qG9nC70d1zE8cYNXWKd9A8MVsdDLtsyI
 b04B8wZthi7cJUapq/NsNF3nDtD1u75iWGxKQZnccxt2IrTV+KXnxrEwbQMENM9ahcvZ
 dd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1nvchNn+VWtn/WVfmFkMyvJoEKsssvYDkhUOA8bdyeU=;
 b=ARP/fSzsGTwtEYOv2yZhkMPzPZa1GUIsXWktRkUrb3/ZaUizE2qvvNh8fh7Ds4FUo3
 yoX8ebNrca6XIs8/Sqy6LedQRISXACdyIDQwUlT1K3VRIzraOtAobmFw+cQC2ssUexNT
 ltAkOqCzlxkz5BwVA9byJU3vI9qN2vk0PncP/VwXLOmGsi+5h/hH+7YjJftuSjKTlnmK
 +ZHejfa4QVx3wr3CKcMmcSf36nsQi/KMpxU0AyrORArEk99OCPaJMTDpC4xis4YtWFI0
 Y5XCFciK7qDmUz7CrMp7Ics6lcIVfVRy62vCYhrJn2mGK+VQLX8ROLvlGx1nV17pV2MR
 TTGA==
X-Gm-Message-State: APjAAAUB0nvtm3OyekO0ffwLgWEaV4v24QL5GpbA5PATIz3dhEseaqtr
 TQ/B+qhCoD32O1eNtzPnZ/juXyFLWxk=
X-Google-Smtp-Source: APXvYqyNZjO93ppqdwJElqZ1A7NvGR517UUtoIcTS1W9GhXxrQUO+y8OXKSpGUNFg4rjUXW9Q0TE3g==
X-Received: by 2002:aa7:9f9b:: with SMTP id z27mr1826642pfr.65.1571338272750; 
 Thu, 17 Oct 2019 11:51:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s97sm5009256pjc.4.2019.10.17.11.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 11:51:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 00/20] target/arm: Reduce overhead of cpu_get_tb_cpu_state
Date: Thu, 17 Oct 2019 11:50:50 -0700
Message-Id: <20191017185110.539-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::432
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

Changes since v6:
  * Regen hflags in two more places for m-profile (patch 19).

Changes since v5:
  * Fix the debug assertion ifdef in the final patch.
  * Add more calls to arm_rebuild_hflags: CPSR and M-profile
    These become two new patches, 18 & 19.
  * Update some comments per review. (Alex)

Changes since v4:
  * Split patch 1 into 15 smaller patches.
  * Cache the new DEBUG_TARGET_EL field.
  * Split out m-profile hflags separately from a-profile 32-bit.
  * Move around non-cached tb flags as well, avoiding repetitive
    checks for m-profile or other mutually exclusive conditions.

  I haven't officially re-run the performance test quoted in the
  last patch, but I have eyeballed "perf top", and have dug into
  the compiled code a bit, which resulted in a few of the new
  cleanup patches (e.g. cs_base, arm_mmu_idx_el, and
  arm_cpu_data_is_big_endian).
...


r~


Richard Henderson (20):
  target/arm: Split out rebuild_hflags_common
  target/arm: Split out rebuild_hflags_a64
  target/arm: Split out rebuild_hflags_common_32
  target/arm: Split arm_cpu_data_is_big_endian
  target/arm: Split out rebuild_hflags_m32
  target/arm: Reduce tests vs M-profile in cpu_get_tb_cpu_state
  target/arm: Split out rebuild_hflags_a32
  target/arm: Split out rebuild_hflags_aprofile
  target/arm: Hoist XSCALE_CPAR, VECLEN, VECSTRIDE in
    cpu_get_tb_cpu_state
  target/arm: Simplify set of PSTATE_SS in cpu_get_tb_cpu_state
  target/arm: Hoist computation of TBFLAG_A32.VFPEN
  target/arm: Add arm_rebuild_hflags
  target/arm: Split out arm_mmu_idx_el
  target/arm: Hoist store to cs_base in cpu_get_tb_cpu_state
  target/arm: Add HELPER(rebuild_hflags_{a32,a64,m32})
  target/arm: Rebuild hflags at EL changes
  target/arm: Rebuild hflags at MSR writes
  target/arm: Rebuild hflags at CPSR writes
  target/arm: Rebuild hflags for M-profile.
  target/arm: Rely on hflags correct in cpu_get_tb_cpu_state

 target/arm/cpu.h           |  84 +++++---
 target/arm/helper.h        |   4 +
 target/arm/internals.h     |   9 +
 hw/intc/armv7m_nvic.c      |   1 +
 linux-user/syscall.c       |   1 +
 target/arm/cpu.c           |   1 +
 target/arm/helper-a64.c    |   3 +
 target/arm/helper.c        | 383 ++++++++++++++++++++++++-------------
 target/arm/m_helper.c      |   6 +
 target/arm/machine.c       |   1 +
 target/arm/op_helper.c     |   4 +
 target/arm/translate-a64.c |  13 +-
 target/arm/translate.c     |  33 +++-
 13 files changed, 368 insertions(+), 175 deletions(-)

-- 
2.17.1


