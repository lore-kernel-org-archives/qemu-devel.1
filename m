Return-Path: <SRS0=2u83=X7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E647C4740A
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 00:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B40222BE
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 00:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ezIXr4Sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B40222BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGuXp-0008Lt-AL
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 20:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGuUl-0005j1-58
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 20:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGuUj-0001m9-G1
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 20:33:55 -0400
Received: from ozlabs.org ([203.11.71.1]:46327)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGuUi-0001jX-6b; Sat, 05 Oct 2019 20:33:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46m4NT0jKQz9sN1; Sun,  6 Oct 2019 11:33:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570322025;
 bh=5loEHqNB87aEZhiVbSBojFo/4jWSxvzV0dIfIIvVzDc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ezIXr4SfNHT5xWjKbcDm7gW5O5mCb98AlulT4Q4SO/83HtSyOBY5d3IeEsDEAh3WO
 UK0Dm4BB5R+qGqHkUqf1aGCMRP5VSHtrfkRvF03OIw2BsRf2KLapyTlEeQuSGEa8rZ
 dyINd8fx6pm21Aot5mRxiyI/P0X89JH8jXvbsrkU=
Date: Sat, 5 Oct 2019 20:23:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/7] spapr, xive: Turn "nr-ends" property into
 "nr-servers" property
Message-ID: <20191005102342.GF29310@umbus.fritz.box>
References: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
 <157010406203.246126.13381271918474281392.stgit@bahia.lan>
 <20191004040725.GB27597@umbus.fritz.box>
 <20191004085119.73cb5f5f@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AGZzQgpsuUlWC1xT"
Content-Disposition: inline
In-Reply-To: <20191004085119.73cb5f5f@bahia.lan>
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2019 at 08:51:19AM +0200, Greg Kurz wrote:
> On Fri, 4 Oct 2019 14:07:25 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Oct 03, 2019 at 02:01:13PM +0200, Greg Kurz wrote:
> > > The sPAPR XIVE object has an nr_ends field which happens to be a
> > > multiple of spapr_max_server_number(). It is currently set with
> > > the help of "nr-ends" property. This is a bit unfortunate since
> > > it exposes to the sPAPR irq frontend what should remain an
> > > implemantation detail within the XIVE backend.
> > >=20
> > > It will be possible soon to inform the XIVE KVM device about the
> > > range of VCPU ids that may be used in the VM, as returned by the
> > > spapr_max_server_number() function. This will allow the device
> > > to substantially reduce the consumption of scarce resources
> > > in the XIVE HW.
> > >=20
> > > For both reasons, replace the "nr-ends" property with an "nr-servers"
> > > one. The existing nr_ends field must be kept though since it tells how
> > > many ENDs are migrated, it is derived from "nr-servers" at realize ti=
me
> > > for simplicity. Convert spapr_dt_xive() to use it as well.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/intc/spapr_xive.c        |   21 ++++++++++++++++-----
> > >  hw/ppc/spapr_irq.c          |    2 +-
> > >  include/hw/ppc/spapr_xive.h |    1 +
> > >  3 files changed, 18 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > > index 04879abf2e7a..62888ddc68db 100644
> > > --- a/hw/intc/spapr_xive.c
> > > +++ b/hw/intc/spapr_xive.c
> > > @@ -99,6 +99,15 @@ int spapr_xive_end_to_target(uint8_t end_blk, uint=
32_t end_idx,
> > >      return 0;
> > >  }
> > > =20
> > > +static uint32_t spapr_xive_vcpu_id_to_end_idx(uint32_t vcpu_id)
> > > +{
> > > +    /*
> > > +     * 8 XIVE END structures per CPU. One for each available
> > > +     * priority
> > > +     */
> > > +    return vcpu_id << 3;
> > > +}
> > > +
> > >  static void spapr_xive_cpu_to_end(PowerPCCPU *cpu, uint8_t prio,
> > >                                    uint8_t *out_end_blk, uint32_t *ou=
t_end_idx)
> > >  {
> > > @@ -109,7 +118,7 @@ static void spapr_xive_cpu_to_end(PowerPCCPU *cpu=
, uint8_t prio,
> > >      }
> > > =20
> > >      if (out_end_idx) {
> > > -        *out_end_idx =3D (cpu->vcpu_id << 3) + prio;
> > > +        *out_end_idx =3D spapr_xive_vcpu_id_to_end_idx(cpu->vcpu_id)=
 + prio;
> > >      }
> > >  }
> > > =20
> > > @@ -283,11 +292,13 @@ static void spapr_xive_realize(DeviceState *dev=
, Error **errp)
> > >          return;
> > >      }
> > > =20
> > > -    if (!xive->nr_ends) {
> > > -        error_setg(errp, "Number of interrupt needs to be greater 0"=
);
> > > +    if (!xive->nr_servers) {
> > > +        error_setg(errp, "Number of interrupt servers must be greate=
r than 0");
> > >          return;
> > >      }
> > > =20
> > > +    xive->nr_ends =3D spapr_xive_vcpu_id_to_end_idx(xive->nr_servers=
);
> >=20
> > I'd prefer not to store both nr_servers and nr_servers * 8 in the
> > structure.  I think you just want xive->nr_servers, then derive it any
> > any places that current look at xive->nr_ends.
> >=20
>=20
> Of course but unfortunately nr_ends is involved in migration:
>=20
> static const VMStateDescription vmstate_spapr_xive =3D {
>     .name =3D TYPE_SPAPR_XIVE,
>     .version_id =3D 1,
>     .minimum_version_id =3D 1,
>     .pre_save =3D vmstate_spapr_xive_pre_save,
>     .post_load =3D NULL, /* handled at the machine level */
>     .fields =3D (VMStateField[]) {
>         VMSTATE_UINT32_EQUAL(nr_irqs, SpaprXive, NULL),
>         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(eat, SpaprXive, nr_irqs,
>                                      vmstate_spapr_xive_eas, XiveEAS),
>         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(endt, SpaprXive, nr_ends,
>                                                              ^^^^^^^^^^
>                                              vmstate_spapr_xive_end, Xive=
END),
>         VMSTATE_END_OF_LIST()
>     },
> };
>=20
> and we certainly cannot put nr_servers << 3 here. I suppose I should
> emphasize that even more in the changelog.

Ah, dangit, I forgot about that, though I've hit the same problem
before.  I'm actually less concerned about a comment in the changelog,
than in on the definition in the structure itself.

> We could possibly rename nr_ends to mig_nr_ends, and possibly only
> compute at migration time, but it doesn't buy much IMHO.

No, indeed not.

> > >      /*
> > >       * Initialize the internal sources, for IPIs and virtual devices.
> > >       */
> > > @@ -489,7 +500,7 @@ static const VMStateDescription vmstate_spapr_xiv=
e =3D {
> > > =20
> > >  static Property spapr_xive_properties[] =3D {
> > >      DEFINE_PROP_UINT32("nr-irqs", SpaprXive, nr_irqs, 0),
> > > -    DEFINE_PROP_UINT32("nr-ends", SpaprXive, nr_ends, 0),
> > > +    DEFINE_PROP_UINT32("nr-servers", SpaprXive, nr_servers, 0),
> >=20
> > Technically speaking the user can reach in using -global and modify
> > QOM properties like this, so this is arguably an interface breakage.
>=20
> Drat, I didn't think about this one... :-\ but it seems that "spapr-xive"
> isn't user creatable and doesn't appear in the output of '-device help'.
> Not sure how -global behaves in this case...
>=20
> > That said, I've always thought it was kind of a problem that the way
> > QOM is used internally thereby exposes as interface a bunch of things
> > that are really intended to be internal.
> >=20
>=20
> I tend to agree, nr-ends is really an internal detail that a typical
> sPAPR user should probably never see.
>=20
> > So... I'm inclined to go ahead with this anyway.  I won't tell if you
> > don't.
> >=20
> > >      DEFINE_PROP_UINT64("vc-base", SpaprXive, vc_base, SPAPR_XIVE_VC_=
BASE),
> > >      DEFINE_PROP_UINT64("tm-base", SpaprXive, tm_base, SPAPR_XIVE_TM_=
BASE),
> > >      DEFINE_PROP_END_OF_LIST(),
> > > @@ -1550,7 +1561,7 @@ void spapr_dt_xive(SpaprMachineState *spapr, ui=
nt32_t nr_servers, void *fdt,
> > >      /* Interrupt number ranges for the IPIs */
> > >      uint32_t lisn_ranges[] =3D {
> > >          cpu_to_be32(0),
> > > -        cpu_to_be32(nr_servers),
> > > +        cpu_to_be32(xive->nr_servers),
> > >      };
> > >      /*
> > >       * EQ size - the sizes of pages supported by the system 4K, 64K,
> > > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > > index 457eabe24cda..025fd00143a2 100644
> > > --- a/hw/ppc/spapr_irq.c
> > > +++ b/hw/ppc/spapr_irq.c
> > > @@ -591,7 +591,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Err=
or **errp)
> > >           * 8 XIVE END structures per CPU. One for each available
> > >           * priority
> > >           */
> > > -        qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
> > > +        qdev_prop_set_uint32(dev, "nr-servers", nr_servers);
> > >          qdev_init_nofail(dev);
> > > =20
> > >          spapr->xive =3D SPAPR_XIVE(dev);
> > > diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> > > index 0df20a6590a5..4a4a6fc6be7f 100644
> > > --- a/include/hw/ppc/spapr_xive.h
> > > +++ b/include/hw/ppc/spapr_xive.h
> > > @@ -22,6 +22,7 @@ typedef struct SpaprXive {
> > >      /* Internal interrupt source for IPIs and virtual devices */
> > >      XiveSource    source;
> > >      hwaddr        vc_base;
> > > +    uint32_t      nr_servers;
> >=20
> > This is a basic paraneter, not really related to the internal source
> > structure, so I'd move it up above that comment there.
> >=20
>=20
> Sure.
>=20
> > > =20
> > >      /* END ESB MMIOs */
> > >      XiveENDSource end_source;
> > >=20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AGZzQgpsuUlWC1xT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2Yby4ACgkQbDjKyiDZ
s5KElhAAomN9rX2hKXiU4v7lJlz7HLugOnjnUx0wV9Q6KDtqoekYsIwl2KOURlkE
lGwYpOQoyOABrpzuVRggsr2IDs+GvQES1pk9NO62YMNUmtqVfbLttJhK315+eAiG
9yzLkhxKf3/BP3vaUcI/x/x5mYCDpsa3ogLJFrs1EqK0qGGlibMi1mDGlJz6EMAu
WHhRwB59QLKRFi9g7/WHEpZFOlqg5KhHbCPtJ3dOHQjxiZoelABDCVkUGWUtpKym
IoZepvpMlg1o3Q01OMWune++UYhbYXtcAQjakgSnU9ENTax7kxQuRR95y+weowRh
lEQOghQvOHc2xWt3LqCxMXYSKoIMmFHnEiGHhhcCogpQLZqOOgDuk3F6kTl8rR0L
OMoE2agdUfDa20dPB+BaPsgJbU0szeu5kE4rYhM0OquJb+kCIL8UTAjMnYYBMpON
CarmJ3rXy6QMMeM6GLqhkIoiSAzFA0yE44AFQG94RLH9fFvqxGMX4u/6RtCMnqlN
HjIqTPkzmvCHQqq6icYc9QsNW9cKMsW4D59vjxN4sRQmmUFL90GJem9ahxl7Qdqe
4y7rNLTkvzBVehqFClToLjO4KbK2lwaTx2VKYTde+NKCI9AfY8L+GAj8tYEUE89h
qJz8KOhMWtLM3aY1rLfc3YSaowxmnunOn2ste282ceznw5U/GYY=
=7whN
-----END PGP SIGNATURE-----

--AGZzQgpsuUlWC1xT--

