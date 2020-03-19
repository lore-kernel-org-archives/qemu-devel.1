Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B840C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 05:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B152072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 05:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AXlIZ1YO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B152072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEnm8-0007p6-VG
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 01:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jEnjm-00052z-Vw
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 01:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jEnjl-0004Ln-3v
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 01:28:58 -0400
Received: from ozlabs.org ([203.11.71.1]:44661)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jEnjk-0004C2-3z; Thu, 19 Mar 2020 01:28:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48jb6r0QCtz9sSL; Thu, 19 Mar 2020 16:28:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584595732;
 bh=H9asLVdVOyChPGOPFihn2KaLW865pG5gIXie1nXXMjc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AXlIZ1YOiZdN4ZRnnDM3FKSF6aLO+xIDlfna4R3PJaIVnhuuVOqH9aOrhTkXlQ54D
 +uD78NUpBdiW9YcO60wjkeQA/6SEzBzYbZAUOi4Rb76K6s+U1K6ThHYpIJWo0p+Xus
 D/MHpgnw+Kxwt2z+KB2TI4CyIEjbTxg+y21yKw3g=
Date: Thu, 19 Mar 2020 16:22:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [EXTERNAL] [PATCH 2/2] target/ppc: Fix ISA v3.0 (POWER9) slbia
 implementation
Message-ID: <20200319052206.GG628315@umbus.fritz.box>
References: <20200318044135.851716-1-npiggin@gmail.com>
 <20200318044135.851716-2-npiggin@gmail.com>
 <47de57fe-189f-aef1-87f4-d9e2b5d31b22@kaod.org>
 <c534dd84f3e8509b7d8f1e844e48ee0dfaa3c420.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eVzOFob/8UvintSX"
Content-Disposition: inline
In-Reply-To: <c534dd84f3e8509b7d8f1e844e48ee0dfaa3c420.camel@kernel.crashing.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--eVzOFob/8UvintSX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2020 at 07:46:54AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2020-03-18 at 18:08 +0100, C=E9dric Le Goater wrote:
> > On 3/18/20 5:41 AM, Nicholas Piggin wrote:
> > > Linux using the hash MMU ("disable_radix" command line) on a POWER9
> > > machine quickly hits translation bugs due to using v3.0 slbia
> > > features that are not implemented in TCG. Add them.
> >=20
> > I checked the ISA books and this looks OK but you are also modifying
> > slbie.
>=20
> For the same reason, I believe slbie needs to invalidate caches even if
> the entry isn't present.
>=20
> The kernel will under some circumstances overwrite SLB entries without
> invalidating (because the translation itself isn't invalid, it's just
> that the SLB is full, so anything cached in the ERAT is still
> technically ok).
>=20
> However, when those things get really invalidated, they need to be
> taken out, even if they no longer have a corresponding SLB entry.

Right, the slbie change is certainly correct, but it doesn't match
what the commit message says this is doing.  Nick, can you split that
out please.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eVzOFob/8UvintSX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5zAX4ACgkQbDjKyiDZ
s5IMlg//TyXU01vHA0xYiQnXgnKWgbHbG2Gi4ltnvhnQu+UvUmq82m7y1c8uk1XG
HmyX7myDaSydnSYPfi9QQyonlvqfoEsb4R06F7bij0U4e8bdJdpVzoS4S764ndOb
reLWoGdc2K+YIvc0bIemH2adyrrnVXPMrnPdKPtTENi6ZiTPbGGKiskoJE8NhhGF
SN/vRvS2YtAhwJF5Sw8dGU8HlVFSzE8An57fwnFpf9PKuYHqsHs/NFHjs6pZBae1
qG3mXlimxRxaJXXeNnwjiiTe0cB5lhgKUw83xQVnz5nUv6/3gDyXNjgeGCiNYB/B
woIT/9eIL9bmKO/J4Hfa3WuaFrHJcZ6h/H2+peVor9/0dZYx9Uy4dFprpazhMUmr
Oonwlya5OTJzLhkxEYT/9gXc3HEvIjULgMfYIxWq30kSjWauN5QrrM5N7Z3woFam
tyhb6nIAsR06yYAc8gxEYpmT5TEum1CKgsCcp/tlYF6KomBrxL7BuKFzqCZAGLjG
x97b4TjyYiI3h3ZvwlkfztFPWXy4OaTfiiAw1umswt16l4eTOqqB/l+ylmdoxynu
prKJnKfofbFJuOBNV2h3rMc97e0viKUW14a1Wmz192m6GFC0fYYMEIg7aa+mOWHg
QKJz/H2xpXnjJc1FYhlfBuz6DniAn3tV56Tzy+izCNhYdhA0RsQ=
=cshv
-----END PGP SIGNATURE-----

--eVzOFob/8UvintSX--

