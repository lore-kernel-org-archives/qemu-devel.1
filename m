Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792E9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 02:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4206C207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 02:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="N5fE3UdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4206C207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joHLK-0005Ci-E0
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 22:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joHKY-0004NW-3k
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 22:09:34 -0400
Received: from ozlabs.org ([203.11.71.1]:39369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joHKU-0004D5-Am
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 22:09:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49sk3N47Vsz9sRf; Thu, 25 Jun 2020 12:09:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593050960;
 bh=wLxRiOlJfHpZrw5cRoWmPvZAEqa0wW8enf0YYsUhtZ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N5fE3UdKcqvtysVRPqfAYRAPLqY9OMtZ5MELpu9GwVTPAtEXpYKi1BvzEU6DKjx3t
 M2287qr6ZF9VfTMPfIK6RY96hKga8I3AOicHG5kZ+0EKuRhAXBdj/rfOx0NRiALAry
 lt4n6zNqU5WDxmN7QOL2noUS0TI7OFjQWBTEYO6Y=
Date: Thu, 25 Jun 2020 11:41:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v2 6/9] spapr_pci: add spapr msi read method
Message-ID: <20200625014125.GC69292@umbus.fritz.box>
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-7-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <20200624185523.762240-7-ppandit@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 22:09:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 12:25:20AM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> Add spapr msi mmio read method to avoid NULL pointer dereference
> issue.
>=20
> Reported-by: Lei Sun <slei.casper@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr_pci.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 329002ac04..7033352834 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -52,6 +52,7 @@
>  #include "sysemu/kvm.h"
>  #include "sysemu/hostmem.h"
>  #include "sysemu/numa.h"
> +#include "qemu/log.h"
> =20
>  /* Copied from the kernel arch/powerpc/platforms/pseries/msi.c */
>  #define RTAS_QUERY_FN           0
> @@ -738,6 +739,12 @@ static PCIINTxRoute spapr_route_intx_pin_to_irq(void=
 *opaque, int pin)
>      return route;
>  }
> =20
> +static uint64_t spapr_msi_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
> +    return 0;
> +}
> +
>  /*
>   * MSI/MSIX memory region implementation.
>   * The handler handles both MSI and MSIX.
> @@ -755,8 +762,10 @@ static void spapr_msi_write(void *opaque, hwaddr add=
r,
>  }
> =20
>  static const MemoryRegionOps spapr_msi_ops =3D {
> -    /* There is no .read as the read result is undefined by PCI spec */
> -    .read =3D NULL,
> +    /* .read result is undefined by PCI spec
> +     * define .read method to avoid assert failure in memory_region_init=
_io
> +     */
> +    .read =3D spapr_msi_read,
>      .write =3D spapr_msi_write,
>      .endianness =3D DEVICE_LITTLE_ENDIAN
>  };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl70AMUACgkQbDjKyiDZ
s5KbKw//Z9fOAZRi7OvyHmPebS+3Ymlzc8/s1LfIrkUGXNLGFdtZtwDF+fPOYDLq
DuF4SRsp/MJiOKKLRycwOB7MI7Euq3LYgvis4vnUDb2cdWB4JS9CnXrkyQZiMCWv
Xn5nUSJh4l+LkOAe4lCzXAquScuRPoczwlonBH19AFqIXrI44dI03wor1BxqOdE1
NuSN+78sNy0i+Cxn7ZIgYk5XnWSGAsNPsjPNPIEeu/VBeY70NNT/YcGuv1pWmm0z
pfuM6lqSgTq1OccZY1I22G8wNAGheovGQSDTdbLk5sW7IhIDly67z+hY1bgJRt4R
vb2N2V8D/YIISOQuHOkohf5ZIrCUdd/TI7/mVetHF8o4gj4mHh1UhzoWHUmiUaSJ
/pVoOrP+hGJnj9XefjCx+9UBRvl1/WZ1GyOVQLsM/sNPHcxqBuv6sNtV5Fj8vWzA
ZUC4sE3rH29JgWlcVlolfZG13Afl/falm5NPD7B9Cn8ylXXSDnaulkRXNAb42h6G
Oc2gu+YBzkETIoI3L0249qfSMdhQPMUBuT45nsjPl3L5ejZ1jsKoEVc14csxS3E+
O7+geOJ81/AvSWRdff40iPg44PmYEY3loVyOz9Kf4OAuJUkJ+Zc6Ey/t1m49dGLo
aCtSa/Zh1xsYmP519SIIwDJA3b62ae713NE1U7fxL5QbnDtHc18=
=zgSG
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--

