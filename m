Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E865C4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 22:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47FC920842
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 22:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ujwv+bya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FC920842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFnCU-00022r-VU
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 18:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFn9y-0000Ry-KB
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 18:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFn9x-0002mr-4R
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 18:31:50 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35903 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFn9w-0002kd-EU; Wed, 02 Oct 2019 18:31:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46k9q30lFjz9sPc; Thu,  3 Oct 2019 08:31:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570055503;
 bh=4fj+uPqyID/K5w+eTnKXXHjO5g1cBRFDsra3Y/WYnao=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ujwv+byadlPgl7BmSrqdMo6MEznG1A4HiIRLWmB3S+sNuZGZ/8ZKJjDodFw2mFwcj
 ghP7EOwhmWs67ScI2Ik5ByITVCd/edk7Tc5yAFsvHk5OYHt0WoIWDm4mjc6wC6Bcz2
 syep/TEVqbERR9fqYZUbnH553d6xCxkJHPJgRjSs=
Date: Thu, 3 Oct 2019 08:28:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 22/34] spapr, xics, xive: Move cpu_intc_create from
 SpaprIrq to SpaprInterruptController
Message-ID: <20191002222851.GA11105@umbus.fritz.box>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-23-david@gibson.dropbear.id.au>
 <360fd118-81c2-7ba1-2faf-d735d887d955@kaod.org>
 <3118503c-10a2-507a-46e5-da0847d7135e@kaod.org>
 <20191002064015.GY11105@umbus.fritz.box>
 <a6058ebc-9d52-ecf2-9b6f-2329bcbec550@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LG5jgFgJbJFFiAfj"
Content-Disposition: inline
In-Reply-To: <a6058ebc-9d52-ecf2-9b6f-2329bcbec550@kaod.org>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--LG5jgFgJbJFFiAfj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 09:31:08AM +0200, C=E9dric Le Goater wrote:
> On 02/10/2019 08:40, David Gibson wrote:
> > On Wed, Oct 02, 2019 at 08:13:55AM +0200, C=E9dric Le Goater wrote:
> >>>> @@ -527,6 +471,30 @@ static int spapr_irq_check(SpaprMachineState *s=
papr, Error **errp)
> >>>>  /*
> >>>>   * sPAPR IRQ frontend routines for devices
> >>>>   */
> >>>> +#define ALL_INTCS(spapr_) \
> >>>> +    { SPAPR_INTC((spapr_)->ics), SPAPR_INTC((spapr_)->xive), }
> >>>
> >>> I would have expected this array to be under the machine.
> >>>
> >>>> +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
> >>>> +                              PowerPCCPU *cpu, Error **errp)
> >>>> +{
> >>>> +    SpaprInterruptController *intcs[] =3D ALL_INTCS(spapr);
> >>>> +    int i;
> >>>> +    int rc;
> >>>> +
> >>>> +    for (i =3D 0; i < ARRAY_SIZE(intcs); i++) {
> >>>
> >>> but it would have been difficult to use ARRAY_SIZE. OK then.
> >>>
> >>>> +        SpaprInterruptController *intc =3D intcs[i];
> >>>> +        if (intc) {
> >>>
> >>> Is that test needed ?=20
> >>
> >> I understand now : spapr->ics and spapr->xive can be NULL.=20
> >>
> >> I think using a list would be better.
> >=20
> > Uh.. a list in what sense?
>=20
> an interrupt controller list under the machine.


Well

a) You're the one who suggested not dropping the ics and xive
individual pointers, which would be redundant with such a list.

b) A linked list for 2 entries seems overly complicated.

>=20
> when created, an interrupt controller would self register in that list.
>=20
> C.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LG5jgFgJbJFFiAfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2VJKEACgkQbDjKyiDZ
s5KDoRAA5ga9XDh9aAY5ZtK1NQWS/bi5VobpCIbIDFBFYWokJjUuvpJ/Z084Piw1
kqqYg4zsZC6GgIWRH3esE8AFl9UFpsmChe2DBp0mnFPAmagBs7yfToUlZPbHzwih
+o+b8UqLX/FL1AANCAuZDMybLj6R0jHjEidBsuju2XWDR7ZftfUtzNiP8mtXVQLT
mQIEMm0wGbRn7kAmlZ54f7R4oL9+g2k2rlGlCZaWciBYJH7K9qSW3X5ekYtj8esh
5Pj3eHQmQ2aLKSmcNJR6XOxKcZfQnKHaiCQJoINAnOtl2eYkXEoNyZQIBCDDWa3m
dLE9w0J8qp+A/YYYSUqhVv/InaLnh2I/TtmQOjs1AAPiGykuBNFoT6V8wq30amsA
l5wwW9H6YKEeun/DRfH659OQg+FBpsFWcK/L5gK9RACWKp6rKl9jYwdnFa4X50D8
TMmpop1Yz8Ot+XIjF7eRQiLI6R8C3wz/EuHaBkhwqCZxypGiLIvdBIhGIrwPggBi
u8HKUGooQiwWR4VC4sYoUSEnZI8K3giUfbbsIJyQ5ihoEWDeuQ+1sP/JbCQjdMz+
BjoNmfsx1zYDAFqVHRygLi0A7yXkdcvSK3bvLgzzhwkDg5ovRiBc3yVWLEKstqBC
sA/bEFRbXgL9yfmz7WIIZwfdz0nqEUuRMb8hdnTM57ls3vRUtiE=
=CPHE
-----END PGP SIGNATURE-----

--LG5jgFgJbJFFiAfj--

