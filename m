Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2679C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 02:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E108222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 02:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jpKErUUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E108222BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDJRU-0000Wb-IL
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 22:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDJOu-0005iE-GZ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 22:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDJOt-00017S-9u
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 22:21:00 -0400
Received: from ozlabs.org ([203.11.71.1]:42297)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDJOs-00015H-VN; Wed, 25 Sep 2019 22:20:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46dzD96jwcz9sPZ; Thu, 26 Sep 2019 12:20:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569464425;
 bh=RFQxJJMDCKwchuVxueoKhwe4RU2UJcLCiPRj/r2cm9A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jpKErUUChW0IQ3p0RZQQ/8FVoDJL+hTR+GPKoWocM0dcnMFZJeiFEPl+dcQE7YHs0
 6IEnw4/FtBBH6K8uVhnDivuShgpnKWqhL8Y6v8Xx7JCvnm0T81USE/5UpIhA+FseAE
 0LHqWEHikI6U2mafZgE79xkLVYPpgHejclq3/eH0=
Date: Thu, 26 Sep 2019 11:31:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 11/20] spapr: Fix indexing of XICS irqs
Message-ID: <20190926013148.GU17405@umbus>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-12-david@gibson.dropbear.id.au>
 <20190925221746.7b497c8c@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hUen2UJD5eWDKlb+"
Content-Disposition: inline
In-Reply-To: <20190925221746.7b497c8c@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hUen2UJD5eWDKlb+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2019 at 10:17:46PM +0200, Greg Kurz wrote:
> On Wed, 25 Sep 2019 16:45:25 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > spapr global irq numbers are different from the source numbers on the I=
CS
> > when using XICS - they're offset by XICS_IRQ_BASE (0x1000).  But
> > spapr_irq_set_irq_xics() was passing through the global irq number to
> > the ICS code unmodified.
> >=20
> > We only got away with this because of a counteracting bug - we were
> > incorrectly adjusting the qemu_irq we returned for a requested global i=
rq
> > number.
> >=20
> > That approach mostly worked but is very confusing, incorrectly relies on
> > the way the qemu_irq array is allocated, and undermines the intention of
> > having the global array of qemu_irqs for spapr have a consistent meaning
> > regardless of irq backend.
> >=20
> > So, fix both set_irq and qemu_irq indexing.  We rename some parameters =
at
> > the same time to make it clear that they are referring to spapr global
> > irq numbers.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> Further cleanup could be to have the XICS backend to only take global
> irq numbers and to convert them to ICS source numbers internally. This
> would put an end to the confusion between srcno/irq in the frontend
> code.

Yeah, maybe.  But the local srcnos do actually make sense from within
the perspective of ICS, so I'm not all that keen to do that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hUen2UJD5eWDKlb+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2MFQQACgkQbDjKyiDZ
s5J60Q/5ATLRa+01tQ7gHZEB7quYQ/m2e8prUevaFWaijk/GL4mbGU9tAnF/m2f1
/+tzHPU81iHstEQpZgGjDkx5yukKza2SNHFcaDoF30Dxjd5v6fuV867HlCi4fM9c
RrjPReOyLfbRpdMa382q4h0tXq6gkaTbRrVhTfa7PhNAnk9DfAS9x2RpkihgXESL
jtm6vC8Pte380wCnSxeo/UiQyYghYVvkIeOStmLU6L9aFRzoijQdTofwWqN1aXXj
zsLDAFRTqX8uCdD+qzS70STmGY6NzGLAmqPAtjVB4Wdk/SWtdkZ918gG1I9KkG9c
poAnF6AmsnUHC4UuEb4V7jGHlcRoLYhpieaWlglLUaOdfCGw2uLhmQWYbtj8bZvA
pZhLkd2wBU5UHPvT2+V9YxGH4cBlbh2zcd6bAbMVVSKnof2dGnM6m9PJZJjgRmHL
K5DkpJF8V0wMObqlqOLdjxypAsOda4jxaxk9tokTxrgktf4G2WO/QcrKw07g+Tsw
P/sYMAdOvK0dhcfi8lBQihNQbdZETeJV32ovJQ2bRLBvxHtioVow0l9/PVcK0b49
xEIbQeYI6ZaBrHBh+bC3DvCPrL1E/5kJGovglNiRX/jb9GCd0zKbyleGX6+diOgT
fZBMw7P4E1Aq4IUn7/aaEdlR/y/5X7q++NGoI51hz/kJXOC2O0s=
=hg7I
-----END PGP SIGNATURE-----

--hUen2UJD5eWDKlb+--

