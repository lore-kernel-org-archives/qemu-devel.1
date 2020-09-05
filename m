Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12BEC2BBD0
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 08:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73FF2074D
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 08:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FLH0oDu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73FF2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kETUC-0006yA-KY
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 04:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kETTN-0005xs-Ny
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 04:22:57 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kETTK-0007Gw-7h
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 04:22:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bk6wy4hTKz9sTM; Sat,  5 Sep 2020 18:22:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599294162;
 bh=LTVoev1denB9hio2a5SKPMXqfrJuE/XRRP8RdbsXNko=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FLH0oDu1rrCozIZqiZrSSUtOT19oKbzf7HGOkG/F6dIrHNyTW6YuLqiEhI3bOPCbu
 1rUBPPz94FJjc3iU62pKHF/UPKQ55Qcju+bGzPvK+aW5bbMs1aZUzpk4OKDINDm74I
 PFmH3RDtKuu4KyOxYz3eOklX0EWZnQKU7zHIOokE=
Date: Sat, 5 Sep 2020 17:47:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH] docs/system/deprecated: mark ppc64abi32-linux-user
 for deprecation
Message-ID: <20200905074722.GI341806@yekko.fritz.box>
References: <20200904165140.10962-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mXDO3udm/xYWQeMQ"
Content-Disposition: inline
In-Reply-To: <20200904165140.10962-1-alex.bennee@linaro.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mXDO3udm/xYWQeMQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2020 at 05:51:40PM +0100, Alex Benn=E9e wrote:
> It's buggy and we are not sure anyone uses it.
>=20
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  docs/system/deprecated.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 851dbdeb8ab..11c763383d9 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -424,6 +424,15 @@ linux-user mode) is deprecated and will be removed i=
n a future version
>  of QEMU. Support for this CPU was removed from the upstream Linux
>  kernel in 2018, and has also been dropped from glibc.
> =20
> +``ppc64abi32`` CPUs (since 5.2.0)
> +'''''''''''''''''''''''''''''''''
> +
> +The ``ppc64abi32`` architecture has a number of issues which regularly
> +trip up our CI testing and is suspected to be quite broken.
> +Furthermore the maintainers are unsure what the correct behaviour
> +should be and strongly suspect no one actually uses it.
> +
> +
>  Related binaries
>  ----------------
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mXDO3udm/xYWQeMQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9TQoYACgkQbDjKyiDZ
s5IJHhAAvLbJ9Wjnp3uR2itk2UgZS6/hKmnw+bBtdZ9ODkzIUYQ0c/poLm7hBYv0
Fv2mrt3sDuNT6Kely4WgzPbV4j1ARlBCAD+C0JJBeo2rx8f0EBoQSLZjDxJkUeE+
L20jqUB7zEqoSPLi6ilwFwW3FAr4DsBgCim48zEOC/fcD9GPfYHaB4TamIdkx9Xt
zno/WZANREezokCtqxIvqK6vIRjy19+1T/S1qF8NKs2iNP8VEELnDCqi9y+4xNfP
9tdKasXoRRLdbHTWE4YEsbzlj8ea9paNgGVGLpA73Sc/LNDvkAMEG5de60bPFptC
y+fcv+8PpCQIK74ehtVMIAL1PTwQrRST8lkRn1RO+dxNtw+Ev+Q+QWOLkOhPQfzc
Updwk67VbMDI/FAlN/xn14V+0W5M3tpzN9WOSYwLJ4+msDkz2+40IKkoWQV1isic
SELB9kQTfZju9GUkZjStV5bUJRI4GPbmsOPObJ9pmD1s46CprZd+vMyoBY6Fuer8
821WJNyN3cWcDzkMe5jI/ijMU7m0KPLotjs1cmUMQxIVwBbitAvYPYqL26CxkS8n
osXaqqVoulduKFQnmdumzfgPy2BqZbGdS5QmKzRVgEMJt9cLFjIM6QiONzOv39Vl
RJDViAd1mL2B6zV23xDRi5vQlCF43heRkC0u5xArqP9Q7uElXFk=
=QYCO
-----END PGP SIGNATURE-----

--mXDO3udm/xYWQeMQ--

