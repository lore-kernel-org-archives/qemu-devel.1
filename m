Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EE9C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390222081A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXaXSAne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390222081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jam6l-0007lY-B5
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam5i-00064p-Iy
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:26 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136]:35457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam5h-0002F5-QV
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:26 -0400
Received: by mail-lf1-x136.google.com with SMTP id 82so9227129lfh.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R3CEJfPQjDAimWb5Us2RCtj0zShMQnJepugAQA0pPSA=;
 b=jXaXSAneU8ZAFGMvBNxzLrnap0NsEkMEFRVrQHwXMxrMlF7pQ/Kh7WpKqGMm2a7qKP
 296mWOUDxLLGZXwGyMZi8gwjGtZkYVEj489naPsjKKVBddmZQr8YEn1aeZzjBB+J5+Jv
 z0NFyfnrOBegCgmYKBgM9EdF8VDzMIv1S1idn8bmPCZRVKyp4UwDiTx7eRDLl8s1YSTF
 JN7rNjauRPdYdPiQ5OaXwk6rJBZko2bTcKt8A1zlRbHcYMDb/yMqnaKQUvXuJyrZUkCs
 1KVQcEJtndmVcuvbXoWP9E4DgXLHVznThAf8vLCWpiq6D/vbhBZYSCN2RoDxtUHg558m
 9Atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R3CEJfPQjDAimWb5Us2RCtj0zShMQnJepugAQA0pPSA=;
 b=Cx7IKn0h1uSOr+jUcKMqjiZftDYvfj7AyQa0crvFteddQ2EwsE3k/S5SDyApoBzGvB
 NG5p4LDfrtMwczG0SS3iAcfqVW2p1dK5Ay0zLMjT2R65NXynlQcWImT4ae5a8ScjTVVV
 OuGjj8MVZw9yeOjSBGZmE+pgpfq53RbBOB1bHxcrgleWocxvK7AZUu5AhHJoUMuGGCnJ
 cuPB+eqOlQ6IH++FSVSwTyWaLA7QmDwHarsWjqdoCeewenTgTgbHulceoKFR6l53ihr5
 ZRvLm1iUpqA0kuMi/n8dDPqEZaZEesjWA5GgaObgrHncVcMtXwZzjX3pIzWZVpSOKDgA
 T+Tw==
X-Gm-Message-State: AOAM532IjsJ1kFxltuR7vKIOf4NV3qnUUQVfp/Bf11cTxL81D/3ojaL+
 8sVOc/EG0txgXOvasyUMBhNH68Oj8z4=
X-Google-Smtp-Source: ABdhPJx7nn4lka4LZFIqd1nUKFpuyXS/zBg0YsCkJlGHhDr/DWW7K9XQuBGm7JnuA1HfFeaOTlIOuA==
X-Received: by 2002:a05:6512:110d:: with SMTP id
 l13mr12776085lfg.93.1589832623532; 
 Mon, 18 May 2020 13:10:23 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id c78sm8700591lfd.63.2020.05.18.13.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 13:10:23 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/21] target/mips: MSA,
 FPU and other cleanups and improvements
Date: Mon, 18 May 2020 22:08:59 +0200
Message-Id: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x136.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series contains some pathces that split heprers in msa_helper.c.
It will make easier for debugging tools to display involved source
code, and also introduces some modest performance improvements gains
for all involved MSA instructions.

Also, this series contains mostly cosmetic FPU cleanups aimed to make
source code recognition easier for tools like gdb, gcov, calgrind,
and others.

There is also a patch that refactors conversion from ieee to mips
fp exception flags. This refactoring will improve the performance
of almost all fp-related mips instructions, albait very modestly
(less that one percent).

There is a patch that introduces some logging in mips_malta.c.

There is a patch on change of Aleksandar Rikalo's email.

Finally, there is a patch on renaming some files in hw/mips folder.

v5->v6:

  - excluded a patch that was included by mistake

v4->v5:

  - corrected some spelling and style mistakes in commit messages
  - added changing MAINTAINERS too while renaming files
  - added two patches on splitting helpers in msa_helper.c

v3->v4:

  - corrected some spelling and style mistakes in commit messages
  - added a patch on renaming some files in hw/mips

v2->v3:

  - changed Malta patch to perform logging
  - added change of Aleksandar Rikalo's email

v1->v2:

  - added more demacroing

Aleksandar Markovic (21):
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
  MAINTAINERS: Change Aleksandar Rikalo's email address
  target/mips: msa: Split helpers for MADDV.<B|H|W|D>
  target/mips: msa: Split helpers for MSUBV.<B|H|W|D>
  hw/mips: Add some logging for bad register offset cases
  hw/mips: Rename malta/mipssim/r4k/jazz files in hw/mips

 .mailmap                              |   3 +-
 MAINTAINERS                           |  21 +-
 hw/mips/Makefile.objs                 |   8 +-
 hw/mips/{mips_jazz.c => jazz.c}       |   0
 hw/mips/{mips_malta.c => malta.c}     |  14 +-
 hw/mips/{mips_mipssim.c => mipssim.c} |   0
 hw/mips/{mips_r4k.c => r4k.c}         |   0
 target/mips/fpu_helper.c              | 658 ++++++++++++++++++--------
 target/mips/helper.h                  |  12 +-
 target/mips/internal.h                |   1 -
 target/mips/msa_helper.c              | 235 +++++++--
 target/mips/translate.c               |  38 +-
 12 files changed, 712 insertions(+), 278 deletions(-)
 rename hw/mips/{mips_jazz.c => jazz.c} (100%)
 rename hw/mips/{mips_malta.c => malta.c} (99%)
 rename hw/mips/{mips_mipssim.c => mipssim.c} (100%)
 rename hw/mips/{mips_r4k.c => r4k.c} (100%)

-- 
2.20.1


