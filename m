Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575C8C4727D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A80206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f7DfGHkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A80206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOM6l-0007Um-NL
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 10:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kOM4x-0005xK-Ia; Fri, 02 Oct 2020 10:30:36 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47035 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kOM4u-0002vO-An; Fri, 02 Oct 2020 10:30:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C2spp1fjvz9sSC; Sat,  3 Oct 2020 00:30:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1601649026;
 bh=7mhcUK3UnJtqotxvqLjSPxf4JZvqf8ducoSuxA7t4R4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f7DfGHkxhwcIKopaJJeuPxb4OQFdz9F1RD8IvDfX6V6O+zU8U0xHaxDhbsjXNP2mc
 o7HD9VnjjlR8H5t2918fvZXA16R3KHRDOfsyq4Hwa0xeVndhBkPVZM+7aiJIdGFYfj
 JZHg0AMgti/nyJbu6ABxw8P8ImBSWyGTipr2PjMc=
Date: Sat, 3 Oct 2020 00:20:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2] ppc/pnv: Increase max firmware size
Message-ID: <20201002142011.GB442245@yekko.fritz.box>
References: <20201002091440.1349326-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20201002091440.1349326-1-clg@kaod.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2020 at 11:14:40AM +0200, C=E9dric Le Goater wrote:
> Builds enabling GCOV can be bigger than 4MB and the limit on FSP
> systems is 16MB.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.2, thanks.

> ---
>  hw/ppc/pnv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 6670967e26a9..d9e52873ea70 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -61,7 +61,7 @@
> =20
>  #define FW_FILE_NAME            "skiboot.lid"
>  #define FW_LOAD_ADDR            0x0
> -#define FW_MAX_SIZE             (4 * MiB)
> +#define FW_MAX_SIZE             (16 * MiB)
> =20
>  #define KERNEL_LOAD_ADDR        0x20000000
>  #define KERNEL_MAX_SIZE         (256 * MiB)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl93NxgACgkQbDjKyiDZ
s5JDLg//b62o6PN3758VN6D2IfPEpOfU7dIzf8LQ7ald2Teot28bI6bOPYWYBLcw
lXcmEErGQL1cjO/G8Z4V23GKiKucSc9emBXEICU+i4zcM4cYQDQa6LBVln/fjtMd
igW+XhV6n3xk4L+gnaWH9ZAO//l4rD4VpXMn+PaKX8+3V7frZR32nzUFecGaOA68
3xOLg8mmqH2oQZqGjwQJAoQYtAI+Q9WQ2lxCXWrHhg8MgRTaIUT5GQnii+PHk3Lh
CNKZiCiM1acLbljGH9y2P09CcSioZhWyI3ZeLI5gstUBt4ZUsrDEQ8FYY773rRkN
CasuzVn3s6omQaBNEzguk/4Qf/I5sSUph08kMNwlEet4vUsE8uViDz3F8jkIBCTc
z27Mp/jND9pOI33/uWIomjcr5XZAwlMI2SVifCXuWKjESPl1d8Odo5Lu3f/q5a+k
w7cQYfh8LpbY0qLh7UhzitX4rCVGUOim4BCXOUAJtYFplnUtrAyrnTx0lbCTwLqz
RoklkKRHYhuej5x+S43ZGD+vVOzt8Jn9oXf/Eve8rPWF6oqwDXzYmgsWDaUAje7a
SJ4VuocfIYdoJEk24wx1HqlUM4TyBVkCRxKBcZtKzVqok9iRXLv89v4Xui8L0cic
wopeNh25NizLne3sp5YqxcfyqsYKEm2UEC7DyzbdBz1B2+3lqE0=
=Gsfp
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--

