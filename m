Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80767C0650F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 00:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D858214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 00:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HR/mAY70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D858214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvsVR-0006nv-In
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 20:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56511)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hvsUg-0005Pf-0J
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 20:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hvsUf-0004m0-7w
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 20:10:53 -0400
Received: from ozlabs.org ([203.11.71.1]:52787)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hvsUe-0004k8-6k; Thu, 08 Aug 2019 20:10:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 464Qck5LKxz9sNC; Fri,  9 Aug 2019 10:10:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565309446;
 bh=/A5p4D93UzcXt3DXlr5wmK66eUBvz9+7eH5r/seQfoM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HR/mAY70wq51WPzVeBTz6S0GZN1nvRV3Mi0mhDYVu+SvfeFxThRIvE69+Kzk9BadI
 DhATAFoCQHdauAKIddCAQAc1vP3Ew4EbJ1tcmWaNwdb89JKOjPMSijd/a2l6qsvpOZ
 648B94DlT/61N3T5mmNs/4yIDjUW0P0E6DZy9y6w=
Date: Thu, 8 Aug 2019 16:35:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190808063500.GB5465@umbus.fritz.box>
References: <20190805071302.6260-1-tao3.xu@intel.com>
 <20190806145055.4f645f60@redhat.com>
 <20190807175256.GD4669@habkost.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <20190807175256.GD4669@habkost.net>
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


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2019 at 02:52:56PM -0300, Eduardo Habkost wrote:
> On Tue, Aug 06, 2019 at 02:50:55PM +0200, Igor Mammedov wrote:
> > On Mon,  5 Aug 2019 15:13:02 +0800
> > Tao Xu <tao3.xu@intel.com> wrote:
> >=20
> > > Add MachineClass::auto_enable_numa field. When it is true, a NUMA node
> > > is expected to be created implicitly.
> > >=20
> > > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > > Signed-off-by: Tao Xu <tao3.xu@intel.com>
> [...]
> > > +    mc->auto_enable_numa =3D true;
> >=20
> > this will always create a numa node (that will affect not only RAM but
> > also all other components that depends on numa state (like CPUs)),
> > where as spapr_populate_memory() was only faking numa node in DT for RA=
M.
> > It makes non-numa configuration impossible.
> > Seeing David's ACK on the patch it might be fine, but I believe
> > commit message should capture that and explain why the change in
> > behavior is fine.
>=20
> After a quick look, all spapr code seems to have the same
> behavior when nb_numa_nodes=3D=3D0 and nb_numa_nodes=3D=3D1, but I'd like
> to be sure.

That's certainly the intention.  If there are cases where it doesn't
behave that way, it's a bug - although possible one we have to
maintainer for machine compatibility.

> David and/or Tao Xu: do you confirm there's no ABI change at all
> on spapr after implicitly creating a NUMA node?

I don't believe there is, no.

>=20
> >=20
> > >      smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> > >      smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
> > > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > > index 2eb9a0b4e0..4a350b87d2 100644
> > > --- a/include/hw/boards.h
> > > +++ b/include/hw/boards.h
> > > @@ -220,6 +220,7 @@ struct MachineClass {
> > >      bool smbus_no_migration_support;
> > >      bool nvdimm_supported;
> > >      bool numa_mem_supported;
> > > +    bool auto_enable_numa;
> > > =20
> > >      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
> > >                                             DeviceState *dev);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1LwpIACgkQbDjKyiDZ
s5JDyw/8DuPUSfy/0vhR8vHsuLOfOMq6wgG0EZ6RJOZmN5xBXQfgtkJNL3QwfMjQ
+o7Fj0nznrSH0Xd/jJPetl+b4PUQ6IMlHxEp2p6N0+yFGmNxc6FCCXT/Ozn1I0uk
Y77RJ1MW7DnY1coaCASl/YUPtSqC+O1RBwkVRhxaqJRIu1pMfNPjGCaiAj8lqNYa
Xx6bCxKy9xTjbCXyS5M+KokeWuS2zQ0G36LuqEOP5kMiQyhO63d0b3YWzLmMgtPt
nLKEVQoyo5qkNEByDh/BlI0iFXw1h5NOQGBUWcA4o4A5wlLTZgcxEix2k+BJePI4
xYl4cB+KQashg74usS6jDY2lNcJWfD+rHRWy8w4VA5U2yCzyoBaFoLc2DILpJCkO
vcV1lOGipWM5T5iLvDEGB8wx6xCZhgNs/GUjO/LFT7jz5XKUw/9nM0AEhocpJKev
L1gRz/qZQdsRIb9O84U92QtxP+QV/teBhbRu6QLVOT3PYH8k8Yzh2wAT5Y7ykdYk
dko+EaHJVQAwMBKQBw1wvcP9Zq6E1IGaIdYn/4UgQFVG+mlbm2pOEwMWmSudSAW2
m5l6kl37GCDBBTex1wDQY2lSneoftJE0nYfcwOVDl5PRF2Sv417Eoz5xOgMs5Mwx
voxrRGpaMA4pWyNgVsxsPL9jgJJusy+fSI5tjxBeaGpWjrh8REc=
=M4h5
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--

