Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB84C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E5720716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4R1ADeV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E5720716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDt2i-0002Pc-OD
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 13:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDt1x-0000p2-Gy; Thu, 03 Sep 2020 13:28:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDt1v-0002V5-KF; Thu, 03 Sep 2020 13:28:13 -0400
Received: by mail-wr1-x444.google.com with SMTP id c18so4068752wrm.9;
 Thu, 03 Sep 2020 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MaYvDpYA/q1gHW4bD3RmC39zVROC6oAwV/mFF935mOk=;
 b=A4R1ADeVqpDDM6cYNxZfbffyJcUga2yXAfFk0JhtGCPzRjJ22uVpFCfE8zDbQ3ETc9
 NMGjg1P0ZrPRfiYybGTYrdYUTXBvIe+0+9biwOgVJg9nV0lyU+LuqZxBg3BD2sNllryU
 kP6rhep2jcEEajTQfvJcqyKoHzqszqdHLTQBDJuWDazruJX6IubE8Q2CURdfpWbScIol
 22rFQRJ+VhftqKc1HJMN6YLZv9A/cdldlTrmez4w4Jtx9KoAb3P30srdFww2At8+Gbpz
 6ks5dSrD3cEGOuFmHgljCsCQh9nQe1VXyNqVaE5aFHYjq9xtPgJxchEs5Or1JQOJvQXS
 uhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=MaYvDpYA/q1gHW4bD3RmC39zVROC6oAwV/mFF935mOk=;
 b=InIjcoCI9OpwlbrqdusRKWlawAiYn2l5gSkMsEjRfQbVr0T1gX2/yLELsd0JnLkTKf
 ZZqhlFQhPDRy95dzf5mJ3FewfK9SJMXf+AC1ZEzO/K7rjalKlAXsujsJzUemI/fmJDrU
 T7Pwp5JblckPsRQ2X7rxv3j9A5/RjH2MmPyyfzgPZ/iYW8CIZuCicAVjl5D1jBEjQlJ0
 qT1I1j6OWfCEcRSDO4IYYUGddGprxeUXFRdPyVZMuIh+huUZp1Im6cLT3l7BZbzBZgdk
 v/oCCVViPY/UIYbJfJwT615ntIgj55b/K0/ePNAFkHlCP3vVJcVtbUUlBlwJG50Onco6
 rfdw==
X-Gm-Message-State: AOAM530hoXu2jqvgsu0syBlOUjmuJYuNQcoCgaZ9KniHoWnaLck2JMtP
 PN4no/1Q//7HE/bN5eM7uASxd2KNVsI=
X-Google-Smtp-Source: ABdhPJzUIO97wpLKF8Q5DSWpRv4UTvYhrePm//2Sgj72sU4ZVAJ5n2MhDqxlbX+P7fioJaOATuWIpw==
X-Received: by 2002:adf:f011:: with SMTP id j17mr3376770wro.335.1599154088909; 
 Thu, 03 Sep 2020 10:28:08 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id b2sm5325802wmh.47.2020.09.03.10.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 10:28:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] hw/sd/sdhci: Strengthen multiple DMA transfers
Date: Thu,  3 Sep 2020 19:28:02 +0200
Message-Id: <20200903172806.489710-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 Ruhr-University <bugs-syssec@rub.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Still trying to fix the bugs reported by Aleksander...

- Do not send 0 block count
- Reduce DMA to MMIO re-entrancy by yielding when pending IRQ

Based-on: <20200901140411.112150-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (4):
  hw/sd/sdhci: Stop multiple transfers when block count is cleared
  hw/sd/sdhci: Resume pending DMA transfers on MMIO accesses
  hw/sd/sdhci: Let sdhci_update_irq() return if IRQ was delivered
  hw/sd/sdhci: Yield if interrupt delivered during multiple transfer

 hw/sd/sdhci.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

-- 
2.26.2


