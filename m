Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF1EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49D020714
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Tn5K2CNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49D020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyRcL-0007tL-Tl
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyRbD-0006HX-IT; Wed, 22 Jul 2020 23:08:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44947 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyRbA-0006TB-Rp; Wed, 22 Jul 2020 23:08:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BBy2v3xSFz9sRf; Thu, 23 Jul 2020 13:08:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595473719;
 bh=8gO8lrXm9Zs06bXFiLzN1vzF+m8bshGnphaA+b13KCA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Tn5K2CNJ5aUz8S411SpZaQbNzRgyxKuhLV+kQOmsTz5/4lM7ElYWXQnDfNSOIKLzq
 vJkjPiiBpD6QEud4HJ9fBRkr0h3hr6yNnqn5qmU3YHJgdmj4bZF4gzUWR7dOfSFYc8
 TdL/vK1EIDMIpqF08oOWYM6u1HN+uOJ0vQ3PHFC4=
Date: Thu, 23 Jul 2020 13:07:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 4/8] ppc/e500: Use start-powered-off CPUState property
Message-ID: <20200723030711.GO5513@umbus.fritz.box>
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200723025657.644724-5-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+wSiqF7c0ySQ2tNi"
Content-Disposition: inline
In-Reply-To: <20200723025657.644724-5-bauerman@linux.ibm.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 23:08:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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


--+wSiqF7c0ySQ2tNi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 11:56:53PM -0300, Thiago Jung Bauermann wrote:
> Instead of setting CPUState::halted to 1 in ppce500_cpu_reset_sec(), use
> the start-powered-off property which makes cpu_common_reset() initialize =
it
> to 1 in common code.
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

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

--+wSiqF7c0ySQ2tNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Y/t8ACgkQbDjKyiDZ
s5IrjxAAj8w1dlpy4ndOgDi84moUQXy+GpWtzsFjdyjozBcz3RxkW8RVZVDBQiG3
fz+IFQqf0BKgOiKX5gM6s69g0AFl3y632eq4aOViJZJHnEdsn/V2Prl50yKZHD14
MabdK7GjI6hv9ird5V6Gmv2mI+Yhfz9+9woz5S6y7ZTWWwx8LyynvLzFJR1D+3eF
5ETb8fBXri4jeFqfy1upW0miKJrn/BaKbx1f0Wk0RJ793AbhHgO9f/X5xRIb8sZG
9k2U1cLP6VClKQ0Y0zKq6kMyFikSiiC+Iyj9jgO2w+SOCFoSKD3U3T4ehum7n+d8
OY9Tt3JdUGQU/oa5HwJleON/da0hzEtGdjBR2M4Ozmzv4JLtKS1P0kgDd6c5U/00
kzIT2eS/mM7nG6E2WEgd78EswDdqwcrdZA/fNtJYkAf/ghrSpk+RolYAkikpLIiZ
9KXZwUBv99DelCl1rbFSKhidmgirzTQIh1WtkbTlXfXLAUKo2RLDj8513O8klxh4
yBnw2TmjQ0GJbc/nOOvDuqMT9VfsLmVxSdzBEIRbl9XgMX6aHxxOjVOH5J17JPIp
DNoaax7ybgEMFhBmPYdOD0ZmYCjK9WhROZzR4jowO8k79Am58eZo2IizzGvo6MiZ
WUZAJTghW5nDlBbCKsr68/QeVB45Hqn36MwkiKcDkklKJkUlr3c=
=Qpx7
-----END PGP SIGNATURE-----

--+wSiqF7c0ySQ2tNi--

