Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ACAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE26222D2C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jNrKrLfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE26222D2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3YEX-0005aQ-7V
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 01:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k3YBC-0001Ch-34; Thu, 06 Aug 2020 01:11:02 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:54419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k3YB7-0001cq-JG; Thu, 06 Aug 2020 01:11:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BMc5N0TgZz9sTR; Thu,  6 Aug 2020 15:10:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1596690648;
 bh=JsDsI51HT4SqEg29zaHViwyxEl5MDXP+6OYyrRUK5U8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jNrKrLfJa8UkKpQTJSGobz1nxBX0MZqXBFVJ3RmhhT8fA2b4MXcFufslevDkVBQRA
 squM+y9LToErSvPkemCdtEP3zx3NW5NrENKEjPKbbOP6tmINuB/8/afzsK80buMK/O
 RM3/v6EnoA3SNK9iECPRilx/otlGZQI+lWsfP/3A=
Date: Thu, 6 Aug 2020 15:05:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH for-5.2 2/5] spapr/xive: Simplify kvmppc_xive_disconnect()
Message-ID: <20200806050554.GB100968@yekko.fritz.box>
References: <159664891296.638781.18417631893299150932.stgit@bahia.lan>
 <159664892990.638781.13517846040386267779.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <159664892990.638781.13517846040386267779.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2020 at 07:35:29PM +0200, Greg Kurz wrote:
> Since this function begins with:
>=20
>     /* The KVM XIVE device is not in use */
>     if (!xive || xive->fd =3D=3D -1) {
>         return;
>     }
>=20
> we obviously don't need to check xive->fd again.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2.

> ---
>  hw/intc/spapr_xive_kvm.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index d55ea4670e0e..893a1ee77e70 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -873,10 +873,8 @@ void kvmppc_xive_disconnect(SpaprInterruptController=
 *intc)
>       * and removed from the list of devices of the VM. The VCPU
>       * presenters are also detached from the device.
>       */
> -    if (xive->fd !=3D -1) {
> -        close(xive->fd);
> -        xive->fd =3D -1;
> -    }
> +    close(xive->fd);
> +    xive->fd =3D -1;
> =20
>      kvm_kernel_irqchip =3D false;
>      kvm_msi_via_irqfd_allowed =3D false;
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8rj7EACgkQbDjKyiDZ
s5LyaRAAzGeXQc82khP+S6Ta8ccI2jUSx7sRS//ZIV4Clj3ryKPk8t1FE3kDD6bN
0LUBFUu7IYQUs+nKVMKOsh98jDd0s+AXf/E+hj6R0f08bIw/4mTKB3vzp646imib
LunBQiMFRti1LQme4mIctELg+YXtIC/kxTEEmjlTyTacmXbGvdQro1xvmS2A1EMN
D5zbqFibaX//Mjl4uk92ghWzAhyCxspVADCNRR5giKu+hcasHM7Y9JqOcOUbHsyI
r4p8xdlKc1xLcG+B/zMAbvtLCxZnejoc0n/OZg4THuKnNyfiY/KQmQBWS6tza0bB
VwT6O49olesuTnMesrYHOV0kRHzAsp8z4FFAPP7ffYVgcYFAASc+ACW5twI25OIE
gylNjST/seGjL4WSqJzgHM7JOzCJ40PCvcWSZNwHjrRplSCW6HMAdyBYkoews+UK
6mRrq9Ze06Qe4ftbXMiHpiLxppRHmaFu6sgtBOaT9pAeEiykl3qsK33Mv6LpQ8/9
25COowFMUGRqDDz2FqF1573IEwAcuGJWRyy7n2Ti1Kl2ZOtujezGsVnOdmDooU8N
+warHMv1ChStrPkmsuZT/4EewRdGxXrFtL+iY83mS4LxdPUS1FyG+vF/FhZC6vv3
w7a06GUUPfS8Xy+roFoV2SPqDTFIcr5YM2zb2d6c6ia265LSbY0=
=rHij
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--

