Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C6EC2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 19:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8256C206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 19:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPPNTNET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8256C206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHBZM-0001Rd-FP
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 15:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBXz-0008A8-Ul
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 15:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBXy-0008Ge-QW
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 15:18:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBXy-0008Fe-Kg; Wed, 25 Mar 2020 15:18:38 -0400
Received: by mail-wm1-x343.google.com with SMTP id d1so4186648wmb.2;
 Wed, 25 Mar 2020 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CkPe9c7WtsqdNtQ1gIrLaLcoK0h9RvhM17e7zhHbNJ0=;
 b=XPPNTNEToSCPzF9RYiFistt/AyuGtTzjetGYj7RZU6CJ34srCCzuR+hcZqGawRHVjS
 v7Uhn0JoplmJG/Uzrok1/nKqwhJLt2b7M5JpwzdWWLXheMYI+iOrPqpxNL1qXj1hMfkS
 xo3dvBD10Fb4cf9SmCZuH5wtE0aFDaY4GpyleRETKqNomAgR1aDA1QvMQmEaQez+WVLL
 E/N5Vhgzlo5vCAnXPoWkC9DGDls9f9vj/JiaXWnPe+VGb2bnAtc4SVfvcZ5lYan4fNjf
 D1dDQ2R+mhJYu+Kv6Sak+5qpg0niyvjpQBbuWx6GJOPQ3OeIERx+7I2qCFL3YnUKkKj9
 YG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=CkPe9c7WtsqdNtQ1gIrLaLcoK0h9RvhM17e7zhHbNJ0=;
 b=QJ5uVfjhk4uWMUq0zDy9eGWyDoXxJdFZGZvrnVsmQSDOuZO2Q0a65kwq12d9Zemr0z
 R6U8q7rzHchV6U83slqpJO0++3uj0nBIY/W0A59N3PetV6Csj3w0RoqlufHfbuCExrcQ
 2AgMUZqytdA5ISnnRDF/vIO4PcjgS/ZN5Ir/RsSVzZN4HbW3ycgu/rnv1Y+nyBf8WeBq
 aTr9vbfnXXQnbuRgufZudYr/eNuvKWOYpQJ/saNUHpD2I7T/7hMt6bZelkIMhvoBwBQd
 4bcIxIv4zWfjDX7eiC1unr2V4UmaXQzSCjrMe2T+0J264xdxtw37TsW57r/L0H4QESoQ
 sa/A==
X-Gm-Message-State: ANhLgQ0S70/tcHISxAgz1x7+gzJHnpkv0jC3zPso2BhnsVUxlPW8NxWf
 Nyae0rbzWVgmZcJuBDiMbARsbSjCkGA=
X-Google-Smtp-Source: ADFU+vu4Prm9QXq4qTH5OQBnEVGpDvhSS7WGWWe1lxLJHnTVcwZ+YzxFQUeEJzIvEU/NnGcnQr4VIA==
X-Received: by 2002:a05:600c:24d2:: with SMTP id
 18mr4767560wmu.38.1585163914865; 
 Wed, 25 Mar 2020 12:18:34 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id r17sm6345672wrx.46.2020.03.25.12.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 12:18:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 00/12] hw: Add missing error-propagation code
Date: Wed, 25 Mar 2020 20:18:18 +0100
Message-Id: <20200325191830.16553-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series is inspired of Peter fix:
"hw/arm/xlnx-zynqmp.c: fix some error-handling code"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg691636.html

Add a cocci script to fix the other places.

Based-on: <20200324134947.15384-1-peter.maydell@linaro.org>

Philippe Mathieu-Daud=C3=A9 (12):
  scripts/coccinelle: Add script to catch missing error_propagate()
    calls
  hw/arm/bcm2835_peripherals: Add missing error-propagation code
  hw/arm/fsl-imx: Add missing error-propagation code
  hw/arm/stm32fx05_soc: Add missing error-propagation code
  hw/i386/x86: Add missing error-propagation code
  hw/dma/xilinx_axidma: Add missing error-propagation code
  hw/mips/cps: Add missing error-propagation code
  hw/mips/boston: Add missing error-propagation code
  hw/mips/mips_malta: Add missing error-propagation code
  hw/misc/macio/macio: Add missing error-propagation code
  hw/net/xilinx_axienet: Add missing error-propagation code
  hw/riscv/sifive_u: Add missing error-propagation code

 ...ect_property_missing_error_propagate.cocci | 58 +++++++++++++++++++
 hw/arm/bcm2835_peripherals.c                  |  8 +++
 hw/arm/fsl-imx25.c                            |  8 +++
 hw/arm/fsl-imx6.c                             |  8 +++
 hw/arm/stm32f205_soc.c                        |  4 ++
 hw/arm/stm32f405_soc.c                        |  4 ++
 hw/dma/xilinx_axidma.c                        |  3 +
 hw/i386/x86.c                                 |  4 ++
 hw/mips/boston.c                              | 17 ++----
 hw/mips/cps.c                                 | 52 +++++++++++++++++
 hw/mips/mips_malta.c                          | 19 ++++--
 hw/misc/macio/macio.c                         |  4 ++
 hw/net/xilinx_axienet.c                       |  3 +
 hw/riscv/sifive_u.c                           |  8 +++
 14 files changed, 184 insertions(+), 16 deletions(-)
 create mode 100644 scripts/coccinelle/object_property_missing_error_propagat=
e.cocci

--=20
2.21.1


