Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923A3C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B60C2083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B60C2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrXV-00020l-Gi
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrDe-0004Rg-Tc
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:20:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrDc-0001Yn-W0
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:20:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id p65so5898324qtd.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/gKKHLYgrCm3RF7D2iv78T5YKZYhOS467RhQBHNiTXg=;
 b=U1IlEU5g4KPzHUhCJ1H9r7BLbZePllEhckQFCyDZImlT9g5m0dg0sv6yFUY93c/H6G
 usGh5TLMd7CRqxqiI5VfpZqd5FLJk18G5Bnzs181qbryx/NaTHmQIUfrP5eGrVPgb9EW
 R0CS+2AUJyI1Vt/1KapZUiSYcDwdvDKFPLzjzWjbdoKot7+NQdSn6UOmlmGOfirCttx5
 7MpoqQBNqY4EznT8sAB0nefleCJTKYVzzMyghegCDEQjqO9uwqsSJPHDxgujSqFozlB0
 wdayP6JwCHi74bLw23tXRJmtuOV/Yqn3oYt1ma2DiSBs5HUM6aJkG45x4jY7glJR/vxs
 g9ZA==
X-Gm-Message-State: AOAM532W5LwWwswTsRrNAMqhVniKHGGYIl2pp7uEA1CycREwSrX+p90t
 fWMF9h8oucfrC4PeSFXmnJJmqnT0uuRLJFGA2amXL7mr
X-Google-Smtp-Source: ABdhPJxOHbVsgCj2VSwMMeWdzKzsmgWiIvnbMytxcXpqesU2nzUqmENAbYdIu/iHQxGXAHuJ+dByBUW8rLo5x3jNMMY=
X-Received: by 2002:ac8:f86:: with SMTP id b6mr3333909qtk.252.1598908800174;
 Mon, 31 Aug 2020 14:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
In-Reply-To: <20200827123859.81793-1-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 22:38:37 +0200
Message-ID: <CAAdtpL4tyCfa-vEnYVP1i_3ksjBkAaDVx1wwMfBVHfA+BhS_wA@mail.gmail.com>
Subject: Re: [PATCH 00/20] RX target update
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: multipart/alternative; boundary="00000000000010135305ae32f7a9"
Received-SPF: pass client-ip=209.85.160.195;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qt1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:15:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000010135305ae32f7a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Yoshinori,

Le jeu. 27 ao=C3=BBt 2020 14:43, Yoshinori Sato <ysato@users.sourceforge.jp=
> a
=C3=A9crit :

> Hello.
> This series Renesas RX updates.
>
> It consists of the following contents.
> * Update firmware loader.
> * Rewrite peripheal modules (Timer and SCI).
>   - Unified SH4 module.
>   - Using clock API
> * New peripheal modules.
>   - On-chip clock generator.
>   - Multi-function timer.
>   - Ethernet MAC.
> * New real hardware target.
>   - TokushudenshiKairo TKDN-RX62N-BRD.
>   - CQ publishing CQ-FRK-RX62N
>

How can we test them?


> Yoshinori Sato (20):
>   loader.c: Add support Motrola S-record format.
>   include/elf.h: Add EM_RX.
>   hw/rx: Firmware and kernel loader.
>   hw/rx: New firmware loader.
>   hw/rx: Add RX62N Clock generator
>   hw/timer: Renesas 8bit timer emulation.
>   hw/rx: RX62N convert new 8bit timer.
>   hw/timer: Renesas TMU/CMT module.
>   hw/timer: Remove renesas_cmt.
>   hw/rx: Convert to renesas_timer
>   hw/char: Renesas SCI module.
>   hw/rx/rx62n: Use New SCI module.
>   hw/timer: Add Renesas MTU2
>   hw/rx/rx62n: RX62N Add MTU module
>   hw/net: Add generic Bit-bang MDIO PHY.
>   hw/net: Add Renesas On-chip Ethernet MAC
>   hw/rx/rx62n: Add Ethernet support.
>   hw/rx: Add Tokudenkairo TKDN-RX62N-BRD
>   hw/rx: Add CQ-FRK-RX62N target
>   MAINTAINERS: Update RX entry
>
>  default-configs/rx-softmmu.mak   |    2 +
>  include/elf.h                    |    2 +
>  include/hw/char/renesas_sci.h    |  129 ++-
>  include/hw/loader.h              |   14 +
>  include/hw/net/mdio.h            |  126 +++
>  include/hw/net/renesas_eth.h     |   57 ++
>  include/hw/rx/loader.h           |   35 +
>  include/hw/rx/rx62n-cpg.h        |   72 ++
>  include/hw/rx/rx62n.h            |   36 +-
>  include/hw/timer/renesas_cmt.h   |   40 -
>  include/hw/timer/renesas_mtu.h   |   90 ++
>  include/hw/timer/renesas_timer.h |  103 +++
>  include/hw/timer/renesas_tmr.h   |   55 --
>  include/hw/timer/renesas_tmr8.h  |   67 ++
>  hw/char/renesas_sci.c            | 1040 ++++++++++++++++++-----
>  hw/core/loader.c                 |  208 +++++
>  hw/net/mdio.c                    |  264 ++++++
>  hw/net/renesas_eth.c             |  875 ++++++++++++++++++++
>  hw/rx/cq-frk-rx62n.c             |   94 +++
>  hw/rx/loader.c                   |  182 +++++
>  hw/rx/rx-gdbsim.c                |   98 +--
>  hw/rx/rx62n-cpg.c                |  344 ++++++++
>  hw/rx/rx62n.c                    |  140 ++--
>  hw/rx/tkdn-rx62n.c               |  192 +++++
>  hw/timer/renesas_cmt.c           |  283 -------
>  hw/timer/renesas_mtu.c           | 1312 ++++++++++++++++++++++++++++++
>  hw/timer/renesas_timer.c         |  639 +++++++++++++++
>  hw/timer/renesas_tmr.c           |  477 -----------
>  hw/timer/renesas_tmr8.c          |  540 ++++++++++++
>  MAINTAINERS                      |    2 +
>  hw/net/Kconfig                   |    8 +
>  hw/net/meson.build               |    3 +
>  hw/rx/Kconfig                    |   16 +-
>  hw/rx/meson.build                |    5 +-
>  hw/timer/Kconfig                 |    9 +-
>  hw/timer/meson.build             |    5 +-
>  36 files changed, 6391 insertions(+), 1173 deletions(-)
>  create mode 100644 include/hw/net/mdio.h
>  create mode 100644 include/hw/net/renesas_eth.h
>  create mode 100644 include/hw/rx/loader.h
>  create mode 100644 include/hw/rx/rx62n-cpg.h
>  delete mode 100644 include/hw/timer/renesas_cmt.h
>  create mode 100644 include/hw/timer/renesas_mtu.h
>  create mode 100644 include/hw/timer/renesas_timer.h
>  delete mode 100644 include/hw/timer/renesas_tmr.h
>  create mode 100644 include/hw/timer/renesas_tmr8.h
>  create mode 100644 hw/net/mdio.c
>  create mode 100644 hw/net/renesas_eth.c
>  create mode 100644 hw/rx/cq-frk-rx62n.c
>  create mode 100644 hw/rx/loader.c
>  create mode 100644 hw/rx/rx62n-cpg.c
>  create mode 100644 hw/rx/tkdn-rx62n.c
>  delete mode 100644 hw/timer/renesas_cmt.c
>  create mode 100644 hw/timer/renesas_mtu.c
>  create mode 100644 hw/timer/renesas_timer.c
>  delete mode 100644 hw/timer/renesas_tmr.c
>  create mode 100644 hw/timer/renesas_tmr8.c
>
> --
> 2.20.1
>
>
>

--00000000000010135305ae32f7a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hello Yoshinori,<div dir=3D"auto"><br></div><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le jeu. 27 ao=C3=
=BBt 2020 14:43, Yoshinori Sato &lt;<a href=3D"mailto:ysato@users.sourcefor=
ge.jp">ysato@users.sourceforge.jp</a>&gt; a =C3=A9crit=C2=A0:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">Hello.<br>
This series Renesas RX updates.<br>
<br>
It consists of the following contents.<br>
* Update firmware loader.<br>
* Rewrite peripheal modules (Timer and SCI).<br>
=C2=A0 - Unified SH4 module.<br>
=C2=A0 - Using clock API<br>
* New peripheal modules.<br>
=C2=A0 - On-chip clock generator.<br>
=C2=A0 - Multi-function timer.<br>
=C2=A0 - Ethernet MAC.<br>
* New real hardware target.<br>
=C2=A0 - TokushudenshiKairo TKDN-RX62N-BRD.<br>
=C2=A0 - CQ publishing CQ-FRK-RX62N<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">How can we test them?=C2=A0</div><div di=
r=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
<br>
Yoshinori Sato (20):<br>
=C2=A0 loader.c: Add support Motrola S-record format.<br>
=C2=A0 include/elf.h: Add EM_RX.<br>
=C2=A0 hw/rx: Firmware and kernel loader.<br>
=C2=A0 hw/rx: New firmware loader.<br>
=C2=A0 hw/rx: Add RX62N Clock generator<br>
=C2=A0 hw/timer: Renesas 8bit timer emulation.<br>
=C2=A0 hw/rx: RX62N convert new 8bit timer.<br>
=C2=A0 hw/timer: Renesas TMU/CMT module.<br>
=C2=A0 hw/timer: Remove renesas_cmt.<br>
=C2=A0 hw/rx: Convert to renesas_timer<br>
=C2=A0 hw/char: Renesas SCI module.<br>
=C2=A0 hw/rx/rx62n: Use New SCI module.<br>
=C2=A0 hw/timer: Add Renesas MTU2<br>
=C2=A0 hw/rx/rx62n: RX62N Add MTU module<br>
=C2=A0 hw/net: Add generic Bit-bang MDIO PHY.<br>
=C2=A0 hw/net: Add Renesas On-chip Ethernet MAC<br>
=C2=A0 hw/rx/rx62n: Add Ethernet support.<br>
=C2=A0 hw/rx: Add Tokudenkairo TKDN-RX62N-BRD<br>
=C2=A0 hw/rx: Add CQ-FRK-RX62N target<br>
=C2=A0 MAINTAINERS: Update RX entry<br>
<br>
=C2=A0default-configs/rx-softmmu.mak=C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +<br>
=C2=A0include/elf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
=C2=A0include/hw/char/renesas_sci.h=C2=A0 =C2=A0 |=C2=A0 129 ++-<br>
=C2=A0include/hw/loader.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A014 +<br>
=C2=A0include/hw/net/mdio.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 126 +++<br>
=C2=A0include/hw/net/renesas_eth.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A057 ++<b=
r>
=C2=A0include/hw/rx/loader.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A035 +<br>
=C2=A0include/hw/rx/rx62n-cpg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A072=
 ++<br>
=C2=A0include/hw/rx/rx62n.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A036 +-<br>
=C2=A0include/hw/timer/renesas_cmt.h=C2=A0 =C2=A0|=C2=A0 =C2=A040 -<br>
=C2=A0include/hw/timer/renesas_mtu.h=C2=A0 =C2=A0|=C2=A0 =C2=A090 ++<br>
=C2=A0include/hw/timer/renesas_timer.h |=C2=A0 103 +++<br>
=C2=A0include/hw/timer/renesas_tmr.h=C2=A0 =C2=A0|=C2=A0 =C2=A055 --<br>
=C2=A0include/hw/timer/renesas_tmr8.h=C2=A0 |=C2=A0 =C2=A067 ++<br>
=C2=A0hw/char/renesas_sci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1040=
 ++++++++++++++++++-----<br>
=C2=A0hw/core/loader.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 208 +++++<br>
=C2=A0hw/net/mdio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 264 ++++++<br>
=C2=A0hw/net/renesas_eth.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 875 ++++++++++++++++++++<br>
=C2=A0hw/rx/cq-frk-rx62n.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A094 +++<br>
=C2=A0hw/rx/loader.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 182 +++++<br>
=C2=A0hw/rx/rx-gdbsim.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A098 +--<br>
=C2=A0hw/rx/rx62n-cpg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 344 ++++++++<br>
=C2=A0hw/rx/rx62n.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 140 ++--<br>
=C2=A0hw/rx/tkdn-rx62n.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 192 +++++<br>
=C2=A0hw/timer/renesas_cmt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 283 -------<br>
=C2=A0hw/timer/renesas_mtu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1312=
 ++++++++++++++++++++++++++++++<br>
=C2=A0hw/timer/renesas_timer.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 639=
 +++++++++++++++<br>
=C2=A0hw/timer/renesas_tmr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 477 -----------<br>
=C2=A0hw/timer/renesas_tmr8.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 540=
 ++++++++++++<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
=C2=A0hw/net/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 =C2=A0 8 +<br>
=C2=A0hw/net/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A0 3 +<br>
=C2=A0hw/rx/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A016 +-<br>
=C2=A0hw/rx/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 5 +-<br>
=C2=A0hw/timer/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 9 +-<br>
=C2=A0hw/timer/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 5 +-<br>
=C2=A036 files changed, 6391 insertions(+), 1173 deletions(-)<br>
=C2=A0create mode 100644 include/hw/net/mdio.h<br>
=C2=A0create mode 100644 include/hw/net/renesas_eth.h<br>
=C2=A0create mode 100644 include/hw/rx/loader.h<br>
=C2=A0create mode 100644 include/hw/rx/rx62n-cpg.h<br>
=C2=A0delete mode 100644 include/hw/timer/renesas_cmt.h<br>
=C2=A0create mode 100644 include/hw/timer/renesas_mtu.h<br>
=C2=A0create mode 100644 include/hw/timer/renesas_timer.h<br>
=C2=A0delete mode 100644 include/hw/timer/renesas_tmr.h<br>
=C2=A0create mode 100644 include/hw/timer/renesas_tmr8.h<br>
=C2=A0create mode 100644 hw/net/mdio.c<br>
=C2=A0create mode 100644 hw/net/renesas_eth.c<br>
=C2=A0create mode 100644 hw/rx/cq-frk-rx62n.c<br>
=C2=A0create mode 100644 hw/rx/loader.c<br>
=C2=A0create mode 100644 hw/rx/rx62n-cpg.c<br>
=C2=A0create mode 100644 hw/rx/tkdn-rx62n.c<br>
=C2=A0delete mode 100644 hw/timer/renesas_cmt.c<br>
=C2=A0create mode 100644 hw/timer/renesas_mtu.c<br>
=C2=A0create mode 100644 hw/timer/renesas_timer.c<br>
=C2=A0delete mode 100644 hw/timer/renesas_tmr.c<br>
=C2=A0create mode 100644 hw/timer/renesas_tmr8.c<br>
<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote></div></div></div>

--00000000000010135305ae32f7a9--

