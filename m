Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABCEC7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB7321849
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkBBahai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB7321849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hodmg-0006n6-70
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39938)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hodmN-00068W-CR
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hodmM-0006DL-6H
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:15 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:36823)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hodmM-0006Cq-0Y
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:14 -0400
Received: by mail-qk1-x744.google.com with SMTP id g18so24617851qkl.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 18:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=skKzECx68DbSks4Ras4twFIfw+We7wqGO33+W8HFOzc=;
 b=LkBBahaihQ2kTMdCPAj/beogOniZyP/yV0Mw/YgjW9MNLX7OegXFeUZQPBSKQSj722
 o2bvoDc6qwQnBZKrRUz0A0/c4cxDchgjIzgowfSoWk/uDrgJ0HlE2W/sFftJCD9kubiY
 NgJcAkCCZPCb8pAK0O+Kb4FUtI/bfXzUC8AoW770hArQlH6tD9mNC+/3FGZGf+/I+Hl3
 nu1cbwiycJsW67rytqPqGOZg6eVKpKo+AUFdtcpIJRqDl6U4/XEmDMl0FPnbMy9V7eEn
 mgz6TL45VAnZsjfFmESNOREN4MG1EjAZ+xXsu1+4xvNke1o7cvWYJHwacKIu5iKh/E9g
 c/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=skKzECx68DbSks4Ras4twFIfw+We7wqGO33+W8HFOzc=;
 b=TK9EBiIElTdpYegro0rp05guGflXb9yAnbVuxdzAqurwdCJ3TFRk/XtFNZR2K2Nod5
 rkrG0KQONDRSRKxinanf0Q+UizglBr9yUPPtJ/7nklxcSU1vrLWPtP4HeVPUKfospDnc
 6t6L651RfzvQ1IC/UenLHJunZj6c35JMVUEK1zCxo38cE6zJLnARr/oSUEdKUsC1kdmX
 hSL6iTM6Y2KqgIDZ9Yc3KWHBz5kal7NR4Ue6QWoWnTWrMoP9mKxtYK4HqvYPRnQ8NYKE
 /fo6ubzLlEyzlVm+HJDe4ng6aq2euRG0+okQsgT7zRxDiCFXWmhj7XxtJKY1hr8XSJRD
 G2iA==
X-Gm-Message-State: APjAAAVcRBfJbsiqeII6xHZuUPRWjKKaCnR30UJGd/GgrMIWatQyXn2O
 4XI28Od3mSncaUmHW6ZmdVoCR2JK
X-Google-Smtp-Source: APXvYqzJt6h+PET6nCqkZVfQ6d8EGE0QNXpBmw6hzzjgUXm8CaJUi4KO+KwnwLpjFj1SQ6ah1jqKJA==
X-Received: by 2002:a37:47d6:: with SMTP id
 u205mr37238298qka.214.1563584592950; 
 Fri, 19 Jul 2019 18:03:12 -0700 (PDT)
Received: from vanderson-lmcad.domain.name ([177.137.96.41])
 by smtp.googlemail.com with ESMTPSA id g10sm13405115qki.37.2019.07.19.18.03.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 18:03:11 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 22:02:28 -0300
Message-Id: <20190720010235.32444-1-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: [Qemu-devel] [PATCH v4 0/7] Measure Tiny Code Generation Quality
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
Cc: vandersonmr <vandersonmr2@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch is part of Google Summer of Code (GSoC) 2019.
More about the project can be found in:
https://wiki.qemu.org/Internships/ProjectIdeas/TCGCodeQuality

The goal of this patch is to add infrastructure to collect
execution and JIT statistics during the emulation with accel/TCG.
The statistics are stored in TBStatistic structures (TBStats)
with each TB having its respective TBStats.

We added -d tb_stats and HMP tb_stats commands to allow the control
of this statistics collection. And info tb, tbs, and coverset commands
were also added to allow dumping and exploring all this information 
while emulating.

Collecting these statistics and information is useful to understand
qemu performance and to help to add the support for traces to QEMU. 

vandersonmr (7):
  accel: introducing TBStatistics structure
  accel: collecting TB execution count
  accel: collecting JIT statistics
  accel: replacing part of CONFIG_PROFILER with TBStats
  log: adding -d tb_stats to control tbstats
  monitor: adding tb_stats hmp command
  monitor: adding info tbs, tb, and coverset

 accel/tcg/Makefile.objs      |   2 +-
 accel/tcg/tb-stats.c         | 489 +++++++++++++++++++++++++++++++++++
 accel/tcg/tcg-runtime.c      |   7 +
 accel/tcg/tcg-runtime.h      |   2 +
 accel/tcg/translate-all.c    |  93 ++++++-
 accel/tcg/translator.c       |   6 +
 disas.c                      | 108 ++++++++
 hmp-commands-info.hx         |  23 ++
 hmp-commands.hx              |  17 ++
 include/disas/disas.h        |   1 +
 include/exec/exec-all.h      |  15 +-
 include/exec/gen-icount.h    |   9 +
 include/exec/tb-context.h    |  12 +
 include/exec/tb-hash.h       |   7 +
 include/exec/tb-stats.h      | 113 ++++++++
 include/qemu/log-for-trace.h |   2 +
 include/qemu/log.h           |  16 ++
 linux-user/exit.c            |   4 +
 monitor/misc.c               | 111 ++++++++
 tcg/tcg.c                    | 114 +++-----
 tcg/tcg.h                    |  12 +-
 util/log.c                   |  99 ++++++-
 22 files changed, 1144 insertions(+), 118 deletions(-)
 create mode 100644 accel/tcg/tb-stats.c
 create mode 100644 include/exec/tb-stats.h

-- 
2.22.0


