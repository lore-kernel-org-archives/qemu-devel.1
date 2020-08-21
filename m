Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3C4C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC5E20724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBkaRLKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC5E20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9E0y-0004XW-M1
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 16:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1k9E0H-0003mV-KZ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 16:51:13 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:36134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1k9E0F-0001JN-WB
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 16:51:13 -0400
Received: by mail-pl1-x630.google.com with SMTP id y6so1418338plt.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2DW43WGM/acRfeuMXxpBQVeMp09/Zt0DygOTo24ezk0=;
 b=UBkaRLKr3i3kg8rNlbRVOPxp/SZVybgXoaCHS+/3nhm9POfC/LoP6elvm2rp+FNDEX
 Dz1A/Ukpfe1NRbtOpBQqmelXUKMO2HDibhY/veC8C2DlBHEfm6bObc5DgdDhzwmaA4Ec
 5eegv5AdEsaDkr5LNavwhQGvkNryC2HlCJ1AdvqvzfzNXxWgv28bGpyM+7NFNJ6N/NwQ
 weah/zExHvz3I+ipZ21I4o5Xx2mD4lYgv+hSThiFKA01dhigWyn7OKpzHSv+HU5tTdQ4
 AULqCSsQebyKr4DDpKDGXUy9cumuXG64vISS3GrjbaeauoPgJKap6XzrOcaPeuaYmj9i
 OUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2DW43WGM/acRfeuMXxpBQVeMp09/Zt0DygOTo24ezk0=;
 b=SuywpPK4vX/IKx5Q82mdxDOSDilfvXp3+9iQ72FMo33wPK7JE3QQqhkE5vTCZTZV3N
 VrJDBWKJzFidrz7mGp5Zs6cvfXPAHqlSJyN3C5It6wJzXXliB1D7gSNunVNLzLycVQPT
 M2ZpXcjq6GNXhJ5bwxVi0875w3bxyMjUNtfhP9r8OPb8kB8MHlcECQaiCQwNxqdXv3m9
 PsMjozVMjhw4MBw4nHxP+wAm2Ynqzi/BmeGFzXH4O4XDL+IQreg65mTCuN14XAzlUsMY
 9ReEWXkGumt5xS60T4VtdlkE3JAIBPE5QyYVxqAhu4+lisrcEORf5QG+ICIfvIEDYPaZ
 KW4Q==
X-Gm-Message-State: AOAM5338xmCkSXtLtq4oORiEfnoF6zzENWNVqDF11PDysGJKrz9+VhQW
 kvKTCsKIJQIZdypqM5hfc92EnksxquA=
X-Google-Smtp-Source: ABdhPJwchpC6xzv7GVDMr3ni5alVzEeumsMRfzZR0bKHj1oHb3cJgJdjkbAuD2P6OkKcvo4G172waQ==
X-Received: by 2002:a17:902:b402:: with SMTP id x2mr242282plr.97.1598043069803; 
 Fri, 21 Aug 2020 13:51:09 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:401:26c0:5caa:fe49:9c90:e47c])
 by smtp.gmail.com with ESMTPSA id k5sm3091102pgk.78.2020.08.21.13.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 13:51:09 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/24] target/xtensa updates for 5.2
Date: Fri, 21 Aug 2020 13:50:50 -0700
Message-Id: <20200821205050.29066-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x630.google.com
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

Changes v1->v2:
- rebase on top of build system changes, resolve trivial conflicts
  in the last two patches that add new files.

The following changes since commit f86d9a093dada588889bde5582c7ec320487c4b8:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-08-21 17:26:52 +0100)

are available in the Git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20200821-xtensa

for you to fetch changes up to c621b4142bf1ff8c663811c10bd1628481e494a6:

  target/xtensa: import DSP3400 core (2020-08-21 12:56:45 -0700)

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

 fpu/softfloat-specialize.c.inc                    |    286 +-
 fpu/softfloat.c                                   |      2 +-
 hw/xtensa/pic_cpu.c                               |      6 +-
 include/fpu/softfloat-helpers.h                   |     10 +
 include/fpu/softfloat-types.h                     |      8 +-
 target/xtensa/core-de233_fpu.c                    |     58 +
 target/xtensa/core-de233_fpu/core-isa.h           |    727 +
 target/xtensa/core-de233_fpu/core-matmap.h        |    717 +
 target/xtensa/core-de233_fpu/gdb-config.c.inc     |    277 +
 target/xtensa/core-de233_fpu/xtensa-modules.c.inc |  20758 +++
 target/xtensa/core-dsp3400.c                      |     58 +
 target/xtensa/core-dsp3400/core-isa.h             |    452 +
 target/xtensa/core-dsp3400/core-matmap.h          |    312 +
 target/xtensa/core-dsp3400/gdb-config.c.inc       |    400 +
 target/xtensa/core-dsp3400/xtensa-modules.c.inc   | 171906 +++++++++++++++++++
 target/xtensa/cpu.c                               |      5 +
 target/xtensa/cpu.h                               |     14 +-
 target/xtensa/exc_helper.c                        |     23 +-
 target/xtensa/fpu_helper.c                        |    342 +-
 target/xtensa/helper.c                            |      4 +-
 target/xtensa/helper.h                            |     58 +-
 target/xtensa/meson.build                         |      2 +
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
 create mode 100644 target/xtensa/core-de233_fpu/gdb-config.c.inc
 create mode 100644 target/xtensa/core-de233_fpu/xtensa-modules.c.inc
 create mode 100644 target/xtensa/core-dsp3400.c
 create mode 100644 target/xtensa/core-dsp3400/core-isa.h
 create mode 100644 target/xtensa/core-dsp3400/core-matmap.h
 create mode 100644 target/xtensa/core-dsp3400/gdb-config.c.inc
 create mode 100644 target/xtensa/core-dsp3400/xtensa-modules.c.inc
 create mode 100644 tests/tcg/xtensa/fpu.h
 create mode 100644 tests/tcg/xtensa/test_dfp0_arith.S
 create mode 100644 tests/tcg/xtensa/test_fp0_div.S
 create mode 100644 tests/tcg/xtensa/test_fp0_sqrt.S

-- 
Thanks.
-- Max

