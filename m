Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6085C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A031D214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDuppKwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A031D214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUPuh-0005RY-MT
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 01:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iUPrS-0003IH-9Q
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iUPrR-0007Km-G7
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:41:10 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iUPrP-0007JQ-AR; Tue, 12 Nov 2019 01:41:07 -0500
Received: by mail-pl1-x642.google.com with SMTP id d7so7069389pls.3;
 Mon, 11 Nov 2019 22:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sjve1OM0Uk+8Kz/y9+LRf9Q2kVMunPP7oZCcDeTVT8o=;
 b=mDuppKwheRmMgWpThI5vViBHoJm3Rbavdl4fIlkev0q7l3uY67qMWcuE6/Ek5GBuaA
 GD0SMcvhDbIOIOGu4adEkPxCPVfY48RvyUKlcNrm+qMC/rGI8s2q8s3LBuRaz3KO1A+t
 VXZzpa2kGl14e1cBXXTGO89GgOB5QzX78CGX5OJuWicZgvG9z1ICNxbPZdqv+5JNW44T
 xr4ZMo1nOTdkKM4Q5AFGYGsv1iFUbz8mZA+fN/M/R+RgGrI/rdGDvM11Jad//8kefxrj
 HG/044ehBM3sHeuuT/PT9U6Ks7vkbOeUqwslLIZhxOl1R1vX8XgSz09uNLm8zv8mPf1G
 rhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=sjve1OM0Uk+8Kz/y9+LRf9Q2kVMunPP7oZCcDeTVT8o=;
 b=YQ/TB2+pqEsjKzLHo3GsfQZaE2opvZZ6KoqLfh2yFRtq8IyFyWcbnGwt9FMkNV3Wuo
 fhekwdkDl77C3KG+UEZQYrsAwjk8xpeBiGRMq1qYRwLgsL5gS98ayujKamsrsKxe4rCR
 t9toEdGWOXlVeCZH292i4frV+Xi38I1XoMfKW1eP+WpIl/UFahkUHJNZf0qeioHn1omW
 uam8enb7kd39X17YMBGUNMD6LuwYodJc3ezE6w74yg/3xpBUA9Em7DBQtHzcAeARkyeQ
 QL+kZHRoW2qQWYu3ciZ3l9+FSbvDNo0mL6Qvn9AppCn/6JBULCcELPOn32WcR0PHJLY7
 Hrgg==
X-Gm-Message-State: APjAAAVMEWW9HqCB+Jaqt2siarRUwxcZfEDGaXIljl86lKa8norzoNGf
 5mDnvPqSVbtqjNqZXkhJ9jA=
X-Google-Smtp-Source: APXvYqwslMmR/Uq5qzSg0loF5sbCriFEeZCXHVBkacouKvYmBOwjTStzg23aB5LhFVedaQMWqjY1zA==
X-Received: by 2002:a17:902:be14:: with SMTP id
 r20mr24799228pls.297.1573540865798; 
 Mon, 11 Nov 2019 22:41:05 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id q8sm16375590pgg.15.2019.11.11.22.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 22:41:04 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH 0/4] arm/aspeed: Watchdog and SDRAM fixes
Date: Tue, 12 Nov 2019 17:10:54 +1030
Message-Id: <20191112064058.13275-1-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Three of these are fixes for ast2600 models that I found when testing
master. The forth is a usability improvement that is helpful when
diagnosing why a watchdog is biting.

Joel Stanley (4):
  aspeed/sdmc: Make ast2600 default 1G
  aspeed/scu: Fix W1C behavior
  watchdog/aspeed: Improve watchdog timeout message
  watchdog/aspeed: Fix AST2600 frequency behaviour

 hw/misc/aspeed_scu.c             | 11 ++++++++---
 hw/misc/aspeed_sdmc.c            |  6 +++---
 hw/watchdog/wdt_aspeed.c         | 24 +++++++++++++++++++-----
 include/hw/watchdog/wdt_aspeed.h |  1 +
 4 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.24.0


