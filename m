Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9715DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6237220657
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LBS807Hf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6237220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyReZ-0002Ys-Iz
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyRbJ-0006TN-3W; Wed, 22 Jul 2020 23:08:53 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36223 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyRbH-0006UO-0z; Wed, 22 Jul 2020 23:08:52 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BBy2w0Zv1z9sSd; Thu, 23 Jul 2020 13:08:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595473720;
 bh=7IPc2Q1fTaCeaM4LUpDehskEstA2XXUOp7aYej6dJSc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LBS807HfKJJsLUOK1BFWmk1dk3FoLyfXjaq8mBlGnVAHeAf3ieXxIYN2EskcM8Glb
 cpTTOiV5BkVVkma9X04Uo9uQrG4ISNqDIjRi5DaWlkeDVJLaXDwRAjzUa72/6d4U9D
 sElZF7m2ffp0jMiZ7CdMoLvRV7U/Ty+u3fqDY1kQ=
Date: Thu, 23 Jul 2020 13:08:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 7/8] sparc/sun4m: Use start-powered-off CPUState
 property
Message-ID: <20200723030822.GR5513@umbus.fritz.box>
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200723025657.644724-8-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2z7AKWNQ4hR/M4ga"
Content-Disposition: inline
In-Reply-To: <20200723025657.644724-8-bauerman@linux.ibm.com>
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


--2z7AKWNQ4hR/M4ga
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 11:56:56PM -0300, Thiago Jung Bauermann wrote:
> Instead of setting CPUState::halted to 1 in secondary_cpu_reset(), use the
> start-powered-off property which makes cpu_common_reset() initialize it
> to 1 in common code.
>=20
> This makes secondary_cpu_reset() unnecessary, so remove it.
>=20
> Also remove setting of cs->halted from cpu_devinit(), which seems out of
> place when compared to similar code in other architectures (e.g.,
> ppce500_init() in hw/ppc/e500.c).
>=20
> Suggested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/sparc/sun4m.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>=20
> NB: I was only able to test that this patch builds. I wasn't able to
> run it.
>=20
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index f1d92df781..fd74e516bb 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -218,15 +218,6 @@ static void dummy_cpu_set_irq(void *opaque, int irq,=
 int level)
>  {
>  }
> =20
> -static void secondary_cpu_reset(void *opaque)
> -{
> -    SPARCCPU *cpu =3D opaque;
> -    CPUState *cs =3D CPU(cpu);
> -
> -    cpu_reset(cs);
> -    cs->halted =3D 1;
> -}
> -
>  static void cpu_halt_signal(void *opaque, int irq, int level)
>  {
>      if (level && current_cpu) {
> @@ -810,7 +801,6 @@ static const TypeInfo ram_info =3D {
>  static void cpu_devinit(const char *cpu_type, unsigned int id,
>                          uint64_t prom_addr, qemu_irq **cpu_irqs)
>  {
> -    CPUState *cs;
>      SPARCCPU *cpu;
>      CPUSPARCState *env;
> =20
> @@ -818,11 +808,8 @@ static void cpu_devinit(const char *cpu_type, unsign=
ed int id,
>      env =3D &cpu->env;
> =20
>      cpu_sparc_set_id(env, id);
> -    if (id !=3D 0) {
> -        qemu_register_reset(secondary_cpu_reset, cpu);
> -        cs =3D CPU(cpu);
> -        cs->halted =3D 1;
> -    }
> +    object_property_set_bool(OBJECT(cpu), "start-powered-off", id !=3D 0,
> +                             &error_abort);
>      *cpu_irqs =3D qemu_allocate_irqs(cpu_set_irq, cpu, MAX_PILS);
>      env->prom_addr =3D prom_addr;
>  }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2z7AKWNQ4hR/M4ga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Y/yUACgkQbDjKyiDZ
s5JsVw//fEJWBKkb5iGCm0e/sLgbwcRm7nmw+o6Uthn5eMWXAYTk5hydgF13HlGC
6PjROV2N6PtgQlWwERcuJMZ0kdTnytbKzLKXWwk7A/PIUHDNjxzc9wlTQ70rRA9G
sDrKIGsDXJP7oQ2a9RixxHTcg/LRp1HfhZAZBHHdt9Zf0rW4JVJR9xjRJ/lH64rx
6lqBQCkLuSH1ZPCZikriNwD4/olq4KAT+UMECHSkWqiYNFAWB4b7s/o963+nX6xw
lPethsUMsqIU555LGnxNS1bKlif1/254o0aZ3LRcbU5fNmUdw9RqozIvubo7d026
xwaEDDSF/kk7M3LgF/O6R7j/g2qZXxHB+PFiV8qQh0PXtmsdy7xdaRkbTiTnZRz5
A38CMxqOcCwlK1JFSEe1P/lQCZVkHOf4rakw5IAiFTpvsRB/wTuruCNxYXzJCrg5
0np4FfQPnku6PSYuMLpyHyoZlBs2nUHTIBp2qu+9YdNt4u7kxLH6A8Ui+arNN0es
M22ZeO+aaEbb5pk/XKcaVulFlueTW6rQlywZdFERSdUr6Dk98aNFSRO2ke4bPIO8
9Dn1R6T8oskzlFww0iPOALx6qe+LQHd06PWI5Jqar9sFCcwgjIum3/BIChYV/eg5
VMeu4x5vVhhp23v1Yxg/pRYJ1DRFh1T/wowBj6gxUGZ0PAxmbUE=
=l61x
-----END PGP SIGNATURE-----

--2z7AKWNQ4hR/M4ga--

