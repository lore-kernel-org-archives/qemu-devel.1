Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD18C3A5A3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 02:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCFA02173E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 02:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HYApzLYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFA02173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2o3P-0006vt-QS
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 22:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i2o1i-0005D2-Ge
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 22:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i2o1h-00073x-7a
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 22:49:38 -0400
Received: from ozlabs.org ([203.11.71.1]:46179)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i2o1f-0006zt-Ry; Tue, 27 Aug 2019 22:49:37 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46J9F50BHSz9sNf; Wed, 28 Aug 2019 12:49:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566960569;
 bh=JteTbgXY9mRza6LJTDu8lpJoi5UHRvkUXUHSb19QxNA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HYApzLYsuEETc1+YZbzwWi0s/BvcZ6NMTGl0B2mxBGLS8O2/sL7KXm9W/7oytMuYj
 sCuVGqnBO5XOg4Vn74lNCciQO+jKeaq2tucntXc0xO2+781iYApKcFgws/A5x6Kj47
 a8mQPF8IpgvG0gUeTDf/zC3wcFHcCLBTidAreHqI=
Date: Wed, 28 Aug 2019 12:12:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190828021237.GD16825@umbus.fritz.box>
References: <20190827065650.107319-1-aik@ozlabs.ru>
 <20190828004634.GB16825@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
In-Reply-To: <20190828004634.GB16825@umbus.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [GIT PULL for qemu-pseries] spapr: Render full FDT
 on ibm, client-architecture-support
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 10:46:34AM +1000, David Gibson wrote:
> On Tue, Aug 27, 2019 at 04:56:50PM +1000, Alexey Kardashevskiy wrote:
> > The following changes since commit d6bb8b27204eaa58f1da948b65454e3a598a=
b2a4:
> >=20
> >   pseries: Update SLOF firmware image (2019-08-27 16:47:04 +1000)
> >=20
> > are available in the Git repository at:
> >=20
> >   git@github.com:aik/qemu.git tags/qemu-slof-20190827
> >=20
> > for you to fetch changes up to da9960a5aaa25d27c9798c3d94c7b4c2d8af31ac:
> >=20
> >   spapr: Render full FDT on ibm,client-architecture-support (2019-08-27=
 16:47:46 +1000)
> >=20
> > ----------------------------------------------------------------
> > Alexey Kardashevskiy (1):
> >       spapr: Render full FDT on ibm,client-architecture-support
> >=20
> >  hw/ppc/spapr.c | 90 +++++++-------------------------------------------=
--------
> >  1 file changed, 10 insertions(+), 80 deletions(-)
> >=20
> >=20
> > *** Note: this is not for master, this is for pseries
> >=20
>=20
> Merged, thanks.

Urgh.  And the qemu change is now un-merged.  Alas, as soon as we had
a CAS reboot for XIVE the guest didn't boot on the second attempt.
Haven't had a chance to investigate yet.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1l4xMACgkQbDjKyiDZ
s5JsKA/9Gu9WWTE4Nb56a1nyFlsYtiLj++bjwlTtcXf6exa85xyUcjmwuKIIr9Of
yDALHcLpHprCTsdBEJZdqcDAEzvxGUy7EjLR/lBCE/kxFSScV/jASKKec1h4f3Ma
QjRDh7SlVIvcl8oMwOr5SQPTeFLsJvKOkDIng4d4iaLnExhUgbMLtbKWvEBYJXEH
VU8YZx3+D9OyuZbw7n/H3Z5NNPm9UafMAsvNoHOl+6LXRc3gobx+kOUaPo6rnKpM
axqZXHMWKHROHyl730+9sHU26zODtln4Q55VpDNZI18ypWazzg+IuSuXoT7NGf22
FMFZGNJsFE5vN+vCxSpfRpusD8fJjVVgD7nJ06D20CBrkIfXVM5jFghXvklqh0C+
xNcN7lSDHGaCjEZMIaOIVRroRoxixFDuIq4fpzWsBIsPnnvuT+6XLlbvc16pJ8PV
HvT0QBv93KyTENLdcu+taFxuotSpyKA2qJO2myTVYMhu5r+0Q4O8Y6Z7LctwHmb+
sWQVWqTVDG4JvZXYf8lCHTtcYfR5aT752BeFHLTjJoteU91DSWh+7x2QIhYfwB3n
EwvwYkb5hvrG9ofbSqaTQj0WC1GN6S8IotFwUL3iNlAniMVpzRFcigGikcgH46S2
+mKinveEbOCaIqcZpFNoAz61M5WHYkkklv+uTIVWgP44qJfO//Q=
=rCtm
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--

