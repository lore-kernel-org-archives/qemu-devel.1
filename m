Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1770C04AAB
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D021206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YNoXsnza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D021206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40737 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNtXb-00021Q-O9
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 02:25:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVi-0000mL-5n
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVg-0002dS-S1
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:30 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52207)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNtVe-0002Yn-Jb; Tue, 07 May 2019 02:23:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yqL23mZPz9sCJ; Tue,  7 May 2019 16:23:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557210202;
	bh=gpQrHJyWQexYpx5/xWG2PXXC2z/I5IoQUN483yRDw7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNoXsnzaZu4Bg6jWp6BWToKgLt946roURZn4WNjk8WSwqxDSSgXyVcDkDtYR4+HYu
	W/cX4DmWaOWkNyDTunh6VufFZRh0ebGgPn9F++Br3Qpunl5qvD89ePM4u0wZP543gT
	Nv9GQYr8M+XN99LTV89+gR3pFMC9wwJ/ChBJNe5A=
Date: Tue, 7 May 2019 15:22:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@ozlabs.org>
Message-ID: <20190507052243.GH7073@umbus.fritz.box>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-5-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xHbokkKX1kTiQeDC"
Content-Disposition: inline
In-Reply-To: <20190507004811.29968-5-anton@ozlabs.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 5/9] target/ppc: Fix xvabs[sd]p, xvnabs[sd]p,
 xvneg[sd]p, xvcpsgn[sd]p
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, f4bug@amsat.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xHbokkKX1kTiQeDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 10:48:07AM +1000, Anton Blanchard wrote:
> We were using set_cpu_vsr* when we should have used set_cpu_vsrl*

Commit message doesn't appear to match the code.

>=20
> Fixes: 8b3b2d75c7c0 ("introduce get_cpu_vsr{l,h}() and set_cpu_vsr{l,h}()=
 helpers for VSR register access")
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>
> ---
>  target/ppc/translate/vsx-impl.inc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index c13f84e745..0a48020e3b 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -859,8 +859,8 @@ static void glue(gen_, name)(DisasContext *ctx)      =
            \
>          xbh =3D tcg_temp_new_i64();                                \
>          xbl =3D tcg_temp_new_i64();                                \
>          sgm =3D tcg_temp_new_i64();                                \
> -        set_cpu_vsrh(xB(ctx->opcode), xbh);                      \
> -        set_cpu_vsrl(xB(ctx->opcode), xbl);                      \
> +        get_cpu_vsrh(xbh, xB(ctx->opcode));                      \
> +        get_cpu_vsrl(xbl, xB(ctx->opcode));                      \
>          tcg_gen_movi_i64(sgm, sgn_mask);                         \
>          switch (op) {                                            \
>              case OP_ABS: {                                       \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xHbokkKX1kTiQeDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzRFiMACgkQbDjKyiDZ
s5I+QRAA0nThDjCOaLpGXUdgPCmIs/d2f5sGN2qwsDQmT8xaRomGt+ZXF4sAHwe7
eUP4i4uuporFP+FhJzMjHBfx8LEJdT2Ohk6my5u5XckKrnfh5UvpgNfD14gLTXrQ
2OyymI3AvnCNX9HQlsuieWWdnmSNJeuorb/pAzF7vgw7c+ThxYyiwp2zIukiYoGr
8DD3lBXRZSpomeJkx5YKOomDX7294xdoeDGmchZEPgeBfxmEkN1dGu+F0ccltOSt
Sa/FdCN7ZynAKHavvAhKfboJdBeDmbx1w+BfUHCguwyUFr7FMoYv+JSNTFu0oeCh
N6TJ/MBSPGJKskKbZDzUJYVjLCl4a58xanxasqzr0BI4BnG8oBtzVne1fpoHHygA
iTX/iO0oZt299EncpeSBKBdwZoTaRu6bmZXhBR700xiRr4ic6LM0oN5h+g4BGx3K
rsmUY7kuRzG2Dnw0ghaODTf10en+3sdod8Ks5jNIk0pZk1HwPvJBUByvxw/elIYi
HllRjwL/6b2KJzgz3itdXsDGWG6YslJe5+PMxQZHSSHM2AxCi48ulCCDkSkRX8iA
vorjn913XVXU3Wv8P8AmguS1amXQBp1cpwxelpdYeCKa9nbWSYUmiOBEMMGQ4OXA
/Pzv0ef1Ppo5FgKLOwar9ppjXzFSYdL0Lj1Lu/Rn1pkFvdhQMzo=
=M0TX
-----END PGP SIGNATURE-----

--xHbokkKX1kTiQeDC--

