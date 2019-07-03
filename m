Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2014C06513
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 13:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8461D2187F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 13:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="o8TZD2/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8461D2187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hifHj-0007zT-Rl
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 09:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39647)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hifGP-0006XF-AF
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 09:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hifGN-0002iH-17
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 09:25:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41919 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hifGK-0002d2-LS; Wed, 03 Jul 2019 09:25:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45f20h4Vcnz9sQq; Wed,  3 Jul 2019 23:25:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562160324;
 bh=AL042cX4QM6+sAXKH0xw0j9V5S7zrXc3jFdfINhufDM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o8TZD2/halFxXeD7RSoTwwhz1XoJ1titmT7gTKK1oP4OH08P1bI3K1S1dqGNWc8hD
 eLc5F8xDK862NX2VTwbNiMh6BaDowze/SH5K75a9yKwnCXUtcKyuH+6MNCrI/lzCYA
 MHCYSQlzeoSfeXYnXRYE03wwsxqoy3Xok04m/RLM=
Date: Wed, 3 Jul 2019 16:39:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190703063915.GM9442@umbus.fritz.box>
References: <20190327204102.20925-1-maxiwell@linux.ibm.com>
 <20190328142151.7b0e00dd@bahia.lab.toulouse-stg.fr.ibm.com>
 <20190328183923.lcd3p6fpy4qvvxoo@maxibm>
 <20190329132951.451d4ef0@bahia.lan>
 <20190408042149.GH16627@umbus.fritz.box>
 <20190408183156.1f71c21d@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oYAXToTM8kn9Ra/9"
Content-Disposition: inline
In-Reply-To: <20190408183156.1f71c21d@bahia.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v7 0/2] spapr-rtas: add ibm,
 get-vpd RTAS interface
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oYAXToTM8kn9Ra/9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 06:31:56PM +0200, Greg Kurz wrote:
> On Mon, 8 Apr 2019 14:21:50 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Mar 29, 2019 at 01:29:51PM +0100, Greg Kurz wrote:
> > > On Thu, 28 Mar 2019 15:39:45 -0300
> > > "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
> > >  =20
> > > > Hi,
> > > >=20
> > > > On Thu, Mar 28, 2019 at 02:21:51PM +0100, Greg Kurz wrote: =20
> > > > > On Wed, 27 Mar 2019 17:41:00 -0300
> > > > > "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
> > > > >    =20
> > > > > > Here are two patches to add a handler for ibm,get-vpd RTAS call=
s.
> > > > > > This RTAS exposes host information in case of set QEMU options
> > > > > > 'host-serial' and 'host-model' as 'passthrough'.
> > > > > >=20
> > > > > > The patch 1 creates helper functions to get valid 'host-serial'
> > > > > > and 'host-model' parameters, guided by QEMU command line. These
> > > > > > parameters are useful to build the guest device tree and to ret=
urn
> > > > > > get-vpd RTAS calls. The patch 2 adds the ibm,get-vpd itself.
> > > > > >=20
> > > > > > Update v7:
> > > > > > * rtas_get_vpd_fields as a static array in spapr machine state
> > > > > >=20
> > > > > > Maxiwell S. Garcia (2):
> > > > > >   spapr: helper functions to get valid host fields
> > > > > >   spapr-rtas: add ibm,get-vpd RTAS interface
> > > > > >=20
> > > > > >  hw/ppc/spapr.c         | 48 +++++++++++----------
> > > > > >  hw/ppc/spapr_rtas.c    | 96 ++++++++++++++++++++++++++++++++++=
++++++++
> > > > > >  include/hw/ppc/spapr.h | 14 +++++-
> > > > > >  3 files changed, 135 insertions(+), 23 deletions(-)
> > > > > >    =20
> > > > >=20
> > > > > Hi Maxiwell,
> > > > >=20
> > > > > David sent a patch to rework how the host data is exposed to the =
guest.
> > > > > Especially, the special casing of the "none" and "passthrough" st=
rings
> > > > > is no more... I'm afraid you'll have to rework your patches accor=
dingly:
> > > > > code+changelog in patch 1 and at least changelog in patch 2.
> > > > >=20
> > > > > Cheers,   =20
> > > >=20
> > > > IIUC, the 'ibm,get-vpd' RTAS should return information about the
> > > > platform/cabinet. Thus, it's not necessary to add new nodes in the =
guest
> > > > device tree to export information like that. =20
> > >=20
> > > I agree that these "host-model" and "host-serial" props, which aren't
> > > described anywhere and not used by either the linux kernel or the
> > > powerpc-utils, look like a QEMU-specific poor man's version of VPD.
> > >=20
> > > Not quite sure why they were even created since this is the purpose
> > > of "system-id" and "model" as explained in PAPR, and supposedly
> > > exposed in /proc/ppc64/lparcfg according to the LPARCFG(5) manual
> > > page: =20
> >=20
> > Yeah, I'm not sure why they were created either.  I rather suspect
> > nothing much is using them, and I'd kind of like to just kill them.
> > But Daniel Berrange (and maybe others) are paranoid about this
> > breaking things.
>=20
> Speaking of that. The "host-model"/"host-serial" fix is associated to a
> CVE which affects QEMU versions currently shipped by downstream vendors.
> Isn't a good enough reason to break things in existing unsecure setups ?
> Should we add this patch to Mike's patch round-up for stable 3.0.1 (and
> therefore break something that used to _work_ with 3.0.0) ?

I would say yes, but I can't really be bothered arguing it upstream.

> > >        serial_number
> > >        The serial number of the physical system in which the partitio=
n resides
> > >=20
> > >        system_type
> > >        The  machine,type-model  of  the physical system in which the =
partition
> > >        resides
> > >=20
> > > This is indeed what we get in a PowerVM LPAR running on a tuleta syst=
em:
> > >=20
> > > [root@furax1 ~]# head -3 /proc/ppc64/lparcfg=20
> > > lparcfg 1.9
> > > serial_number=3DIBM,032116A9A
> > > system_type=3DIBM,8247-22L
> > >=20
> > > [root@furax1 ~]# echo $(cat /proc/device-tree/system-id)
> > > IBM,032116A9A
> > > [root@furax1 ~]# echo $(cat /proc/device-tree/model)
> > > IBM,8247-22L
> > >=20
> > > But QEMU generates a hard coded "IBM pSeries (emulated by qemu)" mode=
l,
> > > which is clearly not PAPR compliant according to this requirement:
> > >=20
> > > 	R1=E2=80=9312.2=E2=80=9313. There must be a property, =E2=80=9Cmodel=
=E2=80=9D, under the root node
> > > 	in the format, =E2=80=9C<vendor>,xxxx-yyy=E2=80=9D, where <vendor> i=
s replaced by
> > > 	one to five letters representing the stock symbol of the company
> > > 	(for example, for IBM: =E2=80=9CIBM,xxxx-yyy=E2=80=9D), and where xx=
xx-yyy is
> > > 	derived from the VPD TM field (see Table 160=E2=80=9A =E2=80=9CLoPAP=
R VPD Fields=E2=80=9A=E2=80=9D
> > > 	on page 343) of the first or =E2=80=98marked=E2=80=99 processor encl=
osure.
> > >=20
> > > And worse, it mixes "vm,uuid" which is QEMU specific concept to uniqu=
ely
> > > identify guests, with "system-id" which is about the host :-\ =20
> >=20
> > Ugh, right.  So, it's been this way for years, so it's clearly not
> > breaking things in practice.  Given that, it might be best to leave
> > it, even though it violates PAPR technically.
> >=20
> > Frankly, providing information about the *guest* virtual model and
> > "serial number" =3D~=3D UUID makes more sense than providing information
> > about the host that might be security sensitive.
> >=20
>=20
> IIUC, the rationale of exposing to the guest something that uniquely
> identifies the host is needed by some inventory or license validation
> softwares [1]. So I'd say we need both a guest UUID, that doesn't change
> during the VM lifetime, and host UUID that changes when migrating to
> another host.

Well, maybe.  We can supply the anonymized host identifier through
/etc/machine-id (already used by Openstack on x86), and I guess we can
present it to the guest via this get-vpd interface.  Heaven knows what
to do about caching / notifications, since in the qemu model (unlike
the PAPR / pHyp model) the guest is not aware of migrations.
>=20
> The fact that "system-id" =3D=3D "vm,uuid" in the current code didn't
> break anything would rather indicate that there are no inventory
> or license validation softwares users yet in the KVM+PAPR+linux
> ecosystem...

Well, maybe.

> [1] https://bugs.launchpad.net/nova/+bug/1337349/comments/6
>=20
> > > All of this is very confusing and need to be sorted out before buildi=
ng
> > > anything on top of it. Especially since "model" and "system-id" are
> > > supposed to derive from VPD IIUC.
> > >=20
> > > I guess that we should first decide what we really want to expose
> > > in "system-id" and "model": what we have now ? the same as in
> > > "host-serial" and "host-model", ie. user configurable ? Must we
> > > stay compatible with existing setups ? In any case, I'm afraid that
> > > we have to diverge from PAPR somehow, since it obviously doesn't
> > > care about the security concerns that motivated recent changes
> > > for "host-serial" and "host-model"... =20
> >=20
> > We absolutely should not expose the real host information without the
> > user explicitly requesting it.
>=20
> I agree, but it seems that we may need something in between: an ID that
> uniquely identifies a given system but that doesn't reveal security
> sensitive information.
>=20
> Looking again at PAPR, nothing much is said on the format of "system-id"
> or VPD SN. Only "model" is expected to follow some formatting rules:
> <vendor>,xxxx-yyy.
>=20
> For "system-id", this could be addressed pretty much like in OpenStack
> with systemd's /etc/machine-id. For "model", I'm not sure...

Right, but do license systems need the model as well?  I can't see why
they would.

> > > > Since it's a POWER specific
> > > > functionality, may 'ibm,get-vpd' export host information if the
> > > > guest instance allows it? Or is it better return only the 'host-ser=
ial'
> > > > and 'host-model' content, like in the patch "spapr: Simplify handli=
ng
> > > > of host-serial and host-model values"?
> > > >  =20
> > >=20
> > > I've spent some time reading PAPR on this topic and I'm not sure that
> > > "ibm,get-vpd" is the way to go for what you were trying to achieve
> > > initially (ie, obtain up-to-date host model and serial after migratio=
n).
> > >=20
> > > Have you looked at RTAS "ibm,update-properties" ?
> > >=20
> > > 	7.4.8 ibm,update-properties RTAS Call
> > >=20
> > > 	This RTAS call is used to report updates to the properties changed
> > > 	due to a massive platform reconfiguration such as when the partition
> > > 	is migrated between machines. =20
> >=20
> > Yeah.. the thing here is that partition migration kind of means
> > something different in PAPR than it does in the qemu world.  It uses a
> > guest-aware model of migration (which frankly I think is broken
> > verging on unworkable).  qemu and uses a guest-(mostly)-unaware
> > migration model.
>=20
> Yeah...
>=20
> > > This explicitly covers updates to "system-id" and "model". Maybe it is
> > > time to do as Ben was suggesting a long time ago when "host-serial"
> > > and "host-model" were introduced [1]:
> > >=20
> > > 	On Tue, 2014-07-08 at 12:49 +0200, Alexander Graf wrote: =20
> > > 	> Please be aware that all of the above is bogus when you start
> > > 	> thinking=20
> > > 	> about live migration. =20
> > >=20
> > > 	What's probably where we need to start thinking about implementing
> > > 	migration according to PAPR :-)
> > >=20
> > > 	IE. With pre and post-migration notifications to the guest including
> > > 	device-tree updates.
> > >=20
> > >=20
> > > [1] https://patchwork.ozlabs.org/patch/367792/#813547
> > >  =20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oYAXToTM8kn9Ra/9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0cTZEACgkQbDjKyiDZ
s5INFA//YWbzdyYTjlDbv8DsN94SbY5nxRRwkiP+NhIo2ggs5es34adYj93+nKIe
Lrz2e7U8En7L3rBJxjjKJo/xOromt2dd6aa4KJbSunRfU5w3dwLdXdOaqM/4iAgQ
cOl+3IYaLQZeytiheaHVbRXEzeCCNHFgXovv1b8PGEAxiEER9ePgzu/cwgPqqCU1
oMobpDRCUzZoVFIZX+HXwVP+Ehi0tNXPyU1A+Jy7bCVRJGGge+OhDlbg1i72Akbn
DTAyjkj8brZnl7D+soauMRx24of+fY1ea1fQxc3/q7nWVUyIPBiBHJAF6+NECboX
L14/AA8t0gFlTrZIIY28P4+5AnWEzwvXC6h4i2oWaapON3bVs/xyiPiG4qqU0EIn
9PvJylB1y/CE4eZTNWejTsCE+lLWf+T1ZGqcbcVTxUgPHQKYHYiJOnVrpoDskdTt
kx0gOsygBuXteX5beAIaHY2jof8YlHfLrlDdHG/U6/ZeO3S0MKW09XRZ5cAW4rBJ
buIuBVckszrZY1TE6yatuNOWMTBAoVuCwfhxoy9+uM4BqgJES0u2283ULoZTa5wE
zB02sFmqFiAIpMA1OUezoxCmSZOe6+hFC7mUzR00bNRBCEtmxC+4BzymZ7jiNw2y
RYZkaKc0WcgfqtAUBJcaX9Z2UYwDhCaaBTOyQbCFQqHmx8iGn6g=
=10ox
-----END PGP SIGNATURE-----

--oYAXToTM8kn9Ra/9--

