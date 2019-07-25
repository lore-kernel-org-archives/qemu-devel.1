Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABC9C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74B3206BF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="C6Jp+4dP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74B3206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqugp-0004g9-BC
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 03:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37727)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hqufa-0000dM-1v
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hqufX-00054L-Hj
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:29:37 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60505)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hqufW-0004Ye-Qz; Fri, 26 Jul 2019 03:29:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45w11J1DyBz9s3l; Fri, 26 Jul 2019 17:29:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564126164;
 bh=gwdM3HACaL/zyCLDGufOukHRIgTremEbI+0AuvciFZ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C6Jp+4dP+KbIHM4VeNDXA2KZB3njktis2sDQD6VM/QM4Lae9uR7oQUws3VJGIsZ5B
 KcA5gt0YP5bKI1Gfk7QSnRSJZgCThm1EFC9dOMuaoWiTqZIiZ0RoapdvHTREEhvf0t
 hulBtfPfzoCYikOIRL6jgyoegHuyW5eYZEa4Y0l8=
Date: Thu, 25 Jul 2019 13:27:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190725032723.GB28601@umbus>
References: <20190722182347.25075-1-clg@kaod.org>
 <20190723013808.GJ25073@umbus.fritz.box>
 <177076c3-b418-fb52-74c9-ee98f5fe4694@kaod.org>
 <20190723063730.GT25073@umbus.fritz.box>
 <9dcb77c1-ff45-921a-6b98-6f1c3b67b89a@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <9dcb77c1-ff45-921a-6b98-6f1c3b67b89a@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Introduce PowerNV machines with
 fixed CPU models
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


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2019 at 11:32:00AM +0200, C=E9dric Le Goater wrote:
> On 23/07/2019 08:37, David Gibson wrote:
> > On Tue, Jul 23, 2019 at 08:00:27AM +0200, C=E9dric Le Goater wrote:
> >> On 23/07/2019 03:38, David Gibson wrote:
> >>> On Mon, Jul 22, 2019 at 08:23:47PM +0200, C=E9dric Le Goater wrote:
> >>>> Make the current "powernv" machine an abstract type and derive from =
it
> >>>> new machines with specific CPU models: power8, power8e, power8nvl,
> >>>> power9.
> >>>>
> >>>> The "powernv" machine is now an alias on the "powernv9" machine.
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>
> >>> Ah, sorry, I wasn't clear here.  I don't think we need a different
> >>> machine type for every cpu model, I just think we should have powernv8
> >>> and powernv9.  POWER8E and POWER8NVL don't significantly change the
> >>> system design (IIUC) so they can still be done with "-machine powernv8
> >>> -cpu POWER8E" or whatever.  I expect the same will be true for POWER9'
> >>> when that comes along
> >>
> >> I understand but I am afraid we will to have one machine per CPU famil=
y=20
> >> because POWER8E and POWER8NVL already have their own PnvChip :=20
> >>
> >>     DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8, pnv_chip_power8_class_=
init),
> >>     DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8E, pnv_chip_power8e_clas=
s_init),
> >>     DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8NVL,
> >>                           pnv_chip_power8nvl_class_init),
> >=20
> > Hrm.  Is there an actual reason we need different chip classes for
> > these? =20
> The POWER8 (8E, 8, 8NVL) chips differ by the core :=20
>=20
>     target/ppc/cpu-models.h:    CPU_POWERPC_POWER8E_BASE       =3D 0x004B=
0000,
>     target/ppc/cpu-models.h:    CPU_POWERPC_POWER8_BASE        =3D 0x004D=
0000,
>     target/ppc/cpu-models.h:    CPU_POWERPC_POWER8NVL_BASE     =3D 0x004C=
0000,
>=20
> The chip model is different :
>=20
>     k->chip_cfam_id =3D 0x221ef04980000000ull; /* P8 Murano DD2.1 */
>     k->chip_cfam_id =3D 0x220ea04980000000ull; /* P8 Venice DD2.0 */
>     k->chip_cfam_id =3D 0x120d304980000000ull; /* P8 Naples DD1.0 */
> =20
> The chiplets are different also. NVL has a NPU and a different LPC bus wh=
ich
> is modeled. There are different number of PHBs.

Ah, ok.  That seems like enough reason.

>=20
> > Even if there is, I don't see an inherent reason that implies separate
> > machine classes as well.=20
>=20
> I will see if we can have a single powernv8 machine.
>=20
> C.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl05IZsACgkQbDjKyiDZ
s5ICHw//UFch0CquR50qxhq9So+c2DHSUZOLXx63R2GTueMfU7Oe2arRv9Aldt/g
rK6ik6rrGadG9xZ+agc7K6JnsCorHgxJwPlc7r6jy1huJfBQ29mbHuw4KtxaUBkC
cBnrAG0KkQtzUg3QwH7TT20INIE0JXxaLVORZpEtpUm7yBrk/A2EYqdo8RXvu0ke
5OlApMig9khdCnKr/MtzB5iEDlE1VdNsm9pZl1qgGQUJ5zBNHz3qmc6tBGp+zqxx
nV0YJXxiOcq6vkMuJJErAZ5ZwXAW8Z1SBaTK4Bw2LlUB0I983vvKTKKnpi3VMIC3
VzOV/LuMk2IJPuuqNHBkABUwIJmaEG5YYjll/6gBu/BSkAjv5u6/QYB/u7uuyfZA
q029Lg0na6hTOFkIB1HyYn6n5mpzXxlE69Sr3s+s80uK4985xZzg89Hl8hj4JdkR
NNW4wjzyiQDtiVoRyQM6me6a++fvJT8McpxXvOvlhFCzbBxYexhQh4Qqs2m4o1gd
s9AbBa7mvEd99PBSat6q1Fmi2MPR7Wzpmlk/s7doLxYvy9guXg+S+FmVvmIbTwJJ
P8Jc5aB+/yPIOolLfMsQPbFO+Y8GMsI7VrymSTiljBsvzgaU8om/PWV1hzoaHBaL
MmKFAIquCq75jmyYa4J6u90M/CnPgaSa/WQ2x9V+q9vi4uAG/3I=
=ENMT
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--

