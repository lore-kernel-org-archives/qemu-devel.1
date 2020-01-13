Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468EEC33CA8
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 03:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117D121744
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 03:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ohUnPK2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117D121744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqqhg-0007td-Ta
	for qemu-devel@archiver.kernel.org; Sun, 12 Jan 2020 22:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iqqgY-0006am-UK
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 22:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iqqgX-0006Ln-SG
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 22:46:38 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:55987 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iqqgW-0006HL-Ks; Sun, 12 Jan 2020 22:46:37 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47wzzB4Lc2z9sR0; Mon, 13 Jan 2020 14:46:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578887190;
 bh=D/agHlATfy+an/ttf5aq3ZkAGFq9+i1kApPrqW5q4vA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ohUnPK2ihw9iuD0KYjsEP4EJ94R/7CY7ZHvfbwpsc72juRYmHdVV9xvciDCX93HDt
 Sc2CDLgJivqb8YPNz7SyHChGwefOEqcphsJ2mKbEHiEk4hqJTGzr+RK24W+6UZoDtD
 1vZ8FGq/lkhMFo3JKX8LDPAXPC+WarbHvqUhC0SY=
Date: Mon, 13 Jan 2020 13:38:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v2 05/10] spapr, ppc: Remove VPM0/RMLS hacks for POWER9
Message-ID: <20200113033811.GB19995@umbus>
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-6-david@gibson.dropbear.id.au>
 <926a7cd9-3f25-44e4-3bcc-3eedac068a68@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <926a7cd9-3f25-44e4-3bcc-3eedac068a68@ozlabs.ru>
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
Cc: lvivier@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 paulus@samba.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2020 at 06:33:36PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 07/01/2020 15:48, David Gibson wrote:
> > For the "pseries" machine, we use "virtual hypervisor" mode where we on=
ly
> > model the CPU in non-hypervisor privileged mode.  This means that we ne=
ed
> > guest physical addresses within the modelled within the cpu to be treat=
ed
> > as absolute physical addresses.
>=20
>=20
> s/within the modelled within the cpu/within the modelled cpu/ ?
> Thanks,

Thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4b5iMACgkQbDjKyiDZ
s5KHng/+OieIGiw+12EobcfxbtKsWbiAzF6v9q1bOlpQNqilPq+bBfssYUmHrNSR
QylgNaS7kLSc8NHMjIB5ibDclKSmDDe9ngChVt50VWgozvcvFcKZdwcqQkNnGbc/
DU5j8KK3PdE77Wj5zRXi2LfJA6TCNQwPnn4UtUgEWiJxmGo22P9RRETDRW3j63hk
6vy4dqGFmwCKxE7hFAHGIMEwCbbipZRNtPnYF5BMLi1mcgbY/RbY6J5iuq1yGpJi
lbTECUkyomPczpEPsuAvSm4btMJCeRrz9fgHfF9sjaYY+YlkcFqkiAjv/B69ap/g
6vSlxyNuW2YTbC0/1gZdhjaKqkFmxu7BI32v4mFKcAh17iRqHZHeVJuMuVoLuHEH
lnGdS+70KFatq/BXmDCTjXsq8d9FGTE5pvglFIylgt2VF82dF59ltJMgcJ8MN3xT
lnrjdFK4YrPyfkSOkoBL4P96B8rk+TmJAyWANVqnHiIf02vUwwcGARU5+0Wde3sO
11cOl6SVtw/uiYv7ezcYh7zX2GV0UaRxXE7kOb1/Ae7XJ8Dqd0om7NByJx04cYtk
I4Rru1wFI4k9rRXjIQNhgWmRzbXW2ChS20+9p34vJXUQZ5akcfQ/vGuSaVYN0jlh
A7dR7cIAjkamjaQMgxx64O27QMXqN/S2q1nyhAlyj0BHGc8MR3g=
=usTa
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--

