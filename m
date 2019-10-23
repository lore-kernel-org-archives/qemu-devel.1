Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85073CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B912084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNlh9OpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B912084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIcU-0000dF-Rf
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8v-0008Dk-RW
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8q-0001Db-M3
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:45 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:38830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8o-0000yd-Ju
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:38 -0400
Received: by mail-qt1-x843.google.com with SMTP id o25so19348572qtr.5
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=G2RHHCFtsP5auZ4wmaveYQuuH6u7l3/77Cc/6E9VhRU=;
 b=oNlh9OpJdglfNTjhTYgZNIGISi32kTmvH0YOBux5UM5605QPr0d0B0bAinIAoZqDsT
 vvk1WvcbqN3oqgrbadClOCpr8emdHK41QHVkTcDyscl6u224wbq/zWtViA6MCZkrE+jK
 XwehN3wEmhMKbG42dCxegyLjpLHkDeEh2kJgzKho+osgSpFOzVvK5PQyuB8AqRJrGgD8
 iA2SWYzLcP5R8ocqQZdgP4+i37Ks0HCgXWpNHc0qugJDDm5jz51eX5I6WW0q0H/ykv5d
 INSDxa5e3ke5H6MqPPgJZ1ge1cj8T6n64Qcn5g/ffMLve8P2ycUF0BaBBTeyA9Jw9hXt
 5KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=G2RHHCFtsP5auZ4wmaveYQuuH6u7l3/77Cc/6E9VhRU=;
 b=TiLMkpbeQaVYFOS5fgyvE1qpieIfWSaE02oqSXhgvUO4AriRyads5u4HJ5FpI5xWFo
 BJnSUbEZnTOCj02sbYMCM9Yrb9iC33D7jpz9Nm5Manc6RzfXRrrhqVhtcEWsG7t4o6q5
 TYnLSc9nLNZM/1kBQLJhHpr6ZsgZr2Ua0yxjQsEoEsApUA18kW0iEhbcfl7x2J5Vy2u7
 +Yj7SJOvn4FaHlPQxmz2ybp+yS/9pvVz9FFNPbDM0z/UhKPHKMZJbMcfTuXgedvRY4V/
 SE0+nK6WnO39w1+kQdYQW0rOUcMbF48gxDXFtaWFhbhV0MWOZ3Dl8Vlbph6zvZdCBbd4
 fwyQ==
X-Gm-Message-State: APjAAAURiejIRGu8bJpvI2r8Ee2HUgHJ99BQHTGkzFDQjbmgv/fufa9h
 mlj8NhfFgigdAA5yI7jcobn+FZjatmo=
X-Google-Smtp-Source: APXvYqyWjwMwjQ0j3AFrSZ396cSQ45oI5+IwgorOOumkuFlVUCU8zt5nd3/m+mbd12jP6O7rxmT5Uw==
X-Received: by 2002:ac8:7052:: with SMTP id y18mr9879850qtm.24.1571842861327; 
 Wed, 23 Oct 2019 08:01:01 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:00:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 00/24] target/arm: Reduce overhead of cpu_get_tb_cpu_state
Date: Wed, 23 Oct 2019 11:00:33 -0400
Message-Id: <20191023150057.25731-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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

Changes since v8:
  * Rebuild hflags in linux-user/*/cpu_loop.c, after changing to big-endian.
    This allows the armeb busybox ls to pass.  I don't have a test image for
    aarch64_eb, but the code looks the same.

Changes since v7:
  * Rebuild hflags for all successful nvic writes (Peter).
  * Rebuild hflags for Xscale sctlr writes (Peter).

Changes since v6:
  * Regen hflags in two more places for m-profile (patch 19).
...


r~


Richard Henderson (24):
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
  target/arm: Rebuild hflags at Xscale SCTLR writes
  target/arm: Rebuild hflags for M-profile
  target/arm: Rebuild hflags for M-profile NVIC
  linux-user/aarch64: Rebuild hflags for TARGET_WORDS_BIGENDIAN
  linux-user/arm: Rebuild hflags for TARGET_WORDS_BIGENDIAN
  target/arm: Rely on hflags correct in cpu_get_tb_cpu_state

 target/arm/cpu.h              |  84 +++++---
 target/arm/helper.h           |   4 +
 target/arm/internals.h        |   9 +
 hw/intc/armv7m_nvic.c         |  22 +-
 linux-user/aarch64/cpu_loop.c |   1 +
 linux-user/arm/cpu_loop.c     |   1 +
 linux-user/syscall.c          |   1 +
 target/arm/cpu.c              |   1 +
 target/arm/helper-a64.c       |   3 +
 target/arm/helper.c           | 393 ++++++++++++++++++++++------------
 target/arm/m_helper.c         |   6 +
 target/arm/machine.c          |   1 +
 target/arm/op_helper.c        |   4 +
 target/arm/translate-a64.c    |  13 +-
 target/arm/translate.c        |  33 ++-
 15 files changed, 392 insertions(+), 184 deletions(-)

-- 
2.17.1


