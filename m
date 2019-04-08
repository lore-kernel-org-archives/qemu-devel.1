Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCCEC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36DBF2147A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DBF2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55982 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDXD5-00048p-FP
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 12:33:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hDXBy-0003o1-KA
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hDXBv-0003Vk-JO
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:32:18 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:39718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hDXBt-0003Hq-Li
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:32:15 -0400
Received: from player739.ha.ovh.net (unknown [10.109.143.189])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id B4F41124FD7
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 18:32:03 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player739.ha.ovh.net (Postfix) with ESMTPSA id 28BFF4AA8890;
	Mon,  8 Apr 2019 16:31:57 +0000 (UTC)
Date: Mon, 8 Apr 2019 18:31:56 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190408183156.1f71c21d@bahia.lan>
In-Reply-To: <20190408042149.GH16627@umbus.fritz.box>
References: <20190327204102.20925-1-maxiwell@linux.ibm.com>
	<20190328142151.7b0e00dd@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190328183923.lcd3p6fpy4qvvxoo@maxibm>
	<20190329132951.451d4ef0@bahia.lan>
	<20190408042149.GH16627@umbus.fritz.box>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/hS/cLmIl4Mdm32v_ElMfPXG";
	protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 8611726915692829158
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudefgddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.140
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
	"Maxiwell S. Garcia" <maxiwell@linux.ibm.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408163156.3oJi2KBnLU2e0RIn06gWmCapp6_tdIwsXLv12JZqrOo@z>

--Sig_/hS/cLmIl4Mdm32v_ElMfPXG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Apr 2019 14:21:50 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Mar 29, 2019 at 01:29:51PM +0100, Greg Kurz wrote:
> > On Thu, 28 Mar 2019 15:39:45 -0300
> > "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
> >  =20
> > > Hi,
> > >=20
> > > On Thu, Mar 28, 2019 at 02:21:51PM +0100, Greg Kurz wrote: =20
> > > > On Wed, 27 Mar 2019 17:41:00 -0300
> > > > "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
> > > >    =20
> > > > > Here are two patches to add a handler for ibm,get-vpd RTAS calls.
> > > > > This RTAS exposes host information in case of set QEMU options
> > > > > 'host-serial' and 'host-model' as 'passthrough'.
> > > > >=20
> > > > > The patch 1 creates helper functions to get valid 'host-serial'
> > > > > and 'host-model' parameters, guided by QEMU command line. These
> > > > > parameters are useful to build the guest device tree and to return
> > > > > get-vpd RTAS calls. The patch 2 adds the ibm,get-vpd itself.
> > > > >=20
> > > > > Update v7:
> > > > > * rtas_get_vpd_fields as a static array in spapr machine state
> > > > >=20
> > > > > Maxiwell S. Garcia (2):
> > > > >   spapr: helper functions to get valid host fields
> > > > >   spapr-rtas: add ibm,get-vpd RTAS interface
> > > > >=20
> > > > >  hw/ppc/spapr.c         | 48 +++++++++++----------
> > > > >  hw/ppc/spapr_rtas.c    | 96 ++++++++++++++++++++++++++++++++++++=
++++++
> > > > >  include/hw/ppc/spapr.h | 14 +++++-
> > > > >  3 files changed, 135 insertions(+), 23 deletions(-)
> > > > >    =20
> > > >=20
> > > > Hi Maxiwell,
> > > >=20
> > > > David sent a patch to rework how the host data is exposed to the gu=
est.
> > > > Especially, the special casing of the "none" and "passthrough" stri=
ngs
> > > > is no more... I'm afraid you'll have to rework your patches accordi=
ngly:
> > > > code+changelog in patch 1 and at least changelog in patch 2.
> > > >=20
> > > > Cheers,   =20
> > >=20
> > > IIUC, the 'ibm,get-vpd' RTAS should return information about the
> > > platform/cabinet. Thus, it's not necessary to add new nodes in the gu=
est
> > > device tree to export information like that. =20
> >=20
> > I agree that these "host-model" and "host-serial" props, which aren't
> > described anywhere and not used by either the linux kernel or the
> > powerpc-utils, look like a QEMU-specific poor man's version of VPD.
> >=20
> > Not quite sure why they were even created since this is the purpose
> > of "system-id" and "model" as explained in PAPR, and supposedly
> > exposed in /proc/ppc64/lparcfg according to the LPARCFG(5) manual
> > page: =20
>=20
> Yeah, I'm not sure why they were created either.  I rather suspect
> nothing much is using them, and I'd kind of like to just kill them.
> But Daniel Berrange (and maybe others) are paranoid about this
> breaking things.
>=20

Speaking of that. The "host-model"/"host-serial" fix is associated to a
CVE which affects QEMU versions currently shipped by downstream vendors.
Isn't a good enough reason to break things in existing unsecure setups ?
Should we add this patch to Mike's patch round-up for stable 3.0.1 (and
therefore break something that used to _work_ with 3.0.0) ?

> >=20
> >        serial_number
> >        The serial number of the physical system in which the partition =
resides
> >=20
> >        system_type
> >        The  machine,type-model  of  the physical system in which the pa=
rtition
> >        resides
> >=20
> > This is indeed what we get in a PowerVM LPAR running on a tuleta system:
> >=20
> > [root@furax1 ~]# head -3 /proc/ppc64/lparcfg=20
> > lparcfg 1.9
> > serial_number=3DIBM,032116A9A
> > system_type=3DIBM,8247-22L
> >=20
> > [root@furax1 ~]# echo $(cat /proc/device-tree/system-id)
> > IBM,032116A9A
> > [root@furax1 ~]# echo $(cat /proc/device-tree/model)
> > IBM,8247-22L
> >=20
> > But QEMU generates a hard coded "IBM pSeries (emulated by qemu)" model,
> > which is clearly not PAPR compliant according to this requirement:
> >=20
> > 	R1=E2=80=9312.2=E2=80=9313. There must be a property, =E2=80=9Cmodel=
=E2=80=9D, under the root node
> > 	in the format, =E2=80=9C<vendor>,xxxx-yyy=E2=80=9D, where <vendor> is =
replaced by
> > 	one to five letters representing the stock symbol of the company
> > 	(for example, for IBM: =E2=80=9CIBM,xxxx-yyy=E2=80=9D), and where xxxx=
-yyy is
> > 	derived from the VPD TM field (see Table 160=E2=80=9A =E2=80=9CLoPAPR =
VPD Fields=E2=80=9A=E2=80=9D
> > 	on page 343) of the first or =E2=80=98marked=E2=80=99 processor enclos=
ure.
> >=20
> > And worse, it mixes "vm,uuid" which is QEMU specific concept to uniquely
> > identify guests, with "system-id" which is about the host :-\ =20
>=20
> Ugh, right.  So, it's been this way for years, so it's clearly not
> breaking things in practice.  Given that, it might be best to leave
> it, even though it violates PAPR technically.
>=20
> Frankly, providing information about the *guest* virtual model and
> "serial number" =3D~=3D UUID makes more sense than providing information
> about the host that might be security sensitive.
>=20

IIUC, the rationale of exposing to the guest something that uniquely
identifies the host is needed by some inventory or license validation
softwares [1]. So I'd say we need both a guest UUID, that doesn't change
during the VM lifetime, and host UUID that changes when migrating to
another host.

The fact that "system-id" =3D=3D "vm,uuid" in the current code didn't
break anything would rather indicate that there are no inventory
or license validation softwares users yet in the KVM+PAPR+linux
ecosystem...

[1] https://bugs.launchpad.net/nova/+bug/1337349/comments/6

> > All of this is very confusing and need to be sorted out before building
> > anything on top of it. Especially since "model" and "system-id" are
> > supposed to derive from VPD IIUC.
> >=20
> > I guess that we should first decide what we really want to expose
> > in "system-id" and "model": what we have now ? the same as in
> > "host-serial" and "host-model", ie. user configurable ? Must we
> > stay compatible with existing setups ? In any case, I'm afraid that
> > we have to diverge from PAPR somehow, since it obviously doesn't
> > care about the security concerns that motivated recent changes
> > for "host-serial" and "host-model"... =20
>=20
> We absolutely should not expose the real host information without the
> user explicitly requesting it.
>=20

I agree, but it seems that we may need something in between: an ID that
uniquely identifies a given system but that doesn't reveal security
sensitive information.

Looking again at PAPR, nothing much is said on the format of "system-id"
or VPD SN. Only "model" is expected to follow some formatting rules:
<vendor>,xxxx-yyy.

For "system-id", this could be addressed pretty much like in OpenStack
with systemd's /etc/machine-id. For "model", I'm not sure...

> > > Since it's a POWER specific
> > > functionality, may 'ibm,get-vpd' export host information if the
> > > guest instance allows it? Or is it better return only the 'host-seria=
l'
> > > and 'host-model' content, like in the patch "spapr: Simplify handling
> > > of host-serial and host-model values"?
> > >  =20
> >=20
> > I've spent some time reading PAPR on this topic and I'm not sure that
> > "ibm,get-vpd" is the way to go for what you were trying to achieve
> > initially (ie, obtain up-to-date host model and serial after migration).
> >=20
> > Have you looked at RTAS "ibm,update-properties" ?
> >=20
> > 	7.4.8 ibm,update-properties RTAS Call
> >=20
> > 	This RTAS call is used to report updates to the properties changed
> > 	due to a massive platform reconfiguration such as when the partition
> > 	is migrated between machines. =20
>=20
> Yeah.. the thing here is that partition migration kind of means
> something different in PAPR than it does in the qemu world.  It uses a
> guest-aware model of migration (which frankly I think is broken
> verging on unworkable).  qemu and uses a guest-(mostly)-unaware
> migration model.
>=20

Yeah...

> > This explicitly covers updates to "system-id" and "model". Maybe it is
> > time to do as Ben was suggesting a long time ago when "host-serial"
> > and "host-model" were introduced [1]:
> >=20
> > 	On Tue, 2014-07-08 at 12:49 +0200, Alexander Graf wrote: =20
> > 	> Please be aware that all of the above is bogus when you start
> > 	> thinking=20
> > 	> about live migration. =20
> >=20
> > 	What's probably where we need to start thinking about implementing
> > 	migration according to PAPR :-)
> >=20
> > 	IE. With pre and post-migration notifications to the guest including
> > 	device-tree updates.
> >=20
> >=20
> > [1] https://patchwork.ozlabs.org/patch/367792/#813547
> >  =20
>=20


--Sig_/hS/cLmIl4Mdm32v_ElMfPXG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlyrd3wACgkQcdTV5YIv
c9ZeMg//TfWJ2alO1xg0YOrCnTzWYdsoBIksRlQGO2Ijaaxf+EYYsRvU2/tSq8/F
iEb8TVMDpaVroTWwfkurg2Y+n3Ht/DTQVpDd/c6b+1LewGd5pFoTJx5I9B3xqWW7
8bJDHPRMUJN1opshB0cj5tq+M+h7d1Y13W1cSe3+aF6FFVCCoz2lrw0AB+mAOsWp
EzY6sxFKZMpzGSLJuVUVjBCz1Y+1d+J5zMMs+N2D6DnTPbYlxBVWtIxgUYNUmDCq
UmXBw9I4qqLtYroVS6p2gNxr7jVWShDkEnJ89vzL4yLTiAXCgHzHQatU/463yIsc
ll9p9DJfLKyF5f5EQAMslCWFBRKyPtul/sbU+kQlktxEn2uF2y13937+AKZ2uSj6
enoMJBQyzpskuD3CU0i5nTMsnN7+UB1ZqvEA8gid/1V3IJ3iD7kju+C0fZaI5qDT
ztt+mZejqfBKvqB8+R4eL5JPDNXVTTnXOHSea7YNm8FuyDsQ/07DyjIxiOA7NI/x
6pz6TTfqrWRrxV4nAxLIaRTOgBWoj576CVIzM5XF8FD7mjdZHMzVmf1toCHI7L6/
oIaBnk0JxJJVkrNqrBTquwABvAIx+MyqAbsg2iZxAJrLf6dvxV6H2mQ2ymlqdwQU
/DpovmHn8Ne0wiRXp6IRDIF4xTpMcDp9XO6wH291OWi74GrcRzw=
=EExp
-----END PGP SIGNATURE-----

--Sig_/hS/cLmIl4Mdm32v_ElMfPXG--

