Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0D0C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0DB206DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMu7rJnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0DB206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbuMG-0003pm-9l
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 18:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuKb-0002MA-Br
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:42:45 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:55698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuKZ-0002DT-Pc
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:42:45 -0500
Received: by mail-wm1-x329.google.com with SMTP id c9so6430900wml.5
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 15:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YvANeuoK1uvTk2XyQ3vmx9swqngQarRde/A0BHGtv6E=;
 b=WMu7rJnJgDWjzG9d9pFru+u5mXk+7jr+n4aldDKiMeFB6/o+8J6e0x+RjYrB+14S6V
 Xtw8VYOo8jOj3deysxSp7jr8ufxUlJIClW4pxaE8KDQJjodu0TuUpz4PAA3mWJnqWSHM
 r7jsC0NHeolIwKLK7jEV+8ALuebUcI8+EqGXSXeQiB7N82Fc8DI2H4JxhabVrfNwaf/T
 BVJ0lc7rY7pfDxCfeW/xPH1HRYSIm+DV0SndAS3/k5b93xPIHfj62khFxcfjGyKBEufU
 wJUpqsV3Ff4OhC5P9ifVB3CJcErtMOp5vb9kRwb/QeKvuJ5npYyvRPXPTvph/I/QDu3y
 rnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=YvANeuoK1uvTk2XyQ3vmx9swqngQarRde/A0BHGtv6E=;
 b=B+ZPYTzgIs32QfaUO4NztQ2Wpwt/NcIOU+1cZ7gppsugOABva6qW9behMIDrre/UoD
 ni0Wt60AGW/5yePjDbJWj19vCPN0BtZmLp47TYS9IyAUxi7j6PAxhvrlY8VC0aXeoCtd
 LDrr6iKqaPYLA0KICC1JKk5ZBJVaz9zwcI5D6I2EaAHwKane8qjb2nuzq599n56SlL5S
 uQj8001zdadUgAYzPXF7VE1NJWpusKeQe7PZw1IuBYRSXPPSHErHg+v8v9bYuKVMXvVF
 RGKYm0AbAL6pHbpkKVcm2yQBLCdyzTMFe3yvIHjJXpFalY/xH97Dt2LwOdV0fyUcn3tC
 dkkA==
X-Gm-Message-State: AOAM532MTz4Oi9H0S/6xfT37mxd9Ao7OMxj9YkvGyb26sG3KP9m0SIfG
 dibdvd53qI01uWyZejTivYHD8vlpybI=
X-Google-Smtp-Source: ABdhPJw4RyykWnAdq1MPT/lzX/tyIuddNDF8HUv4GxyqlJ91MTo8nybrXZcArjR4Zn9MxNiGQq/qQw==
X-Received: by 2002:a1c:b346:: with SMTP id c67mr11345191wmf.105.1604878962036; 
 Sun, 08 Nov 2020 15:42:42 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id n14sm11452193wrt.8.2020.11.08.15.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 15:42:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] MIPS patches for 5.2-rc1
Date: Mon,  9 Nov 2020 00:42:31 +0100
Message-Id: <20201108234234.2389789-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3493c36f0371777c62d1d72b205b0eb6117e2156=
:=0D
=0D
  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20201106' into st=
aging (2020-11-06 13:43:28 +0000)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/philmd/qemu.git tags/mips-fixes-20201109=0D
=0D
for you to fetch changes up to bf4ee88ab63fcf2dcb75f0d68cc6c8d2edb68212:=0D
=0D
  hw/mips/boston: Fix memory leak in boston_fdt_filter() error-handling pat=
hs (2020-11-09 00:40:44 +0100)=0D
=0D
----------------------------------------------------------------=0D
MIPS patches queue=0D
=0D
- Deprecate nanoMIPS ISA=0D
- Fix PageMask with variable page size (Huacai Chen)=0D
- Fix memory leak in boston_fdt_filter (Coverity CID 1432275, Peter Maydell=
)=0D
=0D
CI jobs results:=0D
. https://cirrus-ci.com/build/5439131968864256=0D
. https://gitlab.com/philmd/qemu/-/pipelines/213403385=0D
. https://travis-ci.org/github/philmd/qemu/builds/742312387=0D
----------------------------------------------------------------=0D
=0D
Jiaxun Yang (1):=0D
  target/mips: Fix PageMask with variable page size=0D
=0D
Peter Maydell (1):=0D
  hw/mips/boston: Fix memory leak in boston_fdt_filter() error-handling=0D
    paths=0D
=0D
Philippe Mathieu-Daud=C3=A9 (1):=0D
  target/mips: Deprecate nanoMIPS ISA=0D
=0D
 docs/system/deprecated.rst | 23 +++++++++++++++++++++++=0D
 target/mips/cpu.h          |  1 +=0D
 hw/mips/boston.c           | 10 ++++------=0D
 target/mips/cp0_helper.c   | 27 +++++++++++++++++++++------=0D
 MAINTAINERS                |  6 +++++-=0D
 5 files changed, 54 insertions(+), 13 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

