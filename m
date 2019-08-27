Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FC6C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0595B2184D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQRvZ4+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0595B2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2daM-0003xM-0j
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2dX4-0000f9-Fk
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2dX3-0006d9-0P
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:37:18 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46317)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2dX2-0006cm-Px
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:37:16 -0400
Received: by mail-oi1-x242.google.com with SMTP id t24so15259635oij.13
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=t5I3HKsguqHeB727TvHpayH/w/G2mmJD9HCQWuDpFC0=;
 b=cQRvZ4+ElY5CWnkv4GxSJqqTeKSnzToVRc6Ez414WNgQsfrYnqu7GgpxKJEcdd7PMJ
 JZSJ6Z5HVY9CGoNjXU6sd/uCvOAcDIM/jw65poN98s3+OZsPnu1499aHryP9+rnIkVJh
 NyY+LqgImCSJRtdvz6l9Mc7h+0sYA70XF/do1Wz7pFmpr6jBezXJyoo2poSA3O/jZYUb
 sQMhOVvTgfl1ZhSGJvFo3NXKe89vBp+TkPC66tn5MdtujLGy/ulFaHEzGugCfhQX3ni7
 U4tGZqvkoKRTp7SKchGvQXrVfeOs5uu4tuDFK0BPcpTKu9lhvMrjH3/HvVc7F7OEiPVg
 wN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=t5I3HKsguqHeB727TvHpayH/w/G2mmJD9HCQWuDpFC0=;
 b=FKdW1rno2dMSE6E/Qk4cYVTDqgi/kL0HVdbAQu9ZYwBqTiOEPYEcn0K9FZCMC6OulT
 nPd+ngogUWRFcNtzx+EyOAuipcl7s6c91dD4oFBNLOlvuM7vFwa2TKhiLf11QQawm7IO
 wFWxFSxoHwve4hZybyDxJj+r/NMIPj1Kv1PTt6714kh0Zf3D5MvwxZB0q5ytaH9CZ1+C
 xSv6Xau1JlzxJXhEwikSdFRkwZtIASgn2J/CpRpQe+a+YTWDaSL2eI+AYvF94hu5M+te
 YJA9l2CMEAByosHzRbF7MFNeuc6jwVfQHBhlkedopdSkBwxDCRpQWA2DI6bSiMBNecrD
 YbUQ==
X-Gm-Message-State: APjAAAUvm1T+jmB7o5t9AJP7dhccfgA64JKc79wSmT/MBtRneyR/gjgJ
 5cu3Exn+GsyKV/8/zTHWP3MyVQJxw3d3i/shkJxwMw==
X-Google-Smtp-Source: APXvYqyZH/h9akaN8che0lajVeoWjeRlK6CWKCx8L7FNL3d1y+DS+w6Ky7ahxH5rVUcWwWTAcQhqd3y2DuBSFOQct0U=
X-Received: by 2002:aca:4814:: with SMTP id v20mr16737854oia.98.1566920235745; 
 Tue, 27 Aug 2019 08:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190704055150.4899-1-clg@kaod.org>
 <cd1f8a48-27cb-5cc5-1fd2-46f1597a7094@redhat.com>
 <20190704101345.GC1609@stefanha-x1.localdomain>
 <b304e4bd-1315-b1be-6c48-add99df92626@redhat.com>
 <CACPK8XdFUO6+Fx17Dry0D2QFhM885DugdvOkWnhgjxPc9VgG2Q@mail.gmail.com>
 <CACPK8XfZq1FvMBXLgS-WHoJy4s_L9k19hLW-XgBNoiY-DhGhWA@mail.gmail.com>
 <f5ed785c-027d-66fe-aba2-d03001b44162@redhat.com>
 <CACPK8XcG4JRq0hAUPu4+vv-j1TFNwwsu5iv6X9M-qAgm0atTRA@mail.gmail.com>
In-Reply-To: <CACPK8XcG4JRq0hAUPu4+vv-j1TFNwwsu5iv6X9M-qAgm0atTRA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 16:37:04 +0100
Message-ID: <CAFEAcA_zt-=BKZa3CnnP0XNjurxwd1svsda5LnsJ+YsKHdRL_Q@mail.gmail.com>
To: Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH for 4.1] aspeed/timer: Provide
 back-pressure information for short periods
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
Cc: Andrew Jeffery <andrew@aj.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Aug 2019 at 04:16, Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 16 Jul 2019 at 07:02, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
> > On 7/16/19 9:00 AM, Joel Stanley wrote:
> > > On Tue, 16 Jul 2019 at 06:54, Joel Stanley <joel@jms.id.au> wrote:
> > >> On Thu, 4 Jul 2019 at 12:26, Paolo Bonzini <pbonzini@redhat.com> wro=
te:
> > >>> On 04/07/19 12:13, Stefan Hajnoczi wrote:
> > >>>> On Thu, Jul 04, 2019 at 11:26:53AM +0200, Philippe Mathieu-Daud=C3=
=A9 wrote:
> > >>>>> CC'ing Stefan & Paolo for a non-ARM view on this...
> > >>>>
> > >>>> I'm not familiar with the various clock smoothing techniques imple=
mented
> > >>>> in QEMU and KVM, but this looks okay given that Linux guests expec=
t
> > >>>> this.
> > >>>
> > >>> Yeah, even KVM applies a minimum period of 200us to the x86 LAPIC t=
imer.
> > >>
> > >> Can we please merge this so guests can boot on 4.1?
> > >
> > > C=C3=A9dric pointed out this lacks my reviewed by. I had not provided=
 it in
> > > the past as I wondered if we could come up with a better fix. However=
,
> > > I consider this a good fix for 4.1, and if sometime finds time to
> > > further rework the timer model in the future then we can do that work
> > > later.
> >
> > Agreed.
> >
> > >
> > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > > Tested-by: Joel Stanley <joel@jms.id.au>
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> HI Peter,
>
> Is this one still in your queue?



Applied to target-arm.next, thanks.

-- PMM

