Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE73C433F8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 01:04:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6412086A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 01:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bBtJ7vdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6412086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyPer-0005fR-UN
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 21:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyPaw-0008RO-QM; Wed, 22 Jul 2020 21:00:22 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:36849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyPau-0007HH-Hk; Wed, 22 Jul 2020 21:00:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BBvBk4qCWz9sRR; Thu, 23 Jul 2020 11:00:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595466014;
 bh=Dj0Y0gkrxPHbTK/MI/TwCv7ZL7R9wEyOUsLsGzFq2Z4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bBtJ7vdyoRl3HDe/HBYdeIPU1tT0SpmAmthKh15FonsXjj03Yjd3C5+LH4Gep0c5j
 TWSD3GlK16FVF5aES+lEy3IZoS6smkDw9+K3C2Wf2nlkEpNzBMkk44hO3J9FIZ5tXi
 ZzE1/BuwmnEYWaS7MpZysIaHyUqzb/mt3Mu1hfyc=
Date: Thu, 23 Jul 2020 10:56:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v2 4/9] ppc/e500: Use start-powered-off CPUState property
Message-ID: <20200723005630.GI5513@umbus.fritz.box>
References: <20200722035016.469075-1-bauerman@linux.ibm.com>
 <20200722035016.469075-5-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4BlIp4fARb6QCoOq"
Content-Disposition: inline
In-Reply-To: <20200722035016.469075-5-bauerman@linux.ibm.com>
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
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4BlIp4fARb6QCoOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 12:50:11AM -0300, Thiago Jung Bauermann wrote:
> Instead of setting CPUState::halted to 1 in ppce500_cpu_reset_sec(), use
> the start-powered-off property which makes cpu_common_reset() initialize =
it
> to 1 in common code.
>=20
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/e500.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> NB: I was only able to test that this patch builds. I wasn't able to
> run it.
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index ab9884e315..dda71bc05d 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -704,9 +704,6 @@ static void ppce500_cpu_reset_sec(void *opaque)
> =20
>      cpu_reset(cs);
> =20
> -    /* Secondary CPU starts in halted state for now. Needs to change when
> -       implementing non-kernel boot. */
> -    cs->halted =3D 1;
>      cs->exception_index =3D EXCP_HLT;
>  }
> =20
> @@ -897,6 +894,13 @@ void ppce500_init(MachineState *machine)
>          } else {
>              /* Secondary CPUs */
>              qemu_register_reset(ppce500_cpu_reset_sec, cpu);
> +
> +            /*
> +             * Secondary CPU starts in halted state for now. Needs to ch=
ange
> +             * when implementing non-kernel boot.
> +             */
> +            object_property_set_bool(OBJECT(cs), "start-powered-off", tr=
ue,
> +                                     &error_abort);
>          }
>      }
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4BlIp4fARb6QCoOq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Y4D0ACgkQbDjKyiDZ
s5Lf5w/+PoQjOoiGcvCl8nMUJvCDIB2G8Ft0xGjbAxMJf3IYkQaLAWiczhujLem7
GYIXtu8WpgjGZj9u+tMEKkfch9L9OtLbmpvRXXxrcBovhXu8YQPoMcjePwbJijVd
3fxHWC6g+Dc5GUJD3ugqHQP/ntpLjr5+vZ43I6NwOtuL71INn5R5jdHhP36zrCYq
xQQnRQT3Sg+hoD/9kkffP1qCXm1siw64RwsELLbKCVYbLyI85ZUQJqS3nxiuXlDx
vp8gMX3NLjDevvz4wkPMOp9xq68CN1sosiQXSzenLNND2f1lx0iC0/RM8WNIvssA
DitHjO6UJMlqrwHg423ko1G+74VKy7r/3rC91scg0ldXKjceABIGz7RhHvaImLbH
ar5PG4uTgN6HxjVUK97dgjcFflvfn055jKAoOWOhfJZDtfiSp+JWf79JxQzf1Wt3
iQVs6NGBxkANwhMVu7ztzJBA3NzoCvpa2fJ0xyoBW49BvNFQqNCGZ9CXeEsD5sny
r8CQGOhSUYuGs8bmVkQmGEyqRcbDwUPXotF2tUv1iAGZ7NENJsiR+cWaPVX3qxq7
Iu4hPpIXeMSxvnjIC393yTtzRkDA3wI3d0gG6X2iXFU1qAS3IfAWz+cRAw2ZPyI6
1/PTAvo9RRKO6T4CPJX2ZBg6hI9DlSXWUjsmGulppBQbTDvxK8g=
=J82A
-----END PGP SIGNATURE-----

--4BlIp4fARb6QCoOq--

