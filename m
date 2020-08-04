Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B45EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2773A22C9F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cddrCz4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2773A22C9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2u9f-0004jH-8C
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k2u8a-0003nG-NJ; Tue, 04 Aug 2020 06:25:40 -0400
Received: from ozlabs.org ([203.11.71.1]:55951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k2u8W-0000jy-RB; Tue, 04 Aug 2020 06:25:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BLW9K5yzQz9sTH; Tue,  4 Aug 2020 20:25:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1596536725;
 bh=EimDIT5LvWScAqM93OgtR67oBXtvUWt9nlJvoygSTo8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cddrCz4XmLX7DBnGjiA7VdzYeeuC5mTUjrQGQVHkLjx/IUYYBpWluq2mxmGfU3GXe
 wVp6R2Il3rn7508vSKlr7RDjiNHq2r46L1aoxAUa5aqmFKeuqgIOAtu3HkPJenwKI/
 ntEU9tKXiasVGGw+/QDZd7qE9TekbKu/G53zsWM4=
Date: Tue, 4 Aug 2020 20:16:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 1/1] docs: adding NUMA documentation for pseries
Message-ID: <20200804101636.GA2178@yekko.fritz.box>
References: <20200803133440.825276-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20200803133440.825276-1-danielhb413@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 06:25:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2020 at 10:34:40AM -0300, Daniel Henrique Barboza wrote:
> This patch adds a new documentation file, ppc-spapr-numa.rst,
> informing what developers and user can expect of the NUMA distance
> support for the pseries machine, up to QEMU 5.1.
>=20
> In the (hopefully soon) future, when we rework the NUMA mechanics
> of the pseries machine to at least attempt to contemplate user
> choice, this doc will be extended to inform about the new
> support.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>=20
> Changes in v2:
> - added 'index.rst' entry to fix a build error
>=20
>  docs/specs/index.rst          |   1 +
>  docs/specs/ppc-spapr-numa.rst | 191 ++++++++++++++++++++++++++++++++++
>  2 files changed, 192 insertions(+)
>  create mode 100644 docs/specs/ppc-spapr-numa.rst

Applied to ppc-for-5.2, replacing the old version, thanks

>=20
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 426632a475..1b0eb979d5 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -12,6 +12,7 @@ Contents:
> =20
>     ppc-xive
>     ppc-spapr-xive
> +   ppc-spapr-numa
>     acpi_hw_reduced_hotplug
>     tpm
>     acpi_hest_ghes
> diff --git a/docs/specs/ppc-spapr-numa.rst b/docs/specs/ppc-spapr-numa.rst
> new file mode 100644
> index 0000000000..e762038022
> --- /dev/null
> +++ b/docs/specs/ppc-spapr-numa.rst
> @@ -0,0 +1,191 @@
> +
> +NUMA mechanics for sPAPR (pseries machines)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NUMA in sPAPR works different than the System Locality Distance
> +Information Table (SLIT) in ACPI. The logic is explained in the LOPAPR
> +1.1 chapter 15, "Non Uniform Memory Access (NUMA) Option". This
> +document aims to complement this specification, providing details
> +of the elements that impacts how QEMU views NUMA in pseries.
> +
> +Associativity and ibm,associativity property
> +--------------------------------------------
> +
> +Associativity is defined as a group of platform resources that has
> +similar mean performance (or in our context here, distance) relative to
> +everyone else outside of the group.
> +
> +The format of the ibm,associativity property varies with the value of
> +bit 0 of byte 5 of the ibm,architecture-vec-5 property. The format with
> +bit 0 equal to zero is deprecated. The current format, with the bit 0
> +with the value of one, makes ibm,associativity property represent the
> +physical hierarchy of the platform, as one or more lists that starts
> +with the highest level grouping up to the smallest. Considering the
> +following topology:
> +
> +::
> +
> +    Mem M1 ---- Proc P1    |
> +    -----------------      | Socket S1  ---|
> +          chip C1          |               |
> +                                           | HW module 1 (MOD1)
> +    Mem M2 ---- Proc P2    |               |
> +    -----------------      | Socket S2  ---|
> +          chip C2          |
> +
> +The ibm,associativity property for the processors would be:
> +
> +* P1: {MOD1, S1, C1, P1}
> +* P2: {MOD1, S2, C2, P2}
> +
> +Each allocable resource has an ibm,associativity property. The LOPAPR
> +specification allows multiple lists to be present in this property,
> +considering that the same resource can have multiple connections to the
> +platform.
> +
> +Relative Performance Distance and ibm,associativity-reference-points
> +--------------------------------------------------------------------
> +
> +The ibm,associativity-reference-points property is an array that is used
> +to define the relevant performance/distance  related boundaries, defining
> +the NUMA levels for the platform.
> +
> +The definition of its elements also varies with the value of bit 0 of by=
te 5
> +of the ibm,architecture-vec-5 property. The format with bit 0 equal to z=
ero
> +is also deprecated. With the current format, each integer of the
> +ibm,associativity-reference-points represents an 1 based ordinal index (=
i.e.
> +the first element is 1) of the ibm,associativity array. The first
> +boundary is the most significant to application performance, followed by
> +less significant boundaries. Allocated resources that belongs to the
> +same performance boundaries are expected to have relative NUMA distance
> +that matches the relevancy of the boundary itself. Resources that belongs
> +to the same first boundary will have the shortest distance from each
> +other. Subsequent boundaries represents greater distances and degraded
> +performance.
> +
> +Using the previous example, the following setting reference points defin=
es
> +three NUMA levels:
> +
> +* ibm,associativity-reference-points =3D {0x3, 0x2, 0x1}
> +
> +The first NUMA level (0x3) is interpreted as the third element of each
> +ibm,associativity array, the second level is the second element and
> +the third level is the first element. Let's also consider that elements
> +belonging to the first NUMA level have distance equal to 10 from each
> +other, and each NUMA level doubles the distance from the previous. This
> +means that the second would be 20 and the third level 40. For the P1 and
> +P2 processors, we would have the following NUMA levels:
> +
> +::
> +
> +  * ibm,associativity-reference-points =3D {0x3, 0x2, 0x1}
> +
> +  * P1: associativity{MOD1, S1, C1, P1}
> +
> +  First NUMA level (0x3) =3D> associativity[2] =3D C1
> +  Second NUMA level (0x2) =3D> associativity[1] =3D S1
> +  Third NUMA level (0x1) =3D> associativity[0] =3D MOD1
> +
> +  * P2: associativity{MOD1, S2, C2, P2}
> +
> +  First NUMA level (0x3) =3D> associativity[2] =3D C2
> +  Second NUMA level (0x2) =3D> associativity[1] =3D S2
> +  Third NUMA level (0x1) =3D> associativity[0] =3D MOD1
> +
> +  P1 and P2 have the same third NUMA level, MOD1: Distance between them =
=3D 40
> +
> +Changing the ibm,associativity-reference-points array changes the perfor=
mance
> +distance attributes for the same associativity arrays, as the following
> +example illustrates:
> +
> +::
> +
> +  * ibm,associativity-reference-points =3D {0x2}
> +
> +  * P1: associativity{MOD1, S1, C1, P1}
> +
> +  First NUMA level (0x2) =3D> associativity[1] =3D S1
> +
> +  * P2: associativity{MOD1, S2, C2, P2}
> +
> +  First NUMA level (0x2) =3D> associativity[1] =3D S2
> +
> +  P1 and P2 does not have a common performance boundary. Since this is a=
 one level
> +  NUMA configuration, distance between them is one boundary above the fi=
rst
> +  level, 20.
> +
> +
> +In a hypothetical platform where all resources inside the same hardware =
module
> +is considered to be on the same performance boundary:
> +
> +::
> +
> +  * ibm,associativity-reference-points =3D {0x1}
> +
> +  * P1: associativity{MOD1, S1, C1, P1}
> +
> +  First NUMA level (0x1) =3D> associativity[0] =3D MOD0
> +
> +  * P2: associativity{MOD1, S2, C2, P2}
> +
> +  First NUMA level (0x1) =3D> associativity[0] =3D MOD0
> +
> +  P1 and P2 belongs to the same first order boundary. The distance betwe=
en then
> +  is 10.
> +
> +
> +How the pseries Linux guest calculates NUMA distances
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +Another key difference between ACPI SLIT and the LOPAPR regarding NUMA is
> +how the distances are expressed. The SLIT table provides the NUMA distan=
ce
> +value between the relevant resources. LOPAPR does not provide a standard
> +way to calculate it. We have the ibm,associativity for each resource, wh=
ich
> +provides a common-performance hierarchy,  and the ibm,associativity-refe=
rence-points
> +array that tells which level of associativity is considered to be releva=
nt
> +or not.
> +
> +The result is that each OS is free to implement and to interpret the dis=
tance
> +as it sees fit. For the pseries Linux guest, each level of NUMA duplicat=
es
> +the distance of the previous level, and the maximum amount of levels is
> +limited to MAX_DISTANCE_REF_POINTS =3D 4 (from arch/powerpc/mm/numa.c in=
 the
> +kernel tree). This results in the following distances:
> +
> +* both resources in the first NUMA level: 10
> +* resources one NUMA level apart: 20
> +* resources two NUMA levels apart: 40
> +* resources three NUMA levels apart: 80
> +* resources four NUMA levels apart: 160
> +
> +
> +Consequences for QEMU NUMA tuning
> +---------------------------------
> +
> +The way the pseries Linux guest calculates NUMA distances has a direct e=
ffect
> +on what QEMU users can expect when doing NUMA tuning. As of QEMU 5.1, th=
is is
> +the default ibm,associativity-reference-points being used in the pseries
> +machine:
> +
> +ibm,associativity-reference-points =3D {0x4, 0x4, 0x2}
> +
> +The first and second level are equal, 0x4, and a third one was added in
> +commit a6030d7e0b35 exclusively for NVLink GPUs support. This means that
> +regardless of how the ibm,associativity properties are being created in
> +the device tree, the pseries Linux guest will only recognize three scena=
rios
> +as far as NUMA distance goes:
> +
> +* if the resources belongs to the same first NUMA level =3D 10
> +* second level is skipped since it's equal to the first
> +* all resources that aren't a NVLink GPU, it is guaranteed that they wil=
l belong
> +  to the same third NUMA level, having distance =3D 40
> +* for NVLink GPUs, distance =3D 80 from everything else
> +
> +In short, we can summarize the NUMA distances seem in pseries Linux gues=
ts, using
> +QEMU up to 5.1, as follows:
> +
> +* local distance, i.e. the distance of the resource to its own NUMA node=
: 10
> +* if it's a NVLink GPU device, distance: 80
> +* every other resource, distance: 40
> +
> +This also means that user input in QEMU command line does not change the
> +NUMA distancing inside the guest for the pseries machine.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8pNYEACgkQbDjKyiDZ
s5LbcA//VjaQadOlG+MtzDdrxMdHzwZ0T9qeTayTAiflu1z2OoCzs5Ti+pu2zdbp
Udgd0/f9S4FCsM7ipT6YE1cecI9aHSQMc41YkU957hqKAdKp1qemMBDgZA9B2osN
MZpeBUr/I9QSbOkM0jX7GNVS5POl0bMy6Mt2vE5BTx4h6xdB2iOsASvAywoRiRzD
G701um2qFhuJuC/w/Fy74RYgYvPGXKUdRzI28a9Q+cY+KYHOz4OsnneyDI32oPw9
nqHxy6ljkFtK8dPDjYhr0K9Lo7hQLkT0I3ryz+YeD/J1nM2Bfls4kMtoXG76nmsA
fxBw3Y2oQe78cecgNIKnSwWSPpcWGU2joUjrC2pPEpWzWZmXXuDL5u34KAxdulLC
CtBWUYGz9QyHWBq5Oin7HHsRxsFecG7Ng0t0WqajWqeeHigMEF9yYTEWmHghky0L
QXfgfiUPscLmSNMEMe4RrnOEt0vvWIERUDYXG4kPySzU1H1kZHBI+8s6oHeDAlWv
l0/r4VJ7+oB2J+6+WYS619Fks0wo1RqjpfL9wVuuT2yi8b4f6Py9vx0GTsbjdOA+
kKqHz65qD4GnBNzcNHAiaViayHI46NWI/8RzQxllv6m/atcLt8Bp2G8aURo+JKsA
yx3Tm414x+hwclquUu5cjh5b0RfBnZ+I0VJzv6j27ciDgvBkc4E=
=qXOv
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--

