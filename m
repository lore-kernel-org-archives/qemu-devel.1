Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5492BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BFC2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BFC2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2ucQ-0002LM-RI
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i2uav-0001dN-24
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i2uat-0007lc-20
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:50:24 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:35323)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i2uas-0007jt-LA
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:50:22 -0400
Received: from player796.ha.ovh.net (unknown [10.109.146.32])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 603B867E8F
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 11:50:20 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player796.ha.ovh.net (Postfix) with ESMTPSA id 6CDE7917869D;
 Wed, 28 Aug 2019 09:50:15 +0000 (UTC)
Date: Wed, 28 Aug 2019 11:50:14 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190828115014.0364baa1@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190828055740.GG16825@umbus.fritz.box>
References: <20190827065650.107319-1-aik@ozlabs.ru>
 <20190828004634.GB16825@umbus.fritz.box>
 <20190828021237.GD16825@umbus.fritz.box>
 <2ee9df47-1536-f2e3-9892-b4868ec359c2@ozlabs.ru>
 <20190828055740.GG16825@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lH0gZRZ_0G1aohKyvN8UusL"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 5646106558984591846
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeitddgvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.73.241
Subject: Re: [Qemu-devel] [Qemu-ppc] [GIT PULL for qemu-pseries] spapr:
 Render full FDT on ibm, client-architecture-support
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/lH0gZRZ_0G1aohKyvN8UusL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Aug 2019 15:57:40 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Aug 28, 2019 at 01:27:35PM +1000, Alexey Kardashevskiy wrote:
> >=20
> >=20
> > On 28/08/2019 12:12, David Gibson wrote:
> > > On Wed, Aug 28, 2019 at 10:46:34AM +1000, David Gibson wrote:
> > > > On Tue, Aug 27, 2019 at 04:56:50PM +1000, Alexey Kardashevskiy wrot=
e:
> > > > > The following changes since commit d6bb8b27204eaa58f1da948b65454e=
3a598ab2a4:
> > > > >=20
> > > > >    pseries: Update SLOF firmware image (2019-08-27 16:47:04 +1000)
> > > > >=20
> > > > > are available in the Git repository at:
> > > > >=20
> > > > >    git@github.com:aik/qemu.git tags/qemu-slof-20190827
> > > > >=20
> > > > > for you to fetch changes up to da9960a5aaa25d27c9798c3d94c7b4c2d8=
af31ac:
> > > > >=20
> > > > >    spapr: Render full FDT on ibm,client-architecture-support (201=
9-08-27 16:47:46 +1000)
> > > > >=20
> > > > > ----------------------------------------------------------------
> > > > > Alexey Kardashevskiy (1):
> > > > >        spapr: Render full FDT on ibm,client-architecture-support
> > > > >=20
> > > > >   hw/ppc/spapr.c | 90 +++++++------------------------------------=
---------------
> > > > >   1 file changed, 10 insertions(+), 80 deletions(-)
> > > > >=20
> > > > >=20
> > > > > *** Note: this is not for master, this is for pseries
> > > > >=20
> > > >=20
> > > > Merged, thanks.
> > >=20
> > > Urgh.  And the qemu change is now un-merged.  Alas, as soon as we had
> > > a CAS reboot for XIVE the guest didn't boot on the second attempt.
> > > Haven't had a chance to investigate yet.
> >=20
> > QEMU command line, guest kernel version? I'd give it a try.
>=20
> RHEL8.1 in guest and host, booting via GRUB into a XIVE capable
> kernel.
>=20
> I've now been able to investigate, dumping the dtb at H_UPDATE_DT
> time.

FWIW I sent a patch to do just that some times ago:

https://patchwork.ozlabs.org/patch/1095705/

>  Comparing before and after the fully-render-dt change, I get:
>=20
> @@ -24,13 +24,13 @@
>         };
> =20
>         chosen {
> -               bootargs =3D "BOOT_IMAGE=3D/vmlinuz-4.18.0-137.el8.ppc64l=
e root=3D/dev/mapper/rhel-root ro crashkernel=3Dauto rd.lvm.lv=3Drhel/root =
rd.lvm.lv=3Drhel/swap";
> +               bootargs =3D [00];
>                 bootpath =3D "/pci@800000020000000/scsi@0";
>                 cpu =3D <0xe45ee80>;
>                 ibm,arch-vec-5-platform-support =3D <0x17801880 0x19001a4=
0>;
>                 ibm,architecture-vec-5 =3D [19 00 20 00 00 80 05 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 80 40 40 00 40];
> -               linux,initrd-end =3D <0x00 0x588ed7d>;
> -               linux,initrd-start =3D <0x00 0x3c00000>;
> +               linux,initrd-end =3D <0x00>;
> +               linux,initrd-start =3D <0x00>;
>                 linux,pci-probe-only =3D <0x00>;
>                 linux,stdout-package =3D <0xe733a70>;
>                 linux,stdout-path =3D "/vdevice/vty@71000001";
> @@ -252,7 +252,7 @@
>                 used-by-rtas;
> =20
>                 ethernet@1 {
> -                       assigned-addresses =3D <0x82000830 0x00 0x8004000=
0 0x00 0x40000 0x81000810 0x00 0x100 0x00 0x20 0x82000814 0x00 0x80010000 0=
x00 0x1000 0xc3000820 0x2100 0x10000 0x00 0x4000>;
> +                       assigned-addresses;
>                         cache-line-size =3D <0x00>;
>                         class-code =3D <0x20000>;
>                         device-id =3D <0x1000>;
> @@ -274,7 +274,7 @@
>                 };
> =20
>                 scsi@0 {
> -                       assigned-addresses =3D <0x81000010 0x00 0x80 0x00=
 0x80 0x82000014 0x00 0x80000000 0x00 0x1000 0xc3000020 0x2100 0x00 0x00 0x=
4000>;
> +                       assigned-addresses;
>                         cache-line-size =3D <0x00>;
>                         class-code =3D <0x10000>;
>                         device-id =3D <0x1001>;
>=20
> So basically the bootargs, initrd params and assigned-addresses have
> been lost.
>=20
> For bootargs and initrd, I think what's happening is that because qemu
> isn't setting those (with no -kernel parameter) SLOF is creating them,
> but they're now being overwritten by qemu's post-CAS DT.
>=20
> I'm not sure what's going on with assigned-addresses.
>=20


--Sig_/lH0gZRZ_0G1aohKyvN8UusL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl1mTlYACgkQcdTV5YIv
c9bEmw//ZuiCgEAaRJeuzRaBEIA5wlQSdyIsXmaEci494YGfyicvgIImFZffsJcr
2lEtHNLTeRzPcrrWB2bXI1ZnPdIQjeACuzBgYWDSevyNOaimjMcM9jspn2y8drs/
HnoTYew4J3r3KB1N2DFh1dOegr4sXT7mDrVS2j83F/FA4on39t03wgvyhT3j5WOX
1P0ixgGN53JIDnlL+mcdV4vUbX/+FnAG9FrLbBpluyTE5Czp2Do8F9Du2hhPr/AV
IgVON/ymzO5DRN1CSv/gpR0jdPbgZrHLCQRKRazkf53902tk2U/hWiXWTQ/iDY+8
gUmK1GkEZfuy97I+JZuFEcbeCbsCKJZBdkmt2L7gPZafF3VQIhDY76xFgHHtGUlp
vclKHC6wFusyqa7VGKpTMgQl2uRVCrFOj69mrOjSZJIO8Y07MZqTRjvuDAuCNY80
S/Mv1ehE+Dd2rUao91Q1ZUHCrbARuMrIfZjQpoi8S4wPkmkA7vH5bGXuLkUZ0cym
hhrrqukk6Rj91CnE4INVktfGaLDCJCk93clMbVUFAlWQB7L4eovXwHkMx4pNep64
HXvKYywGzzj1LeEaNqqAYHCal7WTb1v/4MFXGg/tFr8n6tVIgxVZIJUyGJoQ5eIk
evN56Vlk3sbTu1sMsGiqDzWtfNHYVze2DJGERyfpzopjdDq09A0=
=eMVj
-----END PGP SIGNATURE-----

--Sig_/lH0gZRZ_0G1aohKyvN8UusL--

