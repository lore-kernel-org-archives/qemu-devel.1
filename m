Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70796C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F786205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KpXZ6K7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F786205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDzEt-0000pa-BA
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 19:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jDzDa-0007dS-E4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jDzDZ-0005eH-2n
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:32:22 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:54483)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jDzDY-0004wu-7O; Mon, 16 Mar 2020 19:32:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hCJJ2Ck0z9sR4; Tue, 17 Mar 2020 10:32:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584401536;
 bh=ahwy71KaFLrYpotUkY+WlCpG36KcTmUiBZfVKq5O+Es=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KpXZ6K7N0NX9HyT7L6xnSy6Ls+nyDo95QEjtxM74kM2H5uaTBfCSet4o8DuLHpTOG
 /NqcFj6pwYN9Vgn+yJeQQCl4DinlXTME7PxeyyGJ1n7aAXk//BPY8APYrtlNjEiX6r
 d2fPPV9x3MOrEg0D7w//K2OUgHp19M+qMAru+3b0=
Date: Tue, 17 Mar 2020 10:27:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/8] ppc/spapr: Fix FWNMI machine check interrupt
 delivery
Message-ID: <20200316232700.GE20264@umbus.fritz.box>
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-5-npiggin@gmail.com>
 <2ff9bfbf-5a6a-2a79-e14e-4b7c76aff062@kaod.org>
 <1584400226.tr4pv2h852.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Content-Disposition: inline
In-Reply-To: <1584400226.tr4pv2h852.astroid@bobo.none>
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 09:19:57AM +1000, Nicholas Piggin wrote:
> C=E9dric Le Goater's on March 17, 2020 3:59 am:
> > On 3/16/20 3:26 PM, Nicholas Piggin wrote:
> >> FWNMI machine check delivery misses a few things that will make it fail
> >> with TCG at least (which we would like to allow in future to improve
> >> testing).
> >=20
> > I don't understand which issues are addressed in the patch.
>=20
> The existing code does not compute hflags, at least.
>=20
> There's a few possible other things, I didn't dig into qemu enough
> to know if they might be a problem (e.g., reservation and TLB). I
> figure it's better to keep these consistent.
>=20
> Keep in mind this is a bit academic right now, because we can't
> (AFAIKS) inject an MCE from TCG. It would be good to wire that up,
> but I didn't get to it.
>=20
> >> It's not nice to scatter interrupt delivery logic around the tree, so
> >> move it to excp_helper.c and share code where possible.
> >=20
> > It looks correct but this is touching the ugliest routine in the QEMU=
=20
> > PPC universe. I would split the patch in two to introduce the helper
> > powerpc_set_excp_state().
> >=20
> > It does not seem to need to be an inline also.
>=20
> Yeah it's all pretty ugly. I didn't yet find a nice way to do
> split things up that did not require a lot of code churn, but that
> can come later.
>=20
> Inline was just because powerpc_excp is inline, I didn't want to
> change behaviour too much there (it obviously wants to do a lot of
> constant propagation but maybe only on the case statement). Anyway
> I just wanted to be minimal for now, it could be changed.

Yeah, I definitely want to get this in, so despite imperfections that
could probably be polished with time, I've applied to ppc-for-5.0.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5wC0QACgkQbDjKyiDZ
s5K1GA/+PslSnOoaK8aLvK25GLu8vYS1GM4H2+DVI3R5QMNFjK8Dw4xZO+qQt6Bd
BW8D6SriD/oF96366ABvhzgvVAtZqljLntfuRRwH4SXMLqlBgjeuHg9qHMKiddeh
w/OqLTp7OM4S+NikTM/xljVI9Akh9vE8zv6K57xOjoPJ1Kyvtqf2NdN7gSc2nCmp
auIQj8DZTBEcorw7hSqHVUgfJZ7LGuNQ8XHEq6xAwK4mNDpyrD2uiMOHNbfsnpy2
UK63WUfWOstLltbprpkGstA0/wlFJkiNdypP9UlQDKVBiPd9FHyIohAkMIStfQNQ
7yo6kI+HtbkTFmI+B8qmcpKUz2hzLI9HVd9O4zrQBilDc4VEooYKvagS2gWOAC48
WK4cJyizx7pBrOClpY1gu+i+IoYzDgNUnj2MEaCEMrU2Qp4FJaLhB0f2QkMx/Guv
IvUnDO0I5c05YD+N4A3U0nZAUdqeLy9oX/Kc8gPNNv1PcIYhBEpAGSq+f91Iq8Qo
GtHM3PfrGiNheCU4viENz+UCSYLDpTEsNbCH/a9v0vqS/vru5pJQQQOVU3h8ndls
QwMLoCp0oRAe8NqvukHyk5uvakey2TZyAHxLu+oMupa4kd+WEgILXWEtZgbVeF+a
WkxXCDuNjdMGfuLglP2Feg0NQCThJZJnJeE2c23B5URH8P8j4Vo=
=SUqr
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--

