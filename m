Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CD9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5CB206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhFiN2p9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5CB206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfn6l-0006a0-Nq
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 12:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5J-0004xl-MO
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:45 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5I-0001V2-S2
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:45 -0400
Received: by mail-wr1-x431.google.com with SMTP id x14so432532wrp.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zt7j9vF8Hau4riPOBYBgg1sjKWlFGcMGJn48Mme/0Lc=;
 b=FhFiN2p9MbUxSzIIpdyJ1FhpZ/xB7uGNCn1VRFKSukyUowHxst/JHq6dWetpmbXBQq
 BIP2mNMryY53qlLdAYgscUK+WTB8+NMMI+looj2G1NeFCwp3yZpIz7BNsWj2CRXFLwmc
 mDqLAhSZqQPKh+/c13YdnNapzUxWE75w8Ar5D2jjRupFKfYIpaIzND+9TeZOa3MRoGwK
 Vi45/0RaNtpcFxHPvERt2e1MCEfk+lXXEBf1JdVLFd6J1oyHkBM87PJ7PdACVsR5CPYT
 l7pyKg8PfxfOJi6N0IKV8yiDbjk37HFnFRCZNS2FemngAMv19QilJlr8QtJ8YkEKNAM5
 y9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=zt7j9vF8Hau4riPOBYBgg1sjKWlFGcMGJn48Mme/0Lc=;
 b=kqm9JCsRSbO17tIyVwTu4sXbsHJIag/T2eKZhdrJiKUb2i5RSkkaSdIGCEeTW66kZH
 9+UiTsHZukdfVPCKozjVVJHZHDDMYHS9p7wmEwDe2vxe5Y+ArXU7gv+D44P+uGRNJg+W
 B0O8ac/eYk3gkuKkyiA9EgmWszAsrtJEMujiJnnCLu+MTxvqYh4xWISslmRmxyZOvRsQ
 T/o5XZl/iqh4ih5YQ7nVxTyJ0RoYmqyFYZw4WfQxkJIKvgqndMimthL1xd0A/BkapsJN
 92py6NObRRa9s221XQCfyMBJ8Vd1zgR+r420Ml73TIOCgqb+g5vE5kQpUKLeB7ZGrnFU
 SMsg==
X-Gm-Message-State: AOAM533UVYxMbJ0snMsBfs+HE2VuRhrL3r98o4k2Zmc7/1CNTzE4/ElV
 go9wmqrj4jXmxCJTcu0BxjA=
X-Google-Smtp-Source: ABdhPJzQcMMe9LmK91YqJt19Xe2goJ+EF7QmgAWyprMjTNfCDHrFUXX11zuNK3Fj8IL2GRn5q5G4yA==
X-Received: by 2002:a5d:6986:: with SMTP id g6mr23255991wru.27.1591028083407; 
 Mon, 01 Jun 2020 09:14:43 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a6sm21309896wrn.38.2020.06.01.09.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 09:14:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 00/12] hw/rx: Add RX GDB simulator machine
Date: Mon,  1 Jun 2020 18:14:29 +0200
Message-Id: <20200601161441.8086-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

This is the RX series I was preparing for merge-request candidate,
rebased over the last 3 months with some API updates addressed,
from Yoshinori v32:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg682290.html

Unfortunately we didn't sync with Yoshinori so he diverged and
send another reworked series:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg708102.html

I'm sorry the timing is so bad, but I let other maintainance duties
invert priorities, delaying the RX hardware integration.

Changes are noted in [PMD: ...] comments before my S-o-b.

Patches missing review:

 #1: target/rx/cpu: Remove unused headers
 #9:  hw/rx: Register R5F562N7 and R5F562N8 MCUs

Regard,

Phil.

Philippe Mathieu-Daudé (3):
  target/rx/cpu: Remove unused headers
  hw/rx: Register R5F562N7 and R5F562N8 MCUs
  BootLinuxConsoleTest: Test the RX GDB simulator

Richard Henderson (1):
  hw/rx: Honor -accel qtest

Yoshinori Sato (8):
  MAINTAINERS: Add entry for RX hardware
  hw/intc: RX62N interrupt controller (ICUa)
  hw/timer: RX62N 8-Bit timer (TMR)
  hw/timer: RX62N compare match timer (CMT)
  hw/char: RX62N serial communication interface (SCI)
  hw/rx: RX62N microcontroller (MCU)
  hw/rx: Add RX GDB simulator
  docs: Document the RX target

 docs/system/target-rx.rst             |  36 ++
 docs/system/targets.rst               |   1 +
 default-configs/rx-softmmu.mak        |   1 +
 include/hw/char/renesas_sci.h         |  51 +++
 include/hw/intc/rx_icu.h              |  76 ++++
 include/hw/rx/rx62n.h                 |  78 +++++
 include/hw/timer/renesas_cmt.h        |  40 +++
 include/hw/timer/renesas_tmr.h        |  55 +++
 target/rx/cpu.h                       |   2 -
 hw/char/renesas_sci.c                 | 350 +++++++++++++++++++
 hw/intc/rx_icu.c                      | 397 +++++++++++++++++++++
 hw/rx/rx-gdbsim.c                     | 198 +++++++++++
 hw/rx/rx62n.c                         | 328 ++++++++++++++++++
 hw/timer/renesas_cmt.c                | 283 +++++++++++++++
 hw/timer/renesas_tmr.c                | 477 ++++++++++++++++++++++++++
 MAINTAINERS                           |  15 +
 hw/Kconfig                            |   1 +
 hw/char/Kconfig                       |   3 +
 hw/char/Makefile.objs                 |   1 +
 hw/intc/Kconfig                       |   3 +
 hw/intc/Makefile.objs                 |   1 +
 hw/rx/Kconfig                         |  10 +
 hw/rx/Makefile.objs                   |   2 +
 hw/timer/Kconfig                      |   6 +
 hw/timer/Makefile.objs                |   2 +
 tests/acceptance/machine_rx_gdbsim.py |  68 ++++
 26 files changed, 2483 insertions(+), 2 deletions(-)
 create mode 100644 docs/system/target-rx.rst
 create mode 100644 include/hw/char/renesas_sci.h
 create mode 100644 include/hw/intc/rx_icu.h
 create mode 100644 include/hw/rx/rx62n.h
 create mode 100644 include/hw/timer/renesas_cmt.h
 create mode 100644 include/hw/timer/renesas_tmr.h
 create mode 100644 hw/char/renesas_sci.c
 create mode 100644 hw/intc/rx_icu.c
 create mode 100644 hw/rx/rx-gdbsim.c
 create mode 100644 hw/rx/rx62n.c
 create mode 100644 hw/timer/renesas_cmt.c
 create mode 100644 hw/timer/renesas_tmr.c
 create mode 100644 hw/rx/Kconfig
 create mode 100644 hw/rx/Makefile.objs
 create mode 100644 tests/acceptance/machine_rx_gdbsim.py

-- 
2.21.3


