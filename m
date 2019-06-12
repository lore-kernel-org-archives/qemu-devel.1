Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78060C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 06:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43359206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 06:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lxV+gRLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43359206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56938 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hawUa-0005zH-2s
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 02:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33444)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hawRa-0003hn-Ie
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 02:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hawQW-0005Vj-7s
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 02:08:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46053 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hawQT-0005Ns-Aq; Wed, 12 Jun 2019 02:08:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45NxHZ1JfBz9s6w; Wed, 12 Jun 2019 16:07:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560319674;
 bh=8tbyM3CZ2wjq1HZ3ypE6PRKsiqwo6id2MfljA+zdnpo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lxV+gRLamB8hxGej7f6H7l2IyGUeYyX9LpeKf1UsLuD9iuAHneCJ0u82V57W7KTq9
 Ut5wktWBbNXHloW0dzS0NUVeVLDC5ev6wm1CA77C+V7BFPXBjNO6x0x2GY4GebH3tt
 G50KDHKkGaHLg5rY/WK2h7Co1KNokSozu7Sx0EIM=
Date: Wed, 12 Jun 2019 16:07:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190612060746.GB26378@umbus.fritz.box>
References: <20190612020723.96802-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20190612020723.96802-1-aik@ozlabs.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH qemu REPOST] spapr/rtas: Force big endian
 compile for rtas
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


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 12:07:23PM +1000, Alexey Kardashevskiy wrote:
> At the moment the rtas's Makefile uses generic QEMU rules which means
> that when QEMU is compiled on a little endian system, the spapr-rtas.bin
> is compiled as little endian too which is incorrect as it is always
> executed in big endian mode.
>=20
> This enforces -mbig by defining %.o:%.S rule as spapr-rtas.bin is
> a standalone guest binary which should not depend on QEMU flags anyway.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to ppc-for-4.1, thanks.

> ---
>  pc-bios/spapr-rtas/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/pc-bios/spapr-rtas/Makefile b/pc-bios/spapr-rtas/Makefile
> index f26dd428b79e..4b9bb1230658 100644
> --- a/pc-bios/spapr-rtas/Makefile
> +++ b/pc-bios/spapr-rtas/Makefile
> @@ -14,8 +14,11 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/spapr-rtas)
> =20
>  build-all: spapr-rtas.bin
> =20
> +%.o: %.S
> +	$(call quiet-command,$(CCAS) -mbig -c -o $@ $<,"CCAS","$(TARGET_DIR)$@")
> +
>  %.img: %.o
> -	$(call quiet-command,$(CC) -nostdlib -o $@ $<,"Building","$(TARGET_DIR)=
$@")
> +	$(call quiet-command,$(CC) -nostdlib -mbig -o $@ $<,"Building","$(TARGE=
T_DIR)$@")
> =20
>  %.bin: %.img
>  	$(call quiet-command,$(OBJCOPY) -O binary -j .text $< $@,"Building","$(=
TARGET_DIR)$@")

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0AlrIACgkQbDjKyiDZ
s5LyfQ/+Oz4ljwa/2f1CWc4mMHMgqyu6MUXkhY3JNrJQQt69PQhv6cs1xNNevhO8
Zw2OUnsOKI5rCHZhElOpxH3g2NyC/UAQWNwDCx3J9nmFWFMWT0NibIXsCvUr/DFi
Ym5+uhp4tKs69Jw8u/IMvjNwyxfXb5podlgcnCOagVJhY3ZFjMmYUNH5jatZaAgC
UQyAk9g5RQdThd+VIKJfQUP1sYn+oMpYpkJp1FXEfvM33OfQ82QuMOmmBPs1H4Kd
qrR3r2Wwz4pKsN+lrJA+RShY688gQ8KWFW5dFcFSO0HtUEIqsDPIkc4bG9tUGzmQ
METe58wgWD3UehSz/6vqD3JxLct6GG2j6sZsLmVxgmYEcbd15Sz24vuqlbGxr0Ws
oAnGOFYwyFDDtJdX8w7gUX47fTDODqsi4ckUlrS1O8/tzHMHPOV93dhuNdKs+4ci
8r3CY4aTJbw2NGA6/vFBQyOr67oZzsC2ZHjTqJKj9Z4ID3Rm5K0dnkyZ7GIBf59a
FJ9QfUASZJ3Ejb3jDVIYiBJo5Y/OIN+WB5DC+6liDYpuP2n6QpH6zdaGIDZhYUTy
Bgc5l+MeQzO53vx4kEUfCPB46zeeDVywNMqFTtIDwr7vHw8Yc6OdrvDlH5uLBA1Q
tyHOAszUZUtRiuc/P3DYx6pLo9xzhVPWcmhk1Cu91KeBnqCYlmg=
=dKZ2
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--

