Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6666AC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 04:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C9920880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 04:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AwM/p8uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C9920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDLzF-0007uN-ED
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 00:34:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDLuR-0004R5-V6
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 00:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDLuP-0007cg-4G
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 00:29:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41313 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hDLuO-0007aN-CZ; Mon, 08 Apr 2019 00:29:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44cy9g3hPQz9sRd; Mon,  8 Apr 2019 14:29:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1554697751;
	bh=Ha+QzzFX2tKzmLo/vSOZgCLrAcAX6q48OXpsBGIc520=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwM/p8uyR5iDBrXLK1oHnn1EgfxPPHNsOsp55AmsYGa9Asr5o2LvYZDyPDv9Yys9o
	q55OMqugxRStxQE2ayyvNXshhGhX588eDSFbJEAW0DPjCBiRxX1SU98ZkahPSVyyaH
	zuIfOZzShU66PJbu7lU57ZQEaf1X0Fa5Yma1ey20=
Date: Mon, 8 Apr 2019 14:27:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190408042747.GI16627@umbus.fritz.box>
References: <20190327204102.20925-1-maxiwell@linux.ibm.com>
	<20190328142151.7b0e00dd@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190328183923.lcd3p6fpy4qvvxoo@maxibm>
	<20190329132951.451d4ef0@bahia.lan>
	<20190401145858.lw7v3xt7fqanp6nc@maxibm>
	<20190402122807.1a141e37@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/8E7gjuj425jZz9t"
Content-Disposition: inline
In-Reply-To: <20190402122807.1a141e37@bahia.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
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
	Andrea Bolognani <abologna@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408042747.XHvJ9c2vj_eMXxPn85Ym71K0g5ztonDdOhgESPPGz14@z>


--/8E7gjuj425jZz9t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 12:28:07PM +0200, Greg Kurz wrote:
> On Mon, 1 Apr 2019 12:01:48 -0300
> "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
>=20
> > Hi Greg,
> >=20
> > Thanks for your review. I added some comments below...
> >=20
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
> > > page:
> > >=20
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
> > > identify guests, with "system-id" which is about the host :-\
> > >=20
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
> > > for "host-serial" and "host-model"...
> > >  =20
> >=20
> > Many important changes should be done to solve these inconsistencies.
> > So, I saw in the 'get-vpd' RTAS a manner to return host information
> > and that works with live-migration.
> >=20
>=20
> Yes it does indeed allow that, among other things. My concern is more that
> PAPR clearly indicates that the "system-id" and "model" in the root node
> are derived from the VPD, and this series is about to tie the VPD TM and
> VPD SE keywords to something else that isn't documented in PAPR...
>=20
> The more I look at the "host-serial" and "host-model" properties, the more
> I have the impression that they serve the same purpose as "system-id" and
> "model" in PAPR (at least when peeking into the device tree of a PowerVM
> LPAR as shown somewhere ^^)... what about unifying these ? It would likely
> impact some guest software that use this to guess the platform type, like
> powerpc-utils for example:
>=20
> 		} else if (strstr(line, "IBM pSeries (emulated by qemu)")) {
> 			rc =3D PLATFORM_POWERKVM_GUEST;
> 			break;
> 		} else if (strstr(line, "pSeries")) {
>=20
> but this is fragile and should be improved anyway...
>=20
> > >  =20
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
> > > Have you looked at RTAS "ibm,update-properties" ? =20
> >=20
> > >=20
> > > 	7.4.8 ibm,update-properties RTAS Call
> > >=20
> > > 	This RTAS call is used to report updates to the properties changed
> > > 	due to a massive platform reconfiguration such as when the partition
> > > 	is migrated between machines.
> > >=20
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
> > >=20
> >=20
> > The 'ibm,update-properties' and 'ibm,update-nodes' RTAS report which DT
> > nodes was modified. So, to implement this approach, the QEMU should cha=
nge
> > the DT nodes when the live-migration finish and some service in the gue=
st
> > need to call these RTAS to discovery what nodes was changed. Is it the
> > right way?
> >=20
>=20
> If QEMU on the target is started with different "host-serial" and
> "host-model", the DT in QEMU already has the new value. No need to
> change anything. Appart from that, yes, QEMU should generate a PRRN
> event at post load to notify the guest, which in turns do the RTAS
> calls to get the updates.

Hrm.  The way the DT is handled between qemu, SLOF and the guest
would, I suspect, make ibm,update-properties a serious PITA to
implement.  So, I'm not super keen on that idea.

More generally, I'm not sure merging concepts from PAPR's guest-aware
migration model into qemu's guest-unaware migration model is a great
idea.

> > Assuming that in new pseries machine won't be possible choose
> > 'passthrough' options to 'host-serial' and 'host-model' (last patch of
> > dgibson about this), it's necessary get the host information and set it
> > as string in these options. So, if we use the same qemu options in a
> > live-migration scenario for src and dst (libvirt do that), these
> > properties will remain the same. Is this behavior expected?
> >=20
>=20
> The recent fixes around "host-serial" and "host-model" simply moved
> the decision to expose host data to the upper layer, ie. libvirt
> which should be involved in this discussion.

Right, that's deliberate.  Note that roughly-equivalent information on
x86 is currently supplied via the SMBIOS.  OpenStack Nova sets that,
rather than qemu, and I'd like to move towards a common configuration
model with x86, though it's a fairly long path to there.

OpenStack had an equivalent security problem to our one, which it
addressed by taking the host serial from /etc/machine-id if present
rather than the real host info.

> Cc'ing Andrea for expertise. Problem exposed below.
>=20
> The pseries machine used to expose the content of the host's
> /proc/device-tree/system-id and /proc/device-tree/model in the guest
> DT. This led to a CVE and QEMU doesn't do that anymore for new machine
> types. Instead, two new properties where added to the pseries machine:
>=20
> pseries-4.0.host-serial=3Dstring (Host serial number to advertise in gues=
t device tree)
> pseries-4.0.host-model=3Dstring (Host model to advertise in guest device =
tree)
>=20
> It is up to the caller to pass something... which may be anything,
> including something like $(cat /proc/device-tree/system-id) or
> randomly generated.
>=20
> Is there a chance libvirt can be taught to pass a different string
> to the target QEMU in case of migration ?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/8E7gjuj425jZz9t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyqzcMACgkQbDjKyiDZ
s5K58RAAgAVfnT3j6Tbhe6MH+79sPnEhNYMiHx9ZPgChhZYCRnf9DZmPfqkvrrbE
8wr1rsYNjZebHn9UDXChGkszeMowFqvwH3/ucycIya8BpNCe6d0MZylrKTjy49b8
/f+tuaCoUHOyI2mO2sudXyIQfWE1aJ/dZ4AYmKzoWm4mNuwQki9A4tZvpH9Ja3RJ
sIXzktzKkv4qphLwXqMiFwjNWNC3aKOz1dvdSh0L2+VeODtY2umoiP0cQsif2BPA
8i15lt3Js2OyKaBPqoZQtjiTls8/SFdhuw/vAbJbxAXyeH4XeVuF9G5QnsbIzqtQ
7TYdFwDEwkq3PkEf1uCOy+oLeJ1ZH+JGaJV2dAKlkfYC3silkBXcAUVFcEn08rzx
CCsXY0uaMo6YOTQ36JPeWCeezmALbxgcFsZekEV/VT2k1HKToehARGw4d5co2dq+
POZgdcZYRplRAgp6XQDJ2bBsvfnkHmgC9dTtCSTSbOfvkuqTjmfiu2xWpiATq0q8
OkHo9xtaCQQFr6sTGZTlZIbrmqN/MtA2DiUocbm3HFrAZAlqAQVo6/L7A/OnFgYm
4ellNQw/gQs6NLXmNDiS4y2n3LiO4+VvMqhmPlKVuFm8jBI0p8Ltn28vOxpUot/B
LOGYK8Ipwc0iNF4xDG+jTH15RvPmtakmGyIBK2BlNEEByXyyh0w=
=DY80
-----END PGP SIGNATURE-----

--/8E7gjuj425jZz9t--

