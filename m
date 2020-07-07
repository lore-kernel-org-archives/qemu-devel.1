Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E44C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABEE7206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FenY9shr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEE7206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsiqQ-0008MY-SK
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 04:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jsipa-0007R9-MC; Tue, 07 Jul 2020 04:19:58 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37529 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jsipV-00075l-Qo; Tue, 07 Jul 2020 04:19:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B1FjC5pgqz9sRK; Tue,  7 Jul 2020 18:19:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594109983;
 bh=aRIslm7NJnT/HB9HWzDznfUKgYQvdCDYTbMa7qB/+Lo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FenY9shrwY0q7ujw/bZW829Yx6TuSmxpfBz53rnwfp6vQGVM9Lz8wfwaIoWK0tafZ
 jPgq8FGBnEodD4pQlpoh7bSwk7gI8Ok8/wI2/w2Ok+fTIo9ZdPBWWmcC/2F1YMdwAF
 bazzxTCJl3hdwgFk4GRJA3qOeH/mlAMyKpZVQES8=
Date: Tue, 7 Jul 2020 18:19:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] tests: Skip over pcrUpdateCounter byte in result
 comparison
Message-ID: <20200707081938.GB18595@umbus.fritz.box>
References: <20200707040522.4013885-1-stefanb@linux.vnet.ibm.com>
 <20200707040522.4013885-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <20200707040522.4013885-3-stefanb@linux.vnet.ibm.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 04:19:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
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
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2020 at 12:05:22AM -0400, Stefan Berger wrote:
> Due to a change in the TPM 2 code the pcrUpdate counter in the
> PCRRead response is now different, so we skip comparison of the
> 14th byte.

Can you elaborate on this a bit, both in the code comment and the
commit message.

>=20
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  tests/qtest/tpm-util.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
> index 34efae8f18..58a9593745 100644
> --- a/tests/qtest/tpm-util.c
> +++ b/tests/qtest/tpm-util.c
> @@ -139,7 +139,11 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
> =20
>      tx(s, tpm_pcrread, sizeof(tpm_pcrread), buffer, sizeof(buffer));
> =20
> -    g_assert_cmpmem(buffer, exp_resp_size, exp_resp, exp_resp_size);
> +    /* skip pcrUpdateCounter (14th byte) in comparison */
> +    g_assert(exp_resp_size >=3D 15);
> +    g_assert_cmpmem(buffer, 13, exp_resp, 13);
> +    g_assert_cmpmem(&buffer[14], exp_resp_size - 14,
> +                    &exp_resp[14], exp_resp_size - 14);
>  }
> =20
>  bool tpm_util_swtpm_has_tpm2(void)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8EMBoACgkQbDjKyiDZ
s5K+Ew//eToEIVoQprVyUYeocXFn8irgQOQcLilNJxTeDo7qFcFSWXBIAXf2QuCu
IHq4IcyOfqWUn0ONpIwBaCcwbHX2tGAocrdQ5slKe31dYFNZXaCWkPhLwv1G4pYu
21oKg1rXxYnYs85x6x5mGccKEO3d7Iqe+2+x71xF83Yv5rsExvPY+2GiPp/E9dYG
w85WxL6Jtcf9BVrzVpWInR2Apu22X8SsRA6JzXk85dGfEg7oAkCY6ty5GKnZxhXP
tJBlwyLhCWW3Qx72+Ki92dLk3XUOS1DzOHKfOLWanN2ITeZsSn8sUX6/GZqWmdU/
oFocSIcZuDkUaJ/xfAPidcIJE1PtIXMdRozzmO5O4wUKLtE9YFwEyKZaEYiGkkY4
K4TZ4i83Qe4SaCoO5XLKoPk0Q7WZdo8+00BUb+p+93k+qJlQyA1RdMde76L2k5uk
Rl6DQxLg1wL4PZMI1xe7EqusEle9z9uHJwNPa+zeJeKrfiN80AIsDoNqwSIopXYW
ec6SoC0wzGLFv5fFvfst7H6KVByYo555pOvagpJSMDCLUE7Pdlddzc0TRdXwUGso
htdj66mcCg9EUkfp7/spk4lkvvJPeyMcnjLYeXfcV5GpChCp3q2UO/pEnBHYVjhh
d1moCGCWVcB/03wxgJuYX87pbACyvDWnfx8QcPFGqpBba7YqSWk=
=z7n4
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--

