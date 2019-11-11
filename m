Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233ADC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4ED2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R28FXNX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4ED2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUADx-0000oH-Oc
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 08:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUACm-00083u-QA
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUACl-0006LS-By
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:58:08 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUACl-0006L0-4f
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:58:07 -0500
Received: by mail-wr1-x441.google.com with SMTP id e6so14808510wrw.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 05:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vn/LS1QxQ3Jo7PPa3q2DW5VUSUkioX+p/q5lP9sToUs=;
 b=R28FXNX47v/QaSSXjwONwSJcJ6s8RfEPxc1mh5jrE2b+skULPmBTszUhEeyNkLVtqm
 Ib/Fc/AY7xKGTx12t5CBPZo102itjq9HrEnp6fDp/QOihi7P804lyAejzDJJ6O8dOnln
 6oBZo8DlMyRfQcpE74IBB7gzfP79akDfvz3GUdPSY+AXVX9mwJZ8Sn67Y67210iLXP+D
 6LfPuqaY8p4KxVBP686Rg96/Mzbbk9PvYSRVRIPhziqCHg4iSMWSlDUEfJu46GgY5UHn
 QUIISUO6m73nHPDh695TrNrFLyjCMU+Wahb+9Qzeu+CzOPTCx7BpmA5Ah79CgnXzxuzv
 t8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vn/LS1QxQ3Jo7PPa3q2DW5VUSUkioX+p/q5lP9sToUs=;
 b=lW3sWPxdChlAPgzHHQ2ec2ghHXvTcRwL/v5Z8N7dmzB/CY1YzJhcu2W2ohyUibdXX/
 wOerdaewn0KwbEiAkO/qZRPIkrMQC6p1uOZoOyMXUSAUfzV/T3eLQTeMS4/WhF2ZfM/j
 7aLqJKaS4Qj1qlASwOG7moyI3r0YYfzi+uRUo7Da2rGb7PmpEKtO6TN6LmSPPGE6xejA
 VHzAh8TqYiJAPxJ3hB8GQgNmXBvmawsudAnJmMRM7kf4pSMd80SgSL/YmlfZUTL7bPfd
 Kjs3ahi1YVT2sRz9MReDaY8ngDZJxiN3+6Wz1ISTqn+S1M3jMUqjAKu11KPnWBHH7+Vp
 U4HQ==
X-Gm-Message-State: APjAAAVN7yAib516ss5nXI9oIBzzmP7o235I8o4xUS7J8B6Mk/odIEqy
 BrqSekzHatIIEdElRqW1DZwylmi+7iLKfw==
X-Google-Smtp-Source: APXvYqz2CAWE6tiPFEArsGPMaPXByz0IPB+qHOz/QOLxDLXSh9zyTY4f4miCVFNHTw1w6zKCP9BAGg==
X-Received: by 2002:adf:fd45:: with SMTP id h5mr22960795wrs.388.1573480685534; 
 Mon, 11 Nov 2019 05:58:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t29sm20544857wrb.53.2019.11.11.05.58.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 05:58:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] target-arm queue
Date: Mon, 11 Nov 2019 13:58:00 +0000
Message-Id: <20191111135803.14414-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Arm patches for rc1:
 * two final "remove the old API" patches for some API transitions
 * bugfix for raspi/highbank Linux boot

thanks
-- PMM

The following changes since commit 654efcb511d394c1d3f5292c28503d1d19e5b1d3:

  Merge remote-tracking branch 'remotes/vivier/tags/q800-branch-pull-request' into staging (2019-11-11 09:23:46 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191111

for you to fetch changes up to 45c078f163fd47c35e7505d98928fae63baada7d:

  hw/arm/boot: Set NSACR.{CP11, CP10} in dummy SMC setup routine (2019-11-11 13:44:16 +0000)

----------------------------------------------------------------
target-arm queue:
 * Remove old unassigned_access CPU hook API
 * Remove old ptimer_init_with_bh() API
 * hw/arm/boot: Set NSACR.{CP11, CP10} in dummy SMC setup routine

----------------------------------------------------------------
Clement Deschamps (1):
      hw/arm/boot: Set NSACR.{CP11, CP10} in dummy SMC setup routine

Peter Maydell (2):
      ptimer: Remove old ptimer_init_with_bh() API
      Remove unassigned_access CPU hook

 include/hw/arm/boot.h |  7 ++--
 include/hw/core/cpu.h | 24 --------------
 include/hw/ptimer.h   | 45 ++++++++++++-------------
 accel/tcg/cputlb.c    |  2 --
 hw/arm/boot.c         |  3 ++
 hw/core/ptimer.c      | 91 +++++++++------------------------------------------
 memory.c              |  7 ----
 7 files changed, 44 insertions(+), 135 deletions(-)

