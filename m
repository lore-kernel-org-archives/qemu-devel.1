Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D07C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B699720829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B699720829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Br1-0000ei-OD
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k1BqH-00005W-1W
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:55:41 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:59686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k1BqD-000702-AS
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:55:40 -0400
Received: from player773.ha.ovh.net (unknown [10.108.42.192])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 240E19940F
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 18:55:26 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player773.ha.ovh.net (Postfix) with ESMTPSA id 4979214EF1B9E;
 Thu, 30 Jul 2020 16:55:19 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G00115336f22-8968-4033-b06d-99d0ce0d87a5,
 BD984F8AF93B25118D280F59DA094A97F588353D) smtp.auth=groug@kaod.org
Date: Thu, 30 Jul 2020 18:55:18 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH for-5.2] spapr: Avoid some integer conversions in
 spapr_phb_realize()
Message-ID: <20200730185518.774172c9@bahia.lan>
In-Reply-To: <20200729025441.GJ84173@umbus.fritz.box>
References: <159592765385.99837.12059368746532345109.stgit@bahia.lan>
 <20200729025441.GJ84173@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EWjCRjAy8nx/MqMd3KupCwp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 18121921954483050982
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrieeigddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeggfekuddvuddtgfekkeejleegjeffheduuefhledtteeftdfhffdtgfegiefhvdenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejfedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.42.102; envelope-from=groug@kaod.org;
 helo=4.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 12:55:27
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
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/EWjCRjAy8nx/MqMd3KupCwp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jul 2020 12:54:41 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jul 28, 2020 at 11:14:13AM +0200, Greg Kurz wrote:
> > Without this patch, the irq number gets converted uselessly from int
> > to int32_t, back and forth.
> >=20
> > This doesn't fix an actual issue, it's just to make the code neater.
> >=20
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Applied to ppc-for-5.2, thanks.
>=20

Daniel reported a crash that happens systematically on some systems that
don't support KVM XIVE (aka. bostons) since the patch "spapr: Simplify
error handling in spapr_phb_realize()" landed in the ppc-for-5.2 tree.

The patch is good but it uncovered an issue we have in the KVM XIVE code
in QEMU (basically we should ignore the absence of KVM XIVE device when
claiming IRQ numbers).

The fix is trivial but to avoid breaking bisect, it should rather go
before the patch mentioned above. Also I want to consolidate the error
handling a bit more so, in the meantime, for others to be able to use
the ppc-for-5.2 branch, I suggest you simply drop:

spapr: Simplify error handling in spapr_phb_realize()

and the current patch as well since it's a follow-up.

I'll send a new patchset later.

> > ---
> >=20
> > This is a follow-up to my previous "spapr: Simplify error handling in
> > spapr_phb_realize()" patch. Maybe worth squashing it there ?
> > ---
> >  hw/ppc/spapr_pci.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 59441e2117f3..0a418f1e6711 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1964,7 +1964,7 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
> > =20
> >      /* Initialize the LSI table */
> >      for (i =3D 0; i < PCI_NUM_PINS; i++) {
> > -        int32_t irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS=
 + i;
> > +        int irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
> > =20
> >          if (smc->legacy_irq_allocation) {
> >              irq =3D spapr_irq_findone(spapr, errp);
> >=20
> >=20
>=20


--Sig_/EWjCRjAy8nx/MqMd3KupCwp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl8i+3YACgkQcdTV5YIv
c9Zx6Q//fv6ey2J3LRzQ7gTVVuSMQmyq7hr2sEp6/wHIe0HeNR3xAnONsuFzklfT
yz9/g50YlDBUKpsrRMiVEKjr4wETstaUbpZUUhFFkUMm5ZrQNVKDYSwdK42KD7ww
Eu5JUy6IN0AgtZ58kuGEz/NClTCmn2LQ8J2Jtb6GSrmkYCPvluYZe0h/QzMmHmcM
eWIm24bZy850RFgAssGn97FnV5xcFMYt+0yXDxKGeddB2QbCRxbbdyeVUyAPGTp4
4pE9d32vaHMkUV7FnkUTfJnzzY68sFv/WQ+l5IdkD+sIxs8FI/C1AlAzRsPjp0FK
7SLr54OcUE/Y1BacX8doHve6FlDwb5zsqKkoDpiRHS7CXqP27d3wpnRNJ50hqHG8
JEwyCM05uwKB1cy8K/08gT0KRs0BzaqejvoDVsOH5S6XS5hTcEv0YHkLisaUk3Bf
HzjOxj3J+2DKROvInc6jiXTMTQmezmtNATezdJp7uKhvHu6OGpJDtImHpVNK655b
9iUtTfln5i/sqg+Ij+HLL1Fw1CzwZiX+asu96AHUARVX4NeVPY7hzxtv+yrq/ypE
fl/ony8G2b03OFdUQBOPwE9KvQvQ59/6cO6plHLYamWsEHjysd0H5B9i5zL2xXtu
rWERoLxA7LFXoTkYgUm5qP4IKQs7/7qgVtR3FL89ww1rpK2QvCc=
=L2Qa
-----END PGP SIGNATURE-----

--Sig_/EWjCRjAy8nx/MqMd3KupCwp--

