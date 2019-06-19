Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBEDC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2A720B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KNzcc9/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2A720B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36372 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdXJV-00047x-Ld
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 05:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43326)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hdXDs-0006CE-SZ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hdXDr-0000hg-Dh
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:49:44 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:33593 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hdXDr-0000Xf-01; Wed, 19 Jun 2019 05:49:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45TKt05QwCz9s7h; Wed, 19 Jun 2019 19:49:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560937768;
 bh=091szy3YTEOWx2me8L+dqFWhkifzv09Zn4H0MaWf34M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KNzcc9/b/7UT7K3XHVL/VOazo0bXPYEc9yC2euYoB7QarMGbov1yaoFm/cyj5EPb2
 tg7OAQNJkyUOr/x04WXUYoJC6ffh47Nx+q0/xlLwQN2QzPWaAP9ZO6V3LBYeSUAPNt
 hVWfus1Cm+fZJ/mWbtbeAfGzcp3WJZ6pMktWieQw=
Date: Wed, 19 Jun 2019 19:39:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Message-ID: <20190619093924.GD22560@umbus.BigPond>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-28-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <20190614171200.21078-28-alex.bennee@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v3 27/50] target/ppc: fetch code with
 translator_ld
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
Cc: "Emilio G. Cota" <cota@braap.org>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 06:11:37PM +0100, Alex Benn=E9e wrote:
> From: "Emilio G. Cota" <cota@braap.org>
>=20
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/translate.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 4a5de28036..a27b5659f4 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -7864,11 +7864,9 @@ static void ppc_tr_translate_insn(DisasContextBase=
 *dcbase, CPUState *cs)
>      LOG_DISAS("nip=3D" TARGET_FMT_lx " super=3D%d ir=3D%d\n",
>                ctx->base.pc_next, ctx->mem_idx, (int)msr_ir);
> =20
> -    if (unlikely(need_byteswap(ctx))) {
> -        ctx->opcode =3D bswap32(cpu_ldl_code(env, ctx->base.pc_next));
> -    } else {
> -        ctx->opcode =3D cpu_ldl_code(env, ctx->base.pc_next);
> -    }
> +    ctx->opcode =3D translator_ldl_swap(env, ctx->base.pc_next,
> +                                      need_byteswap(ctx));
> +
>      LOG_DISAS("translate opcode %08x (%02x %02x %02x %02x) (%s)\n",
>                ctx->opcode, opc1(ctx->opcode), opc2(ctx->opcode),
>                opc3(ctx->opcode), opc4(ctx->opcode),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0KAswACgkQbDjKyiDZ
s5KknxAA02oEzB0Vt5+0TwCp8n4Egfwcb05e/rFxq5A4SVxsbu9axOPrdZ5FgbeM
JWaHdHfCeRjXe3lM9EUKyfM/r8B5YWUY4hl+uJF7OY/wGEg5SUQPzg9Yx7H74Osr
yZzTLq+HH6zHLf3qkO66bcMFw7Arg+TLiidl08kuMgoQJfsmSR6x4A3AWSH8ejBk
y6QBR2Xmmk3el/fmvDT1cZEZTCNmTTf60K21DupCc9vSK1pkLpqrx6InpODDFpVT
EAQI71yXkaX3ndUqxUCFfXYbdutJyHiW5ZrYDCaUWLTMWkSWMp4vbyM/25D/f3ex
tLMQaap+d8fg8DzAjFqoof24SR39FSQBbV5dkr1fZ4CPjz7CDJxJqUdQm3jgBt4z
Oj4c3Vk7ENubaIs/keL6aADwRg/IitMZKpH48LKIx4K8elET41gn/9yDqzNyq6j6
Kno/XS6IQm9YLTnilXl9cWdbzU1t6aJTgMzDgZMxCdqF0Ii3oYj7gSrNEzvHwXRc
w6Rmi+7KhevPV6QDZ0/kwUcwOb6pkn63R8fx8bJRKvKOrorvGjjiIWHV6ICn73pG
eu5U6DdWwmlkWaV9qVHQF/r5Z4sVCdEg29lddrhnSLWwKyIf/loYkDPfgdrFTdzs
bqe7TYMfwOIZHr7oO8YlbLqwzceRoBcejk3wxGQe0P3ERP5UyA0=
=9KO4
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--

