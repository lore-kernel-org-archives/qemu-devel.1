Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98535C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6203B206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMxajWwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6203B206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsaqx-0002OE-LP
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 19:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaq2-0000o0-Kd
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:47:54 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:43366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaq1-0000o8-4Q
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:47:54 -0400
Received: by mail-pg1-x52f.google.com with SMTP id w2so18317459pgg.10
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 16:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ihCfB9QGaifWa0gtrPGA0S6HmFHk3Z0IoU1M1kPTR44=;
 b=KMxajWwgKLKyFQEDF+Zr0dFuJpFt9TsTYODiqqkmBlNzgRcX5L/rC4dH2a5HPJc1T3
 ZTQ0mpk+N9HOTURcd+Trr9k7iICulngHIBlM00EdAdVIVNdWzH10F+tPCl59kiQQcFfR
 vGQHJOCggEZj5/ZXvuJkjGqSQYEJgbOfmOeml5ImPutZnKsD+HqNAed/8cmurhqR266u
 fJ97EM3c8OQ2HYJ+sIJol0XM/XazEPMRIdqPx7G7/8ntaccDg3mDf4kCxbZaWYj+eCQz
 cEAh12I90sIKfwfh5l3WRkYrBxqYdi+0HcLuUgo7/yVFfZ1Mz49tsE8IqPIp7L+FLzdi
 Lmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ihCfB9QGaifWa0gtrPGA0S6HmFHk3Z0IoU1M1kPTR44=;
 b=ZQSYvyna4IgpTHMKV3fIU8E5mYrSBggCknnhOmSPo1P3mF89DuiDBrBAtha5W5SPGb
 WmCJ/QGKPBkryNjt7CMLkiXow0WD5WhRJN+t2WIMYrqstmGGJnJBvsWNmwU8HOAaXZvZ
 JHsyIDLwjDHDYSMpQtn5jO1MinvRviHuqxdVUUgnVZ96glc6M8sTiJOAKpnN+YgMR2Dy
 HUE9AsH5uL1VxhFMUvG7jz81JsirS4gUmkYtc6hX3+0+U3+WfnoG+Wyjz6iM+2DyfiCK
 uma3qO1jki9w+Cax5GZxtsLiRuFF/FsZcgiX4LXVmvv4JRWcrHvJXIErOpoAnLuyPd/n
 VRrA==
X-Gm-Message-State: AOAM533UsSI9Aay9LyD8RmhZ4kQwKtEVCD8Z/IM4oRDUZQGPfcOYF40F
 3xJD+jf6jsRgYH/ofIRMtVt3gbDG
X-Google-Smtp-Source: ABdhPJz0cGwBBlBYb8eLlk2bT2BPfyAf/6u8FllAZkyNRBc4Gk3Bi1Jjp00Etyc6QiHS0l4OChGOAA==
X-Received: by 2002:a63:5b55:: with SMTP id l21mr35513497pgm.348.1594079271132; 
 Mon, 06 Jul 2020 16:47:51 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id e15sm19647649pgt.17.2020.07.06.16.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 16:47:50 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/21] target/xtensa: implement double precision FPU
Date: Mon,  6 Jul 2020 16:47:16 -0700
Message-Id: <20200706234737.32378-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x52f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

this series implements double precision floating point unit option for
target/xtensa, updates FPU tests and adds two new CPU cores, one with
FPU2000 option and one with DFPU option.

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
  tests/tcg/xtensa: add DFP0 arith tests
  target/xtensa: import DE_233L_FPU core
  target/xtensa: import DSP3400 core

 fpu/softfloat-specialize.inc.c                |    276 +-
 fpu/softfloat.c                               |      2 +-
 include/fpu/softfloat-helpers.h               |     10 +
 include/fpu/softfloat-types.h                 |      2 +
 target/xtensa/Makefile.objs                   |      2 +
 target/xtensa/core-DE_233L_FPU.c              |     31 +
 target/xtensa/core-DE_233L_FPU/core-isa.h     |    727 +
 target/xtensa/core-DE_233L_FPU/core-matmap.h  |    717 +
 .../xtensa/core-DE_233L_FPU/gdb-config.inc.c  |    277 +
 .../core-DE_233L_FPU/xtensa-modules.inc.c     |  20758 ++
 target/xtensa/core-dsp3400.c                  |     31 +
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
 tests/tcg/xtensa/test_dfp0_arith.S            |    153 +
 tests/tcg/xtensa/test_fp0_arith.S             |    266 +-
 tests/tcg/xtensa/test_fp0_conv.S              |    299 +-
 tests/tcg/xtensa/test_fp0_div.S               |     82 +
 tests/tcg/xtensa/test_fp0_sqrt.S              |     76 +
 tests/tcg/xtensa/test_fp1.S                   |     62 +-
 tests/tcg/xtensa/test_lsc.S                   |    170 +-
 31 files changed, 198354 insertions(+), 542 deletions(-)
 create mode 100644 target/xtensa/core-DE_233L_FPU.c
 create mode 100644 target/xtensa/core-DE_233L_FPU/core-isa.h
 create mode 100644 target/xtensa/core-DE_233L_FPU/core-matmap.h
 create mode 100644 target/xtensa/core-DE_233L_FPU/gdb-config.inc.c
 create mode 100644 target/xtensa/core-DE_233L_FPU/xtensa-modules.inc.c
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


