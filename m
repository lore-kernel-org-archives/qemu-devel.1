Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60529C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F251206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TtNY21Q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F251206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8am-0003X2-9O
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8ZO-0001bs-Mg
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:10 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:41022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8ZN-0006zH-FJ
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:10 -0400
Received: by mail-wr1-x432.google.com with SMTP id h17so2097856wrc.8
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0uTj5FuaxLRxQKaETn1roHV13235qFIM0CWbgde5Ozs=;
 b=TtNY21Q+ylAaOWfUa1TZddXisiFB0WizIrBJXguw4YhF2JIHV9hshkc5jIArKVgJG0
 3EZB8YsUdvOuClWq3XJt9720T5/vSw3Ka1HpDUKDp3ApbJqqQ2ZvUpGduo/qMqXp2rMe
 I9vofwaonazag0dVtUP2Ps95Ai7QQSMkrQjuVBEURCGrs6sK4SN0DJjmC9pgbVppArMx
 pUGVnv105Tr5E4KBz3KM24jK9BQb7Xv0EbGjNXYawReHTeqgu61R9YyvkdW+J7gkDYjB
 AmOXvYKD4CGRsnpKfZTvWtVMAT3DQuM3fJ96Oau1bfVAzJdFd5p5sreUG6EvrL/BD8bb
 E2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0uTj5FuaxLRxQKaETn1roHV13235qFIM0CWbgde5Ozs=;
 b=i4j9M2xf5sWSnpqLLvnKTrT7R9yj80/VaGZwltfMRHQN+i4dn3B2Dbbd2XekvjDxHF
 fE0cE684Jm7bvtHBVyaKOWo2/B4+/ZZFdCxNpiOlvoJuC1rpIF6Dj+GEYj5Sil53Do9s
 cevDQQqk3JUrB+hszq1Z70hs4StwuzNTf09wfFhXmR8i7+degL2WMb3ITpimxwYMgEWx
 omQJyDCSbzfesqDtprmAND3au44Fo870na536GTE7S935vZfR5W3PKxZDuW3I86OrG0Y
 C8m8X+wIPqLmn8nlFDwa7dwm04+u0OAX9WLf1uRg6qjus5Bp3A/G8e5f19uKEDysz95P
 P6Yw==
X-Gm-Message-State: AGi0PubjEfbsdlaZyd8jzNVJr7qfqlFQ6PwKzDkwq27adcxdHU7W7aEB
 N7HpWFyCBE2OXURQtzf59fmofgZXOlvBbQ==
X-Google-Smtp-Source: APiQypKCfug2xkVmnCcoDmBKjmiYY8H+RsWtBvlas4Di2+mmxvMMYCMAJu6ffinl4kAzI7dBGD966g==
X-Received: by 2002:adf:e752:: with SMTP id c18mr2231718wrn.353.1589204047301; 
 Mon, 11 May 2020 06:34:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/34] target-arm queue
Date: Mon, 11 May 2020 14:33:31 +0100
Message-Id: <20200511133405.5275-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit c88f1ffc19e38008a1c33ae039482a860aa7418c:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2020-05-08 14:29:18 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200511

for you to fetch changes up to 7e17d50ebd359ee5fa3d65d7fdc0fe0336d60694:

  target/arm: Fix tcg_gen_gvec_dup_imm vs DUP (indexed) (2020-05-11 14:22:54 +0100)

----------------------------------------------------------------
target-arm queue:
 aspeed: Add boot stub for smp booting
 target/arm: Drop access_el3_aa32ns_aa64any()
 aspeed: Support AST2600A1 silicon revision
 aspeed: sdmc: Implement AST2600 locking behaviour
 nrf51: Tracing cleanups
 target/arm: Improve handling of SVE loads and stores
 target/arm: Don't show TCG-only CPUs in KVM-only QEMU builds
 hw/arm/musicpal: Map the UART devices unconditionally
 target/arm: Fix tcg_gen_gvec_dup_imm vs DUP (indexed)
 target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA

----------------------------------------------------------------
Edgar E. Iglesias (1):
      target/arm: Drop access_el3_aa32ns_aa64any()

Joel Stanley (3):
      aspeed: Add boot stub for smp booting
      aspeed: Support AST2600A1 silicon revision
      aspeed: sdmc: Implement AST2600 locking behaviour

Philippe Mathieu-Daudé (8):
      hw/arm/nrf51: Add NRF51_PERIPHERAL_SIZE definition
      hw/timer/nrf51_timer: Display timer ID in trace events
      hw/timer/nrf51_timer: Add trace event of counter value update
      target/arm/kvm: Inline set_feature() calls
      target/arm/cpu: Use ARRAY_SIZE() to iterate over ARMCPUInfo[]
      target/arm/cpu: Restrict v8M IDAU interface to Aarch32 CPUs
      target/arm: Restrict TCG cpus to TCG accel
      hw/arm/musicpal: Map the UART devices unconditionally

Richard Henderson (21):
      exec: Add block comments for watchpoint routines
      exec: Fix cpu_watchpoint_address_matches address length
      accel/tcg: Add block comment for probe_access
      accel/tcg: Adjust probe_access call to page_check_range
      accel/tcg: Add probe_access_flags
      accel/tcg: Add endian-specific cpu_{ld, st}* operations
      target/arm: Use cpu_*_data_ra for sve_ldst_tlb_fn
      target/arm: Drop manual handling of set/clear_helper_retaddr
      target/arm: Add sve infrastructure for page lookup
      target/arm: Adjust interface of sve_ld1_host_fn
      target/arm: Use SVEContLdSt in sve_ld1_r
      target/arm: Handle watchpoints in sve_ld1_r
      target/arm: Use SVEContLdSt for multi-register contiguous loads
      target/arm: Update contiguous first-fault and no-fault loads
      target/arm: Use SVEContLdSt for contiguous stores
      target/arm: Reuse sve_probe_page for gather first-fault loads
      target/arm: Reuse sve_probe_page for scatter stores
      target/arm: Reuse sve_probe_page for gather loads
      target/arm: Remove sve_memopidx
      target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA
      target/arm: Fix tcg_gen_gvec_dup_imm vs DUP (indexed)

Thomas Huth (1):
      target/arm: Make set_feature() available for other files

 docs/devel/loads-stores.rst    |   39 +-
 include/exec/cpu-all.h         |   13 +-
 include/exec/cpu_ldst.h        |  283 +++--
 include/exec/exec-all.h        |   39 +
 include/hw/arm/nrf51.h         |    3 +-
 include/hw/core/cpu.h          |   23 +
 include/hw/i2c/microbit_i2c.h  |    2 +-
 include/hw/misc/aspeed_scu.h   |    1 +
 include/hw/timer/nrf51_timer.h |    1 +
 target/arm/cpu.h               |   10 +
 target/arm/helper-sve.h        |   45 +-
 target/arm/internals.h         |    5 -
 accel/tcg/cputlb.c             |  413 ++++---
 accel/tcg/user-exec.c          |  256 ++++-
 exec.c                         |    2 +-
 hw/arm/aspeed.c                |   73 +-
 hw/arm/aspeed_ast2600.c        |    6 +-
 hw/arm/musicpal.c              |   12 +-
 hw/arm/nrf51_soc.c             |    9 +-
 hw/i2c/microbit_i2c.c          |    2 +-
 hw/misc/aspeed_scu.c           |   11 +-
 hw/misc/aspeed_sdmc.c          |   55 +-
 hw/timer/nrf51_timer.c         |   14 +-
 target/arm/cpu.c               |  662 +----------
 target/arm/cpu64.c             |   18 +-
 target/arm/cpu_tcg.c           |  664 +++++++++++
 target/arm/helper.c            |   30 +-
 target/arm/kvm32.c             |   13 +-
 target/arm/kvm64.c             |   22 +-
 target/arm/sve_helper.c        | 2398 +++++++++++++++++++++-------------------
 target/arm/translate-sve.c     |   93 +-
 hw/timer/trace-events          |    5 +-
 target/arm/Makefile.objs       |    1 +
 33 files changed, 2975 insertions(+), 2248 deletions(-)
 create mode 100644 target/arm/cpu_tcg.c

