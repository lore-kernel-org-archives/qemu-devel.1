Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AE9C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDA1206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DycKSM3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDA1206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaKQ-0005A8-Cd
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHc-0008FD-0U
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:17 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:39118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHa-0000iv-T8
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:15 -0400
Received: by mail-wr1-x431.google.com with SMTP id l18so9958685wrn.6
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Qz/oC7mJ9ErBWbFSUONIhFOPD9eMP6oEJDrSogvCy0w=;
 b=DycKSM3qgiBbmRZSdDnXh5htxJphZh7vPjO4Jxx9trKiaqJ4GJXbK/vLdwP2h+KhhQ
 7nVy690EjKY8gQZQvvcbQ+nOcNq/6NPXk+zNdOQUk4Rgwc6ORm0YZrsTrcNmqOUnh58s
 1R4t7PHRoSCu+kTx4hLGzI9Xjjdth1kj65Ms9l1lHaz/PJ/lshpSkNbgFf47/ETxfKDY
 iexHtOULd8Em3iI//h0VvImKS+wV6U2wRWmzzfKyHvRa/zeWe0VIQfkvUNCCDoUTplCV
 fd2dkqiQ54n0BmulgtYWCsisBNN8nJRA4LkP4jwqg10gOLM4VPJde28SsE6+5+qhP8K+
 SGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Qz/oC7mJ9ErBWbFSUONIhFOPD9eMP6oEJDrSogvCy0w=;
 b=MIxcO5slR1xq+DTDe/8DFpB2PQb4qL7EuvECxzgWZlSxwOeKSkwCais7MxuwG+/1zp
 VbYevwPY4fwrW1SwV9NXK71w04RGYbzu+wC1/iDJ9uZd8HtrNZ7C8RzzWE7ShvH59zLI
 GHCncsoXufCy1dIy9yssJeMiCkyYGLRUrKAfoc/etfx+1xyJAZ+K99bMFH6zHPMhlPpL
 ulSfF5BO2cGDPX/DN0YU4/hljcfvsRBb6pQmYHA1UTVrGwVZJSqVJ8APsBuWqfuO2Xn/
 d2qCxwiSzjEQDxQ1sG+n5ZRPEG1KRE0wnlxqrnxNZY6LuuYfqaXMtrVNUpmrhouwgtfl
 bbkw==
X-Gm-Message-State: AGi0Pubg6vFiFw17OaQGQIPIrI19+tGzhb+kCEHfq1YOVd4XOj6f7uPv
 tGXQuYTF4rWyf3F7Fm1oKHb+OO69B+X2oA==
X-Google-Smtp-Source: APiQypL5XU4o0msdKAmNIo+m6leJoDBwt7jIWRjSQhdEcrlPnS36k4CdCuwiudVIVUWd6cjWOMqwdw==
X-Received: by 2002:a5d:60ca:: with SMTP id x10mr18701069wrt.407.1588595592411; 
 Mon, 04 May 2020 05:33:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/39] target-arm queue
Date: Mon,  4 May 2020 13:32:30 +0100
Message-Id: <20200504123309.3808-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Most of this is the Neon decodetree patches, followed by Edgar's versal cleanups.

thanks
-- PMM


The following changes since commit 2ef486e76d64436be90f7359a3071fb2a56ce835:

  Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' into staging (2020-05-03 14:12:56 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200504

for you to fetch changes up to 9aefc6cf9b73f66062d2f914a0136756e7a28211:

  target/arm: Move gen_ function typedefs to translate.h (2020-05-04 12:59:26 +0100)

----------------------------------------------------------------
target-arm queue:
 * Start of conversion of Neon insns to decodetree
 * versal board: support SD and RTC
 * Implement ARMv8.2-TTS2UXN
 * Make VQDMULL undefined when U=1
 * Some minor code cleanups

----------------------------------------------------------------
Edgar E. Iglesias (11):
      hw/arm: versal: Remove inclusion of arm_gicv3_common.h
      hw/arm: versal: Move misplaced comment
      hw/arm: versal-virt: Fix typo xlnx-ve -> xlnx-versal
      hw/arm: versal: Embed the UARTs into the SoC type
      hw/arm: versal: Embed the GEMs into the SoC type
      hw/arm: versal: Embed the ADMAs into the SoC type
      hw/arm: versal: Embed the APUs into the SoC type
      hw/arm: versal: Add support for SD
      hw/arm: versal: Add support for the RTC
      hw/arm: versal-virt: Add support for SD
      hw/arm: versal-virt: Add support for the RTC

Fredrik Strupe (1):
      target/arm: Make VQDMULL undefined when U=1

Peter Maydell (25):
      target/arm: Don't use a TLB for ARMMMUIdx_Stage2
      target/arm: Use enum constant in get_phys_addr_lpae() call
      target/arm: Add new 's1_is_el0' argument to get_phys_addr_lpae()
      target/arm: Implement ARMv8.2-TTS2UXN
      target/arm: Use correct variable for setting 'max' cpu's ID_AA64DFR0
      target/arm/translate-vfp.inc.c: Remove duplicate simd_r32 check
      target/arm: Don't allow Thumb Neon insns without FEATURE_NEON
      target/arm: Add stubs for AArch32 Neon decodetree
      target/arm: Convert VCMLA (vector) to decodetree
      target/arm: Convert VCADD (vector) to decodetree
      target/arm: Convert V[US]DOT (vector) to decodetree
      target/arm: Convert VFM[AS]L (vector) to decodetree
      target/arm: Convert VCMLA (scalar) to decodetree
      target/arm: Convert V[US]DOT (scalar) to decodetree
      target/arm: Convert VFM[AS]L (scalar) to decodetree
      target/arm: Convert Neon load/store multiple structures to decodetree
      target/arm: Convert Neon 'load single structure to all lanes' to decodetree
      target/arm: Convert Neon 'load/store single structure' to decodetree
      target/arm: Convert Neon 3-reg-same VADD/VSUB to decodetree
      target/arm: Convert Neon 3-reg-same logic ops to decodetree
      target/arm: Convert Neon 3-reg-same VMAX/VMIN to decodetree
      target/arm: Convert Neon 3-reg-same comparisons to decodetree
      target/arm: Convert Neon 3-reg-same VQADD/VQSUB to decodetree
      target/arm: Convert Neon 3-reg-same VMUL, VMLA, VMLS, VSHL to decodetree
      target/arm: Move gen_ function typedefs to translate.h

Philippe Mathieu-Daudé (2):
      hw/arm/mps2-tz: Use TYPE_IOTKIT instead of hardcoded string
      target/arm: Use uint64_t for midr field in CPU state struct

 include/hw/arm/xlnx-versal.h    |  31 +-
 target/arm/cpu-param.h          |   2 +-
 target/arm/cpu.h                |  38 ++-
 target/arm/translate-a64.h      |   9 -
 target/arm/translate.h          |  26 ++
 target/arm/neon-dp.decode       |  86 +++++
 target/arm/neon-ls.decode       |  52 +++
 target/arm/neon-shared.decode   |  66 ++++
 hw/arm/mps2-tz.c                |   2 +-
 hw/arm/xlnx-versal-virt.c       |  74 ++++-
 hw/arm/xlnx-versal.c            | 115 +++++--
 target/arm/cpu.c                |   3 +-
 target/arm/cpu64.c              |   8 +-
 target/arm/helper.c             | 183 ++++------
 target/arm/translate-a64.c      |  17 -
 target/arm/translate-neon.inc.c | 714 +++++++++++++++++++++++++++++++++++++++
 target/arm/translate-vfp.inc.c  |   6 -
 target/arm/translate.c          | 716 +++-------------------------------------
 target/arm/Makefile.objs        |  18 +
 19 files changed, 1302 insertions(+), 864 deletions(-)
 create mode 100644 target/arm/neon-dp.decode
 create mode 100644 target/arm/neon-ls.decode
 create mode 100644 target/arm/neon-shared.decode
 create mode 100644 target/arm/translate-neon.inc.c

