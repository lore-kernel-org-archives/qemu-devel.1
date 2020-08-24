Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A869AC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBDB2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5FJLLSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBDB2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9Kh-0001nG-Mo
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 06:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kA9HT-000451-8T
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:00:47 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d]:34010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kA9HR-0006U6-7E
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:00:46 -0400
Received: by mail-lj1-x22d.google.com with SMTP id y2so8934148ljc.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 03:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WLizz/xLfK46knGsBVdY5pZ2jvQOcq61pYb9iIJUQPY=;
 b=K5FJLLSa3ZHAwWjGEQJdftSE+rICGOUlEaMYDI6W8nw9bF/c5bwcY5LWKTmtBNAfYh
 zrFLDWKd2Jk6pzxwpTD6Ci9se6WiI3odGG5P1sfGxq4QXbJOvl0L9gy05FLNW37rInt3
 w6D8Zl4PO2C6/Yk+r4GcjGDhSfmlxCDCNOdlgrgAQPrzccBXATZx9J+7wzQasuH4iaUU
 w3RUcJdvQuwDqb/PK/3rSPo37OjRHglWD33WIC470PY0cqzgAv7mHpdi5FJZiRJEbfJN
 ditQ8T5PzKU7C+J0jgmpo0P/PygpmvLrlq48ANacTqprVuYvg2uzXb8PC/PMR6NR7Hmh
 jCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WLizz/xLfK46knGsBVdY5pZ2jvQOcq61pYb9iIJUQPY=;
 b=ikpkNtGPX4KotOPtilci3XhngGkMjmZ1aUPbbwJdeQxOwotCHtgJRsoROWTaq5hqBl
 Q1Ggn2N6vwYYomrFRBEVpMfAuMEM0FWKBT/7qoeKNQFNXlDJhnvofljYOg1AJMWAPvA0
 /djdrft9tckZZmvhb7J3DGiMvm3WKc38TCtE+IYrbhWOCZR8GVfZIKP/PMcfWSUAEdF+
 vkxy5SIBk+yEIg4xymkmcn2Ec/b+EajfzFy6+rM90J5ToW9ZvCOAG07UPmQgEggNYUxM
 EMWn37fuvIbef8uK56CN8P6sYXv8Q1HB3bjV3bo+hm1KoQcUywT1AkleDyf2RaMNHk6Y
 PT5Q==
X-Gm-Message-State: AOAM532+o1XbxiPJsr+QQpRSQtDx+y13OYFclHbteni3rKY4LLLYTtPU
 s+xs7MiDUAlBqFuHRxBajaMksGfOdks=
X-Google-Smtp-Source: ABdhPJybnsdxNt7pEnilrkP5fZG5gG4T/Db33qejzEB+Et7VDctpXufCZB9XT8brq+1wMSRA9DrcIg==
X-Received: by 2002:a2e:a370:: with SMTP id i16mr2389785ljn.22.1598263242619; 
 Mon, 24 Aug 2020 03:00:42 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id o25sm2120035ljg.45.2020.08.24.03.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 03:00:41 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 0/8] Xilinx queue 2020-08-14
Date: Mon, 24 Aug 2020 12:00:33 +0200
Message-Id: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.724, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

The following changes since commit 8367a77c4d3f6e1e60890f5510304feb2c621611:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2-pull-request' into staging (2020-08-23 16:34:43 +0100)

are available in the Git repository at:

  git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2020-08-24.for-upstream

for you to fetch changes up to 43f4e3d4fa2f9dba6bd68452a3380864ad9453c1:

  microblaze: petalogix-s3adsp1800: Add device-tree source (2020-08-24 10:47:27 +0200)

----------------------------------------------------------------
For upstream.

----------------------------------------------------------------
Edgar E. Iglesias (8):
      target/microblaze: mbar: Transfer dc->rd to mbar_imm
      target/microblaze: mbar: Move LOG_DIS to before sleep
      target/microblaze: mbar: Add support for data-access barriers
      target/microblaze: swx: Use atomic_cmpxchg
      configure: microblaze: Enable mttcg
      target/microblaze: mbar: Trap sleeps from user-space
      microblaze: petalogix-ml605: Add device-tree source
      microblaze: petalogix-s3adsp1800: Add device-tree source

 configure                        |   1 +
 target/microblaze/translate.c    |  38 +++--
 pc-bios/petalogix-ml605.dtb      | Bin 9982 -> 9882 bytes
 pc-bios/petalogix-ml605.dts      | 350 +++++++++++++++++++++++++++++++++++++++
 pc-bios/petalogix-s3adsp1800.dtb | Bin 8259 -> 8161 bytes
 pc-bios/petalogix-s3adsp1800.dts | 282 +++++++++++++++++++++++++++++++
 6 files changed, 661 insertions(+), 10 deletions(-)
 create mode 100644 pc-bios/petalogix-ml605.dts
 create mode 100644 pc-bios/petalogix-s3adsp1800.dts

-- 
2.25.1


