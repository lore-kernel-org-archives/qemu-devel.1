Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE144C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 12:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872CF2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 12:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yILxsa7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872CF2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaf6b-0001vv-LG
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 08:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jaf5z-000104-UQ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 08:42:15 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:34578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jaf5y-0004dU-F7
 for qemu-devel@nongnu.org; Mon, 18 May 2020 08:42:15 -0400
Received: by mail-oo1-xc42.google.com with SMTP id s139so1995371oos.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 05:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JtBtE3nw27El8VWoeJ7zSYWKXQECO0bpQV+zh5rOwjY=;
 b=yILxsa7bQrRoII2s2M94XNarz+RsQN8KAYDiK04dWhOlZwqUT63SlnpSz4yyP1cuv6
 qSMKgupJVmuZ+M+N73m1fzPheqmJox512ecMu0bP4X3FWVvuiun2eiJSGgQAIf727+vl
 wl9FrzLd8ShXNe+u5TrCeWtynsgnomEOJDipgB/+g/5yER8QxPGvoSBDBO2T+/mfWHG0
 cvONHEhz2f4ksbdjncr8psNOJni7yCft7KVuQb8K/lMS1ojoMcpPvY1dI2wLeyqXfq1I
 Mi7AHEzSK0+HjQDHAdqujtWZZjcDCY05IFDDJfOytYe+rxltJ79eIHW7+qtZAgyNgO87
 50eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JtBtE3nw27El8VWoeJ7zSYWKXQECO0bpQV+zh5rOwjY=;
 b=PnDDmciMSPUE87rIxHYbeOEO3CdApPUqTeBfjPXSxtDYWAmG18grhlPQROrptl29tY
 kiPnFKsaz1BPUSSgww5tqaZPoAczcLyr5b3K2+H2IDYeGP3siy4IqwmpPsANviRPywNf
 5bdAUNqlKMpOokFaarleHsAhKNx/e1POkqSVyXqNDOl522Bau+IO9Apmm+Xla2cGYrmO
 /vH251Yo2EmX0LQt4+IO/pjKjMCzAP+OnfHE3vmvoUykSE3L3tmIQU0D5esKP8zXvriL
 2KwfBuR48NoLDVVEo1o/+0e3WZblLFVALy8ZhdEaLQ58USKE87iy54mp7d+eXnmOQKgG
 SMcA==
X-Gm-Message-State: AOAM531GYWRMbdvhR3GNdqdk/xyeW0/Pc912/Rx3VP3IjKylkLajp+iY
 Z4+yFh2onkSFq69wvCioYZwmjUBcbg1GCkYOGjZazw==
X-Google-Smtp-Source: ABdhPJyn086ODLNF0KvCWf0mNSpyFFh1s0YRKG58JrKufOXvh2yYRIr+4NG9MmT/4Z65bGS47Iki1FCtT25NmkhixXM=
X-Received: by 2002:a4a:d136:: with SMTP id n22mr12769091oor.85.1589805733154; 
 Mon, 18 May 2020 05:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200511205246.24621-1-philmd@redhat.com>
In-Reply-To: <20200511205246.24621-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 13:42:02 +0100
Message-ID: <CAFEAcA9yKxqYW0fEC87sLPwVACBzbQ2+XS-gNG8-x-VfCeAH=w@mail.gmail.com>
Subject: Re: [PATCH] hw: Use QEMU_IS_ALIGNED() on parallel flash block size
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <leif@nuviainc.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 May 2020 at 21:52, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Use the QEMU_IS_ALIGNED() macro to verify the flash block size
> is properly aligned. It is quicker to process when reviewing.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/arm/sbsa-ref.c       | 2 +-
>  hw/arm/virt.c           | 2 +-
>  hw/block/pflash_cfi01.c | 2 +-
>  hw/block/pflash_cfi02.c | 2 +-
>  hw/i386/pc_sysfw.c      | 2 +-
>  hw/riscv/virt.c         | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

