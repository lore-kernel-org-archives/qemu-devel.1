Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9C5C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E518522DD6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+y+0uKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E518522DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0BRF-0005HQ-Ip
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 17:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLi-0000AM-2f
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLg-0008JV-PC
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:25 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0BLg-0008Iv-HN
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:24 -0400
Received: by mail-pf1-x443.google.com with SMTP id 196so4108744pfz.8
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oxUnGqeWvwLIZfcZQxjlh7NTLJypY4u3oeTZofI/YEE=;
 b=N+y+0uKch7/dYVasjX9hlWHOdpeGMPhFZCx4WnR6OXsSfc9P+HWXELC1AcdUuyr5C3
 a9hWxWIMEf9NuN6U9MLOYfyF1zQ2Rvh2hHm1JsRhWd0ivrPM0qESuxz2Knf8oLmr7mE2
 xXedyRe1dpG6Mb9n+dXCFMvWXqjWkQYj4k2ZuOZbCn1i3mVBuj2LNGQjbk16U56zMS1Y
 OlNFNLxHTxql3vM3Otlq2CosnbEPOWluls4Mq47iuZ/ueLrQPNshxhHPHvlXBHrrayxk
 0eRkHDJaPE3LNxsjWrdoa4R3CZn+fgZOn7lbmizuJHea6TzpD305S3fvS4l02SAt00PC
 Daqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oxUnGqeWvwLIZfcZQxjlh7NTLJypY4u3oeTZofI/YEE=;
 b=RYpaf51PjUsAOe8aZPVcmE/2V6l8RPjy8Zk6waHR2IHLomizgvigTQSf3Zd5pKnNjY
 D6MF14gK7Gv7Js/FLpGdHS6ymKY0BGn+EzSQFOQ+8pdaha8aa5/qkZAaWjQHXiRPYJga
 s3N1XjXCjq/IpXPIJdURhsUiOOW6rMHa0RCH+f0yWo2R2Uvu/kshiG2P1Re/XmLAQEiW
 oVIW08Myc1IA4uUBHwlTK5n3MtHm4wzKQiL/AD7Ojv0vsXjRLJuObQqyDyg8o5VoqEEq
 uvmISHaPcaTEkNFKf5dTOBjRN0cuPpaLuT4qY2AplLzFgC89num5CePofMnC9QhJSiNI
 bpWw==
X-Gm-Message-State: APjAAAWuN+maQscLLjdjh2VHUBODosHG46H8omGLxUyNARJaqPV+3Ao9
 jnpIElYJjcJp4251Wlq/VYQRZ57SvME=
X-Google-Smtp-Source: APXvYqxxBV6QVm7b8if+mYN/xGyKEdIVOghF+lHWhrEh6LpSJ4zmnYozY1QB5zL40m+BdY7JqTr0Xg==
X-Received: by 2002:a63:c70d:: with SMTP id n13mr26228089pgg.171.1566335242880; 
 Tue, 20 Aug 2019 14:07:22 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k22sm21690743pfk.157.2019.08.20.14.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 14:07:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:07:03 -0700
Message-Id: <20190820210720.18976-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v5 00/17] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
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

Changes since v3:
  * Rebase.
  * Do not cache XSCALE_CPAR now that it overlaps VECSTRIDE.
  * Leave the new v7m bits as uncached.  I haven't figured
    out all of the ways fpccr is modified.

Changes since v2:
  * Do not cache VECLEN, VECSTRIDE, VFPEN.
    These variables come from VFP_FPSCR and VFP_FPEXC, not from
    system control registers.
  * Move HANDLER and STACKCHECK to rebuild_hflags_a32,
    instead of building them in rebuild_hflags_common.

Changes since v1:
  * Apparently I had started a last-minute API change, and failed to
    covert all of the users, and also failed to re-test afterward.
  * Retain assertions for --enable-debug-tcg.

Richard Henderson (17):
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
  target/arm: Rebuild hflags at EL changes and MSR writes
  target/arm: Rely on hflags correct in cpu_get_tb_cpu_state

 target/arm/cpu.h           |  84 +++++---
 target/arm/helper.h        |   4 +
 target/arm/internals.h     |   9 +
 linux-user/syscall.c       |   1 +
 target/arm/cpu.c           |   1 +
 target/arm/helper-a64.c    |   3 +
 target/arm/helper.c        | 383 ++++++++++++++++++++++++-------------
 target/arm/machine.c       |   1 +
 target/arm/op_helper.c     |   1 +
 target/arm/translate-a64.c |   6 +-
 target/arm/translate.c     |  18 +-
 11 files changed, 341 insertions(+), 170 deletions(-)

-- 
2.17.1


