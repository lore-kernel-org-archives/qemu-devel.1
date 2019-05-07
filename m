Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_FUZZY_SPRM,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C6BC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF37206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="b6nyMS9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF37206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40795 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNtaJ-0004Xf-3f
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 02:28:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVi-0000mM-6A
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVg-0002dW-S3
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:30 -0400
Received: from ozlabs.org ([203.11.71.1]:40583)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNtVe-0002Z3-J2; Tue, 07 May 2019 02:23:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yqL214wwz9sBV; Tue,  7 May 2019 16:23:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557210202;
	bh=vDBoBub+64YWAZFq+/yU562hrSITXJe6m91CtDs65P8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b6nyMS9scI7/IochDLr6hb/u+SGZ1Ep8j8ck8STUgyCMtUaoX71kpR6Uq6pm0eRQK
	ZXXeAQkARFeVOKyACHxQd4vgud+FkASSivX6Tt4jUwmPgsOQRmqvdxygLzubqtNm3S
	dz+4HZrhQKIhbUVhz3ZUIWplEwglrMff0ikBzWIY=
Date: Tue, 7 May 2019 15:16:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190507051654.GD7073@umbus.fritz.box>
References: <20190506014803.21299-1-sjitindarsingh@gmail.com>
	<20190506032304.GB6790@umbus.fritz.box>
	<1557186214.6435.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <1557186214.6435.2.camel@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH] target/ppc: Add ibm,
 purr and ibm, spurr device-tree properties
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
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 09:43:34AM +1000, Suraj Jitindar Singh wrote:
> On Mon, 2019-05-06 at 13:23 +1000, David Gibson wrote:
> > On Mon, May 06, 2019 at 11:48:03AM +1000, Suraj Jitindar Singh wrote:
> > > The ibm,purr and ibm,spurr device tree properties are used to
> > > indicate
> > > that the processor implements the Processor Utilisation of
> > > Resources
> > > Register (PURR) and Scaled Processor Utilisation of Resources
> > > Registers
> > > (SPURR), respectively. Each property has a single value which
> > > represents
> > > the level of architecture supported. A value of 1 for ibm,purr
> > > means
> > > support for the version of the PURR defined in book 3 in version
> > > 2.02 of
> > > the architecture. A value of 1 for ibm,spurr means support for the
> > > version of the SPURR defined in version 2.05 of the architecture.
> > >=20
> > > Add these properties for all processors for which the PURR and
> > > SPURR
> > > registers are generated.
> >=20
> > So.. what does the current empty property mean?  Is it just wrong by
> > spec, or does it actually mean something incorrect?
>=20
> Af far as I can tell, an empty property is invalid according to PAPR.
> A level value is required to communicate the level of purr
> implemented.

Ok, makes sense.  Applied.

>=20
> Should probably have:
>=20
> Fixes: 0da6f3fef9a "spapr: Reorganize CPU dt generation code"

I've folded that in.

>=20
> >=20
> > >=20
> > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > > ---
> > >  hw/ppc/spapr.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 2ef3ce4362..8580a8dc67 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -500,7 +500,10 @@ static void spapr_populate_cpu_dt(CPUState
> > > *cs, void *fdt, int offset,
> > >      _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
> > > =20
> > >      if (env->spr_cb[SPR_PURR].oea_read) {
> > > -        _FDT((fdt_setprop(fdt, offset, "ibm,purr", NULL, 0)));
> > > +        _FDT((fdt_setprop_cell(fdt, offset, "ibm,purr", 1)));
> > > +    }
> > > +    if (env->spr_cb[SPR_SPURR].oea_read) {
> > > +        _FDT((fdt_setprop_cell(fdt, offset, "ibm,spurr", 1)));
> > >      }
> > > =20
> > >      if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzRFMQACgkQbDjKyiDZ
s5KhAQ/9E0MX9x5y9xPWxRCrybY1UGmP/LA1nZpyQbewkb6rF5YMJe9cQAiyl73Z
HOhSOMjYnk7w++/x3ZbqMovZRSOzDOVeX7m8/jZiknUtLHiHryrrEv/2XKtqwIr1
EagvcpFhzWpKS91uXRbWHEvMR1yaNRrYILUIs7tdQ01buiRx5b11Xp/gMPURLn0G
RDhJrda/HlYJwN/l0J5+WpIyeSWf++tfb6Ltd854Q8QkacevTziAiEp8KQCuZPLS
AwT6PRrAWQ8YOHk3NnQ4iNy2vpmHqzicc9kgjMGVQjmJA0TU5lc6dslvoBjysGXe
WW4aUlXLeSdmfrOIxNKCnINY+EYSFF2xYvZHpUgDmxj8+BIee/hQSHUqGONeFiV/
DcyJ7MtMZQBXxp44H2Ph7a4lpZjxUxUeygROlcNhyDI7Deliob761POd9sRfP8Mq
HzTf3cHDPD8hHEXRHtL0MFD2vpCT8uOvJLvSWjeQ4KOMnK7vMPjwDYUriL6hIOGJ
Kqu+ypGGOsux1WCRg6uqZ2r6xmBBx1Dmw8NYkA5enHSji1zVuvHlSd/+2eB5tVzM
uG5RzmrFlF6CZUvxUAXgzjOMZFsm7c8V/RGbiIIfAxMqNaFPDEwLo5PXlrW1e8Vz
qf8N3l+XFA8bCLW4ZsddnYlFl3ivzvlfW5EmsSaDSY75o8OmVag=
=D2Pi
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--

