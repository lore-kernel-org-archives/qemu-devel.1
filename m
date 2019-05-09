Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC14C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE1B21479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnXQ1FVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE1B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51802 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOg1G-0003Mx-4H
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 06:11:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hOg06-0002Wa-7B
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hOg04-0001yS-54
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:10:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hOg02-0001x9-8a
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:10:03 -0400
Received: by mail-wm1-x342.google.com with SMTP id b203so2500811wmb.4
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=LpLFWRsEmvLHrQ2C8yprFN6bz2WrQ1RseMH/tRzTlzA=;
	b=gnXQ1FVOxumYYARpsjAmrEKsID5LJxQyUF3qxMn4Pyh1CJqSZUWRimXLMEnR4kVjpP
	G/rbxhBgZPs+MRusPYxO9YnBG3gD3SIhcIrWr22h9PcKUDCOiPv/1nq7ioqgXU0fqEzM
	SiDB3h2OiElQ89R1szpqRIoI/hg/bC0U2+css6im4ZnJIK40o8DjbCD9/B58qB+H9+3u
	A3+QG+ttwgBtL10zCpOjovNAU8FpyE5BKjwiMKhI5OBbAvR6iFKDFoB9VUDu/hgOMyu9
	mPiXWk7gPPqe7Ji/4pW8kFbhUp56x290BrfKtI80Mbv+v7R0xdYx86tfupLqB6eSHT9b
	ptKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=LpLFWRsEmvLHrQ2C8yprFN6bz2WrQ1RseMH/tRzTlzA=;
	b=I6qVxJQ8k96GeMZIyv08vrI26m8uJmC6iZgGMCTYuJi7k0GSWA4Mo90aj99oNPkolF
	S8P4f6O6Ksi0I+Wtt+T374L3PcGIl3ziTKKztwljaVJqHc685PBPJ5g9oOF4yK6ChII8
	Ug0N9cilPW9SYQcduHw7LNcsn7aRpyg9dBw4W4liba1RvFJTbldG6hZ9WP5dFSvPWI9O
	Kf8OKn6XZa8NfOVPzW1HCiOR+0s+Uay0XsuhCP7kZ4rB4boBHNggP94/7uVbI6d4FU0b
	tTUfB8TL2f/l8TmthJdiBlQ5UKRQhX25hEkIMj3mLpDcxGwVOfCYFzDuoojEKOIc8YB2
	PayA==
X-Gm-Message-State: APjAAAUjsVE4dIAr4x7ggUiTljissD7HFaTRpnhEUmSDGyDLKH5R3gPV
	9DKK6KG9HSbgtNN2zdCmh2IaZ4mJJU1fr+Dd9ekdS6NJniY=
X-Google-Smtp-Source: APXvYqxAbpbFBCcqnCf5Du1z0E1DOtlrzyv8dEgwIZYmEgfq+qGbGHnJ0uE2iWgJ2UsqqfZkmQAITNzG6+uVHrTAY3Y=
X-Received: by 2002:a1c:5f42:: with SMTP id t63mr2112301wmb.94.1557396600353; 
	Thu, 09 May 2019 03:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190503130034.24916-1-marcandre.lureau@redhat.com>
	<20190503130034.24916-5-marcandre.lureau@redhat.com>
	<20190509063220.cfahgzlujtcv5etr@sirius.home.kraxel.org>
	<CAMxuvaw9kOt3yoRk4sWPeRyUmRLWboCCyrO00W0Se+W-OOrGRw@mail.gmail.com>
	<20190509092418.65ftbkyy4qzki7jk@sirius.home.kraxel.org>
	<CAJ+F1C+CLuoHUNA-hhsEQhYDd1pjJ5EKN8WpBdO-RxS70gCLXw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+CLuoHUNA-hhsEQhYDd1pjJ5EKN8WpBdO-RxS70gCLXw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 9 May 2019 12:09:48 +0200
Message-ID: <CAJ+F1C+-xL4tBAC+5h0KoEeqNbN-7z64=DJy40YT29W++-W4eg@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 4/6] Add vhost-user-input-pci
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
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, May 9, 2019 at 11:53 AM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Thu, May 9, 2019 at 11:25 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Thu, May 09, 2019 at 10:37:20AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > > Hi
> > >
> > > On Thu, May 9, 2019 at 8:32 AM Gerd Hoffmann <kraxel@redhat.com> wrot=
e:
> > > >
> > > >   Hi,
> > > >
> > > > > +static const VirtioPCIDeviceTypeInfo vhost_user_input_pci_info =
=3D {
> > > > > +    .base_name =3D TYPE_VHOST_USER_INPUT_PCI,
> > > > > +    .generic_name =3D "vhost-user-input-pci",
> > > > > +    .transitional_name =3D "vhost-user-input-pci-transitional",
> > > > > +    .non_transitional_name =3D "vhost-user-input-pci-non-transit=
ional",
> > > >
> > > > virtio-input is virtio 1.0 only, so we don't need these variants.
> > > > Incremental fix below, if you ack that I can squash it for the pull=
 req.
> > > > Or you send a v3 (in case you have other changes pending).
> > > >
> > > > cheers,
> > > >   Gerd
> > >
> > > ack, thanks
> >
> > Spoke too soon, patch failed tests.
> > New version (with some virtio-input-host fixes on top) pushed to:
> >
> >         https://git.kraxel.org/cgit/qemu/log/?h=3Dtesting/vhost-input
> >
> > Can you please verify?
>
> Looks good, tested successfully.
> thanks
>

nack, I tested wrongly, investigating some issue


--=20
Marc-Andr=C3=A9 Lureau

