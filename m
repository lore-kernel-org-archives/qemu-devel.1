Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3696C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EC8207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UdCDtxZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EC8207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyRcM-0007te-0o
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyRbD-0006HY-IU; Wed, 22 Jul 2020 23:08:47 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyRbB-0006T8-12; Wed, 22 Jul 2020 23:08:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BBy2v3Cymz9sQt; Thu, 23 Jul 2020 13:08:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595473719;
 bh=uwSl+GwHYfKDJff/le3cud8w1j8l6dZTEu3QU+04iyQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UdCDtxZhLNrZIGKVQL3oQdpafcuVVRfo4NsRo9i0ECAh1tkEF6GO/A+jQtg1dptaw
 g7CuZjnd70ozyKINr4aCfIbndHi4PNHZIxFkDiuNDdHzcTywgI2kVs4VjxArIIAyhr
 59cv/sotWYO1O2I2NijyUQZnLVvrJQU/kqAIGc1k=
Date: Thu, 23 Jul 2020 13:06:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 2/8] target/arm: Move setting of CPU halted state to
 generic code
Message-ID: <20200723030625.GM5513@umbus.fritz.box>
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200723025657.644724-3-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="egxrhndXibJAPJ54"
Content-Disposition: inline
In-Reply-To: <20200723025657.644724-3-bauerman@linux.ibm.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--egxrhndXibJAPJ54
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 11:56:51PM -0300, Thiago Jung Bauermann wrote:
> This change is in a separate patch because it's not so obvious that it
> won't cause a regression.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/core/cpu.c    | 2 +-
>  target/arm/cpu.c | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>=20
> NB: I wasn't able to run this patch on an ARM machine. I did run it on
> a ppc64le pseries KVM guest.
>=20
> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> index 594441a150..71bb7859f1 100644
> --- a/hw/core/cpu.c
> +++ b/hw/core/cpu.c
> @@ -258,7 +258,7 @@ static void cpu_common_reset(DeviceState *dev)
>      }
> =20
>      cpu->interrupt_request =3D 0;
> -    cpu->halted =3D 0;
> +    cpu->halted =3D cpu->start_powered_off;
>      cpu->mem_io_pc =3D 0;
>      cpu->icount_extra =3D 0;
>      atomic_set(&cpu->icount_decr_ptr->u32, 0);
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index ec65c7653f..b6c65e4df6 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -175,7 +175,6 @@ static void arm_cpu_reset(DeviceState *dev)
>      env->vfp.xregs[ARM_VFP_MVFR2] =3D cpu->isar.mvfr2;
> =20
>      cpu->power_state =3D s->start_powered_off ? PSCI_OFF : PSCI_ON;
> -    s->halted =3D s->start_powered_off;
> =20
>      if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
>          env->iwmmxt.cregs[ARM_IWMMXT_wCID] =3D 0x69051000 | 'Q';
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--egxrhndXibJAPJ54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Y/rEACgkQbDjKyiDZ
s5IIsA//eOFnOoHl1OZXOiItrQwlda93YeDHi/KpkGzKa3XXoeklYuNsHpaOLkzZ
0Sw9Vem2BvsLTkcVfRFkNwSBX6sk2XGkM2d54NUgJO83q2UM40GPl2gqIDqxGUuJ
9luaHBseZzwUJi7D4IHsWuzaMbPJP2iT1QSgAGYXwt9PdDCT+foOph6QEuwLSXHo
nMI9llrpyRUr3SRyohYqRRm2eN8KoN9h2XAN5kEa9jELFOIN3DZdYRlp08lstHiY
ZBbjHal2GNJeWaqXyO6sN6sC0epTL0/LF6cRFA7s1+PqzYQVKCrRq+YZ/2Mvk+CN
jbvtlHN/vLDRDmPYinhYrHGtcj2leyPMYf8eYG1ghTt2CpXmzw1hG443lw98KtMz
EVtRxmnP/E9ln3GX6ZbSOOdUOFNyj/o6GoPKf6ZTIY12sGP6VxGTrnOq83vYp+FN
IzvOXbaagxJCNhR1SbSCBE3N0ifW9ayqWQcXDgJXNK2qqRiXbgi4qQwuOsg4T1vk
iPbaW+YPBveXkw1ASMnyjZ90GXU4DJHf0ISUvm6rGunp7znDB/bBYbOBWc3WVbJZ
iDmZ85ECoeqLRPs+XVaZJJCf+Tf2/qqfXy7x1GRkli73ndm2TyKZ7SyU7/LArO6K
ZcTk8oGZ8WMHEbnoSH4vowIbgz69+PHKHYWjq1+TWIen/8OEgkI=
=SfHI
-----END PGP SIGNATURE-----

--egxrhndXibJAPJ54--

