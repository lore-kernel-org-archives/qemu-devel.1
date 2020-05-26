Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3B0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835652073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9/yVh1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835652073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdX9V-0001p5-E8
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7K-0006VG-IY
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:30 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e]:33181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7J-000282-Sa
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:30 -0400
Received: by mail-ed1-x52e.google.com with SMTP id e10so17247357edq.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GJZJp2sUev4P2OYPMJf40xfwPWSp/WELJ2N4SonYgN8=;
 b=H9/yVh1Ea3r4O5g3QsiVXymo65bzW/pbrwz2dWwGI4+Dsz2BT7xgzZexQ2jGyegjj2
 RC2iKzk6VLUGAYwJ8vNF3GnrhgHiS3YyoEq5sym9EL48LZ+oDEgzH7T7IEsyKsazzLqd
 nIMjIca+uED5+whSW5LIVBcTHUi0XwEz7cjdqXXpf0UP+K35W55GBPmriqjfJhByh3Gs
 0D0i4BlfwU7t8+xcPusuRrMM/yeCj5tDvCBhs0RBfAC5PoTgYKsacvnJq/Tp7S/KXx2d
 u/Jl0yvs5wqi8dggR+voWytHDeEUlkH/3I7a4GzScqwZmUUckpg9LeYoKoNYMWfYIiJv
 AvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=GJZJp2sUev4P2OYPMJf40xfwPWSp/WELJ2N4SonYgN8=;
 b=rh/atPjCg1uwYkGmML0OBPcVTqxPwdCn8Up4dom2SK6O8WfViisJThGDupZnHEdv00
 tm1TAAmTBRxyjHxnLxMONiS5saQuQpq/CNZQR5UvHu9izVKNsMzfYkGgIR7J0E3ShDs9
 VMBYXxLS6pP+pDSZySgW/C9/3aWEJLLUiYjpywqb3zr23XBGiG9KxsQufKeCMsXE7KpN
 cgqbwz/yoky+7CJ8zfYoMZfPrkElRotxl7mKzSeH1XqXKzeMpROlrkb3lTtBwtgb95/+
 2a8R6I6eai54plVoXISRaiEIhE8jtBslcyieVR/v46t8K3rzbJ7f05PnRvb8xsyfOH0Q
 iA6w==
X-Gm-Message-State: AOAM531MGz6Y5GUxtgIaSoDwb3Y7pXbp7hnNpK9dPy87E7VzjD7ZN9vh
 bPv51R7/TEApAMOOFO2Dn91fsKSJF80=
X-Google-Smtp-Source: ABdhPJxMpbrGuvqC9Ngfycz+M225ctWb9sFsG3EBE1hKYe6TUgJGeR+NTUrkO/yBfyu2k4BARUTJSg==
X-Received: by 2002:aa7:db45:: with SMTP id n5mr18440918edt.147.1590490048209; 
 Tue, 26 May 2020 03:47:28 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id c27sm3342597ejd.19.2020.05.26.03.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 03:47:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/14] hw/mips: patch queue for 2020-05-26
Date: Tue, 26 May 2020 12:47:12 +0200
Message-Id: <20200526104726.11273-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x52e.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the current state of my hw/mips/next tree.

- MAINTAINERS updated to welcome Huacai Chen and Jiaxun Yang,
  and update Aleksandar Rikalo's email address,

- Trivial improvements in the Bonito64 North Bridge and the
  Fuloong 2e machine,

- MIPS Machines names unified without 'mips_' prefix.

The following patches need review:

- #6  "hw/pci-host/bonito: Map the different PCI ranges more detailled"
- #10 "hw/mips/fuloong2e: Fix typo in Fuloong machine name"

Aleksandar Markovic (3):
  hw/mips: Rename malta/mipssim/r4k/jazz files
  hw/mips/malta: Add some logging for bad register offset cases
  MAINTAINERS: Change Aleksandar Rikalo's email address

Huacai Chen (1):
  MAINTAINERS: Add Huacai Chen as fuloong2e co-maintainer

Philippe Mathieu-Daudé (10):
  hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonito North Bridge
  hw/pci-host/bonito: Fix DPRINTF() format strings
  hw/pci-host/bonito: Map peripheral using physical address
  hw/pci-host/bonito: Map all the Bonito64 I/O range
  hw/pci-host/bonito: Map the different PCI ranges more detailled
  hw/pci-host/bonito: Better describe the I/O CS regions
  hw/pci-host/bonito: Set the Config register reset value with
    FIELD_DP32
  hw/mips/fuloong2e: Move code and update a comment
  hw/mips/fuloong2e: Fix typo in Fuloong machine name
  hw/mips/mips_int: De-duplicate KVM interrupt delivery

 docs/system/deprecated.rst               |  5 ++
 docs/system/target-mips.rst              |  2 +-
 default-configs/mips64el-softmmu.mak     |  2 +-
 hw/isa/vt82c686.c                        |  2 +-
 hw/mips/{mips_fulong2e.c => fuloong2e.c} | 48 ++++++-------
 hw/mips/{mips_jazz.c => jazz.c}          |  0
 hw/mips/{mips_malta.c => malta.c}        | 14 ++--
 hw/mips/mips_int.c                       | 11 +--
 hw/mips/{mips_mipssim.c => mipssim.c}    |  0
 hw/mips/{mips_r4k.c => r4k.c}            |  0
 hw/pci-host/bonito.c                     | 87 +++++++++++++++++++-----
 tests/qtest/endianness-test.c            |  2 +-
 .mailmap                                 |  3 +-
 MAINTAINERS                              | 26 +++----
 hw/mips/Kconfig                          |  3 +-
 hw/mips/Makefile.objs                    | 10 +--
 hw/pci-host/Kconfig                      |  5 ++
 hw/pci-host/Makefile.objs                |  2 +-
 18 files changed, 142 insertions(+), 80 deletions(-)
 rename hw/mips/{mips_fulong2e.c => fuloong2e.c} (91%)
 rename hw/mips/{mips_jazz.c => jazz.c} (100%)
 rename hw/mips/{mips_malta.c => malta.c} (99%)
 rename hw/mips/{mips_mipssim.c => mipssim.c} (100%)
 rename hw/mips/{mips_r4k.c => r4k.c} (100%)

-- 
2.21.3


