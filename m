Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E2FFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921DC2082C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="RvcSop3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921DC2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKhaM-0005ZH-Kt
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 07:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iKhU2-0000u3-RG
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iKhU1-0005Nl-O9
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:28:50 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:43385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>) id 1iKhU1-0005Nc-KW
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:28:49 -0400
Received: by mail-qk1-x742.google.com with SMTP id h126so22347109qke.10
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 04:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xaRforC0EXfncRqtNGSugj/EAA2jG96cbud4zhgbw2w=;
 b=RvcSop3qMTdIJSKWO7MMN/pO+nOOXUmS793WgQwmHhlmSJEUQfgad5pBm4DEyafkmp
 UziPqtIdeRx3nIDFhvAL50u5zzGZYdCc+vgTAciPLBTeKY0nN35r7f3xoMQaD6WB0q5e
 AE/0Gi0fxHFW0cWStkUHGVboFCrKMTmE6b8qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xaRforC0EXfncRqtNGSugj/EAA2jG96cbud4zhgbw2w=;
 b=HPNEfiLoNmDPYKsJ86KytE8Hl9hTJZX41ZJMM8o05xpq20hdWkwmdzTwAxsk5sqiif
 ytHjhnWTOlnngclUaK0RrgM9qTys0cWzB7jkUj1dG8xsILhNDQAuTdUAlkYz1OcYQ6dX
 ikmn3EG1QvdHGzUCqUJ1CtZPhx1u6kEOrC4ct9pp/2pk7/Ds9F4AJJioRha/cObab8H3
 bs5/oa823CT+1LB1WS6A7ue2v/BSnyO24Odr0TFsr1PKqKmHWK9ZTjn0GpTHteBFA+R2
 1Ajzg+InWx47yBsfx5ZwnD48LgWDIfQocyH9ezdDMNpnXGYrATkj0k3JzKf96Gu75w3E
 9S3g==
X-Gm-Message-State: APjAAAUnCa/C4kyAMp03gEMM2wbZcdxaa1R0KJAkCs9pL/5LkFzAZmgh
 eufIciXBLY+PYpKriHp3u3j5tCWByRG8Wxe1s9nuupEAiqE=
X-Google-Smtp-Source: APXvYqym3jJmV/Ywh2PNFaEOdfHmmq9XwvrjEOfoJm5f6dpVITby2YN/tzkXEIGamOrdTR7LsR3xvZ1pYyv2xWKCw7g=
X-Received: by 2002:a37:4dca:: with SMTP id
 a193mr40179208qkb.292.1571225327304; 
 Wed, 16 Oct 2019 04:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191014160404.19553-1-peter.maydell@linaro.org>
 <20191014160404.19553-60-peter.maydell@linaro.org>
 <CAFEAcA-2EZnnrYViQUQK-mR0=JqR9mXNzfVNa_WR5HoCTJ+tag@mail.gmail.com>
 <a888142d-7c9e-bc15-84d3-80bd01df1d11@kaod.org>
 <CAFEAcA9uFL8JVwrcWMP63tZcFK7nWSZZnaUHj0ZC1Qh0BdKijg@mail.gmail.com>
In-Reply-To: <CAFEAcA9uFL8JVwrcWMP63tZcFK7nWSZZnaUHj0ZC1Qh0BdKijg@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 16 Oct 2019 11:28:35 +0000
Message-ID: <CACPK8XdtaoFmVd1Lu7dj0KKBkeAt8AxbvuykZWpOgSWwp6iuxg@mail.gmail.com>
Subject: Re: [PULL 59/68] aspeed: Add an AST2600 eval board
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Oct 2019 at 17:55, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Tue, 15 Oct 2019 at 18:43, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> > On 15/10/2019 19:03, Peter Maydell wrote:
> > > On Mon, 14 Oct 2019 at 17:05, Peter Maydell <peter.maydell@linaro.org=
> wrote:
> > > (armhf)pmaydell@mustang-maydell:~/qemu$
> > > ./build/all-a32/arm-softmmu/qemu-system-arm -M ast2600-evb
> > > qemu-system-arm: at most 2047 MB RAM can be simulated
> > >
> > > It's also a pretty rudely large amount of RAM to allocate
> > > by default: it caused 'make check' to fail on my OSX
> > > box, which is 64-bits but doesn't have huge swathes
> > > of free RAM.
> > >
> > > I'm going to drop this patch from my queue and redo
> > > the pullreq.
> >
> > ok. We do have such a board.
> >
> > What do you suggest ? We can lower the RAM to 1G for QEMU.
>
> 1GB is OK -- we have several machines that set default_ram_size to that.
>
> If we want to handle more generally boards which have a
> larger ram size by default then we probably need to
> work on the 'make check' infrastructure -- right now we
> have a generic test that just checks "can we instantiate
> every machine model", which is what's falling over.

I hit this when bumping the RAM size for the powernv machine too. In
that case it was a convenient size given the memory layout we have, so
changing to be less than 2GB was not making the model less accurate.

For the ast2600evb machine, the board actually has 2GB of RAM, and
it's useful for guests to test in this environment. I'd not had any
reports of it failing to launch due to a failed memory allocation,
which I guess is indicative of the systems people who use the model
have.

Peter, did you have any thoughts on how to exclude such guests from
testing in environments where memory is limited?

Cheers,

Joel

