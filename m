Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C47C5B57A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A22721773
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVPl/7R7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A22721773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhD3L-0001Te-Mq
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 09:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41197)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCy9-0007z3-Ps
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCy8-0003bD-1w
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:41 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:37206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhCy7-0003IW-Jw
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:39 -0400
Received: by mail-wr1-x42c.google.com with SMTP id v14so8991990wrr.4
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 06:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=DpqvQ2OD5EZg6yJYHfttzhbhe9ojKS0NMxvJyAquVwQ=;
 b=eVPl/7R79cY3LDPJWXJkX2wuCiJk+CY+WShpCusLdzzbqpW5KsLFbfqs7O/t/18eB1
 7lWBNC3x4gIr+GP2brz9D9ZT5stHykAyNCRiQHOb3flGpbA4ePArhtTHG2Tuw2hpEB+Y
 It8yDY5q+xjG8Ru5K1Wl7Z5BJb9SlMvdThFqyolfaS1szceOBk/QMe05e09nSlyPgZLr
 t6RqtyeSc4HYm5OHhsTV+jnGwNSDQOvynrX5TclS5QVx0XBxrZcM9Kcw34walBXtwdVt
 3tbax7hlaVX/EbjNo8iwE4haMyp17Ljiud9Wcvu+TQdt7sfdaFkdxh41pgGO6L1xh9ru
 Y+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=DpqvQ2OD5EZg6yJYHfttzhbhe9ojKS0NMxvJyAquVwQ=;
 b=TskMCormVTxMhDk+pEVlCpcORdxS5J53WjUJx5qJpaltdEmDnHMXay/rE9hJ2kTtNB
 PyKOZzrGk0Y5d06hjmFCVp0I7zUm1WB5edakPnigi3o/n6IYAaloBaI6KMkOKGAwVnoZ
 aoQA2WD9m8ZGdK798VBfOqOU4XNvdahx5ONBUG8PYxttkcRQYWW7ejJvGmgXP2vXZl6r
 Sl0DQ5t9rCEQqGOVg0Uv3uw29zu0iMK/Orvfy7hE2DRmx7kO1OCprHuhYgBEfa+AaRPx
 Umjs8vTpQNXw6zF3hEXFdiHQfRoI6Urio3twRbY4epgQMJ5iMNxWi8lZtKTR2WcTFHE5
 vS9A==
X-Gm-Message-State: APjAAAXoY5o5ly4EPl8F/wK7cFH451v47LLw1FYP6pCkI0VM/2uahjuz
 yBmthIlqnnt7tanSKEowU14ak8Sx5mFE8A==
X-Google-Smtp-Source: APXvYqwfK4BnKQsA0NzESJmzm+h10b0kSgEfk6KJF3S+9z+4kCVQ+gzHmuKZQUvD6j03CJ/nVt6new==
X-Received: by 2002:a5d:4acf:: with SMTP id y15mr5704791wrs.208.1561813219402; 
 Sat, 29 Jun 2019 06:00:19 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id d10sm4937676wro.18.2019.06.29.06.00.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 06:00:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 15:00:01 +0200
Message-Id: <20190629130017.2973-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PATCH v6 00/16] tcg/ppc: Add vector opcodes
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

Richard Henderson (16):
  tcg/ppc: Introduce Altivec registers
  tcg/ppc: Introduce macro VX4()
  tcg/ppc: Introduce macros VRT(), VRA(), VRB(), VRC()
  tcg/ppc: Enable tcg backend vector compilation
  tcg/ppc: Add support for load/store/logic/comparison
  tcg/ppc: Add support for vector maximum/minimum
  tcg/ppc: Add support for vector add/subtract
  tcg/ppc: Add support for vector saturated add/subtract
  tcg/ppc: Prepare case for vector multiply
  tcg/ppc: Support vector shift by immediate
  tcg/ppc: Support vector multiply
  tcg/ppc: Support vector dup2
  tcg/ppc: Enable Altivec detection
  tcg/ppc: Update vector support to v2.06
  tcg/ppc: Update vector support to v2.07
  tcg/ppc: Update vector support to v3.00

 tcg/ppc/tcg-target.h     |   39 +-
 tcg/ppc/tcg-target.opc.h |   13 +
 tcg/ppc/tcg-target.inc.c | 1091 +++++++++++++++++++++++++++++++++++---
 3 files changed, 1076 insertions(+), 67 deletions(-)
 create mode 100644 tcg/ppc/tcg-target.opc.h

-- 
2.17.1


