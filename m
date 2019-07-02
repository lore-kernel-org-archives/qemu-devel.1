Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E109BC06511
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B324E21479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdCJd5ES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B324E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiHXK-0003C8-0A
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 08:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36650)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiHMd-0002w9-SU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiHMb-0002Q4-Ap
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:54:23 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:45231)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiHMb-0002Kp-45
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:54:21 -0400
Received: by mail-oi1-x22e.google.com with SMTP id m206so12777264oib.12
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 04:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FYrbNyHwCfkSAifOR2HL1lK/0hxDKe4BjbvklG+FyGw=;
 b=QdCJd5ESWkyzHgxbmMXGYiha2s4JqvmV/CvVzY/GJaqah8KjjNzis2Bi0+r+MI9DeS
 2mQW9qeOBQDwda14oHPkC4tl2aNI5fJFnIeIU//RnKxfGSsZ1u/jYZ9WvFPnXrQ7FQfD
 bjekcL1Z2upNMTW7qH6A0pSIimcp71Qq3+v3rikNMzwWTGMhoECacE7eHfOfpGViyOLH
 w8pvS5NYfY6WnXncB5ZGhEl3EnJp6fvI7P2gYNXrkKOG2GqVtSvzDjkpJ+IjSQ/VyKbl
 oRp7EdykOy+OerGC2sdmHmXqwVD3xdav1ULixQiba5V9r3Dg865OUjrv18aXKpR6jRmJ
 ofdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FYrbNyHwCfkSAifOR2HL1lK/0hxDKe4BjbvklG+FyGw=;
 b=ITckZzSYfXmdmSD8klxTIkTTyZXE8LPsSDuy/NsooygT50mATjGAqrb9uvsK/XfVfp
 rAqvwLrMSnNbnDW/kDZDdCtcSUZ03ypXc4LTc3cYEUHj14bIGC69YWwIuSy3GINTvtr3
 avcrooj53HeZZTeYX/8Le67jW8bQ0nh/cpZId8Eng5oUhuYBmj0z9TpLMBuXCdn75bkb
 N/upnZo6mNeD0hlysAqcFTF6rwcDxrf4TKkTBr11mNnOqIDFrbW5r1ZLhFJqbiBc4lEG
 Dk0xEUkYMofgbFxAGloR+esrm2f8aRENjRgmbo+GoFix/uRDDEaNgHuIUxem+gnDgAV/
 3F4A==
X-Gm-Message-State: APjAAAXTW0ewAQWB9Ep0H4ryKTLUhzovurh+M1BHbLSahSXXqH+INe78
 Gi1P9ak1BzPeKjfJMjvfsfYByHVyJd3shzlOZGCKZg==
X-Google-Smtp-Source: APXvYqyac8zdXreaTGpu1GlZNGZ1MH85mICZ1bGJwLpb6kHpy6anxSlr6T3hDP3rdYnVS9McEMpKC80s8jmxJql7Zcw=
X-Received: by 2002:aca:6185:: with SMTP id v127mr2832329oib.163.1562068458880; 
 Tue, 02 Jul 2019 04:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>
 <1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>
 <5cf7b6e6.1c69fb81.1cdca.e260SMTPIN_ADDED_BROKEN@mx.google.com>
 <ec5033a4-5c68-91b7-ca9e-a1f38c990221@redhat.com>
 <67806828-f666-0c9c-00fc-b520f15013d9@suse.de>
 <e4fe4dc0-f3c4-a051-d39d-afd7bfdc680d@redhat.com>
 <98826c5f-4a74-5364-2aef-28a10db12c20@suse.de>
 <39250506-f38f-c440-5728-7b970d32ab41@redhat.com>
 <79b821a4-7cc0-2461-7ca4-d71c3e5ee4ef@suse.de>
 <c49abf01-c209-b206-edee-507c31269011@redhat.com>
 <87o934sdot.fsf@dusky.pond.sub.org>
 <8d391b41-bf6d-b83b-7b22-25fefa18c518@redhat.com>
 <87ftogp7f5.fsf@dusky.pond.sub.org>
 <4ed45e59-6d7d-a9ea-9af3-7ec336c7ec3d@redhat.com>
 <5d1b4524.1c69fb81.ddba5.77bdSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5d1b4524.1c69fb81.ddba5.77bdSMTPIN_ADDED_BROKEN@mx.google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 12:54:08 +0100
Message-ID: <CAFEAcA_Ut=xG7bN-LL-AN1bhWa2GK6cH9jb_vXnROF0LS11Gdw@mail.gmail.com>
To: Natalia Fursova <Natalia.Fursova@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Subject: Re: [Qemu-devel] qgraph
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?0J/QsNGI0LA=?= <Pavel.Dovgaluk@ispras.ru>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 12:51, Natalia Fursova <Natalia.Fursova@ispras.ru> wr=
ote:
>
> Hi there again!
> Thank you for your answers, I have new question.
>
> I want to identify PCI devices (e.g. network cards) and observed one stra=
nge thing. I use qmp command "qom-list-type" and build tree from it output.=
 Some items don't have parent and don't give information about themselves. =
E. g. "e1000-base". It has three children and it belongs to PCI devices, bu=
t I can't know it, cuz command "qom-list-properties" returns empty message.
>
> There is no information about "e1000-base" in "qom-list-type" output. It =
is referenced only as a parent for network cards.
> Is it ok? Maybe is there other way for get information about all PCI devi=
ces?

e1000-base is an abstract base class for the e1000, e1000-82544pc and
e1000-82545em devices, which are the ones users can actually create and
use. It's an internal implementation detail, so you don't need to care
about it.

thanks
-- PMM

