Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FABC38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF2B206F5
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qncMx9ob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF2B206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXt6T-00010M-9O
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 17:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt4p-00070L-8l
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:35 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:33108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt4o-00015I-Gz
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:35 -0400
Received: by mail-ed1-x533.google.com with SMTP id y24so6222388edo.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 14:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FJGorN9zwrmzluMgeEbFQqnwJ6QZpvnZDFLiGHsF68g=;
 b=qncMx9obNveZRt5rc5WI8aRHmWa2J9ITFsVZnlpeWrXozVCCoKnx1H8sCJ8LmKdGDF
 HKKEMTi/7s+IO1SxckTzUQcUinirFqXeqt7TIl7CmmuXls/Y3Hu6SxZDLiEkG14lz/AD
 s0R7kHD79zpLAgVypUFLoWVUvrnXgUB1LjVGhXWy+xTBJ/hb0sfYP6z5R8UN33j0A1Q1
 RPbnF4B4RPW/II6lwYbY32Q2KeXUJf3WhffevlOWJUWIG+Dd818GkCFuzIX+vz8AioVM
 6J0t3wJSe9E02up63b2NK9tHDdbwvumtUPS/vWk1rzwGFFnLZ5tjRox255X/JPxphtFq
 lRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=FJGorN9zwrmzluMgeEbFQqnwJ6QZpvnZDFLiGHsF68g=;
 b=ZpMo/Ome6zAIVJ2c3f3Td5zFDBHDS0mr+za1+F9tMcpvid5Bmf/PVL2bl1jl5egp1o
 /Eu32VA23ph6f+akzL/ZmmZa1j1CJDF3X4gF8N0KGoGwyPrqyFbBq7WynLxm8uclpVU+
 CsPwhriQfo1uHdxTj5IGY9IxI5DsnBoLUkhKVJ2BEdg9xBz3K9C0rJG9QmVixwbAEliB
 0zT7hcCIs0GX7YJdCROmS/pHOJCESZlANGhFZfix+P50itW7aitDlGjOPtBfJJ9J2yNS
 R5TvT0PECyhIxMSeYXVj+3KN8vjOHYmAiZ6LiTYeS7fnnNXerbxOVAYxja4e3LYPKLnq
 C2xw==
X-Gm-Message-State: AGi0PuZl08/IVQppysPDB9Lnr2xmzcPcs/EPTJp5DRUs/lmEkowAEb57
 MZ5oDrKI+XmRqjeCM1tYPJBBNuBHDYM=
X-Google-Smtp-Source: APiQypLDY420MS9gdiZP4w2/zNxY+tUVquDp2h9NR0eko9bVnKZUQeofAd29HuaBdkO3YiPFfDrW8w==
X-Received: by 2002:aa7:d1d6:: with SMTP id g22mr11178470edp.36.1589144492737; 
 Sun, 10 May 2020 14:01:32 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d15sm921152ejr.50.2020.05.10.14.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 14:01:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/12] hw/mips/fuloong2e: PoC to fix hang after reboot
Date: Sun, 10 May 2020 23:01:16 +0200
Message-Id: <20200510210128.18343-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PMON firmware behave differently regarding it is run
after a cold/warm reset. A simple bit flip fix the issue,
however we need to know the type of reset to set it.
Currently QEMU only supports COLD reset.

This series contains various of my current Fuloong queue,
- Welcome Huacai Chen as co-maintainer,
- Fix typo in machine name,
- Few cleanups in Bonito64,
- Report various Bonito64 accesses as UNIMP,
- Proof-of-concept fix for the reset bit.

The last patch is not for merging, but is included to see
if the Multi-phase reset mechanism can fix the problem.

Regards,

Phil.

Huacai Chen (1):
  MAINTAINERS: Add Huacai Chen as fuloong2e co-maintainer

Philippe Mathieu-Daudé (11):
  hw/mips/fuloong2e: Rename PMON BIOS name
  hw/mips/fuloong2e: Move code and update a comment
  hw/mips/fuloong2e: Fix typo in Fuloong machine name
  hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonito North Bridge
  hw/pci-host/bonito: Fix DPRINTF() format strings
  hw/pci-host/bonito: Map peripheral using physical address
  hw/pci-host/bonito: Map all the Bonito64 I/O range
  hw/pci-host/bonito: Map the different PCI ranges more detailled
  hw/pci-host/bonito: Better describe the I/O CS regions
  hw/pci-host/bonito: Set the Config register reset value with
    FIELD_DP32
  POC hw/pci-host/bonito: Fix BONGENCFG value after a warm-reset

 docs/system/target-mips.rst              |  2 +-
 default-configs/mips64el-softmmu.mak     |  2 +-
 hw/isa/vt82c686.c                        |  2 +-
 hw/mips/{mips_fulong2e.c => fuloong2e.c} | 41 +++++------
 hw/pci-host/bonito.c                     | 92 +++++++++++++++++++-----
 tests/qtest/endianness-test.c            |  2 +-
 MAINTAINERS                              |  6 +-
 hw/mips/Kconfig                          |  3 +-
 hw/mips/Makefile.objs                    |  2 +-
 hw/pci-host/Kconfig                      |  5 ++
 hw/pci-host/Makefile.objs                |  2 +-
 11 files changed, 114 insertions(+), 45 deletions(-)
 rename hw/mips/{mips_fulong2e.c => fuloong2e.c} (91%)

-- 
2.21.3


