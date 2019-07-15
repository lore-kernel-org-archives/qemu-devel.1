Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6757FC7618A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 06:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C24320644
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 06:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNyzur72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C24320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmuL2-0001H3-58
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 02:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rashmica.g@gmail.com>) id 1hmuKo-0000bi-TW
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 02:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rashmica.g@gmail.com>) id 1hmuKo-00023I-1E
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 02:19:38 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44577)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rashmica.g@gmail.com>)
 id 1hmuKm-000221-4h; Mon, 15 Jul 2019 02:19:36 -0400
Received: by mail-pl1-x644.google.com with SMTP id t14so7726600plr.11;
 Sun, 14 Jul 2019 23:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CFwjRJeYEQbmwlpBaKx41zBl6UOTVPC5mwjWf/K53/A=;
 b=MNyzur721+wALYeata3oVOU4DM2DSgoLbHOSJ1dCl4t91JLAz6Ax25/uRqSo2uJoeF
 nNgoiEhwmnzmFFMtOmfKbXnvkvOhLSSLQ8wa9T01W/QjMrxXmuCOueINSYCE03K/2ww2
 Rx+Y60fiaLi3k2SSqNbRyD1FjsjxgxAYVUcdqWRT+ngqXTZmWae8tu0Y4gM1RueZilTj
 LgOGMsmspFnXUL7dfXawWM2o8IoABzJxvKZ4fM5FQhLX9cOZyYRvIzH/ysheO9oQJ/AE
 ax5pec6yJXmNALTg8Kyy/NTvaldSzveUjqFbw/R0O25pGGD0SZ79gP2FHlHVwYI52gdB
 dSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CFwjRJeYEQbmwlpBaKx41zBl6UOTVPC5mwjWf/K53/A=;
 b=Ny3Wc9lRb/avoJchh7C3wtfyyDZdxPfPz6c/cNa9/xUwAkI79l9eikU8pN8OgvWpFL
 9AwB/c7jQcgW08a0wuL8f0MjdA4E8Xud+kFWGM3CSeIaG4eljCDOacqMwgcqpqPTxfzN
 MQrlSSQt6lbi4LPM5SUaUPi3MiPu6qe1W/HhOqQrfzPXazYR24OUHY0jHW4qsJ/lXNBX
 0RCgjS4bVYNO8hDO46hDfCuNm1HKHRz1Pk8gUHeGuBxxFvnxqchbikQPc0DsZP1uBFPd
 JvqfReUylc4qBUAPXGSeBFJ7nENtt99pkDUfi3etnnM2u2i3BgUsgplJyu/AJwel3RKA
 0L0w==
X-Gm-Message-State: APjAAAWJMKAKt8dwu3/KZndCQ6uEE+ObkW6U8VoPnPanwLzxZtpuLVI4
 rg8DQ30hSREyIHtUck8ceCKBNfSz
X-Google-Smtp-Source: APXvYqxPfGzL6n7KGvKaVkJU8q8bKTWoLg2cF2D4mm6y7da4l1MUwr6EVqzB9mhJ2QERnd3yRbOWUw==
X-Received: by 2002:a17:902:bd94:: with SMTP id
 q20mr15519408pls.307.1563171574978; 
 Sun, 14 Jul 2019 23:19:34 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id 4sm20020018pfc.92.2019.07.14.23.19.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 14 Jul 2019 23:19:34 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: qemu-arm@nongnu.org
Date: Mon, 15 Jul 2019 16:19:23 +1000
Message-Id: <20190715061925.28030-1-rashmica.g@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 0/2] Add Aspeed GPIO controller model
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
Cc: peter.maydell@linaro.org, andrew@aj.id.au, qemu-devel@nongnu.org,
 clg@kaod.org, Rashmica Gupta <rashmica.g@gmail.com>, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rebased on Peter's target-arm.next branch.

v2: Addressed Andrew's feedback, added debounce regs, renamed get/set to
read/write to minimise confusion with a 'set' of registers.

Rashmica Gupta (2):
  hw/gpio: Add basic Aspeed GPIO model for AST2400 and AST2500
  aspeed: add a GPIO controller to the SoC

 hw/arm/aspeed_soc.c           |  17 +
 hw/gpio/Makefile.objs         |   1 +
 hw/gpio/aspeed_gpio.c         | 891 ++++++++++++++++++++++++++++++++++
 include/hw/arm/aspeed_soc.h   |   3 +
 include/hw/gpio/aspeed_gpio.h |  92 ++++
 5 files changed, 1004 insertions(+)
 create mode 100644 hw/gpio/aspeed_gpio.c
 create mode 100644 include/hw/gpio/aspeed_gpio.h

-- 
2.20.1


