Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B347C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 04:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520742240D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 04:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NsYNbW1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520742240D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXHcf-0001ES-5g
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 23:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXHb8-0000M8-Du
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 23:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXHb6-0007Qf-4k
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 23:28:10 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:59369 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXHb5-0007Hq-9I; Tue, 19 Nov 2019 23:28:08 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47HqS20YMrz9sPf; Wed, 20 Nov 2019 15:28:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574224082;
 bh=nRvb++ts/tGXhbShZEi935HrnhbLY9DIgA4tHNv4Gv4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NsYNbW1Gl4z/fC5c1t1rgCwsVhXid+CXe31AQXiNig8fmf2/MmQb5ebBAGAXWq+TP
 vhRjLIF1A4S8QdLe7EpLaBFowN/jQ1581vTtdrugN4eOnevCDfbsf42WR4ARUvGS+2
 1RzFudORr2aRgef5ZI72XIOQD5lIvus2fJKydoNQ=
Date: Wed, 20 Nov 2019 15:17:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [RFC 5/5] spapr: Work around spurious warnings from vfio INTx
 initialization
Message-ID: <20191120041739.GE5582@umbus.fritz.box>
References: <20191017054218.8876-1-david@gibson.dropbear.id.au>
 <20191017054218.8876-6-david@gibson.dropbear.id.au>
 <3cded480-ce51-eef7-dc75-686022a18726@kaod.org>
 <2319e683-983c-2c40-3234-c4c43555c657@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pmKUVAsxJ35RhmJn"
Content-Disposition: inline
In-Reply-To: <2319e683-983c-2c40-3234-c4c43555c657@kaod.org>
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
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qemu-ppc@nongnu.org,
 groug@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pmKUVAsxJ35RhmJn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 03:42:06PM +0200, C=E9dric Le Goater wrote:
> On 17/10/2019 10:43, C=E9dric Le Goater wrote:
> > On 17/10/2019 07:42, David Gibson wrote:
> >> Traditional PCI INTx for vfio devices can only perform well if using
> >> an in-kernel irqchip.  Therefore, vfio_intx_update() issues a warning
> >> if an in kernel irqchip is not available.
> >>
> >> We usually do have an in-kernel irqchip available for pseries machines
> >> on POWER hosts.  However, because the platform allows feature
> >> negotiation of what interrupt controller model to use, we don't
> >> currently initialize it until machine reset.  vfio_intx_update() is
> >> called (first) from vfio_realize() before that, so it can issue a
> >> spurious warning, even if we will have an in kernel irqchip by the
> >> time we need it.
> >>
> >> To workaround this, make a call to spapr_irq_update_active_intc() from
> >> spapr_irq_init() which is called at machine realize time, before the
> >> vfio realize.  This call will be pretty much obsoleted by the later
> >> call at reset time, but it serves to suppress the spurious warning
> >> from VFIO.
> >>
> >> Cc: Alex Williamson <alex.williamson@redhat.com>
> >> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>
> >> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >> ---
> >>  hw/ppc/spapr_irq.c | 11 ++++++++++-
> >>  1 file changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> >> index 45544b8976..bb91c61fa0 100644
> >> --- a/hw/ppc/spapr_irq.c
> >> +++ b/hw/ppc/spapr_irq.c
> >> @@ -345,6 +345,14 @@ void spapr_irq_init(SpaprMachineState *spapr, Err=
or **errp)
> >> =20
> >>      spapr->qirqs =3D qemu_allocate_irqs(spapr_set_irq, spapr,
> >>                                        smc->nr_xirqs + SPAPR_XIRQ_BASE=
);
> >> +
> >> +    /*
> >> +     * Mostly we don't actually need this until reset, except that not
> >> +     * having this set up can cause VFIO devices to issue a
> >> +     * false-positive warning during realize(), because they don't yet
> >> +     * have an in-kernel irq chip.
> >> +     */
> >> +    spapr_irq_update_active_intc(spapr);
> >=20
> > This will call the de/activate hooks of the irq chip very early=20
> > before reset and CAS, and won't call them at reset if the intc
> > pointers are the same (xive only for instance). It breaks very=20
> > obviously the emulated XIVE device which won't reset the OS CAM=20
> > line with the CPU id values and CPU notification will be broken.
> >=20
> > We have to find something else.
>=20
> Here is a possible fix for the (re)setting of the OS CAM line.=20
>=20
> Removing spapr_xive_set_tctx_os_cam() is a good thing but this solution
> shows some issues in our modeling of hot-plugged CPUS with a reset()=20
> being called at realize().

Ok, I've applied the patch below now.  Does that mean that my 5/5
patch should be good now?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pmKUVAsxJ35RhmJn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3UvmAACgkQbDjKyiDZ
s5JxAw//bUzIPJkS2S/ulZKE8cLDCiAo/c6NohMJc4H4tD/ECaHhThT4yBHnf6H5
Xb49FbRm30Oqvwt2EKsWQ9C/9l6znT2k5FDETyT0kOZdZHbR7d/xXgw0m5OJ+FEk
UMc8hVuy3nwoDUy7eDKaB2Ujk9qWP/N/aPz0lH+1KkP0gO8ca9v41f02kj/cCEiL
dm6+IqG5ioFyJUpMBGuBfOuLc1SkgRmSP2b1oBMA4esYYXJ6HmDzCQHHVEmBd6HT
D5VQ1AsplXew1528rHi0rW0mbLJHSqovDkUkbqHmOKwDdvepcRbfe+LgWaQcEqjl
NYgMZrnSlTKobUdL9Qg/2iJrio8FMIKibWlXICMB8TKJy3Du22jGHhYT51y+4gk5
gkQMz00BNv6c23XHGyeogZByOPwQC7q+o0cDLUAE3ZNHuTBNqdu0hdGsx9PdfllU
9CYE8eLcFgLWFI6prQOVdaR7+TrFX7oaNJv0KTiHgGnwXY44HVLDN3H0oqvPjUjO
JfkByv6ELmpi198XrN2jg1vdCQRjtHHmiKPyyXFy6R9xI8tYvCziKT2wQggghLMr
bbpKAefS7Zwi+9JbLkOMTCM0nAN3c5i9Srlg9F1DFoQFi0HR7IE+/k8A/gSbBLxA
ThRHyPA+C3qn9H8FPeZb1d7vdxwG3T+SRdUYOfgVv2XBio+fceY=
=W3bB
-----END PGP SIGNATURE-----

--pmKUVAsxJ35RhmJn--

