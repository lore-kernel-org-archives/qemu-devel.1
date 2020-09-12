Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFD9C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 13:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6B720829
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 13:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwYyiRUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6B720829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH5mx-0003Cs-Un
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 09:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH5lo-0001YH-B1; Sat, 12 Sep 2020 09:40:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH5lm-0007n1-Lh; Sat, 12 Sep 2020 09:40:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id k15so14077793wrn.10;
 Sat, 12 Sep 2020 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FGA0sSPKaL1qbUcPugyzEye7s3ZwDkErc7GlYrgxV1U=;
 b=WwYyiRUSPSxeYNNlpsrPf/+XuwqcMqadorxNcaGAS1CxN6o1owY3WL9F3NK/OGbAA3
 SYTxZdTfqUuFSfe67fs9qN7ZIBwkuBASzdyM9/LgdwYJyfJ//9i+dmTiLJeUy05ogMn5
 9wSHJQC2nK0VtFGehr6jIEsOj9Bljywpwy+w/oJUiEN+rsILkNqrRHWrvcme5srQJvZ4
 /Gid7fyP2Q3TqulRo3cIC63jhqylD/KnKGxHKy5cF1FtYTHEeFeiMCQM/h4MZ/m1mPln
 1k1RustUTNshyCeiul3HKxRc7bCHV9RSxJU3spVW3I3X1EYIQVaW1GGTDdnShuf4KUg9
 sb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=FGA0sSPKaL1qbUcPugyzEye7s3ZwDkErc7GlYrgxV1U=;
 b=FC+AWmQP0+Hz8h0dsVyOELiX5nn1W7pf6YI1kZ2ZwydLwD5KUSWfLatwMAvJ+e1vK+
 2auxuRCiPmVkf9bRH7k7mXlbA8x3baVS1NykaAQcTHd7IxJT2JHhrQ9Q7VMs4kFKcOf/
 mQ78pL/DJzGwXftya5RVHcHzLJT6+PPnjfDDHrt719klqkAkIvqCH+3YXIqiOiMsnU5q
 7UTkggWZEOX1i80uTcVg1XLdBwejVDMBYUyvJw+3pv3wMQtDg/G1jGkK5EwOWzBFEnrJ
 s6ZLUUMqDLFzB5iy5h7bV3spe0xQ5+x0KEW7QD6CtWWM1hL6d9SMAlBD8vhiIzLlK9u8
 QIbg==
X-Gm-Message-State: AOAM530orhyGCY9ac0WerNZWLU3nsvGPkx2UhBjB2z4GbwWplZVCBCh6
 HO/soSj8kNtqp2RvcyhOtxAdD2EEPD0=
X-Google-Smtp-Source: ABdhPJzVZ5Z5ys6/tJbt2pF7lfouwBQAwMVlcmjrp9AUYrBe029CD0rytVWQikhtEgbelWId+79I4A==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr6618337wrt.23.1599918044041; 
 Sat, 12 Sep 2020 06:40:44 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm10309144wmg.44.2020.09.12.06.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 06:40:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/7] hw/misc: Add LED device
Date: Sat, 12 Sep 2020 15:40:34 +0200
Message-Id: <20200912134041.946260-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

These patches are part of the GSoC unselected 'QEMU visualizer'
project.

This series introduce a LED device that can be easily connected
to a GPIO output.

Missing review:
- Patch #2: "hw/misc/led: Allow connecting from GPIO output"

Since v5:
- Rebased on "QOM boilerplate cleanup" (use DECLARE_INSTANCE_CHECKER)
- Addressed Luc and Richard comments
- Do not use confusing "polarity-inverted" property
- Reset LEDs in MPS2 devices
- Document GpioPolarity

Since v4:
- Fixed typos (Luc)
- Removed TYPE_TOSA_MISC_GPIO qdev conversion patch (Peter)

Since v3:
- Rebased (TYPE_TOSA_MISC_GPIO)
- Rebased (Meson)
- Addressed Richard's review comments
- Improved doc/comments

Since v2:
- Rebased on PCA9552
- Model intensity to be ready for PWM use (Dave)
- Remove QMP events until we get a UI visualizer (Peter)
- Remove microbit patch (Peter)

Since v1: addressed Eric Blake review comments
- Added QMP rate limit

Next steps planned:

- PoC visualizer...
- look at using a dbus backend (elmarco)
- look at LED array/matrix such 7segments.

Regards,

Phil.

$ git backport-diff -r v6.. -u v5
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respective=
ly

001/7:[0013] [FC] 'hw/misc/led: Add a LED device'
002/7:[0026] [FC] 'hw/misc/led: Allow connecting from GPIO output'
003/7:[----] [--] 'hw/misc/led: Emit a trace event when LED intensity has cha=
nged'
004/7:[----] [--] 'hw/arm/aspeed: Add the 3 front LEDs drived by the PCA9552 =
#1'
005/7:[0004] [FC] 'hw/misc/mps2-fpgaio: Use the LED device'
006/7:[0004] [FC] 'hw/misc/mps2-scc: Use the LED device'
007/7:[----] [-C] 'hw/arm/tosa: Replace fprintf() calls by LED devices'

Philippe Mathieu-Daud=C3=A9 (7):
  hw/misc/led: Add a LED device
  hw/misc/led: Allow connecting from GPIO output
  hw/misc/led: Emit a trace event when LED intensity has changed
  hw/arm/aspeed: Add the 3 front LEDs drived by the PCA9552 #1
  hw/misc/mps2-fpgaio: Use the LED device
  hw/misc/mps2-scc: Use the LED device
  hw/arm/tosa: Replace fprintf() calls by LED devices

 include/hw/misc/led.h         |  97 ++++++++++++++++++++
 include/hw/misc/mps2-fpgaio.h |   2 +
 include/hw/misc/mps2-scc.h    |   2 +
 include/hw/qdev-core.h        |  16 ++++
 hw/arm/aspeed.c               |  20 +++++
 hw/arm/tosa.c                 |  40 ++++-----
 hw/misc/led.c                 | 161 ++++++++++++++++++++++++++++++++++
 hw/misc/mps2-fpgaio.c         |  23 +++--
 hw/misc/mps2-scc.c            |  27 +++---
 MAINTAINERS                   |   6 ++
 hw/arm/Kconfig                |   2 +
 hw/misc/Kconfig               |   5 ++
 hw/misc/meson.build           |   1 +
 hw/misc/trace-events          |   6 +-
 14 files changed, 365 insertions(+), 43 deletions(-)
 create mode 100644 include/hw/misc/led.h
 create mode 100644 hw/misc/led.c

--=20
2.26.2


