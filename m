Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BCBC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054EE22501
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/zd6aB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054EE22501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2Cy-0006Ix-SS
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Ak-0004Sa-QT
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Aj-0005Ub-7Y
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:30 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:33374)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2Ai-0005TE-Vh
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:29 -0400
Received: by mail-pg1-x534.google.com with SMTP id i30so8016044pgl.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=KA/ntiu5DteRGHxl+0gGheZ7X7XKaiTNWju4vYkTfiI=;
 b=b/zd6aB8YKELLtc1O1hYsnMEyAYw0pWvMiAeCxUGbjRRrz2lnQ/yOGmv1xhMU3uPzv
 Yv20FKDzzAX7QKP3uyypFWkDXeRAZXIKuQlVC8gY/gSRrN3UvtGPpfI/qI0cl1vMtbNm
 LZBswH15mEDYep2212ZPf5lGGwzx5Ql+fWHkAuPUqDVIM+klHxbCrXhIde/HgCV6gmFb
 y+rIuz/i3WkoREtkb5dRXo7jCm1UrLxnJ35OHSQAlt7Wc7421+QNRwQ+F4N88yGKdKeq
 hWAJcf4W0L+GeExuodhX+wS4daxAjpchTr/QoMuHK0eZr+LcyjJNgchUxhJ3T3F/B18h
 btxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=KA/ntiu5DteRGHxl+0gGheZ7X7XKaiTNWju4vYkTfiI=;
 b=Akaci5jJXJAAuNBF2CD4H7sh1dc93efVbDmqasf7yWCWcre+PT32gF3F5J5y8OmFfr
 pyOb9RFUifVUaYNxThNOJKn504LD/BYIJaDKeqQRyohbij9nKlQJ17hnjhfR4QxEqdMt
 Q9id4m5NpTD/x3R4P5HtBRFA8M0DEO6oqcRLF08sH99ZT2t23W2uLWM0+xDbQVb8Y+Vg
 mvn3dtY01nzFeYxroMbX1YUKpI58a6PbYB35Sf4C6LxrvytEvw5cvg+eQ/AV3cz5wt6Z
 JOvTmDvjlThHmFDNlZwxnPrXc26H0sEg3h/amKVMlIpGtgHxyyM92DBI4tETn1jWRUZy
 TvPQ==
X-Gm-Message-State: APjAAAXQwyawZdtioARKDef+7AQQ1uDpmPO9VQ61Fqp6b6ubxkwo9M2k
 ZKIzNlwzKLK6+xexqlk1LzgYPICEnVQ=
X-Google-Smtp-Source: APXvYqymp9PJiTdHCrULowOPgoaE1OQZFzoOOINkiHzny9BfeBRTMEyHdXEASeyd0YT82nl4QJVYNQ==
X-Received: by 2002:a63:1e1e:: with SMTP id e30mr7932761pge.405.1569874886993; 
 Mon, 30 Sep 2019 13:21:26 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 00/22] tcg/ppc: Add vector opcodes
Date: Mon, 30 Sep 2019 13:21:03 -0700
Message-Id: <20190930202125.21064-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::534
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes since v6:
  * The have_foo tests have been split so that VSX is not
    combined with ISA revision.
  * The power{7,8,9} patches have been split by isa extension.
  * Force the [TABC]X bits on within the VSX instruction defines,
    making the usage of the VSX insns clearer, since we have no
    additional or'ing of seemingly random bits.

Changes since v5:
  * Disable runtime altivec detection until all of the required
    opcodes are implemented.
    Because dup2 was last, that really means all of the pure altivec
    bits, so the initial patches are not bisectable in any meaningful
    sense.  I thought about reshuffling dup2 earlier, but that created
    too many conflicts and I was too lazy.
  * Rearranged the patches a little bit to make sure that each
    one actually builds, which was not the case before.
  * Folded in the fix to tcg_out_mem_long, as discussed in the
    followup within the v4 thread.

Changes since v4:
  * Patch 1, "tcg/ppc: Introduce Altivec registers", is divided into
    ten smaller patches.
  * The net result (code-wise) is not changed between former patch 1
    and ten new patches.
  * Remaining (2-7) patches from v4 are applied verbatim.
  * This means that code-wise v5 and v4 do not differ.
  * v5 is devised to help debugging, and to better organize the code.

Changes since v3:
  * Add support for bitsel, with the vsx xxsel insn.
  * Rely on the new relocation overflow handling, so
    we don't require 3 insns for a vector load.

Changes since v2:
  * Several generic tcg patches to improve dup vs dupi vs dupm.
    In particular, if a global temp (like guest r10) is not in
    a host register, we should duplicate from memory instead of
    loading to an integer register, spilling to stack, loading
    to a vector register, and then duplicating.
  * I have more confidence that 32-bit ppc host should work
    this time around.  No testing on that front yet, but I've
    unified some code sequences with 64-bit ppc host.
  * Base altivec now supports V128 only.  Moved V64 support to
    Power7 (v2.06), which has 64-bit load/store.
  * Dropped support for 64-bit vector multiply using Power8.
    The expansion was too large compared to using integer regs.

Richard Henderson (22):
  tcg/ppc: Introduce Altivec registers
  tcg/ppc: Introduce macro VX4()
  tcg/ppc: Introduce macros VRT(), VRA(), VRB(), VRC()
  tcg/ppc: Create TCGPowerISA and have_isa
  tcg/ppc: Replace HAVE_ISA_2_06
  tcg/ppc: Replace HAVE_ISEL macro with a variable
  tcg/ppc: Enable tcg backend vector compilation
  tcg/ppc: Add support for load/store/logic/comparison
  tcg/ppc: Add support for vector maximum/minimum
  tcg/ppc: Add support for vector add/subtract
  tcg/ppc: Add support for vector saturated add/subtract
  tcg/ppc: Support vector shift by immediate
  tcg/ppc: Support vector multiply
  tcg/ppc: Support vector dup2
  tcg/ppc: Enable Altivec detection
  tcg/ppc: Update vector support for VSX
  tcg/ppc: Update vector support for v2.07 Altivec
  tcg/ppc: Update vector support for v2.07 VSX
  tcg/ppc: Update vector support for v2.07 FP
  tcg/ppc: Update vector support for v3.00 Altivec
  tcg/ppc: Update vector support for v3.00 load/store
  tcg/ppc: Update vector support for v3.00 dup/dupi

 tcg/ppc/tcg-target.h     |   51 +-
 tcg/ppc/tcg-target.opc.h |   13 +
 tcg/ppc/tcg-target.inc.c | 1118 +++++++++++++++++++++++++++++++++++---
 3 files changed, 1101 insertions(+), 81 deletions(-)
 create mode 100644 tcg/ppc/tcg-target.opc.h

-- 
2.17.1


