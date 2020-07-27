Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F69AC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 06:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2903F20714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 06:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UHitf5ZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2903F20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzwij-0002PB-Cu
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 02:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jzwhs-0001PV-Fi; Mon, 27 Jul 2020 02:33:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55609 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jzwhq-0004mP-Lt; Mon, 27 Jul 2020 02:33:52 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BFVPj5cYNz9sPB; Mon, 27 Jul 2020 16:33:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595831625;
 bh=99TvoGhdfJBwr8ub+p1RkKmCGsVibTsJPQBFqPgVcRU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UHitf5ZRywWX7ZOnzCCjTEWfvhATnELbo+yyJ50nNJR7ihzDwQr1wqgXP8oGW/hB9
 MD0xG7YNw5/ihLlM4uLX7vp6f9NLZCuXn3TYI+zLCjveHlqyCfcr2D53ozGQxX36Fk
 vSLEZLxFcQLCSdtcJ6PHYF3zbqDTXgr6fWYZO8AY=
Date: Mon, 27 Jul 2020 16:33:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Lijun Pan <ljp@linux.ibm.com>
Subject: Re: [PATCH v5 0/6] Add several Power ISA 3.1 32/64-bit vector
 instructions
Message-ID: <20200727063333.GG84173@umbus.fritz.box>
References: <20200724045845.89976-1-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline
In-Reply-To: <20200724045845.89976-1-ljp@linux.ibm.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 02:33:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 11:58:39PM -0500, Lijun Pan wrote:
> This patch series add several newly introduced 32/64-bit vector
> instructions in Power ISA 3.1. Power ISA 3.1 flag is introduced in
> this version. In v4 version, coding style issues are fixed, community
> reviews/suggestions are taken into consideration. 1/11 - 5/11 of v4 were
> accepted by David Gibson, and 9/11 of v4 was accepted by Lauren Vivier.
> This v5 version updates PPC_FEATURE2_ARCH_3_10 definition in 6/11 of v4,
> rebases 7/11 8/11 10/11 11/11 of v4, and integrates vmsumudm/vmsumcud
> patch.

I've applied 1..4 to ppx-for-5.2.  Still looking for a review from
Richard on the last two.

>=20
> Lijun Pan (6):
>   Update PowerPC AT_HWCAP2 definition
>   target/ppc: add vmulld to INDEX_op_mul_vec case
>   target/ppc: add vmulh{su}w instructions
>   target/ppc: add vmulh{su}d instructions
>   target/ppc: add vdiv{su}{wd} vmod{su}{wd} instructions
>   target/ppc: add vmsumudm vmsumcud instructions
>=20
>  disas/ppc.c                         |   2 +
>  include/elf.h                       |   1 +
>  target/ppc/helper.h                 |  16 +++-
>  target/ppc/int_helper.c             | 111 +++++++++++++++++++++++++++-
>  target/ppc/translate.c              |   4 +-
>  target/ppc/translate/vmx-impl.inc.c |  62 +++++++++++-----
>  target/ppc/translate/vmx-ops.inc.c  |  25 ++++++-
>  tcg/ppc/tcg-target.h                |   2 +
>  tcg/ppc/tcg-target.inc.c            |  12 ++-
>  9 files changed, 208 insertions(+), 27 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8edT0ACgkQbDjKyiDZ
s5IRCBAAobsbTPyppXZ98yIonBo2jhEFDedN93U/xFIiu1NdJZb6xJOI2HtHda97
BBzRQoLqraJjnCOJkP/TudbTHvV+wBqhIej5cvkAEHheWvPmYScSEyKHEDz8+4eO
UhAGWpEcE5f3/t59aDM5svqrB4BVRV9xbfvA6+IsM649diaPX/nEwnFnxKb4EK8b
cw+WM2W9kXqIeIqGQsLMNNiAnEym24Ua76fx5qmNOCrSA8lC1KEkwC3s+lMuWG5t
Deg6HagW3urh97RPBdII0ngau5fuKbw4VcmEw1n2mBt60GdlMEoOTvasGTm0uOrK
C4Pfp4aDlL8CRqLa1Z1YghLR2mFFavmrOJ5f2z1k1iCaTsHzF28yLJWfAYXHSHfQ
ALKic7y7aLrqhLCFZxVsYg9OLH5ki+/ViOhZQODuDc4ZFxHsL183QWjWVtFP8KM/
RdINXrv2r6gE0c4E7lFUQz4eOLbgAbVVxCUcF8O6dMwWUdxYOyKfphu8SCtIdP1X
yBmD5mCVEc0S7i8wag/4QQNUOwUuGuR1VQK1OnNDNO1U1bA+WHj7VIVHnwKDYX6R
0KXRhcVGslY4iSunKa/hgWtOqFHZRlFPME1Cx8St54ywR6lGfAw66OlY+k28IL8v
IqvTdjErcriGTl4cPXfzWDke7q5tAXZMDsVmCWaeSIYEpdPtyRo=
=+v6i
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--

