Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF746C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 06:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD9622CEC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 06:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iZuYneu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD9622CEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i12h0-00022t-Mp
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 02:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i12eQ-0000kS-By
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 02:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i12eO-0004cM-PQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 02:02:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34237 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i12eN-0004Sc-HZ; Fri, 23 Aug 2019 02:02:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46F9lh10tlz9s3Z; Fri, 23 Aug 2019 16:02:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566540128;
 bh=kA6Nk5Mriy/egRWGeO2djE7Ppzd9wcalvdsmHxhZFOQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iZuYneu/So+ZsU+eb5CuWYIQamcYVXMuHxS7GmumG/c8JBwIOgcnksiYd/rmtfrp6
 GN2WOjPGbLyDk9DjSiGodnHu7Tuj85cJ+w8jFvjLurIlCTHzw/E0hTwzsIyOyBxLES
 u1aEOpG3F/MSR0J+oOk2Fa/Z4o4D9RO9Zbv0xFhQ=
Date: Fri, 23 Aug 2019 15:39:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190823053944.GC3027@umbus.fritz.box>
References: <20190813065920.23203-1-david@gibson.dropbear.id.au>
 <20190813065920.23203-2-david@gibson.dropbear.id.au>
 <fe960812-9df2-4c27-8661-633dee3f4a53@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <fe960812-9df2-4c27-8661-633dee3f4a53@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 1/2] spapr: Reset CAS & IRQ
 subsystem after devices
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
Cc: peter.maydell@linaro.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2019 at 10:07:09PM +0200, Laurent Vivier wrote:
> On 13/08/2019 08:59, David Gibson wrote:
> > This fixes a nasty regression in qemu-4.1 for the 'pseries' machine,
> > caused by the new "dual" interrupt controller model.  Specifically,
> > qemu can crash when used with KVM if a 'system_reset' is requested
> > while there's active I/O in the guest.
> >=20
> > The problem is that in spapr_machine_reset() we:
> >=20
> > 1. Reset the CAS vector state
> > 	spapr_ovec_cleanup(spapr->ov5_cas);
> >=20
> > 2. Reset all devices
> > 	qemu_devices_reset()
> >=20
> > 3. Reset the irq subsystem
> > 	spapr_irq_reset();
> >=20
> > However (1) implicitly changes the interrupt delivery mode, because
> > whether we're using XICS or XIVE depends on the CAS state.  We don't
> > properly initialize the new irq mode until (3) though - in particular
> > setting up the KVM devices.
> >=20
> > During (2), we can temporarily drop the BQL allowing some irqs to be
> > delivered which will go to an irq system that's not properly set up.
> >=20
> > Specifically, if the previous guest was in (KVM) XIVE mode, the CAS
> > reset will put us back in XICS mode.  kvm_kernel_irqchip() still
> > returns true, because XIVE was using KVM, however XICs doesn't have
> > its KVM components intialized and kernel_xics_fd =3D=3D -1.  When the i=
rq
> > is delivered it goes via ics_kvm_set_irq() which assert()s that
> > kernel_xics_fd !=3D -1.
> >=20
> > This change addresses the problem by delaying the CAS reset until
> > after the devices reset.  The device reset should quiesce all the
> > devices so we won't get irqs delivered while we mess around with the
> > IRQ.  The CAS reset and irq re-initialize should also now be under the
> > same BQL critical section so nothing else should be able to interrupt
> > it either.
> >=20
> > We also move the spapr_irq_msi_reset() used in one of the legacy irq
> > modes, since it logically makes sense at the same point as the
> > spapr_irq_reset() (it's essentially an equivalent operation for older
> > machine types).  Since we don't need to switch between different
> > interrupt controllers for those old machine types it shouldn't
> > actually be broken in those cases though.
> >=20
> > Cc: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > Fixes: b2e22477 "spapr: add a 'reset' method to the sPAPR IRQ backend"
> > Fixes: 13db0cd9 "spapr: introduce a new sPAPR IRQ backend supporting
> >                  XIVE and XICS"
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 821f0d4a49..12ed4b065c 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1726,6 +1726,18 @@ static void spapr_machine_reset(MachineState *ma=
chine)
> >          spapr_setup_hpt_and_vrma(spapr);
> >      }
> > =20
> > +    /*
> > +     * NVLink2-connected GPU RAM needs to be placed on a separate NUMA=
 node.
> > +     * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() wh=
ich is
> > +     * called from vPHB reset handler so we initialize the counter her=
e.
> > +     * If no NUMA is configured from the QEMU side, we start from 1 as=
 GPU RAM
> > +     * must be equally distant from any other node.
> > +     * The final value of spapr->gpu_numa_id is going to be written to
> > +     * max-associativity-domains in spapr_build_fdt().
> > +     */
> > +    spapr->gpu_numa_id =3D MAX(1, nb_numa_nodes);
> > +    qemu_devices_reset();
> > +
> >      /*
> >       * If this reset wasn't generated by CAS, we should reset our
> >       * negotiated options and start from scratch
> > @@ -1741,18 +1753,6 @@ static void spapr_machine_reset(MachineState *ma=
chine)
> >          spapr_irq_msi_reset(spapr);
> >      }
> > =20
> > -    /*
> > -     * NVLink2-connected GPU RAM needs to be placed on a separate NUMA=
 node.
> > -     * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() wh=
ich is
> > -     * called from vPHB reset handler so we initialize the counter her=
e.
> > -     * If no NUMA is configured from the QEMU side, we start from 1 as=
 GPU RAM
> > -     * must be equally distant from any other node.
> > -     * The final value of spapr->gpu_numa_id is going to be written to
> > -     * max-associativity-domains in spapr_build_fdt().
> > -     */
> > -    spapr->gpu_numa_id =3D MAX(1, nb_numa_nodes);
> > -    qemu_devices_reset();
> > -
> >      /*
> >       * This is fixing some of the default configuration of the XIVE
> >       * devices. To be called after the reset of the machine devices.
> >=20
>=20
> This commit breaks migration between POWER8 <-> POWER9 hosts:
>=20
> qemu-system-ppc64: error while loading state for instance 0x1 of device '=
cpu'
> qemu-system-ppc64: load of migration failed: Operation not permitted
>=20
> Using a guest with a running 4.18 kernel (RHEL 8) and "-M pseries,max-cpu=
-compat=3Dpower8" on both sides.
>=20
> There is no problem if both hosts are of the same kind ( P8 <-> P8 or P9 =
<-> P9).

Crud, I was afraid there might be some subtle dependency on the
reverse order.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1ffCAACgkQbDjKyiDZ
s5KqLg/9GIb+LEmQ7luzPx4WyHnaeq+1HHUKvhA0Wuf8DcuSF/RTCYztV43BdsrB
6dvAc0BUF3XYdvBACSuGWz+u9EQ+5p1hV2GIy5fu4LMO9iW3Ur7WXKRTp/0UXchf
ioicG2/WDdZMVbApgiKXP744r9mJopdkKHEoshlrJb0r5m2dBosAVU5LC71C/k+q
PtUQdqHtnfSNERQf2EgGxkSZ5oKZmujuhb41GhE+cm8Eqcumjd0pRgQb8wmMTsGc
J8gZ3R4Ofob8qo36Bx3ouquYsO+f/kuad9LqnVeeHjWqPBEZT5yiqoQqqa+2xRKo
/8lCiQfu5iDNom/biWR1tKgpxG/FeChzFR2Ex3VUWfvv1pmtNZ9IsY6oanTYTr0U
irLgPU/f/HgRwSmJP7ZwyxXWebFVmEjQxJ1f2/Sqa7Yp9pg9+Qzve/2LZAzjLjWz
PognzbbU98WRiwPAOQXJpxZGZQv4s6BBmfiFBJJbLWJa72NpsCSTUwd/ce0LuK20
gZ07qiAjTi6D5RrNf4KZL/d5VtPm8KjSO5ghjmEL+vcENGn3Ikwjspl1DtQYdAvF
uQ26SlqIzYTph5LoOMRDBYP56yC6DNUdYIvUPEUa/RgNLPwZve4r3YCnc1+McjGG
YJIiLutG71iIg2nV0GWCzCYssYC2XV3wo1XzIfn9ZkLFMDQEk4g=
=I/fE
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--

