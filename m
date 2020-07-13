Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC60C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 05:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6667B20724
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 05:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Tc3+91Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6667B20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juqpS-0000qh-I8
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 01:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1juqnz-0007u7-0S; Mon, 13 Jul 2020 01:15:07 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1juqnw-0008R3-DJ; Mon, 13 Jul 2020 01:15:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B4sK84sZyz9sDX; Mon, 13 Jul 2020 15:14:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594617292;
 bh=an3pZDkzsoje/U3I9hRAVbqqaAQpLW2w9TQVSofFI0U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Tc3+91PiOCDAWacrXT4EDaH6umhzJk91IyE7i4b/xg47ohG1bFWGlaPpKv2M7gUdj
 Yip9biHUrDYRlsZqKZg34dQwxQE6kJPGNPnSYAVZuPvLwJGAT0X0bq7AtBtRpq12PZ
 SN0gL5NUaFLtvwhD7KH1OOY67SpeqzqqF4dB505k=
Date: Mon, 13 Jul 2020 15:14:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Lijun Pan <ljp@linux.ibm.com>
Subject: Re: [PATCH v4 06/11] Update PowerPC AT_HWCAP2 definition
Message-ID: <20200713051400.GA93134@umbus.fritz.box>
References: <20200701234344.91843-1-ljp@linux.ibm.com>
 <20200701234344.91843-7-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20200701234344.91843-7-ljp@linux.ibm.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2020 at 06:43:41PM -0500, Lijun Pan wrote:
> Add PPC2_FEATURE2_ARCH_3_10 to the PowerPC AT_HWCAP2 definitions.
>=20
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
> ---
> v4: add missing changes, and split to 5/11, 6/11, 7/11
> v3: use tcg_gen_gvec_mul()
> v2: fix coding style
>     use Power ISA 3.1 flag
>=20
>  include/elf.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/elf.h b/include/elf.h
> index 8fbfe60e09..1858b95acf 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -554,6 +554,7 @@ typedef struct {
>  #define PPC_FEATURE2_HTM_NOSC           0x01000000
>  #define PPC_FEATURE2_ARCH_3_00          0x00800000
>  #define PPC_FEATURE2_HAS_IEEE128        0x00400000
> +#define PPC_FEATURE2_ARCH_3_10          0x00200000
> =20
>  /* Bits present in AT_HWCAP for Sparc.  */


Um.. in the corresponding #defines in the kernel 0x00200000 is given
to PPC_FEATURE2_DARN, and several more bits are allocated past that
point.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8L7ZgACgkQbDjKyiDZ
s5LJqg//Ympr+XTrwDnz4ISbva4Z08u/RO+FYZn0BcX67WLD0sWC8eMr+FGTkgKb
QGe40AXZ6RSPS1AE6mgx8RHpGeKNZddjEQ1RfQOC+xAWFkOsUFTz/OuYIY46WFJT
XBP8FubVBWKLodjlL0STpLlE0HpMca7DaIu1nYNsZNovEAOYA8fSz9LIscoSGVed
FbSrexIJ3sSY968dVSw48YDPvZj44uES1O0UL898oe/guGbo9I9HU4KYOLlwRsJs
uvWiIeEODyF/W4EwUUwtL008z+Ve00BTa4Aa7boIv0fmgEyz37n3FvQEVv7ZWoP6
jELqc+9JtWVQK/N5ObPeS8fjpjIfyZnZUaDKMsWW+VCKu1rSktf/XBRO8Em4+RpZ
Hg4mqNeKjIwGuAM+WMUZ5GbgQQaBrNudaDxSba1A5DNtMn1EOCNR2VpMr1GL2e+V
s6dJlruF7dVakYJAGU11y6hrMD9HIwnMl0yYi3XfWU57FohRTqhOMTaQVosZoqN3
u0Ay3GSNNMDtirFCLwUNbFNrxGnh/4bYE4pchQ6fQ+PLbNbFHHG/YX5s98XdWAMi
0JRubfO9Gytbz5zG1UVhFz48EREHujKRLLLCYoJkBxCKfCt14jR6jglUIoJXkPvy
ApynogHhusUg9pmHLkcwdj76+nOLxVOcW4IEEH5WG18umJbPx4M=
=xM1k
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

