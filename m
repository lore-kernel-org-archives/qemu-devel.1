Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC1EC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 09:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79374206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 09:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtBiEIST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79374206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irf68-0002Yw-Jc
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 04:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1irf5M-000294-TX
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1irf5L-0000NT-HY
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:35:36 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:39581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1irf5L-0000Kc-9R
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:35:35 -0500
Received: by mail-wm1-x334.google.com with SMTP id 20so16975644wmj.4
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 01:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QTOIOD27spB/Mejjn4IYFNa5UMucYxQ7/OFspeE5uVM=;
 b=EtBiEISTskaM/IG2ECOxsmY0Poi68zCxpQbpIfvaWCaXihg50fZqXaPiZT3iH0YnQi
 H3EdrPbhMOr4LeOoMOYyzcz2GX3PPV66UbB0Ere+B9gtLQy4CIHxHa/TcV6tyMn8GN7V
 J6z9+f8xJy38+J+fPA0/hFfOCNzOJvWyCwmQAIzp44/aoMdfwd0ggv7FnBz4s/jfn+mS
 88tJ6hTycQ2Lw1UXgWgRoSxd+cZPgELRf0K4x7FvKgAWoCu7pUNkANQx8+oJD8CgRHsj
 0FGpnpxVsrAxF00EgQ4LLEuIqvUJnX7iOC4ELEnyaTa1k22XwWH1qeoFCHVfqneKFsXq
 Jbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QTOIOD27spB/Mejjn4IYFNa5UMucYxQ7/OFspeE5uVM=;
 b=YTt24kNYISapk/UPgH8rMg0XIj1wiCrB/j8ptgYrChTz0eTp/2nKk3tJiwbQXkxXT7
 AcPteshk5sf8zen+Onq4Yroy2NuZSNIyCGBBw8/vXf1Tw8fBEvQodezgXttmzUN7ZGuE
 Sojm0iwrHmPncRflhSAsBrZ4VTse1W62NGCyq/TZRNYi3bT0CLFB4Yl6mTV//MRcV8Dt
 PsTVRxaYdlyyQjtIzdjK1LHhfE98lvYoYkVGnAjJ4mu9bgEXRVTEXs1oQgCXsV5Djjsf
 b1loyPGFSBejszq7/VyycZma6ki01E+SgCefApMUCvrWSRjHWhS8sJ4WpLLMRRs1YBp4
 Zn1g==
X-Gm-Message-State: APjAAAWDIuJMUTLLAmaWNeANZdtWbfPAj5eabgE7YsL1ijKUAHgwcHyi
 SLQk0ASaj//jF3mEaidCUneEXYgfg/Cut2DUZTdp6Ag93b8=
X-Google-Smtp-Source: APXvYqyLK8l5KhkaXgpyq+b1d1xYH4RQ9RNVmemxVZtJy7kHGH7M9lb0MAEss9FFnLojWJwGidTEVT4YWQtYR9mFTZk=
X-Received: by 2002:a1c:9a84:: with SMTP id
 c126mr33816504wme.111.1579080934084; 
 Wed, 15 Jan 2020 01:35:34 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <1EFEF446-AFEA-429F-B6BA-3206A7C41836@redhat.com>
 <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
In-Reply-To: <87o8v52hz9.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 Jan 2020 13:35:21 +0400
Message-ID: <CAJ+F1C+ayOH=86zuaeXnZ=vqVw77ahK0KHGZOvbYSijwKh6WjQ@mail.gmail.com>
Subject: Re: Making QEMU easier for management tools and applications
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Jan 15, 2020 at 1:21 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Christophe de Dinechin <dinechin@redhat.com> writes:
>
> >> To make this worthwhile, we'd have to replace dynamic QOM properties b=
y
> >> static ones when possible.  Monumental task.
> >
> > I=E2=80=99m sure you are right, but it=E2=80=99s hard for me to evaluat=
e, given how
> > many ways there are to access an object. Naively, grepping for
> > set_prop and for new_with_prop does not give me that many hits.
>
> Look for object_property_add*().  Some 450 hits.

fwiw, I have started tackling that.

Easy first step is to move all QDev properties to class properties,
and this is done in :
https://patchew.org/QEMU/20200110153039.1379601-1-marcandre.lureau@redhat.c=
om/

Moving from instance to class properties is straightforward many times
(when the property is unconditonally added in instance init for
example). There are a few complicated cases though.

To me, the most problematic is reviewer-time and willingness to do
such low-benefits changes.

> Basing the QAPI language on JSON was a poor choice.  Not sure that's
> fixable at a reasonable cost.

Translating it to another language should be relatively easy, but to what?

--=20
Marc-Andr=C3=A9 Lureau

