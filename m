Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD8FC4BA09
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 01:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46E020658
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 01:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="U7W4f28V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46E020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6lW2-0007sZ-TV
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 20:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j6lTy-0005WH-RV
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 20:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j6lTx-0001T0-9n
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 20:27:26 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45025 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j6lTw-0001Bj-3w; Tue, 25 Feb 2020 20:27:25 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48RypB45vnz9sRL; Wed, 26 Feb 2020 12:27:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582680434;
 bh=8Qohk+9qaIXKnyEK2pRyg7xqG6H2we1GtlSMr/JPWKM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U7W4f28VIoCX5K+Xmg8X67Oc+8Ls/beD/18UX5/wPzkj93J2zW3TOG7hiGZRO76zz
 Wyseg8cCnnW55LUtJRCuG+SMO8o4JtcVUTPXlzXlSia0dVD23tyWUYkjETdKaGbBWH
 7ziiYFmTQBja+xAf00V4OadhEdu5RtKF9ncqDcyg=
Date: Wed, 26 Feb 2020 12:08:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 17/18] spapr: Clean up RMA size calculation
Message-ID: <20200226010839.GI41629@umbus.fritz.box>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-18-david@gibson.dropbear.id.au>
 <bd9b356a-1b13-c322-33ec-49c31d1dd2e7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lqaZmxkhekPBfBzr"
Content-Disposition: inline
In-Reply-To: <bd9b356a-1b13-c322-33ec-49c31d1dd2e7@redhat.com>
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, groug@kaod.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lqaZmxkhekPBfBzr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2020 at 12:07:29PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 2/25/20 12:37 AM, David Gibson wrote:
> > Move the calculation of the Real Mode Area (RMA) size into a helper
> > function.  While we're there clean it up and correct it in a few ways:
> >    * Add comments making it clearer where the various constraints come =
=66rom
> >    * Remove a pointless check that the RMA fits within Node 0 (we've ju=
st
> >      clamped it so that it does)
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >   hw/ppc/spapr.c | 59 ++++++++++++++++++++++++++++++--------------------
> >   1 file changed, 35 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 6e9f15f64d..f0354b699d 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2648,6 +2648,40 @@ static PCIHostState *spapr_create_default_phb(vo=
id)
> >       return PCI_HOST_BRIDGE(dev);
> >   }
> > +static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
> > +{
> > +    MachineState *machine =3D MACHINE(spapr);
> > +    hwaddr rma_size =3D machine->ram_size;
> > +    hwaddr node0_size =3D spapr_node0_size(machine);
> > +
> > +    /* RMA has to fit in the first NUMA node */
> > +    rma_size =3D MIN(rma_size, node0_size);
> > +
> > +    /*
> > +     * VRMA access is via a special 1TiB SLB mapping, so the RMA can
> > +     * never exceed that
> > +     */
> > +    rma_size =3D MIN(rma_size, TiB);
>=20
> Can you use '1 * TiB'? It makes review obvious.

Done.

> > +
> > +    /*
> > +     * Clamp the RMA size based on machine type.  This is for
> > +     * migration compatibility with older qemu versions, which limited
> > +     * the RMA size for complicated and mostly bad reasons.
> > +     */
> > +    if (smc->rma_limit) {
> > +        spapr->rma_size =3D MIN(spapr->rma_size, smc->rma_limit);
> > +    }
> > +
> > +    if (rma_size < (MIN_RMA_SLOF * MiB)) {
>=20
> This looks old copy/paste before the change "spapr: Don't use weird units
> for MIN_RMA_SLOF".
>=20
> > +        error_setg(errp,
> > +"pSeries SLOF firmware requires >=3D %ldMiB guest RMA (Real Mode Area)=
",
> > +                   MIN_RMA_SLOF);
>=20
> Similarly, "MIN_RMA_SLOF / MiB"?

Ah, good catch.  I re-ordered the series at some point and forgot to
fix this up.

> > +        return -1;
>=20
> Maybe return 0 in case this function is called with errp !=3D
> &error_fatal.

Good idea.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lqaZmxkhekPBfBzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5VxRcACgkQbDjKyiDZ
s5KZew/+N6D4z/zg3EiIBsblaFVGhexG5zJJgC1pmzWtFdWw9cbNbSmLkk3Dw+wR
m/jk1nwf/fP/JKVNeWo5Mhqt6dU0GZSzI0k5flHmTt3+QeMXX/upF7enJUytNv6Y
cse8Y3oz9doTnUq+ir71XXCZ0qD2IVM7qTfz4cUOLwwNmVBnyaPmlHFalVLdDQ6W
soYGJzJ3vfquIUEdsbWb3FZxLDgQcaO8Ft/KSBl2n1n49Lxf4zVGlRk0s0aOvw44
cs0Xs/TBarQ+uOUBMSUvuZY0Pv8jK2W3lSTHPN0HI2RI9RYprGHgemP02kYq7q7t
I+eTvdU5Edg0lqbNnnPuQUKwbhN7+co5zRcB5vEe0NWNAvr34HPeKhRHk3egaLRU
zmvbhiaVURbgAPn8cDWlVFdLU9ZTaotOuvTdT/jJABi19eXUUi4ytjO4RCpVkfow
KMgIgwACXVHsupqhFSXgjvVRufg6LK018N9Cx4yqkGvFtJAk1T9XZ/1I6SF4WfiF
DcaSLbdW4RxPrBpFFHWLPMOx256cRlJT85zNt+HLjkDn7ThTt6yi76BTnmqxnUBv
kIp9NU7F1KqbO5pB00hMFVOk49wAuLvxlnZljJ3fPjMSiVUxuLsGFbmdE//yAGoX
d/sfgDfpisqH/Bi6YzZYjIwW6B+42BPNpoliKllY2PXpjOSnmOw=
=WjJU
-----END PGP SIGNATURE-----

--lqaZmxkhekPBfBzr--

