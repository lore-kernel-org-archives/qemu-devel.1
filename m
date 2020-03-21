Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C21C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3766120776
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ht6oJzxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3766120776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFfKu-0006Qu-Bn
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 10:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFfJQ-0004Mm-Kb
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFfJP-00079K-Kx
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:41:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFfJP-000791-I6
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584801679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XjYHy8EAEyVWWAj6PcQzbMtUCcBiHqB3U8PD6B93nsg=;
 b=ht6oJzxnbO6vMBXePrRNQ0+z8xRRsr9mST6gEMwbH5CXnIE/vQLXI7MUkNoVCvInohfFZt
 tZa4n205S4U15AayTuBP+CthUoNFfqyudgduOsrlU/us4UL2eGH4r2RzMLs6BzwK8u8lM3
 0J0qrZHnqoHWg0YV4mg+PQK4WPENVZY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-MwshAHYUP-KWsY66hy37BQ-1; Sat, 21 Mar 2020 10:41:15 -0400
X-MC-Unique: MwshAHYUP-KWsY66hy37BQ-1
Received: by mail-wr1-f69.google.com with SMTP id l17so3962196wro.3
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 07:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VXdFqIF/MgdCDNguoL8cH2BaYWlik8rbXVsmqvrTHJE=;
 b=Z4E2JyRJpPtwE6W72Jv5K3zFU6Vs3p1rnva3hQu38uysLbdDMfOo7OhBk4CbI1w94b
 mXY5PcF/iYo/UvDbEY5pw1re3Kf9RMhfoMYeRUy4rM1Adps66/OLMKU3rlAezXDz5/zr
 VqdUsd921y/b8ST+q1T/1X5A9+drwpCTD0889rvWHinuP2dCxZrXc/KNOWK4aMSHDyOI
 BTbLUTl6sgAxjhIPH8JQEIvUjC4usI6m8ZXwsVUEp98eUrriK1mxLrlHo/Xg9FnJR17t
 t44BsJjOXnGpSjvMjayCYaC2y3xIDfd3sewyMVg+LCrchuEH6E30oPWIecTugCT0ElAu
 c5+Q==
X-Gm-Message-State: ANhLgQ06P0ZCzxHp3UpeuI+3KM5W8seTnn2oWkGiPrCOZfBjaX+Pr9Qo
 19kkHRIQBzxVnCjkK0qnaHn0bxyXndwBdkLxHr0YhbHimWWsGzz4pMRpmX32rg22nUjV4GptiZM
 HR9OKh5wvDKe7YE0=
X-Received: by 2002:a7b:c0cf:: with SMTP id s15mr17311415wmh.106.1584801674321; 
 Sat, 21 Mar 2020 07:41:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv6uMxgkNcpJBwBUlvjZaxH1fKsb/YKC4A6BQiDtHKspDaLkC4B04qIib2r3hYSSDAFWI+oXg==
X-Received: by 2002:a7b:c0cf:: with SMTP id s15mr17311376wmh.106.1584801674111; 
 Sat, 21 Mar 2020 07:41:14 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id n2sm13181619wrr.62.2020.03.21.07.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 07:41:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 00/11] misc: Trivial static code analyzer fixes
Date: Sat, 21 Mar 2020 15:40:59 +0100
Message-Id: <20200321144110.5010-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix trivial warnings reported by the Clang static code analyzer.

Since v1:
- Addressed Markus/Zoltan/Aleksandar review comments

Philippe Mathieu-Daud=C3=A9 (11):
  block: Avoid dead assignment
  blockdev: Remove dead assignment
  hw/i2c/pm_smbus: Remove dead assignment
  hw/input/adb-kbd: Remove dead assignment
  hw/ide/sii3112: Remove dead assignment
  hw/isa/i82378: Remove dead assignment
  hw/gpio/aspeed_gpio: Remove dead assignment
  hw/timer/exynos4210_mct: Remove dead assignments
  hw/timer/stm32f2xx_timer: Remove dead assignment
  hw/timer/pxa2xx_timer: Add assertion to silent static analyzer warning
  hw/scsi/esp-pci: Remove dead assignment

 block.c                    | 2 +-
 blockdev.c                 | 2 +-
 hw/gpio/aspeed_gpio.c      | 2 +-
 hw/i2c/pm_smbus.c          | 1 -
 hw/ide/sii3112.c           | 5 +++--
 hw/input/adb-kbd.c         | 6 +-----
 hw/isa/i82378.c            | 8 ++++----
 hw/scsi/esp-pci.c          | 1 -
 hw/timer/exynos4210_mct.c  | 3 ---
 hw/timer/pxa2xx_timer.c    | 1 +
 hw/timer/stm32f2xx_timer.c | 1 -
 11 files changed, 12 insertions(+), 20 deletions(-)

--=20
2.21.1


