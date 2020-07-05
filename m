Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132DEC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 21:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC74820708
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 21:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gk2a4Jew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC74820708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsCHp-00043O-34
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 17:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsCGq-0002wK-1K; Sun, 05 Jul 2020 17:33:56 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsCGo-0000IM-L4; Sun, 05 Jul 2020 17:33:55 -0400
Received: by mail-wm1-x341.google.com with SMTP id w3so27213728wmi.4;
 Sun, 05 Jul 2020 14:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XLadhnT5E6vAuu3xAswg3w8AxNaxCNbfH2QiEzn8UKY=;
 b=gk2a4JewNsocDz51UVVyk2Phn2VsI4QYox6zZcfj5NbONwib/Txx2Tz+VL/ZS4TknQ
 6BO7k6t+x19t0zmZJ4RN4sOnAyGqM3vn9CXP2UAWBT8Ozt26wEAXzK+HzDE6Ezjd6sNC
 Vw7SNUTeh4Bs8ipEgQereG3lHdLX110hI2gc6InYRjiQfCXRJeiE+tXaJlPDJYrs9iSv
 BIx9GdjTHIlNRVVW6x294oGNvj/a+WJqyOG9yyqS4T48MePAZDVzHLwsVzML8L7D+F18
 rV7KVx21LvG1I6clBeEEePWKv1aHuLPLucCHx4cK+lgTklZFPVfnn502UUYJxbPXogfz
 A6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=XLadhnT5E6vAuu3xAswg3w8AxNaxCNbfH2QiEzn8UKY=;
 b=Zr+ID7JGbSJ5X3/2NWsi+Wd2Fu0F+U+Q79JPinr3zMowBBcc3H/f4iq8B3BOt9Px/A
 opYNnQ1WfjBRdJucB66TjU1QsOx/ydC13W1AoVhjetjklzUVAmk11T+6628fA8suWsuo
 N08KNIeRhZvcyqMF9hCAtSwPcvZcrqvivdWzlq8m+KRk0hAochfmSTd9TV2Pr/+TGzC4
 qkL3+SCe/mguOz3HUmE0F2VNbo8O7Zow+twYXbiJobKelmhW2/Wvat2jzNiBEEqmDqwi
 N6xTpYJMOb/VY2iNIowjTz1hvDSDMfv30LAFkTzDurpULriQd0sTCt3LiulAB2RMb40J
 HSwQ==
X-Gm-Message-State: AOAM531oIbGzZ5RmdrfR4/0k+Ofi3jK1hqo1mNUs+G4mJrb4znb3RHbf
 Vs75YRT5kRXdFj4yL89iU+9OCaAWiZE=
X-Google-Smtp-Source: ABdhPJyD1feoJTlknzviPe//S4WToGwGYAzp+QexNAxDo8yD36PX7MJUb26RTaj9FLd7yke0bCi7+A==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr44586471wml.36.1593984832366; 
 Sun, 05 Jul 2020 14:33:52 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id y77sm11244453wmd.36.2020.07.05.14.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 14:33:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/sd/pxa2xx_mmci: Do not create SD card within the SDHCI
 controller
Date: Sun,  5 Jul 2020 23:33:48 +0200
Message-Id: <20200705213350.24725-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SDHCI controllers provide a SD Bus to plug SD cards, but don't
come with SD card plugged in

This series move the SD card creation to the machine/board code.

Regards,

Phil.

Philippe Mathieu-Daudé (2):
  hw/sd/pxa2xx_mmci: Do not create SD card within the SDHCI controller
  hw/sd/pxa2xx_mmci: Trivial simplification

 include/hw/arm/pxa.h |  3 +--
 hw/arm/pxa2xx.c      | 39 +++++++++++++++++++++++++++++----------
 hw/sd/pxa2xx_mmci.c  | 15 +++------------
 3 files changed, 33 insertions(+), 24 deletions(-)

-- 
2.21.3


