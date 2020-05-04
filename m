Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CFEC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FAAA2068E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo1dZolL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FAAA2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWO2-0006HM-8V
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWN9-000599-8d; Mon, 04 May 2020 04:22:43 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWN8-0006wX-IL; Mon, 04 May 2020 04:22:42 -0400
Received: by mail-wr1-x443.google.com with SMTP id s8so9502020wrt.9;
 Mon, 04 May 2020 01:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gVwDMqU7IDBJFvdNOuVVuB4LeRx8gjOeYN0o0mGV2Qw=;
 b=Bo1dZolLpAJb7IszJBw0u2h4zHCqI7s79sB6g6e+8ImLO7sS5vQ1M1SeFuj/raxw48
 nq83UtV3qqFMkvBbP8sezzfxuvNGWvzqGN4UsY3jpfkooNON4q2n2FfIV7f+gBn/A/Q0
 OPaiewQM8UC/kCpH6fCMWQafSzhgW5T/4Z6NOb/gMuQ/xJj5jkDGYk1R8uBC6qT1EE/6
 VckYA0ZLtPrxdaoq/DOO+UFvv0RTcbxAHd/clTSw+hOkpX3kDRGCun52vRfJxZ/LGMh2
 HvyBFRp0hYhswBMbUBP0IJEUXbbBHJzb25NxzHpwVi8ah0fblnpIxkV7RcYjzt1UaRTQ
 LXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=gVwDMqU7IDBJFvdNOuVVuB4LeRx8gjOeYN0o0mGV2Qw=;
 b=mweS/D82ZS2m7C61gzdiFevld6HPdiKxwDjzjTzBQKpwbit+wPJqlMg/zHQBBFBmz8
 KwE+VBwfQ/tSJc0mcTpjMt61NipEDvlPTSagH3mfWVWQlCyUA1H1XmRcaIrOqa9g9G34
 YQyFyeslK9ZEKk7rKpSnp7lcw+Fh0G6J7/+6X32uDABB7usfeF4EJv2q7NhKbKy7lVL3
 Hq4Wcyy3OX1C0yMBIP9vwg0oAOt1wK47cWEHvndwYs6NJkXxL5a/6q/FtB7Lf1YNxrqd
 k5lLgVu3lr5c98eXPRqmiE+iZIuyRUo+gj8Cex38OEBhfa9+Ih7H21L+T33d0ZCiB1ob
 HTXA==
X-Gm-Message-State: AGi0Pua7eMtvskBIxyH7o25UDx9WTRQqC82T1nh1ri3FE+VF2pJCN7pJ
 8AmggE4uI9o0ZewIOkJsNS9+SGrg
X-Google-Smtp-Source: APiQypJy3OfBaZK5dQxpWyDdbvySBklTV0VqAzt8csYksJOa0eN+2/+gA6WA+ZEV+cz0Mzk1t77lqQ==
X-Received: by 2002:adf:d841:: with SMTP id k1mr10114465wrl.129.1588580560042; 
 Mon, 04 May 2020 01:22:40 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id b66sm13045738wmh.12.2020.05.04.01.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 01:22:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/usb: Make "hcd-ehci.h" header public
Date: Mon,  4 May 2020 10:22:37 +0200
Message-Id: <20200504082238.16655-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Jeffery <andrew@aj.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-trivial@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As target-specific code use this header, move it to the publicly
accessible include/ folder.

  $ git grep hw/usb/hcd-ehci.h
  hw/arm/allwinner-h3.c:31:#include "hw/usb/hcd-ehci.h"
  hw/arm/exynos4210.c:38:#include "hw/usb/hcd-ehci.h"
  hw/ppc/sam460ex.c:38:#include "hw/usb/hcd-ehci.h"
  include/hw/arm/allwinner-a10.h:13:#include "hw/usb/hcd-ehci.h"
  include/hw/arm/aspeed_soc.h:29:#include "hw/usb/hcd-ehci.h"

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 {hw => include/hw}/usb/hcd-ehci.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {hw => include/hw}/usb/hcd-ehci.h (100%)

diff --git a/hw/usb/hcd-ehci.h b/include/hw/usb/hcd-ehci.h
similarity index 100%
rename from hw/usb/hcd-ehci.h
rename to include/hw/usb/hcd-ehci.h
-- 
2.21.3


