Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFEBC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 04:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02C4208C7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 04:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PLyAbFB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02C4208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXdBd-0003mC-SM
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 00:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXd6N-00066b-NY; Wed, 28 Oct 2020 00:30:23 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47465 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXd6K-0002al-N8; Wed, 28 Oct 2020 00:30:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLbGH4BpJz9sWL; Wed, 28 Oct 2020 15:30:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603859415;
 bh=2kaPp802qzi8JciMFRifQFEAGJ96LTqZpquodN8UlFw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PLyAbFB9997sf70m0p2ELxNJaYBi1tLSZzdxRbMj6SMalVpzPkcHydKFtcUP1rNuZ
 BLifFGXKoo37QB118368uA/UVogPsiNcfLt2P8oFyYeACq98iKfztL+0c9m+rLKYUV
 nBtKZtChNMi6KAdbvtbEencVoq9wWy+62xXQfgSE=
Date: Wed, 28 Oct 2020 15:30:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Chen Qun <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH 8/9] target/ppc: silence the compiler warnings
Message-ID: <20201028043009.GD5604@yekko.fritz.box>
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-9-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
In-Reply-To: <20201028041819.2169003-9-kuhn.chenqun@huawei.com>
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
Cc: qemu-trivial@nongnu.org, Euler Robot <euler.robot@huawei.com>,
 qemu-devel@nongnu.org, ganqixin@huawei.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2020 at 12:18:18PM +0800, Chen Qun wrote:
> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warn=
ing:
> target/ppc/mmu_helper.c: In function =E2=80=98dump_mmu=E2=80=99:
> target/ppc/mmu_helper.c:1351:12: warning: this statement may fall through=
 [-Wimplicit-fallthrough=3D]
>  1351 |         if (ppc64_v3_radix(env_archcpu(env))) {
>       |            ^
> target/ppc/mmu_helper.c:1358:5: note: here
>  1358 |     default:
>       |     ^~~~~~~
>=20
> Add the corresponding "fall through" comment to fix it.
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Cc: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/mmu_helper.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 8972714775..51749b62df 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1355,6 +1355,7 @@ void dump_mmu(CPUPPCState *env)
>              break;
>          }
>  #endif
> +        /* fall through */
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimplemented\n", __func__);
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+Y89EACgkQbDjKyiDZ
s5IVlw/+Jleirpt6htO9WLdpxyRccf0p8VXO52dK9GDgB5ES6sIPpAn5r8MIClA/
A3b/fL/RPz/59dFwyk7qda2aaeMKp4FfTn4qfTfCcMlPm24ZITyIqgja+tAICU86
PRkOZM4eZAiYmzIK4dzaXx8yjP8woqqvynwfTNx/k8s9Z1px12E8FhCtPyKDzpa+
kXowefILfUCPZJawyWfD8QPb7IdfFrPUdvzzsqInQmqcMp1zXUyf7YcKVqu10Mn2
Krw0ejVdAdZb5FVyIP9SOA7bbnfz46zmRfqXi8c0qQHNgZX+W/x+vjYeXCfTRgul
LskBo+ReGpRO3SXMqRkHguBScgmYQK5PdCAccLUXlcaNyk0lOhn15pRBXoAaZ469
LAi78BuK6RAU16JSJNg5KmrUDR/szUyO0dXDRg/768gJ2zxTM0qGWRf/uQmZjcXm
xkfZTB4d9pj2Q8KRkxQyJ8zXk/VowWDdbjKk4Alwaw0Jv7egdlHE3RUAsNhWMNcy
gjjy8wvh4RnlKAgytGqjcB0XuMtMxFQ2nO6rsuqK+u5kN02jOKKQD2yWV3GWgzJM
l6D3zZldhyX1mgp4+HI18j6gLMOpgig15b6sMlMFXWHTSYibXiBO6joJjynIMC4K
PsO1S/jGAOoiV3wZ1v3QuI3D5jG9A3geeFOJNPAyrCRa6DHtgn0=
=KNQV
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--

