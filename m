Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFF1C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 05:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17AE22173E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 05:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Se0LiN4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AE22173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnyfw-0000JM-9b
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 01:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57965)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel.stan@gmail.com>) id 1hnyfm-0008Cu-Cf
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 01:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1hnyfl-0000ey-B1
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 01:09:42 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:39809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1hnyfi-0000XM-Kx; Thu, 18 Jul 2019 01:09:39 -0400
Received: by mail-qk1-x744.google.com with SMTP id w190so19424686qkc.6;
 Wed, 17 Jul 2019 22:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Q9INugv/mrNV+sxANYdBEZEl1STGB828wsUqN4bmxkk=;
 b=Se0LiN4l+DvAOn3DDSrBbd06YiZJZNp3ggr4t1tricJqTzqOUMmPtFzTP9uNawhgCs
 n0QHD0Eb4+4Pt0ZUEi4j7eu1JUopG8JSK1BX5+B2u4Pm2Ajf3010IHHwSh1Z/PL2vuyZ
 ay1npOgWgUpLy76f/2LMrqyf+fsqGt7cVBCC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Q9INugv/mrNV+sxANYdBEZEl1STGB828wsUqN4bmxkk=;
 b=hnt9wWOxlcmcnzTHvFU5umbDgLa8UO2bD85L/i4/vc1hizaqD376J24Z4lv7YcIkI2
 8rObr4PfJ8es61AiF0awd7bYjfqJ3EqEKpRww8VyZTM5itox1ZUnd/A4zMAMMVEQxfDN
 Rmj2xx24iNcIl+Q/0s4u8AOViMh7Jtla1gt4TpjMUcThmOEnBYG2gRVsWefpXbapeA7k
 TKrT+nXkzWpXgDFB2ywCm8D2AIIeTaRCR1Ld/1llXV0+Kus03urNQuqVPSkUPIaYTtAL
 Afl2jkO5Qwr0T38u2aK5AMQA5e64PLBTWfgNn3xW1XpyST32itHWtGkUboDNke9Atp+o
 wSsg==
X-Gm-Message-State: APjAAAVZyVCXjFchshwSh/9Jqap7pztwtz9K9KzKusp8pMdBssTVIdGO
 DVkAIeLxnO8LRVOEBGqum9/j/bbNKcFSGjzNRRllPg==
X-Google-Smtp-Source: APXvYqys/fDmjvcS4A/Z12MwWGpxAtgzvnfzLbewDvpUZZun0QT50Tz3iA5yeSu+vft28EfzEyrgh0g5LKjjtbq6jM8=
X-Received: by 2002:a37:a2d1:: with SMTP id
 l200mr29422410qke.330.1563426575762; 
 Wed, 17 Jul 2019 22:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190716045633.15319-1-joel@jms.id.au>
 <6e98fffb-2642-3835-d3ba-f06b73ca2fdc@kaod.org>
 <20190716085236.GH7525@umbus.fritz.box>
In-Reply-To: <20190716085236.GH7525@umbus.fritz.box>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 18 Jul 2019 05:09:23 +0000
Message-ID: <CACPK8XfTv2z=3UGHyS=AdtXfeBjZkS6UkUZhyXO-Q9YNq==FuA@mail.gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Warn when using -initrd and low
 ram
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jul 2019 at 08:53, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
>
> On Tue, Jul 16, 2019 at 09:39:36AM +0200, C=C3=A9dric Le Goater wrote:
> > > Provide a helpful message for users so they don't go reporting bugs t=
o
> > > kernel developers.
> > >
> > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > ---
> > > We could solve this in other ways, such as warn when loading the init=
rd
> > > outside of RAM, or load it within the known boundaries or RAM, but af=
ter
> > > hitting this myself I wanted to start the discussion.
> >
> > We should also increase :
> >
> >     mc->default_ram_size =3D 1 * GiB;
> >
> > to 2 or 4 GiB. I always use 4.
>
> It seems to be increasing the default addresses the real problem in
> practice.  Putting in a warning but still letting you do it, rather
> than relocating where we load the image based on the ram size seems
> kind of roundabout.

I agree. I'll send a patch to do that.

> > at the beginning of this routine we have :
> >
> >     /* allocate RAM */
> >     if (machine->ram_size < (1 * GiB)) {
> >         warn_report("skiboot may not work with < 1GB of RAM");
> >     }
> >
> > and we should exit instead.

Yeah, perhaps. If someone is playing with some other bit of firmware
code then there's no reason not to continue. I'll leave this one alone
for now.

Cheers,

Joel

