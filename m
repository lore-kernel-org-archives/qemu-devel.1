Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6075EC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3654F2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3654F2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAEts-0001t2-Ba
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 10:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jAEsu-0000WD-4s
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:27:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jAEst-0006lZ-0f
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:27:32 -0500
Received: from 15.mo7.mail-out.ovh.net ([87.98.180.21]:55849)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jAEss-0006jz-Qt
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:27:30 -0500
Received: from player762.ha.ovh.net (unknown [10.108.54.67])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 1C33A14D385
 for <qemu-devel@nongnu.org>; Fri,  6 Mar 2020 16:27:28 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player762.ha.ovh.net (Postfix) with ESMTPSA id 8928010240994;
 Fri,  6 Mar 2020 15:27:10 +0000 (UTC)
Subject: Re: [PATCH 6/6] hw/net/can: Make CanBusClientInfo::can_receive()
 return a boolean
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200305175651.4563-1-philmd@redhat.com>
 <20200305175651.4563-7-philmd@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1c54e106-bcf6-b899-a236-8044604a1cfd@kaod.org>
Date: Fri, 6 Mar 2020 16:27:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305175651.4563-7-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 7773212959322049491
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudduvddgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.180.21
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
> The CanBusClientInfo::can_receive handler return whether the
> device can or can not receive new frames. Make it obvious by
> returning a boolean type.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


> ---
>  hw/net/can/can_sja1000.h | 2 +-
>  include/net/can_emu.h    | 2 +-
>  hw/net/can/can_sja1000.c | 8 ++++----
>  net/can/can_socketcan.c  | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/net/can/can_sja1000.h b/hw/net/can/can_sja1000.h
> index 220a622087..7ca9cd681e 100644
> --- a/hw/net/can/can_sja1000.h
> +++ b/hw/net/can/can_sja1000.h
> @@ -137,7 +137,7 @@ void can_sja_disconnect(CanSJA1000State *s);
> =20
>  int can_sja_init(CanSJA1000State *s, qemu_irq irq);
> =20
> -int can_sja_can_receive(CanBusClientState *client);
> +bool can_sja_can_receive(CanBusClientState *client);
> =20
>  ssize_t can_sja_receive(CanBusClientState *client,
>                          const qemu_can_frame *frames, size_t frames_cn=
t);
> diff --git a/include/net/can_emu.h b/include/net/can_emu.h
> index d4fc51b57d..fce9770928 100644
> --- a/include/net/can_emu.h
> +++ b/include/net/can_emu.h
> @@ -83,7 +83,7 @@ typedef struct CanBusClientState CanBusClientState;
>  typedef struct CanBusState CanBusState;
> =20
>  typedef struct CanBusClientInfo {
> -    int (*can_receive)(CanBusClientState *);
> +    bool (*can_receive)(CanBusClientState *);
>      ssize_t (*receive)(CanBusClientState *,
>          const struct qemu_can_frame *frames, size_t frames_cnt);
>  } CanBusClientInfo;
> diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
> index 39c78faf9b..ea915a023a 100644
> --- a/hw/net/can/can_sja1000.c
> +++ b/hw/net/can/can_sja1000.c
> @@ -733,21 +733,21 @@ uint64_t can_sja_mem_read(CanSJA1000State *s, hwa=
ddr addr, unsigned size)
>      return temp;
>  }
> =20
> -int can_sja_can_receive(CanBusClientState *client)
> +bool can_sja_can_receive(CanBusClientState *client)
>  {
>      CanSJA1000State *s =3D container_of(client, CanSJA1000State, bus_c=
lient);
> =20
>      if (s->clock & 0x80) { /* PeliCAN Mode */
>          if (s->mode & 0x01) { /* reset mode. */
> -            return 0;
> +            return false;
>          }
>      } else { /* BasicCAN mode */
>          if (s->control & 0x01) {
> -            return 0;
> +            return false;
>          }
>      }
> =20
> -    return 1; /* always return 1, when operation mode */
> +    return true; /* always return true, when operation mode */
>  }
> =20
>  ssize_t can_sja_receive(CanBusClientState *client, const qemu_can_fram=
e *frames,
> diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
> index 29bfacd4f8..807f31fcde 100644
> --- a/net/can/can_socketcan.c
> +++ b/net/can/can_socketcan.c
> @@ -110,9 +110,9 @@ static void can_host_socketcan_read(void *opaque)
>      }
>  }
> =20
> -static int can_host_socketcan_can_receive(CanBusClientState *client)
> +static bool can_host_socketcan_can_receive(CanBusClientState *client)
>  {
> -    return 1;
> +    return true;
>  }
> =20
>  static ssize_t can_host_socketcan_receive(CanBusClientState *client,
>=20


