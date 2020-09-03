Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCDBC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057A6206E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IH86kLBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057A6206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnIO-0001vT-6E
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDnHU-0001Mf-Le
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:19:52 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:39432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDnHS-0007Iw-TT
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:19:52 -0400
Received: by mail-ej1-x642.google.com with SMTP id p9so3304212ejf.6
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4Ganswe+9U9d3mD63BLo8JQ6z2589NIHqh5cScxKjHs=;
 b=IH86kLBeHEXrfP8VR4LP+ze5pqHViWWZMQl9IZRBZuoiLPDRtBTqidAi65kBd5xYaD
 5oJDELKIdZLnJ5LOKzTARpTyrmFHA0Tp+020O8EKjKtDJoUUDnAD1zkftVi1ONgnnhhh
 MWvVF++WeyhFUqpHnoFO+Qw3zaUAz7Z6h2qmXD3nzbTYmOveHgM0hqr/fm2RPUTL5EBk
 7/A8T3WKnk5xiYWNzzD8gg2vnE200MNCeFWcMcuTVSEtx5ZN/5FfTVNhrVXrt7sEkNre
 ZUqGam8y491k4EsQaplUgJgplsjZJl9q9HSF4S33Km7/DSlGBQS3R/mPxEgs/BO0eDuq
 N4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4Ganswe+9U9d3mD63BLo8JQ6z2589NIHqh5cScxKjHs=;
 b=DeRYOZ3t3+kMN5mz/1nHCaLwK2uVLQjPUKJCfEXCEpAWHg08lF3O3m6U7YP+y1SabQ
 hFLwbntrIvztk0US0J2KH2RNlGo/anpyc/9vPmKf1tLXvEewjv8LnFP4+1eYV487Z30d
 zuLDlvNdhcikLhWqVvUdOdOWNuorfjCtkyImrDTdzPbOkCpW8nW6Hdrj2onQsv+H+B9g
 0D6ewrYf/8lzg+Mtf1n73V1XwxlEu9RfhbZhyw5idH3lR8vco+HoJWhhqLSHuHBDIsJQ
 TB9YBWIaEj6y90g4IKoB/ZrS+KGPntywpdR+o2naM+ZNKdIKjQsTuR4g31QmBZlurSoU
 a/JA==
X-Gm-Message-State: AOAM530jUXqC/7QeU54/FnILhmBTYIVyjVFP+McAbkNg5MzbjxzAq9k4
 hpC8VDLDgaMIVV+VhY6pEwNJWAcCsI0bpPHSrUwFfg==
X-Google-Smtp-Source: ABdhPJweiJYZjnF2kxV+UKFl44MQRPF5DqSf69yPG5mc7ZzvH1F3pbuif6HB8ULld+7lgNXRqi9McdA+X/HabFffzgQ=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr1554354ejr.482.1599131989169; 
 Thu, 03 Sep 2020 04:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200902162206.101872-1-liq3ea@163.com>
 <b840aab8-542d-af43-43e5-0a07f442b5d5@redhat.com>
 <CAFEAcA9mvMaR5MJJ74Vv63TG6frWnMeSZA19Zxv8TUceudPUTQ@mail.gmail.com>
 <CAKXe6SLYgkiTAYa81nppHUMEzoeGy3988OmrzZyw8-VY8ajE3w@mail.gmail.com>
In-Reply-To: <CAKXe6SLYgkiTAYa81nppHUMEzoeGy3988OmrzZyw8-VY8ajE3w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Sep 2020 12:19:37 +0100
Message-ID: <CAFEAcA9TEpfBmfOOtpfR9JCAFkMF0fy20L=DBVDTFaLp6J3Lfg@mail.gmail.com>
Subject: Re: [RFC 0/3] try to solve the DMA to MMIO issue
To: Li Qiang <liq3ea@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@163.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 3 Sep 2020 at 12:11, Li Qiang <liq3ea@gmail.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=88=
3=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:53=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > On Thu, 3 Sep 2020 at 04:55, Jason Wang <jasowang@redhat.com> wrote:
> > > I think we still need to seek a way to address this issue completely.
> > >
> > > How about adding a flag in MemoryRegionOps and detect the reentrancy
> > > through that flag?
> >
> > This won't catch everything. Consider this situation:
> >   Device A makes DMA access to device B
> >   Device B's write-handling causes it to raise an
> >    outbound qemu_irq signal
> >   The qemu_irq signal is connected to device A
>
> Here mean device A is an interrupt controller?

No. Any device can have an inbound or outbound qemu_irq line.
We use them not just for actual IRQ lines but for any
situation where we need to pass an on-or-off signal from
one device to another.

> This is special case I think.

It's an example of why looking purely at MMIO is not
sufficient. We should prefer to see if we can come up with
a design principle that works for all between-device
coordination before we implement something that is specific
to MMIO.

thanks
-- PMM

