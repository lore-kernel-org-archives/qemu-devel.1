Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D584C2D0BF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192E6206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVDtMmy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192E6206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igu5M-0005tO-O6
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igtgL-0006dV-2Q
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igtgJ-0001EM-OJ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:57:16 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36037)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igtgJ-0001B6-DU
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:57:15 -0500
Received: by mail-oi1-x243.google.com with SMTP id c16so3091650oic.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QaFLLYDEWud99qoiUNGEueTX0iNK5/Ih2SGsu7QWWCw=;
 b=hVDtMmy3zyYCoxN+m2cHJqFkUt9piFFGIUuFoZwabaoY+KnWL6g2duJZedACp2UzsZ
 2zy1zKhI3/uWpRvP813LzBbrrm305FHOLT5292dUaOX6iKW+K77R4zCWMoZLovQdVnd6
 ZJBK6kWK891LU9P+makBzD/SpDs8gRzB2ubFxDPVueUXt8nUUvC9Rl2pz8lo5euJGxxi
 V7XgljTgNwAIanV59QEfhVNPB86z4zjZIeUiRYP17VdwSg/1DapxYt1UBxIpf4+cjKLu
 qofUOA0AG3fNLHEHhjvkiL5zNZyDH/Fb/TH3IGL+y9iwXPqtBHy2mZdzU62wwxgYH9F5
 /KoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QaFLLYDEWud99qoiUNGEueTX0iNK5/Ih2SGsu7QWWCw=;
 b=EIALe3JAbawL4C9641e7J4jOe7jlEiZaiaE4U+HeYlaaS0KY7zcBo4CFj5f71BFcBH
 1lKQnvlylD84pnUTOZ2f6+SzQICjBo80cVAfqO2qXQMKmvfOXc4ndUFjnhfd4kgIvoHW
 5YgdwVOSI97FeXtLuNE5vXWDu6Fbg/kgX3E02r6PoaKFGC1+2CA+wM+wVQZ05oSrCsRT
 +t1nwX8kt6aOo2n/1LnL350axajnc/NbREWNq6927xLiE6ToB+OVdsh12mjKbV1fPUPV
 ml+KWwC6GMAKozfSU5XBIae2i3tHyVdyCcsNVzWEH27dS0G77N+kHDohcFrCu65znPqF
 Gibw==
X-Gm-Message-State: APjAAAWwx8IKoWFLPLxN2nwOpC0KjCxSIED+idlr9O2Hm79xMdfHw9y8
 jmCYhnqpO8we8us3KAp6rATPpQmqMRyhcc9xyT4V/Ro8Y7Q=
X-Google-Smtp-Source: APXvYqz72DDSyAERPvL+ocn3L9YeI8+tIwMoLS3e1UmFlwTNWykfuwpTOSIgTobFrolcChoty2yns6EEPdLTEbkPqUQ=
X-Received: by 2002:aca:f5cc:: with SMTP id
 t195mr10156384oih.163.1576515434294; 
 Mon, 16 Dec 2019 08:57:14 -0800 (PST)
MIME-Version: 1.0
References: <20191212173320.11610-1-drjones@redhat.com>
 <20191212173320.11610-6-drjones@redhat.com>
 <CAFEAcA8=FcrT8dRMDzxu14J-gv5LEDuNBNpD5yo9j3waV7u8iw@mail.gmail.com>
 <20191216165249.lygksiptf2yowqh7@kamzik.brq.redhat.com>
In-Reply-To: <20191216165249.lygksiptf2yowqh7@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2019 16:57:02 +0000
Message-ID: <CAFEAcA-BND8-kxjaN2gRn48NLJ_BVxcguKPgAQ0qG3XaQ5ghRw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] target/arm/cpu: Add the kvm-no-adjvtime CPU
 property
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: bijan.mottahedeh@oracle.com, Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Heyi Guo <guoheyi@huawei.com>, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Dec 2019 at 16:53, Andrew Jones <drjones@redhat.com> wrote:
>
> On Mon, Dec 16, 2019 at 03:06:57PM +0000, Peter Maydell wrote:
> > This phrasing reads a bit confusingly to me. What I would usually expect
> > is that you get
> >   name-of-option              Description of what the option does.
> >
> > But here we have
> >   name-of-option              Long description of the default behaviour,
> >                               taking many lines and several sentences.
> >                               Brief note at the end that enabling this
> >                               feature gives the opposite effect.
> >
> > Especially since the default-behaviour description isn't prefaced
> > with "By default" or similar, it's quite easy to start reading the
> > text assuming it's defining what the option is going to do, only
> > to get to the end and realise that it's defining what the option
> > is *not* going to do...
>
> I'll take another stab at this, but my feeling is that a '-no-' option
> should be one that just turns off the default behavior, which is why I
> wrote a long description of the default behavior. If you'd prefer the
> description to be more terse, then I can certainly delete a bunch of
> the text, but then I fear what this option disables wouldn't be clear
> enough.

I'm happy with the length of it; it would definitely be helped a lot
just with phrasing that was clearer up front about that it was starting
by describing the default behaviour.

thanks
-- PMM

