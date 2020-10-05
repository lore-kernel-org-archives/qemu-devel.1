Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37E0C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC4A2075A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzfBs521"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC4A2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLoQ-00011I-Ei
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmm-0007xA-Jb
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:56 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:45640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmh-0007Iq-5R
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:54 -0400
Received: by mail-wr1-x435.google.com with SMTP id x14so8452607wrl.12
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9pbVTRYOSJwqxbrYzcTT3Jk9ELmnODYFGQ56/AUtytc=;
 b=DzfBs521qa38ZIosmE6ue2mUlXdvrPsq9antm285fQK8v4dnay2bY3Wfm/LbsmMw+/
 CilZq7POsU3C8980Jonx2hZCLz1KAFQGEu24jnSoj9c1IIwyxcCcYpIHZFaGNJB8bIjB
 uA38Gu5rRTTeY9zEROPMX9/jm+H1HC/4cV+p6ZQkP6txcDa1kjytnkyYGB99y7qACZ5V
 0wJieSeImPCAuyC+RsSQxwqgIK0v483efR2N3VKK/WzxtD1rErUHxAfEfHlgcqscEwx+
 AmctIsAPn0Nfs6NmQd1MKdGyI/RA3xKKFwJxJDux/6Ej3y/zYGY8nZkMoB2EUVust2dl
 FbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=9pbVTRYOSJwqxbrYzcTT3Jk9ELmnODYFGQ56/AUtytc=;
 b=dXiltyOFxNXeOPCeII5cR1HV90fh81iDh74Qa9P/T82q2zgSEkgYSNsn3FSRFXtLWe
 2aukqfcndMXvxe15sjrjK0zXNRHsRpcNSUWM+QKO6neNQhLDMIMwGyccaCEne7MwkgDg
 SXXZ8n109p++l8aivig3fqqNhsr0BP7VI4BdW/9Wj61qzEvSznogrnVsbItkPQSFw8nA
 90H98sTK4hiyaxH6fk21OVUBl6DN78SC40QohxteaKJJ3EqEU/dSCO9Isg6ao5mCWDg/
 +FIfleHJTdm/ARpeCW9P90e3JBKU98oNzD1XnoJoSU6PX2ixBRnSPeRb8Z83oHawOngI
 vhPg==
X-Gm-Message-State: AOAM531P0ySYDwFmWuY01Gd6F5FQXE24MEB1V42xdCizLgnuh9Ffg6SY
 X1QRbtSANN0WGUVHHNe772Gy+fM+RcU=
X-Google-Smtp-Source: ABdhPJxgWy4xCd7e7zShrv1eqSMXsSmJMkGF+pQv+hTxRaL8h1GNnO/IpopzlDhQlFikJGtlOl+nqw==
X-Received: by 2002:adf:e907:: with SMTP id f7mr16100164wrm.169.1601886228687; 
 Mon, 05 Oct 2020 01:23:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.23.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:23:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/19] Build system + MCE patches for 2020-10-05
Date: Mon,  5 Oct 2020 10:23:30 +0200
Message-Id: <20201005082349.354095-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 469e72ab7dbbd7ff4ee601e5ea7c29545d46593b:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2020-10-02 16:19:42 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to d72d6dcb0d633bb08c2dc5a959a47608a1655018:

  dockerfiles: add diffutils to Fedora (2020-10-05 09:14:19 +0200)

----------------------------------------------------------------
* move target configuration to default-configs/targets (myself)
* Memory failure event (Zhenwei)

----------------------------------------------------------------
Paolo Bonzini (16):
      travis: remove TCI test
      default-configs: move files to default-configs/devices/
      configure: convert accelerator variables to meson options
      configure: rewrite accelerator defaults as tests
      configure: move accelerator logic to meson
      configure: remove dead variable
      configure: compute derivatives of target name in meson
      configure: remove useless config-target.mak symbols
      configure: remove target configuration
      default-configs: remove default-configs/devices for user-mode targets
      configure: move OpenBSD W^X test to meson
      default-configs: use TARGET_ARCH key
      default-configs: remove redundant keys
      meson: move sparse detection to Meson and rewrite check_sparse.py
      tests: tcg: do not use implicit rules
      dockerfiles: add diffutils to Fedora

Zhenwei Pi (3):
      target-i386: seperate MCIP & MCE_MASK error reason
      qapi/run-state.json: introduce memory failure event
      target-i386: post memory failure event to QMP

 .travis.yml                                        |   8 -
 configure                                          | 627 +++------------------
 default-configs/aarch64-linux-user.mak             |   1 -
 default-configs/aarch64_be-linux-user.mak          |   1 -
 default-configs/alpha-linux-user.mak               |   1 -
 default-configs/arm-linux-user.mak                 |   1 -
 default-configs/armeb-linux-user.mak               |   1 -
 default-configs/cris-linux-user.mak                |   1 -
 default-configs/{ => devices}/aarch64-softmmu.mak  |   0
 default-configs/{ => devices}/alpha-softmmu.mak    |   0
 default-configs/{ => devices}/arm-softmmu.mak      |   0
 default-configs/{ => devices}/avr-softmmu.mak      |   0
 default-configs/{ => devices}/cris-softmmu.mak     |   0
 default-configs/{ => devices}/hppa-softmmu.mak     |   0
 default-configs/{ => devices}/i386-softmmu.mak     |   0
 default-configs/{ => devices}/lm32-softmmu.mak     |   0
 default-configs/{ => devices}/m68k-softmmu.mak     |   0
 .../{ => devices}/microblaze-softmmu.mak           |   0
 .../{ => devices}/microblazeel-softmmu.mak         |   0
 .../{ => devices}/mips-softmmu-common.mak          |   0
 default-configs/{ => devices}/mips-softmmu.mak     |   0
 default-configs/{ => devices}/mips64-softmmu.mak   |   0
 default-configs/{ => devices}/mips64el-softmmu.mak |   0
 default-configs/{ => devices}/mipsel-softmmu.mak   |   0
 default-configs/{ => devices}/moxie-softmmu.mak    |   0
 default-configs/{ => devices}/nios2-softmmu.mak    |   0
 default-configs/{ => devices}/or1k-softmmu.mak     |   0
 default-configs/{ => devices}/ppc-softmmu.mak      |   0
 default-configs/{ => devices}/ppc64-softmmu.mak    |   0
 default-configs/{ => devices}/riscv32-softmmu.mak  |   0
 default-configs/{ => devices}/riscv64-softmmu.mak  |   0
 default-configs/{ => devices}/rx-softmmu.mak       |   0
 default-configs/{ => devices}/s390x-softmmu.mak    |   0
 default-configs/{ => devices}/sh4-softmmu.mak      |   0
 default-configs/{ => devices}/sh4eb-softmmu.mak    |   0
 default-configs/{ => devices}/sparc-softmmu.mak    |   0
 default-configs/{ => devices}/sparc64-softmmu.mak  |   0
 default-configs/{ => devices}/tricore-softmmu.mak  |   0
 .../{ => devices}/unicore32-softmmu.mak            |   0
 default-configs/{ => devices}/x86_64-softmmu.mak   |   0
 default-configs/{ => devices}/xtensa-softmmu.mak   |   0
 default-configs/{ => devices}/xtensaeb-softmmu.mak |   0
 default-configs/hppa-linux-user.mak                |   1 -
 default-configs/i386-bsd-user.mak                  |   1 -
 default-configs/i386-linux-user.mak                |   1 -
 default-configs/m68k-linux-user.mak                |   1 -
 default-configs/microblaze-linux-user.mak          |   1 -
 default-configs/microblazeel-linux-user.mak        |   1 -
 default-configs/mips-linux-user.mak                |   1 -
 default-configs/mips64-linux-user.mak              |   1 -
 default-configs/mips64el-linux-user.mak            |   1 -
 default-configs/mipsel-linux-user.mak              |   1 -
 default-configs/mipsn32-linux-user.mak             |   1 -
 default-configs/mipsn32el-linux-user.mak           |   1 -
 default-configs/nios2-linux-user.mak               |   1 -
 default-configs/or1k-linux-user.mak                |   1 -
 default-configs/ppc-linux-user.mak                 |   1 -
 default-configs/ppc64-linux-user.mak               |   1 -
 default-configs/ppc64abi32-linux-user.mak          |   1 -
 default-configs/ppc64le-linux-user.mak             |   1 -
 default-configs/riscv32-linux-user.mak             |   1 -
 default-configs/riscv64-linux-user.mak             |   1 -
 default-configs/s390x-linux-user.mak               |   1 -
 default-configs/sh4-linux-user.mak                 |   1 -
 default-configs/sh4eb-linux-user.mak               |   1 -
 default-configs/sparc-bsd-user.mak                 |   1 -
 default-configs/sparc-linux-user.mak               |   1 -
 default-configs/sparc32plus-linux-user.mak         |   1 -
 default-configs/sparc64-bsd-user.mak               |   1 -
 default-configs/sparc64-linux-user.mak             |   1 -
 default-configs/targets/aarch64-linux-user.mak     |   4 +
 default-configs/targets/aarch64-softmmu.mak        |   4 +
 default-configs/targets/aarch64_be-linux-user.mak  |   5 +
 default-configs/targets/alpha-linux-user.mak       |   4 +
 default-configs/targets/alpha-softmmu.mak          |   3 +
 default-configs/targets/arm-linux-user.mak         |   5 +
 default-configs/targets/arm-softmmu.mak            |   3 +
 default-configs/targets/armeb-linux-user.mak       |   6 +
 default-configs/targets/avr-softmmu.mak            |   2 +
 default-configs/targets/cris-linux-user.mak        |   1 +
 default-configs/targets/cris-softmmu.mak           |   1 +
 default-configs/targets/hppa-linux-user.mak        |   5 +
 default-configs/targets/hppa-softmmu.mak           |   4 +
 default-configs/targets/i386-bsd-user.mak          |   2 +
 default-configs/targets/i386-linux-user.mak        |   4 +
 default-configs/targets/i386-softmmu.mak           |   3 +
 default-configs/targets/lm32-softmmu.mak           |   2 +
 default-configs/targets/m68k-linux-user.mak        |   6 +
 default-configs/targets/m68k-softmmu.mak           |   3 +
 default-configs/targets/microblaze-linux-user.mak  |   5 +
 default-configs/targets/microblaze-softmmu.mak     |   3 +
 .../targets/microblazeel-linux-user.mak            |   4 +
 default-configs/targets/microblazeel-softmmu.mak   |   2 +
 default-configs/targets/mips-linux-user.mak        |   6 +
 default-configs/targets/mips-softmmu.mak           |   4 +
 default-configs/targets/mips64-linux-user.mak      |   7 +
 default-configs/targets/mips64-softmmu.mak         |   4 +
 default-configs/targets/mips64el-linux-user.mak    |   6 +
 default-configs/targets/mips64el-softmmu.mak       |   3 +
 default-configs/targets/mipsel-linux-user.mak      |   5 +
 default-configs/targets/mipsel-softmmu.mak         |   3 +
 default-configs/targets/mipsn32-linux-user.mak     |   8 +
 default-configs/targets/mipsn32el-linux-user.mak   |   7 +
 default-configs/targets/moxie-softmmu.mak          |   2 +
 default-configs/targets/nios2-linux-user.mak       |   1 +
 default-configs/targets/nios2-softmmu.mak          |   1 +
 default-configs/targets/or1k-linux-user.mak        |   2 +
 default-configs/targets/or1k-softmmu.mak           |   2 +
 default-configs/targets/ppc-linux-user.mak         |   5 +
 default-configs/targets/ppc-softmmu.mak            |   3 +
 default-configs/targets/ppc64-linux-user.mak       |   7 +
 default-configs/targets/ppc64-softmmu.mak          |   5 +
 default-configs/targets/ppc64abi32-linux-user.mak  |   8 +
 default-configs/targets/ppc64le-linux-user.mak     |   6 +
 default-configs/targets/riscv32-linux-user.mak     |   4 +
 default-configs/targets/riscv32-softmmu.mak        |   4 +
 default-configs/targets/riscv64-linux-user.mak     |   4 +
 default-configs/targets/riscv64-softmmu.mak        |   4 +
 default-configs/targets/rx-softmmu.mak             |   2 +
 default-configs/targets/s390x-linux-user.mak       |   5 +
 default-configs/targets/s390x-softmmu.mak          |   4 +
 default-configs/targets/sh4-linux-user.mak         |   5 +
 default-configs/targets/sh4-softmmu.mak            |   2 +
 default-configs/targets/sh4eb-linux-user.mak       |   6 +
 default-configs/targets/sh4eb-softmmu.mak          |   3 +
 default-configs/targets/sparc-bsd-user.mak         |   3 +
 default-configs/targets/sparc-linux-user.mak       |   5 +
 default-configs/targets/sparc-softmmu.mak          |   3 +
 default-configs/targets/sparc32plus-linux-user.mak |   8 +
 default-configs/targets/sparc64-bsd-user.mak       |   4 +
 default-configs/targets/sparc64-linux-user.mak     |   6 +
 default-configs/targets/sparc64-softmmu.mak        |   4 +
 default-configs/targets/tilegx-linux-user.mak      |   1 +
 default-configs/targets/tricore-softmmu.mak        |   1 +
 default-configs/targets/unicore32-softmmu.mak      |   1 +
 default-configs/targets/x86_64-bsd-user.mak        |   3 +
 default-configs/targets/x86_64-linux-user.mak      |   5 +
 default-configs/targets/x86_64-softmmu.mak         |   4 +
 default-configs/targets/xtensa-linux-user.mak      |   5 +
 default-configs/targets/xtensa-softmmu.mak         |   3 +
 default-configs/targets/xtensaeb-linux-user.mak    |   6 +
 default-configs/targets/xtensaeb-softmmu.mak       |   4 +
 default-configs/tilegx-linux-user.mak              |   1 -
 default-configs/x86_64-bsd-user.mak                |   1 -
 default-configs/x86_64-linux-user.mak              |   1 -
 default-configs/xtensa-linux-user.mak              |   1 -
 default-configs/xtensaeb-linux-user.mak            |   1 -
 meson.build                                        | 190 ++++++-
 meson_options.txt                                  |  17 +
 qapi/run-state.json                                |  90 +++
 scripts/check_sparse.py                            |  56 +-
 target/i386/helper.c                               |  47 +-
 target/i386/kvm.c                                  |  13 +-
 tests/Makefile.include                             |   6 +-
 tests/docker/dockerfiles/fedora.docker             |   1 +
 tests/meson.build                                  |   2 +-
 156 files changed, 731 insertions(+), 650 deletions(-)
 delete mode 100644 default-configs/aarch64-linux-user.mak
 delete mode 100644 default-configs/aarch64_be-linux-user.mak
 delete mode 100644 default-configs/alpha-linux-user.mak
 delete mode 100644 default-configs/arm-linux-user.mak
 delete mode 100644 default-configs/armeb-linux-user.mak
 delete mode 100644 default-configs/cris-linux-user.mak
 rename default-configs/{ => devices}/aarch64-softmmu.mak (100%)
 rename default-configs/{ => devices}/alpha-softmmu.mak (100%)
 rename default-configs/{ => devices}/arm-softmmu.mak (100%)
 rename default-configs/{ => devices}/avr-softmmu.mak (100%)
 rename default-configs/{ => devices}/cris-softmmu.mak (100%)
 rename default-configs/{ => devices}/hppa-softmmu.mak (100%)
 rename default-configs/{ => devices}/i386-softmmu.mak (100%)
 rename default-configs/{ => devices}/lm32-softmmu.mak (100%)
 rename default-configs/{ => devices}/m68k-softmmu.mak (100%)
 rename default-configs/{ => devices}/microblaze-softmmu.mak (100%)
 rename default-configs/{ => devices}/microblazeel-softmmu.mak (100%)
 rename default-configs/{ => devices}/mips-softmmu-common.mak (100%)
 rename default-configs/{ => devices}/mips-softmmu.mak (100%)
 rename default-configs/{ => devices}/mips64-softmmu.mak (100%)
 rename default-configs/{ => devices}/mips64el-softmmu.mak (100%)
 rename default-configs/{ => devices}/mipsel-softmmu.mak (100%)
 rename default-configs/{ => devices}/moxie-softmmu.mak (100%)
 rename default-configs/{ => devices}/nios2-softmmu.mak (100%)
 rename default-configs/{ => devices}/or1k-softmmu.mak (100%)
 rename default-configs/{ => devices}/ppc-softmmu.mak (100%)
 rename default-configs/{ => devices}/ppc64-softmmu.mak (100%)
 rename default-configs/{ => devices}/riscv32-softmmu.mak (100%)
 rename default-configs/{ => devices}/riscv64-softmmu.mak (100%)
 rename default-configs/{ => devices}/rx-softmmu.mak (100%)
 rename default-configs/{ => devices}/s390x-softmmu.mak (100%)
 rename default-configs/{ => devices}/sh4-softmmu.mak (100%)
 rename default-configs/{ => devices}/sh4eb-softmmu.mak (100%)
 rename default-configs/{ => devices}/sparc-softmmu.mak (100%)
 rename default-configs/{ => devices}/sparc64-softmmu.mak (100%)
 rename default-configs/{ => devices}/tricore-softmmu.mak (100%)
 rename default-configs/{ => devices}/unicore32-softmmu.mak (100%)
 rename default-configs/{ => devices}/x86_64-softmmu.mak (100%)
 rename default-configs/{ => devices}/xtensa-softmmu.mak (100%)
 rename default-configs/{ => devices}/xtensaeb-softmmu.mak (100%)
 delete mode 100644 default-configs/hppa-linux-user.mak
 delete mode 100644 default-configs/i386-bsd-user.mak
 delete mode 100644 default-configs/i386-linux-user.mak
 delete mode 100644 default-configs/m68k-linux-user.mak
 delete mode 100644 default-configs/microblaze-linux-user.mak
 delete mode 100644 default-configs/microblazeel-linux-user.mak
 delete mode 100644 default-configs/mips-linux-user.mak
 delete mode 100644 default-configs/mips64-linux-user.mak
 delete mode 100644 default-configs/mips64el-linux-user.mak
 delete mode 100644 default-configs/mipsel-linux-user.mak
 delete mode 100644 default-configs/mipsn32-linux-user.mak
 delete mode 100644 default-configs/mipsn32el-linux-user.mak
 delete mode 100644 default-configs/nios2-linux-user.mak
 delete mode 100644 default-configs/or1k-linux-user.mak
 delete mode 100644 default-configs/ppc-linux-user.mak
 delete mode 100644 default-configs/ppc64-linux-user.mak
 delete mode 100644 default-configs/ppc64abi32-linux-user.mak
 delete mode 100644 default-configs/ppc64le-linux-user.mak
 delete mode 100644 default-configs/riscv32-linux-user.mak
 delete mode 100644 default-configs/riscv64-linux-user.mak
 delete mode 100644 default-configs/s390x-linux-user.mak
 delete mode 100644 default-configs/sh4-linux-user.mak
 delete mode 100644 default-configs/sh4eb-linux-user.mak
 delete mode 100644 default-configs/sparc-bsd-user.mak
 delete mode 100644 default-configs/sparc-linux-user.mak
 delete mode 100644 default-configs/sparc32plus-linux-user.mak
 delete mode 100644 default-configs/sparc64-bsd-user.mak
 delete mode 100644 default-configs/sparc64-linux-user.mak
 create mode 100644 default-configs/targets/aarch64-linux-user.mak
 create mode 100644 default-configs/targets/aarch64-softmmu.mak
 create mode 100644 default-configs/targets/aarch64_be-linux-user.mak
 create mode 100644 default-configs/targets/alpha-linux-user.mak
 create mode 100644 default-configs/targets/alpha-softmmu.mak
 create mode 100644 default-configs/targets/arm-linux-user.mak
 create mode 100644 default-configs/targets/arm-softmmu.mak
 create mode 100644 default-configs/targets/armeb-linux-user.mak
 create mode 100644 default-configs/targets/avr-softmmu.mak
 create mode 100644 default-configs/targets/cris-linux-user.mak
 create mode 100644 default-configs/targets/cris-softmmu.mak
 create mode 100644 default-configs/targets/hppa-linux-user.mak
 create mode 100644 default-configs/targets/hppa-softmmu.mak
 create mode 100644 default-configs/targets/i386-bsd-user.mak
 create mode 100644 default-configs/targets/i386-linux-user.mak
 create mode 100644 default-configs/targets/i386-softmmu.mak
 create mode 100644 default-configs/targets/lm32-softmmu.mak
 create mode 100644 default-configs/targets/m68k-linux-user.mak
 create mode 100644 default-configs/targets/m68k-softmmu.mak
 create mode 100644 default-configs/targets/microblaze-linux-user.mak
 create mode 100644 default-configs/targets/microblaze-softmmu.mak
 create mode 100644 default-configs/targets/microblazeel-linux-user.mak
 create mode 100644 default-configs/targets/microblazeel-softmmu.mak
 create mode 100644 default-configs/targets/mips-linux-user.mak
 create mode 100644 default-configs/targets/mips-softmmu.mak
 create mode 100644 default-configs/targets/mips64-linux-user.mak
 create mode 100644 default-configs/targets/mips64-softmmu.mak
 create mode 100644 default-configs/targets/mips64el-linux-user.mak
 create mode 100644 default-configs/targets/mips64el-softmmu.mak
 create mode 100644 default-configs/targets/mipsel-linux-user.mak
 create mode 100644 default-configs/targets/mipsel-softmmu.mak
 create mode 100644 default-configs/targets/mipsn32-linux-user.mak
 create mode 100644 default-configs/targets/mipsn32el-linux-user.mak
 create mode 100644 default-configs/targets/moxie-softmmu.mak
 create mode 100644 default-configs/targets/nios2-linux-user.mak
 create mode 100644 default-configs/targets/nios2-softmmu.mak
 create mode 100644 default-configs/targets/or1k-linux-user.mak
 create mode 100644 default-configs/targets/or1k-softmmu.mak
 create mode 100644 default-configs/targets/ppc-linux-user.mak
 create mode 100644 default-configs/targets/ppc-softmmu.mak
 create mode 100644 default-configs/targets/ppc64-linux-user.mak
 create mode 100644 default-configs/targets/ppc64-softmmu.mak
 create mode 100644 default-configs/targets/ppc64abi32-linux-user.mak
 create mode 100644 default-configs/targets/ppc64le-linux-user.mak
 create mode 100644 default-configs/targets/riscv32-linux-user.mak
 create mode 100644 default-configs/targets/riscv32-softmmu.mak
 create mode 100644 default-configs/targets/riscv64-linux-user.mak
 create mode 100644 default-configs/targets/riscv64-softmmu.mak
 create mode 100644 default-configs/targets/rx-softmmu.mak
 create mode 100644 default-configs/targets/s390x-linux-user.mak
 create mode 100644 default-configs/targets/s390x-softmmu.mak
 create mode 100644 default-configs/targets/sh4-linux-user.mak
 create mode 100644 default-configs/targets/sh4-softmmu.mak
 create mode 100644 default-configs/targets/sh4eb-linux-user.mak
 create mode 100644 default-configs/targets/sh4eb-softmmu.mak
 create mode 100644 default-configs/targets/sparc-bsd-user.mak
 create mode 100644 default-configs/targets/sparc-linux-user.mak
 create mode 100644 default-configs/targets/sparc-softmmu.mak
 create mode 100644 default-configs/targets/sparc32plus-linux-user.mak
 create mode 100644 default-configs/targets/sparc64-bsd-user.mak
 create mode 100644 default-configs/targets/sparc64-linux-user.mak
 create mode 100644 default-configs/targets/sparc64-softmmu.mak
 create mode 100644 default-configs/targets/tilegx-linux-user.mak
 create mode 100644 default-configs/targets/tricore-softmmu.mak
 create mode 100644 default-configs/targets/unicore32-softmmu.mak
 create mode 100644 default-configs/targets/x86_64-bsd-user.mak
 create mode 100644 default-configs/targets/x86_64-linux-user.mak
 create mode 100644 default-configs/targets/x86_64-softmmu.mak
 create mode 100644 default-configs/targets/xtensa-linux-user.mak
 create mode 100644 default-configs/targets/xtensa-softmmu.mak
 create mode 100644 default-configs/targets/xtensaeb-linux-user.mak
 create mode 100644 default-configs/targets/xtensaeb-softmmu.mak
 delete mode 100644 default-configs/tilegx-linux-user.mak
 delete mode 100644 default-configs/x86_64-bsd-user.mak
 delete mode 100644 default-configs/x86_64-linux-user.mak
 delete mode 100644 default-configs/xtensa-linux-user.mak
 delete mode 100644 default-configs/xtensaeb-linux-user.mak
-- 
2.26.2


