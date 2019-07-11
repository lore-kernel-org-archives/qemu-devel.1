Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E6FC74A43
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 02:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E7A20844
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 02:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LqkX6E9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E7A20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlP3p-0008GU-KM
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 22:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58523)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hlP2m-00073E-RQ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 22:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hlP2l-00072S-G9
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 22:42:48 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:54605)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hlP2k-0006vc-Qc; Wed, 10 Jul 2019 22:42:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45kgMB6yzZz9sDB; Thu, 11 Jul 2019 12:42:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562812950;
 bh=kl8ZqDbR9IlqcI2QHKFph5/r2WVrlt+coNQN/V0molI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LqkX6E9kpOAAjyXDluabJTbJH3miJWHwVjYSKVKX55ssTk76BTmF0y+s6k9gaNwES
 L4h4O/cbSZ5lIenjTqZXy7jvE3+Q1/RKfo+5EnvohuVKFdKnsQ01+lD92qvm4I2Yx2
 ENotYMp2032+yVJ/lXSjF5MHK581nK7SuZhVc01I=
Date: Thu, 11 Jul 2019 11:26:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190711012613.GA13271@umbus.fritz.box>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
 <20190529065017.15149-42-david@gibson.dropbear.id.au>
 <a5139cdc-7175-1747-f18f-e5fcf6926d44@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <a5139cdc-7175-1747-f18f-e5fcf6926d44@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2019 at 06:26:09PM +0200, Laurent Vivier wrote:
> On 29/05/2019 08:50, David Gibson wrote:
> > From: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > Now that XIVE support is complete (QEMU emulated and KVM devices),
> > change the pseries machine to advertise both interrupt modes: XICS
> > (P7/P8) and XIVE (P9).
> >=20
> > The machine default interrupt modes depends on the version. Current
> > settings are:
> >=20
> >     pseries   default interrupt mode
> >=20
> >     4.1       dual
> >     4.0       xics
> >     3.1       xics
> >     3.0       legacy xics (different IRQ number space layout)
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > Message-Id: <20190522074016.10521-3-clg@kaod.org>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 39e698e9b0..4fd16b43f0 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -4352,7 +4352,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_=
ON;
> >      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> >      spapr_caps_add_properties(smc, &error_abort);
> > -    smc->irq =3D &spapr_irq_xics;
> > +    smc->irq =3D &spapr_irq_dual;
> >      smc->dr_phb_enabled =3D true;
> >  }
> > =20
> > @@ -4430,6 +4430,7 @@ static void spapr_machine_4_0_class_options(Machi=
neClass *mc)
> >      spapr_machine_4_1_class_options(mc);
> >      compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_le=
n);
> >      smc->phb_placement =3D phb_placement_4_0;
> > +    smc->irq =3D &spapr_irq_xics;
> >  }
> > =20
> >  DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
> >=20
>=20
> This patch breaks the '-no-reboot' parameter (I think the "dual" mode
> breaks the -no-reboot parameter)
>=20
> After grub loads the kernel and starts it, the kernel aborts:
>=20
> OF stdout device is: /vdevice/vty@71000000
> Preparing to boot Linux version 4.18.0-112.el8.ppc64le
> (mockbuild@ppc-061.build.eng.bos.redhat.com) (gcc version 8.3.1 20190507
> (Red Hat 8.3.1-4) (GCC)) #1 SMP Fri Jul 5 11:21:28 UTC 2019
> Detected machine type: 0000000000000101
> command line: BOOT_IMAGE=3D/vmlinuz-4.18.0-112.el8.ppc64le
> root=3D/dev/mapper/rhel_ibm--p8--kvm--03--guest--02-root ro
> crashkernel=3Dauto rd.lvm.lv=3Drhel_ibm-p8-kvm-03-guest-02/root
> rd.lvm.lv=3Drhel_ibm-p8-kvm-03-guest-02/swap
> Max number of cores passed to firmware: 256 (NR_CPUS =3D 2048)
> Calling ibm,client-architecture-support...[lvivier@localhost ~]$
>=20
> I bisected to this patch, and then after I understood the problem is
> with the -no-reboot parameter as the machine is reset by the CAS
> negotiation... and the -no-reboot prevents this reset.
>=20
> I don't know if it's a real problem or not.

Ah, bother.  I didn't think of the interaction between the CAS reboot
and -no-reboot.  I guess that's more reason to work out a way to do
the xics/xive switch without a full reset.  People were already not
thrilled with the extra reboots here.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0mkDIACgkQbDjKyiDZ
s5LE4hAAvTMN71ModHwp1HOwrAwO8uoPrFHJDv7wRyqCiIwgRhLcC2Yospxdl+84
fLV6Jv0num/V8Us09xTmaUzkkKUi2crFd/zOj66GknCeDCKbRL0UqaSRjmWCn4Kr
jOufe/2P+pS4wRGW3kqG2VPRyrAo0HFhmeIybD2T7a20l8uSmaUts4bHup0AYN+m
k0j96/ORjvQz1ELmof3fxKorzzLsaJX0goqUPLgjc8NQPZtx4IA5vp3ssBidLa6P
QAokQ+8qvmz4RZTP+CuL6DBy+YVAp95ykAWNQ6jdA8tYdxEVVo9m7xfPW5CM4k7k
YOOhrMgBxPzl277lzGEAvQK7RocEzRidqmwNjMWl9czfYArWTc7D5DSa0yX6Az8B
pSfmNBjrTbFF/mdjRLhuUD1vf+pexFZibbY/J0ODqGkuu1fRAKVZiN203eEf71jl
N4dfKCyST22LMh3ZaoVy7Y8ZxltmZ8uEJfyqPAUjIh2fPrhfW9ymhe7FzRDBHmWl
wmJP3VXo3DMQ+RESvwBy2DBZqGk/nkSmWuLqF7vARJ4coX+7Pip1DwWMvEiBgccg
XXvr+DLxOCUFuLJpSh2NO3M6uT2KK2M0+EXJmOP+/DSrdcxexmLTTfXMtJflxYON
eddeZHYvpfqK31S2ppWoMPHquSxAgIhCD579saZIVJBrEOnPnlI=
=L4cO
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

