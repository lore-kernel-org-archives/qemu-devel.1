Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F6FC35280
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 23:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2ED2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 23:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QYhiah/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2ED2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWpx2-0005sS-4l
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 19:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWpwL-0004gL-UN; Thu, 07 May 2020 19:28:29 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:32917 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWpwK-0001Gt-DA; Thu, 07 May 2020 19:28:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49J8ln69Bfz9sRY; Fri,  8 May 2020 09:28:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588894101;
 bh=LX+UY2kgK6xt3zpJWZqaQ5mDAW6ZkKK/KCa552FQVkg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QYhiah/ZsR6udMeZBvle8a8nmThQ4eHyTkMg8/YrmfBUfyrE+okImaebSSzwWmJ1q
 BH5E4qvjYKKv7EuXjRFz5bHpnhRct81L4bxjV584jm2OkCkHSjd4OFSC1yia5U7YoI
 V4g1WD48SUlEigfjCbgXH+uCP6r3S6BtqPfg1aJ0=
Date: Thu, 7 May 2020 23:52:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ppc/spapr: add a POWER10 CPU model
Message-ID: <20200507135238.GB2282@umbus.fritz.box>
References: <20200507073855.2485680-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <20200507073855.2485680-1-clg@kaod.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Alistair Popple <alistair@popple.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2020 at 09:38:55AM +0200, C=E9dric Le Goater wrote:
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.1, thanks

> ---
>  hw/ppc/spapr_cpu_core.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index ac1c10942771..9c7e0d225a0a 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -410,6 +410,7 @@ static const TypeInfo spapr_cpu_core_type_infos[] =3D=
 {
>      DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
>      DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
>      DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power10_v1.0"),
>  #ifdef CONFIG_KVM
>      DEFINE_SPAPR_CPU_CORE_TYPE("host"),
>  #endif

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl60EqYACgkQbDjKyiDZ
s5IgLxAAtDnMURNgzOLywjiHEVfKzssBzwO8EGaKIPkCi+j+pqlgEVCzr/K+/Wy/
R5/D/EfEvpAED1ReloqIj9QZPQEeQY4No98Y1zZ+/TatOQoUyP97VgNcLLmNfqlV
OPKBomWqFDVo5+lJ5kp1tWZbeqmOmSxTUCHUcJiDcsfsA/piMP6rKnYQkvsI3lxK
at8e2YCs523bkDMP+Y9MC8OlkhB6XglM4Ppj8twHPxpMrXdfexEznC7EWVFRmGg/
+r4hW2LaoIexQTzom/m8Bgjw75W8U6F5thMM220GUSGLJmzC4ArQHrswMooFIZTL
XCKMCCdm8+5kCoeZ3FkP6sCYam61/iOQtV5JH/902UKl8aIVmthtmekz9ppJfYfs
aX09619/yDZGn8duc8lqIdmS0gm9bs00X91iEyh8Mb0Pyyqp6uBLPbPeyMndNbeW
HqgI7vrVDZ6VYbKJbo9j9JOwBuUnLE4CM9kahXvHHMMZUNwhXgB3POmvN+HVCQp/
xaWSiOwRI1no6RRsHCPb5/4Hg+Q8OPBFMUL9SMDNzzQw+ciSxbfXy6czfV5JzNKr
eIAgkD8sgdTUknbl2f2tqU0ZuOpejwRemIvYXQIQn/qDN/2DUebYUtb+tbKFdmPR
I2+6SDbYWQv70XFpxaa1moUXBnPWgo3fcI2OHs/C127AbdzXe8g=
=OfeW
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--

