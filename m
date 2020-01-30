Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F20CC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 01:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5054120663
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 01:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KRJQjqbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5054120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixLIu-0005w2-IN
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 20:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ixLIE-0005OA-LZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:40:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ixLID-0003cL-AM
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:40:22 -0500
Received: from ozlabs.org ([203.11.71.1]:42271)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ixLIC-0003Sg-Dn; Thu, 30 Jan 2020 20:40:21 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4880KD6XTTz9sRW; Fri, 31 Jan 2020 12:40:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580434816;
 bh=kcdnTsxMSW/rcbOQcSOdUmz81WYvHyVzuEUi7iV104U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KRJQjqbzh2eNKOdX5Ocu4gb7wxtAkF7yK06BdDD/Ar7L+JYP/h9TXLi0jbgzF5gKV
 EqvKWY/3UIlN0ujHrsF3FTUkC35me8RzmtwxHINZbUXdnMU7bzEoI7F9suloLcoB29
 Ev5bo/h+hvQCpnpxwYourSlboWaaxSzyKpf/V210=
Date: Fri, 31 Jan 2020 10:54:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/4] target/ppc: Use probe_access
Message-ID: <20200130235433.GC15210@umbus.fritz.box>
References: <20200129235040.24022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <20200129235040.24022-1-richard.henderson@linaro.org>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 03:50:36PM -0800, Richard Henderson wrote:
> The first two address the performance regression noticed
> by Howard Spoelstra.  The last two are just something I
> noticed at the same time.

Applied to ppc-for-5.0, thanks.

>=20
>=20
> r~
>=20
>=20
> Richard Henderson (4):
>   target/ppc: Use probe_access for LSW, STSW
>   target/ppc: Use probe_access for LMW, STMW
>   target/ppc: Remove redundant mask in DCBZ
>   target/ppc: Use probe_write for DCBZ
>=20
>  target/ppc/mem_helper.c | 197 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 162 insertions(+), 35 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4zbLgACgkQbDjKyiDZ
s5IV1Q/+OV6aiOK6W44zYwhnS/x7sgMJKVzZ8wmmalzqjRscnO/LyaH72ee7+Wja
pHuToqGHBrTmczRVgj9c4gywme9aziho2tuWELwKqQDBD4GNvDIRx+9s4lCl3p/G
n0LoFjIrNdPsRlskGH2f433q4GAWRqWCbVYmtm/+gH9jbLgY6vk3OU0pBHwURsfO
GoJJge3CV/hpsCg6Y2+inhSaiPD83y2IkVg+KYz4ONp1mtYT2nj9Whq0LsYS88KY
CFKK6ARhDPqrsHSyqO4IYM7di7rb85a2Qaced8JCiEiokA5qFqlnyR02b6PcQMkP
3YhgkNuePJIM+bAnNzQ0pvc7uBtdf4uQEwXhbdA6y8+kmP/Ea/knhQ5uN7LyZqWO
+yZDcyRvPHp2fGHcEh4W3X/fPiLsKlV+V6CD6anQ7NHtOcoG3GJPA946bzF4Os+Q
ppU+e3QPLZhEoY7ErgUS/T85GtGmYUjr+yg5tmyjOThogl0VfFrSZLINKVvv5V1S
o5m9jGBx9XXv3upjmiLB03jusEwbJFN2pDxwf1Wb2Dc1Gb11c3bEcMI+bLEYu9o5
YPtGDZp/gv6l6iXeK+3dv+15xMpkWccsU9fwQKeVNZcrYA81lc54WeNvViTQAa6g
erLO6GxjdN2e8HS+2cOZJWV9BOsH1dWbqnVO22aFUJnczuHp7QA=
=Lsw1
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--

