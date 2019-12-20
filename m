Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD023C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8066D206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsAxQZ17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8066D206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIQ1-0004QG-K0
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iiIOR-0003Ks-Hw
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iiIOM-0005Y0-My
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:32:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22939
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iiIOK-0005VK-Np
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576848745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fLQEqhGLRF+qLVy+VmGtZowBiX6uE7sCge73L4Z+Gk=;
 b=JsAxQZ17VaSuoadLUKvrc9KpZA6SJya6m4WVdQS7Y1/Iba57FE13xu73NF13zcez4T+0Rk
 s5u9ShCZTziquBeb8v+DSznP4UJpdIBDEezgwh+v/FdGg0GG6P03XN88g9hEuFlt0jLwKE
 f6jm6tvaWDVQNp6CPdl8n5i0yIuISC0=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-A4WJw8m_P76JAofTnoJI5A-1; Fri, 20 Dec 2019 08:32:24 -0500
Received: by mail-oi1-f200.google.com with SMTP id v14so4436775oic.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 05:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0fLQEqhGLRF+qLVy+VmGtZowBiX6uE7sCge73L4Z+Gk=;
 b=fadskLrGfxNta0G6XabK6/s5aw3NdiuEwtYXGT0pYI52fApRJJcV/lKPQxzFJOa8Zw
 FwgAJr/hv2X/yEFcJfOwGzSuDDT3coxnzPXVG7qXtsbnB9eUdsPdddQA//BO0GjVXHx4
 6oYJ0EXWa64X55rC7yhR7t2eEi2/pGJcQaI6YHok/sXCYNOx/CWIPm/8Q4hx+kEO8VEc
 vbpO1j5g2hiFOulGuv7iVp+YKVkTrf9bD8lteTyp9PpkAM8uNCWu0F/+Ti/JMvlZFhzZ
 9Acobukrbd+fbUFbw3Q/yu9Z2mg96zjWeBjND1+bA3rP8y3yxgnMOxs9zLbNWgX1adfc
 YMug==
X-Gm-Message-State: APjAAAV5WXB7eQNaTccQdBV0P3VUL6xnwQcA1xAZ64ErDCfdE17jzTyX
 TjY2oRDkEkxxVImGicStAjiiffwQWbDm0M7wbLReI6Lx39O/NWk6Apkyion7pzjux6el3OU5Yy0
 y77/XiQQ6Oa92Jx9h1HuXqm54X/2hBsk=
X-Received: by 2002:a9d:730e:: with SMTP id e14mr14225397otk.62.1576848743568; 
 Fri, 20 Dec 2019 05:32:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzNNKy3nwyIyaRG68ex95G+yRBCxBbFtkyPOP+yD/WrT3Ctc5S07fpiFH6Itusz2nOMfpdiy2YiQvieMeAdbs=
X-Received: by 2002:a9d:730e:: with SMTP id e14mr14225352otk.62.1576848743262; 
 Fri, 20 Dec 2019 05:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20191218172009.8868-1-philmd@redhat.com>
In-Reply-To: <20191218172009.8868-1-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 20 Dec 2019 17:32:11 +0400
Message-ID: <CAMxuvayWibPU6_mEcYEqsWUhSRra33MvwPrbAYr254ZYaYKBgg@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] chardev: Use QEMUChrEvent enum in IOEventHandler
 typedef
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-MC-Unique: A4WJw8m_P76JAofTnoJI5A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Alberto Garcia <berto@igalia.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-block <qemu-block@nongnu.org>,
 Zhang Chen <chen.zhang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, Joel Stanley <joel@jms.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Corey Minyard <minyard@acm.org>,
 Amit Shah <amit@kernel.org>, Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-s390x@nongnu.org,
 qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-riscv@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Michael Walle <michael@walle.cc>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 9:20 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi,
>
> After this chat on #qemu IRC:
> 13:20 <stsquad> so what is the difference between a IOReadHandler and IOE=
ventHandler?
> 13:25 <f4bug> stsquad: one is in-band and the other out-of-band?
> 13:26 <stsquad> f4bug: ahh yes it seems so - connect/disconnect etc...
> 13:27 <f4bug> see QEMUChrEvent for IOEventHandler
>
> I thought it might be a good opportunity to make the IOEventHandler
> typedef meaning more obvious, by using the QEMUChrEvent enum.
>
> To be able to build I had to explicit all enums ignored in the
> switch(event) statement by these frontends.
>
> Then I used a coccinelle spatch to change the various IOEventHandler.
> I don't think the last patch can be split, but suggestions are welcome!
>
> Regards,
>
> Phil.
>
> v2:
> - do blindly ignore all events using a 'default' case.
>
> Philippe Mathieu-Daud=C3=A9 (14):
>   hw/ipmi: Remove unnecessary declarations
>   hw/ipmi: Explicit we ignore some QEMUChrEvent in IOEventHandler
>   hw/char/terminal3270: Explicit ignored QEMUChrEvent in IOEventHandler
>   hw/usb/dev-serial: Explicit we ignore few QEMUChrEvent in IOEventHandle=
r
>   hw/usb/redirect: Explicit we ignore few QEMUChrEvent in IOEventHandler
>   ccid-card-passthru: Explicit we ignore QEMUChrEvent in IOEventHandler
>   vhost-user-crypto: Explicit we ignore some QEMUChrEvent in IOEventHandl=
er
>   vhost-user-net: Explicit we ignore few QEMUChrEvent in IOEventHandler
>   vhost-user-blk: Explicit we ignore few QEMUChrEvent in IOEventHandler
>   virtio-console: Explicit we ignore some QEMUChrEvent in IOEventHandler
>   monitor/qmp: Explicit we ignore few QEMUChrEvent in IOEventHandler
>   monitor/hmp: Explicit we ignore a QEMUChrEvent in IOEventHandler
>   chardev/char: Explicit we ignore some QEMUChrEvent in IOEventHandler
>   chardev: Use QEMUChrEvent enum in IOEventHandler typedef

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

(I guess Paolo will take the series for next PR?)

>
>  include/chardev/char-fe.h       |  2 +-
>  include/chardev/char-mux.h      |  2 +-
>  include/chardev/char.h          |  4 ++--
>  backends/cryptodev-vhost-user.c |  7 ++++++-
>  chardev/char-mux.c              |  8 ++++----
>  chardev/char.c                  |  9 +++++++--
>  gdbstub.c                       |  2 +-
>  hw/arm/pxa2xx.c                 |  2 +-
>  hw/arm/strongarm.c              |  2 +-
>  hw/block/vhost-user-blk.c       |  7 ++++++-
>  hw/char/cadence_uart.c          |  2 +-
>  hw/char/digic-uart.c            |  2 +-
>  hw/char/escc.c                  |  2 +-
>  hw/char/etraxfs_ser.c           |  2 +-
>  hw/char/exynos4210_uart.c       |  2 +-
>  hw/char/grlib_apbuart.c         |  2 +-
>  hw/char/imx_serial.c            |  2 +-
>  hw/char/ipoctal232.c            |  2 +-
>  hw/char/lm32_juart.c            |  2 +-
>  hw/char/lm32_uart.c             |  2 +-
>  hw/char/mcf_uart.c              |  2 +-
>  hw/char/milkymist-uart.c        |  2 +-
>  hw/char/nrf51_uart.c            |  2 +-
>  hw/char/pl011.c                 |  2 +-
>  hw/char/serial.c                |  2 +-
>  hw/char/sh_serial.c             |  2 +-
>  hw/char/terminal3270.c          |  7 ++++++-
>  hw/char/virtio-console.c        |  7 ++++++-
>  hw/char/xilinx_uartlite.c       |  2 +-
>  hw/ipmi/ipmi_bmc_extern.c       | 12 +++++++-----
>  hw/mips/boston.c                |  2 +-
>  hw/mips/mips_malta.c            |  2 +-
>  hw/riscv/riscv_htif.c           |  2 +-
>  hw/riscv/sifive_uart.c          |  2 +-
>  hw/usb/ccid-card-passthru.c     |  7 ++++++-
>  hw/usb/dev-serial.c             |  6 +++++-
>  hw/usb/redirect.c               |  7 ++++++-
>  monitor/hmp.c                   |  6 +++++-
>  monitor/qmp.c                   |  7 ++++++-
>  net/filter-mirror.c             |  2 +-
>  net/vhost-user.c                |  9 +++++++--
>  qtest.c                         |  2 +-
>  tests/test-char.c               |  6 +++---
>  tests/vhost-user-test.c         |  2 +-
>  44 files changed, 111 insertions(+), 56 deletions(-)
>
> Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> Cc: Andrzej Zaborowski <balrogg@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
> Cc: Fabien Chouteau <chouteau@adacore.com>
> Cc: KONRAD Frederic <frederic.konrad@adacore.com>
> Cc: Peter Chubb <peter.chubb@nicta.com.au>
> Cc: Alberto Garcia <berto@igalia.com>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Thomas Huth <huth@tuxfamily.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Amit Shah <amit@kernel.org>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: Paul Burton <pburton@wavecomp.com>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Zhang Chen <chen.zhang@intel.com>
> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-block@nongnu.org
> Cc: qemu-s390x@nongnu.org
> Cc: qemu-riscv@nongnu.org
>
> --
> 2.21.0
>


