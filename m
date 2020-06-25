Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F60C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 03:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E8920709
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 03:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eMuEFYAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E8920709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joIwl-0006kL-PA
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 23:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joIwA-0006E4-M6; Wed, 24 Jun 2020 23:52:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57851 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joIw7-0003dV-H5; Wed, 24 Jun 2020 23:52:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49smLD6xcFz9sSt; Thu, 25 Jun 2020 13:52:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593057140;
 bh=M/qDfRI8OQqzYJWCn/1VR1SPOvZkiiY5fPPgtoyCWo8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eMuEFYAmvg3X4/tqdFCPapgmNgyfTFa37aLR4+DHrMX1OYIRArq+hEOUIeYRR5k7N
 XF9XWIbGIRaMaHzJyeT7zyBAclZLR/FtxVeF4XTbQjJTRbucPIun5N2gUFvvh2j8A8
 niKNL5X7DbQRrpuX47ID04BZQJQCJuB5y/tQBCOg=
Date: Thu, 25 Jun 2020 13:52:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 07/25] spapr: Plug minor memory leak in
 spapr_machine_init()
Message-ID: <20200625035215.GE69292@umbus.fritz.box>
References: <20200624083737.3086768-1-armbru@redhat.com>
 <20200624083737.3086768-8-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Uwl7UQhJk99r8jnw"
Content-Disposition: inline
In-Reply-To: <20200624083737.3086768-8-armbru@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 22:09:21
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
Cc: David Gibson <dgibson@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2020 at 10:37:19AM +0200, Markus Armbruster wrote:
> spapr_machine_init() leaks an Error object when
> kvmppc_check_papr_resize_hpt() fails and spapr->resize_hpt is
> SPAPR_RESIZE_HPT_DISABLED, i.e. when the host doesn't support hash
> page table resizing, and the user didn't ask for it.  As harmless as
> memory leaks can possibly be.  Plug it.
>=20
> Fixes: 30f4b05bd090564181554d0890605eb2c143e4ea
> Cc: David Gibson <dgibson@redhat.com>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index bd9345cdac..9bd2183ead 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2731,6 +2731,7 @@ static void spapr_machine_init(MachineState *machin=
e)
>          error_report_err(resize_hpt_err);
>          exit(1);
>      }
> +    error_free(resize_hpt_err);
> =20
>      spapr->rma_size =3D spapr_rma_size(spapr, &error_fatal);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl70H20ACgkQbDjKyiDZ
s5IJjBAAxa/djQbmQ+EhGAJ2gA4ijYwS677gPt4vfiSEN0M7IsD5Y/SLGI6r/vqk
92iZlgL8JIfSf+E25s+J6Jh8zruXPXvecowPq1DLUV3a9VwpxxaFvoGwmcPZ3fdW
KdFqMByr4Sd4vrU4EsCbWru1kD5Iy6R7bcMrVTQ7a10idoPkaN22EEpETBr/r54j
A+6hADQEukAfv0Ti2uBvoPDNNUyI9QJ3cVPho1bHKOF1z5+pLmW8xtNcKM+ooPnk
edt31O+uf8fYZg1W8Du8V8Nym2qLyKTzfocvTmJPXKG03xsOcfo1f2npraaZ2dNY
TrMMAFTHZb1tV8AJWPXFYqQgpL9Nw3JTkFnDPJQjQX5clnVHK/8Ytvn13kg9scae
v+j+rA7005xrbJJQNlU1ZPR/LH2YB/AtD8cQgCmfsbAGBNgitWqiEJ7LAStu6tvf
2mIYRjDzwQF3Op6/jUWYZ32IOAh6QgQGEiUlJG8Ihxa2+G1X/TRPf5gEAUsw18mW
RCuVtgVmGVzK/wQlD7Eb1/uZ4WEnpM+27XtjZlVz1KIjq3J9dz8oq1J2FFDLZls8
zDMUwQ9f/V7ac95vRG3odS37N6Mk3kVYnPlxkOVw9xQ1vDwqNbMTDmTzb6JxCewY
4dYqpiSFABol2DpRGqtmbnPVPSb7dvK0W/8aIhDdhI0JVugDIoM=
=Nga8
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--

