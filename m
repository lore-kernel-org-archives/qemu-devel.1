Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023D4C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 19:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6ACD20740
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 19:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6ACD20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHBim-0007fz-08
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 15:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBaK-0003Rr-BT
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 15:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBaJ-00015o-7I
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 15:21:04 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33763)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBaJ-00015G-3M; Wed, 25 Mar 2020 15:21:03 -0400
Received: by mail-yb1-f195.google.com with SMTP id p196so1851437ybc.0;
 Wed, 25 Mar 2020 12:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=T7mqDw2HPhBZ7XgToqhMzKZGp93hboGgHXk/bjxfHVU=;
 b=eqFcCiEyGEceAY7Ni2/THtgjmatmVtSr5OxGEmAMH93XToMezN8EEyOpbbm4d2b25s
 BlsbWh1QioWa0svn/bnnfTIIOgq1HUuYzgXIg5+hNT4OvICyLvYK+IigvWkTkyGH9EGT
 f2udFp6fvsjivPTdGeuNM/7VE+VzuSpD4a3nMWQ88nEuuuxg+r28t8BpKJLhAo84w12n
 w5EW6jeCJMWxrUNOSibgfGngb17DjJQ1XjgLzB1ka88sMhaF7aCcH/pLWLHm7bG0CJu7
 MgFHOCiBZM7il5+BinXhiVSo7X2EXzbCOddGJlYlcKvz6MqBjmBS8YmbPym5MzBTViWf
 aBcg==
X-Gm-Message-State: ANhLgQ17s1PER9pkddXYVNPsbmr22FQ9Eqg9BbwAkG1KWK3jA1z2HtG/
 6gh9Qg4ttQftQP1UEDKBhu4EcC8idrUIKPgE4jHPT1768+c=
X-Google-Smtp-Source: ADFU+vvfrqMG8fqoX/dokfqqLXlix3EsPQSyGDtnBsA5mfZ881GiL16nL9rSiXq6eBauuYk7jPQI6HGtLexiZ30o30I=
X-Received: by 2002:a25:6d54:: with SMTP id i81mr7843704ybc.323.1585164060908; 
 Wed, 25 Mar 2020 12:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
In-Reply-To: <20200325191830.16553-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 25 Mar 2020 20:20:49 +0100
Message-ID: <CAAdtpL7rC1u=B-xW+ZbrRbpSMKvGx0kq_hug1J9-cxx6NgJR1Q@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 00/12] hw: Add missing error-propagation code
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.195
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 25, 2020 at 8:18 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> This series is inspired of Peter fix:
> "hw/arm/xlnx-zynqmp.c: fix some error-handling code"
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg691636.html
>
> Add a cocci script to fix the other places.
>
> Based-on: <20200324134947.15384-1-peter.maydell@linaro.org>
>
> Philippe Mathieu-Daud=3DC3=3DA9 (12):

Hmm is that a git-publish bug?

>   scripts/coccinelle: Add script to catch missing error_propagate()
>     calls
>   hw/arm/bcm2835_peripherals: Add missing error-propagation code
>   hw/arm/fsl-imx: Add missing error-propagation code
>   hw/arm/stm32fx05_soc: Add missing error-propagation code
>   hw/i386/x86: Add missing error-propagation code
>   hw/dma/xilinx_axidma: Add missing error-propagation code
>   hw/mips/cps: Add missing error-propagation code
>   hw/mips/boston: Add missing error-propagation code
>   hw/mips/mips_malta: Add missing error-propagation code
>   hw/misc/macio/macio: Add missing error-propagation code
>   hw/net/xilinx_axienet: Add missing error-propagation code
>   hw/riscv/sifive_u: Add missing error-propagation code
>
>  ...ect_property_missing_error_propagate.cocci | 58 +++++++++++++++++++
>  hw/arm/bcm2835_peripherals.c                  |  8 +++
>  hw/arm/fsl-imx25.c                            |  8 +++
>  hw/arm/fsl-imx6.c                             |  8 +++
>  hw/arm/stm32f205_soc.c                        |  4 ++
>  hw/arm/stm32f405_soc.c                        |  4 ++
>  hw/dma/xilinx_axidma.c                        |  3 +
>  hw/i386/x86.c                                 |  4 ++
>  hw/mips/boston.c                              | 17 ++----
>  hw/mips/cps.c                                 | 52 +++++++++++++++++
>  hw/mips/mips_malta.c                          | 19 ++++--
>  hw/misc/macio/macio.c                         |  4 ++
>  hw/net/xilinx_axienet.c                       |  3 +
>  hw/riscv/sifive_u.c                           |  8 +++
>  14 files changed, 184 insertions(+), 16 deletions(-)
>  create mode 100644 scripts/coccinelle/object_property_missing_error_prop=
agat=3D
> e.cocci
>
> --=3D20
> 2.21.1
>

