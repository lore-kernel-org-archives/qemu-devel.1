Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C951C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7CCC20723
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="b2WkPEO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CCC20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyRff-0004IH-7c
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyRbJ-0006Tm-9V; Wed, 22 Jul 2020 23:08:53 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53305 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyRbH-0006UQ-2t; Wed, 22 Jul 2020 23:08:52 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BBy2v6JQmz9sSn; Thu, 23 Jul 2020 13:08:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595473719;
 bh=/3q+qLEIXDksYPkpoztheGx/0Gg45dfxB5RFVCq5noQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=b2WkPEO1LNULVqHT6wDa/TavMhuFeeW0WS8QkGaa8/9zpRqt9SdnfWaXWpxAx29Rq
 7if1wosHvnqveofLaTmgN9Mlv4Xekf/SYb6dN2e1XC9K/OfU5J+ZaJmz9KsU2uEwx1
 exSITBfrw26TU/hmiKQJ8nxuvOvQksRJjnfM2NNY=
Date: Thu, 23 Jul 2020 13:07:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 5/8] mips/cps: Use start-powered-off CPUState property
Message-ID: <20200723030741.GP5513@umbus.fritz.box>
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200723025657.644724-6-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ccJhwVfaC+fHwTsl"
Content-Disposition: inline
In-Reply-To: <20200723025657.644724-6-bauerman@linux.ibm.com>
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


--ccJhwVfaC+fHwTsl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 11:56:54PM -0300, Thiago Jung Bauermann wrote:
> Instead of setting CPUState::halted to 1 in main_cpu_reset(), use the
> start-powered-off property which makes cpu_common_reset() initialize it
> to 1 in common code.
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mips/cps.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> NB: I was only able to test that this patch builds. I wasn't able to
> run it.
>=20
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 615e1a1ad2..d5b6c78019 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -52,9 +52,6 @@ static void main_cpu_reset(void *opaque)
>      CPUState *cs =3D CPU(cpu);
> =20
>      cpu_reset(cs);
> -
> -    /* All VPs are halted on reset. Leave powering up to CPC. */
> -    cs->halted =3D 1;
>  }
> =20
>  static bool cpu_mips_itu_supported(CPUMIPSState *env)
> @@ -89,6 +86,9 @@ static void mips_cps_realize(DeviceState *dev, Error **=
errp)
>              env->itc_tag =3D mips_itu_get_tag_region(&s->itu);
>              env->itu =3D &s->itu;
>          }
> +        /* All VPs are halted on reset. Leave powering up to CPC. */
> +        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
> +                                 &error_abort);
>          qemu_register_reset(main_cpu_reset, cpu);
>      }
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ccJhwVfaC+fHwTsl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Y/v0ACgkQbDjKyiDZ
s5K9uA//d+6joOJM6ETKu6e2feviuz0xobf0FwbR2LFgh2l3nDsAtYh5Ohq2rku2
KOTiMP7j3erjw0SHphbivaNqcQrN2i9M1lKm3qWgVG+gy1R8Qp4RdV5IzDCGXvDp
hiSsyPr31FU0LfUahU26kkBa4Mv6/HWlVpstWFLUyfk1JMZdqar2EdMkCY64vSE5
eloUY5GQryor52oXIfqBrt/Ik0lWqp2wL8py11oopRO6ATlegaRV9b1Ft6Wk98X4
leiHGKnXuEsmf5gSwcoYgTFYKWtgnGZiLB3wN0QYWz7whHThM9R1OETQGIEl/GWb
nTgnwn8VeP+M+f9bZFC0wUHE45IBwHNdi1/6Usl1Uk+T/lSaEmXt1IKGDIAAEjA7
2F/GePUBfFOkESmmPr6Dphzg4Uv7+Pz9y3k8cOVUJrqRO92xYJFqVfpQE3IWwZJF
NC8K8+fM8GwLV6BtiRpfrjbVxEA/JEkaoVF+w666Lz1lT/UKWpw0XImxz/+BBf4u
OwImdh/7zWMJpNA7C33yVBk/OIfql33sQu9ZLSyZ1RgxrxdRSmDV/X9Asew4Xcmy
yUTTUnzupvdZDwlcF7KJJuKGaIy2o7p2huKJI+7jLtxIjo/mD73KsuhXriQ1n5Lz
pUCp8GFNKZm2Zjh6Sn4mTNgnPmWiNaPsUO2C4TBk8u5CscQpSlc=
=fS7F
-----END PGP SIGNATURE-----

--ccJhwVfaC+fHwTsl--

