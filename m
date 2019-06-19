Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12878C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D012084A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eDWUGufB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D012084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36284 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdXAx-0003Wg-SJ
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 05:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38512)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hdWxx-0007dI-9p
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hdWxv-00035n-MM
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:33:17 -0400
Received: from ozlabs.org ([203.11.71.1]:57047)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hdWxu-0002xX-HR
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:33:15 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45TKWB3JKwz9s7h; Wed, 19 Jun 2019 19:33:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560936790;
 bh=VzP232tVULU4RWFzhGRv3vlmXFx4GcRmJ38+dmGTmaY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eDWUGufBsJeygYmcGe0bPNeztfmVbZDvrYz4GFIUb8NF4lfHT4J3T49MVm5J9qfdJ
 8UGFSmeErNigokku7a/kFA1cIbYI1LP4rQQGGFkATa8tVyhQVyNYJm6A/oAelpINy2
 zTd5Naq81YSHl1iflK8qZL2449vxqgA00kIANaTQ=
Date: Wed, 19 Jun 2019 18:11:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190619081110.GB22560@umbus.BigPond>
References: <20190519041522.12327-1-richard.henderson@linaro.org>
 <8f28d008-2608-a579-7505-4546b08deb41@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <8f28d008-2608-a579-7505-4546b08deb41@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg/ppc: Add vector opcodes
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 10:00:10PM -0700, Richard Henderson wrote:
> Ping.  Otherwise I'll include it in my next tcg pull.

Uh.. I'm not sure who this ping is directed at.  I'm afraid this
series has dropped off my radar.

>=20
>=20
> r~
>=20
> On 5/18/19 9:15 PM, Richard Henderson wrote:
> > Based-on: <20190518190157.21255-1-richard.henderson@linaro.org>
> > Aka "tcg: misc gvec improvements".
> >=20
> > Version 3 was last posted in March,
> > https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg05859.html
> >=20
> > Changes since v3:
> >   * Add support for bitsel, with the vsx xxsel insn.
> >   * Rely on the new relocation overflow handling, so
> >     we don't require 3 insns for a vector load.
> >=20
> > Changes since v2:
> >   * Several generic tcg patches to improve dup vs dupi vs dupm.
> >     In particular, if a global temp (like guest r10) is not in
> >     a host register, we should duplicate from memory instead of
> >     loading to an integer register, spilling to stack, loading
> >     to a vector register, and then duplicating.
> >   * I have more confidence that 32-bit ppc host should work
> >     this time around.  No testing on that front yet, but I've
> >     unified some code sequences with 64-bit ppc host.
> >   * Base altivec now supports V128 only.  Moved V64 support to
> >     Power7 (v2.06), which has 64-bit load/store.
> >   * Dropped support for 64-bit vector multiply using Power8.
> >     The expansion was too large compared to using integer regs.
> >=20
> >=20
> > r~
> >=20
> >=20
> > Richard Henderson (7):
> >   tcg/ppc: Initial backend support for Altivec
> >   tcg/ppc: Support vector shift by immediate
> >   tcg/ppc: Support vector multiply
> >   tcg/ppc: Support vector dup2
> >   tcg/ppc: Update vector support to v2.06
> >   tcg/ppc: Update vector support to v2.07
> >   tcg/ppc: Update vector support to v3.00
> >=20
> >  tcg/ppc/tcg-target.h     |   39 +-
> >  tcg/ppc/tcg-target.opc.h |   11 +
> >  tcg/ppc/tcg-target.inc.c | 1077 +++++++++++++++++++++++++++++++++++---
> >  3 files changed, 1063 insertions(+), 64 deletions(-)
> >  create mode 100644 tcg/ppc/tcg-target.opc.h
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0J7hsACgkQbDjKyiDZ
s5LZFw//STdKXnxBvcGl194EfFHGRq3wCn+77gjzuJHtZi8IOLmyr/9L/pxG7XWx
ZsK7POY4x69NATDeqOIbXuck/4aMAYaNh0KkBiHWszJ/pODz6MgK9iS7eY7+Pz0f
Hp/hPnTaApQY2o80kX61IUcNgAtDV6kqkVyTIZj0sSPudBp6TGd5L8VHPcEHbmpQ
t0e4Yc03ax7U3sKOcE7HwI6P60kFXy28VLiiMtL4YfJTJF4RpGn1iGQhQnPI0S+6
wCkLIfdNOyVKxADf1Da1B7EZkceU0UM66a1oQoqv60HYe/yCBtWzeLwXMTHG5t24
ih6qQONejyCMltmwN1uy70/DjKvTmLrkyZ1FWnOM9MA7EL3x4bjvJTwy7w8BVdiY
rkyH1b8zTdB91gNhBX2vg2YHpZgBKlJWKwUfVqlt84efySs4/nAFAkpREGahuaGb
x64sOxA+TOYJtLLOdNV1IF0Uxf2mpM/PUm8EW6Hkw+1Hq6YCbcnyyXFm6Cv2QucL
psBxhE0lQbbX2Cba/jZTY3vDzBM0rwW0K5frkRg33QfujwCfm24/edm94cvUozFU
RAwzCVyP908OtgPelOvOMy4XXrj4VRkktH+TET+lFqse021ShPhjun354IsgCghc
2wXso2vcKMlOzqyZApkFeqc+nqmv88RBy5rQrApEQ7xQF+qdzkE=
=/oAl
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--

