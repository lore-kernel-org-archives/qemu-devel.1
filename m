Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6F7C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1745A206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bEETd27Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1745A206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40863 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNtda-0007Uh-8X
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 02:31:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVs-0000vX-Uu
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVr-0002nF-0J
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:40 -0400
Received: from ozlabs.org ([203.11.71.1]:37175)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNtVo-0002iM-V3; Tue, 07 May 2019 02:23:38 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yqL35N1Wz9sNT; Tue,  7 May 2019 16:23:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557210203;
	bh=ohFGequI5YLEF6PFqtIqds6MwpxK33C0I2m+sA2JVGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEETd27Zu0YhgNPmOTU99Ce/vE6JhvQC1C3/f1JDA2cL/bOLVy1o68oJ7EEof/tdl
	YwNccHrdBMGwk6dtKy+F4Ay8v6lPlNA3c3czhSNQfkBgLTCM8wqXitw2WlFfboB4fX
	4Nbv9fqRRhEDjei7avFf21hJQ+wZHcu/Il54UG0A=
Date: Tue, 7 May 2019 15:30:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@ozlabs.org>
Message-ID: <20190507053031.GL7073@umbus.fritz.box>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-7-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yQDbd2FCF2Yhw41T"
Content-Disposition: inline
In-Reply-To: <20190507004811.29968-7-anton@ozlabs.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 7/9] target/ppc: Fix vrlwmi and vrlwnm
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, f4bug@amsat.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--yQDbd2FCF2Yhw41T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 10:48:09AM +1000, Anton Blanchard wrote:
> We should only look at 5 bits of each byte, not 6.
>=20
> Fixes: 3e00884f4e9f ("target-ppc: add vrldnmi and vrlwmi instructions")
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>

Hrm.  So, what lives in those extra bits in the 'w' instructions?  Is
ignoring it correct?  Should we throw an exception?  Does it mean
something else?

> ---
>  target/ppc/int_helper.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index fd715b4076..111586c981 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -1652,7 +1652,7 @@ void helper_vrsqrtefp(CPUPPCState *env, ppc_avr_t *=
r, ppc_avr_t *b)
>      }
>  }
> =20
> -#define VRLMI(name, size, element, insert)                            \
> +#define VRLMI(name, size, element, insert, modifier_bits)             \
>  void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)          \
>  {                                                                     \
>      int i;                                                            \
> @@ -1662,9 +1662,9 @@ void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_=
avr_t *b)          \
>          uint##size##_t src3 =3D r->element[i];                          \
>          uint##size##_t begin, end, shift, mask, rot_val;              \
>                                                                        \
> -        shift =3D extract##size(src2, 0, 6);                            \
> -        end   =3D extract##size(src2, 8, 6);                            \
> -        begin =3D extract##size(src2, 16, 6);                           \
> +        shift =3D extract##size(src2, 0, modifier_bits);                \
> +        end   =3D extract##size(src2, 8, modifier_bits);                \
> +        begin =3D extract##size(src2, 16, modifier_bits);               \
>          rot_val =3D rol##size(src1, shift);                             \
>          mask =3D mask_u##size(begin, end);                              \
>          if (insert) {                                                 \
> @@ -1675,10 +1675,10 @@ void helper_##name(ppc_avr_t *r, ppc_avr_t *a, pp=
c_avr_t *b)          \
>      }                                                                 \
>  }
> =20
> -VRLMI(vrldmi, 64, u64, 1);
> -VRLMI(vrlwmi, 32, u32, 1);
> -VRLMI(vrldnm, 64, u64, 0);
> -VRLMI(vrlwnm, 32, u32, 0);
> +VRLMI(vrldmi, 64, u64, 1, 6);
> +VRLMI(vrlwmi, 32, u32, 1, 5);
> +VRLMI(vrldnm, 64, u64, 0, 6);
> +VRLMI(vrlwnm, 32, u32, 0, 5);
> =20
>  void helper_vsel(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t=
 *b,
>                   ppc_avr_t *c)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yQDbd2FCF2Yhw41T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzRF/cACgkQbDjKyiDZ
s5JMVA/6AqocD2iWrzbOWuAKlIdQ8DTiKsjbHyNuAwLivgaMc0CrWOl6eTu3Tn3M
Qxwal7bQDsgwnJO8lzXn6JprS703Q6A/59p4VkTXgdZ3pTOYT5+69f/mu6SHLBXD
lk5nJNDNQ28zyAwWj5F3gFvzygAmoEua5aaHZvpro6Qrz1c+PTKGXXBBpGAcixTL
4kisX6OVMGbe196gubMlQi8riM1fDQT2XjWIF0HsUcGiJFSiVtPUqEgRWRzD99nD
eLWVdeCM70mb1dJeLQU8RP8b5B9M4+Y80QG+Nq/jOpKFCgOR+upJEh8LXBqCftqg
YT21427xc2wbKTHGRlKxE2g20NiKhu2tCzoUKqe2XldhTXqUkgMbRzjrsJnA3yg5
EKeUOc6FHqkvFtbFPZHob2m3kvP1OJdjVcBpC+9EuvyvzexpoGLUpLKDx2OQmzB2
6xFmeGJF5viqHDPePp3zZYnKdAMSR++BdtOzYIiB2saSrKsrUyIAhbzXIVYGZ0Vl
gWY5vSiK2p3s78qkX9k049TwB7aAGOyxWzoHRsy9OYX/sNEFo4GkCthiKBOF3mPZ
ozlIXKOCiRHYuMqMvTXGB38kwJ6/TpUM3gVWCEDn/eX+wD7kkz9+5s2DRfSdwqAv
NJtdKOdPmykdJpTWZaOUklRp/y/aGaRsrhHR6IkVUA1mMp8THW4=
=xlhX
-----END PGP SIGNATURE-----

--yQDbd2FCF2Yhw41T--

