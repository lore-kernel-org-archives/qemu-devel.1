Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D8BC04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 02:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CB72182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 02:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="l6ulGiU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CB72182B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35845 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOvl7-0001cp-Ty
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 22:59:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOvjK-0000Un-Er
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOvjJ-0001AJ-Ac
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:57:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56291 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOvjH-00015x-CU; Thu, 09 May 2019 22:57:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 450ZdM2T1Zz9sNq; Fri, 10 May 2019 12:57:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557457063;
	bh=JMjV6FjoI7KqIh+84RB+yrE5kSTPePKdJe9czfYbvAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6ulGiU3FgQyOwPFpAjvTIO/JEwWCP0e/3myP5qD7rUI50m9fjr/p+eEDTvD6eyg9
	UmBF9dxa4kyQlW9IvTz3n91jKz/TSKEHLA/359SLlTo/tfmF8NGUTT7+lw+nIMaSVx
	lzF6NzDMEOUVsh6rk2wz/0m1NWuEXeK95ixl+OHc=
Date: Fri, 10 May 2019 12:01:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: sathnaga@linux.vnet.ibm.com
Message-ID: <20190510020143.GA7073@umbus.fritz.box>
References: <20190509080750.21999-1-sathnaga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="va9XEZk9/dJ5GUjX"
Content-Disposition: inline
In-Reply-To: <20190509080750.21999-1-sathnaga@linux.vnet.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] Fix typo on "info pic" monitor cmd output
 for xive
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--va9XEZk9/dJ5GUjX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 01:37:50PM +0530, sathnaga@linux.vnet.ibm.com wrote:
> From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
>=20
> Instead of LISN i.e "Logical Interrupt Source Number" as per
> Xive PAPR document "info pic" prints as LSIN, let's fix it.
>=20
> Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Applied to ppc-for-4.1, thanks.

> ---
>  hw/intc/spapr_xive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 7faf03b1fb..df3c879826 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -141,7 +141,7 @@ void spapr_xive_pic_print_info(SpaprXive *xive, Monit=
or *mon)
>      XiveSource *xsrc =3D &xive->source;
>      int i;
> =20
> -    monitor_printf(mon, "  LSIN         PQ    EISN     CPU/PRIO EQ\n");
> +    monitor_printf(mon, "  LISN         PQ    EISN     CPU/PRIO EQ\n");
> =20
>      for (i =3D 0; i < xive->nr_irqs; i++) {
>          uint8_t pq =3D xive_source_esb_get(xsrc, i);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--va9XEZk9/dJ5GUjX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzU24cACgkQbDjKyiDZ
s5L8Sw//bPx4JlJ2QRMnBBUnWTeJb0CQWRR1XxsbBt6+HUGGEhy7ca2zayGS2oK2
bSmi8KYkTMbo1YS/6Gnj3HU2DlJIq3XIrjhyzmjYfT8K5+c77hCZSM2zv30KIBMP
jLa0BYevzOX7pbu5W1+ALpZGBsi0K+iTBPrxquLUkMGhLwSe1jRLDyBEB01Dt3jg
dgpkObsrpz+Q+gtB/AEz+8LYMJ3uSOWoAO2hF7oJT+k4TjWCByBnqIDJ3IoxTwFB
IHGD/L/wDZBRq/nTqpx12nxPdnN8Qzp/ZSf6CweTTJU6KC4044kkejG3BMgj6jrl
mUWIIvJO9Y6AoOXcS52m7bWTto1juqkqeyeLYZuDMP+yKkQYBobzgoWwW/S0o6cm
2YN7V/8yqPnlyHary8Sn2viM4kN0Cess8gh5+O5r6Q7W68ig2/w+v4fNWAan9jS9
mByh+J+w7RpwpN71Nuka29Op7zq0l39g/qHwlLs07v6YB4pj8XhLdXBUC+HoIXXY
/uVBUp1mZtBQy70ZUwCM4I9PRbmhPKm2yj5IEaJxBU9RueSid0LiwuJEqzLDWLUa
anCS9xbeWkxUxib5pa6nxucMS6Rn8Zz17LekKJCX8YEFcuqgH7OBDjKr5Xpp+t6B
sh+8um8975dc8w/HPQABsGpynOd3atptfUigmlHYG5nFa3v1jWY=
=Ckat
-----END PGP SIGNATURE-----

--va9XEZk9/dJ5GUjX--

