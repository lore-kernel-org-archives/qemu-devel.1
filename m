Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3417DC55179
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 04:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81648208C7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 04:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eg2DvP/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81648208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXdBe-0003mr-MU
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 00:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXd6N-00066S-IG; Wed, 28 Oct 2020 00:30:23 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXd6K-0002a2-Ov; Wed, 28 Oct 2020 00:30:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLbGG6TNhz9sWH; Wed, 28 Oct 2020 15:30:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603859414;
 bh=4adRTVELwxF6Sc7ccXKYfneCpG4KJ5uE0zT9+mltIzg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eg2DvP/cbGfPcgQENEFXjQuefYsOc9HKpJI7YYqfiFPv0ZAn3zl0WoCfxeaa2XgGM
 dJjmN9WBdnw1VFbdicBIZWfli3dKL2bf+Vg5L2WEKYHMWSe4j7xCxtSwe1z1neFes8
 X51tQN12MRO/Cf09qXhkKqteySWosji7d8VDqJK0=
Date: Wed, 28 Oct 2020 15:27:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Chen Qun <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH] target/ppc/excp_helper: Add a missing break for
 POWERPC_EXCP_HISI
Message-ID: <20201028042758.GB5604@yekko.fritz.box>
References: <20201028041620.2168707-1-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <20201028041620.2168707-1-kuhn.chenqun@huawei.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, clg@kaod.org, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2020 at 12:16:20PM +0800, Chen Qun wrote:
> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warn=
ing:
> ../target/ppc/excp_helper.c: In function =E2=80=98powerpc_excp=E2=80=99:
> ../target/ppc/excp_helper.c:529:13: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
>   529 |         msr |=3D env->error_code;
>       |         ~~~~^~~~~~~~~~~~~~~~~~
> ../target/ppc/excp_helper.c:530:5: note: here
>   530 |     case POWERPC_EXCP_HDECR:     /* Hypervisor decrementer except=
ion         */
>       |     ^~~~
>=20
> A break statement may be required to enter this exception.
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>

This change is incorrect.  We definitely need the fallthrough to set
srr[01] properly.  So the correct fix is to annotate the fallthrough,
not remove it.

>=20
> ---
> I guess there's a break missing in 'POWERPC_EXCP_HISI' branch,
> just like the 'POWERPC_EXCP_ISI' branch.
> ---
>  target/ppc/excp_helper.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index a988ba15f4..5e69ac1b33 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -527,6 +527,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
>          break;
>      case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage excep=
tion */
>          msr |=3D env->error_code;
> +        break;
>      case POWERPC_EXCP_HDECR:     /* Hypervisor decrementer exception    =
     */
>      case POWERPC_EXCP_HDSI:      /* Hypervisor data storage exception   =
     */
>      case POWERPC_EXCP_HDSEG:     /* Hypervisor data segment exception   =
     */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+Y804ACgkQbDjKyiDZ
s5KYbRAAj9x5sKKZDO1UtCkxSmrMkCgdFPK/7lVbDwWM7RlJqU4XQ0sJmGh8/BXL
v806PJShiabkjXNUcKJeqKT935BTgQodrVZEU10a0Q5Ef2fQzgO+IRuw3n3q8oyi
A0IYeDr/rbwSLYoMua2H5f1mxI5YeiAIdnb4hkxYyNY0Y0Yj0nv1NMIKm0cWzW01
W/oiVYaBMxHLE4FP5uPQG5bYmjD0knjspGHJYHRtjAJQ7UtKKGxWCI4XXec5PmOF
gtcFGiliBDOtfARroyS8ibZUkFl5Do6WGMhifV1isnuNkQXwb5PGEzy/+XACLhyI
WjaK/4DLex2dMUU6hZBwq4vwWLKr6j7kOQqdvSfBCVQ2mVvutDXePnn0thpPTwb3
mgiuYcJeTOlr4a7GM/wyWPOFtTZ6DvmJQQ0jFOOsvGbphShBkt5mnx58KCu/UtVs
zs4YP3u59RCzMzb5JudXSnb60M9r0eMgIAs2PeYka43NMlxoGmT5KoPMDfJE3foz
JW6dntU8MCYn7b3I8rYziYXwBIwPcWH0AG4kQMBbpnb1jXcr6kz7o+Bt1lCxxaop
bhI1Sa7qWxC7D+D29S+XwAOBTjQai1krqpCBIWf7EL35ddtw1aTvck+gMpp2k0kA
6WAumk+DtLRMi43evTsOt+leruUIDNCgfKUwSpufkH264KA2llI=
=inbc
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--

