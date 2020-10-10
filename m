Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD14C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:39:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A0520795
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5WyRtrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A0520795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLdw-0003Qa-44
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLcC-0001wc-BH; Sat, 10 Oct 2020 16:37:16 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLc9-0006cU-SV; Sat, 10 Oct 2020 16:37:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id b8so938810wrn.0;
 Sat, 10 Oct 2020 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MKLhlBcr1fnaFhXqyra0aBMsEq9q6pGWKb7Q7VW2MGo=;
 b=r5WyRtrbPZYGegLj/GPuWHRcMJLVs7l23Uih3yKEthLwKYt9OOfYF93dqSi6Kjgdob
 rQ06Yu0+rkYmN3jmrFyqfI/mjMDCZYsRvIcbVy6r6c6g/rLiAjKvuy8SUbeqrrkJ34ER
 RKa/SRbnXLD0dKbfsbWjkVRo+N0zmpyPdGk4kQ6+ZOqpXnTXFyh+iVJ7vlCo1JuS/fFq
 jvdtiGSariFzBGGNaI+QFIOml2Tr4fPMJ4rlea6nBrW3DeHfaBS2kNTSRVbJHJ7kTK+N
 1dDhgXGn9o50GrCy5G5UIwB0mtKEe3hS3oTyoZqTFQ3AZgFWY2DNSlrZ9JdB0HU+djSy
 3BYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=MKLhlBcr1fnaFhXqyra0aBMsEq9q6pGWKb7Q7VW2MGo=;
 b=VFsk6cMGk9Ev+lrMUoizEyv4MlN9cDYiXVsrf18SGmAs0R0nEVcthE6DVOSCcQEbnc
 UOI45tk2dvT8iol4MwvMtk42yU75HJTFkwKPJ7ROGcSHhvwnW64J2ELoFjMPUDg0gJpX
 4M6P68StaDQmMkggvhrr7pFIvpoE9iaQpqmo1kVHxhyDVD/Iq42oMvHhvGOQ3Pofysh8
 UNQ35VqOAJQqi7ze81woajPy9q6/o3QcxN1TqPzT79uIEn5QwbY+IeUH3mtxOFArN3k7
 Mw7o6K4OC4rvdJJSSMVeIbhh1HRLFxP0EwPxg18zOZBuG7J68t4rTAxYjiGVwicZifnM
 uDHA==
X-Gm-Message-State: AOAM5337G51BBzGvXSBk4/bfwDQApC/Um+tIBMSzKAL56n0fXAyT1jrF
 owI93YFVFGjukyIPwyUZfitoRyR41Jo=
X-Google-Smtp-Source: ABdhPJywcYxh1D8ZACl7cpzGeOLrT+5b3i+93YKgpcL6+ktHfQOloELV2iueNMEZkb0ZWdqqx5D3Tg==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr12190928wrp.413.1602362231446; 
 Sat, 10 Oct 2020 13:37:11 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id v17sm5661341wru.44.2020.10.10.13.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:37:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/4] hw/arm/raspi: Fix SYS_timer to unbrick Linux kernels
 v3.7+
Date: Sat, 10 Oct 2020 22:37:05 +0200
Message-Id: <20201010203709.3116542-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In this series we implement the COMPARE registers of the
SYS_timer, since they are used by Linux.

This fixes the hang reported by Niek here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg682090.html

Since v3:
- Addressed Richard review comments (arithmetic fix)

Since v2:
- Fixed issue in COMPARE register reported by Luc

Since v1:
- Extracted unrelated patches to previous series
  (which happened to be mis-rebased)

Philippe Mathieu-Daudé (4):
  hw/timer/bcm2835: Introduce BCM2835_SYSTIMER_COUNT definition
  hw/timer/bcm2835: Rename variable holding CTRL_STATUS register
  hw/timer/bcm2835: Support the timer COMPARE registers
  hw/arm/bcm2835_peripherals: Correctly wire the SYS_timer IRQs

 include/hw/timer/bcm2835_systmr.h | 17 ++++++---
 hw/arm/bcm2835_peripherals.c      | 13 +++++--
 hw/timer/bcm2835_systmr.c         | 57 +++++++++++++++++++------------
 hw/timer/trace-events             |  6 ++--
 4 files changed, 64 insertions(+), 29 deletions(-)

-- 
2.26.2


