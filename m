Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491BAC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1567C2070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuKW4KHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1567C2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXbH-0000nS-72
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyXa7-00086z-OC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyXa6-0007ae-Mu
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:59:47 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyXa6-0007ZG-GQ; Mon, 03 Feb 2020 03:59:46 -0500
Received: by mail-wm1-x343.google.com with SMTP id g1so14821597wmh.4;
 Mon, 03 Feb 2020 00:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QZnQOP94muzSIElkanGheHJjLGSupMVYZHoIdtYusII=;
 b=CuKW4KHUHTbbqKsLd8e2olhNSQi5shdGgROec8c/uKFrH5xTY+oG1idSqNr0dfkkSs
 qslU89a2f5iEYQXMkxD5oIYJ2ZW3FXW2y0Cd4u4KvXqirlEU1kDrwCsnWfTatQW1XHqF
 4QGm9f9kWEsddSelxpubqOtoujp0v6fR0G1ZQrePnYH5GaEkHspCTI/dyHlusKaadJxw
 1ymPBzdrzZicHq3r5n7CpdscQ/+lh8aWFYG/yRcZuJ16/LpbnYfUPFenxGARnhOkYxcz
 mM45V3ZpaFBei6eMumlxS1aHp+QN/TBN6hNTBVPuR/ywyTAXCy3dWBOUll8EXq70g+S6
 kZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=QZnQOP94muzSIElkanGheHJjLGSupMVYZHoIdtYusII=;
 b=O7nHEmDvbgCuDJCE7+BYjuuYpY2+rvzDS2VyLPycK96mkGcbKt7iqn7jz1nc713+KV
 Y92H3dmj20UsokTfhePD30HdlLn7MEdNk9PLJisjjWePYndxHK1Oqsq1xsvUDBP2qb4W
 fmz+i7h+tO7fe+PlQzvknDmGniwBtoSC6U2684JxQP7idXSukw4cGncsghMMf70a7yWX
 +3r5Mh1PjB4IQXsr3S/JbyD6oY66fG+xRH6X63AO0GKIW5+Zq9ScncDOlNqm9h3lz0TB
 87Oqx//X+QwReCE7ijCmzQoVHluN+817n4bQmg+5khWOW5rlWP4GU30DQkczy8gZHIyo
 UkPA==
X-Gm-Message-State: APjAAAXodhHKbIGy8tOsRW2Nxj+504i08kvwJMfrTxylOGqmuxjBPEJV
 HUOdbFgoxndN+Y7VsTRYW63yi0Cn
X-Google-Smtp-Source: APXvYqz1FTrikyXsIQY8ASNXXltC0d9Sfbm380ISZOKF2sWwcQUSjVYQ94J+/wqOiCDRIFXyrjhEYg==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr29896197wmb.137.1580720385134; 
 Mon, 03 Feb 2020 00:59:45 -0800 (PST)
Received: from localhost.localdomain (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id j5sm10029678wrw.24.2020.02.03.00.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 00:59:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [NOTFORMERGE PATCH 0/2] hw/arm/raspi: Add the Raspberry Pi Zero
 machine
Date: Mon,  3 Feb 2020 09:59:40 +0100
Message-Id: <20200203085942.19826-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sharing these two patches to justify the refactor of previous
series [1]. It shows how easily we can add the raspi0 machine.

[1] https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00226.html
"hw/arm/raspi: Dynamically create machines based on the board"
Based-on: <20200203082619.7426-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (2):
  RFC hw/arm: Add the BCM2835 SoC
  RFC: hw/arm/raspi: Add the Raspberry Pi Zero machine

 include/hw/arm/bcm2836.h |  1 +
 hw/arm/bcm2836.c         | 35 +++++++++++++++++++++++++++++++----
 hw/arm/raspi.c           |  7 +++++++
 3 files changed, 39 insertions(+), 4 deletions(-)

-- 
2.21.1


