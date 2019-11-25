Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46970C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 23:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1077820733
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 23:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="D4AETldL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1077820733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZO05-0008Jc-0L
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 18:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iZNz8-0007MC-GL
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 18:41:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iZNz6-0002Ix-V4
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 18:41:38 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35767 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iZNz5-0002Gu-Mw; Mon, 25 Nov 2019 18:41:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47MNpb1ZDWz9sPZ; Tue, 26 Nov 2019 10:41:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574725287;
 bh=gNmi8kLyIlz2bazcTXuD81lF9+J/avPP0XYrEx8ojjY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D4AETldL3L9oouKJWZp2ZmKFobkhCgtgEJoUIJVTlO8KDhvet0CiGw7Lwv/BXad27
 r4BATZ0ftKV3J68l4EvFElsyZmrDg8+ObtEQMqrq1lP2Xd1YskWDNnS063m9reN7Xh
 wCigRav8kHLKng99c0rhh48kNQcTaq/cbXtBSYh0=
Date: Tue, 26 Nov 2019 10:12:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] mos6522: update counters when timer interrupts are off
Message-ID: <20191125231217.GI5582@umbus.fritz.box>
References: <20191125141414.5015-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6gQwMJXxXgY8ZpDE"
Content-Disposition: inline
In-Reply-To: <20191125141414.5015-1-laurent@vivier.eu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Andrew Randrianasulu <randrianasulu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6gQwMJXxXgY8ZpDE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2019 at 03:14:14PM +0100, Laurent Vivier wrote:
> Even if the interrupts are off, counters must be updated because
> they are running anyway and kernel can try to read them
> (it's the case with g3beige kernel).
>=20
> Reported-by: Andrew Randrianasulu <randrianasulu@gmail.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Applied to ppc-for-4.2, thanks.

> ---
>  hw/misc/mos6522.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> index aa3bfe1afd..cecf0be59e 100644
> --- a/hw/misc/mos6522.c
> +++ b/hw/misc/mos6522.c
> @@ -113,6 +113,10 @@ static int64_t get_next_irq_time(MOS6522State *s, MO=
S6522Timer *ti,
>      int64_t d, next_time;
>      unsigned int counter;
> =20
> +    if (ti->frequency =3D=3D 0) {
> +        return INT64_MAX;
> +    }
> +
>      /* current counter value */
>      d =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - ti->load_time,
>                   ti->frequency, NANOSECONDS_PER_SECOND);
> @@ -149,10 +153,10 @@ static void mos6522_timer1_update(MOS6522State *s, =
MOS6522Timer *ti,
>      if (!ti->timer) {
>          return;
>      }
> +    ti->next_irq_time =3D get_next_irq_time(s, ti, current_time);
>      if ((s->ier & T1_INT) =3D=3D 0 || (s->acr & T1MODE) !=3D T1MODE_CONT=
) {
>          timer_del(ti->timer);
>      } else {
> -        ti->next_irq_time =3D get_next_irq_time(s, ti, current_time);
>          timer_mod(ti->timer, ti->next_irq_time);
>      }
>  }
> @@ -163,10 +167,10 @@ static void mos6522_timer2_update(MOS6522State *s, =
MOS6522Timer *ti,
>      if (!ti->timer) {
>          return;
>      }
> +    ti->next_irq_time =3D get_next_irq_time(s, ti, current_time);
>      if ((s->ier & T2_INT) =3D=3D 0) {
>          timer_del(ti->timer);
>      } else {
> -        ti->next_irq_time =3D get_next_irq_time(s, ti, current_time);
>          timer_mod(ti->timer, ti->next_irq_time);
>      }
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6gQwMJXxXgY8ZpDE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3cX88ACgkQbDjKyiDZ
s5LxnQ/+Jvncu8f+o+y4a6lqwr24YqYv5Fdm9bnJDWbSaRQvRQWQakf5THF9kR5/
2129yCrK3kVWo0iXUyU+qvHTgpriPQS28vRokLspenI5bLFK+i6MDKkDFxtol/rL
bi+kzoPQZBFkDHpIpgmcYdmBaPilIZ7fuuLb8YtTT+4/krl5LOY0D+Hc91b6NKT7
XD/MnZkztC6E3sk+YyEcNa0pDVimlHrV+wEmc9nn0PGrrEt1LSJ1vwbfxRhlgtyw
91Vw96y9exWFuDjl4mFhSg5bnXFjzL05v23x0otCFlVN4OtWpym4DMxlZOM6LmPm
aJ/xDcBqdrxfZCv+3pzLQGfuO9THptkBKgeSZZxsEXInMWiwSk/ClUcQTXUUayqQ
hDdVTFi1URTRb8DuVLGbjPiHRCCZTcnTPygaFzAMCL2bknPyfIEGoRV1evCP++9m
BcLeg5+rHI1XSyoOWwslCAvtsLFPO6Crdf/zAABnZ9ZAu9JamwvPWcw6Y5HM1KJc
cNohXquC30plKXOgzgkDoheJIC8mRGwfB4eKPV9yCnKXkQIfqqV3oo5MwFEpzWu4
uEKmz7xHqrWEV2M/blqm/LnwQnfo7jVcJogN28/NMKYnc9HcvgPAkUuXjq5us90/
H6NooBbxlpKpVfA+KBJ6Vkxi0ycGgF6+tMbahndz156CdwX6bPM=
=42bo
-----END PGP SIGNATURE-----

--6gQwMJXxXgY8ZpDE--

