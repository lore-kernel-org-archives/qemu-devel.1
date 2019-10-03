Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09AEC47404
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A038021D81
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Mq6Mu3DU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A038021D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFrBr-0005aj-2y
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 22:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5M-00007Y-15
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5K-0000xQ-8X
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:19 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:38617)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFr5I-0000wB-8j; Wed, 02 Oct 2019 22:43:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kHP92jTMz9sN1; Thu,  3 Oct 2019 12:43:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570070589;
 bh=kuQo7v3meGGppIl4DcmZDigutTgIl6ckR6zxEjCHaPM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Mq6Mu3DUpqWQmpFxCOUhhTUIULocRZxwN19hlepiFfgqQsgb5kuxAmfWLrFUISm4z
 pkQDoku8z2r3pUHdnxTvz7gz99EfDo8Zuyt1Kd/G1z09LhlC1LC4na94/5cnIShlQL
 G8XfqvudpvilR9Z4x6rl+iE53UV0Tz5p4hrM1I28=
Date: Thu, 3 Oct 2019 11:50:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 03/25] ppc/pnv: Introduce a PNV_CHIP_CPU_FOREACH()
 helper
Message-ID: <20191003015017.GE11105@umbus.fritz.box>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Zljh9u/ceMLi+8mf"
Content-Disposition: inline
In-Reply-To: <20190918160645.25126-4-clg@kaod.org>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Zljh9u/ceMLi+8mf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 06:06:23PM +0200, C=E9dric Le Goater wrote:
> As there is now easy way to loop on the CPUs belonging to a chip, add
> a helper to filter out external CPUs.

This seems a somewhat odd way to go about it, given that the chip does
have a cores array and the cores then have a threads array.  What's
the difficulty with using that rather than looping through all vcpus
and filtering?

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/pnv_xive.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index ae449aa1119b..e1c15b6b5b71 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -392,15 +392,36 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8=
_t blk, uint32_t idx,
>      return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
>  }
> =20
> +static int cpu_pir(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    return env->spr_cb[SPR_PIR].default_value;
> +}
> +
> +static int cpu_chip_id(PowerPCCPU *cpu)
> +{
> +    int pir =3D cpu_pir(cpu);
> +    return (pir >> 8) & 0x7f;
> +}
> +
> +#define PNV_CHIP_CPU_FOREACH(chip, cs)                                  \
> +    CPU_FOREACH(cs)                                                     \
> +        if (chip->chip_id !=3D cpu_chip_id(POWERPC_CPU(cs))) {} else
> +
>  static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
>                                uint8_t nvt_blk, uint32_t nvt_idx,
>                                bool cam_ignore, uint8_t priority,
>                                uint32_t logic_serv, XiveTCTXMatch *match)
>  {
> +    PnvXive *xive =3D PNV_XIVE(xptr);
>      CPUState *cs;
>      int count =3D 0;
> =20
> -    CPU_FOREACH(cs) {
> +    /*
> +     * Loop on all CPUs of the machine and filter out the CPUs
> +     * belonging to another chip.
> +     */
> +    PNV_CHIP_CPU_FOREACH(xive->chip, cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>          XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
>          int ring;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Zljh9u/ceMLi+8mf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2VU9cACgkQbDjKyiDZ
s5KCJhAArH5y2NwFIj7D0wYGjIdkFW9LKjVg6AiKIjQwP4Dchjt0sSbuKBC1kd2k
oC7FyvpkUwBtr+lM58kvaAutPLIPGinmR9HbT5N1gPnQyURhPlbl8ug01pKlBUQN
Np5pecCGXVHkTveiPgW/rWrpLvoRKaNKCub8q4dWA02KkEwHJ00NY9hUyV0OJvvI
YdZO4v3j1U/2r07dLLCZp7JqmRwgnoWPCWQKlevuKUL8H74vdDXAiIVy+wHAThjX
IOq5wvBtjLWkpwQYhOad+sGkr9cmB0+M843W+c9LK8QXuf6vBn2SGdyAIlZDcdSD
odko1PA3SNnYAnXASSIodZDHta2ZeLrl8OBkCii668oUADU/YaIsAZhLEYRv+db0
JFIVTlsJGDQEg0VGPlrvSAWB1VIW19iN1ZjjgxtCHP7G0K2oS3vOVL4/d3PtVJCE
nMj9n5x75yw4RmNqvo239FfXqgWcUHAIXS9Z8Twa+EhViK5VXAAf8Bx6ZALoLNva
3cqGmIrTED/Ce+hbTIpRwpgE2mEXkzjyzZ+NuKOoaB/RMb20+09B3ZTuYSCqK7zF
W6/7tk0x/IVKBU5bkWOeOwRTXlecwQTeHl/mtTdDkTfFDiceNnjuDtOGOtvEviFk
1O9CDu2P9U1YJWPW581cBDPzhQhVmQlLL1KE0yzKxoyFHUsw/jE=
=IMPZ
-----END PGP SIGNATURE-----

--Zljh9u/ceMLi+8mf--

