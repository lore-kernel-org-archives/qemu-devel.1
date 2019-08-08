Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA15DC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 00:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89152214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 00:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IRu64QSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89152214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvsWY-0001MD-Rm
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 20:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56514)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hvsUg-0005Pg-1V
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 20:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hvsUf-0004lz-7v
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 20:10:53 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38629 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hvsUe-0004kB-5A; Thu, 08 Aug 2019 20:10:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 464Qck6r8yz9sNF; Fri,  9 Aug 2019 10:10:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565309446;
 bh=1ke8JD3ZSVwGuzGXk1wLieiqK+LtCo54Db+ej8F4zic=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IRu64QSKDzTLtS9FjWRAXWfr/wdSSZw6gwAxJ4BQoZKzTpKNgpfsthEMN4d6zTJsX
 zvO/DWiZL3ST3MeaowqXxZUK6x6k5jEiwTHEYD+uqAQYO8MjZre6iJclFtSCGvNT2O
 ++AGhLzXmoKjVO6hVQCpNahb8vXNPrO0YWNAhxo8=
Date: Thu, 8 Aug 2019 16:35:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190808063558.GC5465@umbus.fritz.box>
References: <20190805071302.6260-1-tao3.xu@intel.com>
 <20190806145055.4f645f60@redhat.com>
 <20190807175256.GD4669@habkost.net>
 <20190808063500.GB5465@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <20190808063500.GB5465@umbus.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] numa: Introduce
 MachineClass::auto_enable_numa for implicit NUMA node
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
Cc: Igor Mammedov <imammedo@redhat.com>, Tao Xu <tao3.xu@intel.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 04:35:00PM +1000, David Gibson wrote:
> On Wed, Aug 07, 2019 at 02:52:56PM -0300, Eduardo Habkost wrote:
> > On Tue, Aug 06, 2019 at 02:50:55PM +0200, Igor Mammedov wrote:
> > > On Mon,  5 Aug 2019 15:13:02 +0800
> > > Tao Xu <tao3.xu@intel.com> wrote:
> > >=20
> > > > Add MachineClass::auto_enable_numa field. When it is true, a NUMA n=
ode
> > > > is expected to be created implicitly.
> > > >=20
> > > > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > Signed-off-by: Tao Xu <tao3.xu@intel.com>
> > [...]
> > > > +    mc->auto_enable_numa =3D true;
> > >=20
> > > this will always create a numa node (that will affect not only RAM but
> > > also all other components that depends on numa state (like CPUs)),
> > > where as spapr_populate_memory() was only faking numa node in DT for =
RAM.
> > > It makes non-numa configuration impossible.
> > > Seeing David's ACK on the patch it might be fine, but I believe
> > > commit message should capture that and explain why the change in
> > > behavior is fine.
> >=20
> > After a quick look, all spapr code seems to have the same
> > behavior when nb_numa_nodes=3D=3D0 and nb_numa_nodes=3D=3D1, but I'd li=
ke
> > to be sure.
>=20
> That's certainly the intention.  If there are cases where it doesn't
> behave that way, it's a bug - although possible one we have to
> maintainer for machine compatibility.
>=20
> > David and/or Tao Xu: do you confirm there's no ABI change at all
> > on spapr after implicitly creating a NUMA node?
>=20
> I don't believe there is, no.

Oh, FWIW, the PAPR interface which is what defines the guest
environment has no notion of "non NUMA" except in the sense of a
system with exactly one NUMA node.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1Lws4ACgkQbDjKyiDZ
s5IYkg/7BsEjnQpBYnBYSBjluREWEnM1FWXzmP0xh/LRX/0tkmye2By2rRvOtHzl
RhyP/coKx46m4Y+XkjddJ9ZKo1TiAGtMFzuz/438nOAKLL/1+viGA+5734XuQ/Mh
GTXwvKPtQcufD5buDxRDLqxWldOxmdBl1clpnOLpcjav4zuUZ0KLkzFkGYzctgFv
Hd1ukD5uZw+ZgjLEAJx+bg3QAGFYyuJ1T4DqHUWKkTVFVZ6bkHYGb+OviImQ0SIo
WCwpBaWrPkw6DvX8eZ5FUO+KBvnPfIAAYYbrbMAk+G4TWE4zwVACHcX+4umx2TvF
TO2K+Mwf1rV/IoECWCxodlO888elvTnCVqArU+PBSRncaEVcPp9Le4yVyHk0z7al
6w3+wWWQR1pDVhXIbt/VoufI0j/9mswR84jOS45gWIhu83nkyfSwZGBe/3OWtP/Q
kEmPBc7jyfvbT6xlM9mzSQdLAAR2BOE8LbTl79rK3M6YU5pzFCh4Z/9JA2mSl2vv
VLE0iJCImlrh8uDGW9ubrrN+Ipv29/8jqqpDu7Nc2+iDD1eMG900zMB4EzfVgOea
nPwvgcQU1+XWqGX2Un2s9WRftRrRS4VcPZmbxsa4qLGKD3WIVSP9hvHj+66LTXUT
w41lZkdPHvh+SwbAYcXAIntVf2anwXRmUxkxssje4KEc4gozfCM=
=wLmW
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--

