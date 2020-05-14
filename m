Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39A7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7067420643
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yh69AKjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7067420643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJRh-0000XV-Fk
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJPp-0006nH-Ef
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:09 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d]:39426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJPo-0007Kc-MP
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:09 -0400
Received: by mail-lj1-x22d.google.com with SMTP id u6so4787915ljl.6
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nslBjmjjb5KYVHFB1WwajBujV0mgFXW5eqYEf7sSWeY=;
 b=Yh69AKjp6AAhgOAvICC+xbVlN6k8ND1rRSsDIQ4iAispG9gyMvSTcqffj5N635G2mS
 zJ+5dRl2Z3ZVll9gDNsWA4JvDo/xmlKk9QYYY8vboYAQRF7lTm3ClIxNduG6wyPO+vY+
 Tr1w97iiWh2X3eqVmhK9uFD81SvaJGjFOXSfzhveP6KJIYo/cXvcTlrB8fTAZdnNFwqt
 lmUJA/MdqqKS5RZxIpg3+Gy6iTHTKB3pA0WP4onkb2v9xlFofAtE2pWasKBinxnvyydT
 Gk2F7h7rz2NBExsWGY4085F8fFGxlsqSAtTs+TCFIhKD+UxFIgM3uCADNwDTzRAxSGOl
 IZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nslBjmjjb5KYVHFB1WwajBujV0mgFXW5eqYEf7sSWeY=;
 b=BTzE/ag41EpAXqhAtwLt3Loe0QHY06e2UxqTCiQB/8MWyz18ckwCI/DSzILhn5x1J/
 5+2rdez80Fs5lk4s1iz91yHtOd9cFeDPHJzfuv19TPdmTRw/teHbIjfceRVbIzx64mrN
 1l1F1JZe9M6POx18Yfy92k4E53vwYk1d5Qmkfugghp8z1x/pueDnoEasHB1zVQ6aImKx
 2UupKxHwbUs1FM2oyx5KZx/2SPFKUZwCNDHg9S2tRmBw2HEQx25uLBnUX40pv+NrQ/eU
 xTTSMPdwi+2naqy9UkXlXTjOuIUbZegqMxV8dMrNq8lWT4TO5QwwpwZYbUmX4cUGcW+N
 TpXg==
X-Gm-Message-State: AOAM531dCzjSMdcd9rTj/mcGscWSwsjPBbeBEdVhKr7MoCVqS/rnAeBP
 hz9zNavqsn+M5T+NlnUddWSfzeh60zA=
X-Google-Smtp-Source: ABdhPJyMGHEKaUhvKZHLCc1EAu+dxKa2240jX1KYIKTHWiQFb2GM3Iq3boRE2I62phfdE8clR9aW+w==
X-Received: by 2002:a2e:b0d6:: with SMTP id g22mr3933360ljl.232.1589484066259; 
 Thu, 14 May 2020 12:21:06 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id h3sm2427257lfk.3.2020.05.14.12.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 12:21:05 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/17] target/mips: FPU and other cleanups and improvements
Date: Thu, 14 May 2020 21:20:30 +0200
Message-Id: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
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

Finally, there is a patch that frees mips_malta.c from
checkpatch warnings.

v1->v2:

  - added more demacroing

Aleksandar Markovic (17):
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
  hw/mips: Convert Malta "ifdef 0"-ed code to comments

 hw/mips/mips_malta.c     |  20 +-
 target/mips/fpu_helper.c | 658 +++++++++++++++++++++++++++------------
 target/mips/internal.h   |   1 -
 target/mips/msa_helper.c |  77 +++--
 4 files changed, 517 insertions(+), 239 deletions(-)

-- 
2.20.1


