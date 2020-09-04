Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB278C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55C620684
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QgoPv2CD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55C620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEH5g-0002tH-Sl
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH4r-0001FO-FB
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:08:49 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:33923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH4p-0000m2-Ia
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:08:48 -0400
Received: by mail-pg1-x530.google.com with SMTP id u13so4819006pgh.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y6vDqRca89eTJo8pj5PO+nmZzPLDTJ/4KThJK5k5oLg=;
 b=QgoPv2CDYj6J9MRxCEdUfBLbuX+fkDcDbfBx+o3G2LAnhqsq7UlNyFOLSOH//eTeMN
 nfebDd5xvRGZprTGm/M7xolGZ4BfbTPyQrbD459s4SI9MVzxtrZ0KyWWtzU3O6XtUPfC
 b7gPMCVOpAydaouqMi8xJPqjpyquUM0xkSOnoajrbNqpgizI/89b20hyGcgPjkBW/LwM
 YI1HqZs2cuUHlzuuPtFNcjvOjxy3Cv2dzzfq33pio8P5ZGox+Fb/uUoS3mPTPSekXkRf
 cC0dEzN2VmQGyWg8nqmylmHYJOzYEOPkAiwhQWXPFBrqIwX+14Zha8fK8e4Mzviymk9B
 Gaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y6vDqRca89eTJo8pj5PO+nmZzPLDTJ/4KThJK5k5oLg=;
 b=lq9uzWVhiUebuSKfZCO7KDGISdR1A4zR0mL4niBqHjzIE25v1NXMnOIRFPeaf//QoL
 Ql++jxFVo4b9WDpQFjYdicBecPSgiKwLDJOoZ5g72gHzosNi7FulMzUYC+wlxLP+dVpQ
 rySiTVAZ8KCW3c1r+HHs6dP3761s6YS+wyNv+ShOxQAWyBCpzcikVHqN3y1hbow3FjzS
 uJwwIvQHBIUFWuZPIhQ/0FHrx4kI2hF8vy+lQRgtWyg58HHk2t7KbXTnjz9+uKOm0nrg
 JL4YCy5r0rwPL8LfqfNTukKVdUNkfy0nAQXpuZX2E5IZ9hHj/gOzx4hCxMKWR86kjMEe
 IRhw==
X-Gm-Message-State: AOAM532wT98I9+cLECWiHubU+RWmjDK0RjFuf4sxEI/kuX2Y9Wji+mV7
 PMOK7CjwRLSSq0t28h+xCswBtePgBSaKgA==
X-Google-Smtp-Source: ABdhPJy9vsZN06xgqYlcODFtrbSgPpZyBJIN/uvyRdxPw/uxujOKtsSrs6bO6w7YD4SzGDa4+zONew==
X-Received: by 2002:a63:fa01:: with SMTP id y1mr8201740pgh.284.1599246524856; 
 Fri, 04 Sep 2020 12:08:44 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x19sm1897941pge.22.2020.09.04.12.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 12:08:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/19] target/microblaze improvements
Date: Fri,  4 Sep 2020 12:08:23 -0700
Message-Id: <20200904190842.2282109-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
Cc: edgar.iglesias@xilinx.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 3:

 * Splits out MicroBlazeCPUConfig, and moves some values
   out of CPUMBState (env) that are constant configuration
   parameters, or derived from configuration parameters.

 * Do not save configuration parameters with vmstate.
 * Pass around MicroBlazeCPUConfig in the translator.
 * Do not set TARGET_ABI32 in configure.

Version 2:

 * Includes fixes for iflags that could cause lockups.

   It seems it was easier to do so with icount=7, which is what we
   do during the replay acceptance tests.  This causes TBs to contain
   no more than 7 insns, and often less to make up for an incomplete
   count elsewhere.  Which stressed the iflags bits around delay slots
   and imm in ways that pure single-step doesn't.

  * cpu vmstate is filled in
  * interrupt logging is tidied.


r~


Richard Henderson (19):
  target/microblaze: Collected fixes for env->iflags
  target/microblaze: Renumber D_FLAG
  target/microblaze: Cleanup mb_cpu_do_interrupt
  target/microblaze: Rename mmu structs
  target/microblaze: Rename DISAS_UPDATE to DISAS_EXIT
  target/microblaze: Introduce DISAS_EXIT_NEXT, DISAS_EXIT_JUMP
  target/microblaze: Replace cpustate_changed with DISAS_EXIT_NEXT
  target/microblaze: Handle DISAS_EXIT_NEXT in delay slot
  target/microblaze: Force rtid, rted, rtbd to exit
  target/microblaze: Use tcg_gen_lookup_and_goto_ptr
  target/microblaze: Diagnose invalid insns in delay slots
  target/microblaze: Split out MicroBlazeCPUConfig
  target/microblaze: Reorg MicroBlazeCPUConfig to minimize holes
  target/microblaze: Move pvr regs to MicroBlazeCPUConfig
  target/microblaze: Treat pvr_regs as constant
  target/microblaze: Move mmu parameters to MicroBlazeCPUConfig
  target/microblaze: Fill in VMStateDescription for cpu
  target/microblaze: Put MicroBlazeCPUConfig into DisasContext
  configure: Do not set TARGET_ABI32 for microblaze

 configure                           |   1 -
 target/microblaze/cpu.h             |  81 +++++-----
 target/microblaze/mmu.h             |  20 +--
 hw/microblaze/petalogix_ml605_mmu.c |   6 +-
 target/microblaze/cpu.c             | 120 +++++++--------
 target/microblaze/gdbstub.c         |   6 +-
 target/microblaze/helper.c          | 220 +++++++++++++---------------
 target/microblaze/machine.c         | 106 ++++++++++++++
 target/microblaze/mmu.c             |  39 ++---
 target/microblaze/op_helper.c       |   2 +-
 target/microblaze/translate.c       | 198 ++++++++++++++++---------
 target/microblaze/meson.build       |   5 +-
 12 files changed, 482 insertions(+), 322 deletions(-)
 create mode 100644 target/microblaze/machine.c

-- 
2.25.1


