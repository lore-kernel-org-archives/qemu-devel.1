Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A53C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB14320773
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T39ySY3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB14320773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqC7-0007W5-TQ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3j-0001nG-Cv
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:31 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:34834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3h-0006Aa-12
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id g18so9900198wrm.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iuggorem9kG/dEp137reT753s8RZfimwKZKwNlrFDN8=;
 b=T39ySY3yOdG/WqFtaCHeFElJ5D7zdJT/GqAUAwCM2gFIUndSfFL15y9SM/AadAYFOU
 pNU+SxErshFa6Co49CRoPB90UmSnVSKYEo7i12uvIcy7KisqEmxsdHB9/tBZ68cGoQfI
 Vjlk9lqp72mJ5k/oKHI0Zj7DFtRaoTxqGEGMQT65k0vswAoCnKlFO3OdYh7wL7gxyndj
 MJpwSrx6e5aIGDMce5aMq0nWDoii+RnuoJSOAM6njEnrsINOxNTmOlOeu17nExYSUpj4
 1afE8T3pbSvqnyp3AFoDjDqRIQyBVBI3Tk6Yyyr9vrtstpuks4Bwoc0dNnHtzIyTwq5h
 Gbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iuggorem9kG/dEp137reT753s8RZfimwKZKwNlrFDN8=;
 b=NgVgSgHbX/1IST57MnB3anjdaBQfoVqQS2MlzOIGWoPfOGVnb9MD6s7NZ9KEh7VcJ8
 zt+Tz1oSu0gKZKQv6dZlq2QwObwXykBxkYoHCO5I7V7OaEkMSwEUlB/HfGrjnNxkNfhY
 k+9EsMYCgJV/jglmckf4f0qVjElCUJr7t7FJpb8dRDua82mqUpYra2E/n7LZ5SHxjm8s
 rAvm7khuMZRdvtUkIPRhxNh6saCNPONEc81jLL9zvMMsrHh9qoFMHijAT7MHtsmA8v8j
 Z20y7GmZOQzRDQSO+IbMPrq6Wuwoluu0wJmmFVfw1EHGgn2HqtjnS6oyRWNg+F880A8i
 1D6Q==
X-Gm-Message-State: AOAM533EWMmlVTVEPhn5sjQY58gjgEzzyXc+q5Aaj5zIViGpmPBYZQk/
 VyiKaxtsW+pCkD6EMgIRKx2kV+0OlxFUfQ==
X-Google-Smtp-Source: ABdhPJxUqRdRyHSUtbnsiME6kMFzvrOQz7uLBarPP/WYRlSUxEou+dltsQj9/wLYjjX+KtEW5MeRZg==
X-Received: by 2002:adf:f083:: with SMTP id n3mr4291611wro.297.1593184467089; 
 Fri, 26 Jun 2020 08:14:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/57] target-arm queue
Date: Fri, 26 Jun 2020 16:13:27 +0100
Message-Id: <20200626151424.30117-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Mostly this is RTH's memtag series, but there are also some cleanups
from Philippe.

thanks
-- PMM

The following changes since commit 10f7ffabf9c507fc02382b89912003b1c43c3231:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-macppc-20200626' into staging (2020-06-26 12:14:18 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200626

for you to fetch changes up to c7459633baa71d1781fde4a245d6ec9ce2f008cf:

  target/arm: Enable MTE (2020-06-26 14:32:24 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/aspeed: improve QOM usage
 * hw/misc/pca9552: trace GPIO change events
 * target/arm: Implement ARMv8.5-MemTag for system emulation

----------------------------------------------------------------
Philippe Mathieu-Daudé (12):
      hw/arm/aspeed: Remove extraneous MemoryRegion object owner
      hw/arm/aspeed: Rename AspeedBoardState as AspeedMachineState
      hw/arm/aspeed: QOM'ify AspeedMachineState
      hw/i2c/core: Add i2c_try_create_slave() and i2c_realize_and_unref()
      hw/misc/pca9552: Rename 'nr_leds' as 'pin_count'
      hw/misc/pca9552: Rename generic code as pca955x
      hw/misc/pca9552: Add generic PCA955xClass, parent of TYPE_PCA9552
      hw/misc/pca9552: Add a 'description' property for debugging purpose
      hw/misc/pca9552: Trace GPIO High/Low events
      hw/arm/aspeed: Describe each PCA9552 device
      hw/misc/pca9552: Trace GPIO change events
      hw/misc/pca9552: Model qdev output GPIOs

Richard Henderson (45):
      target/arm: Add isar tests for mte
      target/arm: Improve masking of SCR RES0 bits
      target/arm: Add support for MTE to SCTLR_ELx
      target/arm: Add support for MTE to HCR_EL2 and SCR_EL3
      target/arm: Rename DISAS_UPDATE to DISAS_UPDATE_EXIT
      target/arm: Add DISAS_UPDATE_NOCHAIN
      target/arm: Add MTE system registers
      target/arm: Add MTE bits to tb_flags
      target/arm: Implement the IRG instruction
      target/arm: Revise decoding for disas_add_sub_imm
      target/arm: Implement the ADDG, SUBG instructions
      target/arm: Implement the GMI instruction
      target/arm: Implement the SUBP instruction
      target/arm: Define arm_cpu_do_unaligned_access for user-only
      target/arm: Implement LDG, STG, ST2G instructions
      target/arm: Implement the STGP instruction
      target/arm: Restrict the values of DCZID.BS under TCG
      target/arm: Simplify DC_ZVA
      target/arm: Implement the LDGM, STGM, STZGM instructions
      target/arm: Implement the access tag cache flushes
      target/arm: Move regime_el to internals.h
      target/arm: Move regime_tcr to internals.h
      target/arm: Add gen_mte_check1
      target/arm: Add gen_mte_checkN
      target/arm: Implement helper_mte_check1
      target/arm: Implement helper_mte_checkN
      target/arm: Add helper_mte_check_zva
      target/arm: Use mte_checkN for sve unpredicated loads
      target/arm: Use mte_checkN for sve unpredicated stores
      target/arm: Use mte_check1 for sve LD1R
      target/arm: Tidy trans_LD1R_zpri
      target/arm: Add arm_tlb_bti_gp
      target/arm: Add mte helpers for sve scalar + int loads
      target/arm: Add mte helpers for sve scalar + int stores
      target/arm: Add mte helpers for sve scalar + int ff/nf loads
      target/arm: Handle TBI for sve scalar + int memory ops
      target/arm: Add mte helpers for sve scatter/gather memory ops
      target/arm: Complete TBI clearing for user-only for SVE
      target/arm: Implement data cache set allocation tags
      target/arm: Set PSTATE.TCO on exception entry
      target/arm: Always pass cacheattr to get_phys_addr
      target/arm: Cache the Tagged bit for a page in MemTxAttrs
      target/arm: Create tagged ram when MTE is enabled
      target/arm: Add allocation tag storage for system mode
      target/arm: Enable MTE

 include/hw/arm/aspeed.h        |   12 +-
 include/hw/i2c/i2c.h           |    2 +
 include/hw/misc/pca9552.h      |   16 +-
 target/arm/cpu.h               |   50 +-
 target/arm/helper-a64.h        |   16 +
 target/arm/helper-sve.h        |  488 ++++++++++++++
 target/arm/helper.h            |    2 +
 target/arm/internals.h         |  153 ++++-
 target/arm/translate-a64.h     |    5 +
 target/arm/translate.h         |   23 +-
 hw/arm/aspeed.c                |   46 +-
 hw/arm/virt.c                  |   55 +-
 hw/i2c/core.c                  |   18 +-
 hw/misc/pca9552.c              |  216 +++++--
 target/arm/cpu.c               |   81 ++-
 target/arm/cpu64.c             |    5 +
 target/arm/helper-a64.c        |   94 +--
 target/arm/helper.c            |  423 ++++++++++---
 target/arm/m_helper.c          |   11 +-
 target/arm/mte_helper.c        |  906 ++++++++++++++++++++++++++
 target/arm/op_helper.c         |   16 +
 target/arm/sve_helper.c        |  616 ++++++++++++++----
 target/arm/tlb_helper.c        |   13 +-
 target/arm/translate-a64.c     |  657 ++++++++++++++++---
 target/arm/translate-sve.c     | 1366 ++++++++++++++++++++++++++--------------
 target/arm/translate-vfp.inc.c |    4 +-
 target/arm/translate.c         |   16 +-
 hw/misc/trace-events           |    4 +
 target/arm/Makefile.objs       |    1 +
 29 files changed, 4391 insertions(+), 924 deletions(-)
 create mode 100644 target/arm/mte_helper.c

