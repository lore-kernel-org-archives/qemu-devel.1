Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C21BC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:40:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 641932064B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHH8Brp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641932064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJSU-00009L-J7
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJEx-0004fu-TG
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJEw-0006pN-4r
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:51 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:34882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiJEv-0006mQ-Ng
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:49 -0500
Received: by mail-wr1-x432.google.com with SMTP id g17so9612453wro.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WlE9SHjyOwKrzPjcb1LpM+O4CTPzniLXv8Mlk3tbLyA=;
 b=qHH8Brp4LhXcILR+fsHrEmxcSBnDlTJVnB9K5LSwZxM0kci4c8l1mO3EVq8YgiudZF
 76pysrQeZ8+XGykZ2fcAobunuBvTQgEINI5EDNAwpaUl3p6RDKdxKilkTOxEnVY582jG
 K2GB+gPxEI7PdIqENK9sm42YjUrydsGuauvFcyN26EfVCbGOqCHhT+E6NlBbxVd2WYCn
 IxbL6uz65K4Ld9H+4pCjGrKwAZ2w306HtRBPbxVJj7cqePIGObxBcL8fZAKXQ54XZ0Nu
 3zS984WfEP5aT4K1d58VhrizHcYq4gyVK+C+jMbCcfzx1neBy8nIVXV9hWxcuopltRu2
 5ofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WlE9SHjyOwKrzPjcb1LpM+O4CTPzniLXv8Mlk3tbLyA=;
 b=M+N6CVDcwXER79Z8HTraizmVbumc5yQe5J1tPh899HT03roRER5Hy3QXqEyHFolAUq
 uHVTfdKjID9VX/oMVvL5LO/oooBt6YtNpFpt6on301aO0+yMveEXLnIuC+7g17qBvgiA
 t8dBMxZ78wKXsTXRUSAfwz2ccGhrJpteGqebv6R64rKZyQ06glsX1hp3JMk23kCEH1qr
 ryZR8FDUezWZUbjnqWlVGq10eM2lh3xgyVYKGOKgkzfE4PgPPWUQrl22lY/Hgs9TkzkJ
 obHr93Q1EeN4HdsNtwjWzdbMf0zFTOjGaeJf/kJHGVlrfIth+fnIgwP1Z5lJV5u8A43K
 iclA==
X-Gm-Message-State: APjAAAV9jR5cep9OIh+7lNXxABF7BQ7tEvusaAmTnpPKGnLnKLn/7pFQ
 GU4vwHK3AT+pbYfC50lNUZASOss0ByUBMQ==
X-Google-Smtp-Source: APXvYqx4sC4T6LTu+9PXnWEDWsrrObdLv0In7IfY8QlR7G0QpyXIeBxFag1camZKZZW/ZcLAaRdrEQ==
X-Received: by 2002:adf:a285:: with SMTP id s5mr15476791wra.118.1576852007584; 
 Fri, 20 Dec 2019 06:26:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t5sm9741814wrr.35.2019.12.20.06.26.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 06:26:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] target-arm queue
Date: Fri, 20 Dec 2019 14:26:32 +0000
Message-Id: <20191220142644.31076-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One last arm pullreq before I stop work for the end of the year...

-- PMM

The following changes since commit 8e5943260a8f765216674ee87ce8588cc4e7463e:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-12-20 12:46:10 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191220

for you to fetch changes up to c8fa6079eb35888587f1be27c1590da4edcc5098:

  arm/arm-powerctl: rebuild hflags after setting CP15 bits in arm_set_cpu_on() (2019-12-20 14:03:00 +0000)

----------------------------------------------------------------
target-arm queue:
 * Support emulating the generic timers at frequencies other than 62.5MHz
 * Various fixes for SMMUv3 emulation bugs
 * Improve assert error message for hflags mismatches
 * arm-powerctl: rebuild hflags after setting CP15 bits in arm_set_cpu_on()

----------------------------------------------------------------
Andrew Jeffery (4):
      target/arm: Remove redundant scaling of nexttick
      target/arm: Abstract the generic timer frequency
      target/arm: Prepare generic timer for per-platform CNTFRQ
      ast2600: Configure CNTFRQ at 1125MHz

Niek Linnenbank (1):
      arm/arm-powerctl: rebuild hflags after setting CP15 bits in arm_set_cpu_on()

Philippe Mathieu-Daudé (1):
      target/arm: Display helpful message when hflags mismatch

Simon Veith (6):
      hw/arm/smmuv3: Apply address mask to linear strtab base address
      hw/arm/smmuv3: Correct SMMU_BASE_ADDR_MASK value
      hw/arm/smmuv3: Check stream IDs against actual table LOG2SIZE
      hw/arm/smmuv3: Align stream table base address to table size
      hw/arm/smmuv3: Use correct bit positions in EVT_SET_ADDR2 macro
      hw/arm/smmuv3: Report F_STE_FETCH fault address in correct word position

 hw/arm/smmuv3-internal.h  |  6 ++---
 target/arm/cpu.h          |  5 ++++
 hw/arm/aspeed_ast2600.c   |  3 +++
 hw/arm/smmuv3.c           | 28 +++++++++++++++-----
 target/arm/arm-powerctl.c |  3 +++
 target/arm/cpu.c          | 65 +++++++++++++++++++++++++++++++++++++++++------
 target/arm/helper.c       | 42 +++++++++++++++++++++++-------
 7 files changed, 125 insertions(+), 27 deletions(-)

