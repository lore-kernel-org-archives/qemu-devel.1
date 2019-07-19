Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC38C76188
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 14:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2B2217F5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 14:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FPvLmmmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2B2217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoq1x-0008MZ-R8
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 10:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53765)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hoq1g-0007Sk-QY
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 10:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hoq1f-0002hj-Kx
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 10:07:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37337 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hoq1b-0002Yf-TR; Sat, 20 Jul 2019 10:07:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45rV7Z1lSnz9sNC; Sun, 21 Jul 2019 00:07:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563631658;
 bh=GIs8XKwl06uRHQ/l1PcTQRA8mzVA6skBTsqI/zdaF8M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FPvLmmmHZBlLaaXgusaUwse8JwUp2mxihgxR3ziSHYwABH5eyezdzlDumW0NzWqpW
 pcp2RJBCFgxcEXhdx6RqDnvvhUe1lrS5VVY4sa1aXTjtLxsK3GlWoW+VI1CcT0Z+he
 RRGbzMmQPyAsck+B8wAIfZe8RQD9bNxKJ0Ha8Bpo=
Date: Sat, 20 Jul 2019 00:20:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190719142038.GB4174@umbus.fritz.box>
References: <20190719131425.10835-1-philmd@redhat.com>
 <20190719131425.10835-8-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <20190719131425.10835-8-philmd@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH-for-4.1? 7/7] spapr_events: Rewrite a fall
 through comment
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2019 at 03:14:25PM +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> GCC9 is confused by this comment when building with CFLAG
> -Wimplicit-fallthrough=3D2:
>=20
>     CC      ppc64-softmmu/hw/ppc/spapr_rtc.o
>   hw/ppc/spapr_events.c: In function =E2=80=98rtas_event_log_to_source=E2=
=80=99:
>   hw/ppc/spapr_events.c:312:12: error: this statement may fall through [-=
Werror=3Dimplicit-fallthrough=3D]
>     312 |         if (spapr_ovec_test(spapr->ov5_cas, OV5_HP_EVT)) {
>         |            ^
>   hw/ppc/spapr_events.c:317:5: note: here
>     317 |     case RTAS_LOG_TYPE_EPOW:
>         |     ^~~~
>   cc1: all warnings being treated as errors
>=20
> Rewrite the comment using 'fall through' which is recognized by
> GCC and static analyzers.
>=20
> Reported-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr_events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index ae0f093f59..0a98894ad6 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -313,7 +313,7 @@ rtas_event_log_to_source(SpaprMachineState *spapr, in=
t log_type)
>              g_assert(source->enabled);
>              break;
>          }
> -        /* fall back to epow for legacy hotplug interrupt source */
> +        /* fall through back to epow for legacy hotplug interrupt source=
 */
>      case RTAS_LOG_TYPE_EPOW:
>          source =3D spapr_event_sources_get_source(spapr->event_sources,
>                                                  EVENT_CLASS_EPOW);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0x0bYACgkQbDjKyiDZ
s5I9vxAA0lXp2UY09O/eG6yHIgCAcvXl11ODbYnTahJ3Wu5LGLfj2UeOrj/wg+9+
CVd90uAGBr4qglgwtf8uIDYPgfCvLpr/Gj8RbnoYtOW4yZXI4dpbM7km/HWqHfxk
tumdLZTCEwWYHExhSalWcAroFyPwH04hqgrt9CXijyjfrgQttf4l8qJ7xXbJnuh4
+MTSUuSfTscfpXWUa/yBhNfzdHXLEs0EE6v1+jIbXGnuxxQwwMZ0VDUBL5uqpcPs
FeYQ94FHNnARf3wapU8T4U+Onkqf9AJESXYNGmJR9/rENRI47g3DmLg/EYqIf83G
2wwFxF07goup9Hc8eM2Zj8tO7Pg9CO8G++yTe1t9BTcXCgf+3xyz0UlAVGRNXRUT
OkfTHl2PsMowATemj0fZ6qdyCT/dbySUYTKbO6kNAt6KJcMVV5spKpH3nDTMuYKw
CghZorlnUImR+/QsNLqNaJlQi9eW0LuJdS2NYvRVOo4R4E4Baf3rKG1CKLISE2xF
HydYrUYTNYgZIeaAZK1U+ZMJRPtWnyTmNdqA3aOmVbfUA9D352d+K6k1HbEeWQRh
IR366wn4QRdAbdXPAu+F7UsrtVCkMwnrAu0Hrm6Vqn/xL9fEhli0krx9rciwwi7m
2tbq7Km4XdCoH6VTbuUi7R63GuofwTAeDhubO1nBQvOLwBamV+M=
=TTyo
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--

