Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCE6C3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 10:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FA020870
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 10:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="o7Qx+gcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FA020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1SuT-00033I-Uc
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 06:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i1SqX-0000wx-DT
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 06:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i1SqW-0000P2-2U
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 06:00:33 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:38583 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1i1SqV-0000FH-0v
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 06:00:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Fv0640MSz9sNF; Sat, 24 Aug 2019 20:00:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566640822;
 bh=SWKqMXNA2SWu7QG9XMBJIDAkuvgnQOaZq/L21MibKTE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o7Qx+gcXYLGu6kkNlQP8NSzYUOETLiESVqnFY7y1BvYxGwy+yAEUa/9LZv5/k4PB9
 D54rmRRLuJT3cfVICyA6RFpeblfzS9ZUNAZvxOrNPDXp5LzNOfwaifTltBOGpraGGB
 ank377Ltz4T24LhDHCwSL5UlK8ZgFmYRwo0gJRXc=
Date: Sat, 24 Aug 2019 19:42:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Message-ID: <20190824094230.GK3027@umbus.fritz.box>
References: <1563200574-11098-1-git-send-email-stefan.brankovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BOhpupldhMlYbdva"
Content-Disposition: inline
In-Reply-To: <1563200574-11098-1-git-send-email-stefan.brankovic@rt-rk.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v5 0/8] target/ppc: Optimize emulation of
 some Altivec instructions
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
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BOhpupldhMlYbdva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2019 at 04:22:46PM +0200, Stefan Brankovic wrote:
> Optimize emulation of ten Altivec instructions: lvsl, lvsr, vsl, vsr, vpk=
px,
> vgbbd, vclzb, vclzh, vclzw and vclzd.
>=20
> This series buils up on and complements recent work of Thomas Murta, Mark
> Cave-Ayland and Richard Henderson in the same area. It is based on devisi=
ng TCG
> translation implementation for selected instructions rather than using he=
lpers.
> The selected instructions are most of the time idiosyncratic to ppc platf=
orm,
> so relatively complex TCG translation (without direct mapping to host
> instruction that is not possible in these cases) seems to be the best opt=
ion,
> and that approach is presented in this series. The performance improvemen=
ts
> are significant in all cases.

I was waiting for acks from rth on the remainder of this series, but
it seems to have been forgotten.  Can you rebase and resend the
remaining patches for inclusion in ppc-for-4.2.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BOhpupldhMlYbdva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1hBoYACgkQbDjKyiDZ
s5KNBxAAvZysyb1j4lbg/TRdEUs5rGgU0o+Ub6ya//aG0knlKJCox9q7vFJJNcMl
jHYFNqPI3CrYPTinrFMeSRgQ9u0BQstyztfrtJ2kvamw6PQq3SJcvQNgmUbixYxf
kCUSlz7ZziYnEutV/t8qqjzn9DxaCPCGVcKn8OH9rOKZLP7a1TWgMX//filmu9qf
xJzeC4wPeKlmtY/FnlHk15ZOsSvW9uklhJ53BP5kHN9wVy4TdMu8QEaa55oBTBDU
Spk8JWH3LW0Pd3RzSMbDDSEVjG1u9kpSm/DlBgINFzna9fWSmf9OI7Li+jmHp18U
i8pLNjITEI5TVznqQ5A3mNlf/zgcWnK2P76FGLA6Zg9236HoPXstQBKsO/f7azS8
91gre7edzY355HgVcOdai8oRe2l3J8wdSu2ps/ZwrGMWW0Pi6y14vfL9dqT7RNVn
Fp85W9IgLlZ/ffiFYmM4e3mJxX1DY0NcaQouNsHmU6Ky3h17aC1FBBUvi1FkquA7
qUGw64g35n3BgnnYDmZRylqoRzYNpno0cH9nT4ViT9arXJC+TjyQmoixJG4FHS/P
1A6S4194rkroyClx0BEW2PmsKLrgJqAGOn+lHI0SsAh8bGnVDMbYUiN+NvRPtgKV
E8M43gnvffomGpTVCTF9x0GQEE+lwZy3Cmp5dyOZ+YD7IdbRL9w=
=GJOV
-----END PGP SIGNATURE-----

--BOhpupldhMlYbdva--

