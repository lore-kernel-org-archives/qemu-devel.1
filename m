Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DAFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F6C2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VyeD8XgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F6C2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8Lz-0008NM-Vu
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 05:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8L7-0006z0-DF
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:35062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8L5-00040V-F9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id q25so2422203wmj.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7ScqesT2vaLTukCijDkEoT5RQ12ELJbQ9/G0v11gmYg=;
 b=VyeD8XgZdg6RDPLhJ7MaRwci/PTujCX6wSBKFsi3nJDtYqRrsGB4qgJX5ZYZ7eVhII
 1tCaw/10d0Va+PqpffsR+fP7CfM05Tpi8ztXKVfZwf32ljWRwE5wLLGQ8e80Mbab9/IY
 7DVXT1X0xqfx7+VYGh/Z5qb3/nANg1FF5o6YRFos8cZXMAVwbB4FdmySvaUzQL5qXamR
 ifR3OSfHEEkcXiwVKT9ON1ahi7NHHcYKqxDFi9Sy5MLbY7m5JGpAlDXxIz8W86IV4xHs
 KQoj2u8bMBxBXIdNzY8mqGn0o/dtF6W+O2h5LjFnRF7DOxfN2VvA7vKLeAKSQu0eJYws
 StsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7ScqesT2vaLTukCijDkEoT5RQ12ELJbQ9/G0v11gmYg=;
 b=fxAbed8PNh0bQyfRdtXHEFOUoppd9v16Es++VZYN2I/JLv1aoFRxGlei8bGoNVpiPl
 vP/tuUOKx0Rjj2Yk2cU3yqDVGLTQoLc/6yqKuAG5DCFFIZF3kTDQMLTPWYmnujssDT6r
 RKHhfLX4nYG2MBmU+oJ4X+BOjkKaA9z/HqsmfIeRflkcgY5tlMp0e45JAjFJNJlUYL+D
 9t/L5VqhsfrbfnfySgQVFv6a0G+U9wuGFVuB52I7DoleW1RAlA6A/LKPpH930BVq7lnE
 J4fdOASsUL4TAU9uRZOKRoM7Qkd22suOohc/Xf3yc76x940zvtZd9SNOKP+QmlN8J2WQ
 hAtg==
X-Gm-Message-State: AOAM533ob6nv5YjgjKPu85aRoSiNjo1u+OmX0jK1jzrHyl6gvqV8qrOU
 4DbUNmWtk+8xm/Y9TMdY27oySVRdI03+pw==
X-Google-Smtp-Source: ABdhPJxfJlw04a5wiHN8fdJl/zztSl8BdAIfb20jZxQ3jJRs+gXAArgOnW4EbllA4XyVO51cU3C+vQ==
X-Received: by 2002:a1c:3c08:: with SMTP id j8mr2243615wma.23.1592301425372;
 Tue, 16 Jun 2020 02:57:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/23] target-arm queue
Date: Tue, 16 Jun 2020 10:56:39 +0100
Message-Id: <20200616095702.25848-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Mostly my decodetree stuff, but also some patches for various
smaller bugs/features from others.

thanks
-- PMM

The following changes since commit 53550e81e2cafe7c03a39526b95cd21b5194d9b1:

  Merge remote-tracking branch 'remotes/berrange/tags/qcrypto-next-pull-request' into staging (2020-06-15 16:36:34 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200616

for you to fetch changes up to 64b397417a26509bcdff44ab94356a35c7901c79:

  hw: arm: Set vendor property for IMX SDHCI emulations (2020-06-16 10:32:29 +0100)

----------------------------------------------------------------
 * hw: arm: Set vendor property for IMX SDHCI emulations
 * sd: sdhci: Implement basic vendor specific register support
 * hw/net/imx_fec: Convert debug fprintf() to trace events
 * target/arm/cpu: adjust virtual time for all KVM arm cpus
 * Implement configurable descriptor size in ftgmac100
 * hw/misc/imx6ul_ccm: Implement non writable bits in CCM registers
 * target/arm: More Neon decodetree conversion work

----------------------------------------------------------------
Erik Smit (1):
      Implement configurable descriptor size in ftgmac100

Guenter Roeck (2):
      sd: sdhci: Implement basic vendor specific register support
      hw: arm: Set vendor property for IMX SDHCI emulations

Jean-Christophe Dubois (2):
      hw/misc/imx6ul_ccm: Implement non writable bits in CCM registers
      hw/net/imx_fec: Convert debug fprintf() to trace events

Peter Maydell (17):
      target/arm: Fix missing temp frees in do_vshll_2sh
      target/arm: Convert Neon 3-reg-diff prewidening ops to decodetree
      target/arm: Convert Neon 3-reg-diff narrowing ops to decodetree
      target/arm: Convert Neon 3-reg-diff VABAL, VABDL to decodetree
      target/arm: Convert Neon 3-reg-diff long multiplies
      target/arm: Convert Neon 3-reg-diff saturating doubling multiplies
      target/arm: Convert Neon 3-reg-diff polynomial VMULL
      target/arm: Add 'static' and 'const' annotations to VSHLL function arrays
      target/arm: Add missing TCG temp free in do_2shift_env_64()
      target/arm: Convert Neon 2-reg-scalar integer multiplies to decodetree
      target/arm: Convert Neon 2-reg-scalar float multiplies to decodetree
      target/arm: Convert Neon 2-reg-scalar VQDMULH, VQRDMULH to decodetree
      target/arm: Convert Neon 2-reg-scalar VQRDMLAH, VQRDMLSH to decodetree
      target/arm: Convert Neon 2-reg-scalar long multiplies to decodetree
      target/arm: Convert Neon VEXT to decodetree
      target/arm: Convert Neon VTBL, VTBX to decodetree
      target/arm: Convert Neon VDUP (scalar) to decodetree

fangying (1):
      target/arm/cpu: adjust virtual time for all KVM arm cpus

 hw/sd/sdhci-internal.h          |    5 +
 include/hw/sd/sdhci.h           |    5 +
 target/arm/translate.h          |    1 +
 target/arm/neon-dp.decode       |  130 +++++
 hw/arm/fsl-imx25.c              |    6 +
 hw/arm/fsl-imx6.c               |    6 +
 hw/arm/fsl-imx6ul.c             |    2 +
 hw/arm/fsl-imx7.c               |    2 +
 hw/misc/imx6ul_ccm.c            |   76 ++-
 hw/net/ftgmac100.c              |   26 +-
 hw/net/imx_fec.c                |  106 ++--
 hw/sd/sdhci.c                   |   18 +-
 target/arm/cpu.c                |    6 +-
 target/arm/cpu64.c              |    1 -
 target/arm/kvm.c                |   21 +-
 target/arm/translate-neon.inc.c | 1148 ++++++++++++++++++++++++++++++++++++++-
 target/arm/translate.c          |  684 +----------------------
 hw/net/trace-events             |   18 +
 18 files changed, 1495 insertions(+), 766 deletions(-)

