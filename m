Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374A8C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 06:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34432073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 06:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Bwq5X2F7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34432073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKFmv-0002bG-0k
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 02:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jKFm7-00024Q-SL
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 02:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jKFm6-0002sP-25
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 02:25:55 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:58317 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jKFm4-0002ov-TE; Fri, 03 Apr 2020 02:25:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48tqgY1pd2z9sRY; Fri,  3 Apr 2020 17:25:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585895145;
 bh=BqHNU4ipXF1bbA6x+sGMAi8JA4hIeHk4JCILiMxb0fQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bwq5X2F7kaZ98bjiJuUNqgHc8aIJIDyd4t4aZSTr02iSalJfLejKGHzfk3+wMB40C
 GdJylL7HNFMWaYlgbEo84nHuONbjgHym9W+xHcUbwOMriBOoKEBVOyrbtEMf/nRIus
 FnOstqRvrcMl7sAZIxE5lgnqduasJXzZpb15fHA8=
Date: Fri, 3 Apr 2020 16:12:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Introduce common PNV_SETFIELD() and
 PNV_GETFIELD() macros
Message-ID: <20200403051240.GV47772@umbus.fritz.box>
References: <20200401152633.1375-1-clg@kaod.org>
 <20200402003118.GJ47772@umbus.fritz.box>
 <b7663796-c9ad-c91e-104a-dcf78e467607@kaod.org>
 <20200402065027.GM47772@umbus.fritz.box>
 <d58b2e61-8245-ecbb-6f0a-31b2ea64835f@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i13qRg9tmWEwo36p"
Content-Disposition: inline
In-Reply-To: <d58b2e61-8245-ecbb-6f0a-31b2ea64835f@kaod.org>
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


--i13qRg9tmWEwo36p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2020 at 09:18:09AM +0200, C=E9dric Le Goater wrote:
> On 4/2/20 8:50 AM, David Gibson wrote:
> > On Thu, Apr 02, 2020 at 08:41:24AM +0200, C=E9dric Le Goater wrote:
> >> On 4/2/20 2:31 AM, David Gibson wrote:
> >>> On Wed, Apr 01, 2020 at 05:26:33PM +0200, C=E9dric Le Goater wrote:
> >>>> Most of QEMU definitions of the register fields of the PowerNV machi=
ne
> >>>> come from skiboot and the models duplicate a set of macros for this
> >>>> purpose. Make them common under the pnv_utils.h file.
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>
> >>> Hrm.  If we're touching these, would it make sense to rewrite them in
> >>> terms of the cross-qemu generic extract64() and deposit64()?
> >>
> >> I won't do that because we will loose compatibility with skiboot.
> >=20
> > Uh.. how so?
>=20
> What would be very nice is to use the QEMU FIELD() from "hw/registerfield=
s.h".
>=20
> But that's a complete different approach from what skiboot does and it wo=
uld
> mean rewriting all the register definitions we include in QEMU for the po=
wernv=20
> models and the code using the fields. It is a major change and I would ra=
ther=20
> have the same files on both side (without tabs on the QEMU side). I think
> it is safer.
>=20
> Using extract64() and deposit64() raises the same kind of problem AFAICT.=
=20
> If we find a clean way to keep the register definition files the same, I =
am
> OK with any changes.

So, I wasn't suggesting changing all the users to use
extract64()/deposit64()/FIELD().  I was suggesting making the skiboot
like versions a wrapper than translates the arguments into the right
form for FIELD() or whatever.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i13qRg9tmWEwo36p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6GxcgACgkQbDjKyiDZ
s5JALRAA5Uj21DnfjrRUCg4vsdTRIx927yMADSrBcCAxzpTrWoqOpm7Nh+0+DLSu
51rM6XbEo1kbfA7bR/6gPYM6KbBl6R4a56yiEFoByMu2+y2lZrlxBJ1mm6sdcsjs
vRNcWYd1zjpMULq7GcZXbeRASeqgvyKvB1RunWGVp8EJyuCEeAmVzDFQnLD4myXO
Lm/LLkeov1YTZOfIFDEG7FKEzEoNs8owgjnUEsTGYNSMS2Lljlo1CJqn+Sh1AAZE
amm5Pq0Yo8EABCbg3v0OHbuJ8RFFs3eFetAZJUGHkdTuN3dOaeghKKB0b/dcVz26
IJtPr+r0QWega8kUKdiSUjGKFdCHUDckHobnCvKrvFlLIpgxoEwgOItTCCEZ2a5z
k0rw2J2Mx9FniLVLQXTJGNfgvBSvdhQ2EfiLrQJEIa2nYyNCWLMOAIUtYq5rE48G
6jJQNh8FB5/ei007WIQ4XU+u8Au9U78NfUuvullsgWgF5R6oULM9rQldnbGoVtOK
W2rD3XmHAt+yDJhSJP16hxYbDp84UTR3L5fk6o60d6bqXwpfnLZJibIqvohKu1ey
UvytcGNfeST7dERpAkgaPSgYQunIZpkcS93Bub1jIPzTO8x9domehQHBtQ7ZW5bk
UredoO5jS5LHW8LxcIlJazriz8e7U/4zx2amdq2GTkno7VXPdS8=
=CFwY
-----END PGP SIGNATURE-----

--i13qRg9tmWEwo36p--

