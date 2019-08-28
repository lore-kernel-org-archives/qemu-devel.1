Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649D8C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 05:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCEE2189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 05:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="X+S/N+KY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCEE2189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2qzJ-0003fy-5o
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 01:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i2qxz-0003ES-7Q
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 01:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i2qxx-0007hg-Iw
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 01:57:58 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:55803)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i2qxt-0007eN-Qr; Wed, 28 Aug 2019 01:57:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46JFQM2DXNz9sNF; Wed, 28 Aug 2019 15:57:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566971867;
 bh=XMr7wF/kTBNuE9Ze9uqimQetmhXcP1E9XfkaZhZQFS8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X+S/N+KYcbwfX890pf58He5vw5NdvHhzT7PVe7l1WTmcC2zbkdqS4gRmYqVh9X5Yl
 42tiYLh8qcekJlxh7vumvCF1czyp+HgBLb/oJBtLOi9O3XzCrzLQz3hCctMQt/IkaE
 4Bi5X2hTxmAxfdfN5flVHsRwwHi1jNu37QYKHkXg=
Date: Wed, 28 Aug 2019 15:57:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190828055740.GG16825@umbus.fritz.box>
References: <20190827065650.107319-1-aik@ozlabs.ru>
 <20190828004634.GB16825@umbus.fritz.box>
 <20190828021237.GD16825@umbus.fritz.box>
 <2ee9df47-1536-f2e3-9892-b4868ec359c2@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Content-Disposition: inline
In-Reply-To: <2ee9df47-1536-f2e3-9892-b4868ec359c2@ozlabs.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [GIT PULL for qemu-pseries] spapr: Render full FDT
 on ibm, client-architecture-support
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 01:27:35PM +1000, Alexey Kardashevskiy wrote:
>=20
>=20
> On 28/08/2019 12:12, David Gibson wrote:
> > On Wed, Aug 28, 2019 at 10:46:34AM +1000, David Gibson wrote:
> > > On Tue, Aug 27, 2019 at 04:56:50PM +1000, Alexey Kardashevskiy wrote:
> > > > The following changes since commit d6bb8b27204eaa58f1da948b65454e3a=
598ab2a4:
> > > >=20
> > > >    pseries: Update SLOF firmware image (2019-08-27 16:47:04 +1000)
> > > >=20
> > > > are available in the Git repository at:
> > > >=20
> > > >    git@github.com:aik/qemu.git tags/qemu-slof-20190827
> > > >=20
> > > > for you to fetch changes up to da9960a5aaa25d27c9798c3d94c7b4c2d8af=
31ac:
> > > >=20
> > > >    spapr: Render full FDT on ibm,client-architecture-support (2019-=
08-27 16:47:46 +1000)
> > > >=20
> > > > ----------------------------------------------------------------
> > > > Alexey Kardashevskiy (1):
> > > >        spapr: Render full FDT on ibm,client-architecture-support
> > > >=20
> > > >   hw/ppc/spapr.c | 90 +++++++--------------------------------------=
-------------
> > > >   1 file changed, 10 insertions(+), 80 deletions(-)
> > > >=20
> > > >=20
> > > > *** Note: this is not for master, this is for pseries
> > > >=20
> > >=20
> > > Merged, thanks.
> >=20
> > Urgh.  And the qemu change is now un-merged.  Alas, as soon as we had
> > a CAS reboot for XIVE the guest didn't boot on the second attempt.
> > Haven't had a chance to investigate yet.
>=20
> QEMU command line, guest kernel version? I'd give it a try.

RHEL8.1 in guest and host, booting via GRUB into a XIVE capable
kernel.

I've now been able to investigate, dumping the dtb at H_UPDATE_DT
time.  Comparing before and after the fully-render-dt change, I get:

@@ -24,13 +24,13 @@
        };
=20
        chosen {
-               bootargs =3D "BOOT_IMAGE=3D/vmlinuz-4.18.0-137.el8.ppc64le =
root=3D/dev/mapper/rhel-root ro crashkernel=3Dauto rd.lvm.lv=3Drhel/root rd=
=2Elvm.lv=3Drhel/swap";
+               bootargs =3D [00];
                bootpath =3D "/pci@800000020000000/scsi@0";
                cpu =3D <0xe45ee80>;
                ibm,arch-vec-5-platform-support =3D <0x17801880 0x19001a40>;
                ibm,architecture-vec-5 =3D [19 00 20 00 00 80 05 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 80 40 40 00 40];
-               linux,initrd-end =3D <0x00 0x588ed7d>;
-               linux,initrd-start =3D <0x00 0x3c00000>;
+               linux,initrd-end =3D <0x00>;
+               linux,initrd-start =3D <0x00>;
                linux,pci-probe-only =3D <0x00>;
                linux,stdout-package =3D <0xe733a70>;
                linux,stdout-path =3D "/vdevice/vty@71000001";
@@ -252,7 +252,7 @@
                used-by-rtas;
=20
                ethernet@1 {
-                       assigned-addresses =3D <0x82000830 0x00 0x80040000 =
0x00 0x40000 0x81000810 0x00 0x100 0x00 0x20 0x82000814 0x00 0x80010000 0x0=
0 0x1000 0xc3000820 0x2100 0x10000 0x00 0x4000>;
+                       assigned-addresses;
                        cache-line-size =3D <0x00>;
                        class-code =3D <0x20000>;
                        device-id =3D <0x1000>;
@@ -274,7 +274,7 @@
                };
=20
                scsi@0 {
-                       assigned-addresses =3D <0x81000010 0x00 0x80 0x00 0=
x80 0x82000014 0x00 0x80000000 0x00 0x1000 0xc3000020 0x2100 0x00 0x00 0x40=
00>;
+                       assigned-addresses;
                        cache-line-size =3D <0x00>;
                        class-code =3D <0x10000>;
                        device-id =3D <0x1001>;

So basically the bootargs, initrd params and assigned-addresses have
been lost.

For bootargs and initrd, I think what's happening is that because qemu
isn't setting those (with no -kernel parameter) SLOF is creating them,
but they're now being overwritten by qemu's post-CAS DT.

I'm not sure what's going on with assigned-addresses.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1mF9EACgkQbDjKyiDZ
s5JpNg//WlmTr01DWnIAom4aUAjcSAl8Z6x0+hdqUw+3w34CFXj94kconEfkIBQE
vGIfjwbQZdJMawD7Cx78zol6VV/wA0FGVzk6tndmatffox/0fdl3fsbKKc12dqgf
UykHV3VyTJuaNUpn/qkbv//PreqP/zdqRCOBi85vTmzODB1cfZSm1iC3mxzSa2yV
eDJvDa1Y/d14B0WSI/AXAc/p82xnPSecZDPk285AUYGM2qNcBZFTKFe2bnojYvmT
WYQUFtQq1wz5TFEodGF15+I6aFgtkQQ/tsUFDSj6FfJ8wM2F28nH+2nu2nNUg8tE
ssTzjZQzmOiff1wputopLQbLOMEtono7J+Bt88TIkQwYoKuletOExC79ZC/xWQx4
LDGq85pYGm1vVIBlY+H29VTS80NvkvqwVopcdLF9/xjCcEUDsEpuzyOqR/AP3S+h
OnNkQMAceUMZQwv+EaYHVI8sqSon89pp1CHpWLZRl0svGWpT2KQyNVI6ETqyShmN
kpDVUgbtHReZ8rysH0YZVkbjGiqm8wDDjQ9lOIFf4ffnFBXb8Kt1kxEZSvoSng6e
lfYWgAFdnUO0OzIvZNOB7Ft1ubADhXP5hWZm80QCFY/aoXvA/SrwhPbIlbfCLEft
VIaEh9qoz6tfrFMiUzko2ajUj8f9N2INESiP0YjROGEia3UnDBs=
=7KlS
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--

