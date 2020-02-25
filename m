Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C887C35DEE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:25:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068E6218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EIS6g4wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068E6218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6O2I-0002TZ-5m
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 19:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j6O1S-0000mS-Dm
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j6O1R-0000MB-9F
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:24:26 -0500
Received: from ozlabs.org ([203.11.71.1]:45553)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j6O1M-0000Iq-0F; Mon, 24 Feb 2020 19:24:20 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48RKS01rmzz9sPK; Tue, 25 Feb 2020 11:24:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582590256;
 bh=QB8oFSFaYoTX8Rx05o4U8QAJPl+c6DRspslzdATSPv4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EIS6g4wc5HG9jscHdglTXT8XM8ciZTrxjmwHjIQwC3S8rIPIkvtw/7/JDCx1PwCZN
 t1Y7w21xw+l/VgvFp+QLpgRSqB35L24vmsQFBcUMrFFyD1vbTuzaVuvfSf1eax0ALd
 hbWnomDgyjHNHjpifw7rdWTPMkcKjrYMbszh1AaA=
Date: Tue, 25 Feb 2020 11:23:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH RESEND v2 11/32] hw/ppc: Use memory_region_init_rom()
 with read-only regions
Message-ID: <20200225002345.GC41629@umbus.fritz.box>
References: <20200224205533.23798-1-philmd@redhat.com>
 <20200224205533.23798-12-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
In-Reply-To: <20200224205533.23798-12-philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org, Magnus Damm <magnus.damm@gmail.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 09:55:12PM +0100, Philippe Mathieu-Daud=E9 wrote:
> This commit was produced with the Coccinelle script
> scripts/coccinelle/memory-region-housekeeping.cocci.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/mac_newworld.c | 3 +--
>  hw/ppc/mac_oldworld.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 464d012103..566413e479 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -156,13 +156,12 @@ static void ppc_core99_init(MachineState *machine)
>      memory_region_add_subregion(get_system_memory(), 0, ram);
> =20
>      /* allocate and load BIOS */
> -    memory_region_init_ram(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
> +    memory_region_init_rom(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
>                             &error_fatal);
> =20
>      if (bios_name =3D=3D NULL)
>          bios_name =3D PROM_FILENAME;
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> -    memory_region_set_readonly(bios, true);
>      memory_region_add_subregion(get_system_memory(), PROM_ADDR, bios);
> =20
>      /* Load OpenBIOS (ELF) */
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 7318d7e9b4..8b22ff60b8 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -132,13 +132,12 @@ static void ppc_heathrow_init(MachineState *machine)
>      memory_region_add_subregion(sysmem, 0, ram);
> =20
>      /* allocate and load BIOS */
> -    memory_region_init_ram(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
> +    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
>                             &error_fatal);
> =20
>      if (bios_name =3D=3D NULL)
>          bios_name =3D PROM_FILENAME;
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> -    memory_region_set_readonly(bios, true);
>      memory_region_add_subregion(sysmem, PROM_ADDR, bios);
> =20
>      /* Load OpenBIOS (ELF) */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5UaRAACgkQbDjKyiDZ
s5KqNRAAwHe0vYT9rKDx9BpcgQAO3s4kkrzffvgcGNe9AVt7B6T75Q+kf6bS+0oU
yhLP9NJFkwjH1hzbyLE0sNKQjWpUdguJh7KYlC248qV8UnozdFXpEp4vYo6ZzLev
6EF7LqLRS4gIR1t7SP9DMeRHUIY5NGTWmDJMU2WrmGT3/gEMZ3MWyVVlOSMr3lD8
butF2PhAdrRUZL5H/IiXcbLIgeCzDw24+WwI8MppW1llereWfRgXL++j6OZnG5mr
Xd1MsivbWZN1lRzORhhhY9eFLvmZk3B54gemMCuGPCX85iafqohFZQTkeq6QHeH0
dyBQ1KkgTHQJOZ8+o8V+zUIzDhOjiTFMZJ2w7z90BiNBt2wqvHYoUGTY9I9tqtdq
TWOoOWkWxElc+HMMEWAq6z9Zxp/QhuPzQ0LqQovmeAGwLwPsuWc1oBE2yhnPDvYP
d1PS8t9+RObBgT8qGFR5X20qpzQErRCU7Vh3exBLRcjjwcj73yJ2RNDaXuOgZfwv
cjyKY5xi3FtNLX/F6Wus4TbC0nddcKs4I/3i/MoSUrAXhw1hFxhuNZ0gHteI0EZf
21L1XBnMUzz1m43uaIyyJTCU4ppEY8+/dlV0h/bcpWP0JvP7+YmLd3Bv5KFlrGxz
c+NDW3O63gw9R7IB3QOYVSlQBIQrnqAjikQVt82hMWbQoh/yz7c=
=Ji33
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--

