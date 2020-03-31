Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFBDC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDE3208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpP+ysRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDE3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJEVa-0003pA-BB
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 06:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJETx-0002Ll-Jc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJETw-0006EQ-Cf
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:50:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJETw-0006DK-4l
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:50:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id m17so25252076wrw.11
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 03:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lJqcVg1nkmfnugvWLqOmYqnLVrllS1d2tf91/cbFWCE=;
 b=GpP+ysRLnV0s20kXUN2ZO6HKsIUTEw5CxqtRUfeR/8y6i5onRLgRDtQRWkBrRiCBa6
 XTeyTUyZCeiaVTezQSQi1Nqe1a6PeD2Ya+9tQxypKfOudWBVOaQ+94WZ6q0Rm9vHWga5
 KbnC3QtCAn8mEiJKvjknuC+WfXB6gNtScySRF+R7yH0pPWDX5xTeBr5RqN2Vgfy4u/P2
 V4e+Q3t+9IQwtmWdfDrSMzGGISc4tSEKxVGAZ2M9JekVDP9JnH4fueX85UOOi1Y6eeXh
 rmC4bxpm6+Px0u4SyFmDqn7yyZtZMxdvxCfqc7rb44KN41RxHJ4/TTRA8Wunol9B8LpK
 h6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=lJqcVg1nkmfnugvWLqOmYqnLVrllS1d2tf91/cbFWCE=;
 b=iK8h7aqKtJOvfXgvVxtCsjFW4A+o3wAnyQ/fHkyPI1e41BJAVOEhN+lZrXoX3L8UuL
 I8/CMXH27MInUC9QHltrV53S5oO69Y9rms0MU4du5iyPzIvIqzUwuD6LvAzEVibxAi9u
 YdaGByIxbjHiY0+a38QK3+Idk5lwWzzy9unv1F8gHAw17EDTJTZrZ93NoYkJiRm18P/L
 RA2je/xmJtVpEorNDdogZSV9bnp50oZ34dpLtP/U+yuiFr9eMQTuxak+o9aihobbW1A6
 6wkFn1irdkx2QTWSlX1gSPmy5QiUxdIn7B2NUKsf4JtNzJxvRWu2cTDgvZ4lrTn/5Du6
 VJeg==
X-Gm-Message-State: ANhLgQ3PKPPKTbRSdzDXbKgHXtJB48/bmWtwAnlybZxiB77jzqapt+tG
 fvV7GyBUG89rw7hih/6TXQRVeuSBpDs=
X-Google-Smtp-Source: ADFU+vtY6FRQLuswX7yS1SdXSGoJVm9WM66ygBROrJo8kbkNtDb3EpT+xvRisA4pPKbkN/VVZunzqQ==
X-Received: by 2002:a05:6000:1205:: with SMTP id
 e5mr21104439wrx.73.1585651854684; 
 Tue, 31 Mar 2020 03:50:54 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id w3sm26042830wrn.31.2020.03.31.03.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 03:50:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] hw/sparc/leon3: Few fixes and disable HelenOS test
Date: Tue, 31 Mar 2020 12:50:41 +0200
Message-Id: <20200331105048.27989-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Leon3Machine.test_leon3_helenos_uimage has been running
erratically since some time now. Time to disable it (at least
until we make it reliable).
Few other patches added while tracking the issue.

Philippe Mathieu-Daudé (7):
  tests/acceptance/machine_sparc_leon3: Disable HelenOS test
  hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to AHB PnP
    registers
  hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses
  hw/misc/grlib_ahb_apb_pnp: Add trace events on read accesses
  hw/timer/grlib_gptimer: Display frequency in decimal
  target/sparc/int32_helper: Remove DEBUG_PCALL definition
  target/sparc/int32_helper: Extract and use excp_name_str()

 hw/misc/grlib_ahb_apb_pnp.c             | 24 ++++++++++++++++++++++--
 target/sparc/int32_helper.c             | 23 ++++++++++++-----------
 hw/misc/trace-events                    |  4 ++++
 hw/timer/trace-events                   |  2 +-
 tests/acceptance/machine_sparc_leon3.py |  4 ++++
 5 files changed, 43 insertions(+), 14 deletions(-)

-- 
2.21.1


