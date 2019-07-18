Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B424C76195
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:01:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D55F2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hLBaYN+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D55F2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnzTY-0008Q6-UV
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 02:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41703)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnzSt-0006oe-BB
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnzSs-0004DY-0x
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:00:27 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:49385)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnzSr-0004BG-9x; Thu, 18 Jul 2019 02:00:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45q3QB1syyz9sND; Thu, 18 Jul 2019 16:00:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563429618;
 bh=eQg8NoMt1hjHmOdm1V0w9noulGR5SutDqZOhREZICbk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hLBaYN+MoHPSItiFJPkL5zyxRfvTBNnH4b0rAn3lUTL+VYIB/rFiutMwWsR+c2MOd
 tJX5HetlvGFLUF9KKos9TEXAvAZ7f8aXyK/ILvWFJBj+5Pv94tr2KaIbCauareCN/I
 GwzPMagU5nWVBqLlvEheUQy1rSmWO68FrEBVeDQA=
Date: Thu, 18 Jul 2019 14:19:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190718041919.GF8468@umbus.fritz.box>
References: <156335150620.82682.9535735857478533420.stgit@lep8c.aus.stglabs.ibm.com>
 <156335156198.82682.8756968724044750843.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Content-Disposition: inline
In-Reply-To: <156335156198.82682.8756968724044750843.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v2 1/4] ppc: fix memory leak in
 spapr_caps_add_properties
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 03:19:43AM -0500, Shivaprasad G Bhat wrote:
> Free the capability name string after setting
> the capability.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Applied to ppc-for-4.2, thanks.

> ---
>  hw/ppc/spapr_caps.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index bbb001f84a..0263c78d69 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -778,7 +778,7 @@ void spapr_caps_add_properties(SpaprMachineClass *smc=
, Error **errp)
> =20
>      for (i =3D 0; i < ARRAY_SIZE(capability_table); i++) {
>          SpaprCapabilityInfo *cap =3D &capability_table[i];
> -        const char *name =3D g_strdup_printf("cap-%s", cap->name);
> +        char *name =3D g_strdup_printf("cap-%s", cap->name);
>          char *desc;
> =20
>          object_class_property_add(klass, name, cap->type,
> @@ -786,11 +786,13 @@ void spapr_caps_add_properties(SpaprMachineClass *s=
mc, Error **errp)
>                                    NULL, cap, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
> +            g_free(name);
>              return;
>          }
> =20
>          desc =3D g_strdup_printf("%s", cap->description);
>          object_class_property_set_description(klass, name, desc, &local_=
err);
> +        g_free(name);
>          g_free(desc);
>          if (local_err) {
>              error_propagate(errp, local_err);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0v80QACgkQbDjKyiDZ
s5ILYBAAyq24dPw/hQ1rCaMTo7dNGOY2iHAwzBVLrXGvlM5Xe9UCUwAVmQT2LUZp
JDPZ1U3WZUf9E2oiAltQpJNj/OtsA+ehii9Nh1/2eeKZRXROAiYYZpprLnARq5cY
JFqoJIAeWkQuXTyQdHm+D9CSFhjHju4pcdhb6jDA8oXDEYoXchDpifX98/zT/Irn
Ob2ncCSy08nlKMJavVG6nsMo/HJXXbSa2hXENKrV6I/A/t2UFKag9Q+F96539m4k
t2gIhVv1s/rt4gfh80ebZjBRhgFpOou3kHpvOPCI4XeME5Y8bkpUOmJLfMPlED2P
vBV+EVYRlgJNiu+BOEoYzsu/5qhA7QkC8pKyk3Ko8DuC5sXP4qsyoJuREJETwugE
l0Z4TpOOK81Nzqs9asNniGdbaha/X7zNLH3LH8tY+U/e8i/kaBnBHFliPQ+lxCQy
ReW72jE987hoE9cXHor5RmNenbuobIau/rRKF4knvIqwvJ6L6PZe4WlUCwg7J8dY
fEtuyQFr9lkp0PODJS0bCPhhQYx9B8S2oVL7ElstfWxWNdiUD9A2uwa9iaO3mCTo
0wy7+RLnW5cafknCqu0l2aGHr62oFHb/LhnDaY4N4lpUumPgrEbkBW1kZ4gr3GNa
cnLbWYAKqpGrvAG2nIifs0k7lxasiEos5YQHPmHUZ9E0fTvpEIc=
=dzl2
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--

