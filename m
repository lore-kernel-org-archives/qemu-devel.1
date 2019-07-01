Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1383EC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:55:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFAC92146F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kb0zULR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAC92146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi5Cc-0003WM-QE
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 18:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51250)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3SK-0002z0-QH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3SJ-00032Y-HC
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:03:20 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3SJ-00030S-7y
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:03:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id r6so14947938oti.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mmzWI4rGYOcDZlfgefVMzjDWKHTWhgNNJ7GoLkF291Q=;
 b=Kb0zULR8tFo2+DAIaZJjGSVjHJDkX6PUOo495cutDvrP6JTvsNukusVz/kYzCnCFu1
 Ny+yeg/wAIi/4cxwSKRyQ7h222tnD+NlUI1c5wTxLTrwI69kYM8Vk4XxESnlxXPAxggK
 Ju38U8bl74c6Oz/z9Ul41maYXWRVJvDRcX0RTdtqvlx5w9FZTkK2zNiqlAIZXUFTnza1
 Ts0QURsAQgDk4+Ptp4bEfwq44skybOkO9IwfFJsLPwOLyQpgobcAaQxpjtaUTDw4iF3g
 wgTK0W6/5zTP7OieKEfyK91XolCRUNuU2xY8Lm931janEq3HC1GEziNsHKAZEO3yrdEA
 KiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mmzWI4rGYOcDZlfgefVMzjDWKHTWhgNNJ7GoLkF291Q=;
 b=Zkgq49g7iliv3Wsqd7nnd/uEbzdQZQ1Sig0TDXXE0WqpoOFkIxDTqi7ZJc40Y4m5hI
 CElG58Sg1WWH0u1t490lHmrU8Wt3wPEHruunulrskzwirlSWWI0n30A5HJ8zE5wYSVXY
 F1nRTj5VkU5aIOPEwiOe/ADkDtma5Fe9EoFDEYmgDp+m8CC6NKxI9/Hi93XaUTk8dF01
 KVyfMczkaIziL3MouRP0Z85QejfNstqgUFRUeE6f8teLZIjMGDc5A7TalfPJBdp/L/3i
 CInMM6hfqvdLhboA87JAT/AsDifHblLZJrocGTpsZ3F0zqVxiZjOJkvrV5ur6EdrtKWZ
 hBrg==
X-Gm-Message-State: APjAAAUWkqEUVDsumLgSdtLx2+B87PXCO2gS7FnxgbLsV+pgbx1qIF2E
 zlwa2TxvLbNnvQ5e5EeFGKs2IkdYgiOGA0jh+aiDmg==
X-Google-Smtp-Source: APXvYqweFORA1PZcuDtIiW0+gJPxczEIaj3kAmvIHBx1AvQB7qko/uyHreL1G/194fiJZCBPJRhJYSseKS9ekb0B+3s=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr19574517otj.97.1562004994964; 
 Mon, 01 Jul 2019 11:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <156200378933.9862.9905804796969886990@c4a48874b076>
 <81770e41-70a3-4e57-d7d7-501321843dd4@redhat.com>
In-Reply-To: <81770e41-70a3-4e57-d7d7-501321843dd4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 19:16:24 +0100
Message-ID: <CAFEAcA-co+55t2XmSrDkRiV1R+Tp-QQvFybUxW5a0nhW9PaCNQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.67
Subject: Re: [Qemu-devel] [PATCH 0/6] hw/arm: Use ARM_CPU_TYPE_NAME() and
 object_initialize_child()
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe DUBOIS <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 19:13, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> On 7/1/19 7:56 PM, no-reply@patchew.org wrote:
> > Patchew URL: https://patchew.org/QEMU/20190701123108.12493-1-philmd@red=
hat.com/
> >
> > Hi,
> >
> > This series failed build test on s390x host. Please find the details be=
low.
> >
> >   CC      hw/dma/i8257.o
> >   CC      hw/dma/xilinx_axidma.o
> > /var/tmp/patchew-tester-tmp-6umc5eop/src/hw/dma/xilinx_axidma.c: In fun=
ction =E2=80=98xilinx_axidma_init=E2=80=99:
> > /var/tmp/patchew-tester-tmp-6umc5eop/src/hw/dma/xilinx_axidma.c:568:29:=
 error: =E2=80=98TYPE_XILINX_AXI_ENET_DATA_STREAM=E2=80=99 undeclared (firs=
t use in this function); did you mean =E2=80=98TYPE_XILINX_AXI_DMA_DATA_STR=
EAM=E2=80=99?
> >   568 |                             TYPE_XILINX_AXI_ENET_DATA_STREAM, &=
error_abort,
> >       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       |                             TYPE_XILINX_AXI_DMA_DATA_STREAM
> > /var/tmp/patchew-tester-tmp-6umc5eop/src/hw/dma/xilinx_axidma.c:568:29:=
 note: each undeclared identifier is reported only once for each function i=
t appears in
> > /var/tmp/patchew-tester-tmp-6umc5eop/src/hw/dma/xilinx_axidma.c:572:29:=
 error: =E2=80=98TYPE_XILINX_AXI_ENET_CONTROL_STREAM=E2=80=99 undeclared (f=
irst use in this function); did you mean =E2=80=98TYPE_XILINX_AXI_DMA_CONTR=
OL_STREAM=E2=80=99?
> >   572 |                             TYPE_XILINX_AXI_ENET_CONTROL_STREAM=
, &error_abort,
> >       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       |                             TYPE_XILINX_AXI_DMA_CONTROL_STREAM
>
> It would be nice if GCC directly fix the patch instead of embarrassing
> the author for obvious copy/paste mistakes...

Sufficiently new gcc supports -fdiagnostics-generate-patch, and you could
probably script up a wrapper to automatically apply the patches ;-)

thanks
-- PMM

