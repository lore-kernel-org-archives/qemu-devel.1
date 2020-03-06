Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAAEC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F9B12073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9B12073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAEtD-0000Vp-Ne
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 10:27:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jAEsJ-0007hU-9R
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jAEsI-0005zv-83
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:26:55 -0500
Received: from 20.mo4.mail-out.ovh.net ([46.105.33.73]:46111)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jAEsI-0005xr-2R
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:26:54 -0500
Received: from player789.ha.ovh.net (unknown [10.108.57.211])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 66A1521C33A
 for <qemu-devel@nongnu.org>; Fri,  6 Mar 2020 16:26:52 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 7EDB9102D211E;
 Fri,  6 Mar 2020 15:26:32 +0000 (UTC)
Subject: Re: [PATCH 3/6] hw/net/rtl8139: Simplify if/else statement
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200305175651.4563-1-philmd@redhat.com>
 <20200305175651.4563-4-philmd@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b53d8a77-544b-c7c4-b208-13dacc437913@kaod.org>
Date: Fri, 6 Mar 2020 16:26:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305175651.4563-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 7763079858530520019
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudduvddgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.33.73
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
Cc: qemu-ppc@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 Joel Stanley <joel@jms.id.au>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/5/20 6:56 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Rewrite:
>=20
>       if (E) {
>           return A;
>       } else {
>           return B;
>       }
>       /* EOF */
>   }
>=20
> as:
>=20
>       if (E) {
>           return A;
>       }
>       return B;
>   }
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/net/rtl8139.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index ae4739bc09..ef3211537f 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -808,11 +808,11 @@ static int rtl8139_can_receive(NetClientState *nc=
)
>          /* ??? Flow control not implemented in c+ mode.
>             This is a hack to work around slirp deficiencies anyway.  *=
/
>          return 1;
> -    } else {
> -        avail =3D MOD2(s->RxBufferSize + s->RxBufPtr - s->RxBufAddr,
> -                     s->RxBufferSize);
> -        return (avail =3D=3D 0 || avail >=3D 1514 || (s->IntrMask & Rx=
Overflow));
>      }
> +
> +    avail =3D MOD2(s->RxBufferSize + s->RxBufPtr - s->RxBufAddr,
> +                 s->RxBufferSize);
> +    return avail =3D=3D 0 || avail >=3D 1514 || (s->IntrMask & RxOverf=
low);
>  }
> =20
>  static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *b=
uf, size_t size_, int do_interrupt)
>=20


