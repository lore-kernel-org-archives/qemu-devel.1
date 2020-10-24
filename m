Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB4BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 17:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C977A2085B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 17:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZbgAtkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C977A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWMx7-0000YY-Sp
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 13:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWMvC-0007FM-Tc; Sat, 24 Oct 2020 13:01:38 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:47087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWMv7-0005gk-Mn; Sat, 24 Oct 2020 13:01:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id n6so6435486wrm.13;
 Sat, 24 Oct 2020 10:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b99Jgjfu69tr+44eIjnFaQhT7BY0ffzrdIZPOKeBNwc=;
 b=nZbgAtktSMIATd5pWd+X5E3+QHeT7/X5A8zPhLLzmK+D0GL0CtjyXgb0yEi0D0BSAf
 O7zKphFXscM1XfNPaiQ8HsoyF0FZ8ISLE6DLQBbRoJTuVeSEo2CzdbYoNdv0spof6HPU
 JqzR1N+/PDhGNzBWrUMUKUl/HpRgmo4KMMn6uUf8fdoaFFjzcBmEJPFC4pypdHick0s/
 JKVIGV+qpMDglWZOZPakTLDJMQnNFbPVXomKhy23CvTlv/vuPghdQVYXzJnSUxt6kfJy
 7+pwbDLVvhoAkAXMxEDWbTTH98mxYtnUv5bZDkQhrgBn8ZNtWBUuV5Pn4CHAAAuhe+9B
 I3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=b99Jgjfu69tr+44eIjnFaQhT7BY0ffzrdIZPOKeBNwc=;
 b=GHHoUNS5NHdECm2XlTSkkhUCwhuRpxhNM5kX8ms5qOe2nj7rakV/jkO0mloYLIG9rq
 +3h1tsHT2WalNToW/ovV+Fh1bNvqBbLcSLCApGqHAXW7VG2Lx951p4Zp8k9Aia9lTFs2
 +iwTJLKtmcZbhZvITo3LB3++eu0r1L5YrPKgNd6X59y8So24wal7vP556XSQxCmeODkd
 J1/5hp+0NgMf/cqxDvNamem+GzSs4i7dAPeVQ2oRfybZ/KdnMKT+DFkkLEPur+SNLk20
 7QQBBp7B1FvqraLRQgXt1M8DX0ZdP4h3sflF+/JFCatOp7LITyafOcDGONlt/FoFj0V1
 N0DQ==
X-Gm-Message-State: AOAM532X2SJ5cP7AfGURAx5qxTvXr+T2OmeINJ7KpywH5XhehADLCJGq
 UBfb7RFKTLNsewCh3lj8TyOgNr0lsMA=
X-Google-Smtp-Source: ABdhPJxi++K3JddZrhLGGVzwH8UbQbuTZYknWMubq4Dc3RxBOcq8u1E2Oza/c08PwZjoKr6SoByOrQ==
X-Received: by 2002:a5d:54d0:: with SMTP id x16mr8338550wrv.75.1603558890255; 
 Sat, 24 Oct 2020 10:01:30 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id i10sm13167338wrq.27.2020.10.24.10.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2020 10:01:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/9] hw/arm: Add raspi Zero, 1A+ and 3A+ machines
Date: Sat, 24 Oct 2020 19:01:18 +0200
Message-Id: <20201024170127.3592182-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the raspi0/1/3A+ machines.=0D
=0D
All series reviewed :)=0D
=0D
Since v3:=0D
- Addressed Igor's review comment and added his R-b tag=0D
=0D
Since v2:=0D
- Rebased=0D
- Addressed Igor comment=0D
- Added Luc R-b=0D
- Added model 3A+=0D
=0D
Since v1:=0D
- Use more specific machine names=0D
=0D
Philippe Mathieu-Daud=C3=A9 (9):=0D
  hw/arm/bcm2836: Restrict BCM283XInfo declaration to C source=0D
  hw/arm/bcm2836: QOM'ify more by adding class_init() to each SoC type=0D
  hw/arm/bcm2836: Introduce BCM283XClass::core_count=0D
  hw/arm/bcm2836: Only provide "enabled-cpus" property to multicore SoCs=0D
  hw/arm/bcm2836: Split out common realize() code=0D
  hw/arm/bcm2836: Introduce the BCM2835 SoC=0D
  hw/arm/raspi: Add the Raspberry Pi A+ machine=0D
  hw/arm/raspi: Add the Raspberry Pi Zero machine=0D
  hw/arm/raspi: Add the Raspberry Pi 3 model A+=0D
=0D
 include/hw/arm/bcm2836.h |   9 +-=0D
 hw/arm/bcm2836.c         | 182 ++++++++++++++++++++++++++-------------=0D
 hw/arm/raspi.c           |  41 +++++++++=0D
 3 files changed, 162 insertions(+), 70 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

