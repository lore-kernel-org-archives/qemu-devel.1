Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900CEECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DDE820872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBaPtzoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDE820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8DV-0002P8-0P
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL7JV-0005bi-KA
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL7JU-0006db-C3
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:03:41 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL7JU-0006d4-69
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:03:40 -0400
Received: by mail-oi1-x242.google.com with SMTP id 83so2452820oii.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3FQnecCqLwopkxDYIuZU7fIcstEcAXt9nnbmXFrtXvE=;
 b=EBaPtzoSUc21e1qdbP2MB8MFZ6lMAQgatusOB5VDgx3CCK3LyF2ynUsrgP66A9Syz5
 qnMPVT0/w+wF7HU1WO9piQdeTedejWf5QkCWz3IOUy86Ctmd+BtWZaQLGrxBbkoxKm+f
 2U1O4YlYlydQHa0wBh147jLBUWadIM+gHuNvn3pkJYnB7cYT3aOzjwFtPCEtrX63J5jl
 Z/YxTf9qaDYIDcPRo+T3KiUtGUUgXmsAcmR7oVe4OD/ww4lYFmY5JmUBAHIr2Zrk/zjz
 d20jg+HLFp1mqm9Co7nDv0teEVS/tFQ5wOFJ7NI5mriuARzQgrfbbxZ4saLxvjc+iYk0
 Mazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3FQnecCqLwopkxDYIuZU7fIcstEcAXt9nnbmXFrtXvE=;
 b=cGyRkpr/mdiD4/Ns4hB0s46HwKdadOSTodSsFSmCCzTd9iDf6/vyItw0e3+jrlP4qz
 GJSSjU7ABGvwvJ22JG38wv8FCOgBGupqr+IeB5CaspixSKSL3pE3kSqmg1RCu4P02tDR
 +BD4rgiZDE8JL06ert+9iil33q4dU6gx57ElprpHJE9/BQLXpQoklQz/1kjzH1Ng6Y/5
 1EyYKv9ImM19dGiiKqnAak+0pLGnxM8EZ/9TeQqnVjbHZVsV4wH9eWwsdEiqHXO8R+wW
 V0RTjrkDiiACebcXQhp3L89A/qFwNafSj+31XU25nS7LS8b7qV7vjVlZfwG6YYfry9N/
 rgWA==
X-Gm-Message-State: APjAAAXNGF81DmH+r/V+PvxyKYIwq3Q7UFK1eB2rtfmPJppOyinvBzd0
 ZmJf9AaVc/KAyAWOJn+szciLDUSWNASoxs8bkB30Cg==
X-Google-Smtp-Source: APXvYqyt3Nvf4UlAsoXV+jpw0Ptq/fdVum4IYFUOdfMxpiAzjyTS+jQhS2qKFLcePat357/8UyxhYb7fR7FubaNE3G8=
X-Received: by 2002:aca:49c2:: with SMTP id w185mr3660773oia.163.1571324619468; 
 Thu, 17 Oct 2019 08:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191017132122.4402-1-peter.maydell@linaro.org>
 <20191017132122.4402-3-peter.maydell@linaro.org>
 <cabcec27-c6a7-6ea7-e933-589f2385c137@redhat.com>
In-Reply-To: <cabcec27-c6a7-6ea7-e933-589f2385c137@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 16:03:27 +0100
Message-ID: <CAFEAcA9dRMu_hauo_PuJyWh03+-Y9ogWmKSBfzu_6GhYCrnDAQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/timer/xilinx_timer.c: Switch to transaction-based
 ptimer API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 at 15:57, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Peter,
>
> On 10/17/19 3:21 PM, Peter Maydell wrote:
> > +/* Must be called inside ptimer transaction block */
> >   static void timer_enable(struct xlx_timer *xt)
> >   {
> >       uint64_t count;
> > @@ -174,8 +173,11 @@ timer_write(void *opaque, hwaddr addr,
> >                   value &=3D ~TCSR_TINT;
> >
> >               xt->regs[addr] =3D value & 0x7ff;
> > -            if (value & TCSR_ENT)
> > +            if (value & TCSR_ENT) {
> > +                ptimer_transaction_begin(xt->ptimer);
> >                   timer_enable(xt);
> > +                ptimer_transaction_commit(xt->ptimer);
>
> Why not move these inside timer_enable()?

Because timer_enable() is called from the callback
function timer_hit(). Since callback functions are called
from within a begin/commit block, if we called begin
again in timer_enable() it would assert().

thanks
-- PMM

