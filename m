Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AE9C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 02:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DE92085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 02:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sios-com.20150623.gappssmtp.com header.i=@sios-com.20150623.gappssmtp.com header.b="JuarAmIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DE92085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sios.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37839 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQN1a-0002jF-V8
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 22:18:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yo-satoh@sios.com>) id 1hQN0m-0002QT-Oe
	for qemu-devel@nongnu.org; Mon, 13 May 2019 22:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yo-satoh@sios.com>) id 1hQN0l-000272-87
	for qemu-devel@nongnu.org; Mon, 13 May 2019 22:17:48 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yo-satoh@sios.com>) id 1hQN0k-00022o-Ie
	for qemu-devel@nongnu.org; Mon, 13 May 2019 22:17:47 -0400
Received: by mail-oi1-x243.google.com with SMTP id f4so3612153oib.4
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 19:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sios-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=kekiuAhKWFpQtfxb+tr0MtLnqMWV8twIvvIEFcs6Lxs=;
	b=JuarAmIZy0H6tDUvlywrSRv6GVTBooR1qWefIL0DVgzWrEJoZzgB9kAdxl4S4Rfqnm
	xj7svg1x/iD+4hx7hV9UurYv9Ft21uY6ApY9Qk7i9O5tioTvCa5I6IyjfN+2SgFAsBVT
	aTxq78JPhYBlOLgj4khakN5n7FO99iVemCc2zMKwBHwfxrmighjYd/dlArhklUcB4DFe
	N7J/fIZ67MNVcBFshhBC98FmaArBC7f+GCzuXWKCAwIDhtvzHLnVWxySH3l4FCdPX/fM
	JMnFkTy+tiecOXRCuiFAUSkhh/KsSC2BmKomDBWmhNbX5PaAN74egHQ/upNGDT4Us2Ya
	dD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=kekiuAhKWFpQtfxb+tr0MtLnqMWV8twIvvIEFcs6Lxs=;
	b=AD8M6055Yd2Uz4e3TINrCpaQfNZgUlLavsigwxLfhRa9RjQJ9fjvPNTeqvA4GNVX8k
	RSoj23TVBSKMvuqnIBRmXms7+dqUZOaUdQoNAhv2IEKj2HfAiBAGEoe+ITCENVxdKPUf
	3B1jaiS5yirEkf6v9KXsGUqEe28/cXZ85y4t/aXx4WK0okcoPfI5Kb4E8Q73pwUPqlKf
	blbDaGcwR09C50BBRalaStKE7jjixGbWWs2ogmzj/T121Cl3eLnNpPhgsrBnosh5Fvac
	R/Zk2ycnq6Ee2zU6++stsptS292J57qAo9ii8khZau1klX0Cs7tHSZtP3/AM4W02zBOX
	d1fA==
X-Gm-Message-State: APjAAAVU8aV1WZFZVfFm0BG3mWeL0y2+OCi9blHm2mw39Ppx5qDOV9zV
	6PFfzP3+yfopkY/8POQ1TrDZciOlqJVfkWtOLPjP/Q==
X-Google-Smtp-Source: APXvYqwHXHybRow70GAMBUHsOtaVt4213ZqSvisLDxlAxc+3jhGTKKtRjycTtDVdiLFXYuYLoyVXT/upkvByYogRclA=
X-Received: by 2002:aca:50d3:: with SMTP id e202mr1473801oib.88.1557800264980; 
	Mon, 13 May 2019 19:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190513052518.6274-1-yo-satoh@sios.com>
	<7fcd8994-1549-fb6f-d7c2-5ad4558767c3@redhat.com>
In-Reply-To: <7fcd8994-1549-fb6f-d7c2-5ad4558767c3@redhat.com>
From: Yoshinori Sato <yo-satoh@sios.com>
Date: Tue, 14 May 2019 11:17:33 +0900
Message-ID: <CAL_XjKWOimLzHs8JeyEJzEOF-T-poJU5LsYJUQtnSPtiPwh2zg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Oh. Sorry.

I fount one other problem.
I will fix it and re-send later.

2019=E5=B9=B45=E6=9C=8814=E6=97=A5(=E7=81=AB) 2:26 Philippe Mathieu-Daud=C3=
=A9 <philmd@redhat.com>:
>
> Hi Yoshinori,
>
> On 5/13/19 7:25 AM, Yoshinori Sato wrote:
> > Hello.
> > This patch series is added Renesas RX target emulation.
> >
> > Fixed build errors and cleaned up the code.
> >
> > My git repository is bellow.
> > git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git tags/rx-20190513
>
> This tag isn't exactly the same as the series you posted, some patches
> are ordered differently, leading to this failure at commit fc564da941a
> (Add rx-softmmu) of your tag:
>
> ((fc564da941a...))$ make -C rx-softmmu hw/intc/rx_icu.o
>   CC      hw/intc/rx_icu.o
> hw/intc/rx_icu.c:35:9: error: expected =E2=80=98)=E2=80=99 before numeric=
 constant
>  REG8(IR, 0)
>          ^~
>          )
> ...
> hw/intc/rx_icu.c: In function =E2=80=98icu_read=E2=80=99:
> hw/intc/rx_icu.c:174:18: error: =E2=80=98A_FIR=E2=80=99 undeclared (first=
 use in this
> function); did you mean =E2=80=98A_FPSW=E2=80=99?
>      if ((addr !=3D A_FIR && size !=3D 1) ||
>                   ^~~~~
>                   A_FPSW
> hw/intc/rx_icu.c:174:18: note: each undeclared identifier is reported
> only once for each function it appears in
> hw/intc/rx_icu.c:181:10: error: =E2=80=98A_IR=E2=80=99 undeclared (first =
use in this
> function); did you mean =E2=80=98DIR=E2=80=99?
>      case A_IR ... A_IR + 0xff:
>           ^~~~
>           DIR
> ...
> hw/intc/rx_icu.c:199:44: error: =E2=80=98R_IRQCR_IRQMD_SHIFT=E2=80=99 und=
eclared (first
> use in this function); did you mean =E2=80=98R_IRQCR_IRQMD_MASK=E2=80=99?
>          return icu->src[64 + reg].sense << R_IRQCR_IRQMD_SHIFT;
>                                             ^~~~~~~~~~~~~~~~~~~
>                                             R_IRQCR_IRQMD_MASK
>
> This is because the commit "hw/registerfields.h" is added after.
> I see this series seems ordered correctly, so I'll keep testing.
>
> >
> > Testing binaries bellow.
> > u-boot
> > Download - https://osdn.net/users/ysato/pf/qemu/dl/u-boot.bin.gz
> >
> > starting
> > $ gzip -d u-boot.bin.gz
> > $ qemu-system-rx -bios u-boot.bin
> >
> > linux and pico-root (only sash)
> > Download - https://osdn.net/users/ysato/pf/qemu/dl/zImage (kernel)
> >            https://osdn.net/users/ysato/pf/qemu/dl/rx-qemu.dtb (DeviceT=
ree)
> >
> > starting
> > $ qemu-system-rx -kernel zImage -dtb rx-qemu.dtb -append "earlycon"
> >
> > Changes for v10.
> > - Fix build error for 32bit system.
> > - Use "object_initialize_child" in create device instance.
> > - Remove unused headers.
> > - Avoid some magic number.
> > - Clean up Kconfig symbols.
> >
> > Yoshinori Sato (12):
> >   target/rx: TCG translation
> >   target/rx: TCG helper
> >   target/rx: CPU definition
> >   target/rx: RX disassembler
> >   hw/intc: RX62N interrupt controller (ICUa)
> >   hw/timer: RX62N internal timer modules
> >   hw/char: RX62N serial communication interface (SCI)
> >   hw/rx: RX Target hardware definition
> >   hw/registerfields.h: Add 8bit and 16bit register macros.
> >   qemu/bitops.h: Add extract8 and extract16
> >   Add rx-softmmu
> >   MAINTAINERS: Add RX
> >
> >  MAINTAINERS                    |   19 +
> >  arch_init.c                    |    2 +
> >  configure                      |    8 +
> >  default-configs/rx-softmmu.mak |    3 +
> >  hw/Kconfig                     |    1 +
> >  hw/char/Kconfig                |    3 +
> >  hw/char/Makefile.objs          |    1 +
> >  hw/char/renesas_sci.c          |  340 ++++++
> >  hw/intc/Kconfig                |    3 +
> >  hw/intc/Makefile.objs          |    1 +
> >  hw/intc/rx_icu.c               |  376 +++++++
> >  hw/rx/Kconfig                  |   14 +
> >  hw/rx/Makefile.objs            |    2 +
> >  hw/rx/rx-virt.c                |  105 ++
> >  hw/rx/rx62n.c                  |  238 ++++
> >  hw/timer/Kconfig               |    6 +
> >  hw/timer/Makefile.objs         |    3 +
> >  hw/timer/renesas_cmt.c         |  275 +++++
> >  hw/timer/renesas_tmr.c         |  455 ++++++++
> >  include/disas/dis-asm.h        |    5 +
> >  include/hw/char/renesas_sci.h  |   45 +
> >  include/hw/intc/rx_icu.h       |   57 +
> >  include/hw/registerfields.h    |   32 +-
> >  include/hw/rx/rx.h             |    7 +
> >  include/hw/rx/rx62n.h          |   94 ++
> >  include/hw/timer/renesas_cmt.h |   38 +
> >  include/hw/timer/renesas_tmr.h |   50 +
> >  include/qemu/bitops.h          |   38 +
> >  include/sysemu/arch_init.h     |    1 +
> >  target/rx/Makefile.objs        |   12 +
> >  target/rx/cpu.c                |  222 ++++
> >  target/rx/cpu.h                |  227 ++++
> >  target/rx/disas.c              | 1480 ++++++++++++++++++++++++
> >  target/rx/gdbstub.c            |  112 ++
> >  target/rx/helper.c             |  148 +++
> >  target/rx/helper.h             |   31 +
> >  target/rx/insns.decode         |  621 ++++++++++
> >  target/rx/monitor.c            |   38 +
> >  target/rx/op_helper.c          |  481 ++++++++
> >  target/rx/translate.c          | 2432 ++++++++++++++++++++++++++++++++=
++++++++
> >  40 files changed, 8025 insertions(+), 1 deletion(-)
> >  create mode 100644 default-configs/rx-softmmu.mak
> >  create mode 100644 hw/char/renesas_sci.c
> >  create mode 100644 hw/intc/rx_icu.c
> >  create mode 100644 hw/rx/Kconfig
> >  create mode 100644 hw/rx/Makefile.objs
> >  create mode 100644 hw/rx/rx-virt.c
> >  create mode 100644 hw/rx/rx62n.c
> >  create mode 100644 hw/timer/renesas_cmt.c
> >  create mode 100644 hw/timer/renesas_tmr.c
> >  create mode 100644 include/hw/char/renesas_sci.h
> >  create mode 100644 include/hw/intc/rx_icu.h
> >  create mode 100644 include/hw/rx/rx.h
> >  create mode 100644 include/hw/rx/rx62n.h
> >  create mode 100644 include/hw/timer/renesas_cmt.h
> >  create mode 100644 include/hw/timer/renesas_tmr.h
> >  create mode 100644 target/rx/Makefile.objs
> >  create mode 100644 target/rx/cpu.c
> >  create mode 100644 target/rx/cpu.h
> >  create mode 100644 target/rx/disas.c
> >  create mode 100644 target/rx/gdbstub.c
> >  create mode 100644 target/rx/helper.c
> >  create mode 100644 target/rx/helper.h
> >  create mode 100644 target/rx/insns.decode
> >  create mode 100644 target/rx/monitor.c
> >  create mode 100644 target/rx/op_helper.c
> >  create mode 100644 target/rx/translate.c
> >

