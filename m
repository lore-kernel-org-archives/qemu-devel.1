Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D7AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC858207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0HcTDya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC858207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLku-0002mB-Rh
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLi9-0000Kp-Ko
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:25 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:51945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLi7-0007Qu-II
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:25 -0400
Received: by mail-wm1-x336.google.com with SMTP id d81so13302326wmc.1
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JB23WwQ5sh4Be/RL0uDTqxpLGhSoKkDGl+5kb83bWNs=;
 b=R0HcTDyaqgFvaFIdehyp6q9jGpIRew4uIkhZf650hYrV4Ns9oJVyNu4+ZQzJyco74b
 CbU+EktP9qZCRI3/leV04J/A9BPBfrVaiDfOwsQwRZQbMmq+9HpZPb2PpzqKQUMjxM3u
 yidJWPzRqoCFxT4Hy3Ln6LC5Qmq4JUv9N3BW8LBFwXwF7ip5m/pqEoU4C6r3pYHREVsA
 1dcIDANFlEGKjhAaxaWAodCD0FHJgyIA8k5cBtUGwX6UZYCmtWZj8XRmMsvnusU6W9z2
 TwB4tLbfHMjbPPt8wEdm2DWSclNsRboAqa93PWKTOXbMnuvI7VcZsO6v701RewkYnGg+
 Rftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=JB23WwQ5sh4Be/RL0uDTqxpLGhSoKkDGl+5kb83bWNs=;
 b=DclM26sFLJXApzMmGdV4DH7oZR652spp6RR6xbvF6JEFupUXC1t9ilctU7HCsDRK3s
 PmUdG0Ksz0UYEHbZlq//te+aFO/YQQbwwJMbVv2s0snI0jhvOK+WU89TtIZpQPm/FWwW
 C3wqqsMtprdONi7TrB9hQF0UU8Sx+0bhzQNdu8DgQKouTdU2OjZQeRVbcRvcBYESIhku
 cG2kDulWOKbKKfMiYqCQDR3lub//3VGA3PXpK6z0HRakwT8vUMnFt99tqWMVfAhxTnzD
 /zCVnJG4iy37JjHNkBdSGcdcTRT8fywYxt4KWgenvC1IciPaT2A6FQYJYeF07OrgpcB/
 Zq+g==
X-Gm-Message-State: AOAM532LpdRLJQRyQGVRyK5bJr64T9Xitp0TFUX0LQqZHflwpLVwHSJs
 74huSq+3yHvhbFdoRG2FQXjioZVsUJ0=
X-Google-Smtp-Source: ABdhPJzkfsIL5pGUhQRLxuHVnRQ6qyVnTDTBuHfdC9C2Mpzc77wd4E1tIUhaZwqr2dQIukRUoxKMbA==
X-Received: by 2002:a1c:1dc3:: with SMTP id d186mr3795292wmd.182.1602362601573; 
 Sat, 10 Oct 2020 13:43:21 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/20] hw/mips: Set CPU frequency
Date: Sat, 10 Oct 2020 22:42:59 +0200
Message-Id: <20201010204319.3119239-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x336.google.com
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v2:
- Renamed "clk" -> "clk-in"
- Renamed "cpuclk-out -> "cpu-refclk"

Missing review: patches 6-20

~~~

All the MIPS cores emulated by QEMU provides the Coproc#0
'Count' register which can be used as a free running timer.

Since it's introduction in 2005 this timer uses a fixed
frequency of 100 MHz (for a CPU freq of 200 MHz).
While this is not an issue with Linux guests, it makes
some firmwares behave incorrectly.

The Clock API allow propagating clocks. It is particularly
useful when hardware dynamicly changes clock frequencies.

To be able to model such MIPS hardware, we need to refactor
the MIPS hardware code to handle clocks.

This series is organized as follow:

1/ qdev/clock patches already reviewed but not merged

2/ refactor the CP0 timer period to allow dynamic changes

3/ MIPS CPU get an optional input clock

4/ set correct CPU frequencies to all boards

I used a MIPSsim test suggested by Thomas.
The test is available on the list:
https://mid.mail-archive.com/20200928171539.788309-17-f4bug@amsat.org

Possible follow up:
- QOM'ify the GIC
- let the GIC handle dynamic clock changes

Regards,

Phil.

Luc Michel (1):
  hw/core/clock: add the clock_new helper function

Philippe Mathieu-Daudé (19):
  util/cutils: Introduce freq_to_str() to display Hertz units
  qdev-monitor: Display frequencies scaled to SI unit
  hw/qdev-clock: Display error hint when clock is missing from device
  target/mips: Move cpu_mips_get_random() with CP0 helpers
  target/mips/cp0_timer: Explicit unit in variable name
  target/mips/cp0_timer: Document TIMER_PERIOD origin
  target/mips: Move cp0_count_ns to CPUMIPSState
  target/mips/cpu: Calculate the CP0 timer period using the CPU
    frequency
  target/mips/cpu: Make cp0_count_rate a property
  target/mips/cpu: Allow the CPU to use dynamic frequencies
  hw/mips/r4k: Explicit CPU frequency is 200 MHz
  hw/mips/fuloong2e: Set CPU frequency to 533 MHz
  hw/mips/mipssim: Correct CPU frequency
  hw/mips/jazz: Correct CPU frequencies
  hw/mips/cps: Expose input clock and connect it to CPU cores
  hw/mips/boston: Set CPU frequency to 1 GHz
  hw/mips/malta: Set CPU frequency to 320 MHz
  hw/mips/cps: Do not allow use without input clock
  target/mips/cpu: Display warning when CPU is used without input clock

 include/hw/clock.h       | 13 ++++++++++
 include/hw/mips/cps.h    |  2 ++
 include/qemu/cutils.h    | 12 ++++++++++
 target/mips/cpu.h        | 14 +++++++++++
 target/mips/internal.h   |  2 +-
 hw/core/clock.c          | 15 ++++++++++++
 hw/core/qdev-clock.c     | 11 +++++++++
 hw/mips/boston.c         | 13 ++++++++++
 hw/mips/cps.c            |  9 +++++++
 hw/mips/fuloong2e.c      |  8 ++++++-
 hw/mips/jazz.c           | 16 ++++++++++++-
 hw/mips/malta.c          | 20 +++++++++++++---
 hw/mips/mipssim.c        | 12 +++++++++-
 hw/mips/r4k.c            |  8 ++++++-
 qdev-monitor.c           |  8 ++++---
 target/mips/cp0_helper.c | 25 ++++++++++++++++++++
 target/mips/cp0_timer.c  | 51 ++++++++++------------------------------
 target/mips/cpu.c        | 42 ++++++++++++++++++++++++++++++++-
 util/cutils.c            | 14 +++++++++++
 19 files changed, 245 insertions(+), 50 deletions(-)

-- 
2.26.2


