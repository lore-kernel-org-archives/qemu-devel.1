Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922EFC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 05:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E1120665
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 05:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AOCNtYtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E1120665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZq1j-000729-8i
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 00:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iZpzc-0005Qo-2N
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 00:36:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iZpza-0000Jp-Mn
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 00:35:59 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57369 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iZpzZ-0000D3-Iv; Wed, 27 Nov 2019 00:35:58 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47N8d234f9z9sSs; Wed, 27 Nov 2019 16:35:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574832950;
 bh=t+UtBKDA7V/ts0lXfcnRVjaMEXqVS69VxzKEtjudPr8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AOCNtYtDdhc7pVuIGUCz79V526jR1hnOksm1k4o3OOmdLIPJg4kVJK9ckfgiFpROC
 RNG2jVkr8YtEgAlJxtM7nBizwtZm7ygjRTACMW/MwQ+PsOnVtVIMFNlj1OeEZhBUDA
 Xhw4GGu33X3uFyBjalQtVG0O2sQ4l6/MFMmj4OA8=
Date: Wed, 27 Nov 2019 16:03:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v6 07/20] ppc/pnv: Fix TIMA indirect access
Message-ID: <20191127050358.GP5582@umbus.fritz.box>
References: <20191125065820.927-1-clg@kaod.org>
 <20191125065820.927-8-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/rpNrW1QPITZETc9"
Content-Disposition: inline
In-Reply-To: <20191125065820.927-8-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/rpNrW1QPITZETc9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2019 at 07:58:07AM +0100, C=E9dric Le Goater wrote:
> When the TIMA of a CPU needs to be accessed from the indirect page,
> the thread id of the target CPU is first stored in the PC_TCTXT_INDIR0
> register. This thread id is relative to the chip and not to the system.
>=20
> Introduce a helper routine to look for a CPU of a given PIR and fix
> pnv_xive_get_indirect_tctx() to scan only the threads of the local
> chip and not the whole machine.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.0.

> ---
>  include/hw/ppc/pnv.h |  2 ++
>  hw/intc/pnv_xive.c   | 13 +++++++------
>  hw/ppc/pnv.c         | 17 +++++++++++++++++
>  3 files changed, 26 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 12b0169a4010..a58cfea3f2fd 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -162,6 +162,8 @@ typedef struct PnvChipClass {
>  #define PNV_CHIP_INDEX(chip)                                    \
>      (((chip)->chip_id >> 2) * 2 + ((chip)->chip_id & 0x3))
> =20
> +PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t pir);
> +
>  #define TYPE_PNV_MACHINE       MACHINE_TYPE_NAME("powernv")
>  #define PNV_MACHINE(obj) \
>      OBJECT_CHECK(PnvMachineState, (obj), TYPE_PNV_MACHINE)
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index ec8349ee4a1f..b2ab2ccc91e7 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -1400,12 +1400,13 @@ static const MemoryRegionOps pnv_xive_ic_lsi_ops =
=3D {
>   */
> =20
>  /*
> - * When the TIMA is accessed from the indirect page, the thread id
> - * (PIR) has to be configured in the IC registers before. This is used
> - * for resets and for debug purpose also.
> + * When the TIMA is accessed from the indirect page, the thread id of
> + * the target CPU is configured in the PC_TCTXT_INDIR0 register before
> + * use. This is used for resets and for debug purpose also.
>   */
>  static XiveTCTX *pnv_xive_get_indirect_tctx(PnvXive *xive)
>  {
> +    PnvChip *chip =3D xive->chip;
>      uint64_t tctxt_indir =3D xive->regs[PC_TCTXT_INDIR0 >> 3];
>      PowerPCCPU *cpu =3D NULL;
>      int pir;
> @@ -1415,15 +1416,15 @@ static XiveTCTX *pnv_xive_get_indirect_tctx(PnvXi=
ve *xive)
>          return NULL;
>      }
> =20
> -    pir =3D GETFIELD(PC_TCTXT_INDIR_THRDID, tctxt_indir) & 0xff;
> -    cpu =3D ppc_get_vcpu_by_pir(pir);
> +    pir =3D (chip->chip_id << 8) | GETFIELD(PC_TCTXT_INDIR_THRDID, tctxt=
_indir);
> +    cpu =3D pnv_chip_find_cpu(chip, pir);
>      if (!cpu) {
>          xive_error(xive, "IC: invalid PIR %x for indirect access", pir);
>          return NULL;
>      }
> =20
>      /* Check that HW thread is XIVE enabled */
> -    if (!(xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(pir & 0x3f))) {
> +    if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
>          xive_error(xive, "IC: CPU %x is not enabled", pir);
>      }
> =20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index d899c83e5255..8f688f4efc5a 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1371,6 +1371,23 @@ static void pnv_chip_class_init(ObjectClass *klass=
, void *data)
>      dc->desc =3D "PowerNV Chip";
>  }
> =20
> +PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t pir)
> +{
> +    int i, j;
> +
> +    for (i =3D 0; i < chip->nr_cores; i++) {
> +        PnvCore *pc =3D chip->cores[i];
> +        CPUCore *cc =3D CPU_CORE(pc);
> +
> +        for (j =3D 0; j < cc->nr_threads; j++) {
> +            if (ppc_cpu_pir(pc->threads[j]) =3D=3D pir) {
> +                return pc->threads[j];
> +            }
> +        }
> +    }
> +    return NULL;
> +}
> +
>  static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
>  {
>      PnvMachineState *pnv =3D PNV_MACHINE(xi);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/rpNrW1QPITZETc9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3eA74ACgkQbDjKyiDZ
s5Lt1A//bzRA7y73j94cVLG+80asowCZ15SCKtC3mkIfA9OiyGQ5Vr2TVIZWDpHs
zh2Nk+Si4QiFLg3/OGKLawV/2EWuChMC+GBEbrydZMOQIsXTqYOHWU9X/vHsbIOc
BcPjEfT8jmEXhmxIt2LWAyCf14+hw6MlGzt/u1vRaordgZBlAXFrooV+KrFGuMGx
ahAnodN4FgqON5bLvlscFrW1nIko6P9FU0qhBSDA2faM4rCcPwO+bvgB12uyCc4c
L5smm0SBTpvF/EcxYIBd/jhYVd0eeF9Njp/6xWUfDITdJe7mYFZP0fZvQjoS+ISL
OquBlrzK56G1H6JZFZZr9SpiHyLIE05vIapzf+OnxYRvmMNx4zukUtijb/ChRQDB
seQY1ImTr63jWDO6uJnFW1Eg7YJ/nH5mYCPeyGW8znG83k5eh1oFEtOc6ik1bH1B
D82IjCI3+w28JGTurJ3PDSI5J93rlBjLzoW4LTsOYisM3t8Umy1Jw0iKESFVrWMz
eJIhW57dEVoyDeNDcsAjLJfqsC/CVPhIZGye812Drn1kqObsxbZrEJwTUzVNYDC2
/8OsN7hE1VFRzSLXBoHA5HipCZtOF7lxsubAtd/E7kBcLGOCk4etyXbv14CqwbM5
oA+Iurv6XHGP5a5iepvqNTOdXTcoxaioBbJg+/fLAEG8wi1s5lg=
=o24a
-----END PGP SIGNATURE-----

--/rpNrW1QPITZETc9--

