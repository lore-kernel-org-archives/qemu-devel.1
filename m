Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D75C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 01:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96EDD2067D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 01:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WZ5445b3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EDD2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXxbo-0006DR-Mr
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 20:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXxan-0005oS-9L
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 20:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXxal-0001aK-Hl
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 20:18:37 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:56873)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXxal-0001Zx-7E; Thu, 21 Nov 2019 20:18:35 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Jz8S3BbDz9sPc; Fri, 22 Nov 2019 12:18:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574385512;
 bh=KdifFQ/CVA5FEDqGjslXCMovs4mIoW+xiz6Ia0QVjJc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WZ5445b3MQQphhzUfciMmBVcuA2w/zSfXilrZk9wb6sf6zMiieRNCVAF9Nxq6IZzk
 AKsOr5LFY176dFB++k572XGc29eEXwGltIGnt8WqrjZLv5iBiKDVjjJ5ahNmAkkBcF
 65tq5ixmm4kvLd+7la6xoSpYs/G4p96ElJWF2fFo=
Date: Fri, 22 Nov 2019 12:18:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/5] vfio/spapr: Handle changes of master irq chip for
 VFIO devices
Message-ID: <20191122011824.GX5582@umbus.fritz.box>
References: <20191121005607.274347-1-david@gibson.dropbear.id.au>
 <20191121095738.71f90700@x1.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TSjqTFuQ28AYToVG"
Content-Disposition: inline
In-Reply-To: <20191121095738.71f90700@x1.home>
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
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TSjqTFuQ28AYToVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2019 at 09:57:38AM -0700, Alex Williamson wrote:
> On Thu, 21 Nov 2019 11:56:02 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Due to the way feature negotiation works in PAPR (which is a
> > paravirtualized platform), we can end up changing the global irq chip
> > at runtime, including it's KVM accelerate model.  That causes
> > complications for VFIO devices with INTx, which wire themselves up
> > directly to the KVM irqchip for performance.
> >=20
> > This series introduces a new notifier to let VFIO devices (and
> > anything else that needs to in the future) know about changes to the
> > master irqchip.  It modifies VFIO to respond to the notifier,
> > reconnecting itself to the new KVM irqchip as necessary.
> >=20
> > In particular this removes a misleading (though not wholly inaccurate)
> > warning that occurs when using VFIO devices on a pseries machine type
> > guest.
> >=20
> > Open question: should this go into qemu-4.2 or wait until 5.0?  It's
> > has medium complexity / intrusiveness, but it *is* a bugfix that I
> > can't see a simpler way to fix.  It's effectively a regression from
> > qemu-4.0 to qemu-4.1 (because that introduced XIVE support by
> > default), although not from 4.1 to 4.2.
>=20
> Looks reasonable to me for 4.2, the vfio changes are not as big as they
> appear.  If Paolo approves this week, I can send a pull request,
> otherwise I can leave my ack for someone else as I'll be on PTO/holiday
> next week.  Thanks,

I'm happy to take it through my tree, and expect to be sending a PR in
that timescale, so an ack sounds good.

I've pulled the series into my ppc-for-4.2 branch tentatively.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TSjqTFuQ28AYToVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3XN2AACgkQbDjKyiDZ
s5Idrg//Zi3qN0NY13bJ7dayNXGDN0HmvV/p9pq189gpWGVrZZoONYrSOcIiiRUm
edRPMhyQfKFYpkIVpoU95cJKmLpzbYh25DsTWS8Q9iqlNbWlBJ2ER4q84NU719aK
LkSiwV35UCEWE+BJTmCRWhc3sw66+DgPJN3LiazovGySRu6JEk/obuxs2gKhx7IJ
kX69lF0Y2/hXjRcz0tb4yt/sAcPNO2/YPdbcgl0+W58s4MTYfvpZlgU5JaCC9qFJ
63bPkLNM/agyfhXOCsrptnU1uXwCatVEcNpQOwU2hCS8d+Akjg8Y7FSiZtE3E+D/
HeUNmulsav6SurXTLRvJo5m346b8BfgmwNOkV3SCaSGJYW1cz/LxG/y51v0A4gPt
6NU4ec7GGNQnCDIM9D3KHnuQAY9IJnLuGOV+zShXYacoYdAU3ZMSkq6JZyqTf2Jt
jBlYCCzku0wd3DQU/iUIp/ClMbnJNambcppim2HNQNp37JxFYw3Y2jzrnbNcIRvK
sOUrGGVNfKRz9GFbvXkD/tRvRdxP5y8mZ1qhh33X3w0PpXEKJ69G+FPzfMARCQlw
cZRDDAdHebQK+8ePplR5eH3hs8iX8o74Pdo2tXuVvRPU/7MCU924XFDIanG3yEsa
Zz1EKdxOA60JeeliL4ljQBBxSkvSBK3bRVcr25Gy3LH8y6gW1WQ=
=U4IZ
-----END PGP SIGNATURE-----

--TSjqTFuQ28AYToVG--

