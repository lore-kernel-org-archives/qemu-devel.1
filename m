Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F410C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575D2206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXp5LteJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575D2206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIiy-0005Sv-Ih
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIRv-0002Nu-Ns
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:21:55 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:35773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIRu-00014k-37
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:21:55 -0400
Received: by mail-pf1-x433.google.com with SMTP id a14so102311pfi.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 15:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AoJvDAGT430G1BTP39FXCnWjeJM+zidJp/hRJrqeMXI=;
 b=FXp5LteJZtF9vT967ojQnq3Gv8/f5lwTgc8+kLwDOpMNIELzjCLakVWxpEG6NjJzjQ
 /vkuxorQD6is4PDxPFfme5II6jxL7AB3sWWA+xgzRvrssw/7CnzZAJ4YOZLw488Ix5to
 +0yUh6uTC0EPWiXj4IS2+hsni9zU69+Ng0wNPmbFYCXRyTsSJUV6SOOzgTWxX6cm+FKh
 +whGn6BM4DUbMp/sqIRL9NgkDr4olY4SOFHHqISGrJbe7VOivwx7CtjzXP7AZJfdLVgJ
 tC3/DeTOMAXBU8l1iR9vQVekWrkMwi6EGkDS49Ql7rzyBmob/Rr3WiMDsXZ3eIjR6yUV
 /KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AoJvDAGT430G1BTP39FXCnWjeJM+zidJp/hRJrqeMXI=;
 b=i769YucXNF2dAe7pK0E6JgcmWQjlB5piOvhyma/puIBujFzwYuWepDYJ6a4JCCER/7
 2iEZcjqdAMNspqNLsAw+0UBxRITRW6l/nUiuCVOdfy1eCRhfnYSHRbiuFV+oxk5tApVb
 zZDUaOmWWhDnZi/ZivIUpUayjT5lZMI52l0+SFCfbo1+eqXsO1FuylRsfZQpVI/KAdAK
 a9mcbQxkNDgMKvO+NOjeAnAcWNh4KJ1QwiFmrXeOjOG8fTAHABi9xZaADgsaKu4MMHf1
 +BExw1f+Tmyv5C9FXb2N8HZ8J4X18mwr0stiS5O3sFa3myV00WNuBUsC0UGcVOOK2L94
 xYOQ==
X-Gm-Message-State: AOAM530vz6XsTvHy14GL7musjkPe0aLoV7gkLJCqYmA9hsZJpm+3ITW+
 4TtpE9UfoZD1dL5EQI+sIul9jIiz
X-Google-Smtp-Source: ABdhPJzhoLbUCo9Yq3/a9wpcJfij8dK0v1rQBxOwxpqh4aYKq8gpffgXemTobnNkVsOWpv6qHsyPHQ==
X-Received: by 2002:a63:7a56:: with SMTP id j22mr51495943pgn.293.1594246912295; 
 Wed, 08 Jul 2020 15:21:52 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id t73sm693517pfc.78.2020.07.08.15.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 15:21:51 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/21] target/xtensa: implement double precision FPU
Date: Wed,  8 Jul 2020 15:20:40 -0700
Message-Id: <20200708222101.24568-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pf1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

this series implements double precision floating point unit option for
target/xtensa, updates FPU tests and adds two new CPU cores, one with
FPU2000 option and one with DFPU option.

It is tagged xtensa-5.1-dfp-v3 in the qemu-xtensa tree at
git://github.com/OSLL/qemu-xtensa.git

Changes v2->v3:
- handle infzero case in pickNaNMulAdd properly and reword commit
  message
- add more infzero tests for FPU2000 and DFPU
- fix test names in test_dfp0_arith.S
- add licenses to newly imported cores
- rename DE_233L_FPU to de233_fpu to be more consistent with other
  core names

Changes v1->v2:
- use inline function for no_signaling_nans property to allow for
  constant folding on architectures that have this property fixed.

Max Filippov (21):
  softfloat: make NO_SIGNALING_NANS runtime property
  softfloat: pass float_status pointer to pickNaN
  softfloat: add xtensa specialization for pickNaNMulAdd
  target/xtensa: add geometry to xtensa_get_regfile_by_name
  target/xtensa: support copying registers up to 64 bits wide
  target/xtensa: rename FPU2000 translators and helpers
  target/xtensa: move FSR/FCR register accessors
  target/xtensa: don't access BR regfile directly
  target/xtensa: add DFP option, registers and opcodes
  target/xtensa: implement FPU division and square root
  tests/tcg/xtensa: fix test execution on ISS
  tests/tcg/xtensa: update test_fp0_arith for DFPU
  tests/tcg/xtensa: expand madd tests
  tests/tcg/xtensa: update test_fp0_conv for DFPU
  tests/tcg/xtensa: update test_fp1 for DFPU
  tests/tcg/xtensa: update test_lsc for DFPU
  tests/tcg/xtensa: add fp0 div and sqrt tests
  tests/tcg/xtensa: test double precision load/store
  tests/tcg/xtensa: add DFP0 arithmetic tests
  target/xtensa: import de233_fpu core
  target/xtensa: import DSP3400 core

 fpu/softfloat-specialize.inc.c                |    285 +-
 fpu/softfloat.c                               |      2 +-
 include/fpu/softfloat-helpers.h               |     10 +
 include/fpu/softfloat-types.h                 |      8 +-
 target/xtensa/Makefile.objs                   |      2 +
 target/xtensa/core-de233_fpu.c                |     58 +
 target/xtensa/core-de233_fpu/core-isa.h       |    727 +
 target/xtensa/core-de233_fpu/core-matmap.h    |    717 +
 target/xtensa/core-de233_fpu/gdb-config.inc.c |    277 +
 .../core-de233_fpu/xtensa-modules.inc.c       |  20758 ++
 target/xtensa/core-dsp3400.c                  |     58 +
 target/xtensa/core-dsp3400/core-isa.h         |    452 +
 target/xtensa/core-dsp3400/core-matmap.h      |    312 +
 target/xtensa/core-dsp3400/gdb-config.inc.c   |    400 +
 .../xtensa/core-dsp3400/xtensa-modules.inc.c  | 171906 +++++++++++++++
 target/xtensa/cpu.c                           |      4 +
 target/xtensa/cpu.h                           |      7 +-
 target/xtensa/fpu_helper.c                    |    314 +-
 target/xtensa/helper.c                        |      4 +-
 target/xtensa/helper.h                        |     53 +-
 target/xtensa/overlay_tool.h                  |      6 +
 target/xtensa/translate.c                     |   1345 +-
 tests/tcg/xtensa/fpu.h                        |    142 +
 tests/tcg/xtensa/macros.inc                   |     10 +-
 tests/tcg/xtensa/test_dfp0_arith.S            |    162 +
 tests/tcg/xtensa/test_fp0_arith.S             |    282 +-
 tests/tcg/xtensa/test_fp0_conv.S              |    299 +-
 tests/tcg/xtensa/test_fp0_div.S               |     82 +
 tests/tcg/xtensa/test_fp0_sqrt.S              |     76 +
 tests/tcg/xtensa/test_fp1.S                   |     62 +-
 tests/tcg/xtensa/test_lsc.S                   |    170 +-
 31 files changed, 198452 insertions(+), 538 deletions(-)
 create mode 100644 target/xtensa/core-de233_fpu.c
 create mode 100644 target/xtensa/core-de233_fpu/core-isa.h
 create mode 100644 target/xtensa/core-de233_fpu/core-matmap.h
 create mode 100644 target/xtensa/core-de233_fpu/gdb-config.inc.c
 create mode 100644 target/xtensa/core-de233_fpu/xtensa-modules.inc.c
 create mode 100644 target/xtensa/core-dsp3400.c
 create mode 100644 target/xtensa/core-dsp3400/core-isa.h
 create mode 100644 target/xtensa/core-dsp3400/core-matmap.h
 create mode 100644 target/xtensa/core-dsp3400/gdb-config.inc.c
 create mode 100644 target/xtensa/core-dsp3400/xtensa-modules.inc.c
 create mode 100644 tests/tcg/xtensa/fpu.h
 create mode 100644 tests/tcg/xtensa/test_dfp0_arith.S
 create mode 100644 tests/tcg/xtensa/test_fp0_div.S
 create mode 100644 tests/tcg/xtensa/test_fp0_sqrt.S

-- 
2.20.1


