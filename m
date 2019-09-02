Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4C4C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 11:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BEF216C8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 11:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="N4ZMP07+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BEF216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4kGi-0001cZ-EC
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 07:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i4kFr-00018z-BY
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 07:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i4kFp-0000aE-OC
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 07:12:15 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48507 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i4kFn-0000PS-9q; Mon, 02 Sep 2019 07:12:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46MS8l26vRz9sDQ; Mon,  2 Sep 2019 21:12:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567422727;
 bh=K1bYLC+UyHqiOVfioDCOAx7SO3Do6c00TTgBnw+4rAs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N4ZMP07+/NxcXhLqsubn/ARiAwJKOf5T8A6aecq27mQj5jhFGAW1DVYkav/3CWo3k
 WF+W+buSorBEiLeCcw9ZUxA+WUbMrkqvFf+dYaob/mA/IfDjg5Ft54O/Fj/F2JPu3c
 1rKiMjgjvgfNyHj6qD3D7KpUziRWpfh/ltLIzX50=
Date: Mon, 2 Sep 2019 20:28:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190902102844.GD30674@umbus.fritz.box>
References: <20190902092932.20200-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline
In-Reply-To: <20190902092932.20200-1-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix "bmc" node name in DT
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


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2019 at 11:29:32AM +0200, C=E9dric Le Goater wrote:
> Fixes the dtc output :
>=20
> ERROR (node_name_chars): //bmc: Bad character '/' in node name
> Warning (avoid_unnecessary_addr_size): /bmc: unnecessary #address-cells/#=
size-cells without "ranges" or child "reg" property
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.2, thanks.

> ---
>  hw/ppc/pnv_bmc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
> index e5eb6e5a70da..dc5e918cb79e 100644
> --- a/hw/ppc/pnv_bmc.c
> +++ b/hw/ppc/pnv_bmc.c
> @@ -77,13 +77,10 @@ void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt)
>      const struct ipmi_sdr_compact *sdr;
>      uint16_t nextrec;
> =20
> -    offset =3D fdt_add_subnode(fdt, 0, "/bmc");
> +    offset =3D fdt_add_subnode(fdt, 0, "bmc");
>      _FDT(offset);
> =20
>      _FDT((fdt_setprop_string(fdt, offset, "name", "bmc")));
> -    _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0x1)));
> -    _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0x0)));
> -
>      offset =3D fdt_add_subnode(fdt, offset, "sensors");
>      _FDT(offset);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1s7toACgkQbDjKyiDZ
s5L06RAAvrjCD0rxbVRRoTisGN/HonURG8yqSwOgAjHvmAopZFoFJz6K3fL3XXSu
GQ2nn/9wgj5JAE2Z/fwpjC/yeawWX0rMPvpF4xfm2sl1GK87AvezARMdZXoE6tIe
kG8N+Tp06XA6UVVd8E/0mOry10n3D6JqO5mLtcUFR/+lqi2QhLbmusiI0UBT0wiZ
xRtMCtrbfLvnYZJe2eNkoPPSur/AnbEPQBQPt6UwsFcucr5dhA+DM2E797xT3bxM
NDeXo8ao9gQeUzLRBNg7B+9K0OyCKw+rbf1seAEI3CaAE9rdWvLW7tsjEMzn/p4I
LpeesYUGvSSFJm2/RnqkvNNUZXZIXTJjPw1qmGIh7YQZsNHDXX40VkbWpK0fT+YI
wb0vdZBvNHbBdV8xA4EwpPCSJIpXAzf45OFWZzLE4w4MagzZtojXNaTkj4vun5AC
gVMfGzZNzkiUZOtLj3GR0vBtXohM6iH/dRGiDXXxIMfmuQM4iyEKksnTcpeodpb+
5Rnyj75lXaNPq9f9xFdFBL9NEUTENQZthAjXvLllI4gLlSchUPO/cIcbX/+3BrOT
rLXP2z22iqUbOF5HQ6lXEqgt8qPmyq5IQrTfwH+mRHGm4Nsgt5MxQWw2PZgk2eEJ
8X+kyiNTsHdS7o+fkb8IN1l1tK7N0fdVv4c1kWEfz30itTQNAk8=
=9ybz
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--

