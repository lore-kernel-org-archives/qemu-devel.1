Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDC3C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 04:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A1920833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 04:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UOrnneXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A1920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42256 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRUs2-0007IJ-QW
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 00:53:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRUqL-00067w-Kv
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRUqK-0007Yb-Gm
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:41 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:35079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRUqK-0007Wk-9N
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:40 -0400
Received: by mail-pl1-x632.google.com with SMTP id g5so2748102plt.2
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 21:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=EF4T+HbdyUYRfTt1N3Y1kvgcuzpxRtr5RFjvf1UsIV4=;
	b=UOrnneXqOzuYck6gXZdKBd+vk06XcH2MItLAWLE+AVH8uZfTWxPR5XCWqldunrkBuv
	tW+yJCrGEiRdomM/J/aA2gZby2UozBhnAFcM3SYSLl830ZhDfiAlcAh0X9LnrKnuKMAT
	hZCvAp8hJnSyiaKm1VGQb8ksUm2/BuTAbG1YSkF/KcZp2mtviLRkt1nAPjoNWPziSizZ
	pgE+OAs1hZ/xhBt2xjbt63t3JhjBUlchBO05EEWBWyUSR1lRBFOKaD1g3P5r3J/1GimC
	3VjS/uEYVoBalBC0sXevKoB6zrhoBsDSIpvpw33+TXg3+7r6EjbMSZXWzv1mGjaqNbCx
	dT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=EF4T+HbdyUYRfTt1N3Y1kvgcuzpxRtr5RFjvf1UsIV4=;
	b=DqPkNYtNA3oWsgl7cHiLA9DpyUlfAaiiK0w9L5q9D55jG/zYDWehPKcBTq/U4CpAG3
	uaDj+PQifR4yZ3ZLeZ9tUuvKdRMQi0NlGGyzz0KoLLdfYxzd5lDwG+yX2qdFguXVkoI4
	LkIKcE6LZkH7s7jCZ+jBS9FnKnVrRDYRN/Ha78fq/d0xCBisgQciB8aYNhTXu+6GNi87
	S58SyBfYAwykKpYXdEvlhNd9xTEntQuS1AstmI8WYJnLN17nd5k5tfNobMkINbe08RAA
	xLC0DLPJ/qI1l/+SfBpK4mHdHY9v7TTBsk7Oq0f0xVEV6CFtKX4t4FMQgTJIZN7BQW4W
	zKfA==
X-Gm-Message-State: APjAAAWIDnJgF7qgUmuBOg9lF2ZUNg4eibU/sBe0x1c2NVgcutQxZ10P
	vy6Deu5Ud7tXnmd/wr09Ur9dgQwRRdQ=
X-Google-Smtp-Source: APXvYqx/1M+YHfua4AR44g3hRndPQBjbX1cPHGba0Z3cLmec1Cx/7O3iEnQuB8ZgflsaaYA2KECk9g==
X-Received: by 2002:a17:902:a60e:: with SMTP id
	u14mr50601463plq.94.1558068698297; 
	Thu, 16 May 2019 21:51:38 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	132sm7709625pga.79.2019.05.16.21.51.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 21:51:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 21:51:23 -0700
Message-Id: <20190517045136.3509-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::632
Subject: [Qemu-devel] [PATCH v14 00/13] RX architecture support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: philmd@redhat.com, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is Sato-san's v13, plus the typos that Phil noticed therein,
plus the change to tlb_fill required by

    commit d8276573da58e8ce78dab8c46dd660efd664bcb7
    Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190510'
    Add CPUClass::tlb_fill.
    Improve tlb_vaddr_to_host for use by ARM SVE no-fault loads.


r~


Richard Henderson (1):
  target/rx: Convert to CPUClass::tlb_fill

Yoshinori Sato (12):
  target/rx: TCG translation
  target/rx: TCG helper
  target/rx: CPU definition
  target/rx: RX disassembler
  hw/intc: RX62N interrupt controller (ICUa)
  hw/timer: RX62N internal timer modules
  hw/char: RX62N serial communication interface (SCI)
  hw/rx: RX Target hardware definition
  qemu/bitops.h: Add extract8 and extract16
  hw/registerfields.h: Add 8bit and 16bit register macros
  Add rx-softmmu
  MAINTAINERS: Add RX

 include/disas/dis-asm.h        |    5 +
 include/hw/char/renesas_sci.h  |   45 +
 include/hw/intc/rx_icu.h       |   56 +
 include/hw/registerfields.h    |   32 +-
 include/hw/rx/rx.h             |    7 +
 include/hw/rx/rx62n.h          |   94 ++
 include/hw/timer/renesas_cmt.h |   38 +
 include/hw/timer/renesas_tmr.h |   53 +
 include/qemu/bitops.h          |   38 +
 include/sysemu/arch_init.h     |    1 +
 target/rx/cpu.h                |  227 +++
 target/rx/helper.h             |   31 +
 arch_init.c                    |    2 +
 hw/char/renesas_sci.c          |  340 +++++
 hw/intc/rx_icu.c               |  376 +++++
 hw/rx/rx-virt.c                |  105 ++
 hw/rx/rx62n.c                  |  238 ++++
 hw/timer/renesas_cmt.c         |  275 ++++
 hw/timer/renesas_tmr.c         |  455 ++++++
 target/rx/cpu.c                |  236 ++++
 target/rx/disas.c              | 1480 +++++++++++++++++++
 target/rx/gdbstub.c            |  112 ++
 target/rx/helper.c             |  148 ++
 target/rx/monitor.c            |   38 +
 target/rx/op_helper.c          |  470 ++++++
 target/rx/translate.c          | 2432 ++++++++++++++++++++++++++++++++
 MAINTAINERS                    |   19 +
 configure                      |    8 +
 default-configs/rx-softmmu.mak |    3 +
 hw/Kconfig                     |    1 +
 hw/char/Kconfig                |    3 +
 hw/char/Makefile.objs          |    1 +
 hw/intc/Kconfig                |    3 +
 hw/intc/Makefile.objs          |    1 +
 hw/rx/Kconfig                  |   14 +
 hw/rx/Makefile.objs            |    2 +
 hw/timer/Kconfig               |    6 +
 hw/timer/Makefile.objs         |    3 +
 target/rx/Makefile.objs        |   12 +
 target/rx/insns.decode         |  621 ++++++++
 40 files changed, 8030 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/char/renesas_sci.h
 create mode 100644 include/hw/intc/rx_icu.h
 create mode 100644 include/hw/rx/rx.h
 create mode 100644 include/hw/rx/rx62n.h
 create mode 100644 include/hw/timer/renesas_cmt.h
 create mode 100644 include/hw/timer/renesas_tmr.h
 create mode 100644 target/rx/cpu.h
 create mode 100644 target/rx/helper.h
 create mode 100644 hw/char/renesas_sci.c
 create mode 100644 hw/intc/rx_icu.c
 create mode 100644 hw/rx/rx-virt.c
 create mode 100644 hw/rx/rx62n.c
 create mode 100644 hw/timer/renesas_cmt.c
 create mode 100644 hw/timer/renesas_tmr.c
 create mode 100644 target/rx/cpu.c
 create mode 100644 target/rx/disas.c
 create mode 100644 target/rx/gdbstub.c
 create mode 100644 target/rx/helper.c
 create mode 100644 target/rx/monitor.c
 create mode 100644 target/rx/op_helper.c
 create mode 100644 target/rx/translate.c
 create mode 100644 default-configs/rx-softmmu.mak
 create mode 100644 hw/rx/Kconfig
 create mode 100644 hw/rx/Makefile.objs
 create mode 100644 target/rx/Makefile.objs
 create mode 100644 target/rx/insns.decode

-- 
2.17.1


