Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656ADC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BCC2076C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCT0JH+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BCC2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIcv-0002m3-Bi
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbU-00013Z-Qd; Mon, 08 Jun 2020 10:18:20 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:41452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbT-0004Te-5P; Mon, 08 Jun 2020 10:18:20 -0400
Received: by mail-pg1-x532.google.com with SMTP id r10so8789295pgv.8;
 Mon, 08 Jun 2020 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=MPi6vTj4qaMjTAPVVPddeTzme+C9Ipmgwatea/EQioM=;
 b=FCT0JH+XhC2zfKYSnkiswanmt0YIbA3C/MIlVXrJSK97VwKuVNFuM455HDOAQQqbFx
 ulgPI3Lv8e+EchQFQTtiAd/IGydOfr/N5jkPDgRKkLmfkD5OUA/EeLqCu5/TzuOIUqLO
 xwMp02qg0WYGDlcET7xePOFexSh5vjfg1QDzeKravePKSodPCHfjOebItwgJYShg7Zd9
 2rj9a552iy4fgKtV8i7rlNVSAG9ordBcB3NCW+iW+49wiGTOplhrsQpqiCNEeu+Efepk
 esjWHYLYlMxYJkIYNd5+PFNSaV19+j5RpNzkUSlaePIXGmCGDBStzMbMyT0QLKMJ/oni
 Ee0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=MPi6vTj4qaMjTAPVVPddeTzme+C9Ipmgwatea/EQioM=;
 b=QjV5NwcyQcdeHInnURa7m02+OzJ+LDJtaa7GR2E0VwuzGyA0enc9Mzlg85ExQgJXOJ
 5uttf+1wk0sQRvfQHCO6adT9qYN30T3uOp4s818lM3iftL0HY47JW3bjDLpMLcs3lPfV
 Eiw7BPFE9EYU+cbTgiYfJYPauF2rCbsRP7K4NqNho875P31HX28fvLgxojchSN+k2z0W
 4YCNupbLq674/CgWqZzvztqYwXXv8h/u7EjUscT/BIokK2PwtH/C6lsypf/NGIwXnVQZ
 61S6LY/XQh71F5KCkWnUSX0YwwsxIjPJaU1Qd46P1rNDiH9VbCmvGd/Sz09myWVEyfeg
 lb6w==
X-Gm-Message-State: AOAM531OTn43hx06+8ISCD0oukhKlib3WRsvC1UTsiFszaaeVN/JsIax
 GNSadD2cVlUJ9vPXnywDMac=
X-Google-Smtp-Source: ABdhPJxHA2QWIpl8P6p1cZ6m5j4ZizuOLOIwvtYa1jIVq8ueNU7O1IPYfgbjG68vicRUAhrHlHXKSA==
X-Received: by 2002:a65:4908:: with SMTP id p8mr19994720pgs.214.1591625896731; 
 Mon, 08 Jun 2020 07:18:16 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id b19sm7292575pft.74.2020.06.08.07.18.15
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 08 Jun 2020 07:18:16 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 00/15] hw/riscv: sifive_u: Add GPIO and Mode Select
 (MSEL[3:0]) support
Date: Mon,  8 Jun 2020 07:17:29 -0700
Message-Id: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x532.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

This series updates the 'sifive_u' machine support:

- Add GPIO controller support
- Support reboot functionality via GPIO pin#10
- Change SiFive E/U series CPU reset vector to 0x1004
- Support Mode Select (MSEL[3:0]) settings at 0x1000 via a new
  "msel" machine property
- Add a dummy DDR memory controller device

The series also does some clean-ups to the existing codes.

With this series, QEMU can boot U-Boot SPL built for SiFive FU540
all the way up to loading U-Boot proper from MMC:

$ qemu-system-riscv64 -nographic -M sifive_u,msel=6 -m 8G -bios u-boot-spl.bin

U-Boot SPL 2020.07-rc3-00208-g88bd5b1 (Jun 08 2020 - 20:16:10 +0800)
Trying to boot from MMC1
Unhandled exception: Load access fault
EPC: 0000000008009be6 TVAL: 0000000010050014

The last big gap for the 'sifive_u' machine is the QSPI modeling.


Bin Meng (15):
  hw/riscv: sifive_e: Remove the riscv_ prefix of the machine* and soc*
    functions
  hw/riscv: opentitan: Remove the riscv_ prefix of the machine* and soc*
    functions
  hw/riscv: sifive_u: Simplify the GEM IRQ connect code a little bit
  hw/riscv: sifive_u: Generate device tree node for OTP
  hw/riscv: sifive_gpio: Clean up the codes
  hw/riscv: sifive_gpio: Add a new 'ngpio' property
  hw/riscv: sifive_u: Hook a GPIO controller
  hw/riscv: sifive_gpio: Do not blindly trigger output IRQs
  hw/riscv: sifive_u: Add reset functionality
  hw/riscv: sifive_u: Rename serial property get/set functions to a
    generic name
  hw/riscv: sifive_u: Add a new property msel for MSEL pin state
  hw/riscv: sifive: Change SiFive E/U CPU reset vector to 0x1004
  hw/riscv: sifive_u: Support different boot source per MSEL pin state
  hw/riscv: sifive_u: Sort the SoC memmap table entries
  hw/riscv: sifive_u: Add a dummy DDR memory controller device

 hw/riscv/opentitan.c           |  29 ++++----
 hw/riscv/sifive_e.c            |  32 +++++----
 hw/riscv/sifive_gpio.c         |  45 +++++++-----
 hw/riscv/sifive_u.c            | 158 ++++++++++++++++++++++++++++++++++-------
 include/hw/riscv/sifive_gpio.h |   8 ++-
 include/hw/riscv/sifive_u.h    |  27 +++++++
 target/riscv/cpu.c             |   4 +-
 7 files changed, 223 insertions(+), 80 deletions(-)

-- 
2.7.4


