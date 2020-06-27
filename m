Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F23C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 19:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133182071A
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 19:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bt0DHor8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133182071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpGtf-00065T-Cb
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 15:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jpGrc-0002MW-54
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 15:51:48 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a]:35436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jpGra-0003sj-CA
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 15:51:47 -0400
Received: by mail-ed1-x52a.google.com with SMTP id e15so9491107edr.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 12:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=ePUAFhNTI5bjt2w/0LW26QVHrfylfhtZt/SOq+UY2b4=;
 b=Bt0DHor84ZfyJq2fRQDVUJ50PrCq+Cr4ce5mFOF9qZsC4D52GvyjA1kMVG5a6ilSml
 VHbQUIh4/5pY+ldwJNu/aTPVt0RrWCQa0Dbt3pOT9gKvrstempGs/DuNTGxNcTsyqS6c
 Ct8gauiLwoXCOX6ZJmaOL/mRYknuKAzPYBKwHy8Th9YJN5BdwBfyGhUhsoA8N5p0Bx4Y
 qmde7TrwO2wWR25/oRSdBe32Mzq4vyVZkUL5unExb2K+QbRRqbZLZqsyIHSLxLz7MJ0T
 M0J22zdHXgPQaLOc7Ar2poRjyNOEJmdeCUX3SzTgFtZEOjjJTwGnNr+d+5do+Z2QECVY
 6TlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ePUAFhNTI5bjt2w/0LW26QVHrfylfhtZt/SOq+UY2b4=;
 b=b9hOEen3VEg1tgMSdSb0jC8qxQ0ZDMGs+04x3qL/7vvDN3Vg/bpuoMpRE4XComaCSa
 OkWc50s0fJ/GYblZSlWSBXHIvfHSxPpHTx5MPZEbuy1S/WuRmjkNO6sMnpz02JAkPA8b
 AXERbHZsVXN+/G7Y6M4/jADclEMA3O79cmxAdyjC8pkD7l0ngipnh0saMNZ1PB+JsD3/
 5zU5pt7SOcnVt0laPwagcznnsD6p2AvVYLRJXksy0/Rm7Hf1KD8+d4/XLQkFTAvRDTU3
 2H1Bjq/nGcPdB5sBhY9Rs0gNhNCQ2hsHFB/hp/tbFqFySHoI+eHzwP72eIjbwM/IY6dI
 n9pA==
X-Gm-Message-State: AOAM531WeYuD22heARp2J+SI+FcDh6NDyt89SADipV8kCCq1OAZkpgtM
 veFra5fjrR0pYY5YPb6bq9TsLwls
X-Google-Smtp-Source: ABdhPJyso+5NFQjGx/vo8ysNwRopmGsPAfJzlegiWAhjL2e4tonQCHcp7qRb8xvsGJ2fgFMu/Y4BLg==
X-Received: by 2002:aa7:c245:: with SMTP id y5mr10032925edo.189.1593287504096; 
 Sat, 27 Jun 2020 12:51:44 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id y11sm5298734ejw.63.2020.06.27.12.51.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 27 Jun 2020 12:51:43 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 0/6] MIPS + TCG Continuous Benchmarking queue for June 27th,
 2020
Date: Sat, 27 Jun 2020 21:51:37 +0200
Message-Id: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ed1-x52a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 553cf5d7c47bee05a3dec9461c1f8430316d516b:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200626' into staging (2020-06-26 18:22:36 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-gsoc-queue-jun-27-2020

for you to fetch changes up to 53fb8bfb93487c0fd88b0babb9a52ec8d67cff7b:

  MAINTAINERS: Add 'Performance Tools and Tests' subsection (2020-06-27 20:15:07 +0200)

----------------------------------------------------------------

MIPS + TCG Continuous Benchmarking queue for June 27th, 2020

   Highlights:

     - add two additional elements of Loongson-3 support
     - add first two Python scripts as a part of a GSoC project

   Notes:

     - several checkpatch warnings on updating MAINTAINERS should be ignored

----------------------------------------------------------------

Ahmed Karaman (2):
  scripts/performance: Add topN_perf.py script
  scripts/performance: Add topN_callgrind.py script

Aleksandar Markovic (1):
  MAINTAINERS: Add 'Performance Tools and Tests' subsection

Huacai Chen (3):
  hw/mips: Implement the kvm_type() hook in MachineClass
  hw/intc: Add Loongson LIOINTC support
  MAINTAINERS: Add Loongson-3 maintainer and reviewer

 target/mips/kvm_mips.h                |  11 ++
 hw/intc/loongson_liointc.c            | 242 ++++++++++++++++++++++++++++++++++
 target/mips/kvm.c                     |  26 ++++
 MAINTAINERS                           |  13 ++
 hw/intc/Kconfig                       |   3 +
 hw/intc/Makefile.objs                 |   1 +
 scripts/performance/topN_callgrind.py | 140 ++++++++++++++++++++
 scripts/performance/topN_perf.py      | 149 +++++++++++++++++++++
 8 files changed, 585 insertions(+)
 create mode 100644 hw/intc/loongson_liointc.c
 create mode 100755 scripts/performance/topN_callgrind.py
 create mode 100755 scripts/performance/topN_perf.py

-- 
2.7.4


