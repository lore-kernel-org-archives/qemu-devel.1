Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC98CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB31E2080F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqX7X5nW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB31E2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQSjT-0005yD-2R
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 04:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSeo-0000xS-RC
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSen-00087e-6o
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:46 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQSem-0007zn-Vd
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:45 -0400
Received: by mail-wr1-x441.google.com with SMTP id s1so8974508wro.0
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gjSuK4BXouO/T+B7He1WodMOLKKfPRfP+oEPOS2e0Nc=;
 b=CqX7X5nWuLlde+7tJ3+h4YVhSNP4zU6yWnO/eHCa8+vroE+UCbcCVFczLY3ib5kCwV
 yOuxzcHtVMm9lHgnnvc/EiyBS0qr8SjXNaYwO3IQgzbcrPm++SaVWIvEtU5ihfv7LY5l
 FrPRxm6hT/mxT2sE6BRaeyrpuzyAeMRSQJEvSctY9Yrr235uL8cO6JCe3fZu4rGA3COn
 HsW0zizoJmbwa92Rh2tgF6fbrUnAeg5/DjiuvRzjixflG9w9gWSUgOD5tcPIJF/jbeBj
 K+eVPvxpMaryoes+H4grA6V2HI+6KGwJ8CsC+yBUwpsZ9k877gzPdnfk11g5sDZs33nH
 BXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gjSuK4BXouO/T+B7He1WodMOLKKfPRfP+oEPOS2e0Nc=;
 b=bT8CSoiUNp2yf7uBatSHfSZnHm6C5Hu/JP+J0M4Ice+qUsL19zCWONa/BNxlTIn4S/
 oy5UggTbsnGKepasxAgssDS0PwhACgHWUWPAg8sflAS6NfStKweSEuvKtissryG3hIKP
 IHtTx3+rEbx2v/ZM2FHOnG1JyhRO/lXk2gnrKelIdWwRYs38OLGadEDO+G6sg9jd+iVh
 E3SbUPD5ou127z/lD9NCdD0lIBBeauey+ffUjojsAJADd+pseP9rp8tExVUvOsi+EQpu
 mgm2b/uQv3j2mgmW91Miv18jeDDt/VMoxoc7UV2iTa8fE7+tBZ/1FzxNTchZGIJe9rgs
 flMA==
X-Gm-Message-State: APjAAAUdzet1HL99E8W1KmrgAkWcC+rjOP9FZ13VHdlPT5kd26+gWOFE
 pgcuhp5FDclce/M8k8G/46H16a9Wc5Dq6g1c
X-Google-Smtp-Source: APXvYqzuSGlWjUaGcZPm1V6mBrSUv9ql7Ux6ye/NIgOmc+MLc5Ke9wEdKESyDvyQKUt+9xC1+nFQwg==
X-Received: by 2002:adf:e682:: with SMTP id r2mr9176189wrm.365.1572598303189; 
 Fri, 01 Nov 2019 01:51:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d20sm8818922wra.4.2019.11.01.01.51.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 01:51:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] target-arm queue
Date: Fri,  1 Nov 2019 08:51:29 +0000
Message-Id: <20191101085140.5205-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

target-arm queue: two bug fixes, plus the KVM/SVE patchset,
which is a new feature but one which was in my pre-softfreeze
pullreq (it just had to be dropped due to an unexpected test failure.)

thanks
-- PMM

The following changes since commit b7c9a7f353c0e260519bf735ff0d4aa01e72784b:

  Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2019-10-31 15:57:30 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191101-1

for you to fetch changes up to d9ae7624b659362cb2bb2b04fee53bf50829ca56:

  target/arm: Allow reading flags from FPSCR for M-profile (2019-11-01 08:49:10 +0000)

----------------------------------------------------------------
target-arm queue:
 * Support SVE in KVM guests
 * Don't UNDEF on M-profile 'vmrs apsr_nzcv, fpscr'
 * Update hflags after boot.c modifies CPU state

----------------------------------------------------------------
Andrew Jones (9):
      target/arm/monitor: Introduce qmp_query_cpu_model_expansion
      tests: arm: Introduce cpu feature tests
      target/arm: Allow SVE to be disabled via a CPU property
      target/arm/cpu64: max cpu: Introduce sve<N> properties
      target/arm/kvm64: Add kvm_arch_get/put_sve
      target/arm/kvm64: max cpu: Enable SVE when available
      target/arm/kvm: scratch vcpu: Preserve input kvm_vcpu_init features
      target/arm/cpu64: max cpu: Support sve properties with KVM
      target/arm/kvm: host cpu: Add support for sve<N> properties

Christophe Lyon (1):
      target/arm: Allow reading flags from FPSCR for M-profile

Edgar E. Iglesias (1):
      hw/arm/boot: Rebuild hflags when modifying CPUState at boot

 tests/Makefile.include         |   5 +-
 qapi/machine-target.json       |   6 +-
 include/qemu/bitops.h          |   1 +
 target/arm/cpu.h               |  21 ++
 target/arm/kvm_arm.h           |  39 +++
 hw/arm/boot.c                  |   1 +
 target/arm/cpu.c               |  25 +-
 target/arm/cpu64.c             | 364 +++++++++++++++++++++++++--
 target/arm/helper.c            |  10 +-
 target/arm/kvm.c               |  25 +-
 target/arm/kvm32.c             |   6 +-
 target/arm/kvm64.c             | 325 +++++++++++++++++++++---
 target/arm/monitor.c           | 158 ++++++++++++
 target/arm/translate-vfp.inc.c |   5 +-
 tests/arm-cpu-features.c       | 551 +++++++++++++++++++++++++++++++++++++++++
 docs/arm-cpu-features.rst      | 317 ++++++++++++++++++++++++
 16 files changed, 1795 insertions(+), 64 deletions(-)
 create mode 100644 tests/arm-cpu-features.c
 create mode 100644 docs/arm-cpu-features.rst

