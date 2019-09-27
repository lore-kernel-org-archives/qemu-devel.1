Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6520EC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 02:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD382146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 02:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MZijwT2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD382146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDg61-00045o-9R
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 22:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDg4K-0003Tr-NQ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 22:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDg4H-0006us-AX
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 22:33:15 -0400
Received: from ozlabs.org ([203.11.71.1]:52105)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDg4B-0006mZ-FQ; Thu, 26 Sep 2019 22:33:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fbSG1xxZz9sPW; Fri, 27 Sep 2019 12:33:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569551582;
 bh=mR7/cyrOqM9fxLAtUG3sX2bo0dn3ILmLiRnzt86mwas=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MZijwT2inWbIQ6ppBPD2y0hmFvN4DnxczI5NM0TL0Z+Vweo60OnmrgAJnOEFjpaKX
 nf7s8d5/0ji5xh7eferQpWaKRe/TjenmP5gM0IWWsUYMCNfHsknh/boQhT5HgSwL6u
 QnH4gYMAqshSHmuLNQXfNjf0HWw6LNQCDmERtOVs=
Date: Fri, 27 Sep 2019 11:47:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 17/20] spapr: Remove unused return value in claim path
Message-ID: <20190927014749.GF17405@umbus>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-18-david@gibson.dropbear.id.au>
 <20190926103602.0c948b6f@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sD87aq2/Ee9ozic7"
Content-Disposition: inline
In-Reply-To: <20190926103602.0c948b6f@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sD87aq2/Ee9ozic7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2019 at 10:36:02AM +0200, Greg Kurz wrote:
> On Wed, 25 Sep 2019 16:45:31 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > spapr_irq_claim() and the hooks it is based on return an integer error =
code
> > as well as taking an Error ** parameter.  But none of the callers check=
 the
> > integer, so we can remove it and just use the richer Error **.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> FYI, the very same topic of using the return value versus Error ** to
> check errors was discussed recently in this thread:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04197.html
>=20
> I tend to agree with Daniel (Cc'd) at first thought, but I don't have a s=
trong
> opinion about this yet. It is mostly to inform you that people are curren=
tly
> discussing/working on it.

So, I made this change mostly because redundant encodings give me an
itch.  But having read that post and then experimented a bit, I found
the approach he proposes does cut down a noticeable amount of
boilerplate.

So I think I'll move towards that approach and drop this patch.

>=20
> >  hw/ppc/spapr_irq.c         | 32 +++++++++++++-------------------
> >  include/hw/ppc/spapr_irq.h |  4 ++--
> >  2 files changed, 15 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index 261d66ba17..2673a90604 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -112,8 +112,8 @@ static void spapr_irq_init_xics(SpaprMachineState *=
spapr, Error **errp)
> >      spapr->ics =3D ICS_SPAPR(obj);
> >  }
> > =20
> > -static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, boo=
l lsi,
> > -                                Error **errp)
> > +static void spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bo=
ol lsi,
> > +                                 Error **errp)
> >  {
> >      ICSState *ics =3D spapr->ics;
> > =20
> > @@ -122,11 +122,10 @@ static int spapr_irq_claim_xics(SpaprMachineState=
 *spapr, int irq, bool lsi,
> > =20
> >      if (!ics_irq_free(ics, irq - ics->offset)) {
> >          error_setg(errp, "IRQ %d is not free", irq);
> > -        return -1;
> > +        return;
> >      }
> > =20
> >      ics_set_irq_type(ics, irq - ics->offset, lsi);
> > -    return 0;
> >  }
> > =20
> >  static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq)
> > @@ -252,14 +251,12 @@ static void spapr_irq_init_xive(SpaprMachineState=
 *spapr, Error **errp)
> >      spapr_xive_hcall_init(spapr);
> >  }
> > =20
> > -static int spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, boo=
l lsi,
> > -                                Error **errp)
> > +static void spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bo=
ol lsi,
> > +                                 Error **errp)
> >  {
> >      if (!spapr_xive_irq_claim(spapr->xive, irq, lsi)) {
> >          error_setg(errp, "IRQ %d is invalid", irq);
> > -        return -1;
> >      }
> > -    return 0;
> >  }
> > =20
> >  static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq)
> > @@ -406,25 +403,22 @@ static void spapr_irq_init_dual(SpaprMachineState=
 *spapr, Error **errp)
> >      }
> >  }
> > =20
> > -static int spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, boo=
l lsi,
> > -                                Error **errp)
> > +static void spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, bo=
ol lsi,
> > +                                 Error **errp)
> >  {
> >      Error *local_err =3D NULL;
> > -    int ret;
> > =20
> > -    ret =3D spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
> > +    spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> > -        return ret;
> > +        return;
> >      }
> > =20
> > -    ret =3D spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
> > +    spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> > -        return ret;
> > +        return;
> >      }
> > -
> > -    return ret;
> >  }
> > =20
> >  static void spapr_irq_free_dual(SpaprMachineState *spapr, int irq)
> > @@ -622,12 +616,12 @@ void spapr_irq_init(SpaprMachineState *spapr, Err=
or **errp)
> >                                        spapr->irq->nr_xirqs + SPAPR_XIR=
Q_BASE);
> >  }
> > =20
> > -int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp)
> > +void spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Erro=
r **errp)
> >  {
> >      assert(irq >=3D SPAPR_XIRQ_BASE);
> >      assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> > =20
> > -    return spapr->irq->claim(spapr, irq, lsi, errp);
> > +    spapr->irq->claim(spapr, irq, lsi, errp);
> >  }
> > =20
> >  void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
> > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > index ed88b4599a..75279ca137 100644
> > --- a/include/hw/ppc/spapr_irq.h
> > +++ b/include/hw/ppc/spapr_irq.h
> > @@ -42,7 +42,7 @@ typedef struct SpaprIrq {
> >      uint8_t     ov5;
> > =20
> >      void (*init)(SpaprMachineState *spapr, Error **errp);
> > -    int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **=
errp);
> > +    void (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error *=
*errp);
> >      void (*free)(SpaprMachineState *spapr, int irq);
> >      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
> >      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
> > @@ -61,7 +61,7 @@ extern SpaprIrq spapr_irq_xive;
> >  extern SpaprIrq spapr_irq_dual;
> > =20
> >  void spapr_irq_init(SpaprMachineState *spapr, Error **errp);
> > -int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp);
> > +void spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Erro=
r **errp);
> >  void spapr_irq_free(SpaprMachineState *spapr, int irq, int num);
> >  qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq);
> >  int spapr_irq_post_load(SpaprMachineState *spapr, int version_id);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sD87aq2/Ee9ozic7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2NakIACgkQbDjKyiDZ
s5I9XhAAg7fnodJXCKis74F2rLMfruI31gr+9SKztzKEFk8PuDh7tOqXf+E+5a5I
UAbg936rhtKot6EYMoPSrR3PKZnTBquaoNKLfEfKdBNmnkEe+KxLYQ/saOZ+ElEw
L90pdIj+nlfPUk3I9DGbhx3RGcSCZZBzFCNrB7FIE51NAkimTLaOyXKI+xglB+Ex
EyKoZnxNcqHms5sQaniCdLaK64KWX6BO2MyY5u9MjyhekHQXk2T+YT2a21UkJ7fs
duN/zcPbtH+rwVsKH/FuwPirYuqnnFu04B2m+PUeyK4YLsb/v2QuOut6cw+/dVBO
EUq74xxDd06bMEpRPJzGGcNLobZ34BYU+tnnKO//VL1np1vCncUIbmamSQlSxb15
jQvWYagYEM7XmSuxGO1ndohzzXMnT2+RuGVT11jjW255RoA+Om7IKWgV6AAQ8z+w
HTYysEhXe8AwimS1gvhiNQDODHm7UPVs8j0cbRxnOtSWXmJDi9M3eWTAZfvHcnrs
YNLIr83mIzIIE/ISrc7peVrxpSwteXWrHE/zzev43myBDVMZcUJ+nCFaoTpfabiA
90/2XB97LsMtkaAPGRcbW9vdy8xiM9hNFbvINNUikTaHZl0G18i/ytDrXgg9sVvu
lw1i3ucz8774g07idKzZerQMAfINdkc8aE3vtIksVhl72MDprDU=
=3LNj
-----END PGP SIGNATURE-----

--sD87aq2/Ee9ozic7--

