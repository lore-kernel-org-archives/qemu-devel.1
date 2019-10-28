Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4D5CA9EC2
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 08:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3960420663
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 08:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DXZQwOA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3960420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPMRT-0008HQ-8F
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 04:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iPMQA-0006sS-4T
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 04:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iPMQ8-00056X-Iy
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 04:00:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33287 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iPMQ7-00051S-Mv; Tue, 29 Oct 2019 04:00:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 472PBg4Sryz9sQm; Tue, 29 Oct 2019 18:59:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572335995;
 bh=BLFdnPBtMaW6B2thKFrHpNqwrXBmhyxkTNXukuHAfjg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DXZQwOA617bJQplaN1EDG5qjnHJq6ZboO59GG67GBuvfZGsm20inmpTpJhYy/qQ8W
 e7RrSKgQzOkHrKup24OiC5PO+MGEPDbtGIwbynG11ShIHaVuQqUV+4244segHc5zCP
 HqupZsj/I1f6RUsL21NLjEKKQcrgCJUrGSgmq0KQ=
Date: Mon, 28 Oct 2019 23:20:06 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr: Don't request to unplug the same core twice
Message-ID: <20191028222006.GP3552@umbus.metropole.lan>
References: <157185826035.3073024.1664101000438499392.stgit@bahia.lan>
 <20191023223817.GL6439@umbus.fritz.box>
 <20191024082854.1ea22701@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mejza3ZMMA5Za1mX"
Content-Disposition: inline
In-Reply-To: <20191024082854.1ea22701@bahia.lan>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mejza3ZMMA5Za1mX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 08:28:54AM +0200, Greg Kurz wrote:
> On Thu, 24 Oct 2019 09:38:17 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Oct 23, 2019 at 09:17:40PM +0200, Greg Kurz wrote:
> > > We must not call spapr_drc_detach() on a detached DRC otherwise bad t=
hings
> > > can happen, ie. QEMU hangs or crashes. This is easily demonstrated wi=
th
> > > a CPU hotplug/unplug loop using QMP.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> >=20
> > Ouch, good catch.  Applied.
> >=20
> > I wonder if we have the same problem with other DRC types.
> >=20
>=20
> We don't have it with PHB and PCI types, through the same use of
> spapr_drc_unplug_requested().
>=20
> LMBs see to avoid it by failing device_del early if an unplug
> request is already in progress:
>=20
>     /*
>      * An existing pending dimm state for this DIMM means that there is an
>      * unplug operation in progress, waiting for the spapr_lmb_release
>      * callback to complete the job (BQL can't cover that far). In this c=
ase,
>      * bail out to avoid detaching DRCs that were already released.
>      */
>     if (spapr_pending_dimm_unplugs_find(spapr, dimm)) {
>         error_setg(&local_err,
>                    "Memory unplug already in progress for device %s",
>                    dev->id);
>         goto out;
>     }
>=20
> Not sure why we error out in this case instead of ignoring the unplug=20
> request.

I suspect no particularly good reason, just history.  Everything's a
bit  different with LMBs because a single device_del will usually
remove a whole bunch of LMB DRCs.  In general the interfacing between
the qemu user side DIMM handling and the PAPR side LMB/DRC handling
is... pretty clunky.

>=20
> > > ---
> > >  hw/ppc/spapr.c |    7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index f9410d390a07..94f9d27096af 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -3741,9 +3741,10 @@ void spapr_core_unplug_request(HotplugHandler =
*hotplug_dev, DeviceState *dev,
> > >                            spapr_vcpu_id(spapr, cc->core_id));
> > >      g_assert(drc);
> > > =20
> > > -    spapr_drc_detach(drc);
> > > -
> > > -    spapr_hotplug_req_remove_by_index(drc);
> > > +    if (!spapr_drc_unplug_requested(drc)) {
> > > +        spapr_drc_detach(drc);
> > > +        spapr_hotplug_req_remove_by_index(drc);
> > > +    }
> > >  }
> > > =20
> > >  int spapr_core_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
> > >=20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mejza3ZMMA5Za1mX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl23aZYACgkQbDjKyiDZ
s5JIJA//YA0r1FSoShJjleW4Edoesul6YIBddSIPkV8v2mLJ4sJJV0QKjkVhk5ry
Dogu3mkFDD3vu/PlscsrFqh60Ak4X9wUM5hUMlG9RWDaPu9w95EXPOOvDRjxfEsv
X6lgRPMshqywOft78NsiQBrQXfO3znAHtjhqmOUQPi1feWOuXKeCugD9O8SJa03b
1LXjJoqHuK0v3KqJfFNhyVxJ4nVBh6XgTLVvTEH+vX2iuMwsxDe6pvE4ajMnAKe2
UdTeoPB4R8dIIf5URrTfgkYBGfC4XLFANEwQ/7gN1o0HAOaUkUxoB3EsZPC6Ki3I
qz5YI9eDmB82WTTr5G89n6h9wZ/4ZmDQS4b0MJwV4+KAUhSH4f4hUv9FZ3BHDPRc
HeioiQMOXVvmcEnXN3tB0hDCuglM0Upfck8fV6TSM8aZA3MuXVnVaqnTnnw8J2ZS
zgfeeY87naoAw324gTOvyHD76umgiXt1z4pP1+vqCnH8CL3JCpnf2UwlvTGGS9Ij
WAZ5UGmbRa+JpeyGRyIMnK2nSI8yCe9ocNfGexFYK6uYo6qyULR6slr0qRwniFkr
qKHjtUKp+naJPaJIG0imupT99pR0RRhKAu9tQpwYOiaEbUUORHYVaRuXL4b8M3Gw
9RswuWqEdhkM4k+lPn3tCn1ctWCIsuPK+BGTTtIgd6N6huiwjMA=
=ivax
-----END PGP SIGNATURE-----

--mejza3ZMMA5Za1mX--

