Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE537C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 17:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9055E2084A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 17:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9055E2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60813 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQEjf-0001AJ-QZ
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 13:27:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQEiq-0000qW-Lm
	for qemu-devel@nongnu.org; Mon, 13 May 2019 13:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQEip-0000xW-Au
	for qemu-devel@nongnu.org; Mon, 13 May 2019 13:26:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQEip-0000wx-4Z
	for qemu-devel@nongnu.org; Mon, 13 May 2019 13:26:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so16188422wro.10
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 10:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=zxoSeMoBB64F36rtqv5xEafqZO+XPUTtWoPdqTQrbes=;
	b=HIq2NcJ29SwRgo1Vn3pBBNap900sP1V8j4yCWJblNLbw8hgaMZDVQczus4z8WzE6O7
	T0QcXiuWIF00QTDo8iyBjv3hpRt5+rk8fG752wePa7eeG1HeaLuFxFvasY6Rw7H9XetE
	EpInbV9/XM6e7yXyA5VRg1IdA39eki0VW7pz1q+iq1t11XdxLzG+6VqULVyE90LSfmKj
	da1k996I50vr7C8ORG1XIY9g3lYpKfv4G/aMMYRuvCxPIrA8mnNhLUiMijocgHSQBAc1
	hQSp+vQhjy+Ij1NA/pgtrPYwDbOTXC4Rcuo8tzbkBVdqFVv/oi8K7YArWTXDrQpW6vHK
	zxPg==
X-Gm-Message-State: APjAAAXrc+X4BwD49HpSLh3k9pHCgmnlTva7ji4YE+2Sv2w7Vi6HADdZ
	xIZn8VB+4pE9IIARdOvq+oBfDJyIZIQ=
X-Google-Smtp-Source: APXvYqzITeuU/h3tBEuTBDxZxeqU7/yxjqvsdWw8kc8oE2/SgC9UVB4nAyIGwGiYXWcjEtGs308QYg==
X-Received: by 2002:adf:e691:: with SMTP id r17mr15697646wrm.50.1557768401289; 
	Mon, 13 May 2019 10:26:41 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id j82sm90345wmj.40.2019.05.13.10.26.40
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 10:26:40 -0700 (PDT)
To: Yoshinori Sato <yo-satoh@sios.com>, qemu-devel@nongnu.org
References: <20190513052518.6274-1-yo-satoh@sios.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7fcd8994-1549-fb6f-d7c2-5ad4558767c3@redhat.com>
Date: Mon, 13 May 2019 19:26:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513052518.6274-1-yo-satoh@sios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v11 00/12] Add RX archtecture support
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yoshinori,

On 5/13/19 7:25 AM, Yoshinori Sato wrote:
> Hello.
> This patch series is added Renesas RX target emulation.
> 
> Fixed build errors and cleaned up the code.
> 
> My git repository is bellow.
> git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git tags/rx-20190513

This tag isn't exactly the same as the series you posted, some patches
are ordered differently, leading to this failure at commit fc564da941a
(Add rx-softmmu) of your tag:

((fc564da941a...))$ make -C rx-softmmu hw/intc/rx_icu.o
  CC      hw/intc/rx_icu.o
hw/intc/rx_icu.c:35:9: error: expected ‘)’ before numeric constant
 REG8(IR, 0)
         ^~
         )
...
hw/intc/rx_icu.c: In function ‘icu_read’:
hw/intc/rx_icu.c:174:18: error: ‘A_FIR’ undeclared (first use in this
function); did you mean ‘A_FPSW’?
     if ((addr != A_FIR && size != 1) ||
                  ^~~~~
                  A_FPSW
hw/intc/rx_icu.c:174:18: note: each undeclared identifier is reported
only once for each function it appears in
hw/intc/rx_icu.c:181:10: error: ‘A_IR’ undeclared (first use in this
function); did you mean ‘DIR’?
     case A_IR ... A_IR + 0xff:
          ^~~~
          DIR
...
hw/intc/rx_icu.c:199:44: error: ‘R_IRQCR_IRQMD_SHIFT’ undeclared (first
use in this function); did you mean ‘R_IRQCR_IRQMD_MASK’?
         return icu->src[64 + reg].sense << R_IRQCR_IRQMD_SHIFT;
                                            ^~~~~~~~~~~~~~~~~~~
                                            R_IRQCR_IRQMD_MASK

This is because the commit "hw/registerfields.h" is added after.
I see this series seems ordered correctly, so I'll keep testing.

> 
> Testing binaries bellow.
> u-boot
> Download - https://osdn.net/users/ysato/pf/qemu/dl/u-boot.bin.gz
> 
> starting
> $ gzip -d u-boot.bin.gz
> $ qemu-system-rx -bios u-boot.bin
> 
> linux and pico-root (only sash)
> Download - https://osdn.net/users/ysato/pf/qemu/dl/zImage (kernel)
>            https://osdn.net/users/ysato/pf/qemu/dl/rx-qemu.dtb (DeviceTree)
> 
> starting
> $ qemu-system-rx -kernel zImage -dtb rx-qemu.dtb -append "earlycon"
> 
> Changes for v10.
> - Fix build error for 32bit system.
> - Use "object_initialize_child" in create device instance.
> - Remove unused headers.
> - Avoid some magic number.
> - Clean up Kconfig symbols.
> 
> Yoshinori Sato (12):
>   target/rx: TCG translation
>   target/rx: TCG helper
>   target/rx: CPU definition
>   target/rx: RX disassembler
>   hw/intc: RX62N interrupt controller (ICUa)
>   hw/timer: RX62N internal timer modules
>   hw/char: RX62N serial communication interface (SCI)
>   hw/rx: RX Target hardware definition
>   hw/registerfields.h: Add 8bit and 16bit register macros.
>   qemu/bitops.h: Add extract8 and extract16
>   Add rx-softmmu
>   MAINTAINERS: Add RX
> 
>  MAINTAINERS                    |   19 +
>  arch_init.c                    |    2 +
>  configure                      |    8 +
>  default-configs/rx-softmmu.mak |    3 +
>  hw/Kconfig                     |    1 +
>  hw/char/Kconfig                |    3 +
>  hw/char/Makefile.objs          |    1 +
>  hw/char/renesas_sci.c          |  340 ++++++
>  hw/intc/Kconfig                |    3 +
>  hw/intc/Makefile.objs          |    1 +
>  hw/intc/rx_icu.c               |  376 +++++++
>  hw/rx/Kconfig                  |   14 +
>  hw/rx/Makefile.objs            |    2 +
>  hw/rx/rx-virt.c                |  105 ++
>  hw/rx/rx62n.c                  |  238 ++++
>  hw/timer/Kconfig               |    6 +
>  hw/timer/Makefile.objs         |    3 +
>  hw/timer/renesas_cmt.c         |  275 +++++
>  hw/timer/renesas_tmr.c         |  455 ++++++++
>  include/disas/dis-asm.h        |    5 +
>  include/hw/char/renesas_sci.h  |   45 +
>  include/hw/intc/rx_icu.h       |   57 +
>  include/hw/registerfields.h    |   32 +-
>  include/hw/rx/rx.h             |    7 +
>  include/hw/rx/rx62n.h          |   94 ++
>  include/hw/timer/renesas_cmt.h |   38 +
>  include/hw/timer/renesas_tmr.h |   50 +
>  include/qemu/bitops.h          |   38 +
>  include/sysemu/arch_init.h     |    1 +
>  target/rx/Makefile.objs        |   12 +
>  target/rx/cpu.c                |  222 ++++
>  target/rx/cpu.h                |  227 ++++
>  target/rx/disas.c              | 1480 ++++++++++++++++++++++++
>  target/rx/gdbstub.c            |  112 ++
>  target/rx/helper.c             |  148 +++
>  target/rx/helper.h             |   31 +
>  target/rx/insns.decode         |  621 ++++++++++
>  target/rx/monitor.c            |   38 +
>  target/rx/op_helper.c          |  481 ++++++++
>  target/rx/translate.c          | 2432 ++++++++++++++++++++++++++++++++++++++++
>  40 files changed, 8025 insertions(+), 1 deletion(-)
>  create mode 100644 default-configs/rx-softmmu.mak
>  create mode 100644 hw/char/renesas_sci.c
>  create mode 100644 hw/intc/rx_icu.c
>  create mode 100644 hw/rx/Kconfig
>  create mode 100644 hw/rx/Makefile.objs
>  create mode 100644 hw/rx/rx-virt.c
>  create mode 100644 hw/rx/rx62n.c
>  create mode 100644 hw/timer/renesas_cmt.c
>  create mode 100644 hw/timer/renesas_tmr.c
>  create mode 100644 include/hw/char/renesas_sci.h
>  create mode 100644 include/hw/intc/rx_icu.h
>  create mode 100644 include/hw/rx/rx.h
>  create mode 100644 include/hw/rx/rx62n.h
>  create mode 100644 include/hw/timer/renesas_cmt.h
>  create mode 100644 include/hw/timer/renesas_tmr.h
>  create mode 100644 target/rx/Makefile.objs
>  create mode 100644 target/rx/cpu.c
>  create mode 100644 target/rx/cpu.h
>  create mode 100644 target/rx/disas.c
>  create mode 100644 target/rx/gdbstub.c
>  create mode 100644 target/rx/helper.c
>  create mode 100644 target/rx/helper.h
>  create mode 100644 target/rx/insns.decode
>  create mode 100644 target/rx/monitor.c
>  create mode 100644 target/rx/op_helper.c
>  create mode 100644 target/rx/translate.c
> 

