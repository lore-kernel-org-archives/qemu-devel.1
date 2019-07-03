Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D71C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 13:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB01D218A4
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 13:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gzT45RSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB01D218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hifHl-00081t-70
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 09:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39637)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hifGP-0006XD-2q
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 09:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hifGN-0002ih-9f
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 09:25:32 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:42939 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hifGK-0002dC-Qx; Wed, 03 Jul 2019 09:25:31 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45f20j1VJjz9sR2; Wed,  3 Jul 2019 23:25:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562160325;
 bh=rzxuufNC/sZdNpeCZJczHcnTG8JQFq28B/bjmK2MFuc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gzT45RSWY5abQBFQm2suAozGfzonuOCOEhUlwmMleDLRWrFzR1lfVCYyz5Zlogx68
 9IBQlhf1uJ2XziTV/gZXkTIzdabNRdUNiZZjKZG5AfyBqwoJWOlB4n608p+XkPT/+r
 0koQVYSFqt2w4TOKHcTclADcjmO+QJ3N/XVxiC4g=
Date: Wed, 3 Jul 2019 16:49:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <20190703064905.GN9442@umbus.fritz.box>
References: <20190327204102.20925-1-maxiwell@linux.ibm.com>
 <20190328142151.7b0e00dd@bahia.lab.toulouse-stg.fr.ibm.com>
 <20190328183923.lcd3p6fpy4qvvxoo@maxibm>
 <20190329132951.451d4ef0@bahia.lan>
 <20190408042149.GH16627@umbus.fritz.box>
 <20190408183156.1f71c21d@bahia.lan>
 <155476288881.5793.5351161802797300445@sif>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A2x6GFCQWVc4i5ud"
Content-Disposition: inline
In-Reply-To: <155476288881.5793.5351161802797300445@sif>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--A2x6GFCQWVc4i5ud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 05:34:48PM -0500, Michael Roth wrote:
> Quoting Greg Kurz (2019-04-08 11:31:56)
> > On Mon, 8 Apr 2019 14:21:50 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Fri, Mar 29, 2019 at 01:29:51PM +0100, Greg Kurz wrote:
> > > > On Thu, 28 Mar 2019 15:39:45 -0300
> > > > "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
> > > >  =20
> > > > > Hi,
> > > > >=20
> > > > > On Thu, Mar 28, 2019 at 02:21:51PM +0100, Greg Kurz wrote: =20
> > > > > > On Wed, 27 Mar 2019 17:41:00 -0300
> > > > > > "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
> > > > > >    =20
> > > > > > > Here are two patches to add a handler for ibm,get-vpd RTAS ca=
lls.
> > > > > > > This RTAS exposes host information in case of set QEMU options
> > > > > > > 'host-serial' and 'host-model' as 'passthrough'.
> > > > > > >=20
> > > > > > > The patch 1 creates helper functions to get valid 'host-seria=
l'
> > > > > > > and 'host-model' parameters, guided by QEMU command line. The=
se
> > > > > > > parameters are useful to build the guest device tree and to r=
eturn
> > > > > > > get-vpd RTAS calls. The patch 2 adds the ibm,get-vpd itself.
> > > > > > >=20
> > > > > > > Update v7:
> > > > > > > * rtas_get_vpd_fields as a static array in spapr machine state
> > > > > > >=20
> > > > > > > Maxiwell S. Garcia (2):
> > > > > > >   spapr: helper functions to get valid host fields
> > > > > > >   spapr-rtas: add ibm,get-vpd RTAS interface
> > > > > > >=20
> > > > > > >  hw/ppc/spapr.c         | 48 +++++++++++----------
> > > > > > >  hw/ppc/spapr_rtas.c    | 96 ++++++++++++++++++++++++++++++++=
++++++++++
> > > > > > >  include/hw/ppc/spapr.h | 14 +++++-
> > > > > > >  3 files changed, 135 insertions(+), 23 deletions(-)
> > > > > > >    =20
> > > > > >=20
> > > > > > Hi Maxiwell,
> > > > > >=20
> > > > > > David sent a patch to rework how the host data is exposed to th=
e guest.
> > > > > > Especially, the special casing of the "none" and "passthrough" =
strings
> > > > > > is no more... I'm afraid you'll have to rework your patches acc=
ordingly:
> > > > > > code+changelog in patch 1 and at least changelog in patch 2.
> > > > > >=20
> > > > > > Cheers,   =20
> > > > >=20
> > > > > IIUC, the 'ibm,get-vpd' RTAS should return information about the
> > > > > platform/cabinet. Thus, it's not necessary to add new nodes in th=
e guest
> > > > > device tree to export information like that. =20
> > > >=20
> > > > I agree that these "host-model" and "host-serial" props, which aren=
't
> > > > described anywhere and not used by either the linux kernel or the
> > > > powerpc-utils, look like a QEMU-specific poor man's version of VPD.
> > > >=20
> > > > Not quite sure why they were even created since this is the purpose
> > > > of "system-id" and "model" as explained in PAPR, and supposedly
> > > > exposed in /proc/ppc64/lparcfg according to the LPARCFG(5) manual
> > > > page: =20
> > >=20
> > > Yeah, I'm not sure why they were created either.  I rather suspect
> > > nothing much is using them, and I'd kind of like to just kill them.
> > > But Daniel Berrange (and maybe others) are paranoid about this
> > > breaking things.
> > >=20
> >=20
> > Speaking of that. The "host-model"/"host-serial" fix is associated to a
> > CVE which affects QEMU versions currently shipped by downstream vendors.
> > Isn't a good enough reason to break things in existing unsecure setups ?
> > Should we add this patch to Mike's patch round-up for stable 3.0.1 (and
> > therefore break something that used to _work_ with 3.0.0) ?
>=20
> Just for confirm: is the suggestion to backport 27461d69a? IIUC the fix
> would involve utilizing new command-line options to override the default
> "passthrough" mode for host-model/host-serial.
>=20
> If so, I think an argument could be made, but I generally try to avoid
> anything relying on new command-line options since they're unlikely to be
> utilized unless the distro/vendor are likely to have specific plans to use
> them


Yeah :/

> and implement the appropriate changes elsewhere in their stack to do
> so (e.g.  stuff like Spectre mitigations). And, worst case, downstreams
> would still have the option of backporting the QEMU fixes as part of the
> overall CVE fix, so I'd probably opt to leave this one to the downstreams
> to consider.

So, in this case Openstack already does something similar for x86 - it
passes /etc/machine-id through the smbios information.  Unfortunately
the way it passes that down to qemu is via an explicit -smbios option.

It would be nice to have a common "host-id" or whatever option to qemu
which will work for both x86 via smbios and power via device tree
and/or get-vpd.  I had a look at that, and implementing it is fiddlier
than you'd think, because all the fallback logic and multiple pieces
to change (e.g. qemu would need to populate with explicit smbios info
first, then fall back to machine options, then libvirt would need a
common way to pass it through, then openstack would need to change to
use the common way, .... ugh).

At the moment this is in my "makes-my-brain-hurt-to-contemplate"
pile.  I'm open to suggestions.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--A2x6GFCQWVc4i5ud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0cT+EACgkQbDjKyiDZ
s5KN4hAApzJYJ9Eh8pv+NPEdJJUIJH18TIK2/aOumWeEM+dcEpLz7f+oZihriS/D
cpHYL57QZZ6X+73heTUnuf8lsGmJhO2IJM4t2KK322z5MBDJcBAGu5maUEdY/DEd
qmFlLDHS2dl8AtFU+WJzSC46qCryTqN3fo1ty6724jeQC+pNse3VhgjjLW3yjnes
n0SZ8GZMf0w6OIVydNrPiY4RDmOt9QM2FR+aXmGFI3oivYr6B2U6rZaOLHy9eq6m
Ph4YAred+8B+J9W3aahf3EM2mMGX0pCAmrcf0a1NIX6fw8kTE0UXBdFAlsfB76C/
DNLRc1vMEj7qJUOPab8trwHNI9U3pkAoRVjT1D8+fyvH41WQCfMyXwHiNfEOTdgF
vCweAy9xswyDbZCkardTxvd4G92S3rVw4BQJVz7zAUGmD8BiZtYPGd7Hj4tthc0Q
mEH3q1aA2xbJI+udYzpB9jNkhitpWb4n6TWopuC5gBpWPOdCkCZthtZYbcfbKcb0
7F+RvDVLt5qc1MZ994fOZ++YmxJcd2MP0rWbIGJSKAt81/6xhjqIVcfB68DADm01
gD6fAMG3pnZou0qUAOPRni4SI0vxa7c7jvbtzCHslTD4+0cxiSDLrB8UnoFTxRbq
HPgE7PXbCvFgGil53YBrc3JhXvmWUEd8wYSVB1lXUvzpWDmRak4=
=k/Z3
-----END PGP SIGNATURE-----

--A2x6GFCQWVc4i5ud--

