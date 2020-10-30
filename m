Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA094C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9F9206E9
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYQYJtbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9F9206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVWw-0006Nl-9L
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYVVR-0004nR-UN
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:35:55 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:42330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYVVP-00020P-8g
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:35:53 -0400
Received: by mail-ej1-x642.google.com with SMTP id gr24so50071ejb.9
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lA++Hl5Ff23cexy9HPHp57mTBkMdUE4lxCl2ZEu5RIM=;
 b=FYQYJtbqal6X0CHAm7FeiWXGeqGqRbSLTOTh1aDXPr/tlVrKLucN+qHwwX53e6ItMp
 uvnyA/0L++AZYAXpSmmbcxfLM7m/D4cwKXMMVejo6OxPpLHqDojWmDwA5xgR9F+RC9TE
 1fHoAi4hOo1etOJaE6eE/G/Y6tSI4lkOv0huUguz/uHBuqSLcwxxi7ppm5v7fr5r4a5T
 VXEqa4j7B5OZLs6y2Gtj5VoMXVJj6iVvC1Po3dQ3OoAc3CCZNYvShUgXZtzYxCGaVN0s
 +7C8N0H80vNc4v489ZrzalwxIdSIuaObjM/2NtGvrbAVj/v+0J1uvs6BCVs6EkZK4MJd
 pxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lA++Hl5Ff23cexy9HPHp57mTBkMdUE4lxCl2ZEu5RIM=;
 b=XrGej8YpjvvkE8VnZZHxSMWzDzQdffow45RDmr3ERi1VhcFVcbcUAFrGrWbrgF1UxL
 pBTWi5b4MDeOmVYfKMTyemINCk+Xt6MF3FYWgWkaxcnaAxbl7RWxNT5BUBSWkT5dtuBh
 /Von3SVh1rDelE6FZ8tu9IpeY8R66b7LwjxZI2F2dHL36pKhwW7HBDwcUuJ8KItjmtMI
 vq5ygqVNvFFlp2s4iqXFi+F4paicHWdH7z2+Es/VqML/oj8LpXbelS043QUJ3jiMI4XS
 ShiI567dfqmhsCH90rEgw8ciY5m/BLfz1ZTKUbLn9IhI4FsM0xdzMAeFeNkGKOr5YOKd
 TIEQ==
X-Gm-Message-State: AOAM533LwcvjFeS//aFzwLtJQrO0UDkIeA9SGCDogFELQ68f1TJ/bxFO
 40oLBjC8kjHTDPVVw7d8k4il4RcE3h0cnLWCXebCwg==
X-Google-Smtp-Source: ABdhPJwvOxrrKtyKgJhUGZ+kKOdLBqn04/bm4a7JzmV/3Cmy/KMzHtdyrwuJlxSC2OC2Mq6ppur09aEmua64N9JA1pA=
X-Received: by 2002:a17:906:af8c:: with SMTP id
 mj12mr2669056ejb.85.1604068548940; 
 Fri, 30 Oct 2020 07:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <5F9BE993.4050406@huawei.com>
 <CAFEAcA8hpb2UVd3PSY4XuEpKYeu1Am1+41DQ=gN48xbAv281TQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8hpb2UVd3PSY4XuEpKYeu1Am1+41DQ=gN48xbAv281TQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 14:35:37 +0000
Message-ID: <CAFEAcA-WTw-0EvT1REbTrtgLB9sBbnJBuNW9LMh7eOtsXtrDTw@mail.gmail.com>
Subject: Re: [PATCH] hw/display/omap_lcdc: Fix potential NULL pointer
 dereference
To: AlexChen <alex.chen@huawei.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 at 14:29, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Fri, 30 Oct 2020 at 10:23, AlexChen <alex.chen@huawei.com> wrote:
> >
> > In omap_lcd_interrupts(), the pointer omap_lcd is dereferenced before
> > being check if it is valid, which may lead to NULL pointer dereference.
> > So move the assignment to surface after checking that the omap_lcd is v=
alid.
> >
> > Reported-by: Euler Robot <euler.robot@huawei.com>
> > Signed-off-by: Alex Chen <alex.chen@huawei.com>
> > ---
> >  hw/display/omap_lcdc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)

> Applied to target-arm.next, thanks.

Whoops, spoke too soon. This doesn't compile:

../../hw/display/omap_lcdc.c: In function =E2=80=98omap_update_display=E2=
=80=99:
../../hw/display/omap_lcdc.c:88:10: error: =E2=80=98surface=E2=80=99 may be=
 used
uninitialized in this function [-Werror=3Dmaybe-uninitialized]
         !surface_bits_per_pixel(surface)) {
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


because the early exit check
    if (!omap_lcd || omap_lcd->plm =3D=3D 1 || !omap_lcd->enable ||
        !surface_bits_per_pixel(surface)) {
        return;
    }

uses 'surface' and this patch moves the initialization of that
variable down below its first use.

thanks
-- PMM

