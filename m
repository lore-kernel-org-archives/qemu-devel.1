Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF248C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269F220639
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZAkQOBtT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269F220639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYENA-0007NM-2u
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 16:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kYEMR-0006pf-Ts; Thu, 29 Oct 2020 16:17:27 -0400
Received: from ozlabs.org ([203.11.71.1]:54737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kYEMP-0001pc-PV; Thu, 29 Oct 2020 16:17:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CMcDc1CWPz9sRk; Fri, 30 Oct 2020 07:17:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1604002640;
 bh=6ZGZICXvUG+nvPbUHQrxtL6nOV3n+/pW644qEk6tJBU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZAkQOBtTr1vXx6qohnUP7PQAtEIlgpZFcqit8Qkdqazw5i7NeVlIx1TYtph21cuV8
 W0SBJN8DoX2gjqyLA63wyAUfo7vEgkHH5Kyhoo33dcU6wSNQp8spLfLYUfzpAjpOAu
 UY4O0YmXo3MEmNGzcXNeCKVaRCErKRjOcmD24yqM=
Date: Fri, 30 Oct 2020 07:11:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/2] spapr: Drop dead code in spapr_reallocate_hpt()
Message-ID: <20201029201149.GL5604@yekko.fritz.box>
References: <160398562892.32380.15006707861753544263.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Z1OTrj3C7qypP14j"
Content-Disposition: inline
In-Reply-To: <160398562892.32380.15006707861753544263.stgit@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 16:17:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-ppc@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Z1OTrj3C7qypP14j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2020 at 04:33:48PM +0100, Greg Kurz wrote:
> Sometimes QEMU needs to allocate the HPT in userspace, namely with TCG
> or PR KVM. This is performed with qemu_memalign() because of alignment
> requirements. Like glib's allocators, its behaviour is to abort on OOM
> instead of returning NULL.
>=20
> This could be changed to qemu_try_memalign(), but in the specific case
> of spapr_reallocate_hpt(), the outcome would be to terminate QEMU anyway
> since no HPT means no MMU for the guest. Drop the dead code instead.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Series applied to ppc-for-5.2.

> ---
>  hw/ppc/spapr.c |    6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 227075103e9a..12a012d9dd09 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1522,12 +1522,6 @@ int spapr_reallocate_hpt(SpaprMachineState *spapr,=
 int shift, Error **errp)
>          int i;
> =20
>          spapr->htab =3D qemu_memalign(size, size);
> -        if (!spapr->htab) {
> -            error_setg_errno(errp, errno,
> -                             "Could not allocate HPT of order %d", shift=
);
> -            return -ENOMEM;
> -        }
> -
>          memset(spapr->htab, 0, size);
>          spapr->htab_shift =3D shift;
> =20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Z1OTrj3C7qypP14j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+bIgMACgkQbDjKyiDZ
s5IY1Q//bsZB8mpQ1CgQeN5qdZ77nHbjX25ZVP+lE7500CIUoiCpGU2H5hM2TFbt
T2nzO5V7xRq8lY+v3V2uuFxgqV5lP1+fPzNFJvaiPMSPiwfsmmeoH78Loo0nakSp
h1sSx4+DalC/bM2c67qGML5ztRcsi6fJzU8YG5xRNl/OxXG5Or3DM9daQZUFyvRc
TibyayesFKsABwaGM5l2huCdAbED/Vhu6ySUYh9QModTfl7igh5zciM+KwduRDc8
7pZwuMK4WM7vKyH9vLiQkeAFTCUNn4yVyaY7s8vcc5jX08T9ZAGx0K89dyLNJOuB
Xn5DX6crMbOmJYM8N+lVEgamsjCLA0LHkKJOQ3AWjXkNTVCP+m9OKASukCBy55xt
U9zvLeVtiwnjde80UElyKB0Yr9XXgb1ZXQYuf9/R+oBmuqAbz7Jv8FxZP7QkqL0U
mnwdwy69b07Qu3uCDjoASAH4vijGgaDfXYKd8p+SfQI0XVbM4a6V2gDMz80Q5oT8
qMK0R5OgYkLOkGFQqhsizpYuiHankaNVOG/Im26VTCRqOXozuK82qF5Y7d7+T6Fc
ZO10ym/6+wNiWKAkLVlM05SKmofaPjZSz9Kw+bVubib2u9VWA3bQboRbOHFl0AFY
N/i9oHVTSHsJEfIEs3SIAKGc+KmXWNeZeqGLQpB6kuYzF5OnWwo=
=HeXc
-----END PGP SIGNATURE-----

--Z1OTrj3C7qypP14j--

