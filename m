Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC1DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 05:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2285206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 05:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JiKuYdBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2285206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieYKj-0003IQ-T9
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 00:45:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ieYK2-0002mr-Nv
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 00:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ieYK1-0004F3-I0
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 00:44:34 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:40483)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ieYK1-0004EK-7A; Tue, 10 Dec 2019 00:44:33 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47X8C16jlzz9sR0; Tue, 10 Dec 2019 16:44:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575956669;
 bh=7U60VSCo280nIUYOlfgydbaTsE4kWbxVB0vFV/Crocw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JiKuYdBv9ukKE0iB8Cv6Qfb9ZxGkIu5+GatrT4KB5yK5Jx1id7b5dRnYIIXADHqyb
 7B9A0PGIk+C4inXNnG79UKWjxSeaHUM9YGjjD9v9cSLUHYGHANOKlgAgBm5uufGEpP
 Mo7DfUt0GhclVkx16UxkWYfycq4alKjUwHwUmJxE=
Date: Tue, 10 Dec 2019 16:44:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [for-5.0 3/4] spapr: Clean up RMA size calculation
Message-ID: <20191210054421.GK207300@umbus.fritz.box>
References: <20191129013504.145455-1-david@gibson.dropbear.id.au>
 <20191129013504.145455-4-david@gibson.dropbear.id.au>
 <26f70f7b-d2e3-689a-693e-66ced0f6d4f8@ozlabs.ru>
 <14bfabf7-826d-4fcf-f185-705e45042cd8@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="T4Djgzn3z2HSNnx0"
Content-Disposition: inline
In-Reply-To: <14bfabf7-826d-4fcf-f185-705e45042cd8@ozlabs.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 groug@kaod.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--T4Djgzn3z2HSNnx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2019 at 04:06:46PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 03/12/2019 14:44, Alexey Kardashevskiy wrote:
> >=20
> >=20
> > On 29/11/2019 12:35, David Gibson wrote:
> >> Move the calculation of the Real Mode Area (RMA) size into a helper
> >> function.  While we're there clean it up and correct it in a few ways:
> >>   * Add comments making it clearer where the various constraints come =
=66rom
> >>   * Remove a pointless check that the RMA fits within Node 0 (we've ju=
st
> >>     clamped it so that it does)
> >>   * The 16GiB limit we apply is only correct for POWER8, but there is =
also
> >>     a 1TiB limit that applies on POWER9.
> >>
> >> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >> ---
> >>  hw/ppc/spapr.c | 57 +++++++++++++++++++++++++++++++-------------------
> >>  1 file changed, 35 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 52c39daa99..7efd4f2b85 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -2664,6 +2664,40 @@ static PCIHostState *spapr_create_default_phb(v=
oid)
> >>      return PCI_HOST_BRIDGE(dev);
> >>  }
> >> =20
> >> +static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
> >> +{
> >> +    MachineState *machine =3D MACHINE(spapr);
> >> +    hwaddr rma_size =3D machine->ram_size;
> >> +    hwaddr node0_size =3D spapr_node0_size(machine);
> >> +
> >> +    /* RMA has to fit in the first NUMA node */
> >> +    rma_size =3D MIN(rma_size, node0_size);
> >> +
> >> +    /*
> >> +     * VRMA access is via a special 1TiB SLB mapping, so the RMA can
> >> +     * never exceed that
> >> +     */
> >> +    rma_size =3D MIN(rma_size, TiB);
> >> +
> >> +    /*
> >> +     * RMA size is controlled in hardware by LPCR[RMLS].  On POWER8
> >=20
> >=20
> > RMA is controlled by LPCR on P8 but the RMLS bits on P9 are reserved
> > (also reserved in PowerISA 3.0).
> >=20
> >=20
> >> +     * the largest RMA that can be specified there is 16GiB
> >=20
> >=20
> > The P8 user manual says:
> > =3D=3D=3D
> > The following RMO sizes are available for the POWER8 processor.
> > The RMLS[34:37] field in the LPCR defines the RMO sizes, as described b=
elow.
> > 1000 - 32 MB
> > 0011 - 64 MB
> > 0111 - 128 MB
> > 0100 - 256 MB
> > 0010 - 1 GB
> > 0001 - 16 GB
> > 0000 - 256 GB
> > =3D=3D=3D
> >=20
> > The maximum seems to be 256GiB.
>=20
>=20
> Ah, update from Paul - we do not actually use what LPCR[RMLS] controls -
> Real Mode Offset Register (RMOR).

Ah... I realized where the 16GiB limit was coming from.

We don't use RMLS with KVM, but we *do* use it under TCG.  The softmmu
code isn't aware of PAPR specific stuff at this point and just
consults the LPCR to handle real mode accesses.  And the TCG
implementation only supports up to 16GiB, even though POWER8 supports
more.

And, AFAICT that limit will apply for a POWER9 guest in hash mode as
well.  Not for initial boot, because we run in radix mode until we
determine that the guest wants hash, but if we drop back to real mode
after boot, this might matter.

I'm going to have to think about how to sort that mess out.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--T4Djgzn3z2HSNnx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3vMLIACgkQbDjKyiDZ
s5J3uxAAqnW7GQTLOuv5Vw78FX++H4NK8PT6JVg2Ok6YEwTS+FgrNihZ4gdknneW
l6U1ijnWir9xprSd/Uv6FyaEvcpXKjxOlq+UIuegY5hZH1KkNo3dOVPtQVrizTKP
IolAhTmPtdnwqgPraUCx5bphOx/OJE9qLHA7bjZnpxAatz6HGoMbwCewc08joD+U
j9Kxb7K3KRnNgIPMtKdQk+3QUuCSypTnHxZdCZF2EKS3hpSGhN6aUwQf5eXUvE1a
mNj/rvyRlbl2LvKq1K47drJWjbQHd6HNLUAvTyqhhbGoScsHCGDxN8qed9b98270
x/7X66Z46Rx3Rx3SZhx4Wh9Zo5iqlfy79EhNvDJhwV8EQG9Nyzln9hIc8ojWY0GB
HozT4xRhVvga7Qvh33kbBKbButxAGUC4PU/AQBrm+ud48kNM9WziNZKE0xCr0miM
nH+N2V2Lk/HxXA4jO7pxt8zDNnKsq5WK0o4VwhBJNR49o0kkppcGkUxdNlpUR0df
XBztBluLpqtMUlwk0ybsbkN/PZWYoBcwwE1m3e6ytYEp6HrutA9j5sDUGNLc1ulO
TwKn3PA/NWwxI1aLwh0DhNe4n0j6L92n33FSNzZrRIxvvPjNs6Pi5NQwXeIwD3sw
UbAeBH3EamQeisMn55eL4BsDVZ4lBhRgTHSfWDA61c/yxKKRYMw=
=YxAW
-----END PGP SIGNATURE-----

--T4Djgzn3z2HSNnx0--

