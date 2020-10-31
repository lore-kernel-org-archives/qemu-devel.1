Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB81EC4742C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 05:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB49921534
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 05:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="W6YDFEX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB49921534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYjI8-0001Wi-LN
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 01:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kYjHO-0000Wx-Hz; Sat, 31 Oct 2020 01:18:18 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:46903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kYjHM-0006qQ-9q; Sat, 31 Oct 2020 01:18:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CNSB44xDNz9sS8; Sat, 31 Oct 2020 16:18:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1604121484;
 bh=IfzrySUWrgkfxbmthEf/Bl4Sc8gQc05wOAFUqTBSJ/o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W6YDFEX12ynP2RleU4DnmiHfJYXPJuHPYEMREsxVLPkZeLys2zeu/VmLjZRJz3jhg
 DaXUEvG2cTjrM0Pi8YimJ0tOPUcS4Fv67rPJCHkjYnoJKI0ts741rYo0SKydGNKDUG
 nC3J8EB7ASWU25mBBPPfJowgFGxy1hJa4d5qyBMU=
Date: Sat, 31 Oct 2020 16:01:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Chen Qun <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH v2 7/8] ppc: Add a missing break for PPC6xx_INPUT_TBEN
Message-ID: <20201031050102.GA17638@yekko.fritz.box>
References: <20201030004046.2191790-1-kuhn.chenqun@huawei.com>
 <20201030004046.2191790-8-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20201030004046.2191790-8-kuhn.chenqun@huawei.com>
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
Cc: Thomas Huth <thuth@redhat.com>, zhang.zhanghailiang@huawei.com,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 08:40:45AM +0800, Chen Qun wrote:
> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warn=
ing:
> hw/ppc/ppc.c: In function =E2=80=98ppc6xx_set_irq=E2=80=99:
> hw/ppc/ppc.c:118:16: warning: this statement may fall through [-Wimplicit=
-fallthrough=3D]
>   118 |             if (level) {
>       |                ^
> hw/ppc/ppc.c:123:9: note: here
>   123 |         case PPC6xx_INPUT_INT:
>       |         ^~~~
>=20
> According to the discussion, a break statement needs to be added here.
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> v1->v2: Add a "break" statement here instead of /* fall through */ commen=
ts
> (Base on Thomas's and David review).
>=20
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 4a11fb1640..1b98272076 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -120,6 +120,7 @@ static void ppc6xx_set_irq(void *opaque, int pin, int=
 level)
>              } else {
>                  cpu_ppc_tb_stop(env);
>              }
> +            break;
>          case PPC6xx_INPUT_INT:
>              /* Level sensitive - active high */
>              LOG_IRQ("%s: set the external IRQ state to %d\n",

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+c74wACgkQbDjKyiDZ
s5K18RAAshjfnaPQGovwz8mLIXHmbQ2zbsn3JgWdJYreDG3GhuSFT0QluQJ9QzXu
zekS+SF1W05LB+/ptpvH0RcbDyw+qzcBobpdLRTmDGdxs9hfJi1YbU3eB9Cp32W6
ioSRPurGRpvh1s1iJob3Imfu2uYnk6dudNhazxti/XuNkYrWTgDl+LYkgDHS/bwx
jjyOugjrtMGMxu/sEmgYxeGtuPdoBuvnwoBYi1PM3BNJSjurjAN2lySPkg8e8enl
0dAAD9TEfHsUgx+94gQPkLt8Zau9KXww2i/5DzZtGENv1vX2eqRxSx67t2viZ+Hm
74qKBfmiRI1OfVL3b1eysYEualsZBwSA7MaJfBi0ChoNoD0cgvZBQBhcAa8xP/vT
ce7fvZuG8r+C0OD1g4nZjTSV4T61EJbKc5/siw/gYEVe4JqMElL9drLWHEbZ5gtK
uO56WReqhKHq0xtCqD35gdn1PRRh0w7yuPOeBMr9XgQ0W2WCc0v/CgpsGnLfCD2g
Thoxm9ixmg8SBYdzgJObW/PbCuFaz8nmRm9TDsUvRKnZ0A8O3lSliKdMDNlARzcc
97gcEZH38HIs0j/MaxCgkIhI48lj2xnQ78sJLdazKp893cp/C+L1C/+7oTlRDkdY
nQjVhLIrdwrg1TuvkWzdHjco/vN9owLXzcUjDiBkMiabGj4bg6E=
=wqfi
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

