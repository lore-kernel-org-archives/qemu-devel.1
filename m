Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDBEC4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DB920637
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MK282tFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DB920637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFcbg-0002kf-O2
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 07:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFcaE-0000EY-Eb
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFcaC-0006Gs-Ro
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:46:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31794)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFcaC-0006Gf-No
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584791188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H/kvBiPyxCh595bpD+FYmGkaOOWay12gFZX+EGKqT6I=;
 b=MK282tFuILqCW9uBZTiJ9UmKJep/iJrOqYIhu3bjL+KwG1pTbI+zvcPhhDDZZNdYEB2HdU
 V/6zBSA8qMZXp02EVDdePaawTl5JEP8wBt/GJNYdaoqZSdOfYgC3JjLpOGcXKwFvKYuSUo
 hz5GQaYoE67V4MboctMwEcD026oVjc8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-Cmo7EbVWOc6SrN1Sd8-r7Q-1; Sat, 21 Mar 2020 07:46:26 -0400
X-MC-Unique: Cmo7EbVWOc6SrN1Sd8-r7Q-1
Received: by mail-wr1-f71.google.com with SMTP id v6so4136683wrg.22
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 04:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9dXP4N8TyULZAzjZYqxK/uANHHgjWwDCR4io6WeB96U=;
 b=P8thVm3LCOD/EDqX9NA4Uwjy06hFwDLUqKXVHXs5ozxlp1/wRfS9EGdxhS+7Pp37JD
 N6H/f5snQ3jG4UUp3kblvEPj7MLLc30knLQi51+DXWC+5lpPKgB3CsvHKvC8HQNDzZW6
 9BQrYIgQEdu9DcKYeprdqCDdPpKKHWNZ+pGbMhvVuYfZ462qQFS+x3l17JQ2LWJFy+op
 qyYX1g/BwgSH2jPkQwaahg3ZLmmIMoWLLqHNzfA920CDsSrK68kw18Y4DqBjk8lceaLy
 eVlyKYv12PBYcL7R0+W0yHdA5Jtv0qNRpOUix9MCTxhMh1ge6r4uUKri2zUOmkZWA5l1
 9JBA==
X-Gm-Message-State: ANhLgQ0yxwCvgUmXLsMRK1j8R9sJdbMgUYH1Cxy1g0fT7S9iCRouydRp
 msLyQvz8tLMejBn2Dxt87FNk9nPSJoU5KOl1MQY+sXkLjVeiPEU1BAF0lZuy6CaBNxVVI4hQRFf
 dKfAZc8jPD3G7xHY=
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr16445004wmk.160.1584791185043; 
 Sat, 21 Mar 2020 04:46:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsSWCMAhwipawfBMfkPl4+F8HWrgcbof15lyslD5n9fBr4SnAzQxKtSsuZj7e5L0nZTE/KW3g==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr16444963wmk.160.1584791184820; 
 Sat, 21 Mar 2020 04:46:24 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id d21sm12882125wrb.51.2020.03.21.04.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 04:46:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 00/11] misc: Trivial static code analyzer fixes
Date: Sat, 21 Mar 2020 12:46:04 +0100
Message-Id: <20200321114615.5360-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
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

Philippe Mathieu-Daud=C3=A9 (11):
  block: Remove dead assignment
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
 hw/gpio/aspeed_gpio.c      | 4 ++--
 hw/i2c/pm_smbus.c          | 1 -
 hw/ide/sii3112.c           | 2 +-
 hw/input/adb-kbd.c         | 1 -
 hw/isa/i82378.c            | 8 ++++----
 hw/scsi/esp-pci.c          | 1 -
 hw/timer/exynos4210_mct.c  | 3 ---
 hw/timer/pxa2xx_timer.c    | 1 +
 hw/timer/stm32f2xx_timer.c | 1 -
 11 files changed, 10 insertions(+), 16 deletions(-)

--=20
2.21.1


