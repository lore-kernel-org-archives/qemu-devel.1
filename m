Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8666DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 23:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAB122252
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 23:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MF6fWsDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAB122252
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQfmG-00071S-8d
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 19:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQflF-0006W0-4W; Thu, 08 Oct 2020 19:55:49 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:43787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQflA-00070i-U3; Thu, 08 Oct 2020 19:55:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C6p446y69z9sTL; Fri,  9 Oct 2020 10:55:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602201332;
 bh=wrUw9tzof0l8GVQXHsinBUdoqXEPQv7b1Q8JgTddhOY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MF6fWsDaigq2DIfAjNjEhQfDfnuQNT4uJOkdZsdC6P9j+DTe0ICgR64MIhJJUrRH6
 YhdtZw5Z5Av9/79MLuo9zioLHqGeC0WPPsyubOyTbbow8JKVGgcCKL7xwWTg2mJ54Z
 QhhoxyFGMjfH/Z+TzgU964P/yymD2Bgk5LHac3FY=
Date: Fri, 9 Oct 2020 10:52:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v4 0/5] pseries NUMA distance calculation
Message-ID: <20201008235232.GA1025389@yekko.fritz.box>
References: <20201007172849.302240-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20201007172849.302240-1-danielhb413@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2020 at 02:28:44PM -0300, Daniel Henrique Barboza wrote:
> This forth version is based on review comments and suggestion
> from David in v3.
>=20
> changes from v3:
> - patch 4:
>     * copied the explanation in spapr_numa_define_associativity_domains()
>       to the commit message
>     * return numa_level directly instead of calculating a temp
>       value in spapr_numa_get_numa_level()
>     * we're now setting assoc_src in all n_levels above it in=20
>       spapr_numa_define_associativity_domains()
> - patch 5:
>     * changed the documentation as suggested by David
>=20
> v3 link:
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg10443.html

Applied to ppc-for-5.2, thanks.

>=20
> Daniel Henrique Barboza (5):
>   spapr: add spapr_machine_using_legacy_numa() helper
>   spapr_numa: forbid asymmetrical NUMA setups
>   spapr_numa: change reference-points and maxdomain settings
>   spapr_numa: consider user input when defining associativity
>   specs/ppc-spapr-numa: update with new NUMA support
>=20
>  capstone                      |   2 +-
>  docs/specs/ppc-spapr-numa.rst | 235 ++++++++++++++++++++++++++++++++--
>  hw/ppc/spapr.c                |  12 ++
>  hw/ppc/spapr_numa.c           | 185 ++++++++++++++++++++++++--
>  include/hw/ppc/spapr.h        |   2 +
>  5 files changed, 419 insertions(+), 17 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9/pkAACgkQbDjKyiDZ
s5KKCA/+P5WK+UJ8Si4yz68pjba3xe2G/rVZCQMs7XTXX0ZAMxIMn3o9Kli4kRMj
gmh+eBUZtnTRytJp0IA8kKw79Ml9DZvSKOuU/NHTgWXafOWIWoMvHqHFqBQ/NCB+
pHtQSsjuqGHkLeyRnq/tBINXfSK1lMzS1UUAbiGRppyogs4UAd6A7+71PMEbxRXp
z4M5myB4xe043b7itnXeI3xK1zCW/vdXRStb/2UVrJzKoyr5xT6a6hTNg8xGFc+3
tqiDlxvtCMygx6BFN0eAPQKy/mgGUnkiFdC6oHCHE6L94l71LS4LcZJPcfgy5sGF
13chRy/R+Ubroc25xVNmB8ZnxsjeaA96gT6P6dO1o0xu4Wvbf5c3ozwJLbQ4pcT3
gISvcvmgb88Va+cPv6kub21HvJ5ZcX4ugM/Xj8dj9eRKicvX272gB/LVTupkOO24
tAHwbhdaI+oapAzapyJPdKYiOp42NcfHAC/l/a4i23TZHsYVl9JadKhR4UY+jwHG
ohGu7igAWM0pWktCjC1TZb4KRoatmkoqWkxQbxBkQuC2ywrnvU9WHmrVn2GGkmCA
LHqaZaxCO+6cE7ASMaHXLSJWfMyXXwIAC2VygQuZxD84cvwK23OsKMScWk1mLoz5
0HDsp5Mv9nxB769ZcVcgz4ukU4VcYPxKJz37u3V5bdvf/6IQkhA=
=2M2Y
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

