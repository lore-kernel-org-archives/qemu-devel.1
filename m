Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F4DC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C74206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="yhxrsUQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C74206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA7wv-0006Rx-Nl
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 04:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1kA7w7-0005XX-ML
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 04:34:39 -0400
Received: from charlie.dont.surf ([128.199.63.193]:55652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1kA7w5-0003pW-Hn
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 04:34:39 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 04B66BF553;
 Mon, 24 Aug 2020 08:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1598258074;
 bh=Aj8/Q8Q+mA1d2aldDGG1Yghwvl0LJFSd3zY2mZZ9COQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yhxrsUQlkik5BtLVkmG8I/N7NbLy5+BRviivRy3ktYmTOkFjcyhG5YvP1taufb1YO
 tdS9s/m5Q8gvDptilm7VI4vHboIAqFlUgMlPoR7+1prjnAdCpdlVGsh9yfPQXauZ9i
 bkEOiKp5ojSC+0E31DCGdPyDhfgvf47796MMA/yHTPSXOXfKyjO+MapUYPOahPU7/d
 Hmfpe51DfMI0rYjpuwwmEauL4jHRJ0RDSwUWtwYToHRquB02rYJDGHc5AYSoYBXe30
 RjLEmeUJqUcYHdMHgsKDfWRuY+q8u7PTNlnI+CJ8KKHQKfYokJWs6z8swVgFTrGaVs
 TCL/0+PlkWthg==
Date: Mon, 24 Aug 2020 10:34:29 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] meson: drop keymaps symlink
Message-ID: <20200824083429.GA439541@apples.localdomain>
References: <20200824074057.3673-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20200824074057.3673-1-kraxel@redhat.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 04:34:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 24 09:40, Gerd Hoffmann wrote:
> We are building the keymaps by default now.  Drop the keymaps symlink
> so the generated files are actually written to the build tree not the
> source tree.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 67832e3bab76..428fa33be140 100755
> --- a/configure
> +++ b/configure
> @@ -8119,7 +8119,7 @@ DIRS=3D"$DIRS roms/seabios"
>  LINKS=3D"Makefile"
>  LINKS=3D"$LINKS tests/tcg/lm32/Makefile"
>  LINKS=3D"$LINKS tests/tcg/Makefile.target"
> -LINKS=3D"$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
> +LINKS=3D"$LINKS pc-bios/optionrom/Makefile"
>  LINKS=3D"$LINKS pc-bios/s390-ccw/Makefile"
>  LINKS=3D"$LINKS roms/seabios/Makefile"
>  LINKS=3D"$LINKS pc-bios/qemu-icon.bmp"
> --=20
> 2.27.0
>=20

Tested-by: Klaus Jensen <k.jensen@samsung.com>

Awesome! This fixes cluttering of the source tree with changed
pc-bios/keymaps/ files for me.

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9De5AACgkQTeGvMW1P
Denq/wgAn/eONAi3+/R+idcoJ10502ePJLNX9f81lEJIVwKVxL+fJvZUjPt7Z5jr
SdUSue5O4uGmB1EZkSNbwqqTChmpD0bBWj9Bk1ZQAbost/ntn9iHSrrtIgVlVSsI
9MhF9D1NrMtv0nvjoZ1Z4RHqelEb4PaT0ijKTwCcC1fRIa2ZYvtb7DH79JwNNEER
Fis3bVUWk/xlBHhPl4uLlG8/56d4S/vr5YlwhGK5NFWMCBtuL7QpBKT2H57QgqXn
lNFLDh8wVeBHG+PJb6gI46Lvs0Lh9VJKjyKepCLy7zm+YSkR45sHVM8nCx+5Rndd
iIl2nehruvN/gL9nffCFZ6FgXhD7oA==
=mWO9
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--

