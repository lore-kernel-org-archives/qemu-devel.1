Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60CFC46460
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 04:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91EDE20868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 04:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OYgcj+wY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EDE20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54363 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYkAF-00026S-J4
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 00:38:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYk9H-0001jb-08
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 00:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYk9F-0001tj-CV
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 00:37:10 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59037 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hYk9C-0001mF-P6; Thu, 06 Jun 2019 00:37:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45KCYN6FsCz9sDX; Thu,  6 Jun 2019 14:36:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559795816;
	bh=Er/HJ7+pVaahnDK3PQIKMIW/N0Vf4Pq8rltMW6Hed44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYgcj+wYABqKtbGzhWfeeEcz4S+rNXyqOCu3km0vr6nZLM3/yDa5oRC1+Ywownelt
	0g78WoejFPyoRNhNZmWj3QhVnzRK1uCUQGJRqSuNaamVh+aViAPRTKn/eChowHBFL8
	S69NdBSlfEh8a2teNlOzslVbEk1g0GPU+PLkx5GI=
Date: Thu, 6 Jun 2019 14:24:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190606042459.GN10319@umbus.fritz.box>
References: <20190606040919.110655-1-aik@ozlabs.ru>
	<f2793523-7dab-a171-2d71-94ca48d9eb65@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kkcDP0v44wDpNmbp"
Content-Disposition: inline
In-Reply-To: <f2793523-7dab-a171-2d71-94ca48d9eb65@ozlabs.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] spapr_pci: Advertise BAR reallocation capability
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Shawn Anastasio <shawn@anastas.io>, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--kkcDP0v44wDpNmbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2019 at 02:13:20PM +1000, Alexey Kardashevskiy wrote:
> I changed my handy scripts for posting patches and the subject line
> broke, do I need to repost? It made it to the patchworks though.

No, that's fine I've seen it and will look at it when I have the chance.

>=20
>=20
>=20
> On 06/06/2019 14:09, Alexey Kardashevskiy wrote:
> > The pseries guests do not normally allocate PCI resouces and rely on
> > the system firmware doing so. Furthermore at least at some point in
> > the past the pseries guests won't even be allowed to change BARs, proba=
bly
> > it is still the case for phyp. So since the initial commit we have [1]
> > which prevents resource reallocation.
> >=20
> > This is not a problem until we want specific BAR alignments, for exampl=
e,
> > PAGE_SIZE=3D=3D64k to make sure we can still map MMIO BARs directly. For
> > the boot time devices we handle this in SLOF [2] but since QEMU's RTAS
> > does not allocate BARs, the guest does this instead and does not align
> > BARs even if Linux is given pci=3Dresource_alignment=3D16@pci:0:0 as
> > PCI_PROBE_ONLY makes Linux ignore alignment requests.
> >=20
> > ARM folks added a dial to control PCI_PROBE_ONLY via the device tree [3=
].
> > This makes use of the dial to advertise to the guest that we can handle
> > BAR reassignments.
> >=20
> > We do not remove the flag from [1] as pseries guests are still supported
> > under phyp so having that removed may cause problems.
> >=20
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/arch/powerpc/platforms/pseries/setup.c?h=3Dv5.1#n773
> > [2] https://git.qemu.org/?p=3DSLOF.git;a=3Dblob;f=3Dboard-qemu/slof/pci=
-phb.fs;h=3D06729bcf77a0d4e900c527adcd9befe2a269f65d;hb=3DHEAD#l338
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Df81c11af
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >  hw/ppc/spapr.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 6dd8aaac3340..84d16f9edaca 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1209,6 +1209,9 @@ static void spapr_dt_chosen(SpaprMachineState *sp=
apr, void *fdt)
> >          _FDT(fdt_setprop_string(fdt, chosen, "stdout-path", stdout_pat=
h));
> >      }
> > =20
> > +    /* We can deal with BAR reallocation just fine, advertise it to th=
e guest */
> > +    _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
> > +
> >      spapr_dt_ov5_platform_support(spapr, fdt, chosen);
> > =20
> >      g_free(stdout_path);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kkcDP0v44wDpNmbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz4lZoACgkQbDjKyiDZ
s5IqwQ//X/8Y3WY26rO+mUvJ4pWXKHAAcwVtsv37ow8u5txrudreM1IqXIsmZJNs
D83949SCXL/NipqrpXLKEumDpblqkIHyQs3VzZkzFns0zoMmJASVX30yW0A0hu3Z
zw3NR12zLotPKbaH2LcBIBXcwaegOFV4FfCBwbAOn+7ftZFxo6kgxfW3BaLS+OD3
3Qwnmyl85gISrf9EIyiXFIsa93f8Tu+n2arPmC/siLbkwU5RyUXloLy5gPShUP4j
p8GWVCKG5ZfQBm4HKE0G7hB4kbo47mAeJim8sOrB8h+K2UwLTgKz8Arzcitn0MCv
mVVt/pYNPT/IR06mns9mQdY+V7Bft2IrJlmUkRfMhYs2WSODsHyiHoFtuMuPm9G1
Wm+j19lbhiq4wFW8Kvtw2lFkkNVFu2YcCfrP+D/Ie+YN+VoRDCI/czVxvYKHU0v7
fHB7gWqip9qW8BgzSTKKQOUYXl3u90TkC5okFX17EzYLqCrCShOOsC7mqa8c9K69
WBHyLbRlvQ+poOOm8lRD9ZAC6wH0aqV7qKJQrt3mVBWunGTNmJVHF4/iXxZZ3ObM
+teSMNqaCBZGMN+kPyco0/3ofLgSu+p2ZBFU302cw81pgI+SPAqRr33m5AVO31GH
dgal4TGENrf+n/3+JNonsGzbLsELLmjiUoQMA4C3CRT7aOfs4a0=
=lJws
-----END PGP SIGNATURE-----

--kkcDP0v44wDpNmbp--

