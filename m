Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A3EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B86020643
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFLIzDPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B86020643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalhN-0006hE-Iz
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaleL-0002Jh-QB
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:09 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:39400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaleL-0004Pb-60
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:09 -0400
Received: by mail-lf1-x142.google.com with SMTP id h26so9159067lfg.6
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 12:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RNwaBalSq7hVemOS6/MpEJ85P0luwo/qn8uoV+N9FFs=;
 b=QFLIzDPHlZl49qDdOprl/2WKv0B9+qomdG/O3hWFwN9Oe0y488B+bqsz6tavLYrhDk
 XtAjsbpaqGwCm9Ey63TwZCbm3H6snTlBDSxtOSIaGvNh6ZTWWZMg+JM8vgBh06ubx1o5
 4bpuTlNmpXszgyMqTllQPnRejYFn+XHpcXsXOdZZchF+3sS7J4wpq3itPoIm4+HHPDND
 CEPuybiC1xfSrsale1cPi3fuhP4hewI8l4dC6J5I4PzuZGs1/oTRuCci9upi95Q6VG5f
 uI1Lv3woD5/doXPtYWXIRPqYn+sR/e2qiJwgFbJiQGg/E+swiabLYtynpoxnJuurNfYf
 DVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RNwaBalSq7hVemOS6/MpEJ85P0luwo/qn8uoV+N9FFs=;
 b=bjucniVDSBsBRBbFLe56aOcJPcnzQl1Q1xDNpbWQJIhSO0td9Xr0SQiBmZ1uvTF+Yc
 u06TGJKYnR7i5p0B71ztWwMV8GGjPsg3VQT2AQ1mIpSaWq2GFfcmMCw4AO5JJIXVMFpT
 Tp6DtK3lOnPqA9G+Ejsbh1TQsgDSjwRp0rU0ZmseEOPqU0al8/rFhntAWdSnZ/c/TY09
 1l4BFXXQeATHCcv57+0l9EMHuSQNC7QlOfHQphOUHGNJqKG9s0Ux6yXprjNWlnxQqmu5
 c5AahjGS2ye2WwAgZODC/Vjgha//cZuf5pT4RoQ0MvV+BllTNkoPG9duYE6pJnnS8aG5
 qH4g==
X-Gm-Message-State: AOAM530M4JPak8ek0SAKUUGnHgsZS7c+luknuddua82EHyBzfp77KT9T
 sy1oDkguNrkH8UQoJq7/CQSuMyKJANA=
X-Google-Smtp-Source: ABdhPJzT0oWHguKIE4hdzSFza7r1HgPjXc9mlftoLk7/W/jMH2uJJ0HkWB7rjGsfhVM6AIJVsaQzSg==
X-Received: by 2002:ac2:58d0:: with SMTP id u16mr12509585lfo.114.1589830926782; 
 Mon, 18 May 2020 12:42:06 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id r15sm7593128lfp.34.2020.05.18.12.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 12:42:06 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/22] target/mips: MSA,
 FPU and other cleanups and improvements
Date: Mon, 18 May 2020 21:41:27 +0200
Message-Id: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x142.google.com
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

Jafar Abdi (1):
  hw/tpm: fix usage of bool in tpm-tis.c

-- 
2.20.1


