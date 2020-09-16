Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2C0C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752242080C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mZnlg2Qk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752242080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISr6-0007nY-H7
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kISig-0004iX-FN; Wed, 16 Sep 2020 04:23:14 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:40101 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kISid-0005E5-Jk; Wed, 16 Sep 2020 04:23:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BrtQF0WNYz9sS8; Wed, 16 Sep 2020 18:22:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1600244581;
 bh=vLgOrDSqQIgoxOCgpyITbFhYx3DEQa/ax/945SFyFUc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mZnlg2QksL9fNPFobqxOWyRDVVf5REDcGB/nWqVgQ6LresmPpCXrbVZkd7sdLNGN2
 nzotNqG4y7U4JerBaK3qykzulNQbmBR1FeHgStnlXsCbGxcAI/EbuCSUsCB1123vFn
 r8TjxrLQBC3R3hbDLgLZf7nsRePCrGyrbO0CFi9E=
Date: Wed, 16 Sep 2020 12:18:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 4/6] target/ppc: Set instance_align on PowerPCCPU
 TypeInfo
Message-ID: <20200916021804.GB5258@yekko.fritz.box>
References: <20200916004638.2444147-1-richard.henderson@linaro.org>
 <20200916004638.2444147-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <20200916004638.2444147-5-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 05:46:36PM -0700, Richard Henderson wrote:
> Fix alignment of CPUPPCState.vsr.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

LGTM

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: qemu-ppc@nongnu.org
> ---
>  target/ppc/translate_init.c.inc | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/target/ppc/translate_init.c.inc b/target/ppc/translate_init.=
c.inc
> index 230a062d29..accb4f2fae 100644
> --- a/target/ppc/translate_init.c.inc
> +++ b/target/ppc/translate_init.c.inc
> @@ -10960,6 +10960,7 @@ static const TypeInfo ppc_cpu_type_info =3D {
>      .name =3D TYPE_POWERPC_CPU,
>      .parent =3D TYPE_CPU,
>      .instance_size =3D sizeof(PowerPCCPU),
> +    .instance_align =3D __alignof__(PowerPCCPU),
>      .instance_init =3D ppc_cpu_instance_init,
>      .instance_finalize =3D ppc_cpu_instance_finalize,
>      .abstract =3D true,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9hddoACgkQbDjKyiDZ
s5KbxRAAr82cZFqegBl2HNAZc7rmb9W/9wwR1LqzcnCR3dEf+sdKBHM3EEfb4Ox1
x8O3LiPlnXHF2g5KYapsgtX6pXZFv3uwAHObfZ4FxxrTXM20DGXjEKs7csJQQpMs
B2CjuxDATkj1+dfuKy2Rej4+GQ5Omhi4gG+1vO78SjOMQkjCT/yzgJq+quwT2Mh+
4i9Bbi6AHikjWegbJWPKZO4sM0Kdm8tN29tD9Y4hVTNbQ4FFq86Qhhnly2T7TxQs
kweJ3Fdm7lA/W1WN62ani6Sh277kNvA6dknaWEBviasPeOdWfg8VehccEQ4GiV3L
KhNV/Vj1sId2OBBf14xH7zt1Qe99ZouQlJrXZWC9cbSJRI7CGixuBj8mMzeCf/NO
S2gXBNjHL6MwMnrSVutGMEMJO5gZ+LBKBvYa9BQZLi9W2B8hNEk21+QkV/iNuuOx
nsq57xWOiquHX4Dd0cUysHCkvpcCXGMzx4mQZt2XtM3yOSDkP6Ul3p5aotC2eBYB
eAwbUJx6ifwB4mip4cDS4GeQy90S3oB8V07YnUktE4T5vOxifCpp5Zqhhrk8qFiE
qivFkvLdhv7wjI7H2C67LmubKlLKl/vAj7MvBpPt+6NcuDiAogEEcmTEvi1uFpih
S/2J4Ubeg3F2IiG8ZxzT3VJv9egjvzX7mbD+h6pn1+hZ/3YEL+o=
=Hu+A
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--

