Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B8FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3530C20774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2esih1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3530C20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihH3-00026v-Dw
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jih7D-0005sm-By
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:28:43 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jih7C-00016a-A6
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:28:42 -0400
Received: by mail-wr1-x42a.google.com with SMTP id x13so22026774wrv.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=W5S0XVqm1PdZq+jzEv1zdBRtTT47fmJwTvAyXY5SRCE=;
 b=h2esih1jBICvdggU0ucVBLWLWHbwTra0WnalJpR13fCBXTM0kovEDQNjRVMqJmYsBB
 BWw/Ft3TRtz5o1HnLZYOhFEVRND18MwT8lQxnX6WCQP0fXJuqnIznq46tjDE8MZgG8oF
 7w4qyulUYJ8c6Le2Lrj61BBBajhG0aIlUnniT1NK35nZH0wakBiWycbBrCmKOO4OZZFW
 cDvSxVBsNhkMsLFkRGZMvPdSkEkeLfKYnybx6e0B6f5+tfp14BsjuXirbqHhpTFpV3nu
 Z1WRS5eT63KRb85zdGRBe0ylPWRN1/IhRygEYv4/DSvwgvfF0850qNLcGP+WY4HD23Y/
 rx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=W5S0XVqm1PdZq+jzEv1zdBRtTT47fmJwTvAyXY5SRCE=;
 b=DC6WvSGJ2M2HoVQ+pNyUWmlVE0IAQsuc2rLNkPKW61J3SpnEjAZUiPZ6f89Tmukmjp
 JTqJRNjXBSS/6EFGnjvPyNT5i/6E+0SARfk6JBffvYlP/a+6Hm8VdZ4W1n6eBW1bFqhj
 EklmG5IDFmYvzAFtRC2H5X3/fE1nmFWYYq9FCBmrNuNzQaKMyKsGTPFOATgCcVkC4MpR
 B1LnaI+0CXhmr1Yv0YISXDSvdMJbLkxYDbuiDh/0M8Oio2scEBAyh2nDKNMS5cbebJA1
 +9mGSD55ghk1GT4neOQ3rwfrLF676Y4LCTt02Zfe3Jad3Ief63HEw63BvPNTwAUivoGi
 k93g==
X-Gm-Message-State: AOAM5325C++y+YmDqIMSdvClTxD+H9N5MDEbmCoTOkfRg4oasShgtQFq
 Ejadr6DnWAUiWLQy85Dr7U5IJORF
X-Google-Smtp-Source: ABdhPJyuvsLaI/gZ/ovIJinYGP0Pgcjl4J+rhOMTlJiVCIxB56zssEM3w6TwqviLXslqWIKPjHRqCw==
X-Received: by 2002:adf:b354:: with SMTP id k20mr5356090wrd.412.1591720119729; 
 Tue, 09 Jun 2020 09:28:39 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 23sm3643598wmo.18.2020.06.09.09.28.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jun 2020 09:28:39 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 00/20] MIPS queue for June 9th, 2020
Date: Tue,  9 Jun 2020 18:28:18 +0200
Message-Id: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

The following changes since commit 49ee11555262a256afec592dfed7c5902d5eefd2:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-request' into staging (2020-06-08 11:04:57 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-jun-09-2020

for you to fetch changes up to 6db06115d246ea6d24755657a98c185ed2a50210:

  target/mips: Enable hardware page table walker and CMGCR features for P5600 (2020-06-09 17:32:45 +0200)

----------------------------------------------------------------

MIPS queue for June 9th, 2020

Highlights:

  - Registring change of email address for two contributors
  - Cleanup and improvements of FPU helpers
  - Enabling some features of P5600
  - Adding two Loongson-3A CPU definitions
  - A checkpatch warning is known and should be ignored

----------------------------------------------------------------

Aleksandar Markovic (18):
  mailmap: Change email address of Filip Bozuta
  mailmap: Change email address of Stefan Brankovic
  target/mips: fpu: Demacro ADD.<D|S|PS>
  target/mips: fpu: Demacro SUB.<D|S|PS>
  target/mips: fpu: Demacro MUL.<D|S|PS>
  target/mips: fpu: Demacro DIV.<D|S|PS>
  target/mips: fpu: Remove now unused macro FLOAT_BINOP
  target/mips: fpu: Demacro MADD.<D|S|PS>
  target/mips: fpu: Demacro MSUB.<D|S|PS>
  target/mips: fpu: Demacro NMADD.<D|S|PS>
  target/mips: fpu: Demacro NMSUB.<D|S|PS>
  target/mips: fpu: Remove now unused UNFUSED_FMA and FLOAT_FMA macros
  target/mips: fpu: Demacro CLASS.<D|S>
  target/mips: fpu: Remove now unused FLOAT_CLASS macro
  target/mips: fpu: Demacro RINT.<D|S>
  target/mips: fpu: Remove now unused FLOAT_RINT macro
  target/mips: fpu: Name better paired-single variables
  target/mips: fpu: Refactor conversion from ieee to mips exception
    flags

Andrea Oliveri (1):
  target/mips: Enable hardware page table walker and CMGCR features for
    P5600

Huacai Chen (1):
  target/mips: Add Loongson-3 CPU definition

 target/mips/cpu.h                           |  32 +-
 target/mips/internal.h                      |   3 +-
 target/mips/mips-defs.h                     |  45 +-
 target/mips/fpu_helper.c                    | 658 +++++++++++++++++++---------
 target/mips/{lmi_helper.c => lmmi_helper.c} |   0
 target/mips/msa_helper.c                    |  77 ++--
 target/mips/translate.c                     |   2 +
 target/mips/translate_init.inc.c            |  95 +++-
 .mailmap                                    |   2 +
 target/mips/Makefile.objs                   |   2 +-
 10 files changed, 658 insertions(+), 258 deletions(-)
 rename target/mips/{lmi_helper.c => lmmi_helper.c} (100%)

-- 
2.7.4


