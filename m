Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA0DC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 17:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DBC20815
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 17:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DBC20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEz4g-0006o9-LY
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 13:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iEz2k-0005gi-0B
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iEz2i-0000jD-1L
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:01:01 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:46530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iEz2h-0000iF-Bg
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:00:59 -0400
Received: from player786.ha.ovh.net (unknown [10.108.54.94])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 478CD11A920
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 19:00:56 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 3E061A7AA952;
 Mon, 30 Sep 2019 17:00:44 +0000 (UTC)
Date: Mon, 30 Sep 2019 19:00:43 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 06/20] xics: Create sPAPR specific ICS subtype
Message-ID: <20190930190043.5e9b51ed@bahia.w3ibm.bluemix.net>
In-Reply-To: <20190930084530.GK11105@umbus.fritz.box>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-7-david@gibson.dropbear.id.au>
 <20190925104050.072877f1@bahia.lan>
 <86d6fe0c-28ab-89a1-fa5f-dbc1d1c024ed@kaod.org>
 <20190926005646.GP17405@umbus> <20190927180556.6e600342@bahia.lan>
 <20190930084530.GK11105@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U=Ids0ABzRf3zH3lZb7V8sp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 3803008413094615526
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgedvgddutdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.111.180
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
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/U=Ids0ABzRf3zH3lZb7V8sp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Sep 2019 18:45:30 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Sep 27, 2019 at 06:05:56PM +0200, Greg Kurz wrote:
> > On Thu, 26 Sep 2019 10:56:46 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Wed, Sep 25, 2019 at 10:55:35AM +0200, C=C3=A9dric Le Goater wrote:
> > > > On 25/09/2019 10:40, Greg Kurz wrote:
> > > > > On Wed, 25 Sep 2019 16:45:20 +1000
> > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > >=20
> > > > >> We create a subtype of TYPE_ICS specifically for sPAPR.  For now=
 all this
> > > > >> does is move the setup of the PAPR specific hcalls and RTAS call=
s to
> > > > >> the realize() function for this, rather than requiring the PAPR =
code to
> > > > >> explicitly call xics_spapr_init().  In future it will have some =
more
> > > > >> function.
> > > > >>
> > > > >> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > >> ---
> > > > >=20
> > > > > LGTM, but for extra safety I would also introduce a SpaprIcsState=
 typedef
> > > >=20
> > > > why ? we have ICS_SPAPR() for the checks already.
> > >=20
> > > Eh.. using typedefs when we haven't actually extended a base type
> > > isn't common QOM practice.  Yes, it's not as typesafe as it could be,
> > > but I'm not really inclined to go to the extra effort here.
> >=20
> > I'll soon need to extend the base type with a nr_servers field,
>=20
> Uh.. nr_servers doesn't seem like it belongs in the base ICS type.

Of course ! I re-used the wording "extended a base type" of your sentence,
that I understand as "a subtype extends a base type with some more data".
I'm talking about the sPAPR ICS subtype here, not the base ICS type.

> That really would conflict with the pnv usage where the ICS is
> supposed to just represent the ICS, not the xics as a whole.  If you
> need nr_servers information here, it seems like pulling it via a
> method in XICSFabric would make more sense.
>=20
> > and while here with an fd field as well in order to get rid of
> > the ugly global in xics.c. I'll go to the extra effort :)
>=20
> That could go in the derived type.  We already kind of conflate ICS
> and XICS-as-a-whole for the PAPR subtype, and the KVM xics is PAPR
> only anyway.
>=20

Exactly, so that's why I was thinking about adding nr_servers there,
but it could go to XICSFabric as well I guess.

--Sig_/U=Ids0ABzRf3zH3lZb7V8sp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2SNLsACgkQcdTV5YIv
c9ZIeg/+Ko3zBRDOz1omQ/tM9Uew+PySkOxfiB6n4/5Sv2Yuk1lQB4OFlLjULiEu
l3Eod0kv39uVMwF3U+tdnUg+LjxzZ+M10At0/AI0Rgt/6v2oos7UJciaz2fyUcVw
WL93llHPvp7NwIehVMazV/xD/nyRiLtoS6PjgT7PNV0+LFCIdgSCqxa4k8FnITPZ
7ta8dLrQldX4dZnouZIkXA6wSem1o7tPKdLLI+moKDInfK+wJISy/S4WSh/FliJN
nqIZoqubnc+FjYKMwXy8QrMi9lQj+aBzOeQbQ6QYERFSd86HNTlP9NW0gACQ1zXG
QDMQN42tq7VnxUrVHDqMzdhYbuXaCQib6ltC67mmwsthWiFu2pX/8InIWR9jY056
fgAi0MMe0214x6AMRvJDCGyIl6qXd5Mfmrp7vcsjeJQOcl5ezXWWV3cfcy/pk2Aa
RlSWgoTNUNijPjwMOPMRiNOWb7/2wBxw9RMOTuER5EwEv+KqOsr4KIrEA0o1Yclb
PzF/CozgKG5TYROZzGpOzitKDdiTeAwlZeL/9tlkbxKcGaT2ZC/5QRZR2upFStf1
zH8BV5Vs2Rj3d2Xt9BbLUZAWPjiiSl7YAVMIy4M94Lr/BaFtfBTVxQlwI1wfUcjs
RFPyNpsQroNcQ0zCsmklG62DgF2t8Z0MbdQ/bMIXFg3+2j2/G1s=
=6aED
-----END PGP SIGNATURE-----

--Sig_/U=Ids0ABzRf3zH3lZb7V8sp--

