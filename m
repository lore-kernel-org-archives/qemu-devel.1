Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86EEC0044D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 01:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F71D2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 01:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MgPZuIHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F71D2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE0j6-0004HZ-Lj
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 21:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE0iS-0003ly-E1
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 21:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE0iQ-000779-Vx
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 21:08:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59387 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE0iP-0006j5-MK; Mon, 16 Mar 2020 21:08:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hFR13k9Xz9sPF; Tue, 17 Mar 2020 12:08:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584407293;
 bh=8+WoWNWXbtcCs2OCjVZ5Yhv0Zx+CMFICz9zerPvSVP0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MgPZuIHf/gAQSTr6c224i5KuQSNpZ1ZYbPKldBgTa3/vm1ZsqwOF6aAX1Y6woyN/r
 bEtfQj0me3BOPP7Tu4gaf6DxAZ32OuNFMdjQUsGxe8cJri+CFzAdFNEW2G1yZ4acMx
 ZEvy/9XNfFPjHC1jtGLFzQDw1sW7DkDa3nIs3ssw=
Date: Tue, 17 Mar 2020 10:34:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 6/8] target/ppc: allow ppc_cpu_do_system_reset to take
 an alternate vector
Message-ID: <20200316233407.GK20264@umbus.fritz.box>
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-7-npiggin@gmail.com>
 <85cfff63-88e3-b5a5-75e3-aa29ac13ff60@kaod.org>
 <1584401195.r6knelt82x.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NqNl6FRZtoRUn5bW"
Content-Disposition: inline
In-Reply-To: <1584401195.r6knelt82x.astroid@bobo.none>
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NqNl6FRZtoRUn5bW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 09:28:24AM +1000, Nicholas Piggin wrote:
> C=E9dric Le Goater's on March 17, 2020 4:15 am:
> > On 3/16/20 3:26 PM, Nicholas Piggin wrote:
> >> Provide for an alternate delivery location, -1 defaults to the
> >> architected address.
> >=20
> > I don't know what is the best approach, to override the vector addr
> > computed by powerpc_excp() or use a machine class handler with=20
> > cpu->vhyp.
>=20
> Yeah it's getting a bit ad hoc and inconsistent with machine check
> etc, I just figured get something minimal in there now. The whole
> exception delivery needs a spring clean though.

Yeah, there's a huge amount of cruft in nearly all the softmmu code.
It's such a big task that I don't really have any plans to tackle it
specifically.  Instead I've been cleaning up little pieces as they
impinge on things I actually care about.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NqNl6FRZtoRUn5bW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5wDO4ACgkQbDjKyiDZ
s5L01xAA2pLkGIGIuA9QVSsB09AaYic8To6WfJyS0aw/ePPRcGeCj0QlaD4i/F8I
UK0Nvs+LhbWM9YxdkEOvc0FrWrDcmjMUVMEq+s0YMniqoTxFpIoFG92tIsHTpyvI
2oIbQXPtE1c0vTDqwEyBnpX5IMVvz8p1awJpyctGmgD5z+4EMLrYVRT+4w4O6K9E
DQkdpF8/HZOnK+4SQBNMAbxlrt9fS3J8mZYsGOjAwIHZVIjGM2EXcU1ND2hVBxLo
NsEvGZUVf7V1gbEW0oSQur8cSbs8VsLglfMG+uTkNc3+cOaFe+Kf4G1mZtOZhvjq
paq2amiDWAxgehUjwyIJiGCEHV8TfGby6aPShYwtyStEqUoOsId4t4xdgvY4Rdvr
OHrBX8N0KGZv3Vkuk+7g8pJlJi0SB+s7KFRsyusxP/ZyzYRDOoZxa/LUNQ8fQeUp
sMMA/KjNho9hh/qg9pEqa93+6I5j2FugeeHdcuxwFv4lwPagJ+w1KJtPXRifSxw5
6GwnyXqZFaE9M5cAkiY00qEMgdqMov+wQvw1NMd+3cAHxnRu8eSFSETYddEFw0pq
P4K3ym0yyLhmsoazYoyeHQRaiuIHKs/mSiW/C+pwnIVtQEiG9ri5YM3VfPRyPveH
wyguaoJriR+9gFsni0pTjEd/V2VBuKtssqnWUL0NfCQ3XD4XsOI=
=qO83
-----END PGP SIGNATURE-----

--NqNl6FRZtoRUn5bW--

