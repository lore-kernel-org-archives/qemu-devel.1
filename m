Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62282C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA662067B
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMEb/p8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA662067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji1Hy-0005Z9-9m
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 15:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1FV-0003oP-EN
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:29 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:34517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1FU-0004kP-Ck
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:29 -0400
Received: by mail-wr1-x432.google.com with SMTP id r7so15171085wro.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=kMOqrCKRdUKY+RqgLSNCHXhXWR/YTTo3Wqwst1bRs1M=;
 b=JMEb/p8Q6Hm/wqELl7dS68TV86p3TwpBtqvfgA7ZgQXylQuiKzyAD31a4659BEuY/c
 4uVf9MOiQA1WIlm8lZSwJy1BHJXDkynZ7m/Y7fFYGfdCZVFK5PvflKqb+d9XCX2IyYX4
 m2EhVLKogUR6UeLRx5mbLnSdLdCktNFisludRe/TwvcDLD9GVMCEvG5cRmSg+gZ8eoyL
 OIDtGzcjRoQcZNyvHlkL562tHK+3ZJmQvHej0UuesX6x+YAhP3ptVhR4W0n+w5WvSjPi
 R7uMBgeAxdFcz9TL2omCZkOatYfztF/Ghu93GyjqlR4EWQVPfSP8qU4ycvF4pmP5izcC
 p6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=kMOqrCKRdUKY+RqgLSNCHXhXWR/YTTo3Wqwst1bRs1M=;
 b=OotdgO09dwBtD/GQg8WdkjZZu2w9TIQELJ52Ar2msaF2AKUaenWxwDlI+flVpDQF7r
 ArcFDbhG0EgOBpLRkSwBIPaLIQtHtGz6wOLYQorUF1mkWFeWc0BKzmGxVb33+wBUGNx6
 BW01nYnUmoD756RibqG9VamvaPYQy79y2BCwWgwAmNvePzTrriGvQCZv9E8O1AAPuzzc
 AN2Gf0kPrhMZKtnL2JKMVL9jX5oVgGmUQptEgUy3cAlqX8cwDZR24HIbpCLCxBUQwexU
 2wk3kydO0JHv1AiktJhGu0Y21f2Mgnjot+mZZKmPTPHGN0a0dMsk0bVMPTKiAZvn0vwO
 ygHQ==
X-Gm-Message-State: AOAM533vTQTtPAwskbm5tDKGhrl53/3bGj+RSeKg4oJ70R/WqT0SBw/o
 RhLIHlvRsPiCLZ0VhnJqQ9awWkp6
X-Google-Smtp-Source: ABdhPJwvrHeIAQ/665A9GJM7GamIJ68H1etjiqSft6E5KHpNG9s/DWt3JcIh3pb+EJmHcuBOWCj0tA==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr20231154wrw.225.1591559186476; 
 Sun, 07 Jun 2020 12:46:26 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u130sm21091339wmg.32.2020.06.07.12.46.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jun 2020 12:46:26 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 00/21] MIPS queue for June 7th, 2020
Date: Sun,  7 Jun 2020 21:46:04 +0200
Message-Id: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x432.google.com
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 175198ad91d8bac540159705873b4ffe4fb94eab:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200605' into staging (2020-06-05 17:45:59 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-june-07-2020

for you to fetch changes up to ffbd8a88e8872d61fa5622a0075eddbe71951067:

  target/mips: Enable hardware page table walker and CMGCR features for P5600 (2020-06-07 21:34:14 +0200)

----------------------------------------------------------------

MIPS queue for June 7th, 2020

Highlights:

  - Registring change of email address for two contributors
  - Cleanup and improvements of FPU helpers
  - Enabling some features of P5600
  - Adding two Loongson-3A CPU definitions
  - Moving futher towards Loongson-3A KVM support
  - Two checkpatch warnings are known and should be ignored

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

Huacai Chen (2):
  hw/mips: Implement the kvm_type() hook in MachineClass
  target/mips: Add Loongson-3 CPU definition

 include/hw/mips/mips.h                      |   3 +
 target/mips/cpu.h                           |  32 +-
 target/mips/internal.h                      |   3 +-
 target/mips/mips-defs.h                     |  45 +-
 hw/core/null-machine.c                      |   4 +
 hw/mips/common.c                            |  55 +++
 target/mips/fpu_helper.c                    | 658 +++++++++++++++++++---------
 target/mips/{lmi_helper.c => lmmi_helper.c} |   0
 target/mips/msa_helper.c                    |  77 ++--
 target/mips/translate.c                     |   2 +
 target/mips/translate_init.inc.c            |  95 +++-
 .mailmap                                    |   2 +
 hw/core/Makefile.objs                       |   2 +-
 hw/mips/Makefile.objs                       |   2 +-
 target/mips/Makefile.objs                   |   2 +-
 15 files changed, 722 insertions(+), 260 deletions(-)
 create mode 100644 hw/mips/common.c
 rename target/mips/{lmi_helper.c => lmmi_helper.c} (100%)

-- 
2.7.4


