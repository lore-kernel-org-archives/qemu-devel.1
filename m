Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E609C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 04:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C2620880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 04:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZpG/mJPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C2620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47236 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDM1U-0001Gz-CJ
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 00:36:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDLuT-0004T8-Vt
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 00:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDLuR-0007eg-Ts
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 00:29:29 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:38631 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hDLuQ-0007c8-BE; Mon, 08 Apr 2019 00:29:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44cy9g59qQz9sRk; Mon,  8 Apr 2019 14:29:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1554697751;
	bh=QQAnoD5WhYIaUjxip7Sr+G4lrs5RCG0psHKCCvPf0QI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZpG/mJPxQ+rD+WOHuOSRD/81JrJkTgFxzRPqgpeA/X2/oX6GjZ/pseMog0RVbfx/E
	kkrV5ODnipf/tqQnu66RKeBBTTsQRWrMsPPMtwRuyXo4OvPm7/7pGj8BHcyFw1fMbw
	fksV8HmPnmRTmg+gtBAh1mOURQpm/o0vBNwGBS90=
Date: Mon, 8 Apr 2019 14:21:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190408042149.GH16627@umbus.fritz.box>
References: <20190327204102.20925-1-maxiwell@linux.ibm.com>
	<20190328142151.7b0e00dd@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190328183923.lcd3p6fpy4qvvxoo@maxibm>
	<20190329132951.451d4ef0@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1EKig6ypoSyM7jaD"
Content-Disposition: inline
In-Reply-To: <20190329132951.451d4ef0@bahia.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v7 0/2] spapr-rtas: add ibm,
 get-vpd RTAS interface
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	"Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408042150.4zZMv-3FJqEJubpBeCSWtg7Vi9EB9x4qi_jpBOFeJK8@z>


--1EKig6ypoSyM7jaD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2019 at 01:29:51PM +0100, Greg Kurz wrote:
> On Thu, 28 Mar 2019 15:39:45 -0300
> "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
>=20
> > Hi,
> >=20
> > On Thu, Mar 28, 2019 at 02:21:51PM +0100, Greg Kurz wrote:
> > > On Wed, 27 Mar 2019 17:41:00 -0300
> > > "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
> > >  =20
> > > > Here are two patches to add a handler for ibm,get-vpd RTAS calls.
> > > > This RTAS exposes host information in case of set QEMU options
> > > > 'host-serial' and 'host-model' as 'passthrough'.
> > > >=20
> > > > The patch 1 creates helper functions to get valid 'host-serial'
> > > > and 'host-model' parameters, guided by QEMU command line. These
> > > > parameters are useful to build the guest device tree and to return
> > > > get-vpd RTAS calls. The patch 2 adds the ibm,get-vpd itself.
> > > >=20
> > > > Update v7:
> > > > * rtas_get_vpd_fields as a static array in spapr machine state
> > > >=20
> > > > Maxiwell S. Garcia (2):
> > > >   spapr: helper functions to get valid host fields
> > > >   spapr-rtas: add ibm,get-vpd RTAS interface
> > > >=20
> > > >  hw/ppc/spapr.c         | 48 +++++++++++----------
> > > >  hw/ppc/spapr_rtas.c    | 96 ++++++++++++++++++++++++++++++++++++++=
++++
> > > >  include/hw/ppc/spapr.h | 14 +++++-
> > > >  3 files changed, 135 insertions(+), 23 deletions(-)
> > > >  =20
> > >=20
> > > Hi Maxiwell,
> > >=20
> > > David sent a patch to rework how the host data is exposed to the gues=
t.
> > > Especially, the special casing of the "none" and "passthrough" strings
> > > is no more... I'm afraid you'll have to rework your patches according=
ly:
> > > code+changelog in patch 1 and at least changelog in patch 2.
> > >=20
> > > Cheers, =20
> >=20
> > IIUC, the 'ibm,get-vpd' RTAS should return information about the
> > platform/cabinet. Thus, it's not necessary to add new nodes in the guest
> > device tree to export information like that.
>=20
> I agree that these "host-model" and "host-serial" props, which aren't
> described anywhere and not used by either the linux kernel or the
> powerpc-utils, look like a QEMU-specific poor man's version of VPD.
>=20
> Not quite sure why they were even created since this is the purpose
> of "system-id" and "model" as explained in PAPR, and supposedly
> exposed in /proc/ppc64/lparcfg according to the LPARCFG(5) manual
> page:

Yeah, I'm not sure why they were created either.  I rather suspect
nothing much is using them, and I'd kind of like to just kill them.
But Daniel Berrange (and maybe others) are paranoid about this
breaking things.

>=20
>        serial_number
>        The serial number of the physical system in which the partition re=
sides
>=20
>        system_type
>        The  machine,type-model  of  the physical system in which the part=
ition
>        resides
>=20
> This is indeed what we get in a PowerVM LPAR running on a tuleta system:
>=20
> [root@furax1 ~]# head -3 /proc/ppc64/lparcfg=20
> lparcfg 1.9
> serial_number=3DIBM,032116A9A
> system_type=3DIBM,8247-22L
>=20
> [root@furax1 ~]# echo $(cat /proc/device-tree/system-id)
> IBM,032116A9A
> [root@furax1 ~]# echo $(cat /proc/device-tree/model)
> IBM,8247-22L
>=20
> But QEMU generates a hard coded "IBM pSeries (emulated by qemu)" model,
> which is clearly not PAPR compliant according to this requirement:
>=20
> 	R1=E2=80=9312.2=E2=80=9313. There must be a property, =E2=80=9Cmodel=E2=
=80=9D, under the root node
> 	in the format, =E2=80=9C<vendor>,xxxx-yyy=E2=80=9D, where <vendor> is re=
placed by
> 	one to five letters representing the stock symbol of the company
> 	(for example, for IBM: =E2=80=9CIBM,xxxx-yyy=E2=80=9D), and where xxxx-y=
yy is
> 	derived from the VPD TM field (see Table 160=E2=80=9A =E2=80=9CLoPAPR VP=
D Fields=E2=80=9A=E2=80=9D
> 	on page 343) of the first or =E2=80=98marked=E2=80=99 processor enclosur=
e.
>=20
> And worse, it mixes "vm,uuid" which is QEMU specific concept to uniquely
> identify guests, with "system-id" which is about the host :-\

Ugh, right.  So, it's been this way for years, so it's clearly not
breaking things in practice.  Given that, it might be best to leave
it, even though it violates PAPR technically.

Frankly, providing information about the *guest* virtual model and
"serial number" =3D~=3D UUID makes more sense than providing information
about the host that might be security sensitive.

> All of this is very confusing and need to be sorted out before building
> anything on top of it. Especially since "model" and "system-id" are
> supposed to derive from VPD IIUC.
>=20
> I guess that we should first decide what we really want to expose
> in "system-id" and "model": what we have now ? the same as in
> "host-serial" and "host-model", ie. user configurable ? Must we
> stay compatible with existing setups ? In any case, I'm afraid that
> we have to diverge from PAPR somehow, since it obviously doesn't
> care about the security concerns that motivated recent changes
> for "host-serial" and "host-model"...

We absolutely should not expose the real host information without the
user explicitly requesting it.

> > Since it's a POWER specific
> > functionality, may 'ibm,get-vpd' export host information if the
> > guest instance allows it? Or is it better return only the 'host-serial'
> > and 'host-model' content, like in the patch "spapr: Simplify handling
> > of host-serial and host-model values"?
> >=20
>=20
> I've spent some time reading PAPR on this topic and I'm not sure that
> "ibm,get-vpd" is the way to go for what you were trying to achieve
> initially (ie, obtain up-to-date host model and serial after migration).
>=20
> Have you looked at RTAS "ibm,update-properties" ?
>=20
> 	7.4.8 ibm,update-properties RTAS Call
>=20
> 	This RTAS call is used to report updates to the properties changed
> 	due to a massive platform reconfiguration such as when the partition
> 	is migrated between machines.

Yeah.. the thing here is that partition migration kind of means
something different in PAPR than it does in the qemu world.  It uses a
guest-aware model of migration (which frankly I think is broken
verging on unworkable).  qemu and uses a guest-(mostly)-unaware
migration model.

> This explicitly covers updates to "system-id" and "model". Maybe it is
> time to do as Ben was suggesting a long time ago when "host-serial"
> and "host-model" were introduced [1]:
>=20
> 	On Tue, 2014-07-08 at 12:49 +0200, Alexander Graf wrote:
> 	> Please be aware that all of the above is bogus when you start
> 	> thinking=20
> 	> about live migration.
>=20
> 	What's probably where we need to start thinking about implementing
> 	migration according to PAPR :-)
>=20
> 	IE. With pre and post-migration notifications to the guest including
> 	device-tree updates.
>=20
>=20
> [1] https://patchwork.ozlabs.org/patch/367792/#813547
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1EKig6ypoSyM7jaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyqzFsACgkQbDjKyiDZ
s5JvkBAAlDMtfmKRKO/YNYnBxHbItPVD0bXd7W50pKiCHOQ086qX06alqGvuW4Pc
zzQhBLLR71TQkWq6t9+91RFyjappuQWNBWI6cW3z9pFgBliKU5UmtqL2ctiH2z4Y
BTtpYSg4cuFV7zrdW5CBPKCRTJDzG6A8nTEbbZSuh3/+clo0F9QUyN4hqWMMiQkF
CkwwSLkSmf7Df8YyNd6i/wOIA6Knb0++MrTXQx6bJUWv0atrCEm3HF+rSxGImAPo
5hXHi8BtXIcqtuQxFUSccyR8FeoaZ3T5/gTG9fDbBFjuS74zx2FMU1FvCqEm8f/T
NxJV970e1y5sB7hb0LCrff1MUu5kpNuICPPCNez1PtixuKtYE/xW1yXNeuseH61o
qUNoJGbH3gXCshc2+c5ZTOiLA4HN/lmt0D8tKhzN241SOPOLtMXRfnBibQmmUPNF
Fiz+BfEQg4b6HlZz3YMhuDXGY2lqXbhCSVOyoryn/1HCDZEZx7wFdvRGMPO7tj95
3WBxB35BVcVSSUsVNW3Trp3o/eAqBFvNDT+N25iej60Kdb0aRz3USf8ZRFeKSrM0
hGGDTRwf3mNb454YDRYRIV1zaw9dOyaLQRZgrKdpZOnYaknP+NpsppUqskm7fPIC
P2makN8d7Uiw+V029MHBtPyvs7lCLNgtuYwwa+bJp4kBk+1WCW8=
=DRUO
-----END PGP SIGNATURE-----

--1EKig6ypoSyM7jaD--

