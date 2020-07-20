Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DE5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D1122C9C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uTODxsa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D1122C9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxW3N-0003Lt-37
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 09:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxW2X-0002n0-M3
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 09:41:09 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:42756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxW2W-00058t-51
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 09:41:09 -0400
Received: by mail-ot1-x332.google.com with SMTP id g37so12169047otb.9
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v+lngUFosB99Kn/ivfRt4/tlcgZhshLQky3x48I2LIw=;
 b=uTODxsa/KWIAfczQrh9zddU/nHenLXC66tP1jcvZfkG34Mro/gE6aaNMp0BeRQCXXl
 DvDMmqe+Y8WLm4fmtKI8iqEksisKZon9h3t8kOHzasGT8Oz/ZAkrlw3MFb+Q9R4Xf/26
 HXUFGBqY6Z2RF05ZIXZO2X5r2MNkErNdu5Cs8k0kpaKL6neEispgBA1+QnUjIwXORffi
 7jg84PB6aWWcbWhwJiWQmBoac5D/tsfjHuK2DhjJBUN2kD4Ium+1RsKGv5bMijXEngtp
 ihAFGr5qSviHbSmiXqbnGYTX/tdbjYp56M7NlIXVYwDCJHbLqIb8f81/ZX76ifG5OleU
 O1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v+lngUFosB99Kn/ivfRt4/tlcgZhshLQky3x48I2LIw=;
 b=XXdmtO4J450Gll59WYbcz1YmrL0AIoxZNTOkfui4f64jfK4jan5a8By8EYV9N7usyt
 1XoyNqKeTnEsDqb8AIpPiBV1V7e4vPNAvp5QO93OGXLN4NOTOomEkfVohlk+AFC7pb4C
 4b67C4PGwz2lSy1txLP73A9tBUzgGPteMZMRiepvzfUrYzwpfriZFEPtEpcaVDboiv4N
 16yLydvCNWvUJJB+MPnGI+pUYWAf3isOXAIY/zRjxmH1JoCqXKmOPFZk4sUQE/GoiRvE
 SNoIEfq//TSbpH+Pd1Qc8SqcXR1MzIe4+p1tLguID3l65tLggjnG1jiVaqQQ+t/HXvm6
 vgHQ==
X-Gm-Message-State: AOAM530cpGzwI5gyw8fpTRvBVRyxwF07NV/JG+s2z1icr2WJUxcBvd9q
 CNMcpLSkwCR9PdlthBmO//hvIVXMWjMs0oktAyQuZiK+
X-Google-Smtp-Source: ABdhPJyiPC6LnLCQwmfGkTHIXsrGbuPkLwN3LqGFxsVurR9Jd/6ehwCuzszUlDW963sFWUHa5psW/e9E47fW8lapGEM=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr19068813otk.221.1595252466953; 
 Mon, 20 Jul 2020 06:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <CA+aXn+EE2s55Y9gKUpckW_skw5sgonniPuEOFTjC+i1-dcWQyw@mail.gmail.com>
In-Reply-To: <CA+aXn+EE2s55Y9gKUpckW_skw5sgonniPuEOFTjC+i1-dcWQyw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2020 14:40:55 +0100
Message-ID: <CAFEAcA-Qt=_C3CriF-PVqXrvSP1G_VPR5-jGR32SkAG4b+MhaA@mail.gmail.com>
Subject: Re: VMState in QEMU
To: Pratik Parvati <pratikp@vayavyalabs.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jul 2020 at 11:59, Pratik Parvati <pratikp@vayavyalabs.com> wrote:
> Is it mandatory to define the state of each device? Like, for example, I am referring hw/arm/versatilepb.c; I see the VMState is defined for sic (secondary interrupt controller) Whereas VMState is not defined for PL011 UART device.

The PL011 does have VMState: it is in hw/char/pl011.c,
struct "vmstate_pl011". Generally the vmstate struct for
each device is in the source file where that device
is implemented. The SIC device is implemented in
the same versatilepb.c source file that the board model
is implemented in because it happens to be a simple
device used only by that one board, and so the SIC device's
vmstate is also in that source file. (The other reason
that the SIC device is in the versatile board's source
file is because it's quite old code -- these days we'd probably
put it in its own source file in hw/intc, but the coding style
back when that file was written over a decade ago was
different and devices often got put in the same
source file as the board model.)

thanks
-- PMM

