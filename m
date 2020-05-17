Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8C5C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844D9206D5
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJgtx/nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844D9206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaFXn-0005qa-LU
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 05:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFWr-00043x-Ac
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:17 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b]:42225)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFWq-0001me-9n
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:17 -0400
Received: by mail-lj1-x22b.google.com with SMTP id d21so6610546ljg.9
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nyf49ODgF84i+/dzRfNOm+K42T8A/TX3LGX7vPGWYAs=;
 b=VJgtx/nqcC//Mpi+5Yj9njBvOFZaqnzmcDis0cpIq14zdgd1J3AeeEr9wcVuajwf6S
 hXStuKkAzIsS88nN128fwJRbtz99Agv+thYTKcHkEUUqzrgF0W5XjCi/A9yt76lG0cJd
 eAKosC2fkszfaadOT9StrB2yWEOSN2uq83HfTR4dehYDCEkJJosfljxTCQGSvL2jTNRf
 dS4TSkSwTX2eTIiDbKjp/QgBPd7EFnEyxJjJxQfTNoGprl8d2SjIKdGQU7zZIHm9I7c7
 Q5cUDYxrA7n6Lz4FCQmynz/awP8ccjo31sRnToD/5tQpR8hHtVEsk41glwkrgBpEzUeN
 W1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nyf49ODgF84i+/dzRfNOm+K42T8A/TX3LGX7vPGWYAs=;
 b=XxX+m/fu+qtffaAXZQCe1a9pwvM9UJqPt8z0LqaAeElNdWCmGgKud4x8B04LiEOsnn
 Efv77SL+OhmaWDSPfaAH9weoh44e83sw6/vs3uxCmiwvSP0U8qZgPQXBcyxNXs2aqKpn
 iuBqpMSZIvNO6IbSvq1J/RDmgveVki9+s0OkhlHvmIZp7sTfY4EW8aO6yjiE6x1raTQf
 gV/ScW0KP9UpDMk853Mvt9NERHqzZdT8vBOJftfrDTHqEguO0tDibBmm8r8bO1a0ZraI
 fgKXDDZME5VnNKSTokKud73K/k/CFRv5/acY46qftyCLLELTPfZ2FxyChCv2Q6qxkvpb
 r4vA==
X-Gm-Message-State: AOAM5303c6lfuU82oMjLt4mBertr2Tv6x/xKlI0xgZOAdNu21kAeZrYu
 YNu69eLzlrJ1ocFnjww6GeQzE5ANzGc=
X-Google-Smtp-Source: ABdhPJz6A3NXvXvQVufBIg0V/VfdOFK75yQ2kUFvlPASrWslg+A3gtNQdYyihdYoNL07l98X1ZtKpg==
X-Received: by 2002:a2e:9586:: with SMTP id w6mr4189686ljh.274.1589707453779; 
 Sun, 17 May 2020 02:24:13 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id l2sm3872138ljg.89.2020.05.17.02.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 02:24:13 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/19] target/mips: FPU and other cleanups and improvements
Date: Sun, 17 May 2020 11:23:38 +0200
Message-Id: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x22b.google.com
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series contains mostly cosmetic FPU cleanups aimed to make
source code recognition easier for tools like gdb, gcov, calgrind,
and others.

There is also a patch that refactors conversion from ieee to mips
fp exception flags. This refactoring will improve the performance
of almost all fp-related mips instructions, albait very modestly
(less that one percent).

There is a patch that introduces some logging in mips_malta.c.

There is a patch on change of Aleksandar Rikalo's email.

Finally, there is a patch on renaming some files in hw/mips folder.

v3->v4:

  - corrected some spelling and style mistakes in commit messages
  - added a patch on renaming some files in hw/mips

v2->v3:

  - changed Malta patch to perform logging
  - added change of Aleksandar Rikalo's email

v1->v2:

  - added more demacroing

Aleksandar Markovic (19):
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
  hw/mips: Rename malta/mipssim/r4k/jazz files in hw/mips

 .mailmap                              |   3 +-
 MAINTAINERS                           |  12 +-
 hw/mips/Makefile.objs                 |   8 +-
 hw/mips/{mips_jazz.c => jazz.c}       |   0
 hw/mips/{mips_malta.c => malta.c}     |  14 +-
 hw/mips/{mips_mipssim.c => mipssim.c} |   0
 hw/mips/{mips_r4k.c => r4k.c}         |   0
 target/mips/fpu_helper.c              | 658 ++++++++++++++++++--------
 target/mips/internal.h                |   1 -
 target/mips/msa_helper.c              |  77 ++-
 10 files changed, 523 insertions(+), 250 deletions(-)
 rename hw/mips/{mips_jazz.c => jazz.c} (100%)
 rename hw/mips/{mips_malta.c => malta.c} (99%)
 rename hw/mips/{mips_mipssim.c => mipssim.c} (100%)
 rename hw/mips/{mips_r4k.c => r4k.c} (100%)

-- 
2.20.1


