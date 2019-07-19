Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E884C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 02:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB5F21849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 02:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="h5PPxYd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB5F21849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoItg-0006Qx-Rv
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 22:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46886)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hoItR-0005tD-0C
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 22:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hoItK-0000Aw-BN
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 22:45:05 -0400
Received: from ozlabs.org ([203.11.71.1]:41193)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hoItH-0008UK-6t; Thu, 18 Jul 2019 22:45:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45qb2F5MMlz9s7T; Fri, 19 Jul 2019 12:44:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563504293;
 bh=hGmGfXmvNFtWVt5ZJphGJ6Sy1kg9SY6L6pXASKOINv8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=h5PPxYd/GKTSClBchSQsX7x+HkCSYEfyizhXyFa2yW7g/anP9D013sscH/whWuKxs
 mZgwtFsgNn4cf7dIrMt4FsaXeHnsTik+10a+Hgx4gjTKjKEAz13AmSdPcnvHEJAg9a
 8H0WuwZLsgst2Y5CB6JK4EAGvmyKpAwjIJT45KG8=
Date: Fri, 19 Jul 2019 12:22:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190719022251.GP8468@umbus.fritz.box>
References: <20190716053522.78813-1-aik@ozlabs.ru>
 <8b727864-1634-0a5d-c557-fcaa52c49434@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ccJhwVfaC+fHwTsl"
Content-Disposition: inline
In-Reply-To: <8b727864-1634-0a5d-c557-fcaa52c49434@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [RFC PATCH qemu] spapr: Stop providing RTAS blob
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ccJhwVfaC+fHwTsl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2019 at 09:20:56AM +0200, Thomas Huth wrote:
> On 16/07/2019 07.35, Alexey Kardashevskiy wrote:
> > SLOF implements one itself so let's remove it from QEMU. It is one less
> > image and simpler setup as the RTAS blob never stays in its initial pla=
ce
> > anyway as the guest OS always decides where to put it.
> >=20
> > This totally depends on https://patchwork.ozlabs.org/patch/1132440/ ,
> > hence RFC.
>=20
> Patch looks basically fine for me, but I wonder whether we should wait
> for one or two releases until we really remove it from QEMU, so that it
> is still possible to test the latest QEMU with older SLOF releases for a
> while (which is sometimes useful when hunting bugs). Or should this
> maybe even go through the official deprecation process (i.e. with an
> entry in qemu-deprecated.texi)?

I don't really like this idea.  It blocks some cleanups I'd like to do
which rely on it being truly gone, not just sometimes-gone.

I think it's reasonable to do this, since the "raw" rtas blob from
qemu was never supposed to be a guest visible artifact - any guest
that was relying on this was going out of its way to be fragile.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ccJhwVfaC+fHwTsl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0xKXgACgkQbDjKyiDZ
s5KBUA/+MYOm0WpTcz+LSjFIrXdBHOu+qqa7iOXf4xCUNxKC2VBrVXy2Ouetfl5e
lTJ7zUtKSPubWkBMSN49gvWNu/24OMwUAvoVYK+/NUKuZfzzGbKoiMiAU6kUEdDx
zGF5+rw+LjNgmxy7Fl0R6nipXKZCnEk80AEI1lEwrJjgEy7A6QsEezSpXRIla568
tvvtqOz44jWnBx/JESL96uORkWkdQ2k/9AnnqE6yBhTJtw4gj3/SfWTJsKhkDSsH
i57EbKB+6y139mxDPsS1InfMO7CmN1NwpNvPvta33mfXYq1grRbkMn/W6ckZcjzA
L1A70/yfeAUHNRzJxUXV7oYd87ihQ1nkaZiCq9rFnEQH7+bUcNSDrpN9aakvzCGF
vGtTlzog51GwqhZpb/4D4BfAClqqUZPniVKTSIhwK0/c1d6wiyFLu5fX2m6MLL8y
IfMWr/iQCa49GbuC7FAXHo+VKFp6851033lz2fG7oXKS2jBTYzO4PcQD3yNctY9o
pyWjn6QXuBCbpM7UTOCqPmoJaAS/6PRZDsU/bUn1yUpv4gsggQwM5p7uNAiislHc
ZTxfw3RhFHw1dZS4mM7aJ2KqdLkGhVMVtmC8IsTw4sOD2UfLlNsH71Sc7m5nLEF1
T95Gh9aYEh5DuEYm8tzFcq48stgnm4S1yqqOSMY+nhbXmXb2yqw=
=Owd/
-----END PGP SIGNATURE-----

--ccJhwVfaC+fHwTsl--

