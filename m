Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54965C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 23:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24AB2217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 23:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBzSHgiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AB2217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu3Aq-0003Py-MA
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 18:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iu39F-0001df-PM
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iu39D-0004pQ-Dc
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:29 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:39672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iu39D-0004no-51
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 18:41:27 -0500
Received: by mail-pg1-x52d.google.com with SMTP id 4so2383353pgd.6
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 15:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to; bh=l8zeeHKnAmjl/9UeIFXH4k1lG1fkY11IGAeo43g+xvU=;
 b=VBzSHgiFsSbLVaiwVPP+GhxosWfqeaOKrSrhLCxRlqQFs/VCkLrYKI8w1QO+opsUHZ
 aNe7TgSS74xARjz7k/lZ49JpNEJJ3NAfvktIvEYr6PICKoTEyVDk9B9+aoY8QgU83hQX
 lzyqquPBTtOSY2lQQexPx7wPw4tSkWKIjaG2qDg5doWOFRHLlYfwf7uEL7NKzn9dSBUf
 aXwsfvl5i47VVr5MOlF59m4lUjEI+a5/Lc6VOY6mUFWLete3kaGJN84CS2IakkVkiAeF
 4CguSDoVu82xuXstFZkobsckGCYbsA3ssWVgs8mIcPDIqC4Zvu1PUnackd3J2mKbPIEw
 mcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=l8zeeHKnAmjl/9UeIFXH4k1lG1fkY11IGAeo43g+xvU=;
 b=SaxRUPctjYAFdYkjMduLQZW59AlOl3Kt3krPCZDPxUVd44g8oIM9E0nSZsYPeiz8A/
 ehkQjwukDKh1zttis8v77KuXGXNjwRdw4+ZgepRJzvGDryV548UWX3ED3tZPdTtWdfGe
 9yw8LXs3vYi0VqxVktGbN3DszEzLt1N4tqVbiVDHoIaAoWK7q8dqEbjFevL/CLoMmeDL
 F1GXPaxwvgB4kNMqPXxglEHY1nEMLDPWpgvyjztqPW1e41XJ+o/q/NJ2b1UgDtv23rO4
 w44ZLoGxS+hQ/lD1WnGkEAXeDSWol0DmI8ynFzbuiJLkjpj9wJ3Ty0peJBwbGrjpXYEo
 PWfg==
X-Gm-Message-State: APjAAAU2Twu/767xIzEyfB4EDkmvBwRR/o5sj+x2Ir2Ucf33tImKt4jU
 H/TGibYHTbLamfcuX010aqM9PqllUMA=
X-Google-Smtp-Source: APXvYqz0FMQ6LkO586ry0H/ATGwznPi3vu9JI85siGF2NwLc/nOU/1JCKDvV0epFbsPUXXHECwmWoA==
X-Received: by 2002:a62:e511:: with SMTP id n17mr6776464pff.187.1579650083283; 
 Tue, 21 Jan 2020 15:41:23 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id 13sm44327657pfi.78.2020.01.21.15.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 15:41:22 -0800 (PST)
Subject: [PULL] RISC-V Patches for the 5.0 Soft Freeze, Part 1
Date: Tue, 21 Jan 2020 14:56:57 -0800
Message-Id: <20200121225703.148465-1-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-devel@nongnu.org,       qemu-riscv@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 28b58f19d269633b3d14b6aebf1e92b3cd3ab56e:

  ui/gtk: Get display refresh rate with GDK version 3.22 or later (2020-01-16 14:03:45 +0000)

are available in the Git repository at:

  git@github.com:palmer-dabbelt/qemu.git tags/riscv-for-master-5.0-sf1

for you to fetch changes up to 82f014671cf057de51c4a577c9e2ad637dcec6f9:

  target/riscv: update mstatus.SD when FS is set dirty (2020-01-16 10:03:15 -0800)

----------------------------------------------------------------
RISC-V Patches for the 5.0 Soft Freeze, Part 1

This patch set contains a handful of collected fixes that I'd like to target
for the 5.0 soft freeze (I know that's a long way away, I just don't know what
else to call these):

* A fix for a memory leak initializing the sifive_u board.
* Fixes to privilege mode emulation related to interrupts and fstatus.

Notably absent is the H extension implementation.  That's pretty much reviewed,
but not quite ready to go yet and I didn't want to hold back these important
fixes.  This boots 32-bit and 64-bit Linux (buildroot this time, just for fun)
and passes "make check".

----------------------------------------------------------------
Pan Nengyuan (1):
      riscv/sifive_u: fix a memory leak in soc_realize()

ShihPo Hung (3):
      target/riscv: Fix tb->flags FS status
      target/riscv: fsd/fsw doesn't dirty FP state
      target/riscv: update mstatus.SD when FS is set dirty

Yiting Wang (1):
      riscv: Set xPIE to 1 after xRET

 hw/riscv/sifive_u.c                     | 1 +
 target/riscv/cpu.h                      | 5 +----
 target/riscv/csr.c                      | 3 +--
 target/riscv/insn_trans/trans_rvd.inc.c | 1 -
 target/riscv/insn_trans/trans_rvf.inc.c | 1 -
 target/riscv/op_helper.c                | 4 ++--
 target/riscv/translate.c                | 2 +-
 7 files changed, 6 insertions(+), 11 deletions(-)


