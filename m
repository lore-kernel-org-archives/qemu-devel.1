Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BC0C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD162184E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atvHOqa2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD162184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzaBo-0005JN-Kh
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzaAA-0003u6-1d
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzaA9-0005me-3I
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:25:01 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:35525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzaA8-0005kw-Tq; Mon, 19 Aug 2019 01:25:01 -0400
Received: by mail-ed1-x542.google.com with SMTP id w20so477571edd.2;
 Sun, 18 Aug 2019 22:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Kw8gZukUQn7Y0YiR2lb3z6XxAV+KtL/W1eXtQ5TEyOI=;
 b=atvHOqa2h1M7il1dJDVq6U0vuvXfIHLCSYRO8vn4ITyO7qkL4x6lbeukOX7yDvz+bl
 Z5RAmKiEeH2NaydGRpSczxEdgp0a70+ZVtwIzlPJU/XvH4x1JlLCQp8xHM0XZNotyyWf
 MFrXdcCegQWkA+/e89tBc0PzJ2ptdcnHENcHUTA5mshO/fDcfnN2iBzgCLzI6CiWJqZK
 QUi/E2cP1218e+cLxNraZWSAPhHxD48hgx4rsL5vafH5JnDxUL83ZqpMMmSBtE8JEgVo
 F4AOPlkk++0iBIA33+IEIdzftTHhxL97XNaOBOD5U5y2LfGZ3UHiJ0yIFACSRtjluQ87
 svLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kw8gZukUQn7Y0YiR2lb3z6XxAV+KtL/W1eXtQ5TEyOI=;
 b=l9HRm/bCtc4WT+qenfvBDv8xkohaB7WHFkGrgDGb6qMftpPs9Zs38bOJqtjvEmWJDo
 /zTBOJom7sEHPFxd51Z2J7YkccJ6KIXbyuCHziyTa/DfCE10PffPqTJV108PpRv6twNx
 MLOK5M+xHmoaFp14hoXeS/Qpy+2jI5/9zICidx6xTOLFQsIeNGFIxaXjvgAaowpwHMH7
 p0hQ87awlt2AbjAFqj2FNvFQB9bozMzzRMLnScxSXKomKClwFeJzwuVnD6dqvTeqD2p5
 TyNIwDJk7AZjINGDSsfEtG1/JQ65MH0h5Rcgg1JCmLy9kxVSiCUGX+XndNAUtWabnXDf
 6K1w==
X-Gm-Message-State: APjAAAUUj/WRU2wQFJMLJtcGtmOfCBjGw8DXjTjp/d3UCpuYpf/2RTHm
 p/BrM3345a1lgn5RA69x4dJNKkTeMRTWsq2D/ds=
X-Google-Smtp-Source: APXvYqxw6GFQdqIMDUq68tJ+4wuAqTqjMsG7PC9ielCXcULMHoPguM5vOSxL+73k5LlGTYlNRtMUNiorhHExmA2RkMA=
X-Received: by 2002:a17:906:32c2:: with SMTP id
 k2mr2762236ejk.308.1566192299260; 
 Sun, 18 Aug 2019 22:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <1565335544-23584-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKOyTXgs5uZuukZjAEqQkTtf1U+vD=u9_470+OgsfaQdqQ@mail.gmail.com>
In-Reply-To: <CAKmqyKOyTXgs5uZuukZjAEqQkTtf1U+vD=u9_470+OgsfaQdqQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 19 Aug 2019 13:24:48 +0800
Message-ID: <CAEUhbmW0sCEN7mzSfCvUBSqhAGD3v5JyeDj2iSqs0MQJv13bag@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v3] hw: net: cadence_gem: Fix build errors
 in DB_PRINT()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 10, 2019 at 9:58 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Fri, Aug 9, 2019 at 12:26 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > When CADENCE_GEM_ERR_DEBUG is turned on, there are several
> > compilation errors in DB_PRINT(). Fix them.
> >
> > While we are here, update to use appropriate modifiers in
> > the same DB_PRINT() call.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>

Ping?

What's the status of this patch?

Regards,
Bin

