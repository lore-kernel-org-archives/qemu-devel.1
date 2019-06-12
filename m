Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D787C31E44
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 01:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081B720874
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 01:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IKEQub94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081B720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56100 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1harvF-0005n8-75
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 21:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50260)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hartZ-0004rH-8w
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hartW-0002m0-L4
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:17:45 -0400
Received: from ozlabs.org ([203.11.71.1]:34311)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hartT-0002l7-SU; Tue, 11 Jun 2019 21:17:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45NprY6gLWz9s3l; Wed, 12 Jun 2019 11:17:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560302253;
 bh=ovMKE6pHSdxzZ9VKw/v+VvSHJVOXMBw/AaGAio9eCg8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IKEQub94heYR2ZD1w370Dj/zPOd+VTr/Ok4VsORQaCfa6nK/NFmdMBiDkeA7LISjM
 FD8C7piUjDtuinBj2gG7T4jvuBbYVEtZzCmi1Ckydd+JeWSu70btQYcbCsjHLk2fmv
 e1HYIepUu+NgGrK1L+i9c0KAU2GXiQdVbVly5IRo=
Date: Wed, 12 Jun 2019 11:06:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190612010613.GE3998@umbus.fritz.box>
References: <20190201004012.13237-1-aik@ozlabs.ru>
 <b799d329-3336-715f-bf03-776856ecb1bf@ozlabs.ru>
 <20190214033040.GZ1884@umbus.fritz.box>
 <6f6b6388-f9bb-6cf9-6495-b43952bf1b4e@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline
In-Reply-To: <6f6b6388-f9bb-6cf9-6495-b43952bf1b4e@ozlabs.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH qemu] spapr/rtas: Force big endian compile
 for rtas
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
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 10:29:55AM +1000, Alexey Kardashevskiy wrote:
>=20
>=20
> On 14/02/2019 14:30, David Gibson wrote:
> > On Wed, Feb 13, 2019 at 05:00:50PM +1100, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 01/02/2019 11:40, Alexey Kardashevskiy wrote:
> >>> At the moment the rtas's Makefile uses generic QEMU rules which means
> >>> that when QEMU is compiled on a little endian system, the spapr-rtas.=
bin
> >>> is compiled as little endian too which is incorrect as it is always
> >>> executed in big endian mode.
> >>>
> >>> This enforces -mbig by defining %.o:%.S rule as spapr-rtas.bin is
> >>> a standalone guest binary which should not depend on QEMU flags anywa=
y.
> >>
> >> Bag? Good? Useless? :)
> >=20
> > I missed the original send of this, I'm afraid.  Looks like a good
> > idea.
>=20
> Totally forgot this one. It is still in pw:
> https://patchwork.ozlabs.org/patch/1034543/
>=20
> Or you want a repost?

Repost, please.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0AUAUACgkQbDjKyiDZ
s5K+sRAAnh6EHoBX8Lq1EDp13Uukdvf9X9hMO/D+yoWZORxJeainaD1a/GwWBbAB
JqerjqJtgP7KeR2JM/tFrwxdWFXdUu/JSnnIkmvfWT/LhMNlvWn2fQIIGsrQ1orf
KeBlTEfiaM/L5+Bz+wpLOpfy0RVr1Wd37VNVYpv1wZiPt/PCrGElWtQ+dwAmavYT
Hcl7y0AUTY5nk3LeYd3Aia+gKMfIlpSHsjxSdPFvmyqHZSAKHKAKNOCFctNFk15F
Inu43/i4MPRcGLcyoPqsqU3sSIa50C/ULbZIdD8fFG+EwsMmxW3N5xo1vBuF0liW
ERAG0Yhw1tdnOFkOkVOrf9VD668OVcC89m1RPzyEZvIZNsfzGJcFKS1ftpWVkXOQ
m3knO4aJdHeSEF26AZoo437IiZT41PEnTkruUNXqU4uNQWaO6u8mwXsfd3BH9F8Y
oWtboLHNiaEoiIYXlKQE8o9lBJxAXijaq2eYnH1Te9Ku2+6YjwT719xlLQH+kJSy
iR4SfghLw85Y6wMPG9rVuIb66U/qGmNxIA0gxYkz/pZab/01m+FPOELur16wSpLE
txCm8GvYxIX3pThabOweLCehH8kgZ8dnPu+SQ4gMmuPYx8jh3ecpgFZUViGXQBoW
s6HuoDep/rmT/TYhgVwHj+4on+hTiQJEq+cbPlzXREKhWmgp2bE=
=P/Sh
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--

