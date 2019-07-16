Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DECC76191
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 02:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A7720659
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 02:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ciuTuNJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A7720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnDEd-0008Sa-2E
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 22:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40899)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnDEP-0007ts-Du
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 22:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnDEO-0002e5-4T
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 22:30:17 -0400
Received: from ozlabs.org ([203.11.71.1]:39969)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnDEL-0002aP-UQ; Mon, 15 Jul 2019 22:30:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45nkrb6lK8z9sDQ; Tue, 16 Jul 2019 12:30:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563244207;
 bh=yudIgHkGMRouSOHQLS/4yy0tAdfF8Go7JUy5dVhIPPQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ciuTuNJ3iP/XYw8B+W1cwzGKK2fMkNhl1mAKYYQZlvJ6MOOelraIv3SRXQSD/bptc
 ofI0YplGtAPM8DY8kTw12tLixHHHom2JEEo9XXETMbXzsB2M42DQPt9I8iwNxcyIIF
 SNr+ZHqNI2WY8c9ZkGsA5p5NoE19R7zZ7KWsNIds=
Date: Tue, 16 Jul 2019 12:14:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190716021444.GA7525@umbus.fritz.box>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
 <20190529065017.15149-42-david@gibson.dropbear.id.au>
 <a5139cdc-7175-1747-f18f-e5fcf6926d44@redhat.com>
 <20190711012613.GA13271@umbus.fritz.box>
 <cd2e72a2-c252-2305-b070-95c6f3d39d5c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <cd2e72a2-c252-2305-b070-95c6f3d39d5c@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 41/44] spapr: change default
 interrupt mode to 'dual'
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
Cc: Laurent Vivier <lvivier@redhat.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2019 at 12:19:03PM +0200, C=E9dric Le Goater wrote:
> On 11/07/2019 03:26, David Gibson wrote:
> > On Wed, Jul 10, 2019 at 06:26:09PM +0200, Laurent Vivier wrote:
> >> On 29/05/2019 08:50, David Gibson wrote:
> >>> From: C=E9dric Le Goater <clg@kaod.org>
> >>>
> >>> Now that XIVE support is complete (QEMU emulated and KVM devices),
> >>> change the pseries machine to advertise both interrupt modes: XICS
> >>> (P7/P8) and XIVE (P9).
> >>>
> >>> The machine default interrupt modes depends on the version. Current
> >>> settings are:
> >>>
> >>>     pseries   default interrupt mode
> >>>
> >>>     4.1       dual
> >>>     4.0       xics
> >>>     3.1       xics
> >>>     3.0       legacy xics (different IRQ number space layout)
> >>>
> >>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>> Message-Id: <20190522074016.10521-3-clg@kaod.org>
> >>> Reviewed-by: Greg Kurz <groug@kaod.org>
> >>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>> ---
> >>>  hw/ppc/spapr.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>> index 39e698e9b0..4fd16b43f0 100644
> >>> --- a/hw/ppc/spapr.c
> >>> +++ b/hw/ppc/spapr.c
> >>> @@ -4352,7 +4352,7 @@ static void spapr_machine_class_init(ObjectClas=
s *oc, void *data)
> >>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CA=
P_ON;
> >>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> >>>      spapr_caps_add_properties(smc, &error_abort);
> >>> -    smc->irq =3D &spapr_irq_xics;
> >>> +    smc->irq =3D &spapr_irq_dual;
> >>>      smc->dr_phb_enabled =3D true;
> >>>  }
> >>> =20
> >>> @@ -4430,6 +4430,7 @@ static void spapr_machine_4_0_class_options(Mac=
hineClass *mc)
> >>>      spapr_machine_4_1_class_options(mc);
> >>>      compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_=
len);
> >>>      smc->phb_placement =3D phb_placement_4_0;
> >>> +    smc->irq =3D &spapr_irq_xics;
> >>>  }
> >>> =20
> >>>  DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
> >>>
> >>
> >> This patch breaks the '-no-reboot' parameter (I think the "dual" mode
> >> breaks the -no-reboot parameter)
> >>
> >> After grub loads the kernel and starts it, the kernel aborts:
> >>
> >> OF stdout device is: /vdevice/vty@71000000
> >> Preparing to boot Linux version 4.18.0-112.el8.ppc64le
> >> (mockbuild@ppc-061.build.eng.bos.redhat.com) (gcc version 8.3.1 201905=
07
> >> (Red Hat 8.3.1-4) (GCC)) #1 SMP Fri Jul 5 11:21:28 UTC 2019
> >> Detected machine type: 0000000000000101
> >> command line: BOOT_IMAGE=3D/vmlinuz-4.18.0-112.el8.ppc64le
> >> root=3D/dev/mapper/rhel_ibm--p8--kvm--03--guest--02-root ro
> >> crashkernel=3Dauto rd.lvm.lv=3Drhel_ibm-p8-kvm-03-guest-02/root
> >> rd.lvm.lv=3Drhel_ibm-p8-kvm-03-guest-02/swap
> >> Max number of cores passed to firmware: 256 (NR_CPUS =3D 2048)
> >> Calling ibm,client-architecture-support...[lvivier@localhost ~]$
> >>
> >> I bisected to this patch, and then after I understood the problem is
> >> with the -no-reboot parameter as the machine is reset by the CAS
> >> negotiation... and the -no-reboot prevents this reset.
> >>
> >> I don't know if it's a real problem or not.
> >=20
> > Ah, bother.  I didn't think of the interaction between the CAS reboot
> > and -no-reboot.  I guess that's more reason to work out a way to do
> > the xics/xive switch without a full reset.  People were already not
> > thrilled with the extra reboots here.
>=20
> QEMU builds a device tree depending on the interrupt mode negotiated=20
> at CAS time. Can we dynamically add/remove nodes ?

I believe we can make essentially arbitrary change to the device tree
as part of the CAS process without a reboot.

Re-doing this is kind of awkward with the current structure, but it's
probably what we're going to want.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0tMxIACgkQbDjKyiDZ
s5IkzQ/+OJlHY/MKP+2ETObrjqvbHbk8VV+cQRTgIxvBAVWjYfJlAuwilMw2/GBR
Q37Urt2Iw//Z3B0QtYhNN4ak0Qg50H4NSqfy0+Gp2xxDT9m1DEkxukXuyaEtQUXf
cibuYxivTF3g1kOvM5dqHM8Gq0KwZVh3snzFNovLqN5FJBWHPvoF58/L026+gcK2
Ce5D82yCu4U8aQ3Hz5j09YmkDOI+13NNTpuhtCCUfMedubOWcSmVFxu5vqHQYKJT
xTgjGf4nadIP1+NgKFUq2tQsfL5Ms05DDUsVHSIjWEzoc1HwxI6J3uEDixwHEUSt
7sGBWeWKk2BqMtrm11saPwZLukB1J/YEDuOyHgDFEcsGZ1h1dBDpUEXh3nT9vn9y
r+2lm4ZHfKyRiVGB47AxOGwHccNEsNwPdq2IjYzNzY7T8z0aW89vhYr+bEhNykO1
y+F2AJEgSjBuqAJYx+LzSBUnVv8rgbIajIHIGJ1kwPblXxMKKrk4rdKSpwFs4kl4
/uzLfrlscv/HMT/U3NYw0YtRCkVTzneWzAI8jhKbXyoud5YIhrQkb95DDbYRZsln
hFK7ya7OpbVK7j8K8y95HCK0Zg0DoY8MsNQE1v8FlwMGy84kwkMtLfvjnYRvHUo2
mUy9lIecrFfXiMAE9PRVV4xfgWpDho2G764Oj4lJ3GD8Oyzh688=
=DTAB
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--

