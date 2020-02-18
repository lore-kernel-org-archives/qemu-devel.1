Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB14C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 23:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 668F92173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 23:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EpX7k/d1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668F92173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4BvD-0007ak-GH
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 18:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4BuP-0006vp-KX
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 18:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4BuN-0001WM-52
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 18:04:05 -0500
Received: from ozlabs.org ([203.11.71.1]:59309)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4BuL-0001DW-Ta; Tue, 18 Feb 2020 18:04:03 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48Mby05XjNz9sRR; Wed, 19 Feb 2020 10:03:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582067032;
 bh=rkPgt6jXJi7QF4cjqfcNLz4YpVHEuFgjaJmivwsrDvY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EpX7k/d174PRTOX7GU6hoQAIBtguBYT8p3fKuyxmqIWgqXrJBEWuk4z3ToDEbKcax
 ZwoIYk31iv0VwTkbdOnevwuFmy7cRdCg8t1WzMWE/WafNcGpN1aQcTchv0E9Jhn5WJ
 kW23Ck5BPGnxy5HT+o3f6A13qA72nZn6HtQi7ork=
Date: Wed, 19 Feb 2020 10:03:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: kuhn.chenqun@huawei.com
Subject: Re: [PATCH 2/3] hw/ppc/virtex_ml507:fix leak of fdevice tree blob
Message-ID: <20200218230336.GB1764@umbus.fritz.box>
References: <20200218091154.21696-1-kuhn.chenqun@huawei.com>
 <20200218091154.21696-3-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <20200218091154.21696-3-kuhn.chenqun@huawei.com>
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
Cc: marex@denx.de, zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 crwulff@gmail.com, pannengyuan@huawei.com, qemu-devel@nongnu.org,
 jcmvbkbc@gmail.com, qemu-ppc@nongnu.org, pbonzini@redhat.com,
 edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2020 at 05:11:53PM +0800, kuhn.chenqun@huawei.com wrote:
> From: Chen Qun <kuhn.chenqun@huawei.com>
>=20
> The device tree blob returned by load_device_tree is malloced.
> We should free it after cpu_physical_memory_write().
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>

I've applied this patch to my ppc-for-5.0 staging tree.

> ---
>  hw/ppc/virtex_ml507.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 91dd00ee91..4eef70069f 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -188,6 +188,7 @@ static int xilinx_load_device_tree(hwaddr addr,
>      if (r < 0)
>          fprintf(stderr, "couldn't set /chosen/bootargs\n");
>      cpu_physical_memory_write(addr, fdt, fdt_size);
> +    g_free(fdt);
>      return fdt_size;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5MbUgACgkQbDjKyiDZ
s5Ii8A//RgTALOcIdmA/nXzdZU8Cop0ZCOw2+iHHDAqP9s8SwUw9SX+GuXIksj1F
R+XWJbpOU4spgO36DKUJMEaXdSV+YRptODZmp6RgFLOld74NnWYguJc8DlMoZb8u
qk2CCc5PqBqRGCFFMzfAVojwN8HwyMVh2l7lmj3pmw1jzQWchqDBIr+e6Ja65RBC
kujKfaw9hWYhJOynYgYU/AvzWTpt1bebHYlKsUx+hcht7lLxNIO3AFtMyGne6unP
9/l4rPi5ixg+rj62MQPGwQFpstX/SamZs5nqffsMtKbGeCxJYsRpK737YUgf/0/N
IpEnlfWcryOoO3VeNYZZrYjgCeOYohrVo4DIC5sspAAq87eOCmF+DbxFMeS1O8TI
vnr39geUlMX+4K9nHWh8bPHgrZN5GS+VqvUC1IasUS1Brq22q/DebLjtFR2oIxgh
0qARBuCEohBDtbaNFi5Q1/fEsfjqG/eMCSCg4nBCs+izmb/+6SvTtlqBoSXM5I7Y
5S2FjQhOGmR4BgSIaenSM1v3umZ/OJCOcuyNfCzvFzul6/DXm1ZO08MMyorC5NqH
0eRbRPpRMkkLFrYX/AntE58J0AfZ5qKCb3K1smRFNEGD6hAiCyI0RNqD2943Ke5G
gCnjzW/QGpqh4sIrg3PRAad0uAVhHq+57EXnKMfJI1nb4urBuNY=
=JP2C
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--

