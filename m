Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC3BC11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F4A2080D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrMP0C/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F4A2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6E1C-000764-9b
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 08:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1j6DyN-0002gG-VG
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1j6DyM-0004SR-TN
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:40:35 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1j6DyM-0004S0-NP; Mon, 24 Feb 2020 08:40:34 -0500
Received: by mail-pj1-x1042.google.com with SMTP id n96so4231059pjc.3;
 Mon, 24 Feb 2020 05:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+BgHlUg/hUCo/8ZQNXk2OJTXVat9hUNnUrO9vW0g3z8=;
 b=KrMP0C/20z4qiekWgELLGrqlRcX0Fi4Hb5Q79RikkQ8rM872+dsF+0NrmqaFK1PWGC
 KQ7CgtXINLOWHMV7GnoO11tNnplR97FyA3V/gq9oAZglWL8Hhy0y7H1XdojGcikQY+WD
 +W+gynm8qpMVtrqbZL3F4WpcfgpKoYzXXETMrEb0iUrRTYwFqRE63LwE7eOYwFC3fhxi
 JFSLL9AzajEYnK2aF+XD1q/h2gK8/g1Ti0riQ/dUbNap+gO+tXqG1g7nkqber+jy2dEQ
 F4Jnvce2vBPn7oHsTFyAGJP1B7jlTOUExTJC5mQqOBlpb3WRY+mxWiJnuhnUDTDiwD6G
 BbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+BgHlUg/hUCo/8ZQNXk2OJTXVat9hUNnUrO9vW0g3z8=;
 b=hAj2gGB9wbUpHFx0yYTAOzGUcynh4jiNrdgWPWeRIlw4skSmRdKqRBpYcSNIWO3OoX
 iKrhI3cO74i8QQzdiYGnPEe7TYXjadyW6tbjbnrW7hbopCeFrX9La6b1hAtQq8E3Qq4u
 jh2q7EsZeCgAmDJb3H2q1QXrrH6BRds5Fe2vre9nghdWAfSMeUBJZcUppC3yzzZUH2jp
 fDpvnsH4kJenaCzuUG79Dg61cuXPFJw4cTdVXx8Id56Zb7RwleCd5EO5SBT7DvRW8b5y
 VAJH/qMWyXH6+rT9XslI+cvmo3/l+TAp64IbAypP5d7EIQdExd8P3bNDpeOGsKrAmbJV
 xung==
X-Gm-Message-State: APjAAAVzwb91lZmTCYiLJPiqMuJ0/pimIzKgoVoTP6SP3q2qqoCBvrdX
 t0+XADnX0FbpQe3qwmOuz2c=
X-Google-Smtp-Source: APXvYqyn9oB/FFouD3CzYviNzP3K6jwddkBgJlPkJuAaYWj9B7NGwjw8zSt7IlBlTYf4/BsC3WCZbA==
X-Received: by 2002:a17:90a:f0c1:: with SMTP id
 fa1mr20894397pjb.129.1582551633179; 
 Mon, 24 Feb 2020 05:40:33 -0800 (PST)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p4sm12912258pgh.14.2020.02.24.05.40.32
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 24 Feb 2020 05:40:32 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 0/4] riscv: Upgrade OpenSBI to v0.6 and add 32-bit sifive_u
 bios image
Date: Mon, 24 Feb 2020 05:39:40 -0800
Message-Id: <1582551584-20093-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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


This series advances the roms/opensbi submodule to the v0.6 release,
and builds and captures platform firmware binaries from that release.

A 32-bit sifive_u bios image has also been added, so that we can have
32-bit test coverage for SiFive specific drivers that cannot be done
with the 'virt' machine.

Two GitLab CI jobs are added to build the OpenSBI firmware binaries.

Changes in v2:
- new patch: Upgrade opensbi from v0.5 to v0.6
- Update the 32-bit sifive_u bios image to OpenSBI v0.6
- new patch: Add GitLab jobs to build OpenSBI firmware binaries

Bin Meng (4):
  roms: opensbi: Upgrade from v0.5 to v0.6
  roms: opensbi: Add 32-bit firmware image for sifive_u machine
  riscv: sifive_u: Update BIOS_FILENAME for 32-bit
  gitlab-ci.yml: Add jobs to build OpenSBI firmware binaries

 .gitlab-ci-opensbi.yml                       |  63 +++++++++++++++++++++++++++
 .gitlab-ci.d/opensbi/Dockerfile              |  33 ++++++++++++++
 .gitlab-ci.yml                               |   1 +
 Makefile                                     |   2 +-
 hw/riscv/sifive_u.c                          |   6 ++-
 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin | Bin 0 -> 49472 bytes
 pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 40984 -> 41280 bytes
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 49160 -> 53760 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 45064 -> 49664 bytes
 roms/Makefile                                |   7 +++
 roms/opensbi                                 |   2 +-
 11 files changed, 111 insertions(+), 3 deletions(-)
 create mode 100644 .gitlab-ci-opensbi.yml
 create mode 100644 .gitlab-ci.d/opensbi/Dockerfile
 create mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin

-- 
2.7.4


