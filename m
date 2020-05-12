Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9749C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E83620736
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijGVUwh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E83620736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYPfG-00013V-Ki
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 03:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYPeF-0008SS-NZ; Tue, 12 May 2020 03:48:19 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYPeE-0002qP-T9; Tue, 12 May 2020 03:48:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id g14so8670684wme.1;
 Tue, 12 May 2020 00:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=O3A4C5qI5xVwTnKvjkGjo0uHCRrBmraBZalUe9e9aIQ=;
 b=ijGVUwh6yV1Na+WwMs42W1c/8xD3MXEVeD995Zzv+NWy68J48ZqXI6K8LqDcVIzX4T
 aE6XMHlU0zPC8Or7ezZXyk5P+meaDOHN/1G7CHyJ5zKAZH+ddzkzdcPy55vCNdknV+RQ
 FVoHQdkXhjZ973PruMkdHSGVPlLv9nc9BKLk99Ppk1xaKEPQzlu9rEHnC3v6LeYytdis
 kskEv/DLekmVWP9zhATLz6T+7XQsmqH8DokniNp7YZsjqFKQrKc4QRCG80nQCw8kpRWW
 E2qeaKmLh4we/msSH23IdCkcgLI00JEnfN3Rn21vA7GflyL6ZYdwkIpof2AtzvFoZPbD
 qhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=O3A4C5qI5xVwTnKvjkGjo0uHCRrBmraBZalUe9e9aIQ=;
 b=cQfSrPl8U2PeDLD8szt0gAaC5bKz4+VQZedqKdYa1kF70oXauXQd5ymUhEmWxN6dGq
 fzh433Yf2fFu1ABwSSdjwqFLYWXD/8XtxL3Tbhgd5kX8irVJsmSYz9KHwW6qUQXxPDf9
 dsNWON1K020tSuuoKsDRkFBmxv8QXOkDJK7ZrktgxsHkj5eI3nYJHxvdM3WHiELbyuSM
 zq8kZmbqr72Kl0TOV3Gejy5BAXRI+t+HJVHLcGUoEWedBbIfG+MpuOy/OtT7Au2j5HhP
 aT5qOIbxbqF+JaUx46W0I/NCGlcN6+JSQ7yFJct5iUyhCN6rtLk6khUU/HvAVFwxpc23
 JZcQ==
X-Gm-Message-State: AGi0PuYFC0oqhyIUstKr4c4wL13a6weRuYSHe9fD6khzXkE0d8yfjDn4
 ksSe64Bb0xHONV3w1QraR/VWdGxuB20=
X-Google-Smtp-Source: APiQypLOvEi+T8vS8dr0AmdHDYAWQyCZzdFPepEPmBS6uX4RCX7BuRBYmTrXm6/NsF8XiZz2NW/tqQ==
X-Received: by 2002:a7b:c931:: with SMTP id h17mr38037439wml.105.1589269696534; 
 Tue, 12 May 2020 00:48:16 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id c7sm7783754wro.80.2020.05.12.00.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 00:48:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] hw: Use qdev gpio rather than qemu_allocate_irqs()
Date: Tue, 12 May 2020 09:48:10 +0200
Message-Id: <20200512074813.29992-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stafford Horne <shorne@gmail.com>, John Snow <jsnow@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use a coccinelle script to convert few qemu_allocate_irqs()
calls to the qdev gpio API.

One memory leak removed in hw/openrisc/pic_cpu.c

Since v1:
- Referrenced Coverity CID (Stafford)
- Reword AHCI description (Zoltan)

Philippe Mathieu-Daudé (3):
  hw/ide/ahci: Use qdev gpio rather than qemu_allocate_irqs()
  hw/mips/mips_int: Use qdev gpio rather than qemu_allocate_irqs()
  hw/openrisc/pic_cpu: Use qdev gpio rather than qemu_allocate_irqs()

 hw/ide/ahci.c         | 6 ++----
 hw/mips/mips_int.c    | 6 ++----
 hw/openrisc/pic_cpu.c | 5 ++---
 3 files changed, 6 insertions(+), 11 deletions(-)

-- 
2.21.3


