Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8182DC4CEC4
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 23:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459F520678
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 23:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TlkCXv35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459F520678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9e9h-0006Db-Fv
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 19:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i9e8r-0005lJ-WB
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 19:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i9e8q-0008Id-Jd
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 19:41:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58057 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i9e8p-0008GR-FC; Sun, 15 Sep 2019 19:41:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Wm9201jdz9sNx; Mon, 16 Sep 2019 09:41:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568590870;
 bh=zltnrM80upxAW/h5AZAqld/X6iIGiXNs492AbwheTbc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TlkCXv35Sh3KEF18+DX3u86DhLA+DSSpSff28vw9qt5/m2wzVNvzRXHEmLN5AHO6C
 MR8x/xICFUakIfFN3dZAH7fHg9Nk+LIvU3VD+7OUwJUhn8uEpb4knGZqTgV+mfHfc1
 uhqVOOqen0Vow6sPBLVhq2axi0uisHn2WE5uS73w=
Date: Sun, 15 Sep 2019 19:42:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190915094242.GB2104@umbus.fritz.box>
References: <156829860985.2073005.5893493824873412773.stgit@bahia.tls.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <156829860985.2073005.5893493824873412773.stgit@bahia.tls.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] spapr: Report kvm_irqchip_in_kernel() in
 'info pic'
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2019 at 04:30:09PM +0200, Greg Kurz wrote:
65;5603;1c> Unless the machine was started with kernel-irqchip=3Don, we can=
not easily
> tell if we're actually using an in-kernel or an emulated irqchip. This
> information is important enough that it is worth printing it in 'info
> pic'.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/spapr.c |    4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 761f8214c312..348c007ffbd3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -81,6 +81,8 @@
>  #include "hw/mem/memory-device.h"
>  #include "hw/ppc/spapr_tpm_proxy.h"
> =20
> +#include "monitor/monitor.h"
> +
>  #include <libfdt.h>
> =20
>  /* SLOF memory layout:
> @@ -4360,6 +4362,8 @@ static void spapr_pic_print_info(InterruptStatsProv=
ider *obj,
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> =20
>      spapr->irq->print_info(spapr, mon);
> +    monitor_printf(mon, "irqchip: %s\n",
> +                   kvm_irqchip_in_kernel() ? "in-kernel" : "emulated");
>  }
> =20
>  int spapr_get_vcpu_id(PowerPCCPU *cpu)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1+B5IACgkQbDjKyiDZ
s5JkxhAAla4CZmkj3UEk1fHH4X+n0/XeOTFFuxQ+dThPoiOEZXDWGHJ1/gX42mme
AAtiP/AjrxqIJIKMXW47128Y3r481/ObzJElmL3duFmDnyBMHY9xeAbaipwM0AzV
Wh3/II29bwvnTMlmbWmOqZjwmyv+gSlzsUsLPPLrO0JHt1KielOvNquY6xugO6n1
TRzO4wlAnnmyoduvciyKgyeW9Nk0UZMvvVDkRmhyakoUi0jkNMzva2i2xa1eWsHO
c0/v3v+2rAqj/0HYuQPMP6kVxDac1DyF4WMLdgC9R2bv3CrpUU7NIw06nA6ez58V
osYlZZP+4/2nI5yyAHq9gBns3ge50ToBPtRm3IIXu85CBlt4bqykbnIiSSpE+ktW
TLSIQHuL0pkA9lW5uey1/toRi5sGW3KFkHZt9o11TAbMb5HCG1oS0LkEgXzBY6oF
EIvOU6VmhSrIrvgW6k0eHDWb/zCu1JwHl7FST3IYbr5i+vLbqeSVePj4iJmDg00o
YzvcshK0GyENS7cg/fIWsj4rb708XRP0mCjUwCIAmlY5iD9gDRo9E3CSgRVBAkdB
KzRbGgwU4a5whyWrDdOh7cU8eaMcyBEmedHDFAPPxy8QQJJOJ7CpzavtyQbDrwTf
cTYszXUdu3SZ2j8KjbJ54wOcZP7MkQ88iBvFYh5BICk8bAIhX1E=
=Axbr
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--

