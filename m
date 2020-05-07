Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1200AC35280
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 23:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65CE20A8B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 23:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TsMDzzWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65CE20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWpx9-0006Aa-0Z
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 19:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWpwM-0004gO-3Z; Thu, 07 May 2020 19:28:30 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:33989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWpwK-0001Gv-Ca; Thu, 07 May 2020 19:28:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49J8ln5SK2z9sSW; Fri,  8 May 2020 09:28:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588894101;
 bh=XMkOuUYZbpnrJpeCHRFjBRXovMkcsHH+lIdDr3doUjE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TsMDzzWGj5SzAl+FudNOeFAiM6d1dSnFKBttH0YWWleZzea09GnFk6V/jfx6dtj7R
 WrC92K8K2vwPoqAlaT1pVEuHH53LkCKUd263lsfaqrII+uLoLss253QFHXUCYK5GNc
 /iH9wf0QtKxmdCgDjTmN1kCsQklpmCGwy6aWXWMQ=
Date: Thu, 7 May 2020 23:51:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] ppc/pnv: Fix NMI system reset SRR1 value
Message-ID: <20200507135154.GA2282@umbus.fritz.box>
References: <20200507114824.788942-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20200507114824.788942-1-npiggin@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2020 at 09:48:24PM +1000, Nicholas Piggin wrote:
> Commit a77fed5bd926 ("ppc/pnv: Add support for NMI interface") got the
> SRR1 setting wrong for sresets that hit outside of power-save states.
>=20
> Fix this, better documenting the source for the bit definitions.
>=20
> Fixes: a77fed5bd926 ("ppc/pnv: Add support for NMI interface") got the
> Cc: C=E9dric Le Goater <clg@kaod.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to ppc-for-5.1, thanks.
> ---
>=20
> Thanks to Cedric for pointing out concerns with a previous MCE patch
> that unearthed this as well. Linux does not actually care what these
> SRR1[42:45] bits look like for non-powersave sresets, but we should
> follow documented behaviour as far as possible.
>=20
>  hw/ppc/pnv.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index a3b7a8d0ff..1b4748ce6d 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1986,12 +1986,26 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, r=
un_on_cpu_data arg)
> =20
>      cpu_synchronize_state(cs);
>      ppc_cpu_do_system_reset(cs);
> -    /*
> -     * SRR1[42:45] is set to 0100 which the ISA defines as implementation
> -     * dependent. POWER processors use this for xscom triggered interrup=
ts,
> -     * which come from the BMC or NMI IPIs.
> -     */
> -    env->spr[SPR_SRR1] |=3D PPC_BIT(43);
> +    if (env->spr[SPR_SRR1] & PPC_BITMASK(46, 47)) {
> +        /*
> +	 * Power-save wakeups, as indicated by non-zero SRR1[46:47] put the
> +	 * wakeup reason in SRR1[42:45], system reset is indicated with 0b0100
> +	 * (PPC_BIT(43)).
> +	 */
> +        if (!(env->spr[SPR_SRR1] & PPC_BIT(43))) {
> +            warn_report("ppc_cpu_do_system_reset does not set system res=
et wakeup reason");
> +            env->spr[SPR_SRR1] |=3D PPC_BIT(43);
> +        }
> +    } else {
> +        /*
> +	 * For non-powersave system resets, SRR1[42:45] are defined to be
> +	 * implementation-dependent. The POWER9 User Manual specifies that
> +	 * an external (SCOM driven, which may come from a BMC nmi command or
> +	 * another CPU requesting a NMI IPI) system reset exception should be
> +	 * 0b0010 (PPC_BIT(44)).
> +         */
> +        env->spr[SPR_SRR1] |=3D PPC_BIT(44);
> +    }
>  }
> =20
>  static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl60EncACgkQbDjKyiDZ
s5JZ6RAAgvHVEZ5jPnKBTu9kLKvuCstTDaFtonVy91pCOyvM3Ztqw9FEFuZ1IUpi
RULLosoHxdqKQR99Do9LXKQgEdDdYF0PqIaO51Mmss1KIDb4aHRnHvy19NanhVij
lza27bvI9I11WOQQCjGeahkhwqxAyYmuO+KSwTOT5jv1GsCzIoIR8R0IcSEEZE3C
lleQ+diJ6r/yKd6+BPp2sTt+mfeQjOXcO0GePWjmkuPXb68+IaTXTAjPj6aiDb/U
0K1iK7mLkI2yYAjFfbDXiPfdRE1dtY1qzS4PScZQS/GwZr2wvFSluS7fgEJUqeAe
PdqH3CFEvICGYYPknmGsPn0EdUwNZp3wzC/rCTX0308VAQisiE41R+XAkgD7MW2p
W4owHLTRS3ReEYMXwBSrUqoqsSIwhlv3HufahOb+ZmYVHmvLqzf8CWsZNo5KzvdQ
tVam2CTnNYQRirBT3GjP8uSQT52uGt/j18b2GP6mbVIb+1S6w91H7jCA6NN7thMP
wqmQCXE7daO174LiRNnRvlpJaEy8ZsLdiumXN2RIVZz/LNolLZRia6cEU7xeuz50
nRMb/g2jWy/ifSctOSthZWJN5loZjyKtR/c6OM+qPb143CgMaahzJJ7OZVE6w4HH
nX5X2jmjTYLn+4HWLmY2lM9goAh5iR87E4+LIqTcs5+fZQmX7RA=
=GuLL
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

