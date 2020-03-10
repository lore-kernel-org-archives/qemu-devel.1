Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDC4C10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64AD22146E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hm2Yxwgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AD22146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBT6F-0003tZ-GX
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 20:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jBT5Q-0003Ic-DA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jBT5O-0007qY-9p
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:49:31 -0400
Received: from ozlabs.org ([203.11.71.1]:51955)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jBT5L-0007fT-RA; Mon, 09 Mar 2020 20:49:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48bxLP6RD9z9sRR; Tue, 10 Mar 2020 11:49:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583801357;
 bh=mXEHP7fyO0qviHxf+lhT/0H7UgI+nrNvyFum/l6qIVI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hm2YxwgvDPfs0FVj/FKQ9A3M5+a/egeva4yPa19+f0iUGszPfvRP6gqYoJNUkQZ/g
 8oHfXR36bC/KGOdYNjUFWWCL86YADyzzSXVKLHsnTtj+li4B3eetTzPatyED9LegDb
 pgNMjJY5aYwlpGZcfNLtMRw63AbgCIcHhgH/xSA0=
Date: Tue, 10 Mar 2020 11:43:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 5/5] hw/core/loader: Provide rom_add_file_fixed() a
 'max_size' argument
Message-ID: <20200310004313.GC660117@umbus.fritz.box>
References: <20200309144353.26457-1-philmd@redhat.com>
 <20200309144353.26457-6-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <20200309144353.26457-6-philmd@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2020 at 03:43:53PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Let rom_add_file_fixed() call rom_add_file() with a 'max_size'
> argument, to avoid writing more than the available space for
> the ROMs.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

ppc parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/loader.h  | 4 ++--
>  hw/i386/x86.c        | 2 +-
>  hw/ppc/sam460ex.c    | 2 +-
>  hw/sparc64/niagara.c | 5 +++--
>  4 files changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 34ac630eb1..30ed80128e 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -292,8 +292,8 @@ int rom_copy(uint8_t *dest, hwaddr addr, size_t size);
>  void *rom_ptr(hwaddr addr, size_t size);
>  void hmp_info_roms(Monitor *mon, const QDict *qdict);
> =20
> -#define rom_add_file_fixed(_f, _a, _i) \
> -    rom_add_file(_f, NULL, _a, -1, _i, false, NULL, NULL)
> +#define rom_add_file_fixed(_f, _a, _ms, _i) \
> +    rom_add_file(_f, NULL, _a, _ms, _i, false, NULL, NULL)
>  #define rom_add_blob_fixed(_f, _b, _l, _a)      \
>      rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, NULL, true)
>  #define rom_add_file_mr(_f, _mr, _i)            \
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 7f38e6ba8b..bdac66206a 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -783,7 +783,7 @@ void x86_bios_rom_init(MemoryRegion *rom_memory, bool=
 isapc_ram_fw)
>      if (!isapc_ram_fw) {
>          memory_region_set_readonly(bios, true);
>      }
> -    ret =3D rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
> +    ret =3D rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), bios_s=
ize, -1);
>      if (ret !=3D 0) {
>      bios_error:
>          fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name=
);
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 898453cf30..5eab479ae5 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -127,7 +127,7 @@ static int sam460ex_load_uboot(void)
>                  " using default u-boot image");*/
>          rom_add_file_fixed(UBOOT_FILENAME,
>                             UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32=
),
> -                           -1);
> +                           UBOOT_SIZE, -1);
>      }
> =20
>      return 0;
> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index f58d008d3d..4dd9a77dcb 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -91,7 +91,7 @@ static void add_rom_or_fail(const char *file, const hwa=
ddr addr,
>      /* XXX remove qtest_enabled() check once firmware files are
>       * in the qemu tree
>       */
> -    if (!qtest_enabled() && rom_add_file_fixed(file, addr, -1)) {
> +    if (!qtest_enabled() && rom_add_file_fixed(file, addr, region_size, =
-1)) {
>          error_report("Unable to load a firmware for -M niagara");
>          exit(1);
>      }
> @@ -148,7 +148,8 @@ static void niagara_init(MachineState *machine)
>              memory_region_add_subregion(get_system_memory(),
>                                          NIAGARA_VDISK_BASE, &s->vdisk_ra=
m);
>              dinfo->is_default =3D 1;
> -            rom_add_file_fixed(blk_bs(blk)->filename, NIAGARA_VDISK_BASE=
, -1);
> +            rom_add_file_fixed(blk_bs(blk)->filename, NIAGARA_VDISK_BASE,
> +                               size, -1);
>          } else {
>              error_report("could not load ram disk '%s'",
>                           blk_bs(blk)->filename);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5m4qEACgkQbDjKyiDZ
s5IB1hAA3qgG/JFflyGt5RxbV5b9ygHa2duDU6hQqbZxje/aHiLJy/jYcxZEPzPu
qCV7JcvXUBMle5Aeqz8tGxPMKAo5A7F+mSSfroLKj65Evr7ASLFgHCdZwlfBHJ8E
2+1P03QQnL3xX2mBExzecQy3eQrMSFn5KHqYVP2fKyad9f2C+bQNFx6WrsEi0vPk
UemNnNsu7H/aK9JFT60c2RnacxAW3L9dynBWpt+YVfl+CG4D4yvqq5COAJjzh/N9
0IvKYK+OKNvZlXdcPQpaiQ4E9igrQ+VEeP63B4/8k7kVSAmhAyQDzp5WQA5y8vYo
tGhr49hGoSn4pUYgW7/fhJROd76JXK+QTl1bW2EQJ38uD1nA2cAy0xQeHcUtHHRO
oblcDoLtq0rxBeql9mvXWsh7SEsvbU8SWEN5f8N2yavNz4k2W3v49jnweEfp7Eae
H2LF3gNJxwOCIHg1SnL1Hfqqtqq+8128Nr3zog0Yi7zrRAjUe/KJfzH2FpDUEHef
fUzqyYqr4XDN0CPK54EvXw0gqIq7GrYSPXsJ+MPjLNXQQqlA3wVpLhUuuLv1BjBY
zySAcyYenVPeLSJxI2OiHfg0odWgQ1lYTPXbZJ8dMlxL2+MB9B5nNytZyCl3qw20
ZguW2H9C4D0nzYccstLZL5bRqSnVDQqKb13m9D14GOKIt+Snr3o=
=5+0L
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--

