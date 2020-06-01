Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B424DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADD2206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSNDMVHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADD2206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjPx-000141-LF
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjOa-0007sU-6H
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:18:24 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjOZ-0007ll-Bj
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:18:23 -0400
Received: by mail-wr1-x42c.google.com with SMTP id p5so5351272wrw.9
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=wgwj03KL0WjOS7N2QAqcl9k2+YR3+3N4uxwgRB/mLME=;
 b=WSNDMVHQ1tGGL6uxfK/33Kq16vGV7dCD5dzwMSpaJyrV+vk9Pa5x4Jtvdk/ktpe+3E
 Xw0lMFbTVF0jgvDMbFxLR0VKkcKGSlLrJWT2E4YCt80gjiHvBzA8GIh9CrDWHsf8eelC
 3Qs8LoHc5256iNDVL0ON1NasylsLoXN4pvaUjWaxrburJKvOZQzoEnGsDIEEnOhuAwRY
 2Hfa68Pft9D0xOynfSlMesgGsVMv4ZYZpFdWeIDA0Jn/WDYBGfiWyTa+OId7eIKwnRP2
 BChu3dkevAZ8GmEVe6vOW1+cGtByQ1Za/i0MSMeGNfjFVrm77LzhPJkTVQJnldECJRdi
 409Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wgwj03KL0WjOS7N2QAqcl9k2+YR3+3N4uxwgRB/mLME=;
 b=JUaGR4Ivql0466FoS1dYKiw9bm4IkBF+ttWqxRbblgxcNHyWfo3Sk00GjyhZrWrvL4
 ACj3lBxnibK4b5hloylVrOfjpI5kxsmDMpA3sbfgql2iApFNoHSnclFz1YZ9MP4UUrgM
 nEaouKTmSEzwHHGDiIOjfdr5D/v852MwC2aRZGoS4F4AWiTGL0j0MRR95GNvCyViCq5g
 g4onjMUebeKKCG8Cm4mdoBa4JDDANCmshBPrXtGgNExzfXdTa2h3sKwPCBvMM0gDhC6v
 lC4Qwg3vcE0lVPsgvxdbc3lR5MEWenm++8Att8nvuv2JjyebgUnIYoX6PiCTdugV6pO+
 tWaQ==
X-Gm-Message-State: AOAM530ysGXmDN2zlVo6oPJ6wvcws2G0krYx8UVGs+CC4ShwkIRgbjIn
 ot3k3X7ImWdT2t5kIGwRtNcpNo4h6To=
X-Google-Smtp-Source: ABdhPJyMa65SLRfuji/TbqeMJ2nkXaz8DDOevKCXzHBJE4O/23sTMPhJ3e0vesKezQVFaEJy49Skpw==
X-Received: by 2002:adf:9c84:: with SMTP id d4mr20396156wre.327.1591013899939; 
 Mon, 01 Jun 2020 05:18:19 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id y185sm12332136wmy.11.2020.06.01.05.18.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 05:18:19 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] MIPS queue for June 1st, 2020
Date: Mon,  1 Jun 2020 14:18:12 +0200
Message-Id: <1591013898-23391-1-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: peter.maydell@linaro.org, aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4ec2a1f53e8aaa22924614b64dde97321126943e:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-05-30' into staging (2020-05-31 20:43:45 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu 

for you to fetch changes up to a08d60bc6c2b6469368fff3d38dd5ddd16dd36be:

  hw/mips: fuloong2e: Set preferred page size to 16KB (2020-06-01 13:28:21 +0200)

----------------------------------------------------------------

MIPS queue for June 1st, 2020

  Highlights:

  - setting Fuloong 2E preffered page size to a different value
  - preparation for adding KVM support for Longsoon 3
  - other minor changes
  - a checkpatch warning is known and should be ignored

----------------------------------------------------------------

Huacai Chen (6):
  tests/Makefile: Fix description of "make check"
  configure: Add KVM target support for MIPS64
  hw/mips: Add CPU IRQ3 delivery for KVM
  target/mips: Add more CP0 register for save/restore
  target/mips: Support variable page size
  hw/mips: fuloong2e: Set preferred page size to 16KB

 configure               |   2 +-
 target/mips/cpu-param.h |   5 ++
 hw/mips/fuloong2e.c     |   1 +
 hw/mips/mips_int.c      |   2 +-
 target/mips/kvm.c       | 212 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/mips/machine.c   |   6 +-
 tests/Makefile.include  |   2 +-
 7 files changed, 225 insertions(+), 5 deletions(-)

-- 
2.7.4


