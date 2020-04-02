Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC104C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 06:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB43920784
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 06:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Iq70nZvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB43920784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJthM-0003XW-Si
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 02:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jJtgZ-0002gl-7D
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 02:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jJtgW-0005R2-7e
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 02:50:41 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35579 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jJtgU-0005MH-NX; Thu, 02 Apr 2020 02:50:39 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48tDGd4Jzpz9sRR; Thu,  2 Apr 2020 17:50:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585810233;
 bh=J+5T18ET9ygWa3enEx5H28hAVvhFFhrtRuiBPG8g2AA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Iq70nZvWtqCFjWp6geLkydOFGflQw4vU+r07OZ4E10/XrPyG/ASPJWHOQAiZ0aGtE
 7pkC4Ygo0SQd42/bYve+rnFVTZcwzuQhlYbOKk7BMvnX45ZXPDBrGF+nYu/cQHqorc
 GUqQNkIBOLQqe/bghayi9ddzEHewnXOZyJgz+xxo=
Date: Thu, 2 Apr 2020 17:50:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Introduce common PNV_SETFIELD() and
 PNV_GETFIELD() macros
Message-ID: <20200402065027.GM47772@umbus.fritz.box>
References: <20200401152633.1375-1-clg@kaod.org>
 <20200402003118.GJ47772@umbus.fritz.box>
 <b7663796-c9ad-c91e-104a-dcf78e467607@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pP0ycGQONqsnqIMP"
Content-Disposition: inline
In-Reply-To: <b7663796-c9ad-c91e-104a-dcf78e467607@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pP0ycGQONqsnqIMP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2020 at 08:41:24AM +0200, C=E9dric Le Goater wrote:
> On 4/2/20 2:31 AM, David Gibson wrote:
> > On Wed, Apr 01, 2020 at 05:26:33PM +0200, C=E9dric Le Goater wrote:
> >> Most of QEMU definitions of the register fields of the PowerNV machine
> >> come from skiboot and the models duplicate a set of macros for this
> >> purpose. Make them common under the pnv_utils.h file.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > Hrm.  If we're touching these, would it make sense to rewrite them in
> > terms of the cross-qemu generic extract64() and deposit64()?
>=20
> I won't do that because we will loose compatibility with skiboot.

Uh.. how so?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pP0ycGQONqsnqIMP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6FizMACgkQbDjKyiDZ
s5IqHQ//W2LLkneojTeSjrKeniQetqtfONav0qGiuWTzdwwDi+zRDnlHh+1bM559
lYYaJrfFuxeZDXtLcsPI6Ij+r6qdnNbWkgvDyHyIQFiOBhHjWjPfo3Pnk5bYYWbj
j4SJal+gKWpj+J+vXkFbLuFR9H5bYtrJelZRiafKf5j8wALhaZE7eiXKGAxhU0CW
Xax3ViDY4FVcsXpjeL3q1Tu/CEp5Yj6QqmkGOuFhfkvzfJaWdkR3LvOBNywEE4F9
vWPAUGvMqPIIyLNMANnCVgLM3MxrCj80S+g/9rDZ39B6OFp1CFvpyLskgWLQsEye
4Dx6SncyyDhj/jL8UMVvcqHWXJrIWHo3v6j3PpL4I1RaMRdV1RqWrdIZJs3SKpBm
qdnn29s38Cv4VOeayNvcR+Dya7SihFx8jvsGlUG03DnscHdqUs6O3uooRi8+B5Qc
ClAdVCW1cxjmoasjF18KTtjjJ3zBuAGsORu6PSTPtuPZNm8BcUtpmPI0LrCh01xv
1r9LT3DqNHma4Ul/hi2S8aZeR/nPminyK96OFR61fFfKA9QWdFhjBo2RVFvdyomw
b8QHwxeiM3q1bMD6ZCouMK4L/8llodtV5zACDvA+Lo4FF11664Ssxy5+UjjKT0+L
wYp5bbpeo3ySkRAacwOq4ixNLpQS7lYztnQiyZsaEe1fS60DgM8=
=oR65
-----END PGP SIGNATURE-----

--pP0ycGQONqsnqIMP--

