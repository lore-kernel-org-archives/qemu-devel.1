Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C20C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49173208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fLYwCrxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49173208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhpC7-0002FY-6J
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 01:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37323)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hhpAe-0000dp-V6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hhpAd-0005oh-Nu
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:48:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50119 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hhpAc-0005nL-Lf; Mon, 01 Jul 2019 01:48:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45cbxs0tlpz9s00; Mon,  1 Jul 2019 15:48:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561960081;
 bh=KrhB6z9Zs1xh2H4BMfMMCL7pUqPksiRfH49AbZqrGvo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fLYwCrxAe16jwePqEgMxuR/pg7r9Kw2+gg4kbHVzRxMdTkxTgtriptyZpoU4vKdJ1
 d124uuryHez3zmlo5oqmDFJEMKMRHd/CPDM+yJfMdXcNZglYENucvDpxWM2wWf7RSY
 sa8GU+BzN3jYVLrfZ0etfVSbR8neXMR2JMY3ludY=
Date: Mon, 1 Jul 2019 15:07:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190701050715.GJ2138@umbus.fritz.box>
References: <156112873945.115975.15513090884722011930.stgit@bahia.lan>
 <dad9ca85-4849-bfb0-0e09-8082ed64ecbc@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nywXBoy70X0GaB8B"
Content-Disposition: inline
In-Reply-To: <dad9ca85-4849-bfb0-0e09-8082ed64ecbc@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] spapr/xive: H_INT_ESB is used for LSIs only
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--nywXBoy70X0GaB8B
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2019 at 05:05:45PM +0200, C=E9dric Le Goater wrote:
> On 21/06/2019 16:52, Greg Kurz wrote:
> > As indicated in the function header, this "hcall is only supported for
> > LISNs that have the ESB hcall flag set to 1 when returned from hcall()
> > H_INT_GET_SOURCE_INFO". We only set that flag for LSIs actually.
> >=20
> > Check that in h_int_esb().
>=20
> Indeed. H_INT_ESB should work on any IRQ, but I think it's better=20
> to check that the HCALL is only used with the IRQ requiring it.

I'm not so convinced.  It seems to me that specifically limiting this
to certain things limits our options if we ever need future
workarounds for problems with ESB mapping.

In addition using H_INT_ESB for non-LSIs could be useful for minimal
guests (e.g. kvm-unit-tests) where mapping memory might be awkward.

So, I'm not really seeing a compelling reason to apply this.

>=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Thanks,
>=20
> C.
>=20
> > ---
> >  hw/intc/spapr_xive.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index 58c2e5d890bd..01dd47ad5b02 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -1408,6 +1408,12 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
> >          return H_P2;
> >      }
> > =20
> > +    if (!xive_source_irq_is_lsi(xsrc, lisn)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: LISN " TARGET_FMT_lx "is=
n't LSI\n",
> > +                      lisn);
> > +        return H_P2;
> > +    }
> > +
> >      if (offset > (1ull << xsrc->esb_shift)) {
> >          return H_P3;
> >      }
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nywXBoy70X0GaB8B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0ZlQMACgkQbDjKyiDZ
s5I+IxAAklrFK/1mvHKCteVu03DY7fL5ZWfgGifh3AOOrAspQ/yWMsAXdM1wgp5I
m4DfZGwB1MvUvnJ6TiFrr/EOi4emrux4L1KTBZ4UlIpFHfl9uh6BiTgLvkRvB9X6
tyPmlV37cJ6CEr4gE3gFvaDgVd2Mt6fjuxEKdaJTZV1c5OoTEU+JdJSAwGLHcWQu
Pi4XsAr/PrRKXNMgfCYgpYJgvnhYTWMfMZ5qb08vvwqKA4phDMNLZmGpakkjk2aL
U9Beqow8dhxCku5YzQ+Zgdq5llCd0Fyr0eLF02D49okpsn9YgkDALqoesZfmoTAR
BVtrElN5pqX74nqYUkK0jdgrjhtjf9mjfQFbEmsBUIeqWYThiVjJnaTS5NDVnVSC
1j5A33sz/RE1iiGdjZmTNkl2s2q7hvdohJGdLmHrpx2aMbMzLGOwYJoUoI6laGeI
mbZOFnHY4tm7LT+OwGH8/4moz0rGIOlFmAbFbO4qeeJiqGxjV+GXXazWxee9khIZ
8jAFYlzebrzEI8CNwQWQuddEgI8y10NSWAH3pM+nDhyipMMd7nCQweuKuwRZPd23
huQTA7VNtg6hyaTvjuq9TeeLujF3Evu+rv80ORSaFiGsVCPrixqL3qZ5qkY8JamQ
rL0hkmrHZcxDSSd+fC90KofUFERndAaymzkRVpHZuPXBSZfje1c=
=JT4/
-----END PGP SIGNATURE-----

--nywXBoy70X0GaB8B--

