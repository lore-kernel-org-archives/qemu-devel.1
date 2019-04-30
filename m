Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328B1C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 13:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7450205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 13:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nw7Iu52m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7450205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47145 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLScm-0002PN-PW
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 09:16:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSaq-00010a-3N
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLSap-0002AG-5T
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:44 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLSao-000292-TT
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:14:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id k16so20992005wrn.5
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 06:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=w6vzehaCUPSzmkvOvH14Y6PaZ3vtUSQ/vmVeOZradMw=;
	b=Nw7Iu52miYbreKaP04SnKTM5paCXaH+E9+ZUSeEuI2DkvQfwkybnxXt63/53whpbmX
	f+exjTAXv358SZsX8V5eB7hG2GWhzFQFTZpGe2iGo929nFQn3bsjF9FHkmccyP4UWu5B
	oRJuHr5EYiDoKaSzeGQjpmaqTefgIsOxo3jMnZahNnqdmqXpqwgfcaj2vTXXB3cqlSm3
	FLS5osifAjqYzTQ8Kgh4O5aoHiqf/JyHFRtHrCO6JAQpDsmsoQruSx3IXVQE5kZjm3MA
	9OzWHeTkmHDVaAWdKXs1u8RL4Wq2CrHeFAYtMmgpqRuM2Xz3u05hVddFD+CdTSk62cQT
	rbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=w6vzehaCUPSzmkvOvH14Y6PaZ3vtUSQ/vmVeOZradMw=;
	b=eAKQjFb0pKQnBSFfdbCRVh7iU/W5v1pdcMMR7GOgGv9ZQR2DD4MlY74v7wCRxvk6Da
	bno4GA8Cy+xKRv/Jy6M4U4tnOqCswOvNALiWuMcuq0I2zT9iWUdYHKxiZMeWPm1IYFNH
	ScH+GLz14KpUOUtx877xBoV5ZKmnmheB/lcl60Gy0qj9G3BqqPFXyPetO2Vba9MoUlBd
	0EWa1RXr0EQkoLBZXGzWhfmR87LlRLoTSEt2oVvNThN1wP8fSXHnTq0DZSu3bOw5Hy3D
	ElqyuJrsB5xicLoDT5YoPOfWQJeMHziM/GTUiwY2r1BUXTydjoXHdlVLpTwyP5C4Apwp
	BZhA==
X-Gm-Message-State: APjAAAX6QcoSp2rI4ZGXcWcu8yvBfSyhC2CpOcv6sTVmBbHy3GPI9n83
	lyqj25yEZfKChLYYglv8eflBH3ord1U=
X-Google-Smtp-Source: APXvYqzBLL4prhQKWn8wFffgsO6wpSlYS94EYtKsbfJPbvGGKfIuX5EK24NEyycIKEQF3FfZzUNmtA==
X-Received: by 2002:adf:cd05:: with SMTP id w5mr2696917wrm.84.1556630081614;
	Tue, 30 Apr 2019 06:14:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	a12sm16557460wrh.46.2019.04.30.06.14.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 06:14:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 14:14:35 +0100
Message-Id: <20190430131439.25251-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 0/4] target/arm: four minor M-profile bug fixes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430131435.h4lHkkrUGDRDFA2qj_p8tsBYmLEFP8I24LYhKJJKI20@z>

These patches are fixes for some minor bugs that I noticed while
writing and testing the M-profile FPU support. They're not FPU
related, so I didn't want to mix them up with that large patchset...

thanks
-- PMM

Peter Maydell (4):
  hw/arm/armv7m_nvic: Check subpriority in nvic_recompute_state_secure()
  hw/intc/armv7m_nvic: NS BFAR and BFSR are RAZ/WI if BFHFNMINS == 0
  hw/intc/armv7m_nvic: Don't enable ARMV7M_EXCP_DEBUG from reset
  target/arm: Implement XPSR GE bits

 target/arm/cpu.h      |  4 ++++
 hw/intc/armv7m_nvic.c | 40 ++++++++++++++++++++++++++++++++++------
 target/arm/helper.c   | 12 ++++++++++--
 3 files changed, 48 insertions(+), 8 deletions(-)

-- 
2.20.1


