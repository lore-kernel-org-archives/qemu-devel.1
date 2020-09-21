Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F0EC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617A7207D8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lyecehn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617A7207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKCop-0007k4-AC
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 23:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKCng-0006OG-SV; Sun, 20 Sep 2020 23:47:36 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKCnf-0001w1-JG; Sun, 20 Sep 2020 23:47:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id z1so11168719wrt.3;
 Sun, 20 Sep 2020 20:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kmr7MIPQlRUdBq38A4ZkR03WaABT/YA95v2kz3M2+68=;
 b=Lyecehn8f6wmq+u+BVCAKxq7knocuduyZDXR0LZ+ZnuKojTuNiYkDCPxbYlmlOernG
 X1N4espeiS61lBiVKCzq9AExGeLJSfoVtNvB7Sta1zip5BwCql+wcvJHxpFSQTnWf/d3
 xuSDAqQF/S5DIRtiFRY9DR5CZAS3nEW5r6jJT4tRpEwSqZ746pwIIfUC+IiK5LdfjsFu
 11xfrWjxmpZbPaODtHvvVgojXhMLWV0Syk4ORu1YRtn35zgnusjxCDNQbPVCjDY79RmO
 mXXOcBGObIFOwwXNF9Lq8vcj0ve75CpK/BtHAm/G19LtcXYGVPcsZ204ZHYfPgWlqEPJ
 muOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=kmr7MIPQlRUdBq38A4ZkR03WaABT/YA95v2kz3M2+68=;
 b=rc/siiaLHXgdST61MBDnlXINak91kE/xcql0I5uMHxoTpjEncPJGAc9KXHqJSepqTP
 4rrfitgh/2R+SzR8lDAMuFDqzVG7WkzmSwhR+M94aMnyp84DwomsR4B0ol6qti1tbNuW
 PIYz0A73mw+t6jRkxNAqcUmoSDDpZdiAYyqDG6Fm323fnPsQNiXjKA7tqn0qx8sWxjCO
 mWZv6Z1V0+RX8IQswbEb9bCOM4stTuEI3S90qPwrsdJaxG0hjXbqWYmy5TysQnmg1ZfS
 JgCTBAopQyg9OGwvQqfx43wfRBrytTNY4Ru2NAKHT5PkYMANjX1YsHxHERpDpKXkCPNC
 mr/Q==
X-Gm-Message-State: AOAM530qieAB9Z41P1v+yNYI0uzLrt1W62vyzJve6DE59Q/04amCIjYM
 5zZHfpAZ+1ZGL39s86kT8QBwaRj7kzw=
X-Google-Smtp-Source: ABdhPJxHL4Te7wqCw5K5vp3qd9CInSZoK1H67pXe2gyJQRYY3SiYELmW1IACz/iEZAWg/g7vzVHKaQ==
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr49298294wrs.36.1600660050913; 
 Sun, 20 Sep 2020 20:47:30 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u63sm11751440wmb.13.2020.09.20.20.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 20:47:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] hw/arm/raspi: Remove ignore_memory_transaction_failures
 on the raspi2
Date: Mon, 21 Sep 2020 05:47:26 +0200
Message-Id: <20200921034729.432931-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch 1 and 3 are review, patch 2 is new and trivial.

Philippe Mathieu-Daudé (3):
  hw/arm/raspi: Define various blocks base addresses
  hw/arm/bcm2835: Add more unimplemented peripherals
  hw/arm/raspi: Remove ignore_memory_transaction_failures on the raspi2

 include/hw/arm/bcm2835_peripherals.h |  2 ++
 include/hw/arm/raspi_platform.h      | 51 +++++++++++++++++++++++-----
 hw/arm/bcm2835_peripherals.c         |  2 ++
 hw/arm/raspi.c                       |  3 --
 4 files changed, 47 insertions(+), 11 deletions(-)

-- 
2.26.2


