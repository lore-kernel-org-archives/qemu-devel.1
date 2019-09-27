Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44472C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0161020835
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gzSj3sP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0161020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDe3A-00033H-4a
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 20:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDe1a-0001hv-6O
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDe1X-0004F9-Hy
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:22:17 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36621 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDe1T-0003pf-QG; Thu, 26 Sep 2019 20:22:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fXY63FzGz9sPK; Fri, 27 Sep 2019 10:22:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569543722;
 bh=+fxb1JzAE6iXTa7/QZ4T+Nb8Lks0NoRj8MyCtvZx4XM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gzSj3sP/tdWn6fM/cGZX40gwpxZOA+7uJQsRi7XhdO92fXUFoH5rS9++AP/en1zzI
 FhMWxtOtJ2YNZP3WMCs7FpDAgCEJ615C8BAG76Q0ADNaDXX7jg8AB1gPQrE3drTpGL
 tmiyJUFH3JaZvuBtxZgSC2rh5r3ZJu007Bke0nz0=
Date: Fri, 27 Sep 2019 10:07:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 0/7] target/ppc: DFP fixes and improvements
Message-ID: <20190927000743.GE17405@umbus>
References: <20190926185801.11176-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1brTR8/mqxCEB6VZ"
Content-Disposition: inline
In-Reply-To: <20190926185801.11176-1-mark.cave-ayland@ilande.co.uk>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, pc@us.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--1brTR8/mqxCEB6VZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2019 at 07:57:54PM +0100, Mark Cave-Ayland wrote:
> This patchset fixes the DFP issue reported at https://bugs.launchpad.net/=
qemu/+bug/1841990
> caused by the change in FP register storage in commit ef96e3ae96 "target/=
ppc:
> move FP and VMX registers into aligned vsr register array" along with some
> further tidy-up/improvements.
>=20
> Patches 1 and 2 introduce get/set helper functions for reading and writing
> DFP even-odd register pairs (rather than accessing the register pointers
> directly) which then leads to the real fix in patch 3.
>=20
> Following on from this patches 4 to 6 change the struct PPC_DFP internal
> decimal representation from uint64[2] to ppc_vsr_t which enables us to use
> the existing VsrD() macro to access the correct elements regardless of ho=
st
> endian and remove the explicit HI_IDX and LO_IDX references.
>=20
> Finally patch 7 simplifies the calls to set_dfp{64,128}() in DFP macros
> which can now be generated directly by the preprocessor rather than requi=
ring
> an explicit if() statement.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-4.2, thanks.

>=20
> v2:
> - Rebase onto master
> - Fix typo in dfp_set_sign_128()
> - Add R-b tags from Richard
>=20
>=20
> Mark Cave-Ayland (7):
>   target/ppc: introduce get_dfp{64,128}() helper functions
>   target/ppc: introduce set_dfp{64,128}() helper functions
>   target/ppc: update {get,set}_dfp{64,128}() helper functions to
>     read/write DFP numbers correctly
>   target/ppc: introduce dfp_finalize_decimal{64,128}() helper functions
>   target/ppc: change struct PPC_DFP decimal storage from uint64[2] to
>     ppc_vsr_t
>   target/ppc: use existing VsrD() macro to eliminate HI_IDX and LO_IDX
>     from dfp_helper.c
>   target/ppc: remove unnecessary if() around calls to set_dfp{64,128}()
>     in DFP macros
>=20
>  target/ppc/cpu.h        |   1 +
>  target/ppc/dfp_helper.c | 384 ++++++++++++++++++++--------------------
>  target/ppc/helper.h     |   2 +-
>  3 files changed, 193 insertions(+), 194 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1brTR8/mqxCEB6VZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2NUswACgkQbDjKyiDZ
s5KJpA/8CbyCtexGk7xGF1lzhQVarIf+4TkWaXYkpihMIND9frTPZ2L9MJjCtE67
pe1tDQ39xc5Pr1HTFhq4ULrDkeYzG6xrM+C4tQ6bqJKAUNDOZjIc1Y93XnH6rqWG
IyNjGo+IhMv3k0Lj5WJgrBuuh2CpiPdzyv6T0qU7Sple9U6lgntNBOeO8+mSCubq
C84MeFer8gnl6DDOvm+uQC9NHhNHz2A528xM6+7GkxmPGlgvRxcIHkFDSuws0GdU
uoNAYiMkML+CM7Be1UgTOwQ8JWt/yxoGP5lmNncmbD7hnYu8u7UkIOBuRAu3ml9M
7epOu8/84tiB0OkppAjSxwhheFsuqfx2U+pJzQ5RRocOAyGaNA8Y/YY92pqkE96u
Ip3aE5Nr8jSsSJxTjrquSu7aKoQ6bvwcHY2/7nvzaN4b/eJn5OEre8mSJAuTIPTr
aQvwo8NBzAmcjubD65JHLsn2dt1qIBg4GXitKmEA7hAgh0ArIInmHQUoF0nTZ0ua
UG07q9SjUmocHLSr6sRIrGHyeX0BO4G1DHPYEpdcb2BJ4XT+gz6ZwAlvU+C94PmR
efnFSCmWnOC3qknztfDibLPgeNOnamxvpxCYKVRWrKcgiyiQ7q9F0YZrxT36s0Ho
F3T/ThZSOqphEFJJ1W8QpXMxj7DzPcb0Sm5doIkI9yxIpgFUBBM=
=zGuA
-----END PGP SIGNATURE-----

--1brTR8/mqxCEB6VZ--

