Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E1ACA9EB0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 19:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C8F21929
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 19:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XGWVqETa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C8F21929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRLKQ-0003br-BM
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 14:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iRLIi-00033F-OC
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 14:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iRLIg-0000Q1-UM
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 14:12:36 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:57871 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iRLIf-0000Or-TL; Sun, 03 Nov 2019 14:12:34 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 475ltK61bmz9sPK; Mon,  4 Nov 2019 06:12:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572808345;
 bh=Emsine+odTHqybKdmkT1cL6guMEvdl/5put500yFPAk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XGWVqETac/hw+Pjuh/bnxHLwl/k3M1FEdtfkUULO49FxztxsSbzJpMxbhqv0RaF64
 vqiiqnyK1BYA9Qfxzv9M1oxJFMtyPDLHUagdHD9eF8TZCp04OTfBEeRUigKTJ9ktmW
 VIWcSoNCKgaczzPlS2nyLhhI0mGLNrf/7njaV7L8=
Date: Sun, 3 Nov 2019 20:10:13 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] mos6522: fix T1 and T2 timers
Message-ID: <20191103191013.GC3552@umbus.metropole.lan>
References: <20191102154919.17775-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KtWcatouGV9Nk9BU"
Content-Disposition: inline
In-Reply-To: <20191102154919.17775-1-laurent@vivier.eu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KtWcatouGV9Nk9BU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 02, 2019 at 04:49:19PM +0100, Laurent Vivier wrote:
> With the Quadra 800 emulation, mos6522 timers processing can consume
> until 70% of the host CPU time with an idle guest (I guess the problem
> should also happen with PowerMac emulation).
>=20
> On a recent system, it can be painless (except if you look at top), but
> on an old host like a PowerMac G5 the guest kernel can be terribly slow
> during the boot sequence (for instance, unpacking initramfs can take 15
> seconds rather than only 3 seconds).
>=20
> We can avoid this CPU overload by enabling QEMU internal timers only if
> the mos6522 counter interrupts are enabled. Sometime the guest kernel
> wants to read the counters values, but we don't need the timers to
> update the counters.
>=20
> With this patch applied, an idle Q800 consumes only 3% of host CPU time
> (and the guest can boot in a decent time).
>=20
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Applied to ppc-for-4.2, thanks.

> ---
>  hw/misc/mos6522.c | 67 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 52 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> index 57f13db266..aa3bfe1afd 100644
> --- a/hw/misc/mos6522.c
> +++ b/hw/misc/mos6522.c
> @@ -38,8 +38,10 @@
> =20
>  /* XXX: implement all timer modes */
> =20
> -static void mos6522_timer_update(MOS6522State *s, MOS6522Timer *ti,
> -                                 int64_t current_time);
> +static void mos6522_timer1_update(MOS6522State *s, MOS6522Timer *ti,
> +                                  int64_t current_time);
> +static void mos6522_timer2_update(MOS6522State *s, MOS6522Timer *ti,
> +                                  int64_t current_time);
> =20
>  static void mos6522_update_irq(MOS6522State *s)
>  {
> @@ -98,7 +100,11 @@ static void set_counter(MOS6522State *s, MOS6522Timer=
 *ti, unsigned int val)
>      trace_mos6522_set_counter(1 + ti->index, val);
>      ti->load_time =3D get_load_time(s, ti);
>      ti->counter_value =3D val;
> -    mos6522_timer_update(s, ti, ti->load_time);
> +    if (ti->index =3D=3D 0) {
> +        mos6522_timer1_update(s, ti, ti->load_time);
> +    } else {
> +        mos6522_timer2_update(s, ti, ti->load_time);
> +    }
>  }
> =20
>  static int64_t get_next_irq_time(MOS6522State *s, MOS6522Timer *ti,
> @@ -130,19 +136,34 @@ static int64_t get_next_irq_time(MOS6522State *s, M=
OS6522Timer *ti,
>      trace_mos6522_get_next_irq_time(ti->latch, d, next_time - d);
>      next_time =3D muldiv64(next_time, NANOSECONDS_PER_SECOND, ti->freque=
ncy) +
>                           ti->load_time;
> +
>      if (next_time <=3D current_time) {
>          next_time =3D current_time + 1;
>      }
>      return next_time;
>  }
> =20
> -static void mos6522_timer_update(MOS6522State *s, MOS6522Timer *ti,
> +static void mos6522_timer1_update(MOS6522State *s, MOS6522Timer *ti,
> +                                 int64_t current_time)
> +{
> +    if (!ti->timer) {
> +        return;
> +    }
> +    if ((s->ier & T1_INT) =3D=3D 0 || (s->acr & T1MODE) !=3D T1MODE_CONT=
) {
> +        timer_del(ti->timer);
> +    } else {
> +        ti->next_irq_time =3D get_next_irq_time(s, ti, current_time);
> +        timer_mod(ti->timer, ti->next_irq_time);
> +    }
> +}
> +
> +static void mos6522_timer2_update(MOS6522State *s, MOS6522Timer *ti,
>                                   int64_t current_time)
>  {
>      if (!ti->timer) {
>          return;
>      }
> -    if (ti->index =3D=3D 0 && (s->acr & T1MODE) !=3D T1MODE_CONT) {
> +    if ((s->ier & T2_INT) =3D=3D 0) {
>          timer_del(ti->timer);
>      } else {
>          ti->next_irq_time =3D get_next_irq_time(s, ti, current_time);
> @@ -155,7 +176,7 @@ static void mos6522_timer1(void *opaque)
>      MOS6522State *s =3D opaque;
>      MOS6522Timer *ti =3D &s->timers[0];
> =20
> -    mos6522_timer_update(s, ti, ti->next_irq_time);
> +    mos6522_timer1_update(s, ti, ti->next_irq_time);
>      s->ifr |=3D T1_INT;
>      mos6522_update_irq(s);
>  }
> @@ -165,7 +186,7 @@ static void mos6522_timer2(void *opaque)
>      MOS6522State *s =3D opaque;
>      MOS6522Timer *ti =3D &s->timers[1];
> =20
> -    mos6522_timer_update(s, ti, ti->next_irq_time);
> +    mos6522_timer2_update(s, ti, ti->next_irq_time);
>      s->ifr |=3D T2_INT;
>      mos6522_update_irq(s);
>  }
> @@ -204,7 +225,16 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, uns=
igned size)
>  {
>      MOS6522State *s =3D opaque;
>      uint32_t val;
> +    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> =20
> +    if (now >=3D s->timers[0].next_irq_time) {
> +        mos6522_timer1_update(s, &s->timers[0], now);
> +        s->ifr |=3D T1_INT;
> +    }
> +    if (now >=3D s->timers[1].next_irq_time) {
> +        mos6522_timer2_update(s, &s->timers[1], now);
> +        s->ifr |=3D T2_INT;
> +    }
>      switch (addr) {
>      case VIA_REG_B:
>          val =3D s->b;
> @@ -299,8 +329,8 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_=
t val, unsigned size)
>          break;
>      case VIA_REG_T1CL:
>          s->timers[0].latch =3D (s->timers[0].latch & 0xff00) | val;
> -        mos6522_timer_update(s, &s->timers[0],
> -                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        mos6522_timer1_update(s, &s->timers[0],
> +                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
>          break;
>      case VIA_REG_T1CH:
>          s->timers[0].latch =3D (s->timers[0].latch & 0xff) | (val << 8);
> @@ -309,14 +339,14 @@ void mos6522_write(void *opaque, hwaddr addr, uint6=
4_t val, unsigned size)
>          break;
>      case VIA_REG_T1LL:
>          s->timers[0].latch =3D (s->timers[0].latch & 0xff00) | val;
> -        mos6522_timer_update(s, &s->timers[0],
> -                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        mos6522_timer1_update(s, &s->timers[0],
> +                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
>          break;
>      case VIA_REG_T1LH:
>          s->timers[0].latch =3D (s->timers[0].latch & 0xff) | (val << 8);
>          s->ifr &=3D ~T1_INT;
> -        mos6522_timer_update(s, &s->timers[0],
> -                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        mos6522_timer1_update(s, &s->timers[0],
> +                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
>          break;
>      case VIA_REG_T2CL:
>          s->timers[1].latch =3D (s->timers[1].latch & 0xff00) | val;
> @@ -334,8 +364,8 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_=
t val, unsigned size)
>          break;
>      case VIA_REG_ACR:
>          s->acr =3D val;
> -        mos6522_timer_update(s, &s->timers[0],
> -                             qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        mos6522_timer1_update(s, &s->timers[0],
> +                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
>          break;
>      case VIA_REG_PCR:
>          s->pcr =3D val;
> @@ -354,6 +384,11 @@ void mos6522_write(void *opaque, hwaddr addr, uint64=
_t val, unsigned size)
>              s->ier &=3D ~val;
>          }
>          mos6522_update_irq(s);
> +        /* if IER is modified starts needed timers */
> +        mos6522_timer1_update(s, &s->timers[0],
> +                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        mos6522_timer2_update(s, &s->timers[1],
> +                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
>          break;
>      default:
>      case VIA_REG_ANH:
> @@ -426,9 +461,11 @@ static void mos6522_reset(DeviceState *dev)
>      s->timers[0].frequency =3D s->frequency;
>      s->timers[0].latch =3D 0xffff;
>      set_counter(s, &s->timers[0], 0xffff);
> +    timer_del(s->timers[0].timer);
> =20
>      s->timers[1].frequency =3D s->frequency;
>      s->timers[1].latch =3D 0xffff;
> +    timer_del(s->timers[1].timer);
>  }
> =20
>  static void mos6522_init(Object *obj)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KtWcatouGV9Nk9BU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2/JhIACgkQbDjKyiDZ
s5JK+A//XBYemCX9JOtuLk8B+3Ys22nj/m0hCUG0qE6MUDAbTtj8EVdQ4/X8GiWi
uvlwREXBlcMkHlrMHcM0UZmALzmk1w15lEV9sst9ghXFfUbVD16ZXrJqZxE0UBZM
k4s26dc81uFa/DeiL0VFs2nr8hvMA42WwgjU1x++Mt/57S9umZOtbl6Q8wx2lejm
ffWadfoMfuAkJZWX9UjnD28wkp6Qa07mzFi9/3N2Ws5sS2ILxUjPu3pnhYWE4GbJ
IulEInnAcLy8SnbR0WAp+g0k+7WZCZo5DWAiReZCkmNYsc8l3BYiKNU8nbUC2esP
QdfWSLRVZMg7B1iOC+Qh7V9VoLU3e6UEwSdgDI4nZ13yLqWerZziqJMx0VBydZNp
uR2ESKSplGYcoTLMWIm3yliQt5iGPeGY3i14u1nx6ChoIlZUC+7r8fXN4DZ5feGD
o9cSSGckzZLtidKF2HChwz21HK/umRMI6f4qO0JQ07qSKH/3/1KhPfjffpLYZkue
DDhMkuBBFoUjH0r9X03DN6CaZtjrVO7T6br2YkrxFkMgxCgIa3Mm2Rrtdk/rpdtH
6/m39463Ab+4QagprbCnFt2gLqYZu1JyZR9hLN1dbeYQRdflb8bNJWamr2VuKIYw
U0MK2HGuJVhYll2FM1dTTs+TqpqkHC2A0Uk23tOPVINmh+v9Bq0=
=06+F
-----END PGP SIGNATURE-----

--KtWcatouGV9Nk9BU--

