Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50E9C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FFA5214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX2WDVd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFA5214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6s5-00014i-Kv
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6qv-00085T-46; Tue, 01 Sep 2020 10:01:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6qt-0002Uw-EL; Tue, 01 Sep 2020 10:01:36 -0400
Received: by mail-wr1-x442.google.com with SMTP id g4so1179425wrs.5;
 Tue, 01 Sep 2020 07:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Gi0ci1KrpXM84+ZiLnJVzwkbllwnfJsz3K68U1ukbK8=;
 b=BX2WDVd23On6ogCBrdYaAVVWRAcZ3pmhUmKDVLmdIy6ypcB/22n8lhCY5V1oIOK5/4
 /C+r83QTvJB3xRP62HRAAWM6N8Il9IyxeNU9/v4ijKymPPJmlACz1tn2jPIyKSW27mjv
 bXTEBslco7v2Xsd0Q5Y+osvrnHsknHgDYSH5kqoIfFeIDKfyR96uMczdhNeDVWfcHhgI
 CcWEyPTv+X7Rqj7kFAN8/R8GuyMC9oDHJ9FXbHzPTG0tS0iMemfHdlrZGtqMzIy77kDY
 udtShxp1M5Wm4G3JcYTm7d4lERedUZJE/VqLORHSBV218GvtDQzLg/Opsz/ONnz9w1Rw
 ClJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Gi0ci1KrpXM84+ZiLnJVzwkbllwnfJsz3K68U1ukbK8=;
 b=Oc0BN7lxE8/tK1u2t4i62eurf2nsonUec4noQZElv7zlcO0vCRMZfLoWdrvK7nbh/s
 wcyTqeS7SFxo2GbtYY/0AJAzCm86kLzqmkrPc7R+FlAwX7uuuE8zg0tBPA/WShY3rZow
 P2G6Bjtg9lCsYC5UO45vqJvWmsG7GUXndJ4jXXGIJZK75aan7UX2DgEUSVneBo42gXkq
 uXSFgQGcLbKcB89dfvotjsZjRpNyzeSBPfATMrfKypraXlY7QQMhlc7n9A7aitEG+Npc
 xqTK9kJ2+BWOSGCAt19usXMNRnraV0SOkQz5h2YyUscILNZe4pZwp99F6+hiuBIkBkez
 q9iQ==
X-Gm-Message-State: AOAM531XNrar3dY9PFz6sB1uH+QDDpy3Jf/KQbr+WYMP6UPd19Ctatxh
 SnFXfVX1DG/DdptX5a230vQValA4V+k=
X-Google-Smtp-Source: ABdhPJw2B80pWdVc4MP6XQJ8ivBiEscFIWK2IN0L/+t556Qnl8krFvxgZ2aofnfRNwX0UVOwrV0DBg==
X-Received: by 2002:adf:f20b:: with SMTP id p11mr1890282wro.388.1598968889962; 
 Tue, 01 Sep 2020 07:01:29 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id m13sm1492107wrr.74.2020.09.01.07.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 07:01:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] hw/sd/sdhci: Fix DMA Transfer Block Size field width
Date: Tue,  1 Sep 2020 16:01:24 +0200
Message-Id: <20200901140127.111454-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
 Alexander Bulekov <alxndr@bu.edu>, bugs-syssec@rub.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix the SDHCI issue reported last week by Alexander:
https://bugs.launchpad.net/qemu/+bug/1892960

The field is 12-bit (4KiB) but the guest can set
up to 16-bit (64KiB), leading to OOB access.

Philippe Mathieu-Daudé (3):
  hw/sd/sdhci: Fix qemu_log_mask() format string
  hw/sd/sdhci: Document the datasheet used
  hw/sd/sdhci: Fix DMA Transfer Block Size field

 hw/sd/sdhci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.26.2


