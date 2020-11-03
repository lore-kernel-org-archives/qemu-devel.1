Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC2BC388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C736221FB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHbvYqR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C736221FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka0B1-000396-JA
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka09e-0001Pi-Ee; Tue, 03 Nov 2020 12:31:34 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:38984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka09b-0007aa-Kn; Tue, 03 Nov 2020 12:31:34 -0500
Received: by mail-wr1-x434.google.com with SMTP id y12so19383612wrp.6;
 Tue, 03 Nov 2020 09:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OGe7LmXDmA7ZhWoq/eh/9/xncpJoEzNZlAd0PDxZhgU=;
 b=SHbvYqR14F7crSVw4JF3wmZNhx0fJRJVAYe4QVJpwRNOQwUx+iHYc357Of3wUCOM8r
 htrZ4g7YK30p6A1+o+x/VoV30DLhEf3biZ7Kzg3QR4np/bglFagHj2SaS2frf9hTRtVX
 ikfOi0fEX1OU8e9MGNtt/7DZz4HftD5BxTS28HqljahlK9+8SkjXHSx5PtT4Bk4UzhRB
 BSa+j+PgrjvYGea42hTjrWW0zB1wzwxXbwy/wlTLH1hTM7YiltVCElDA9ffJvyTWkIvw
 avtzni1Tiw4U0BfwjXYxQKZETmO9BddhBrabmBAhh//UcE4lMOrk9LMyQ6lA6b1/9CNy
 8IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=OGe7LmXDmA7ZhWoq/eh/9/xncpJoEzNZlAd0PDxZhgU=;
 b=oxSOtJkgLCT2E1leoKUN/Z5HcfDGnP45IKUbXBgFu4q3wVQLvsM3U44+IwBRkvcD61
 2/g0oxa8ZkcFaMKbmrwgEKjU72SJAI/ImRM++rxGUn/96NGqFhdrBdVmNI7MMdaLu2dS
 qfOs0iFte/rm0IBPuDoL8s2fDdB8PhoA46/jakXT7moRStGZRHk2BPB6KYkOsMqfJtS9
 ptCcCVi3opN52K1hgADkzPJLoWMePoKfyAwLMU9RK5UfcmHgN0pusa4vbRjvjl1t5pao
 QlEO7m+9mEEYf8f7mC4UR+G4viN7aCUlJr8lN6b0nE0sS96fM7dw04ovqhouNogwurL/
 OWwQ==
X-Gm-Message-State: AOAM532htEgUTYOBZntOMFyXZE0laly8mINasfb8ZOoviVEo11t8P0fb
 GYNZZyiFmEUpfMher/0B/L+W7m41ccM=
X-Google-Smtp-Source: ABdhPJwJ+M/QI4232QlwsgZeNd44Wm/+Ud7hAlvUirQ901Vp05r1I2SKOUY6XdlE4lvFBRZ4jOFzeA==
X-Received: by 2002:a5d:4e8f:: with SMTP id e15mr17555669wru.390.1604424689586; 
 Tue, 03 Nov 2020 09:31:29 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id s188sm3590837wmf.45.2020.11.03.09.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 09:31:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] Mips fixes patches
Date: Tue,  3 Nov 2020 18:31:21 +0100
Message-Id: <20201103173127.2704256-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Paul Burton <paulburton@kernel.org>,
 libvir-list@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 83851c7c60c90e9fb6a23ff48076387a77bc33cd=
:=0D
=0D
  Merge remote-tracking branch 'remotes/mdroth/tags/qga-pull-2020-10-27-v3-=
ta=3D=0D
g' into staging (2020-11-03 12:47:58 +0000)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/philmd/qemu.git tags/mips-fixes-20201103=0D
=0D
for you to fetch changes up to 8a805609d126ff2be9ad9ec118185dfc52633d6f:=0D
=0D
  target/mips: Add unaligned access support for MIPS64R6 and Loongson-3 (20=
20=3D=0D
-11-03 16:51:13 +0100)=0D
=0D
----------------------------------------------------------------=0D
MIPS patches queue=0D
=0D
- Removal of the 'r4k' machine (deprecated before 5.0)=0D
- Fix LGPL license text (Chetan Pant)=0D
- Support unaligned accesses on Loongson-3 (Huacai Chen)=0D
- Fix out-of-bound access in Loongson-3 embedded I/O interrupt=0D
  controller (Alex Chen)=0D
=0D
CI jobs results:=0D
. https://cirrus-ci.com/build/6324890389184512=0D
. https://gitlab.com/philmd/qemu/-/pipelines/211275262=0D
. https://travis-ci.org/github/philmd/qemu/builds/741188958=0D
=0D
----------------------------------------------------------------=0D
=0D
AlexChen (1):=0D
  hw/intc/loongson: Fix incorrect 'core' calculation in=0D
    liointc_read/write=0D
=0D
Chetan Pant (3):=0D
  hw/mips: Fix Lesser GPL version number=0D
  hw/mips/boston: Fix Lesser GPL version number=0D
  target/mips: Fix Lesser GPL version number=0D
=0D
Huacai Chen (1):=0D
  target/mips: Add unaligned access support for MIPS64R6 and Loongson-3=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (1):=0D
  hw/mips: Remove the 'r4k' machine=0D
=0D
 docs/system/deprecated.rst                    |  12 +-=0D
 .../devices/mips-softmmu-common.mak           |   1 -=0D
 include/hw/mips/cps.h                         |   2 +-=0D
 include/hw/misc/mips_cpc.h                    |   2 +-=0D
 include/hw/misc/mips_itu.h                    |   2 +-=0D
 include/hw/pci-host/xilinx-pcie.h             |   2 +-=0D
 hw/core/loader-fit.c                          |   2 +-=0D
 hw/intc/loongson_liointc.c                    |   4 +-=0D
 hw/mips/boston.c                              |   2 +-=0D
 hw/mips/cps.c                                 |   2 +-=0D
 hw/mips/r4k.c                                 | 318 ------------------=0D
 hw/misc/mips_cpc.c                            |   2 +-=0D
 hw/misc/mips_itu.c                            |   2 +-=0D
 hw/pci-host/xilinx-pcie.c                     |   2 +-=0D
 target/mips/cp0_helper.c                      |   2 +-=0D
 target/mips/dsp_helper.c                      |   2 +-=0D
 target/mips/fpu_helper.c                      |   2 +-=0D
 target/mips/gdbstub.c                         |   2 +-=0D
 target/mips/helper.c                          |   2 +-=0D
 target/mips/lmmi_helper.c                     |   2 +-=0D
 target/mips/mips-semi.c                       |   2 +-=0D
 target/mips/msa_helper.c                      |   2 +-=0D
 target/mips/op_helper.c                       |   2 +-=0D
 target/mips/translate.c                       |   6 +-=0D
 tests/qtest/cdrom-test.c                      |   2 +-=0D
 tests/qtest/endianness-test.c                 |   2 -=0D
 MAINTAINERS                                   |   6 -=0D
 hw/mips/Kconfig                               |  13 -=0D
 hw/mips/meson.build                           |   1 -=0D
 target/mips/translate_init.c.inc              |   2 +-=0D
 30 files changed, 32 insertions(+), 373 deletions(-)=0D
 delete mode 100644 hw/mips/r4k.c=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

