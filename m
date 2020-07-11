Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8693C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 14:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD822075F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 14:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qfr5jvWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD822075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juGec-0006VA-Ly
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 10:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@amarulasolutions.com>)
 id 1juGdz-00065o-Vz
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 10:38:24 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:34120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@amarulasolutions.com>)
 id 1juGdy-0005St-3u
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 10:38:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id g10so10396446wmc.1
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 07:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=R2xjZZPR/VTiORROqnbOSoZQvwoyOJlFuFPuQPVlgwE=;
 b=qfr5jvWTca9oAncQHy19xWq9w9etg+jrQUpWEcI6S/BuPrEBMZrebMl8yIsh/YFhAH
 rlvPIvN8xnaEzEmfNx2j9dF8JWlDiv9DqOHwqnoTMe+dTNnwyq4Ut8/42s/xFX2G11A/
 mpOtw6/D+4l1gz+5Oa6fFDNEfuzgU4tyS/pks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=R2xjZZPR/VTiORROqnbOSoZQvwoyOJlFuFPuQPVlgwE=;
 b=kmFuIAECHVug8W65AkSbojFEI3HmMxyPr5T3/BqjvEnJZjVhALSarPl6g2zj334StN
 uEpTNfpPq660L1zb5KrDSWcPmKvI41+6X+im0c1fI0E5Iyg/E+K2SikVjvLEHiFJR1pI
 rLW15Vs6nFVyvbxYlkKDrTZIqWtongeN/l5M8GNGaNhWz5po94aRBGyo7LeMS9Uan1fA
 UqowF9dC/gNIqMlaB2x33UK+rTR9DDxDBWIBlMp33w3FtGYQIRaxJ/k/1TfMegkKkTT+
 CGG81crsRaJFhDr6N/nVFFgYkd55xbmlqaso41MTe01YyYAZu8q6JskDoXF4xWXp6RDf
 wF7w==
X-Gm-Message-State: AOAM531gKYNg9dVYttb7wW+qyAMQ1E5vpce0uhOEN2E0RJ15XSGHAGrL
 diZH/qU0Nu0N4nkTaXK9skyZ1I8Yzz6k0DKcVt7fUUceScRQIA==
X-Google-Smtp-Source: ABdhPJz2Cvp+Nxt1dn2GpwPy3b9T0rtaq7MqmF2+k2G6ry10DlB4TQqDk90jogTKG16Z/RUaMHWqfljZSA79wEPwqR4=
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr9917093wme.46.1594478299346; 
 Sat, 11 Jul 2020 07:38:19 -0700 (PDT)
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 11 Jul 2020 16:38:08 +0200
Message-ID: <CAOf5uwkxAVNs_=TtVwUiEKyp+UZO_bT26sdCneR679Q5hZ_J2A@mail.gmail.com>
Subject: usb-wacom-tablet failing to register
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=michael@amarulasolutions.com; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all

On my 4.17.0-rc1 linux kernel i386 running on qemu, I can't register
the wacom driver emulation
QEMU emulator version 4.2.0 (Debian 1:4.2-3ubuntu6.3)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

[    0.395368] ata2.00: configured for MWDMA2
[    0.397049] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM
  2.5+ PQ: 0 ANSI: 5
[    0.584135] usb 2-1: new full-speed USB device number 2 using xhci_hcd
[    0.734449] usb 2-1: New USB device found, idVendor=056a,
idProduct=0000, bcdDevice=42.10
[    0.734461] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    0.734466] usb 2-1: Product: Wacom PenPartner
[    0.734470] usb 2-1: Manufacturer: QEMU
[    0.734474] usb 2-1: SerialNumber: 1-0000:00:04.0-1
[    0.737347] usbhid 2-1:1.0: can't add hid device: -32
[    0.737366] usbhid: probe of 2-1:1.0 failed with error -32

I get back an error. Any suggestions?

Michael

