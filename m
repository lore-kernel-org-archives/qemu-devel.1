Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC78C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 02:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1B3214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 02:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="MIw5L06f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pLtyoae1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1B3214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifxR6-0005K8-MN
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 21:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1ifxPr-0004D3-JI
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 21:44:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1ifxPq-0000eJ-Ek
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 21:44:23 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34275)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1ifxPn-0000Rh-5I; Fri, 13 Dec 2019 21:44:19 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 8D01D2243F;
 Fri, 13 Dec 2019 21:44:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Fri, 13 Dec 2019 21:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=NrkT0Bf96hpTUP4A7dCfRMzsYs
 Uhcjmd2DZMl2Q/4Cs=; b=MIw5L06fz+tyB9cNCuJpzFCPEjQ3Yn4ZEIONPSvMyy
 BIKT2VrFu5spkh0TAvN0etm1v7LAXQ6QgdoluzIPAkADs2rQzFGvRFwFaMQRifd0
 2xoIyZZUxm378sy5iSvomWuGx1gZc3qq+K3v2OtX5JyPIu9DqhKjzNXQ/p+gqoFR
 pMRLg2t7gptsXDZJWSsuTMMjzlDV/c9TBvTU1RGdKPBN9Wsvi0ByW0OIx4S+RWyz
 ajYwKuKZBN/G9k16JQCd5+lM7NhMPBBx6FsJgV3fV5at0Xv6bNt8SF2RxXZ0K+Sz
 yv6AOw4ToRv7ZI3EayITCbskF/zioY5dP3g1r0Hj6ONA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=NrkT0Bf96hpTUP4A7
 dCfRMzsYsUhcjmd2DZMl2Q/4Cs=; b=pLtyoae1dRqgjU3UzyxuQC94yw5HW5Ms4
 WTrzx3DrblYi32UlG469jVZty45S2mjoSpHyuij0Tv8A2cscfuaRuczCTuAJ5nXk
 JdOXksikNUA7pXhhkQt+R1asMMV5RWZ1Q/43+KfHvrMwEIvlwzE2AtstbGENaWtU
 5mv67ZgzhknNweKTxMM/uDvF5vbDgPmYwfB63TcOL+wEwaWCJn8v4YoVdB8XzWU8
 KbhIf0MT15y1pquNhVIKOURHZIoxB3j6CpgbIt235VRL3xSD/+pUVoh+Ux2uLnUN
 SNaErOqwbVHb+t7WTBk1VOG7LE25a6uIZVLNQ3ZiTNIRZMcEsdbIg==
X-ME-Sender: <xms:gEz0XbrE-2K4tjkmnKIky7DmeMC0FY6jJj5FiTWw_HpFAoInuDDE3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddttddggeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
 segrlhhishhtrghirhdvfedrmhgvqeenucfkphepjeefrdelfedrkeegrddvtdeknecurf
 grrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhm
 vgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:gEz0XXJ7S8Kxczt1a5UIZ4QtgCvf3QBjPAS5FI5h_9jAPrxPFNBL0w>
 <xmx:gEz0XV3UyVYwnzgHD42abuHBEsYuO4CIc6UkNz3ZK_JMDYtcERPTdg>
 <xmx:gEz0XWWsNsFHhMXTrzfShJtX5qYJ47ut5b26GMdfvWM3CbI3CIHU6g>
 <xmx:gEz0XWIJDSZFgCesLJ9B395pehVupF2-NA1YDLGUq6maQoeN2s5rSw>
Received: from alistair-xps-14z.alistair23.me
 (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
 by mail.messagingengine.com (Postfix) with ESMTPA id 82A5680061;
 Fri, 13 Dec 2019 21:44:15 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v6 0/4]  Add the STM32F405 and Netduino Plus 2 machine
Date: Fri, 13 Dec 2019 18:44:14 -0800
Message-Id: <cover.1576227325.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.29
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
Cc: alistair23@gmail.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the Arm-M4 CPU has been added to QEMU we can add the Netduino
Plus 2 machine. This is very similar to the STM32F205 and Netduino 2 SoC
and machine.

v6:
 - Remove machine specific reset code
 - Rebase on master
v5:
 - Fix checkpatch failures
 - Add mising includes
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

Alistair Francis (4):
  hw/misc: Add the STM32F4xx Sysconfig device
  hw/misc: Add the STM32F4xx EXTI device
  hw/arm: Add the STM32F4xx SoC
  hw/arm: Add the Netduino Plus 2

 MAINTAINERS                        |  14 ++
 default-configs/arm-softmmu.mak    |   1 +
 hw/arm/Kconfig                     |  16 ++
 hw/arm/Makefile.objs               |   2 +
 hw/arm/netduinoplus2.c             |  52 +++++
 hw/arm/stm32f405_soc.c             | 302 +++++++++++++++++++++++++++++
 hw/misc/Kconfig                    |   6 +
 hw/misc/Makefile.objs              |   2 +
 hw/misc/stm32f4xx_exti.c           | 189 ++++++++++++++++++
 hw/misc/stm32f4xx_syscfg.c         | 171 ++++++++++++++++
 hw/misc/trace-events               |  11 ++
 include/hw/arm/stm32f405_soc.h     |  73 +++++++
 include/hw/misc/stm32f4xx_exti.h   |  60 ++++++
 include/hw/misc/stm32f4xx_syscfg.h |  61 ++++++
 14 files changed, 960 insertions(+)
 create mode 100644 hw/arm/netduinoplus2.c
 create mode 100644 hw/arm/stm32f405_soc.c
 create mode 100644 hw/misc/stm32f4xx_exti.c
 create mode 100644 hw/misc/stm32f4xx_syscfg.c
 create mode 100644 include/hw/arm/stm32f405_soc.h
 create mode 100644 include/hw/misc/stm32f4xx_exti.h
 create mode 100644 include/hw/misc/stm32f4xx_syscfg.h

-- 
2.24.0


