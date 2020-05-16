Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44582C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA372053B
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yhx/HSoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA372053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ja0uP-0004e2-5w
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 13:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0tL-0002pM-6u
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:31 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d]:45368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0tK-0008Lm-Cj
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:30 -0400
Received: by mail-lj1-x22d.google.com with SMTP id h4so5544591ljg.12
 for <qemu-devel@nongnu.org>; Sat, 16 May 2020 10:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z8k6tm9Ly4sFR2RE4me5mDxmbD5hIpSb5YT4uRszXms=;
 b=Yhx/HSoW5QyIezrFxLLP6Sd18BgOOcjJaM6QsXnA4HYPnPdHZSZIDCOAh2SCEZVqOp
 w6C3RiYmGI5r8tWjvBwzMMn74pY5FpecQoZ2NPL2y+qBoHTXd1u37PtqCmjXMNkk75gk
 7hDUCt/040KfnDpXZA+YFH4gncyK2h4S2zRLWTye6ktxmcu3ejjiXqgqFHmgw63k9iGK
 gm+bQJeZzpKpnHeMv22RLUk5cRSYL2diaH38LQ1lb2zUbn5C7eUESkwG1TBYoGMaZriI
 RxKCFTevajdJAqj0QKayF1DaBgMojR+egYxucQZ7Tx94xWAA0Eg11826L6Eyo389+acu
 YgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z8k6tm9Ly4sFR2RE4me5mDxmbD5hIpSb5YT4uRszXms=;
 b=KlC6O/AsogDqPNTscjiMrnn5531KL+DJTRX4cfn5Oy2VH1L8gKWYEJwq57OcRLl5G+
 cWd19KtoOj0YNZbMmUjtgV9hWUxSJ7rOiCDGDjx207IjvGUAcUye+4pxgtEbctgMVurV
 c6JN92TWHp6GV+j0gJGTw4ac7seKgtXGWwpXrbR2zB0zm5QbGbkLrWQOXtATu21VeirW
 m7q7dkWEHh+cD8AlT/KbHGG13DIh8lO5YujVmrv2lQbF1PNLYBQrwk0T0Lnwg/68YpjQ
 hHlnoSZlUjH0fSkQY7mTrkdlrkC/6cqrRBgVBNksWMPWyu46KGohmP/n2eSJCpm9W1dS
 a1dg==
X-Gm-Message-State: AOAM533N11x5KCQmSQuzsXwPCKFtywOSiIgy5gL7zafDEea2GivU6jP+
 1ksQ9aoaY0gAtUzVHYkG6Eo5Uh4MhsA=
X-Google-Smtp-Source: ABdhPJyanuDGRVBd5kUQ5IVohHbvlCxLRLpC3oWD1PT11B337FylN8nGnZ/j8sr72CTegcp4uqkfGw==
X-Received: by 2002:a2e:9e45:: with SMTP id g5mr6025873ljk.180.1589651187838; 
 Sat, 16 May 2020 10:46:27 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id i1sm3024759lja.3.2020.05.16.10.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2020 10:46:27 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/18] target/mips: FPU and other cleanups and improvements
Date: Sat, 16 May 2020 19:45:30 +0200
Message-Id: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x22d.google.com
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
Cc: aleksandar.rikalo@rt-rk.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series contains mostly cosmetic FPU cleanups aimed to
make source code recognition easier for tools like gdb, gcov,
calgrind, and others.

There is also a patch that refactors conversion from ieee to
mips fp exception flags. This refactoring will improve the
performance of almost all fp-related mips instructions, albait
very modestly (less that one percent).

There is a patch that introduces some logging in mips_malta.c.

Finally, there is a change of Aleksandar Rikalo's email.

v2->v3:

  - changed Malta patch to perform logging
  - added change of Aleksandar Rikalo's email

v1->v2:

  - added more demacroing


Aleksandar Markovic (18):
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
  hw/mips: Add some logging for bad register offset cases
  MAINTAINERS: Change Aleksandar Rikalo's email address

 .mailmap                 |   3 +-
 MAINTAINERS              |  12 +-
 hw/mips/mips_malta.c     |  14 +-
 target/mips/fpu_helper.c | 658 +++++++++++++++++++++++++++------------
 target/mips/internal.h   |   1 -
 target/mips/msa_helper.c |  77 +++--
 6 files changed, 519 insertions(+), 246 deletions(-)

-- 
2.20.1


