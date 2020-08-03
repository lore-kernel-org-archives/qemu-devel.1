Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A5CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0BD2076C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0BD2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2YzB-0006Fc-Ji
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 07:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k2YyC-0005an-Vo
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:49:32 -0400
Received: from 20.mo6.mail-out.ovh.net ([178.32.124.17]:44726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k2Yy9-00008X-Bc
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:49:32 -0400
Received: from player762.ha.ovh.net (unknown [10.110.115.229])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 51C0622147C
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 13:49:26 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player762.ha.ovh.net (Postfix) with ESMTPSA id 7322314F171A6;
 Mon,  3 Aug 2020 11:49:18 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006a1f9041f-cae2-4022-a9ea-7df28ade4ddf,
 57B3F75294BC4E66139B8C02EFC2580628949457) smtp.auth=groug@kaod.org
Date: Mon, 3 Aug 2020 13:49:17 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/1] docs: adding NUMA documentation for pseries
Message-ID: <20200803134917.48c5e7a5@bahia.lan>
In-Reply-To: <20200730005852.GN84173@umbus.fritz.box>
References: <20200729125756.224846-1-danielhb413@gmail.com>
 <20200730005852.GN84173@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OGPikRKvrlzx1A3md2IF_Xt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 17997791488818584038
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrjeeggdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgefgkeduvddutdfgkeekjeelgeejffehudeuhfeltdetfedthffftdfggeeihfdvnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.32.124.17; envelope-from=groug@kaod.org;
 helo=20.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 07:49:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/OGPikRKvrlzx1A3md2IF_Xt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Jul 2020 10:58:52 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jul 29, 2020 at 09:57:56AM -0300, Daniel Henrique Barboza wrote:
> > This patch adds a new documentation file, ppc-spapr-numa.rst,
> > informing what developers and user can expect of the NUMA distance
> > support for the pseries machine, up to QEMU 5.1.
> >=20
> > In the (hopefully soon) future, when we rework the NUMA mechanics
> > of the pseries machine to at least attempt to contemplate user
> > choice, this doc will be extended to inform about the new
> > support.
> >=20
> > Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>=20
> Applied to ppc-for-5.2, thanks.
>=20

I'm now hitting this:

Warning, treated as error:
docs/specs/ppc-spapr-numa.rst:document isn't included in any toctree

> > ---
> >  docs/specs/ppc-spapr-numa.rst | 191 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 191 insertions(+)
> >  create mode 100644 docs/specs/ppc-spapr-numa.rst
> >=20
> > diff --git a/docs/specs/ppc-spapr-numa.rst b/docs/specs/ppc-spapr-numa.=
rst
> > new file mode 100644
> > index 0000000000..e762038022
> > --- /dev/null
> > +++ b/docs/specs/ppc-spapr-numa.rst
> > @@ -0,0 +1,191 @@
> > +
> > +NUMA mechanics for sPAPR (pseries machines)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +NUMA in sPAPR works different than the System Locality Distance
> > +Information Table (SLIT) in ACPI. The logic is explained in the LOPAPR
> > +1.1 chapter 15, "Non Uniform Memory Access (NUMA) Option". This
> > +document aims to complement this specification, providing details
> > +of the elements that impacts how QEMU views NUMA in pseries.
> > +
> > +Associativity and ibm,associativity property
> > +--------------------------------------------
> > +
> > +Associativity is defined as a group of platform resources that has
> > +similar mean performance (or in our context here, distance) relative to
> > +everyone else outside of the group.
> > +
> > +The format of the ibm,associativity property varies with the value of
> > +bit 0 of byte 5 of the ibm,architecture-vec-5 property. The format with
> > +bit 0 equal to zero is deprecated. The current format, with the bit 0
> > +with the value of one, makes ibm,associativity property represent the
> > +physical hierarchy of the platform, as one or more lists that starts
> > +with the highest level grouping up to the smallest. Considering the
> > +following topology:
> > +
> > +::
> > +
> > +    Mem M1 ---- Proc P1    |
> > +    -----------------      | Socket S1  ---|
> > +          chip C1          |               |
> > +                                           | HW module 1 (MOD1)
> > +    Mem M2 ---- Proc P2    |               |
> > +    -----------------      | Socket S2  ---|
> > +          chip C2          |
> > +
> > +The ibm,associativity property for the processors would be:
> > +
> > +* P1: {MOD1, S1, C1, P1}
> > +* P2: {MOD1, S2, C2, P2}
> > +
> > +Each allocable resource has an ibm,associativity property. The LOPAPR
> > +specification allows multiple lists to be present in this property,
> > +considering that the same resource can have multiple connections to the
> > +platform.
> > +
> > +Relative Performance Distance and ibm,associativity-reference-points
> > +--------------------------------------------------------------------
> > +
> > +The ibm,associativity-reference-points property is an array that is us=
ed
> > +to define the relevant performance/distance  related boundaries, defin=
ing
> > +the NUMA levels for the platform.
> > +
> > +The definition of its elements also varies with the value of bit 0 of =
byte 5
> > +of the ibm,architecture-vec-5 property. The format with bit 0 equal to=
 zero
> > +is also deprecated. With the current format, each integer of the
> > +ibm,associativity-reference-points represents an 1 based ordinal index=
 (i.e.
> > +the first element is 1) of the ibm,associativity array. The first
> > +boundary is the most significant to application performance, followed =
by
> > +less significant boundaries. Allocated resources that belongs to the
> > +same performance boundaries are expected to have relative NUMA distance
> > +that matches the relevancy of the boundary itself. Resources that belo=
ngs
> > +to the same first boundary will have the shortest distance from each
> > +other. Subsequent boundaries represents greater distances and degraded
> > +performance.
> > +
> > +Using the previous example, the following setting reference points def=
ines
> > +three NUMA levels:
> > +
> > +* ibm,associativity-reference-points =3D {0x3, 0x2, 0x1}
> > +
> > +The first NUMA level (0x3) is interpreted as the third element of each
> > +ibm,associativity array, the second level is the second element and
> > +the third level is the first element. Let's also consider that elements
> > +belonging to the first NUMA level have distance equal to 10 from each
> > +other, and each NUMA level doubles the distance from the previous. This
> > +means that the second would be 20 and the third level 40. For the P1 a=
nd
> > +P2 processors, we would have the following NUMA levels:
> > +
> > +::
> > +
> > +  * ibm,associativity-reference-points =3D {0x3, 0x2, 0x1}
> > +
> > +  * P1: associativity{MOD1, S1, C1, P1}
> > +
> > +  First NUMA level (0x3) =3D> associativity[2] =3D C1
> > +  Second NUMA level (0x2) =3D> associativity[1] =3D S1
> > +  Third NUMA level (0x1) =3D> associativity[0] =3D MOD1
> > +
> > +  * P2: associativity{MOD1, S2, C2, P2}
> > +
> > +  First NUMA level (0x3) =3D> associativity[2] =3D C2
> > +  Second NUMA level (0x2) =3D> associativity[1] =3D S2
> > +  Third NUMA level (0x1) =3D> associativity[0] =3D MOD1
> > +
> > +  P1 and P2 have the same third NUMA level, MOD1: Distance between the=
m =3D 40
> > +
> > +Changing the ibm,associativity-reference-points array changes the perf=
ormance
> > +distance attributes for the same associativity arrays, as the following
> > +example illustrates:
> > +
> > +::
> > +
> > +  * ibm,associativity-reference-points =3D {0x2}
> > +
> > +  * P1: associativity{MOD1, S1, C1, P1}
> > +
> > +  First NUMA level (0x2) =3D> associativity[1] =3D S1
> > +
> > +  * P2: associativity{MOD1, S2, C2, P2}
> > +
> > +  First NUMA level (0x2) =3D> associativity[1] =3D S2
> > +
> > +  P1 and P2 does not have a common performance boundary. Since this is=
 a one level
> > +  NUMA configuration, distance between them is one boundary above the =
first
> > +  level, 20.
> > +
> > +
> > +In a hypothetical platform where all resources inside the same hardwar=
e module
> > +is considered to be on the same performance boundary:
> > +
> > +::
> > +
> > +  * ibm,associativity-reference-points =3D {0x1}
> > +
> > +  * P1: associativity{MOD1, S1, C1, P1}
> > +
> > +  First NUMA level (0x1) =3D> associativity[0] =3D MOD0
> > +
> > +  * P2: associativity{MOD1, S2, C2, P2}
> > +
> > +  First NUMA level (0x1) =3D> associativity[0] =3D MOD0
> > +
> > +  P1 and P2 belongs to the same first order boundary. The distance bet=
ween then
> > +  is 10.
> > +
> > +
> > +How the pseries Linux guest calculates NUMA distances
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > +
> > +Another key difference between ACPI SLIT and the LOPAPR regarding NUMA=
 is
> > +how the distances are expressed. The SLIT table provides the NUMA dist=
ance
> > +value between the relevant resources. LOPAPR does not provide a standa=
rd
> > +way to calculate it. We have the ibm,associativity for each resource, =
which
> > +provides a common-performance hierarchy,  and the ibm,associativity-re=
ference-points
> > +array that tells which level of associativity is considered to be rele=
vant
> > +or not.
> > +
> > +The result is that each OS is free to implement and to interpret the d=
istance
> > +as it sees fit. For the pseries Linux guest, each level of NUMA duplic=
ates
> > +the distance of the previous level, and the maximum amount of levels is
> > +limited to MAX_DISTANCE_REF_POINTS =3D 4 (from arch/powerpc/mm/numa.c =
in the
> > +kernel tree). This results in the following distances:
> > +
> > +* both resources in the first NUMA level: 10
> > +* resources one NUMA level apart: 20
> > +* resources two NUMA levels apart: 40
> > +* resources three NUMA levels apart: 80
> > +* resources four NUMA levels apart: 160
> > +
> > +
> > +Consequences for QEMU NUMA tuning
> > +---------------------------------
> > +
> > +The way the pseries Linux guest calculates NUMA distances has a direct=
 effect
> > +on what QEMU users can expect when doing NUMA tuning. As of QEMU 5.1, =
this is
> > +the default ibm,associativity-reference-points being used in the pseri=
es
> > +machine:
> > +
> > +ibm,associativity-reference-points =3D {0x4, 0x4, 0x2}
> > +
> > +The first and second level are equal, 0x4, and a third one was added in
> > +commit a6030d7e0b35 exclusively for NVLink GPUs support. This means th=
at
> > +regardless of how the ibm,associativity properties are being created in
> > +the device tree, the pseries Linux guest will only recognize three sce=
narios
> > +as far as NUMA distance goes:
> > +
> > +* if the resources belongs to the same first NUMA level =3D 10
> > +* second level is skipped since it's equal to the first
> > +* all resources that aren't a NVLink GPU, it is guaranteed that they w=
ill belong
> > +  to the same third NUMA level, having distance =3D 40
> > +* for NVLink GPUs, distance =3D 80 from everything else
> > +
> > +In short, we can summarize the NUMA distances seem in pseries Linux gu=
ests, using
> > +QEMU up to 5.1, as follows:
> > +
> > +* local distance, i.e. the distance of the resource to its own NUMA no=
de: 10
> > +* if it's a NVLink GPU device, distance: 80
> > +* every other resource, distance: 40
> > +
> > +This also means that user input in QEMU command line does not change t=
he
> > +NUMA distancing inside the guest for the pseries machine.
>=20


--Sig_/OGPikRKvrlzx1A3md2IF_Xt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl8n+b0ACgkQcdTV5YIv
c9aK6xAAor3i6eOb72Iy/vmBmO3MLW0gcabgTAhGaJl2xuHtG7XBi9v+8LYTy3/P
xejuLYZSFr1i3a7p0wxWf1IisIvYQArkyx+AY/P1AOFFjcIIhELuze67W5jpp6Pj
EUwcsbPDgeLb2Jbqc5QJWuh8Uiuj+wSjav5a/YPTKFysD0FBySxF47KYr71MWLnT
+QGOINbnCfwKHheEA3N1uzeaj2jM581zrb1mqiFOl1TVjsDEVxJdAaebp5JTMzkI
h3QRgeZat3AH5xsSUgT8suWdNnuFtZS7qq8fGghKaDAhj+CbD6k+77QZvQgiOsuw
7UBY6W4e2Su/2TcO10Zhs5ZfTayv4B/JanaB9V074KayFYyf4i2c5CY9jselZd8r
GFd/EfVXWJfgo7S+zWMbhxeIBQ0+wPPdugtbaw+vI96RRXQYzu8e2JJKc12MZGku
ui8g8yBoY2xGhF/3lbL5hZ+saNyY6ot6w48YqoZkyNV5dVFImBk/Uq2kSnILBKf6
MKW95VmhRoUJdWYLcw0Blle44Jw8uwooleyUc0HE8TtC3eX68bbfN5nDLRZ+MT6X
aRfdhDCgwcVuu5i9z5LTSi9VBoYMgI4RGEgto62mTdECqT6C6o31Ag8tMlWL6NYg
SVNIuQutRQOPIynjEbbBTVyKzScbg0GbU/Bjg67Dh2vOeOprfas=
=fuNG
-----END PGP SIGNATURE-----

--Sig_/OGPikRKvrlzx1A3md2IF_Xt--

