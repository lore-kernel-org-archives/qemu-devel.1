Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418C3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B711207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glwBomo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B711207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiddN-0007bq-4S
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 08:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jidSj-0000Io-5M; Tue, 09 Jun 2020 08:34:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jidSY-000749-To; Tue, 09 Jun 2020 08:34:40 -0400
Received: by mail-wr1-x443.google.com with SMTP id x6so21053052wrm.13;
 Tue, 09 Jun 2020 05:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4vYBQ4QOoLJ0tWi1pnrplMJpUmOVbtMFmv0oacXtacU=;
 b=glwBomo4hogbRJTESikWKaZdE/9Pss6V+ntW5JGrUihb260OeBiLq8tPVaV7WCekSt
 qJYzKm9g6IZYFpAVQ57Yt0l4YCkjNDPzEIHXUTk3nV7RJI6sU45PhRlQE/5S2FmzsITI
 ITX29OFSgmdU+AYbph7uefhB0rUzvjwhArze8O2ghbKvSNEpgGzBzoOVfGuVi1GYcdun
 ytjEtuW3NhjFJXdHSYNCqvSjQ4Km/BjQjWqVg6mTJvHNuAEr4NGZkdUVgj6jxH9TgP9B
 Uv6rtOitxzTEh/0P0HuSb9jpLD+OPzy114hpavzL5n2CZApowRMgWFKdfU7fwpGuDpXC
 P3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=4vYBQ4QOoLJ0tWi1pnrplMJpUmOVbtMFmv0oacXtacU=;
 b=IXT5Q3CBvxB5tDikBNYIMdtKSgHBKqm9WgZKU7Gj0Jno+QI/2itDqne2kfn2cuTgMu
 9oSur6fENSdiuKqAUhJlMLd679tBtMtPHPU4kDavHBL7r7Ig1SdfEsz0h1wEuapyDuNA
 JHx32Vu4L32rYqsiYC+jqztQ2umuljTk75HsCE+EaZAwxJQiaSaEsMl9WWgFP+11UslH
 O3EVRNdikvGzwZxSHYVWxAfVyttsiFQe8CWcBkWPIgPdjwDB/hMDYsiKlzGSiJui+pWM
 u3evlrIAaTPPX7qCXyfrrqNibt/wAKj5gBBwsyy6P5hZ9Oh1htIt4mBvfVoy7ENnNSqi
 YECA==
X-Gm-Message-State: AOAM53052FzSjb8lU8JL+98RoIx8JL71wc1swFh93lOrFf9ZPv15j6Sm
 /r+EaiPrE5xlfwX2divWPLOVPldx
X-Google-Smtp-Source: ABdhPJxgydoyfpuuyi9Sr9NuKIO6xYmpr4HxNpY/iAA9lmjJ/v2uGoUJFix+h3eRW+nHqzP6g7M+dg==
X-Received: by 2002:adf:82ab:: with SMTP id 40mr4021066wrc.85.1591706066909;
 Tue, 09 Jun 2020 05:34:26 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id c81sm2920931wmd.42.2020.06.09.05.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 05:34:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/5] hw/misc: Add LED device
Date: Tue,  9 Jun 2020 14:34:20 +0200
Message-Id: <20200609123425.6921-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

These patches are part of the GSoC unselected 'QEMU visualizer'
project.  As the AVR port is not merged, I switched to microbit
to keep working on it.

This series presents a proof of concept of LED device that can
be easily connected to a GPIO.
The LED emit QMP events, so an external visualizer can display
the LED events.

If there is no negative opinion on this series, next step will
be add Zephyr test for the microbit, then we'll work on LED
array/matrix.

Regards,

Phil.

Philippe Mathieu-Daudé (5):
  hw/misc: Add a LED device
  hw/misc/led: Add LED_STATUS_CHANGED QAPI event
  hw/misc/led: Add create_led_by_gpio_id() helper
  hw/arm/microbit: Add a fake LED to use as proof-of-concept with Zephyr
  hw/arm/tosa: Use LED device for the Bluetooth led

 qapi/led.json         |  47 ++++++++++++++++++
 qapi/qapi-schema.json |   1 +
 include/hw/misc/led.h |  44 +++++++++++++++++
 hw/arm/microbit.c     |   3 ++
 hw/arm/tosa.c         |   7 ++-
 hw/misc/led.c         | 108 ++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS           |   7 +++
 hw/arm/Kconfig        |   2 +
 hw/misc/Kconfig       |   3 ++
 hw/misc/Makefile.objs |   1 +
 hw/misc/trace-events  |   3 ++
 qapi/Makefile.objs    |   2 +-
 12 files changed, 223 insertions(+), 5 deletions(-)
 create mode 100644 qapi/led.json
 create mode 100644 include/hw/misc/led.h
 create mode 100644 hw/misc/led.c

-- 
2.21.3


