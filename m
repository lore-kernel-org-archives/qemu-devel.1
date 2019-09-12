Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC735C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B9B20693
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtCXs/X6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B9B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8O8q-0000nv-QL
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i8O7r-0008Ku-Gs
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i8O7q-0006fm-Bo
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:23:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i8O7q-0006fa-5d
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:23:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id o184so7413065wme.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ar7x6SFGQRQOR70FgKLuAyVO3vdv6LH0teTnF9ULC2o=;
 b=DtCXs/X6rpWIHuLsLrDlhJIv7wphO65w4fre1h4KaZdWqRyzveXGMi59pPGmrbinfB
 iarXtgyZQZomm/BmopB/JCJS+rSo41wo3LCsYsTVFcRGBDmG2jq3ZtW4NczsTuNvNHBv
 F25u2v9d85irgG8JTK+0zIO9jIuk9n2dKIUD5x69rOWaSVNWDRa+BmlOLyyyLFWvT6JO
 DkP/05Hau5e56/eW0RcsTazbkBH1kvC29jH+sv2HXzoWLUIDbfU2lfVLiWjTU3zuv77W
 gu7UuJJA4tmrjYDClUr8E8cg5p2Jw4y9RXGSvUleT6HJuWzGag9Pp+qfQyOceDyi5qGa
 Ya/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ar7x6SFGQRQOR70FgKLuAyVO3vdv6LH0teTnF9ULC2o=;
 b=J7g5Y4mrsa03SzdO5BTDUeCR90iNQhVrKZHH5z/2Zco1Z3+qrSNHTEero7J7AwNs/b
 /w/70yiNluUnH+Q6522ydY2jajRgQKEZnNsEvJklCSrM1w9Ri75H84TJ87T1X/89OlLK
 lgU18BC9QtHU0PxopzqOfzV2xbWuBsNSur6KOY/NI1Z2jjOLMGDUYK042VX5OsIa/Dyx
 tf8ls2BQnUuWKkZDMdWDwVBXSxnuJTCe0E5YlNmQzF4Gh4n7lvV6vkobncbngCGxhSKb
 KsEH77Ax0qgP+j9BgUgHDYi0F5ri6NFcUUar29Rxmd3NNzXJcYLJUlT1btxsFQobLkcZ
 P7sQ==
X-Gm-Message-State: APjAAAWs8JWVG7d857fp81SaFSfL2jZBaifAUaM9Q/D/v2fY6a/ao411
 gVEhquB3Qvf5X0aj3y1lst0=
X-Google-Smtp-Source: APXvYqyg7nt9dzO3E/yEUaqE4feWbJLYQX9iN3UlTRqfzrtsMmemXOBmMZe1giLaDdgBGLRfQ2+7GQ==
X-Received: by 2002:a7b:c766:: with SMTP id x6mr8877373wmk.51.1568290980940;
 Thu, 12 Sep 2019 05:23:00 -0700 (PDT)
Received: from localhost (178.165.130.7.wireless.dyn.drei.com. [178.165.130.7])
 by smtp.gmail.com with ESMTPSA id r18sm8799272wme.48.2019.09.12.05.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 05:23:00 -0700 (PDT)
Date: Thu, 12 Sep 2019 14:22:53 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190912122253.GH23174@stefanha-x1.localdomain>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190902121233.13382-2-johannes@sipsolutions.net>
 <CAJSP0QXhOQg98FyLzcTnruG7B=b+uUqEd5HvevRKmuP3HhCSmw@mail.gmail.com>
 <45d6dc06b9973aa231f1076a0de279fd5292d2d3.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZYOWEO2dMm2Af3e3"
Content-Disposition: inline
In-Reply-To: <45d6dc06b9973aa231f1076a0de279fd5292d2d3.camel@sipsolutions.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: Re: [Qemu-devel] [RFC] docs: vhost-user: add in-band kick/call
 messages
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZYOWEO2dMm2Af3e3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2019 at 05:36:32PM +0200, Johannes Berg wrote:
> On Wed, 2019-09-11 at 17:31 +0200, Stefan Hajnoczi wrote:
>=20
> > > +``VHOST_USER_VQ_CALL``
> >=20
> > "call" should be "kick".  "kick" is the driver->device request
> > submission notification and "call" is the device->driver request
> > completion notification.
>=20
> Ahrg, yes. I confuse this all the time, sorry, will fix.
>=20
> Btw, speaking of confusion ... this document may need some cleanup wrt.
> the "client" language since it states that both sides might be a socket
> server or client, but then goes on to talk about the "client" as though
> it was equivalent to "slave", where normally it's actually the other way
> around (the device is the one listening on the socket, i.e. it's the
> server). This is most pronounced in the section "Starting and stopping
> rings".
>=20
> IMHO, it'd be good to talk more about "device" and "host" instead of
> "slave" and "master" too since that's clearer, and just replace *all*
> that language accordingly, but YMMV.

The vhost-user spec is unclear and inconsistent.  Patches are welcome.
A footnote describing the old terminology would be necessary so that
existing documentation, code, etc can still be decyphered when the spec
changes the terminology :).

--ZYOWEO2dMm2Af3e3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl16OJ0ACgkQnKSrs4Gr
c8gVPggArBxlHLziVMuVLl2TU1OimyoJN0saalpECgWLoxvag0vFYRe/gERnTqVJ
0Kd099cNXCO6fyMTU4ADEzdULgSUYf66Z5+56/2iZx48vjN+HBmyC9Q/OsB5SvTc
prJr9yQkrl52Ux+1ALm+ijWyVBobu0T0lcTW8u818NG0+dhaYl/sGcrifradCbRs
Ag7E7G74JG/sGerUJGJ4KSiYyMx1FBou+GS9fLU9uGeIh5UOTh9SMOfzJhnoHU16
X+L4bq/FXluNikEA8ISlEQrky1Iidr2pdP0wu0LZQRJkWP6h6jz2lRIRUrjEv1ll
47ox8Q6M3qkFYqLodt8FtPbFzyHesw==
=PWdj
-----END PGP SIGNATURE-----

--ZYOWEO2dMm2Af3e3--

