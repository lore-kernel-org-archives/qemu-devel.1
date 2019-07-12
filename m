Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577F7C742A1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 01:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2486D21019
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 01:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NXpRjEl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2486D21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlkEv-0002xz-Sj
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 21:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55597)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hlkEb-0001we-8C
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 21:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hlkEZ-0003QC-38
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 21:20:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52177 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hlkEV-0003JM-E3; Thu, 11 Jul 2019 21:20:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45lFTm4jmSz9sN4; Fri, 12 Jul 2019 11:20:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562894412;
 bh=TbxgRAd9L59D3rUTIDcULPrzz+lpNGkzv05bZeb2fRE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NXpRjEl/0GpxJiAVlP2fV/gXbiizXT/n4EhuSMI3G7GyF9pmN0p15FUxlBF2kUsUC
 h1ptnMhgEKCqVqvW+U3iWawPNubYvTeoYr+9IGNHBKE9LEOAKRdeZh4fbQ9LInWK1f
 ZS9csMTgFCmJ0sYBZTAPI7uaBfb2Mwz4/SN16LKw=
Date: Fri, 12 Jul 2019 11:18:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190712011817.GD2561@umbus.fritz.box>
References: <20190606040919.110655-1-aik@ozlabs.ru>
 <20190612061103.GC26378@umbus.fritz.box>
 <02bf721f-26e6-91d4-88ec-371e959e4161@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <02bf721f-26e6-91d4-88ec-371e959e4161@ozlabs.ru>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] spapr_pci: Advertise BAR reallocation capability
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
Cc: Shawn Anastasio <shawn@anastas.io>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 11:37:45AM +1000, Alexey Kardashevskiy wrote:
>=20
>=20
> On 12/06/2019 16:11, David Gibson wrote:
> > On Thu, Jun 06, 2019 at 02:09:19PM +1000, Alexey Kardashevskiy wrote:
> >> The pseries guests do not normally allocate PCI resouces and rely on
> >> the system firmware doing so. Furthermore at least at some point in
> >> the past the pseries guests won't even be allowed to change BARs, prob=
ably
> >> it is still the case for phyp. So since the initial commit we have [1]
> >> which prevents resource reallocation.
> >>
> >> This is not a problem until we want specific BAR alignments, for examp=
le,
> >> PAGE_SIZE=3D=3D64k to make sure we can still map MMIO BARs directly. F=
or
> >> the boot time devices we handle this in SLOF [2] but since QEMU's RTAS
> >> does not allocate BARs, the guest does this instead and does not align
> >> BARs even if Linux is given pci=3Dresource_alignment=3D16@pci:0:0 as
> >> PCI_PROBE_ONLY makes Linux ignore alignment requests.
> >>
> >> ARM folks added a dial to control PCI_PROBE_ONLY via the device tree [=
3].
> >> This makes use of the dial to advertise to the guest that we can handle
> >> BAR reassignments.
> >>
> >> We do not remove the flag from [1] as pseries guests are still support=
ed
> >> under phyp so having that removed may cause problems.
> >>
> >> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/arch/powerpc/platforms/pseries/setup.c?h=3Dv5.1#n773
> >> [2] https://git.qemu.org/?p=3DSLOF.git;a=3Dblob;f=3Dboard-qemu/slof/pc=
i-phb.fs;h=3D06729bcf77a0d4e900c527adcd9befe2a269f65d;hb=3DHEAD#l338
> >> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/commit/?id=3Df81c11af
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >=20
> > Changing a guest visible property, that could have a big effect on how
> > the guest behaves, without a machine version change seems... unwise.
>=20
>=20
> As a general rule - sure, not good. In this particular case QEMU has
> always been able to cope with BAR reallocations.

That's not really the point.  What I'm worried about is some old
kernel version running on a guest in the wild having a bug here and
the supposedly compatible qemu change breaking it.

> What could probably
> make sense is having it as a machine option (pci-probe-only=3Doff by
> default) in case if we find some old kernel which cannot handle
> "linux,pci-probe-only" but I seriously doubt we'll find such a broken
> kernel - I do remove the probe-only switch from guest kernels on a
> regular basis last 7 or so years when debugging.

Yeah, doing it when debugging isn't really the same as exercising it
in production environments.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0n39gACgkQbDjKyiDZ
s5IUZQ/9GQ/vjwx58UVqf7trvE0GgxWAlEZaZARULdLRVCK++gsNqfUBEA9VHY1l
4i1lXnd7bCBXL4KeICSdM54Qm/itAODyVmsCSX97X734HLFka+DN0n0SMJkYi1th
TDQt4LwgREfvlz5g1PDIjm2d4rXK0L2DxfiJ8WYSCrvbMtiSF1E7j99/Utte68Oq
sjURTiPSMX7A7kQjonOHk2FI2bQC9xVE0w/lb1/uxx9FXjgPfFQwL+RuJ87Dx1Ft
NfYVMD6gPSWYhlmTl+fh+9aO7+780GRjz3VVK3XBTv4gCroUDE7QxX+pTuYCMo2s
0smFdC08LHDZ3pfGXB0cwMy129CDvOTdrOM54085rdOip1rVM5KZle+xC3AFFRiQ
yc9thg9aM+rh0Jtrz1ISCHnQ+sfGVeyzYl6nnMDQzxQJSvnoyHv2E+mSPaM3eYOo
+sD5ZOUN9ZL6o/KH6oU42L09XURsCm+9aSxvWnpZbvmTDFBsSkMMkdShF/2hYgQR
Ag/9imXrr2qHjDFiA7nk9uj3+Q/foW3ItN0qBBJgoXPw72I0fuIjrx+W2bELnTMr
losIN75HAh1Jt+Of5nRTLyz2xVSeHDfAxCj2Cz7hBjxJUie8X7uInRo3i1f50oOe
kXfi1zJmZyCb+4rIP1SRC5tNazHncKq00xQqO7AS5W/oJXFiRh4=
=z7tB
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--

