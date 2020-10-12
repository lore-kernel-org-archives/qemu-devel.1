Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0D2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 09:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682DE208B6
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 09:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLSLr1gV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682DE208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRuc8-0001AY-93
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 05:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRuap-0008Er-UC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:58:11 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRuao-0002k9-5E
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:58:11 -0400
Received: by mail-wr1-x435.google.com with SMTP id e18so18426389wrw.9
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TvcNGGsgC61zpth+JjcRSRBZyoU7/e2wQ1xOxcDu56Q=;
 b=KLSLr1gVkBXgv2CAxD+PvGekZ8EgOykEtrfOcmiByx0LVrAs1t2/tF4Y34Z2amxFPa
 0u+Pvi9rQ/zXKCsbc/vgMhYpzWMyhuhavjmgLpN25b53gWc9bA+rP8cSFKddlklGCZ2V
 I+94Wsgr8rFRyCX2ddBy7G/tUsey3BwuJXQYJBwnYavJOxWneAQmrhOFfIRzCJqyr7au
 IrSFt8VAsmVgSZ0wuJp2bvflcDFO9sfz1djjkw3zdu0CaCkOvgJNBHN7JPy4cicLx38u
 C0mW7L79t12TwOQa2M+10YkI3vBQ2T51pBmtKuDspy3bN6NSdbJOTS8O8N7msWyc3TrY
 6T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=TvcNGGsgC61zpth+JjcRSRBZyoU7/e2wQ1xOxcDu56Q=;
 b=XXRVbimPhsxUvvEHUcI5+dL6xhjRDPWGzLHXy9J0ATZKO3U4fgU1XRResxr8jTuLFH
 KezE+wXczraMJcFyzH9cI2KiCrq0+p8t8mYVW8Fs3o8VomQy8UVV5wZgWC5b673ab0fJ
 nS3t9/g8kWN8EQjG4XrnHsXMvPWHMYffsoyog85Kn15t71yRMtsriNwfyzCsnRCJvyDL
 2e1ZRn64T/nIyFwH9j95ayD1TsbP/Cepvx7DTX0U08orm2N4d1d91ZiiaeHUyDRGFBTs
 3NHE1YK5DfE35J4q0q31taRA6wUi6ew/4Dl9wvjYZhuBXEvPlxhypFgOmxG/YfRXLpfX
 vjJg==
X-Gm-Message-State: AOAM530vVj0nLWbATQYCTIwndCOSCLMHPuic/th2DZuc1KwHrtvfhAxb
 5xKTsOh6z1ivzLgYPFiPrtCQGHqY5Qo=
X-Google-Smtp-Source: ABdhPJx0nrhbB8AbSfBijzRP1I+Izg3WTzNNOl0oPglSpEnMbM+vKRFTIJTf4QqHmgUUeSG5NAeQxw==
X-Received: by 2002:adf:ed07:: with SMTP id a7mr30256088wro.326.1602496687973; 
 Mon, 12 Oct 2020 02:58:07 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x15sm27187433wrr.36.2020.10.12.02.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 02:58:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/21] hw/mips: Set CPU frequency
Date: Mon, 12 Oct 2020 11:57:43 +0200
Message-Id: <20201012095804.3335117-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v3:=0D
- Introduced mips_cpu_create_with_clock() helper (Huacai)=0D
- Added R-b tags=0D
=0D
Since v2:=0D
- Renamed "clk" -> "clk-in"=0D
- Renamed "cpuclk-out -> "cpu-refclk"=0D
=0D
Missing review: patches 7, 10-13, 15-21=0D
=0D
~~~=0D
=0D
All the MIPS cores emulated by QEMU provides the Coproc#0=0D
'Count' register which can be used as a free running timer.=0D
=0D
Since it's introduction in 2005 this timer uses a fixed=0D
frequency of 100 MHz (for a CPU freq of 200 MHz).=0D
While this is not an issue with Linux guests, it makes=0D
some firmwares behave incorrectly.=0D
=0D
The Clock API allow propagating clocks. It is particularly=0D
useful when hardware dynamicly changes clock frequencies.=0D
=0D
To be able to model such MIPS hardware, we need to refactor=0D
the MIPS hardware code to handle clocks.=0D
=0D
This series is organized as follow:=0D
=0D
1/ qdev/clock patches already reviewed but not merged=0D
=0D
2/ refactor the CP0 timer period to allow dynamic changes=0D
=0D
3/ MIPS CPU get an optional input clock=0D
=0D
4/ set correct CPU frequencies to all boards=0D
=0D
I used a MIPSsim test suggested by Thomas.=0D
The test is available on the list:=0D
https://mid.mail-archive.com/20200928171539.788309-17-f4bug@amsat.org=0D
=0D
Possible follow up:=0D
- QOM'ify the GIC=0D
- let the GIC handle dynamic clock changes=0D
=0D
Regards,=0D
=0D
Phil.=0D
=0D
Luc Michel (1):=0D
  hw/core/clock: add the clock_new helper function=0D
=0D
Philippe Mathieu-Daud=C3=A9 (20):=0D
  util/cutils: Introduce freq_to_str() to display Hertz units=0D
  qdev-monitor: Display frequencies scaled to SI unit=0D
  hw/qdev-clock: Display error hint when clock is missing from device=0D
  target/mips: Move cpu_mips_get_random() with CP0 helpers=0D
  target/mips/cp0_timer: Explicit unit in variable name=0D
  target/mips/cp0_timer: Document TIMER_PERIOD origin=0D
  target/mips: Move cp0_count_ns to CPUMIPSState=0D
  target/mips/cpu: Calculate the CP0 timer period using the CPU=0D
    frequency=0D
  target/mips/cpu: Make cp0_count_rate a property=0D
  target/mips/cpu: Allow the CPU to use dynamic frequencies=0D
  target/mips/cpu: Introduce mips_cpu_create_with_clock() helper=0D
  hw/mips/r4k: Explicit CPU frequency is 200 MHz=0D
  hw/mips/fuloong2e: Set CPU frequency to 533 MHz=0D
  hw/mips/mipssim: Correct CPU frequency=0D
  hw/mips/jazz: Correct CPU frequencies=0D
  hw/mips/cps: Expose input clock and connect it to CPU cores=0D
  hw/mips/boston: Set CPU frequency to 1 GHz=0D
  hw/mips/malta: Set CPU frequency to 320 MHz=0D
  hw/mips/cps: Do not allow use without input clock=0D
  target/mips/cpu: Display warning when CPU is used without input clock=0D
=0D
 include/hw/clock.h       | 13 ++++++++++=0D
 include/hw/mips/cps.h    |  2 ++=0D
 include/qemu/cutils.h    | 12 +++++++++=0D
 target/mips/cpu.h        | 26 +++++++++++++++++++=0D
 target/mips/internal.h   |  2 +-=0D
 hw/core/clock.c          | 15 +++++++++++=0D
 hw/core/qdev-clock.c     | 11 ++++++++=0D
 hw/mips/boston.c         | 13 ++++++++++=0D
 hw/mips/cps.c            |  9 +++++++=0D
 hw/mips/fuloong2e.c      |  7 +++++-=0D
 hw/mips/jazz.c           | 15 ++++++++++-=0D
 hw/mips/malta.c          | 19 +++++++++++---=0D
 hw/mips/mipssim.c        | 11 +++++++-=0D
 hw/mips/r4k.c            |  7 +++++-=0D
 qdev-monitor.c           |  8 +++---=0D
 target/mips/cp0_helper.c | 25 +++++++++++++++++++=0D
 target/mips/cp0_timer.c  | 51 ++++++++++---------------------------=0D
 target/mips/cpu.c        | 54 +++++++++++++++++++++++++++++++++++++++-=0D
 util/cutils.c            | 14 +++++++++++=0D
 19 files changed, 264 insertions(+), 50 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

