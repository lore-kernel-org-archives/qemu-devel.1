Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBDCC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 09:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56FD120723
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 09:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oCXdOO/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FD120723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVXmt-00088R-Go
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 04:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iVXmD-0006Uz-1r
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 04:20:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iVXmB-0001Pb-Bv
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 04:20:24 -0500
Received: from ozlabs.org ([203.11.71.1]:33569)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iVXmA-0001OU-Eg; Fri, 15 Nov 2019 04:20:23 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Dt9T70Rvz9sPK; Fri, 15 Nov 2019 20:20:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1573809613;
 bh=GAal6PR4V2MjnYgDyPxtGuW71Cb60NDCzl1+F1KPVz8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oCXdOO/+grhCEijrhLzm80aMLb9YMzM1Lx9h73OPwjsGro3yHTmwafX8NFSli1h/p
 p/qbP+Qy8TCgVHSBsQlRv2iUl9r1VBakt4SdZsQx/0/Dh1CtknjxmSn2MF5ezK2yvB
 EzW+QnjH7/lohfVaw2+cuHFV6mq//kzfA6Yezeco=
Date: Fri, 15 Nov 2019 20:20:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr/kvm: Set default cpu model for all machine classes
Message-ID: <20191115092003.GC2134@umbus.fritz.box>
References: <20191030163243.10644-1-david@gibson.dropbear.id.au>
 <20191113144344.GA4204@orkuz.int.mamuti.net>
 <20191113160900.5f9f5415@bahia.lan>
 <CAFEAcA9+VzDC9N5vGcA9COUaPsSue9VWmtoaPneCqY7drtbVzA@mail.gmail.com>
 <20191113170040.7c62fcaf@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <20191113170040.7c62fcaf@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2019 at 05:00:40PM +0100, Greg Kurz wrote:
> On Wed, 13 Nov 2019 15:31:58 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>=20
> > On Wed, 13 Nov 2019 at 15:10, Greg Kurz <groug@kaod.org> wrote:
> > > David is away until the 19th of November, which is the release date
> > > of rc2 according to the planning [*]. Then we have rc3 the 26th, and
> > > final release (or rc4) the 3rd of December, so it should be ok.
> >=20
> > Please don't actively plan to delay putting changes in
> > until later release candidates. The release process
> > involves steadily winding up the bar of whether it's
> > worth putting in and hopefully reducing the volume
> > of changes between rcs. In an ideal world rc3 would
> > have very few changes, and then there would be no
> > changes at all between rc3 and the final release.
> >=20
>=20
> Right. I could discuss with Laurent: David should be back on Monday
> actually. Hopefully he can a send a PR before rc2.

I'm back home now, back to work on Monday.  It'll probably take me a
full day of catching up on email and whatnot, so the earliest I'd be
likely to do the PR is Tuesday.  If you can get it ready before that,
please go ahead.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3ObcMACgkQbDjKyiDZ
s5L3EQ//a7h4hPa3JOSKWPJsMCordo1RlsRseAMKWTDLx3BdbvX8GNoBUtyzL6qn
lT48IIojLntMzF0b+OdElr7ofHJSj9ZtgMx6j7fJ/eea7ckCRESoGFfXznwXmx6j
iY/3k09rmW4X7QJB3OgZw6qO6L/H2uUhRlo6HTMxzEIJHCt1FdoMrdZUtNAAvoXQ
gG1L+W/Gbuxe2ceoX6ALQ7/KikQCSdONr1W6WoCHandqy58Q9Z7Fx9P4Sc/QdrN3
rWpF3aDY1PW8wEfYKvkjTEDjAvSWmEfX6dkHS0wPUd4B2Pophg9l4nrdYc/cIHzw
GXssoR38JTTuHN7emiLS+QmbM5yoN/Ehiql1ijLkT6H5k/jtZimHHBRzxNQK9/KC
kJKw1kp9rCpixMJbndfCfgYXRgij7k1i8+DCVtCjot0rwMxc8VM8maDlzqnCaVl+
/WSKI3+oF0HIkW1kPgs354j+y4GkiwA42QrNGYHs3EvJGTqsysvxasZjQQ1ZsmIZ
fw5PZ2swqRL+KGa3n0HzUCiPJh3TRH77bwhZllU4ugVZ8O5A138UMekgoZqAOG0j
ZQ1H4kyJK8JvLWmq6xzl+qf8/CYWJCY1dxjLQ/ceviR/+FcCW78fT1Y10O5/a0l9
X2vBDLbKXAge6oPib4X1hoJtIbHH3QlT/bBckfCkYFomI0qpS+Q=
=HbOp
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--

