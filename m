Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4142DC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 10:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089C0206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 10:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bOSjZXBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089C0206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34339 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGLFZ-0007jD-7t
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 06:23:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGLEb-0007K0-IN
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 06:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGLEa-0002T8-7C
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 06:22:37 -0400
Received: from ozlabs.org ([203.11.71.1]:34341)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hGLEX-0002OC-Ft; Tue, 16 Apr 2019 06:22:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44k1dT4Zz0z9s55; Tue, 16 Apr 2019 20:22:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1555410141;
	bh=ZC4ikY6v1vCpPs74DGf1N5kLv+td0xCuMtTELqC6xu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOSjZXBnw35SXalQZ4EFLjdC9r44Yl6lvc5r7lMWtnHoDkF5SDm+l4oVTv4zU02oR
	jp4nZF8k5EwIVM3lbgIQ8B3VPqDA0PjS8eh7d8NGWHzXcVSpj6lSdPEqHI5i9RAeFz
	ScvPHk5d0IyWp9ZmZZEFWrm9VU0BTY5zrJeqPTxA=
Date: Tue, 16 Apr 2019 14:13:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190416041334.GF32705@umbus.fritz.box>
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
	<1555334842-195718-3-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Content-Disposition: inline
In-Reply-To: <1555334842-195718-3-git-send-email-imammedo@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v1 2/5] ppc: rs6000_mc: drop usage of
 memory_region_allocate_system_memory()
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
Cc: qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
	Helge Deller <deller@gmx.de>, Cornelia Huck <cohuck@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
	=?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416041335.DXGHk1bncHR5TFmQRQetFwgJsej8F7nTR8tA5L70zAU@z>


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 03:27:19PM +0200, Igor Mammedov wrote:
> rs6000mc_realize() violates memory_region_allocate_system_memory() contra=
ct
> by calling it multiple times which could break -mem-path. Replace it with
> plain memory_region_init_ram() instead.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

LGTM, though I've no idea if the rs6000 machine even works at the moment.

> ---
>  hw/ppc/rs6000_mc.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
> index 45cb95e..ea174f1 100644
> --- a/hw/ppc/rs6000_mc.c
> +++ b/hw/ppc/rs6000_mc.c
> @@ -142,6 +142,7 @@ static void rs6000mc_realize(DeviceState *dev, Error =
**errp)
>      RS6000MCState *s =3D RS6000MC_DEVICE(dev);
>      int socket =3D 0;
>      unsigned int ram_size =3D s->ram_size / MiB;
> +    Error *local_err =3D NULL;
> =20
>      while (socket < 6) {
>          if (ram_size >=3D 64) {
> @@ -163,19 +164,21 @@ static void rs6000mc_realize(DeviceState *dev, Erro=
r **errp)
>          if (s->simm_size[socket]) {
>              char name[] =3D "simm.?";
>              name[5] =3D socket + '0';
> -            memory_region_allocate_system_memory(&s->simm[socket], OBJEC=
T(dev),
> -                                                 name,
> -                                                 s->simm_size[socket] * =
MiB);
> +            memory_region_init_ram(&s->simm[socket], OBJECT(dev), name,
> +                                   s->simm_size[socket] * MiB, &local_er=
r);
> +            if (local_err) {
> +                goto out;
> +            }
>              memory_region_add_subregion_overlap(get_system_memory(), 0,
>                                                  &s->simm[socket], socket=
);
>          }
>      }
>      if (ram_size) {
>          /* unable to push all requested RAM in SIMMs */
> -        error_setg(errp, "RAM size incompatible with this board. "
> +        error_setg(&local_err, "RAM size incompatible with this board. "
>                     "Try again with something else, like %" PRId64 " MB",
>                     s->ram_size / MiB - ram_size);
> -        return;
> +        goto out;
>      }
> =20
>      if (s->autoconfigure) {
> @@ -191,6 +194,8 @@ static void rs6000mc_realize(DeviceState *dev, Error =
**errp)
> =20
>      isa_register_portio_list(ISA_DEVICE(dev), &s->portio, 0x0,
>                               rs6000mc_port_list, s, "rs6000mc");
> +out:
> +    error_propagate(errp, local_err);
>  }
> =20
>  static const VMStateDescription vmstate_rs6000mc =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly1VmkACgkQbDjKyiDZ
s5K7/xAA45bvbxM5vuvGkSYQJjsBlEiuWh0mJt966ZhwcEUcGNb0n+HN4uatmJLm
YNHnUMlVSxWQPyTUzbfuqd7CGWR5qbBEesc8d5rHxwYsekKCy5Q2AEWioc2RqoDc
n8qIUKIthQMaa9h9uVDDejjPSSMR8A8NLHZmS6IWebWej+dLGBX1dBhd4lB25hxQ
Er48IFJYUon3loP395m9HtBt/1keuyG0x8rLqqKhvjwcuwA+6C2QBZCNId9ugUUD
JHk7K1DQ0wagucgelUdjWo2q+7RnWoR+hCtMfUXdF9AydgJLn57GM7CTokOp9amS
f1Z8lC/gOfQYTBhJmBoJQopFNYUgsZFmQpPcCBOjH7V/Inv65dXCvKCO686eBLCI
ypfde12IdZwx2NOKxnIa37zS4rXNnLv/Mt3xUhCR7OVo6CiVql3Fa/Mc9gV2wUR9
/BKXHg7GqZA/0aUE6c6WlyYhh14yLyiEzJ3kEY398pU5YR2dJfvaKjbdanA0E08e
5w5Lpb+dCiotFQtNZ9t0erH2C1bNPwSrs81bRta8Aa5mavhF+bJdI7YWwqNzGGR8
xJ1RhBI7dDND22mVstQNDanRGk73NFjQcSyg85Km0WVVr5eikOGN9Z2hjDw/ZZBc
FAEYocxb/1JWy5hdQjZPeN2GrTv0fAKmQ/fxoPlfBGpR7blyncE=
=+K5K
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--

