Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FE8C35DEA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2515021927
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Jr1qKio+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2515021927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6O2R-0002lx-9V
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 19:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j6O1T-0000pJ-Ia
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j6O1S-0000MY-AU
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:24:27 -0500
Received: from ozlabs.org ([203.11.71.1]:33461)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j6O1M-0000Io-04; Mon, 24 Feb 2020 19:24:20 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48RKS02NSDz9sRQ; Tue, 25 Feb 2020 11:24:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582590256;
 bh=ijQfxbE3pJVAj9ZDO7QmVbTk0Y8moMotJj8/X4GVBco=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Jr1qKio+U6RLhGeYtW7DtFpKvvCEwow8u6i48ZpsBKIsaRFerfHcGCBP0n0MxuaaO
 pMqfNkEYlXNE6S/cclXCvObsPtBWPLTSa4/Zbsc+wkWfGSH7TFeXMrGu+MHeDWwyvo
 PsX3nNkzrJ5Vzs+PIF3eQcmN9hFOhLUID4OAHQRw=
Date: Tue, 25 Feb 2020 11:24:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH RESEND v2 17/32] hw/ppc/ppc405: Use
 memory_region_init_rom() with read-only regions
Message-ID: <20200225002403.GD41629@umbus.fritz.box>
References: <20200224205533.23798-1-philmd@redhat.com>
 <20200224205533.23798-18-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline
In-Reply-To: <20200224205533.23798-18-philmd@redhat.com>
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


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 09:55:18PM +0100, Philippe Mathieu-Daud=E9 wrote:
> The scripts/coccinelle/memory-region-housekeeping.cocci reported:
> * TODO [[view:./hw/ppc/ppc405_boards.c::face=3Dovl-face1::linb=3D195::col=
b=3D8::cole=3D30][potential use of memory_region_init_rom*() in  ./hw/ppc/p=
pc405_boards.c::195]]
> * TODO [[view:./hw/ppc/ppc405_boards.c::face=3Dovl-face1::linb=3D464::col=
b=3D8::cole=3D30][potential use of memory_region_init_rom*() in  ./hw/ppc/p=
pc405_boards.c::464]]
>=20
> We can indeed replace the memory_region_init_ram() and
> memory_region_set_readonly() calls by memory_region_init_rom().
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc405_boards.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 1f721feed6..5afe023253 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -192,7 +192,7 @@ static void ref405ep_init(MachineState *machine)
>  #endif
>      {
>          bios =3D g_new(MemoryRegion, 1);
> -        memory_region_init_ram(bios, NULL, "ef405ep.bios", BIOS_SIZE,
> +        memory_region_init_rom(bios, NULL, "ef405ep.bios", BIOS_SIZE,
>                                 &error_fatal);
> =20
>          if (bios_name =3D=3D NULL)
> @@ -216,7 +216,6 @@ static void ref405ep_init(MachineState *machine)
>              /* Avoid an uninitialized variable warning */
>              bios_size =3D -1;
>          }
> -        memory_region_set_readonly(bios, true);
>      }
>      /* Register FPGA */
>      ref405ep_fpga_init(sysmem, 0xF0300000);
> @@ -461,7 +460,7 @@ static void taihu_405ep_init(MachineState *machine)
>          if (bios_name =3D=3D NULL)
>              bios_name =3D BIOS_FILENAME;
>          bios =3D g_new(MemoryRegion, 1);
> -        memory_region_init_ram(bios, NULL, "taihu_405ep.bios", BIOS_SIZE,
> +        memory_region_init_rom(bios, NULL, "taihu_405ep.bios", BIOS_SIZE,
>                                 &error_fatal);
>          filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>          if (filename) {
> @@ -479,7 +478,6 @@ static void taihu_405ep_init(MachineState *machine)
>              error_report("Could not load PowerPC BIOS '%s'", bios_name);
>              exit(1);
>          }
> -        memory_region_set_readonly(bios, true);
>      }
>      /* Register Linux flash */
>      dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5UaSIACgkQbDjKyiDZ
s5Lb4w//S8uU0kRFHQ8nswAPuIt4XpXe35s7+rfp1Or54+lu13gbVo9vFk7ZpqtH
CernJi87n72H3oD0v9fi40j/TIjmgQ40kO9rht89HjpS3gPrzvA4ZH5VxhuPOT26
LFJ2Kb6uTivSMhkTYA+z7kg4zpT0bwhtEFdlaH7aOcF2AmP865aJyxXGfFYdfsnF
5y59BZ3ZXcyv94XHiWy/oeXneQ3aol/2/7T+E7rgGACy6JHkE0f3B5TV4iDLCd2P
mdlBgz1sk2DBbMZWDn/tjYRbRFfH2b3bAT0rrQVQfzUFqCmYWlChYDqIxhrysGhT
Fws+CYVTgwfihZd0T/4xMt4ScI1pPKGVq0QhVMWsEC04De+ed9KUwfk5fh5ODZvs
m8/U8jkBQ6N+5ou0UkELjEoRA3iPaXh+lGMMcZUmnMohA5bnKpkB6T7TXs0X7eEm
Fe74XCgAR4s1W4ytov1C+zempita4qHYrJJhV3lf7CqhPhoQZNm19iLSHAiodd4G
SvCt7hg50yKeGm0zgiyqQI1cAo9lDZG9bi+RK/dMEQCUkJV1pbKd01gXSz4AVXC7
VxXCxNsL9W/jTupO3fmxlwanfXjWG74BwKQ5K3R1U0TyM7R74Ueqkkp5KQ9RHzUX
zJjM/r2Xvml7f+iLU6Zxu2GQ0JWVF9WYp6Nav+cl2TrZrhy3MJg=
=8G+m
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--

