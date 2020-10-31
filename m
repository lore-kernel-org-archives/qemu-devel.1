Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF9EC388F7
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 05:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32842087E
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 05:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UgUjBTdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32842087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYjI7-0001Vi-So
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 01:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kYjHO-0000X1-NI; Sat, 31 Oct 2020 01:18:18 -0400
Received: from ozlabs.org ([203.11.71.1]:35077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kYjHM-0006qP-3Z; Sat, 31 Oct 2020 01:18:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CNSB45Lwqz9sRR; Sat, 31 Oct 2020 16:18:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1604121484;
 bh=SD/6EktFL3jo9p46qfHml/6Av4lfLaWVzoHjf8lDjlo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UgUjBTdFN7uU4VF4p/21Dv1704uWVY/v++ZY4jASRjqZP/uzQj641akCEeFIwIYq7
 K7pWGo2TmndJKy9yBJrLeS6eZdaMdCWNTs5PFpQblPuEjnHp8OP5x3M4LceF4z546R
 2nWDN8IaZrsmZI2HB4hyrMc4rvUG2tv9aUFL02bs=
Date: Sat, 31 Oct 2020 16:01:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Chen Qun <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH v2 8/8] target/ppc: replaced the TODO with LOG_UNIMP and
 add break for silence warnings
Message-ID: <20201031050146.GB17638@yekko.fritz.box>
References: <20201030004046.2191790-1-kuhn.chenqun@huawei.com>
 <20201030004046.2191790-9-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20201030004046.2191790-9-kuhn.chenqun@huawei.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 01:18:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
 Euler Robot <euler.robot@huawei.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 08:40:46AM +0800, Chen Qun wrote:
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
> Use "qemu_log_mask(LOG_UNIMP**)" instead of the TODO comment.
> And add the break statement to fix it.
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v1->v2: replace the TODO by a LOG_UNIMP call and add break statement(Base=
 on Philippe's comments)
>=20
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  target/ppc/mmu_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 8972714775..12723362b7 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1349,11 +1349,12 @@ void dump_mmu(CPUPPCState *env)
>          break;
>      case POWERPC_MMU_3_00:
>          if (ppc64_v3_radix(env_archcpu(env))) {
> -            /* TODO - Unsupported */
> +            qemu_log_mask(LOG_UNIMP, "%s: the PPC64 MMU unsupported\n",
> +                          __func__);
>          } else {
>              dump_slb(env_archcpu(env));
> -            break;
>          }
> +        break;
>  #endif
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimplemented\n", __func__);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+c77oACgkQbDjKyiDZ
s5KmXw//fUXxS0q3GXCTHhhhlwDAMRGXoWlqoehoDx0Sf4gTaSLCi3Q6yfDc9kCo
vPq2exY4gX2Q7zE76M76GWfKHjla8uw9wQrXFCejnVbJ+3BjSXbiLE6Kx8ZL/+9a
nnRsjtXa+MrdNNojC2P7ty5ijMB0JVRw+cQ42zXNuzvlEHELhtUqhCOFGrK4b3lb
Wdkqyuc9/IoJI+nFEQsL1ta6xnIyEftUtV1dao5kusA20dTWhogAvUPLqg95UGyc
lhZCV5wlQEQgC+gsZGEEhXl8c6C2RvbUYjW/W/tJYrfZuhFAQN8F6EOIuc2f5GHV
UpwAKtk0elsxybmg9x5nt7cNFsX/ULlIgRSItdhLKHGFh1oyR6KrCVmaJV2LMDQR
SaLaston/G2I71Pp+PTU2eKpsReLbr5BYCn3kIdGxmU/87vTyrjmXQ/XAx1OcAMm
RU4uFSewqgSDdp4jvWbaI1HpXjVgeCjAr76BxJTOaxy29zbOkVTdxgqrM39AtNgR
JWH/cHobFA0Na8SMGrWCAX5x5ZW+Vd8Or6wbCxbOz81z17HP+UZDZAuQb8MUQNIN
B0tjoF02/oprBoNiAVXqIB7GDqTJuNdGS0FdzpKFmD5vPsFBK9rMCl7tAExGBLeM
gb4G97kxAu6SKCEE/FCeDnfdU9kt08LhjKlwC5YaU1lx6fEQtAE=
=05Q7
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--

