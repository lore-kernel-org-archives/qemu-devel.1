Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E98C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E181B20657
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="izDzb1gD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E181B20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyReg-0002jA-7G
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyRbF-0006IB-3K; Wed, 22 Jul 2020 23:08:49 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:39971 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyRbB-0006TA-56; Wed, 22 Jul 2020 23:08:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BBy2v5bhVz9sRk; Thu, 23 Jul 2020 13:08:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595473719;
 bh=NSGEymlD5gk/g8XY4FPk2eLjlQXVwxFnFpnfdbXwPsk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=izDzb1gDnm5JJkgkhLtpfjm3OLioMgy+3A9pa3pg3ZG/SHKorBUxkeW3lD+kSvoYo
 un0gZQOVra8VBFBhvj+tQBhaDcgz8CtFHLnDigy9C/YI9nsLf5b9MfrnQzggB/vVcJ
 GFVLVQb+kGDhmvsxV7Fn4P/7Ghc0SHATHYOUCunw=
Date: Thu, 23 Jul 2020 13:08:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 6/8] sparc/sun4m: Remove main_cpu_reset()
Message-ID: <20200723030806.GQ5513@umbus.fritz.box>
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200723025657.644724-7-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XG0jWBK27HhJN4nS"
Content-Disposition: inline
In-Reply-To: <20200723025657.644724-7-bauerman@linux.ibm.com>
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


--XG0jWBK27HhJN4nS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 11:56:55PM -0300, Thiago Jung Bauermann wrote:
> We rely on cpu_common_reset() to set cs->halted to 0, so main_cpu_reset()
> is pointless.
>=20
> Suggested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Revieed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/sparc/sun4m.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>=20
> NB: I was only able to test that this patch builds. I wasn't able to
> run it.
>=20
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 9be930415f..f1d92df781 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -218,15 +218,6 @@ static void dummy_cpu_set_irq(void *opaque, int irq,=
 int level)
>  {
>  }
> =20
> -static void main_cpu_reset(void *opaque)
> -{
> -    SPARCCPU *cpu =3D opaque;
> -    CPUState *cs =3D CPU(cpu);
> -
> -    cpu_reset(cs);
> -    cs->halted =3D 0;
> -}
> -
>  static void secondary_cpu_reset(void *opaque)
>  {
>      SPARCCPU *cpu =3D opaque;
> @@ -827,9 +818,7 @@ static void cpu_devinit(const char *cpu_type, unsigne=
d int id,
>      env =3D &cpu->env;
> =20
>      cpu_sparc_set_id(env, id);
> -    if (id =3D=3D 0) {
> -        qemu_register_reset(main_cpu_reset, cpu);
> -    } else {
> +    if (id !=3D 0) {
>          qemu_register_reset(secondary_cpu_reset, cpu);
>          cs =3D CPU(cpu);
>          cs->halted =3D 1;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XG0jWBK27HhJN4nS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Y/xYACgkQbDjKyiDZ
s5LqkRAAtP6RrKQOrPdqCyervjeCAAFy40nwHcZaoo/OgYhZe7WGhhgCacb2e1iu
upPSAMaHOSx0KkQta4iPKu6s/tyZrCOfk9s4ISeSuDRw8G6SM7OIAKaMliubyz0i
rUGyGjGD+ZN0Pew+Uf/lCW5leWd4r18GSECwLUZHHNIOjiAPivqbR4U9DTG6DrNC
8k6jmVUL5SgP2GIWZy0YvmQjCpJWnsZaTShwIp/IrvNF0LhuaJvinQPDrn9n4bhT
ThGw+VJyHxuuX/XV4ifGUku1uzn7XF+k2dX4bjrdKAztP/w27Obr2JMOFaNiKMjk
+jXjmv2lzG8pZKll045uJMLK0b2GdOFCIG2etUrG0EoOBzuthA/bSH5Sk7F40a54
xvL/Zwwvb7raPtUpFDQ4APKzLDAPsjSOEo9U7Bf53Ee5OFEwH/jNKL+teXZrnLzO
qNnOsgH5oELJbjzruX2eW81RJCt+cPguUsUmsaPMwb7yoqliSyeqrzZ2tdJrQa5S
nrSKlTId6/8aDAxXuejHwRIeanLaULD3zZs9DkEAOzTncqtm4najtaMyQVXGZntZ
QEhf/XHGFXvgUzMRgq+3S6sA8Cn+iZG2KXdXhxbhrQwBc7/tlRe5eFMOSlJpl+go
iGhbFRvlS4UZ2RlAmt2iVUZQDtHKgC7AkHio0qI1eyrsRjx9Jh0=
=M1UU
-----END PGP SIGNATURE-----

--XG0jWBK27HhJN4nS--

