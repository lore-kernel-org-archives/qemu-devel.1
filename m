Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1E0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 05:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92077222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 05:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="1dfiysmA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r3gMZ47k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92077222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihoIZ-00066i-MI
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 00:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1ihoGv-0004RC-T1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 00:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1ihoGu-0002KV-NN
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 00:22:49 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:34549)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1ihoGr-0001qh-W4; Thu, 19 Dec 2019 00:22:46 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 484BA48A;
 Thu, 19 Dec 2019 00:22:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Thu, 19 Dec 2019 00:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=zuKq+gd9kj0a7Z5OXk24TRnL90
 uej/6n5NSnAPMTh4c=; b=1dfiysmAdVuiW+H66a6TqaGgwVWjvabLUNhHHumdEb
 /9ayqvF2MNj6IBKpPYPv0rc/NhVPsGDkFCJmGLxNsdgZkqUdHTRFbNHupccMKlsu
 KHl9N4vp0sjkSjLcABgJ0neOsUiD6SVaLbMJzo9AwkyInY5RaB6IbEUUx6VYhYDI
 dQaegEovgEtllR6NDETrnT1s682eG7dhpbCfk6XQ8bZmcF+mBzKJ/9baF6/JWKS0
 bdQUnxF5RNfwFJiRUThrbP8A2gRCjcum5rWi6O/1mYt737rB5HIL2h/Rgpq38Sm4
 5pARGrI3KfHxe+Fl5mvW3aQMTQfpjQSv7j/yypT8wcMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=zuKq+gd9kj0a7Z5OX
 k24TRnL90uej/6n5NSnAPMTh4c=; b=r3gMZ47kv3tQrmEtcnaNIYTYgmhp2ulM2
 IHKyA5K1lU5Cf8coVGSIRfhmM461VKMhJwFqXE3wy5JAirp0ljJ55tcY3sdxJyWN
 02uhoNIi/Exep7/8VYiOEzW9NKhVlo94SZwen/4DsWJZrpt0r1cmYqDcqAEadRby
 TvSM/sV9QZw1iV/S0QZkEEXzY81ADoTKG71rtJP7YclHsa77W4Amp9PCpf+jsR3S
 9Aum2jerrZeysMvZN7tcC/4wrPRcrL9jMy1LGehMjLOCBcxmcyAtQCV1jURMstdW
 ZbKMmMjHcEQ+v0YMhu7E/aB47OYmLCSen6/mQkuMyLQdM0VC/F3TQ==
X-ME-Sender: <xms:Ign7XXIyXBQwFZ_NELCMiIuuuCdmqBqJwKJ7OdwIR-Y9PUUOqoTdfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddutddgkeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
 segrlhhishhtrghirhdvfedrmhgvqeenucfkphepjeefrdelfedrkeegrddvtdeknecurf
 grrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhm
 vgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Ign7Xfbb0H71SLmHnMVVMJPZZw4MSW54M2AR3c6nKCCKJT7fjncXgQ>
 <xmx:Ign7XauY_4CcWk8R8aW7BuggLo1PxECHbVjx1Od4Ba0MG2rgAb1goQ>
 <xmx:Ign7XUusoKZdNYGg89sNuBSXqgqhjg8PV1qe5jC9_uxzMwcZ-ur3QQ>
 <xmx:Ign7XcYUJC6UGH0rvLE3yVQei7mhyNSHEOZgac_KA6RiQ-TBLQoNmg>
Received: from alistair-xps-14z.alistair23.me
 (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
 by mail.messagingengine.com (Postfix) with ESMTPA id AAF028005C;
 Thu, 19 Dec 2019 00:22:41 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 philmd@redhat.com
Subject: [PATCH v7 0/4]  Add the STM32F405 and Netduino Plus 2 machine
Date: Wed, 18 Dec 2019 21:22:40 -0800
Message-Id: <cover.1576658572.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 64.147.123.20
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

v7:
 - Fix the EXTI IRQ
 - Remove the duplicate configs
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
 hw/arm/Kconfig                     |  10 +
 hw/arm/Makefile.objs               |   2 +
 hw/arm/netduinoplus2.c             |  52 +++++
 hw/arm/stm32f405_soc.c             | 302 +++++++++++++++++++++++++++++
 hw/misc/Kconfig                    |   6 +
 hw/misc/Makefile.objs              |   2 +
 hw/misc/stm32f4xx_exti.c           | 188 ++++++++++++++++++
 hw/misc/stm32f4xx_syscfg.c         | 171 ++++++++++++++++
 hw/misc/trace-events               |  11 ++
 include/hw/arm/stm32f405_soc.h     |  73 +++++++
 include/hw/misc/stm32f4xx_exti.h   |  60 ++++++
 include/hw/misc/stm32f4xx_syscfg.h |  61 ++++++
 14 files changed, 953 insertions(+)
 create mode 100644 hw/arm/netduinoplus2.c
 create mode 100644 hw/arm/stm32f405_soc.c
 create mode 100644 hw/misc/stm32f4xx_exti.c
 create mode 100644 hw/misc/stm32f4xx_syscfg.c
 create mode 100644 include/hw/arm/stm32f405_soc.h
 create mode 100644 include/hw/misc/stm32f4xx_exti.h
 create mode 100644 include/hw/misc/stm32f4xx_syscfg.h

-- 
2.24.0


