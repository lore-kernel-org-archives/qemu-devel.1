Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1ACC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 12:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75CEB2081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 12:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8d6mS+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CEB2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40377 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMXls-0004AV-RI
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 08:58:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMXl9-0003rY-03
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMXl8-0006L2-1g
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:57:50 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMXl6-0006IL-6O
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:57:48 -0400
Received: by mail-oi1-x241.google.com with SMTP id 143so4328257oii.4
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 05:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=/NuIaw3/6wEYTL0WMlR4+PVue2uKvKjbnKw9i6nXeGM=;
	b=Z8d6mS+wq5MtzJkxDapyEd7nryJLhmf/yz+8eLHlRajiQrVJUSpP4N/Q75GmZkGTed
	8y2uTYEZmLfX+9AQA4KVJYfX2HpETambrp957A0Ta224kohmNdVLfZH7f4B3hYf2nDR/
	TGC+ft9rM/JWr4GHr0DLeH/4begrV6o3ZQQ98QTvzbO8AE+b3jsiLmVWaxClYYGaEMVo
	E+MVtJdUw68Q794Jq8h7SXJaiwhXrigGsVwYeXgMzm2qwaDKqaNAgDcjvbNUusqGrlwo
	Vl6aEeI4idOmQZnUZjx4tVYfvLQeOtCFdlefJ5fZ3iuN1wAjRkHH6n+CjYNE3T3gZHAk
	731g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=/NuIaw3/6wEYTL0WMlR4+PVue2uKvKjbnKw9i6nXeGM=;
	b=VYkcX3vaIRrWNM03ZDtW2GNB5UPtolCuEBRE5/Qohv8HUKpTOSWk1x0+tnUABlqOUR
	GoptazeDIPO84Fr2YLIYS2l8tZZMU4WrSgWfFrIEiqjfMxyltnYA2uo6uNN8LCV5hJId
	wFq7+49zPuVNrNeY44TUK3O1MlXTbTxJKFkELJEtTvTX+6izIgHAB18ZTpgod8QmogHb
	Q8ml51D6G4/If3ThJLHhvtdTsoMqwWxs6MuV7uhnoq5LPQl/DbGr8XONYLcj23LIp0wB
	4THMLJqfs6D50dZ9bAX8F2wdSsDcC5YPCHBcmpYu/kmtyrz9B2kblUNFbEa1LC792Hxe
	Pw9A==
X-Gm-Message-State: APjAAAUQTQ3JIGIj1nfgEfzjvRdZu7VfFhvi0D/2MB7NLStQdvI2WOlG
	G6okwfjhPC5QKhI8GDAcg9xB6Wr5b8QIqqlo2mZ5CCEyZlA=
X-Google-Smtp-Source: APXvYqwSwbhGChyfsU5JtYDxZNw/h9YoKK+zf5F3+N+PxXG0q1CCEM58RueLhSHxFdNTJHiwoVqtOONbYhlDb/baHUQ=
X-Received: by 2002:aca:ed17:: with SMTP id l23mr5630465oih.146.1556888267567; 
	Fri, 03 May 2019 05:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190425145420.8888-1-stefanha@redhat.com>
	<20190501162055.GB21155@stefanha-x1.localdomain>
	<CAFEAcA8Go-8Ux9AGzw5CGiU3wDyAQSrV1HOb0gbZP8+b06-EPQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8Go-8Ux9AGzw5CGiU3wDyAQSrV1HOb0gbZP8+b06-EPQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 13:57:36 +0100
Message-ID:
 <CAFEAcA--Gn=7aAH1i28sr7ifk23vprw24rqO7TTs=8D7hKG95g@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2] gitmodules: use qemu.org git mirrors
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503125736.Ll3CW6uvRNryOpIp2Y8WBbI-Dl1enUqSHV1IKoQZsG8@z>

On Thu, 2 May 2019 at 11:11, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Wed, 1 May 2019 at 17:20, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Thu, Apr 25, 2019 at 03:54:20PM +0100, Stefan Hajnoczi wrote:
> > > qemu.org hosts git repository mirrors of all submodules.  Update
> > > .gitmodules to use the mirrors and not the upstream repositories.
> > >
> > > Mirroring upstream repositories ensures that QEMU continues to build
> > > even when upstream repositories are deleted or temporarily offline.
> > >
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > ---
> > >  .gitmodules | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > Ping?

> This won't apply because currently master's .gitmodules
> has no [submodule "slirp"] entry. I was assuming you'd
> ping or repost once the slirp changes went in.

The slirp changes are now in master, so I've applied this.

thanks
-- PMM

