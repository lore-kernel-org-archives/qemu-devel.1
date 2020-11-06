Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEF9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6FB2067B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7rDrIkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6FB2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb6gM-0002k1-B8
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb6eX-0001R9-5L
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:40:01 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:43855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb6eQ-0006dk-Vy
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:39:58 -0500
Received: by mail-ed1-x543.google.com with SMTP id b9so2261052edu.10
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 10:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3pOUAuYQLvwSPgtgvux6WqypsdNnpVvcasfii0LsbMI=;
 b=T7rDrIkCAybWK2B61fegczJTcwsVvHfOksco30rHmMDuoWnjDWbtVA1nCeHnrtjLCV
 rdEyzYJSj7s8LLd4HcEMqCt0KjUzaxgzHg0xU9CLKRWkfr+BFdpstvoIAGY5n79wUwbj
 OYQ/2ihZbu2VZ+zpBSNcu15v7Ls5P5jTYeAawSqh9q6EgNL1ddF6p+KRpqMcMYxRDUV5
 ArreExmvFPfuXB1Hs/vFMmwMYi07+frqhbpcT37H2xI01CU3JXlcGse7nNRx6ILUhsOD
 QQ0HeKyofKG3Zvw2wpw4A5HZ6F0uqTNOwBqQY9tHCM86QmJzWRkUU5V6rnZ1mBMgnARh
 RKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3pOUAuYQLvwSPgtgvux6WqypsdNnpVvcasfii0LsbMI=;
 b=mE24hztKiYngDK7KWy8B1963yKxZ41ho1UllmTIT48mCy83JOC06peZ96Lw8pWukZ/
 frPuC1FJ95fSAnT1ALiBD6y5akiCaUUkndSM1VS6jC9nOfqDwVoMq3O/jqY2ip4yFcFL
 7Pl6olbRWv6DzaVRDPaaGbx/SLWenghTjpJJ5eg7MFCVeho43T5x747WRjUCr0Dgq/2n
 SXvSKINXQpHpv42Fs+DwvGqUlHdnfZC6EypsuvjhddJ1EkY1PC3hHJoyni3vFOSWQkl0
 XLwQ2sYBxq5MYDpM3ENF8S5zQ+i0CrO+CXscTkAeN/SOTgVx1u6XCm8EFGRbPw4wuQgo
 IgCQ==
X-Gm-Message-State: AOAM531UZ6ECX15vA3rhdk00v8xUZ8N6316OTG7V5zB+d5r3swxtavKu
 ZRNbzU9UyxCyPkTzE3ARmvskZVdYuzr0e4RmC9pnWA==
X-Google-Smtp-Source: ABdhPJwDo5CguyMxXhaVhUD44mRVyjV8A9aC1+wd7NTU4SlYO8OvjsmD/u3PTjaMeTMEoY+/Qs4jC/RMD2OTgfHkdBM=
X-Received: by 2002:a05:6402:b35:: with SMTP id
 bo21mr3569529edb.52.1604687992854; 
 Fri, 06 Nov 2020 10:39:52 -0800 (PST)
MIME-Version: 1.0
References: <20201106171153.32673-1-peter.maydell@linaro.org>
 <20201106171153.32673-5-peter.maydell@linaro.org>
 <b545a78d-7b11-7c6d-cdf7-bf20272b8fd6@amsat.org>
In-Reply-To: <b545a78d-7b11-7c6d-cdf7-bf20272b8fd6@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2020 18:39:41 +0000
Message-ID: <CAFEAcA8y4MVDD3SXsVbm5GAXSdaRHFONNV3xDxEooBs8nL4XKA@mail.gmail.com>
Subject: Re: [PATCH for-5.2 4/4] hw/net/ctucan_core: Use stl_le_p to write to
 tx_buffers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: Jason Wang <jasowang@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Nov 2020 at 18:31, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> On 11/6/20 6:11 PM, Peter Maydell wrote:
> > Instead of casting an address within a uint8_t array to a
> > uint32_t*, use stl_le_p(). This handles possibly misaligned
> > addresses which would otherwise crash on some hosts.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  hw/net/can/ctucan_core.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
> > index f2ce978e5ec..e66526efa83 100644
> > --- a/hw/net/can/ctucan_core.c
> > +++ b/hw/net/can/ctucan_core.c
> > @@ -305,8 +305,7 @@ void ctucan_mem_write(CtuCanCoreState *s, hwaddr ad=
dr, uint64_t val,
> >          addr %=3D CTUCAN_CORE_TXBUFF_SPAN;
> >          assert(buff_num < CTUCAN_CORE_TXBUF_NUM);
> >          if (addr < sizeof(s->tx_buffer[buff_num].data)) {
> > -            uint32_t *bufp =3D (uint32_t *)(s->tx_buffer[buff_num].dat=
a + addr);
> > -            *bufp =3D cpu_to_le32(val);
> > +            stl_le_p(s->tx_buffer[buff_num].data + addr, val);
>
> Out of curiosity, how did you notice? Passing by while reviewing?

I saw it while I was fixing the Coverity issue from
patch 1, yes.

thanks
-- PMM

