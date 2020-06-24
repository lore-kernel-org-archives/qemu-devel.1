Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17246C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 01:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9DD32137B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 01:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GWAfnIIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DD32137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnu4k-0004P2-4X
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 21:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jnu3f-0003st-78; Tue, 23 Jun 2020 21:18:35 -0400
Received: from ozlabs.org ([203.11.71.1]:37241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jnu3Z-0006QU-Si; Tue, 23 Jun 2020 21:18:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49s4yy0Y2Sz9sSS; Wed, 24 Jun 2020 11:18:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1592961498;
 bh=6et0rPXpkPZ25MkAjF1x2BuVS3ngFgrmdd/opAwviBo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GWAfnIIx7ZaHm4KvVeFeSR7ZkRW8UqWjA2eEavSzjZYqDtS/LJrQjgRzT7dPD6leD
 bnknlYhwhov8xNt978MDwvAUE3FbZP+RMbznq4nd8EPTw9EjdyYqoB5qH60artVSNL
 OeCnEECySK86ZjDOLcx8miJ4XR8B2yW0PYwxXPlo=
Date: Wed, 24 Jun 2020 11:08:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] target/ppc: Remove TIDR from POWER10 processor
Message-ID: <20200624010851.GY17085@umbus.fritz.box>
References: <20200623154534.266065-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rd/3IrB17klb+Ksj"
Content-Disposition: inline
In-Reply-To: <20200623154534.266065-1-clg@kaod.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 21:18:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, TVD_SUBJ_WIPE_DEBT=1.004,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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


--rd/3IrB17klb+Ksj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2020 at 05:45:34PM +0200, C=E9dric Le Goater wrote:
> It is not part of Power ISA Version 3.1.

Applied to ppc-for-5.1, thanks.

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  target/ppc/translate_init.inc.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index a40888411c1a..49212bfd90f2 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -9086,11 +9086,6 @@ static void init_proc_POWER10(CPUPPCState *env)
>      gen_spr_power8_rpr(env);
>      gen_spr_power9_mmu(env);
> =20
> -    /* POWER9 Specific registers */
> -    spr_register_kvm(env, SPR_TIDR, "TIDR", NULL, NULL,
> -                     spr_read_generic, spr_write_generic,
> -                     KVM_REG_PPC_TIDR, 0);
> -
>      /* FIXME: Filter fields properly based on privilege level */
>      spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR", NULL, NULL, NULL, NULL,
>                          spr_read_generic, spr_write_generic,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rd/3IrB17klb+Ksj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7yp6AACgkQbDjKyiDZ
s5Jvkg/7BEdFUZH+A6i6bigRnHmtSvutzdDAD7C5+9iOSNG4DwLnA/xEhKpPk/eE
QWR4g2xCjqK7VficxYR4h7HGrwgS8NjwO7oH8Lc3KbzDZqL9mx9OjGZ9TIqpwLnL
BEFvbPDMXMEJc4Cp4AzaaIlevAdp+tCLatFKa0kjBuBce9aRWPPt1bhHaWlemRZv
aWf3kSdrh81RkalbJ2nBw0HEXYdPQw7q5irLKj+JNFwlhuFZhNoafjdvwjvgmi72
GdcTATN9Lwob1KI7Ciw5ZB3x5qVqWpxqg2Jaw0dk42OXrA/nA1vWwfXgyuHVAS5o
BQf08fJ0gQERLdBm6IWZi01vRD9vhoH76IOteg7M8/jp16atlBjrE8Pm0UO3ZxuB
kT0gh06Uzk7dlfj+3Slo8uvWQO4SOqSHRrYIvyXYYjsCrHfqD7AIAZcoqt1+wn6G
ecKTrf4T69HN1KhGfRyZYH4IV7POMXdFAc+vIsKq1QupNmie3C+3fc7RlQ4FOgIc
d5lfMEKfNEwadUv8VaQLn6APoUS+pqMOCIPr0xx/m1fLI9DSj85dPUU5wpnmFATI
KZKb6Q9rRB2H4lX+eNYn6nGJg5jNGTXez5GO9B3xKPutPWQdRN34NVujsrJCaVIU
wDIDgnh76zn2tmrCbrrfnOwvXFvf4Y1U8/V160m/P0gMQ2H9P1o=
=iFmC
-----END PGP SIGNATURE-----

--rd/3IrB17klb+Ksj--

