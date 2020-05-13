Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D856CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6494320675
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHbamM+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6494320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYp24-0001gl-Hi
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 06:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYp12-0008NL-J0
 for qemu-devel@nongnu.org; Wed, 13 May 2020 06:53:32 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133]:41588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYp11-0000OU-TB
 for qemu-devel@nongnu.org; Wed, 13 May 2020 06:53:32 -0400
Received: by mail-lf1-x133.google.com with SMTP id a9so13216664lfb.8
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 03:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=u669Kr81MGZtXGrsziBzjo9t5/vvvw+9mun4n76uc+c=;
 b=SHbamM+7RDzC2KGNb6SP3mmOSNV4iA2vx6jpKVjjY7j+BEqfCiQlvuLUwdR4M1fQFX
 +kkcjIivJSWnMLR2SKc0ESWUvtZUCCgZR+NVI2uhVb9zRLU3P1XAPP/9QkGY+HTeEEqB
 LKGkwg9e455JlZePSfBGALspT9YofFUYS2iPmJ4lb8KZw54GFiQxoRpUlrW5/8Zyv8Wu
 bZLbygayR4u4D66RtcBteEqryH5dpgZkcGbgVfku/QzGUKwQcEK5XtfrG+12JVGJpm7R
 4MBX/keYqMO5DjBQZnBulZv9VyLnwW26OZrfxwnv8iX269e0pF8NVeUxqtBGeRwemewg
 3sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=u669Kr81MGZtXGrsziBzjo9t5/vvvw+9mun4n76uc+c=;
 b=TUR3mIqV6njEqR3M/7yFpaBJuJG8kdHc8hdo7MA+2EjaxWkXEtnMVHp0hstNSSyKjF
 PbEw+6AdZnMh+dYnL5h/JE0+EUGq2AsrCTYQYgt1GyQSbnP0lzvRNfwj5VdkwSXM+1vS
 RU79hDM0G2Lb4+U0raPkvJ/DKhz68/Lpjk45btvRSRA5XyyBcLtthrrchxpwxqNYItyb
 CI/Ye8iWCV3en4aieVDc0xsIwBCb0l4LyActEBhuJ+VOC8lO4SdgfkhuViiV4/wcmzlK
 dK9kk5D1WgWctd8tcZUmlEQKeAzJCMpu1erKVyZvxFpwxqqASAquknWaZdHtTGEF908L
 MF5w==
X-Gm-Message-State: AOAM5336uRuE3jEzS7wphc/RtyVPLOPM8kk/Yajl+4yPRkDD/UebongE
 tworrb0Xm7trIgjv+5/I7u2L06KPNT4=
X-Google-Smtp-Source: ABdhPJxsex2xWOvgfVFnCbJlm15rTvS9v2JThrYnmlgEC3QvFI30b/+N6L4BDV6RuFYr3TaQEJILiw==
X-Received: by 2002:a19:4b57:: with SMTP id y84mr17778441lfa.214.1589367209991; 
 Wed, 13 May 2020 03:53:29 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id z64sm15749417lfa.50.2020.05.13.03.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 03:53:29 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/12] target/mips: FPU and other cleanups and improvements
Date: Wed, 13 May 2020 12:52:55 +0200
Message-Id: <20200513105307.22638-1-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x133.google.com
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

Finally, there is a patch that frees mips_malta.c from
checkpatch warnings.

Aleksandar Markovic (12):
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
  target/mips: fpu: Refactor conversion from ieee to mips exception
    flags
  hw/mips: Convert Malta "ifdef 0"-ed code to comments

 hw/mips/mips_malta.c     |  20 +-
 target/mips/fpu_helper.c | 458 +++++++++++++++++++++++++++++----------
 target/mips/internal.h   |   1 -
 target/mips/msa_helper.c |  77 ++++---
 4 files changed, 402 insertions(+), 154 deletions(-)

-- 
2.20.1


