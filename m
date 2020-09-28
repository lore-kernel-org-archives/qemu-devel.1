Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83483C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DA8207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9BbVSFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DA8207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwmG-0005rf-Or
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwkg-0004B2-U2
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:15:50 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwka-0006JA-2J
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:15:50 -0400
Received: by mail-wr1-x42b.google.com with SMTP id k10so2212153wru.6
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OuV2lSj+vDl5vCymOXQwcqQAKlj2R1WhJymuq9BnH40=;
 b=N9BbVSFBSdRWJLCzVMWKMBlQXVjppex6EqGcDIQ7uXF8A6x+UqDOueUqR6FzROmBj8
 HUipa04B5dKAx0OiW16+JREok3JNFcTYUMyS2h0478LFaS6yX1sDjVyGJJw4sAyJqfM2
 XhsimQUv3u6qop1qHh/YHV3Dk8QBkldq44u1VXa2b81bUogzgZy0pEuST+JEykKpDs2E
 honiB0SeODYcEWPFftLuxnTcqPMasDxBzlzIlmSJRfbA8YAVrwGSaadh9YWNCy58Qqsy
 UiDjyFl8irTmuo0z3c4FUOxzcrP9AiToRog+k3ZvPgeeXb1/eVbB1TrzW9fc1+izCEfd
 bWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=OuV2lSj+vDl5vCymOXQwcqQAKlj2R1WhJymuq9BnH40=;
 b=BvwQ6diIsTjH3LBCbl3eb+NITYgvOWCUAr5CvwN6W+je+Jlas6aMv20ThRrz/utzuI
 q+7N03Ca8IX66/D38P0T6YZprNWYOhgRMnv5XIwuc1etyrAVb2d63fXTB4ni1cFgP6Jg
 8stqCGsUJELeUSRrJZ6UI9GF3UaTvHPEbpeL81nNsF2iHOjr54xGnp5N0cm8RlLsfqCf
 5HIg1PbOtp21EcAje3hPfTWUghqXg6bhTkr2/nSyTdMieO/IVt/Lz3dqH0O4ysXAEaBU
 fRzDzhIZU+l2QW8XIYxmTM22QNqXIPp0jCsA7JNICveFvl5ahr4+evl4xdf/O+zX+IXQ
 oeXw==
X-Gm-Message-State: AOAM531qJMoTdC1i/ARRjVpbauvxm9NTQKPvkKiV1igklDOUHbieXKZw
 Ay/HpyNTrimjiyVOEhEwQKN5mmM2TnY=
X-Google-Smtp-Source: ABdhPJwTliMfzuKWa2SpWQfOuI7WZ1vbqo/J1JTC0OV/aXBvCRQLk64tyQMnioB2hhe/NfJHNMoD6A==
X-Received: by 2002:adf:9d44:: with SMTP id o4mr2792701wre.361.1601313341605; 
 Mon, 28 Sep 2020 10:15:41 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z67sm464787wme.41.2020.09.28.10.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:15:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/16] hw/mips: Set CPU frequency
Date: Mon, 28 Sep 2020 19:15:23 +0200
Message-Id: <20200928171539.788309-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

- let all CPU have an input clock,
- MIPS CPU get an input clock
- when the clock is changed, CP0 timer is updated
- set correct CPU frequencies to all boards
- do not allow MIPS CPU without input clock

I used a MIPSsim test suggested by Thomas. It is also included
as bonus at the end.

Possible follow up:
- QOM'ify the GIC
- let the GIC handle dynamic clock changes

Regards,

Phil.

Philippe Mathieu-Daudé (16):
  hw/core/cpu: Let CPU object have a clock source
  target/mips: Move cpu_mips_get_random() with CP0 helpers
  target/mips/cp0_timer: Explicit unit in variable name
  target/mips/cpu: Introduce mips_cpu_properties[]
  target/mips/cpu: Set default CPU frequency to 200 MHz
  target/mips: Keep CP0 counter in sync with the CPU frequency
  hw/mips/r4k: Explicit CPU frequency is 200 MHz
  hw/mips/fuloong2e: Set CPU frequency to 533 MHz
  hw/mips/mipssim: Correct CPU frequency
  hw/mips/jazz: Correct CPU frequencies
  hw/mips/cps: Expose input clock and connect it to CPU cores
  hw/mips/boston: Set CPU frequency to 1 GHz
  hw/mips/malta: Set CPU frequency to 320 MHz
  hw/mips/cps: Do not allow use without input clock
  target/mips/cpu: Do not allow system-mode use without input clock
  tests/acceptance: Test the MIPSsim machine

 include/hw/core/cpu.h                    |  5 +++
 include/hw/mips/cps.h                    |  2 +
 target/mips/cpu.h                        |  9 ++++
 target/mips/internal.h                   |  2 +-
 hw/core/cpu.c                            | 12 +++++
 hw/mips/boston.c                         | 13 ++++++
 hw/mips/cps.c                            |  8 ++++
 hw/mips/fuloong2e.c                      |  8 +++-
 hw/mips/jazz.c                           | 16 ++++++-
 hw/mips/malta.c                          | 20 +++++++--
 hw/mips/mipssim.c                        | 12 ++++-
 hw/mips/r4k.c                            |  8 +++-
 target/mips/cp0_helper.c                 | 25 +++++++++++
 target/mips/cp0_timer.c                  | 51 ++++++---------------
 target/mips/cpu.c                        | 43 +++++++++++++++++-
 MAINTAINERS                              |  1 +
 tests/acceptance/machine_mips_mipssim.py | 56 ++++++++++++++++++++++++
 17 files changed, 244 insertions(+), 47 deletions(-)
 create mode 100644 tests/acceptance/machine_mips_mipssim.py

-- 
2.26.2


