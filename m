Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843C8C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 00:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505A322303
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 00:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bQEIWCYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505A322303
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWrmH-0003QT-BE
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 19:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iWrlA-0002B1-NQ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 19:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iWrl7-0005qY-HW
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 19:52:48 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:38547)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iWrl6-0005mC-DI; Mon, 18 Nov 2019 19:52:45 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47H6jz35fpz9sPV; Tue, 19 Nov 2019 11:52:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574124759;
 bh=AHmTULuQJQt6oqGi5Z69V8IeFHpLr/v5b27JM8Ak5Yg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bQEIWCYfcm49gaTXutvlDTAJV6F+D5vD/nYpH1SZ3yFNReYRg/KoC1vkkM9hKMmYs
 njV+1Fk0lvA+APB986QA65rAW91in/MaRoUKLT24rtyPY+oH0LMiQAHmMQPUQfeaPH
 Q1LpEVfNhcG/M023M4r7UbPjzM46OxEEsVFrdIuY=
Date: Tue, 19 Nov 2019 11:47:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0] xive/kvm: Trigger interrupts from userspace
Message-ID: <20191119004713.GF5582@umbus.fritz.box>
References: <157408992731.494439.3405812941731584740.stgit@bahia.lan>
 <f81b87b2-c6c9-9c12-2929-adbb341cd391@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
Content-Disposition: inline
In-Reply-To: <f81b87b2-c6c9-9c12-2929-adbb341cd391@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 04:37:16PM +0100, C=E9dric Le Goater wrote:
> On 18/11/2019 16:12, Greg Kurz wrote:
> > When using the XIVE KVM device, the trigger page is directly accessible
> > in QEMU. Unlike with XICS, no need to ask KVM to fire the interrupt. A
> > simple store on the trigger page does the job.
> >=20
> > Just call xive_esb_trigger().
>=20
> Yes but the KVM XIVE device does a few other checks.=20
>=20
> It checks that the interrupt was correctly initialized at the KVM device
> level. We should be fine in QEMU which has similar checks.
>=20
> It caches the LSI assertion level. We should be fine also because it is
> useless in KVM when using the XIVE native exploitation mode.
>=20
> It checks it is not a passthru interrupt. Any idea on how to check this=
=20
> condition under QEMU ?=20
> =20
> > This may improve performance of emulated devices that go through
> > qemu_set_irq(), eg. virtio devices created with ioeventfd=3Doff or
> > configured by the guest to use LSI interrupts, which aren't really
> > recommended setups.
>=20
> LGTM.

Ok, between the comments above and this, I'm not sure if this is ready
to merge or not.

>=20
> Any figures to share ?=20
>=20
> C.
>=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/intc/spapr_xive_kvm.c |   16 ++--------------
> >  1 file changed, 2 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> > index 08012ac7cd76..69e73552f1ef 100644
> > --- a/hw/intc/spapr_xive_kvm.c
> > +++ b/hw/intc/spapr_xive_kvm.c
> > @@ -354,32 +354,20 @@ static void kvmppc_xive_source_get_state(XiveSour=
ce *xsrc)
> >  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
> >  {
> >      XiveSource *xsrc =3D opaque;
> > -    SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
> > -    struct kvm_irq_level args;
> > -    int rc;
> > -
> > -    /* The KVM XIVE device should be in use */
> > -    assert(xive->fd !=3D -1);
> > =20
> > -    args.irq =3D srcno;
> >      if (!xive_source_irq_is_lsi(xsrc, srcno)) {
> >          if (!val) {
> >              return;
> >          }
> > -        args.level =3D KVM_INTERRUPT_SET;
> >      } else {
> >          if (val) {
> >              xsrc->status[srcno] |=3D XIVE_STATUS_ASSERTED;
> > -            args.level =3D KVM_INTERRUPT_SET_LEVEL;
> >          } else {
> >              xsrc->status[srcno] &=3D ~XIVE_STATUS_ASSERTED;
> > -            args.level =3D KVM_INTERRUPT_UNSET;
> >          }
> >      }
> > -    rc =3D kvm_vm_ioctl(kvm_state, KVM_IRQ_LINE, &args);
> > -    if (rc < 0) {
> > -        error_report("XIVE: kvm_irq_line() failed : %s", strerror(errn=
o));
> > -    }
> > +
> > +    xive_esb_trigger(xsrc, srcno);
> >  }
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3TO44ACgkQbDjKyiDZ
s5LI+g/+O4j+2xTac7UNrabUpBp7j0PuFU5Z/Fy+Li8IpMme5y9EHJHSRkgcEkOQ
oeS1K2795V/JljH8nE1Wr5I55u8hnRVfwwjkeJdohH2Sx+3x+8jgDWgB5ou1q8m5
JFifrl2PKbQpKQ4nRuHQIn42kw9sCyjeyQhgqMwAn01v8TnBTZJJVd+O/tNPBrri
5WDnM3auvn+nQqUSoxV+g08rJr5SGL7Hf+1U8mMmx6wd0IX3rLpaE+IV7hudvrhl
hHWG/Vdqyz0VMtc5d0BwBP3c6vD9cW4cppSUqdV2GH4XLEBUdNj0cBKR7toyqMb5
icZ2pasrIAniM2VOWDcwdqZboM5Uk1UagTPe4eG8Sm4M461/s7ESm2o8cRzOs3p9
MJ2NuqpwkbCsANPPm/IxD4h5s7lmjYRquHHfQd4rPFGj0lDSnZ3tl59a9Jf+qcEx
91JZwsDzDrL3xiqt1smx5VhgA1sAtdTFjktdP+qY/RGfwKGQxwUr0w7HeeaSx+gz
n36TXzjNsg1APW+e1OdMyZDqPeNMRR/C614LgYNqM3O+xXqIE+RN0+4hFTh+Jbhh
LTVgvz8NtqLENRpxvW7E6GDjGRxhJj+xK7krMtYfGjuFClpoju5A46b0Zh0yaW8B
+VoiZFnAB1qfadk8K54e+/l21uxRPug9FN2bLxVCklHHEuvTyso=
=QaR7
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--

