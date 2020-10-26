Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0955C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53739206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvCDkCJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53739206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXBxt-0004uZ-9m
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 19:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBvq-00033b-JR
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:29:42 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c]:35006)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBvo-0000Fe-Ax
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:29:41 -0400
Received: by mail-ed1-x52c.google.com with SMTP id w25so11583352edx.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 16:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B3z+MrFiIC1Wgl1oSMKymfnXVmy6zIDxT3JQyJHFCNk=;
 b=VvCDkCJ2h9be+AgeJ0UbhfQNObaIXHpLCNjzOVkqdi4l9Mvt8EWWIWw+v1ASQMd+td
 oXmIHngV6L6YCp9mt9rldGMpEp/4ck01P1zTVxoqeAB4pgwbjz2+sc+H01S0eglBUZUE
 FHmchF6PmRkOATXhAfpU1FOzEIr7qXxQdKqH10IV2Mgzemrcdy1aqouYnwHRED2Rc5Zr
 PXYDu1FtnuFLAlCWH7HXMcUdkbnv5k+G8g/xYHZDtq4m5/KjL2kxxnTWPemcUeKJSnYh
 YDSfHANR4lfYX1ofwOjTdYeOB/VEoVyMSUSp6ihJj3LM2EpKnhAMWYz1sapXWfDLpt2y
 SG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=B3z+MrFiIC1Wgl1oSMKymfnXVmy6zIDxT3JQyJHFCNk=;
 b=IH8l/AJTCeOlfioF3krcnQAPm1Jt/mmra05UwZzEiFVqsBi2k0bFAP0vHtrYreVJz9
 LRzH8ulqs/A2/TJ+71M/XCFcCvrq1RH3QrI94DfjrU3h55asPwFhVoUuypXNLJKYctB4
 NEX6UVAR/5BeIDBnACNOJ2scM402b47aeHlFLN6eSMReI5radioZUltuZ5rywpuiMMrY
 hW3cx39wPXynSXCdsVyeY228/wvJR/lN0O2bmKeSy2W04+0B0NlU+Iv8RRGKwUV+2oJw
 CSxE46dItySCoRh46gyznF+xFOI+4msCba0cc1lPatlNZiNXEY+kv108nrNbEEDDMBHe
 B4uQ==
X-Gm-Message-State: AOAM532Rqp0RcHGejWkH9BFLV2agAlnOw8EKE9xAXDX/+H6VpTwdFRqV
 MaDGbycvnEwtL+ItqCNfYR4i1ehDHNM=
X-Google-Smtp-Source: ABdhPJwhI0BOhEIdZZCzWGQKGCFgMjKH18eFU7r/sqicBMW+FXVi2iUzgKWLz3uVl3RSZl6RnwvsIg==
X-Received: by 2002:aa7:ce13:: with SMTP id d19mr2582286edv.68.1603754977624; 
 Mon, 26 Oct 2020 16:29:37 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id ce15sm6818360ejc.39.2020.10.26.16.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 16:29:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] Renesas patches for 2020-10-27
Date: Tue, 27 Oct 2020 00:29:27 +0100
Message-Id: <20201026232935.92777-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x52c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 1dc887329a10903940501b43e8c0cc67af7c06d5=
:=0D
=0D
  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sd-next-20201026=
' =3D=0D
into staging (2020-10-26 17:19:26 +0000)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/philmd/qemu.git tags/renesas-20201027=0D
=0D
for you to fetch changes up to 81c76433407a1c5b5560a3b8fb593671667e9b13:=0D
=0D
  target/rx: Fix Lesser GPL version number (2020-10-27 00:22:56 +0100)=0D
=0D
----------------------------------------------------------------=0D
Renesas patches (SH4 and RX)=0D
=0D
- Fix few warnings (Thomas Huth)=0D
- Fix typos (Lichang Zhao, Chetan Pant)=0D
=0D
CI jobs results:=0D
. https://cirrus-ci.com/build/6368903343374336=0D
. https://gitlab.com/philmd/qemu/-/pipelines/207919103=0D
. https://travis-ci.org/github/philmd/qemu/builds/739133105=0D
----------------------------------------------------------------=0D
=0D
Chetan Pant (1):=0D
  target/rx: Fix Lesser GPL version number=0D
=0D
Lichang Zhao (2):=0D
  target/sh4: fix some comment spelling errors=0D
  target/rx: Fix some comment spelling errors=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (1):=0D
  target/sh4: Update coding style to make checkpatch.pl happy=0D
=0D
Thomas Huth (3):=0D
  hw/timer/sh_timer: Coding style clean-up=0D
  hw/timer/sh_timer: Silence warnings about missing fallthrough=0D
    statements=0D
  hw/timer/sh_timer: Remove superfluous "break" statements=0D
=0D
Yoshinori Sato (1):=0D
  elf: Add EM_RX definition=0D
=0D
 include/elf.h          |  2 +=0D
 target/sh4/cpu.h       |  2 +-=0D
 target/rx/insns.decode |  2 +-=0D
 hw/timer/sh_timer.c    | 90 +++++++++++++++++++++++++++---------------=0D
 target/rx/op_helper.c  |  2 +-=0D
 target/rx/translate.c  |  2 +-=0D
 target/sh4/op_helper.c |  8 ++--=0D
 target/sh4/translate.c |  8 ++--=0D
 8 files changed, 74 insertions(+), 42 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

