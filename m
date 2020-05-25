Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067A1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 05:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52C82075F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 05:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kyvud2Mh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52C82075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd5Os-00076l-2g
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 01:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jd5LK-00031z-01; Mon, 25 May 2020 01:08:06 -0400
Received: from ozlabs.org ([203.11.71.1]:53505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jd5LI-00047h-3C; Mon, 25 May 2020 01:08:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49VlTk6m62z9sSs; Mon, 25 May 2020 15:07:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590383274;
 bh=RhtXAU3MRQxzJrFraIaZI5LbqjzddJBgv+hEPLL6wrg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kyvud2MheUkwLqdBC0AiEPjC7SC30cg1wfIlQyx7Gaf85cV+EzMVVduHr4mwly+7i
 /0mlGj9mlSidQc/U7F6gb9Mj1vtG5ERgnYkIP94zlfFLKer5rga1m3D4KwPY8uszRq
 azAOXBGjL9r34tblpmwbXbtBw+b0Fg+USZrFj6FM=
Date: Mon, 25 May 2020 15:07:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH] hw/pci-bridge/dec: Remove dead debug code
Message-ID: <20200525050703.GC23110@umbus.fritz.box>
References: <20200525033910.26166-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Content-Disposition: inline
In-Reply-To: <20200525033910.26166-1-f4bug@amsat.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:07:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2020 at 05:39:10AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Remove debug code never used since added in commit e1c6bbabee30.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Applied to ppc-for-5.1, thanks.

> ---
>  hw/pci-bridge/dec.c | 10 ----------
>  1 file changed, 10 deletions(-)
>=20
> diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
> index 3ae2f788a4..952bc71122 100644
> --- a/hw/pci-bridge/dec.c
> +++ b/hw/pci-bridge/dec.c
> @@ -32,16 +32,6 @@
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/pci/pci_bus.h"
> =20
> -/* debug DEC */
> -//#define DEBUG_DEC
> -
> -#ifdef DEBUG_DEC
> -#define DEC_DPRINTF(fmt, ...)                               \
> -    do { printf("DEC: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DEC_DPRINTF(fmt, ...)
> -#endif
> -
>  #define DEC_21154(obj) OBJECT_CHECK(DECState, (obj), TYPE_DEC_21154)
> =20
>  typedef struct DECState {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7LUncACgkQbDjKyiDZ
s5Jsdw//RnHjdSEGIiQVEQ/PVejpdkOKvoJfWBiASlS/AeIvvDfkOPlCXszwUYP+
oZyvQj+8eqz6S0tyaCtziJDKMPkhNE8Le7dLf3228dcM88eP8tLJ8ug56CnJtYrI
y9wp13AN8h7Ewj09XHlwzs04wZpO3/7TGP2kN4SlSDceJbzbfwqmkOtIIddQtzNo
atgtyEt4+TzSsJESo0z63IEhzZXMzb7KhrUvDAMrJI6JtvIgUnSJOEovYosDanSA
OEB1wW5gbR1QJ/ZGeZawfnOU9dQ34L2pzc3KKdf3qT5oUsEyezljL2nBvg5j3NkC
WxybVSYk5HLIWjsMlGYEP/h+jL/cB0Qi3mHX+vx/HZ0Y788d5Jk44miZjWNoQNJv
7jaJnJmv0mmzE+KJX4ZUyMuCssWA4/guS4yLxq6aS2u6ZoY8D/EhWMuQG4VeiYMd
eg6GcPSoHT+GVL87nGSXW3w23/hAJM166hBGAQGkMhGzYAXlUSGAXSNQw/9MnIqH
AVX+XypamieZQqlL6uJkAueT0qXpZ3kCdnpc1GQDX39NMsEN3BpgIMBZFvlJc8pr
tgq8kWUo43T3tbpNyQt5ZOZyA1JMW+NRbMgQNFQmWvBpqgaPst+2GV91Gt80kzOo
80S8iIvJ33gsg/VRtnYG17iMsSta1m/LGeN3BJUk2ZzlKoedgVE=
=geU5
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--

