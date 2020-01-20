Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2FAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851232073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPU9z5i4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851232073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itU8C-0005hY-AD
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1itU6Y-0004PE-Ot
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:16:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1itU6X-0005Si-4r
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:16:22 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45854)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1itU6W-0005Qx-Tx
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:16:21 -0500
Received: by mail-wr1-x441.google.com with SMTP id j42so28842017wrj.12
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 02:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0dDo7KjfEl7MVx6H05pJJDvNiqm4o+InpLbev2A/hAc=;
 b=VPU9z5i40/NOR7ea5siEMlbzeADp6X8a9V/rwvDpgNbey7DPoTmAU/LNsP1ZG2cZmC
 ym1SrKPIFbIiE2E8zLkzdopW9JWBwhNEm8wy5zXPe99gD70LiNm67826onQqP5MApXY1
 xxwYOIwbQGvZWLYjGQ3L5/PeUf079SbfwdidDwx5Ur4wfyByUiUZC/LFlKzxLU8kBF+g
 xdVMo1pZSHiorAX+aZq+HMT5itft96IAVb9aiUN6G8TjASE7+3kLetWQFWcWX5FSEuXB
 UvtL/WGzsVanTOH8xY4xnnWnetr2+NsFGTGAWSh7gXbvrguGX+T52lftx+fpQRLn/hsw
 BZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0dDo7KjfEl7MVx6H05pJJDvNiqm4o+InpLbev2A/hAc=;
 b=Asf+NJcaiKqnthqhNUt4rYdTpqJ5PahIZG9l4rfEu2QvvK5oHEhBvGcOSXSj840uXF
 SnB5erQVfagydA5MJFIyinDM2P/nXuG2bBp1XHzKSQfk0YhbCSv4OQT9zwy3f1NCFfR4
 zZdcoz3a/VBd72k5iqT31bdejqNzRdH7CVyxNekFnfscQROY3T05HWuIqc+s1URfB9dS
 0MCfbMZAGtdtPjLYTsmpcBFsujPZyAaQgvjeKq8hosbCy/QjPcI2aR7CQsEb1q44iGIO
 NXockjc5f866vo8YpKnIKRM58TO5oJTHm1KLHopQJ0P3jOI4aMubd946xjWAYunx+Z0y
 jufw==
X-Gm-Message-State: APjAAAXKdUvTkHcFLywiEWWFAfxexJMscnIqing57C8WZhT1sVsYHmnM
 1ojkvKafhyOM29aGDehGFms=
X-Google-Smtp-Source: APXvYqxfpfVOer4sb3bwHSj4OxFmenhzNVRTz9+BWwKCXyN3Vor1PA5GoZihW5A4GmHDaVaPBRvDSg==
X-Received: by 2002:adf:e70d:: with SMTP id c13mr17257861wrm.248.1579515379282; 
 Mon, 20 Jan 2020 02:16:19 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u8sm22362540wmm.15.2020.01.20.02.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 02:16:18 -0800 (PST)
Date: Mon, 20 Jan 2020 10:16:17 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [qemu-web PATCH] documentation: update links to readthedocs
Message-ID: <20200120101617.GC345995@stefanha-x1.localdomain>
References: <20200113103550.1133-1-alex.bennee@linaro.org>
 <2331e0b7-cad9-7b53-3d30-7fb88d692c8a@redhat.com>
 <20200115111042.GA163546@stefanha-x1.localdomain>
 <87zhepkk6j.fsf@linaro.org> <20200115120134.GH93923@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <20200115120134.GH93923@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: pbonzini@redhat.com, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 12:01:34PM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Jan 15, 2020 at 11:56:04AM +0000, Alex Benn=E9e wrote:
> >=20
> > Stefan Hajnoczi <stefanha@redhat.com> writes:
> >=20
> > > On Tue, Jan 14, 2020 at 12:11:34PM +0100, Thomas Huth wrote:
> > >> On 13/01/2020 11.35, Alex Benn=E9e wrote:
> > >> > ..and extemporise a little about their state.
> > >> >=20
> > >> > Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> > >> > ---
> > >> >  documentation.md | 9 ++++++---
> > >> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >> >=20
> > >> > diff --git a/documentation.md b/documentation.md
> > >> > index f4ef9f4..55d5db6 100644
> > >> > --- a/documentation.md
> > >> > +++ b/documentation.md
> > >> > @@ -3,9 +3,12 @@ title: QEMU documentation
> > >> >  permalink: /documentation/
> > >> >  ---
> > >> > =20
> > >> > -The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) ca=
n be read online, courtesy of Stefan Weil.
> > >> > -More documentation is found in the <a href=3D"https://git.qemu.or=
g/?p=3Dqemu.git;a=3Dtree;f=3Ddocs;hb=3Dmaster">`docs`</a>
> > >> > -directory of the QEMU git tree.
> > >> > +The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) ca=
n be
> > >> > +read online, courtesy of Stefan Weil. There is a partial set of
> > >> > +[developer documentation](https://qemu.readthedocs.io/en/latest/)
> > >> > +which is generated from the QEMU git tree. The process of convert=
ing
> > >> > +the rest of the [`docs`](https://git.qemu.org/?p=3Dqemu.git;a=3Dt=
ree;f=3Ddocs;hb=3Dmaster)
> > >> > +directory is ongoing.
> > >>=20
> > >> This has a conflict with Stefan's patch to point to our documentatio=
n on
> > >> www.qemu.org now instead:
> > >>=20
> > >>  https://patchwork.kernel.org/patch/11234545/
> > >>=20
> > >> ... Stefan, looks like the index.html page is still not there yet,
> > >> although your other patch that includes index.html.in in the sources=
 is
> > >> in the repository now? What's the status here?
> > >
> > > The qemu.git/master docs are built nightly here (index.html is now
> > > visible!):
> > > https://www.qemu.org/docs/master/
> > >
> > > qemu.org's docs are more useful at the moment since they include the
> > > user documentation in addition to the developer documentation.
> >=20
> > And I think we want to continue hosting them on qemu.org. Is it possible
> > to theme them under the website branding? Stefan's version includes a
> > banner and background icon so it would be nice to at least fit in with
> > the reset of the site.
>=20
> I did a demo of this a while back:
>=20
>   https://www.mail-archive.com/qemu-devel@nongnu.org/msg578110.html
>=20
> Essentially you just need to strip the HTML header down to the
> <body> content. Then add the jekyll header and run its site
> generator which will add the new HTML header with theme.
>=20
> In my patches above I committed the ref docs .html files to qemu-web.git
> but this is not required. They just need to be placed in any directory
> on the server where jekyll build process runs, so that we can access
> them when building the static site content.

I won't have time to play with this until after FOSDEM.

If anyone wants to send patches, please go ahead!

Stefan

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4lffEACgkQnKSrs4Gr
c8jxbwf/WXXe4gsBUxjRM4+XNarQELw42A4qu3kayiEgUiEBMwxiT48+X7+JR81A
i3wMPEAdQGrmfUpYNgjUB9ahbLhex2W8RF2hLIroRoXfhvVZEg0gJePVgO0Z2d3u
6EsFB+Xefk0TxhCtF1DwDIuOOi+9hjQjv4/CsBDo4qb65KVVqbJWtnY7ySzP8cME
9UFghiUSgQdnjXhPGWvK7bvhj706ls8OjOguI5e/iOW49rkPft3f3KqUChCSGEzV
2OletNvXaSkrXP8a30wta35m0/svq8kZDLScI82PqfIvvEwVayVPun1V4Ez/0gw7
yS674wnphIdAg733sGelu37Hbc/Rjw==
=KKXB
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--

