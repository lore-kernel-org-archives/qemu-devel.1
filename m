Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93062C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00BAA2080A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlPQjJzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BAA2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGTbY-0005wq-Tu
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 16:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGTaW-0004Bz-9u; Thu, 10 Sep 2020 16:54:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGTaU-0000Gl-EG; Thu, 10 Sep 2020 16:54:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id s12so8619432wrw.11;
 Thu, 10 Sep 2020 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cE1BdjYokghhyZMf3x3eQ6C62qVX3CCpu206VY6CXYw=;
 b=WlPQjJzxALSekH5oXTiumyNvEUl6DS2pl5Pes6ebkKWyVXlPgCIJh3v3EIH430hfoa
 Q0Udy/g/bPFBSZxtHseO9DstarVSW1AqN4wz6oQnmEPPE1efbhjMAnnBNF7A88eJFc5Z
 Rn4XV0h9/WF2/aGUyGDG2flEi1g5hTBtewpMaD1Ab0r40oReSlZf+WYjjTYc4ayQ7twu
 MNIEo5KjUBjoKjyffz0Fedi+ntt/IHxMG3uigJfIMzxMFxr7jfsXw2wwtdhQjFNJp6Hn
 toIpXJwBvdqawwHALdsHDlQtDdAiNh1zCqmQ3T7d1JdxXiNf/hecF0KfmJtJYJaV3ew/
 se/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=cE1BdjYokghhyZMf3x3eQ6C62qVX3CCpu206VY6CXYw=;
 b=hhaob8EwCcUJjfBmsTQXbBFv7LKFyVQw0b+2LYoVTVbXtzsV3z3HmwLEBFs7o6A+h1
 KtNZLOXpJodnepvGWML/wp1iMWOo3M8RrpoNoTA+KpiiGZrLOKQjUsv9EUE0036zTiZ3
 53i/DnTkNMZq3hODTh8p/GhFS6gGJ/UAUNwOmhoEdzwrIyFoCf+ELhSVJituIYEQyH88
 uOUyIiZ3jC8ck4nBz0sUgSIO7MYuEoB5v6wP5uKYLHyNVAYPDrDa6m3lJ8ARqiKDBupg
 MZFwKBKho6Mf3ithCx6/au03o3/qq+C97wj7OI4mJUtTQ+khRbz/XHYlpDH1QE8X02Oy
 HhRg==
X-Gm-Message-State: AOAM533HLMo9YWqrE79RjOtvmefbpbvQT3RzTO1sk1sYSzr6BLZld9xz
 EysJC8d7H0MDTpiPvEkN7BIyDI8ZZEY=
X-Google-Smtp-Source: ABdhPJx68DiGu9zZ358kzXc3eyMq7s1B87KdQ74O8/ssmISTllenuW1qTVA9QP1zadQ42tiBq89ttg==
X-Received: by 2002:a5d:5281:: with SMTP id c1mr10925441wrv.184.1599771271551; 
 Thu, 10 Sep 2020 13:54:31 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t1sm5089317wmi.16.2020.09.10.13.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 13:54:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/7] hw/misc: Add LED device
Date: Thu, 10 Sep 2020 22:54:22 +0200
Message-Id: <20200910205429.727766-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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

Philippe Mathieu-Daudé (7):
  hw/misc/led: Add a LED device
  hw/misc/led: Allow connecting from GPIO output
  hw/misc/led: Emit a trace event when LED intensity has changed
  hw/arm/aspeed: Add the 3 front LEDs drived by the PCA9552 #1
  hw/misc/mps2-fpgaio: Use the LED device
  hw/misc/mps2-scc: Use the LED device
  hw/arm/tosa: Replace fprintf() calls by LED devices

 include/hw/misc/led.h         |  92 +++++++++++++++++++
 include/hw/misc/mps2-fpgaio.h |   2 +
 include/hw/misc/mps2-scc.h    |   2 +
 include/hw/qdev-core.h        |   8 ++
 hw/arm/aspeed.c               |  20 +++++
 hw/arm/tosa.c                 |  40 ++++-----
 hw/misc/led.c                 | 161 ++++++++++++++++++++++++++++++++++
 hw/misc/mps2-fpgaio.c         |  19 ++--
 hw/misc/mps2-scc.c            |  25 +++---
 MAINTAINERS                   |   6 ++
 hw/arm/Kconfig                |   2 +
 hw/misc/Kconfig               |   5 ++
 hw/misc/meson.build           |   1 +
 hw/misc/trace-events          |   6 +-
 14 files changed, 346 insertions(+), 43 deletions(-)
 create mode 100644 include/hw/misc/led.h
 create mode 100644 hw/misc/led.c

-- 
2.26.2


