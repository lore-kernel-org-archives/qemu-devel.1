Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5956C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:00:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CCDC21852
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCDC21852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXKv4-00025f-JP
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 03:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iXKu6-0001B1-W3
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:00:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iXKu5-0001rr-4E
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:59:58 -0500
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:58983)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iXKu2-0001p9-9W
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:59:54 -0500
Received: from player737.ha.ovh.net (unknown [10.108.57.16])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id D20A914BD9F
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:59:49 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 71FC42DF5CA3;
 Wed, 20 Nov 2019 07:59:43 +0000 (UTC)
Date: Wed, 20 Nov 2019 08:59:40 +0100
From: Greg Kurz <groug@kaod.org>
To: Balamuruhan S <bala24@linux.ibm.com>
Subject: Re: [PATCH 2/5] hw/ppc/pnv_xscom: PBA bar mask values are incorrect
 with homer/occ sizes
Message-ID: <20191120085940.5c824fca@bahia.lan>
In-Reply-To: <20191120031651.GB689@localhost.localdomain>
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <20191119175056.32518-3-bala24@linux.ibm.com>
 <20191119215618.GU5582@umbus.fritz.box>
 <20191119220032.GV5582@umbus.fritz.box>
 <20191119220226.GW5582@umbus.fritz.box>
 <20191120030103.GA689@localhost.localdomain>
 <20191120031651.GB689@localhost.localdomain>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 17470870329967417753
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegledguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucffohhmrghinhepughrohhpsggvrghrrdhiugdrrghupdhgihhthhhusgdrtghomhdpohiilhgrsghsrdhorhhgnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.75.26
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
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 08:46:51 +0530
Balamuruhan S <bala24@linux.ibm.com> wrote:

> On Wed, Nov 20, 2019 at 08:31:03AM +0530, Balamuruhan S wrote:
> > On Wed, Nov 20, 2019 at 09:02:26AM +1100, David Gibson wrote:
> > > On Wed, Nov 20, 2019 at 09:00:32AM +1100, David Gibson wrote:
> > > > On Wed, Nov 20, 2019 at 08:56:18AM +1100, David Gibson wrote:
> > > > > On Tue, Nov 19, 2019 at 11:20:53PM +0530, Balamuruhan S wrote:
> > > > > > homer/occ sizes are calculated in skiboot with `(mask | 0xfffff=
) + 1`,
> > > > > > and from xscom access should return correct mask values instead=
 of actual
> > > > > > sizes.
> > > > > >=20
> > > > > > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > > > > > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > > > > > ---
> > > > > >  hw/ppc/pnv_xscom.c | 10 ++++++----
> > > > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > > > >=20
> > > > > > diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> > > > > > index f01d788a65..cdd5fa356e 100644
> > > > > > --- a/hw/ppc/pnv_xscom.c
> > > > > > +++ b/hw/ppc/pnv_xscom.c
> > > > > > @@ -46,6 +46,10 @@
> > > > > >  #define P9_PBA_BARMASK0                 0x5012b04
> > > > > >  #define P9_PBA_BARMASK2                 0x5012b06
> > > > > > =20
> > > > > > +/* Mask to calculate Homer/Occ size */
> > > > > > +#define HOMER_SIZE_MASK                 0x0000000000300000ull
> > > > > > +#define OCC_SIZE_MASK                   0x0000000000700000ull
> > > > >=20
> > > > > Uuuhhhhh... AFAICT these defines have identical values to
> > > > > PNV_HOMER_SIZE and PNV_OCC_COMMON_AREA_SIZE, so I don't see what =
this
> > > > > patch is actually changing.
> > > >=20
> > > > Oh, sorry, missed that the values were changed in 1/5.  Would have
> > > > been easier to follow if the two patches were folded together, but
> > > > never mind.  Applied.
> > >=20
> > > Ugh.. or not.  The first patch doesn't apply for me, looks like it
> > > needs a rebase (or you have something else in your tree I don't know
> > > about).
> >=20
> > I checked out from upstream master (commit: 8937f17249 ) and worked on
>                                                  ^
> 						 |
> ignore this its my first patch commit id (1/5)----
>=20
> > it.
>=20
> upstream commit id: f086f22d6c (VFIO fixes 2019-11-18), please let me
> know if you would like me to respin the patches after rebase with v4.2.0
> rc2 release.
>=20

Or maybe base your patches on David's ppc-for-5.0 branch available at
https://github.com/dgibson/qemu .

> -- Bala
>=20
> >=20
> > -- Bala
> > >=20
> > > --=20
> > > David Gibson			| I'll have my music baroque, and my code
> > > david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _o=
ther_
> > > 				| _way_ _around_!
> > > http://www.ozlabs.org/~dgibson
> >=20
> >=20
> >=20
>=20


