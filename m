Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFCEC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 06:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8B9206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 06:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="0d7M8j2O";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U4Btvgu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8B9206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i67Ty-0003d2-Ut
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 02:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1i67SY-0002UA-8T
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1i67SX-0003ir-7R
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49379)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1i67SW-0003he-Te
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:01 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 3380921FA7;
 Fri,  6 Sep 2019 02:10:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 06 Sep 2019 02:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=from:to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=fm2; bh=U7DYFrdykQUdBtxzrmhN8VuuQJ
 axpApsQx7wVRkkV7c=; b=0d7M8j2OTNa/v8OVabDyowXyb+IrEua+SuqebpBOi4
 FgL5FLSiVSJFEQjeKnG6OlRjEPM0ngLpI8/BJwZ5bdXETgzaUFuwLCAGkYUWQJNK
 KGVZQqBKUG57WgD5yf+PG9XaONkUwXHbqBHz7Y0wvciJaljeMMrVCKO7R9OlT/Tb
 tclgGoR3xzR5dRWEgE2XlrLa79NSxb0d1mggYaLU2Z8u+owqAysHi6w9ge3HnaxU
 NW37WpWEOB39HpQiiS2ZFQLlO+1O6LEI4tbkx7YZL8mBuP3kX8FAtxtyJNXLDVEe
 QAWQYStg3E5UZYej8XahTekY2PGY07vrwgXOftlbppZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=U7DYFr
 dykQUdBtxzrmhN8VuuQJaxpApsQx7wVRkkV7c=; b=U4Btvgu186JZD2nSGtFvxY
 c9xdJn4isVi+h0JivhKXWX7jMlEY51LKow6ByvHNmo5XneD1TSAg3wdhX6WUkkeo
 s5W9chflPCc9G3puUZCxeFO0b8I4QH/gYpyzkWE+jP1F7EdgzQ1HBOLklW9lJtOl
 29fe8201TWM9xdJ/DKoVY2NMllYhgu4/mszG07iS0Hvuw1e7BCSYfjnRajTsytiV
 CAJSHPteRsF6C4ud22P/PCi/cDFiMvM5fEhb6KOLe9bSdVXchjVZOH213VnGvE/A
 YxjOk+CpVIdsCtb8RdcgZSNBXn4vWc5BaDdGr7nKVLPcv02ZjJ9JpCydN2KmmqPA
 ==
X-ME-Sender: <xms:cfhxXQt4RF80NDJVNsrfICc-lFP3WaRXd6beu2t-LG1hgt1L8i1qbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejkedgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtkeertd
 ertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
 rhesrghlihhsthgrihhrvdefrdhmvgeqnecukfhppeejfedrleefrdekgedrvddtkeenuc
 frrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedr
 mhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:cfhxXVFa_7sbmgnt_TaG0TKQxXmkoM0qObou-SQbo2XHbCAktac2sw>
 <xmx:cfhxXZY184WoDq7X2UlKwXOGqTaFNU7yEk1gYgU8Yyq8wwUVwk6q5Q>
 <xmx:cfhxXdVSh5ghoEZUluh_HztwHBHwpRQdrHvCi9OnYmCnyKjiR9Q8yw>
 <xmx:cvhxXX3zptVIFqEriFSJCrbW0s0e3xZmWGja15FSCzRkOe4sGg90pA>
Received: from alistair-xps-14z.alistair23.me
 (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
 by mail.messagingengine.com (Postfix) with ESMTPA id 36248D6005D;
 Fri,  6 Sep 2019 02:10:57 -0400 (EDT)
From: Alistair Francis <alistair@alistair23.me>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Thu,  5 Sep 2019 23:10:56 -0700
Message-Id: <cover.1567750222.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.25
Subject: [Qemu-devel] [PATCH v4 0/6] Add the STM32F405 and Netduino Plus 2
 machine
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
Cc: alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Now that the Arm-M4 CPU has been added to QEMU we can add the Netduino
Plus 2 machine. This is very similar to the STM32F205 and Netduino 2 SoC
and machine.

v4:
 - Rebase on master
v3:
 - Remove custom reset handler
 - Add init-entry and init-sp properties
 - Rebase on master (including Kconfig changes)
v2:
 - Reorder patchset
 - Return the kernel entry point instead of using a pointer
 - Address Peter's comments


Alistair Francis (6):
  armv7m: Allow entry information to be returned
  target/arm: Allow setting M mode entry and sp
  hw/misc: Add the STM32F4xx Sysconfig device
  hw/misc: Add the STM32F4xx EXTI device
  hw/arm: Add the STM32F4xx SoC
  hw/arm: Add the Netduino Plus 2

 MAINTAINERS                        |  14 ++
 default-configs/arm-softmmu.mak    |   1 +
 hw/arm/Kconfig                     |  16 ++
 hw/arm/Makefile.objs               |   2 +
 hw/arm/armv7m.c                    |   4 +-
 hw/arm/netduinoplus2.c             |  58 ++++++
 hw/arm/stm32f405_soc.c             | 301 +++++++++++++++++++++++++++++
 hw/misc/Kconfig                    |   6 +
 hw/misc/Makefile.objs              |   2 +
 hw/misc/stm32f4xx_exti.c           | 187 ++++++++++++++++++
 hw/misc/stm32f4xx_syscfg.c         | 168 ++++++++++++++++
 hw/misc/trace-events               |  11 ++
 include/hw/arm/boot.h              |   4 +-
 include/hw/arm/stm32f405_soc.h     |  73 +++++++
 include/hw/misc/stm32f4xx_exti.h   |  60 ++++++
 include/hw/misc/stm32f4xx_syscfg.h |  61 ++++++
 target/arm/cpu.c                   |  52 ++++-
 target/arm/cpu.h                   |   3 +
 18 files changed, 1016 insertions(+), 7 deletions(-)
 create mode 100644 hw/arm/netduinoplus2.c
 create mode 100644 hw/arm/stm32f405_soc.c
 create mode 100644 hw/misc/stm32f4xx_exti.c
 create mode 100644 hw/misc/stm32f4xx_syscfg.c
 create mode 100644 include/hw/arm/stm32f405_soc.h
 create mode 100644 include/hw/misc/stm32f4xx_exti.h
 create mode 100644 include/hw/misc/stm32f4xx_syscfg.h

-- 
2.22.0


