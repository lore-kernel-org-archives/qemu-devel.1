Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A759C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1AD5207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsE9sT9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AD5207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKCuY-0005lg-MM
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 23:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKCsx-0004Kb-RJ; Sun, 20 Sep 2020 23:53:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKCsv-0002z1-UJ; Sun, 20 Sep 2020 23:53:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id k15so11153731wrn.10;
 Sun, 20 Sep 2020 20:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eMGxJsP/XV9ZaclU9UPc3RpZWVI8bwkuQY3IaryKxOg=;
 b=WsE9sT9jXWXrmtRZi9y2glEVJzIZYpOORuh2yRP51CQFdsBxjzppWiQAxPG4D3DaKe
 eyhkW+JRTyVy5mPumgaHwZmeEg0CgG6t8if+/OZtpW9TpLL00w/VAC4QN/r9Kb0f5H3/
 66WQUgGS9Fp+j+lei7oRAEMWIfwM/ZTyQqJPEZGM7KYCtBeSu33cjJywkaMELUwTdIMY
 V/QyHH17P1zV80vfpEu9JtZS6IxrOq5qvWUGqmetP54tUwjYkRnCxfGY8YKNspWxbk+A
 vwHsy8pKcV0dcwir7dIy0C0Gpug5Rot5DIjAijel6B4flPYPJY+Gz5bD7gkZpJOpSlBq
 9yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=eMGxJsP/XV9ZaclU9UPc3RpZWVI8bwkuQY3IaryKxOg=;
 b=RvcO+QfLbi/rwFH82AGLkjKqESvEHd7GkYVO+iyn8SFQ2xlI4bpr5ie8Y++iVKOFf2
 kyKwgSkvCnPJ27yJuEJ8+bSfbUcRDZlSSncZhGg25xYhdwULxH4hy0bSVEtsF0CU12jY
 sRQx6BvvWwf4ZAVgxbP04h9STK/v+MqA9S/xlg7btrvTAQykttMKuZ649aBgu7qV4j8e
 8Wn+889y7U+AtFceG/oqufz3V5ul8zgUC70GnVKn5g1/L0JrKr8jNxTVzi5fozLFbrdG
 oGLIm9kgiemv2s24jmVm0h9CmUL3d6+bje86tYvLz5P1yBnlyOaoAN2YGmYbPQ2whXrb
 yV6g==
X-Gm-Message-State: AOAM533qDVVtGiW4rlJFH06hz3EirIEahapqcLqzNZy8JInzJQvU+XER
 +ZySuuo3fE5+FRqKNN6aQgeQblUdNG4=
X-Google-Smtp-Source: ABdhPJxU9pafd02i5UXWr3h+GSnIn8Nsc0ed9XCHmtS7oaaEfo+2qTQSRQgDzyCsehgY0EgVDqrl9g==
X-Received: by 2002:a5d:680b:: with SMTP id w11mr53323417wru.73.1600660379770; 
 Sun, 20 Sep 2020 20:52:59 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a17sm19633754wra.24.2020.09.20.20.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 20:52:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] hw/arm/raspi: Fix SYS_timer to unbrick Linux kernels
 v3.7+
Date: Mon, 21 Sep 2020 05:52:52 +0200
Message-Id: <20200921035257.434532-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In this series we implement the COMPARE registers of the
SYS_timer, since they are used by Linux.

This fixes the hang reported by Niek here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg682090.html

Since v1:
- Extracted unrelated patches to previous series
  (which happened to be mis-rebased)

Based-on: <20200921034729.432931-1-f4bug@amsat.org>
Supersedes: <20200920175825.417680-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (5):
  hw/intc/bcm2835_ic: Trace GPU/CPU IRQ handlers
  hw/timer/bcm2835: Introduce BCM2835_SYSTIMER_COUNT definition
  hw/timer/bcm2835: Rename variable holding CTRL_STATUS register
  hw/timer/bcm2835: Support the timer COMPARE registers
  hw/arm/bcm2835_peripherals: Correctly wire the SYS_timer IRQs

 include/hw/timer/bcm2835_systmr.h | 17 ++++++++---
 hw/arm/bcm2835_peripherals.c      | 13 ++++++--
 hw/intc/bcm2835_ic.c              |  4 ++-
 hw/timer/bcm2835_systmr.c         | 50 ++++++++++++++++++-------------
 hw/intc/trace-events              |  4 +++
 hw/timer/trace-events             |  4 ++-
 6 files changed, 64 insertions(+), 28 deletions(-)

-- 
2.26.2


