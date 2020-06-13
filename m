Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F93C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 15:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A462078A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 15:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5ZLsfPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A462078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk7zk-0002N9-9b
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 11:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jk7yo-0000tv-US
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 11:21:58 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:35250)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jk7ym-0002jn-GX
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 11:21:58 -0400
Received: by mail-wr1-x430.google.com with SMTP id x14so12799202wrp.2
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2020 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WaBN+FmDWdeYlV8cMJnzKCcNoJ/dy1FLLXbLhh8Fal0=;
 b=u5ZLsfPFNJAWM7gB8LK5HxVHlHsPm8SLb+8qZwU2yaP863N9RN4z+JuCeX3VwiVT3A
 GyzmjOVJTP/Y9EHQ+QEErZwZCT1EHdA7wUarrKuAQbim+xb2hyQNEXXcuaWGKAtYUe5m
 /wp3Wy+dAUSFwNmP3gwBCIDwFpOZ60OhLJfINCpMb0PO3JgmEoO/84ODj4/9ilDswhji
 l495aLfXvDilDkB9t/GSi3m5KYi81Upd23mwcZSCJWO1u5QYLn4SnTqoskDbb0tR5Tis
 MGEn73SGpruvaJFh03gK0nU07maWWy1PthMk1u3/Sm80US2fiXbFKlV0cqqua6bqmhal
 5vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WaBN+FmDWdeYlV8cMJnzKCcNoJ/dy1FLLXbLhh8Fal0=;
 b=YFbOor8xaW3cl2hBaMpW9A8t03XM4clC3+rz7bHISLVKAYncQZFDDPzQIdzSJz81xE
 WQCj4wa4fJz+iJAwkaT5q0IQIZPpBLbDh6E9Xh7HOLRKjinrVd2XjZOfSWEX4CtFueVS
 e2RoLLUqJZrKynV6UMAhV9Bb3jFA6JbzRdGg4lDuGCD98LYRMXIPo1xLKUGX1BPEdmFV
 z8rRzVNOb7VxNcIloAje3OOrs05ymjtl3mXVI7GriMDZsTah/QBJ3ZtCrsr6tkmxAitY
 goAunJ9GMzf4NpohPZB+7IzMX9NqJv/m3QuiUmye7XRdsMeFw29ZTgjXKQ6xXPFPue31
 HjOw==
X-Gm-Message-State: AOAM531JTR6U9wZo8WeSVJ+3h6xTnJb8CO00dGXGQUcCDBOJJuHoqaKx
 f18awERQkDovBWumaMEVSNXrI0U1uBA=
X-Google-Smtp-Source: ABdhPJw8Y/SOgqDsL0fVN/nqp/STMxkoNVbqXNeokS1Yn5G3VMv5Vmgj87YiQH4hkZq3NI+ZiQaoeQ==
X-Received: by 2002:a5d:6b8c:: with SMTP id n12mr20318027wrx.61.1592061709705; 
 Sat, 13 Jun 2020 08:21:49 -0700 (PDT)
Received: from localhost.localdomain (net212-32-245-109.mbb.telenor.rs.
 [109.245.32.212])
 by smtp.gmail.com with ESMTPSA id 67sm16045399wrk.49.2020.06.13.08.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2020 08:21:48 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 00/14] target/mips: MSA,
 FPU and other cleanups and improvements
Date: Sat, 13 Jun 2020 17:21:19 +0200
Message-Id: <20200613152133.8964-1-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x430.google.com
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series contains some patches that split heprers in msa_helper.c.
It will make easier for debugging tools to display involved source
code, and also introduces some modest performance improvements gains
for all involved MSA instructions.

v7->v8:

  - added six new demacroing patches

v6->v7:

  - excluded patches that have been already upstreamed
  - added six new demacroing patches

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

Aleksandar Markovic (14):
  target/mips: msa: Split helpers for MADDV.<B|H|W|D>
  target/mips: msa: Split helpers for MSUBV.<B|H|W|D>
  target/mips: msa: Split helpers for DPADD_S.<H|W|D>
  target/mips: msa: Split helpers for DPADD_U.<H|W|D>
  target/mips: msa: Split helpers for DPSUB_S.<H|W|D>
  target/mips: msa: Split helpers for DPSUB_U.<H|W|D>
  target/mips: msa: Split helpers for DOTP_S.<H|W|D>
  target/mips: msa: Split helpers for DOTP_U.<H|W|D>
  target/mips: msa: Split helpers for SUBS_S.<B|H|W|D>
  target/mips: msa: Split helpers for SUBS_U.<B|H|W|D>
  target/mips: msa: Split helpers for SUBSUS_U.<B|H|W|D>
  target/mips: msa: Split helpers for SUBSUU_S.<B|H|W|D>
  target/mips: msa: Split helpers for SUBV.<B|H|W|D>
  target/mips: msa: Split helpers for MULV.<B|H|W|D>

 target/mips/helper.h     |   73 ++-
 target/mips/msa_helper.c | 1296 ++++++++++++++++++++++++++++++--------
 target/mips/translate.c  |  200 +++++-
 3 files changed, 1271 insertions(+), 298 deletions(-)

-- 
2.20.1


