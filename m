Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9199BC4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6000E20674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUuJiHNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6000E20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55104 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfXXd-000057-Is
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34069)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSL-00047O-Lj
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSH-0005Jm-LJ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:28:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46862)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSF-0005Cs-T1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:28:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so15507444wrw.13
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QbyF3F7R8CToKHemwXpvJuBxZLBOEbyrjFoIXswa+Q0=;
 b=YUuJiHNubaRloYXmBFbwAcRzE9zu+gRFWF3DJ5zz+LSKvWMIA5HsdSlR21ycN8Lb/A
 MQVUrej5hnI9zDuOGw0/SR5GgAzGFZBBInaAQAZEsn/jgO10yQM2+tmQ29a6oFVRX6eu
 ZCeNT5zL1//UCpN2tvAzu0jzEN3JGSlVR6BF/M2rdXfINyeizrKhJ+pefl+3OtizSSGY
 j69Yc7hNra5HADMTLs9bHjbi1wt7c/1LIyW+hxL5T4z8CAga07Eb4+4NrCws7KlYL54i
 wUwtGOyQRg3GDkHyCi6zGeafuzIfvGKkRQbhgOoTurHnjQwzICxHGoPE8WZw1WdpTwcv
 2UTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=QbyF3F7R8CToKHemwXpvJuBxZLBOEbyrjFoIXswa+Q0=;
 b=Q7U1lBU6ACN6zABbyqQVCY712n4dFepqkxnGUOtegducjS9jSHtULQ2ZZ7QoAVPbJt
 KtTzv4mMC3P5eRC99I6UvPL7vkbO1kAuhG+X/V19T39DJ+pM4r2f2hCxUAXl1O2hGKsD
 9jd6tWY0XHQsbiYhg4KBDB5vJzcia8dOkERD95qXYRIZZzfeQeUul6XLd1ci3smt2ygi
 Kfgh9DeLc+r1xDNLB34XOUj0RnMUJXdvD9hMtHvAp/XxuzRWDW3Ii34Ybz/3kkRenuJk
 aL7SX9vvQ/Gq86s66rNYhJ+3b3uTcq5ExqYIjw2F/mrjWq4W24Ubyym/vrXjBVBoTtw+
 T1hw==
X-Gm-Message-State: APjAAAX82Z74slg/e+DJxi8agSLbrTRd4RDcNUX8oSLvstuIKj+kPrT4
 OaU9IShU84TpJ49w9vKzb9wTN2yZ
X-Google-Smtp-Source: APXvYqyTs/f/pc9429XyOPMPNMTj9BZ4mL6c6ww+j0Mg8gL3DSl28S48G0Y5KNP41fMACcZeNQZf5w==
X-Received: by 2002:adf:db12:: with SMTP id s18mr14221164wri.335.1561415326906; 
 Mon, 24 Jun 2019 15:28:46 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id l1sm646781wmg.13.2019.06.24.15.28.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:28:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:28:34 +0200
Message-Id: <20190624222844.26584-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 00/10] hw/pci-host: Clean the GT64120 north
 bridge
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series clean the gt64120 device.
It is no more target-dependent, and tracing is improved.

Regards,

Phil.

Based-on: 20190624220056.25861-1-f4bug@amsat.org
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05304.html

Philippe Mathieu-Daudé (10):
  hw/mips/gt64xxx_pci: Fix multiline comment syntax
  hw/mips/gt64xxx_pci: Fix 'tabs' coding style issues
  hw/mips/gt64xxx_pci: Fix 'braces' coding style issues
  hw/mips/gt64xxx_pci: Fix 'spaces' coding style issues
  hw/mips/gt64xxx_pci: Use qemu_log_mask() instead of debug printf()
  hw/mips/gt64xxx_pci: Convert debug printf()s to trace events
  hw/mips/gt64xxx_pci: Align the pci0-mem size
  hw/mips/gt64xxx_pci: Add a 'cpu_big_endian' qdev property
  hw/mips/gt64xxx_pci: Move it to hw/pci-host/
  hw/pci-host/gt64120: Clean the decoded address space

 Makefile.objs                                 |   1 +
 include/hw/mips/mips.h                        |   2 +-
 hw/mips/mips_malta.c                          |   8 +-
 hw/{mips/gt64xxx_pci.c => pci-host/gt64120.c} | 542 ++++++++++--------
 MAINTAINERS                                   |   2 +-
 hw/mips/Makefile.objs                         |   2 +-
 hw/mips/trace-events                          |   0
 hw/pci-host/Makefile.objs                     |   2 +-
 hw/pci-host/trace-events                      |   5 +
 9 files changed, 307 insertions(+), 257 deletions(-)
 rename hw/{mips/gt64xxx_pci.c => pci-host/gt64120.c} (68%)
 create mode 100644 hw/mips/trace-events

-- 
2.19.1


