Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D968FC3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79D221726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAKIsy0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79D221726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Ysw-0003JR-3z
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 13:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqP-0001IO-Pk
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqO-0006yN-J1
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:21 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:38168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqO-0006xq-AH; Wed, 04 Sep 2019 13:13:20 -0400
Received: by mail-wr1-x42e.google.com with SMTP id l11so13287194wrx.5;
 Wed, 04 Sep 2019 10:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HKqL9ZWZyoX9rq8jSewYQgNwV5pak8csw5WRGNU8fT4=;
 b=MAKIsy0b4kNQoSVuI8b4dWYgKCHioDrLYFEBmlWnfzZBlRAscFbRjM0biwqimEi/tf
 1ZR4mSsRMh17EiCTf2ouO244s+TnZYY5p/tddCo8FWFUxZMlCznQTLSCcDZ9BQIEJTjp
 kcP/rdWAV1QBwnbT0GGvO2YAUwyT/6lmb5v/b60Yap3TGinxldvknJL/zysE5xG9Nba3
 OBQLZosuO1mtScjeHFNpUvTBidAi4wx6KXEBmrmayIHNKYGW9D/Ya1l4NPhLmjPfxRF1
 4vAYYAwnsp6dqA0ynB0hlJyFZ/z3l1g0Cg2aIsgKuQ6OQQLsXBsSEvKVpLFdw+QqMGp3
 B/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=HKqL9ZWZyoX9rq8jSewYQgNwV5pak8csw5WRGNU8fT4=;
 b=KSOOR0NYZ63xFliLnqj2M3toTPxbxjImsClGXw6wHuS4EyCYkn8QFi8nu9GvkPMfve
 gBUQNEu7kDJNItegURyXS0MsWXyDZo60tbGYS5ed836bUCreh9sdFKhSS2onTaYoHBL5
 D3H1NGEykjtqTDIH5GZoxoCM7AW3CgB7CJP9GtfruWxJFXMG+9GXbngGGvPWp5mn3nU0
 vvPyr2vLSfIC7+EvDlaZObRB4dGecKFotxhJMs/eg5D26mtAX4Qgo0tcv0HAGGlKUW6P
 +9u+iaMFzDKRHthbHrrg6MYrzzt5FuGQ9hOr4cubYyHgBf1awLWtt3SuQdy3UjlDxnL5
 Mu1w==
X-Gm-Message-State: APjAAAUtfWNm5xHpfTzv2TyCYDHAP10XnsfdVVit8JKM7mFrKGzBNVDt
 P80Dz7Ef2Uc7DWt8p5JnxpI=
X-Google-Smtp-Source: APXvYqxQZOkt6h6QuO2t1OCqM53dErrR1xVza4kJQmJKgeridEXyn71exmK35BwWnUlfBZR5cwMLfg==
X-Received: by 2002:a5d:4382:: with SMTP id i2mr33855811wrq.297.1567617198245; 
 Wed, 04 Sep 2019 10:13:18 -0700 (PDT)
Received: from x1w.redhat.com ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id p19sm2339512wmg.31.2019.09.04.10.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 10:13:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>,
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>
Date: Wed,  4 Sep 2019 19:13:01 +0200
Message-Id: <20190904171315.8354-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
Subject: [Qemu-devel] [RFC PATCH 00/14] hw/arm: Add the Raspberry Pi 4B
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Esteban wrote me over the weekend asking about raspi4 progress.
I cleaned up my patches/notes to pass him. Other help is also welcomed :)
I got scared trying to understand how to use the GIC, and wire the various
IRQs.

Most important notes about testing are in patch #12:
"Add the BCM2838 which uses a GICv2"

Not much works yet, it only runs a bit until configuring the GIC.

branch pushed at https://gitlab.com/philmd/qemu/commits/raspi4_wip

Regards,

Phil.

based-on: 20190903120555.7551-1-philmd@redhat.com
cutils: Move size_to_str() from "qemu-common.h" to "qemu/cutils.h"
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00229.html

Philippe Mathieu-Daudé (14):
  hw/arm/raspi: Use the IEC binary prefix definitions
  hw/misc/bcm2835_property: Add FIXME comment for uninitialized memory
  hw/misc/bcm2835_property: Handle the 'domain state' property
  hw/arm/bcm2835_peripherals: Improve logging
  hw/arm/bcm2835_peripherals: Name various address spaces
  hw/arm/bcm2835: Rename some definitions
  hw/arm/bcm2835: Add various unimplemented peripherals
  hw/arm/bcm2836: Make the SoC code modular
  hw/arm/raspi: Make the board code modular
  hw/arm/raspi: Define various blocks base addresses
  hw/arm/bcm2835_peripherals: Map various BCM2838 blocks
  hw/arm/bcm2836: Add the BCM2838 which uses a GICv2
  hw/arm/bcm2838: Map the PCIe memory space
  hw/arm/raspi: Add the Raspberry Pi 4B board

 hw/arm/bcm2835_peripherals.c         |  49 ++++++++-
 hw/arm/bcm2836.c                     | 103 +++++++++++++++++--
 hw/arm/raspi.c                       | 142 ++++++++++++++++++++++++---
 hw/char/bcm2835_aux.c                |   5 +-
 hw/display/bcm2835_fb.c              |   2 +-
 hw/dma/bcm2835_dma.c                 |  10 +-
 hw/intc/bcm2836_control.c            |   7 +-
 hw/misc/bcm2835_mbox.c               |   9 +-
 hw/misc/bcm2835_property.c           |  28 ++++--
 include/hw/arm/bcm2835_peripherals.h |  18 ++++
 include/hw/arm/bcm2836.h             |   3 +
 include/hw/arm/raspi_platform.h      |  79 ++++++++++++---
 12 files changed, 393 insertions(+), 62 deletions(-)

-- 
2.20.1


