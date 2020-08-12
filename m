Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF16C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 23:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F6320774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 23:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIzF8uSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F6320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k607r-0001Ze-BF
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 19:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1k6076-00015Z-6c
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 19:24:56 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:38813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1k6074-0002Ft-Jc
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 19:24:55 -0400
Received: by mail-pj1-x1034.google.com with SMTP id ep8so1881919pjb.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 16:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oqQ5EnYS/MEmuEB9l5aalQwXWp6W8TAUY6sW3Ldhsyk=;
 b=jIzF8uSBXrK+2fPTYliJefERes7c3xulZz1h5DfQRDnkf3UrSuR/Mj28BD3DziSLJr
 MlPTJBG2UWVmiky8kv+DtuczlDPikVgZ6xrq10NCGV6aLknBpbpvLcimd7mCgfpqB8WG
 IuW+VdvPE6D1zoOyBMwpV2hf70LDvRKJQxRuovVVgtwZMsiSSie4rQeuFeE8/fosKVe8
 kWywcg2suwaiMWEZ1CbImOcqNJzeIDK3xMvSVw/0nlGGFPWIWJ4iQyZToiWizJgjBfcU
 MbQj8s+euQHCrRPc3ekGSYb0dP7MM05Tki8d/jxuiAXpQSk7rqykc6hkcudl0g1Z9ZZ+
 ZE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oqQ5EnYS/MEmuEB9l5aalQwXWp6W8TAUY6sW3Ldhsyk=;
 b=WPqSgog9uEottJL36SYOi5mKeC39ixEeRH/3A+E6yo05Ctw7eRubHRvND1Ly+3nStc
 L+H6lFxubz8InZlGTW2n3/V8axnbf9Lc4coc6r/ZkOXr938r4NEADT0KSBOKhm8ZLneG
 zGBpjsWqv3nCCzEsarwbT/Epb8HXVAkIRtKjF94JqqPoo5EKYyJo36nc0HUZTVn3Tmvj
 g2gfdk/4i/vB6d2wFwDdjPGPm0tb0/QpSCAKYxRkE8unMCt3TQoHemr8rXst/pGI5C/Q
 u66UbgdxH7W63hhqAPsMT4lEBzEFCO0k1JBbmJZxywBMgLtgrSVvZ2i9lFGt4nHaUtv+
 x+zA==
X-Gm-Message-State: AOAM533bwFt0rsB1x/8egANswyxRaIX/0J5sQgS89q+9V7vy8VBS3B2H
 9RP5PccmfJ3TkcEyta7zGQ/JjylI
X-Google-Smtp-Source: ABdhPJwfnztWcRr42CktGu770jwXIv6x8spXZwcW4lUQ9sic8gsSsEunA5Z500Mu180K+9T6EkVAdg==
X-Received: by 2002:a17:90a:20e7:: with SMTP id
 f94mr2267482pjg.121.1597274691638; 
 Wed, 12 Aug 2020 16:24:51 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:401:26c0:5caa:fe49:9c90:e47c])
 by smtp.gmail.com with ESMTPSA id y12sm3261828pgi.75.2020.08.12.16.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 16:24:50 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/24] target/xtensa updates for 5.2
Date: Wed, 12 Aug 2020 16:24:39 -0700
Message-Id: <20200812232439.20153-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1034.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

please pull the following batch of updates for target/xtensa.

The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:

  Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)

are available in the Git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20200812-xtensa

for you to fetch changes up to f64fa1494d5f92d4e4f0cc6a0ef3c7e3cc12763d:

  target/xtensa: import DSP3400 core (2020-08-12 15:56:51 -0700)

----------------------------------------------------------------
target/xtensa updates for 5.2:

- add NMI support;
- add DFPU option implementation;
- update FPU tests to support both FPU2000 and DFPU;
- add example cores with FPU2000 and DFPU.

----------------------------------------------------------------
Max Filippov (24):
      target/xtensa: make opcode properties more dynamic
      target/xtensa: implement NMI support
      softfloat: make NO_SIGNALING_NANS runtime property
      softfloat: pass float_status pointer to pickNaN
      softfloat: add xtensa specialization for pickNaNMulAdd
      target/xtensa: add geometry to xtensa_get_regfile_by_name
      target/xtensa: support copying registers up to 64 bits wide
      target/xtensa: rename FPU2000 translators and helpers
      target/xtensa: move FSR/FCR register accessors
      target/xtensa: don't access BR regfile directly
      target/xtensa: add DFPU option
      target/xtensa: add DFPU registers and opcodes
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

 fpu/softfloat-specialize.inc.c                    |    286 +-
 fpu/softfloat.c                                   |      2 +-
 hw/xtensa/pic_cpu.c                               |      6 +-
 include/fpu/softfloat-helpers.h                   |     10 +
 include/fpu/softfloat-types.h                     |      8 +-
 target/xtensa/Makefile.objs                       |      2 +
 target/xtensa/core-de233_fpu.c                    |     58 +
 target/xtensa/core-de233_fpu/core-isa.h           |    727 +
 target/xtensa/core-de233_fpu/core-matmap.h        |    717 +
 target/xtensa/core-de233_fpu/gdb-config.inc.c     |    277 +
 target/xtensa/core-de233_fpu/xtensa-modules.inc.c |  20758 +++
 target/xtensa/core-dsp3400.c                      |     58 +
 target/xtensa/core-dsp3400/core-isa.h             |    452 +
 target/xtensa/core-dsp3400/core-matmap.h          |    312 +
 target/xtensa/core-dsp3400/gdb-config.inc.c       |    400 +
 target/xtensa/core-dsp3400/xtensa-modules.inc.c   | 171906 +++++++++++++++++++
 target/xtensa/cpu.c                               |      5 +
 target/xtensa/cpu.h                               |     14 +-
 target/xtensa/exc_helper.c                        |     23 +-
 target/xtensa/fpu_helper.c                        |    342 +-
 target/xtensa/helper.c                            |      4 +-
 target/xtensa/helper.h                            |     58 +-
 target/xtensa/overlay_tool.h                      |     30 +-
 target/xtensa/translate.c                         |   1979 +-
 tests/tcg/xtensa/fpu.h                            |    142 +
 tests/tcg/xtensa/macros.inc                       |     10 +-
 tests/tcg/xtensa/test_dfp0_arith.S                |    162 +
 tests/tcg/xtensa/test_fp0_arith.S                 |    282 +-
 tests/tcg/xtensa/test_fp0_conv.S                  |    299 +-
 tests/tcg/xtensa/test_fp0_div.S                   |     82 +
 tests/tcg/xtensa/test_fp0_sqrt.S                  |     76 +
 tests/tcg/xtensa/test_fp1.S                       |     62 +-
 tests/tcg/xtensa/test_lsc.S                       |    170 +-
 33 files changed, 198888 insertions(+), 831 deletions(-)
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
Thanks.
-- Max

