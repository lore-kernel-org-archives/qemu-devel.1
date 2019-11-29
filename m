Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ECFC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB86C21774
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB86C21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaen1-0001vE-0q
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 06:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Bilal_Wasim@mentor.com>) id 1iaeOw-0002aU-0K
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Bilal_Wasim@mentor.com>) id 1iaeOq-0002kO-6w
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:25:26 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:57531)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Bilal_Wasim@mentor.com>)
 id 1iaeOo-0002aW-2o; Fri, 29 Nov 2019 06:25:22 -0500
IronPort-SDR: GTLqJW6RXPQNPOC/SOcfMIOdCUKvKndfJXtkoav8cNd9SHRyq4IhQwTVXRwn1rusypBqXgsef6
 pCywU1FWZqTHAAJKQX+C2HGJDERksBHzpN5DeEjGWZTRc80m6/gxP3Kg7xoecuuvChzKVyW8e5
 n9mVz3H5pzoDyWAOd8Hpr0LwSOb6HV9zYl/sbmLY+DctjxJgsmSf66KJI0UN1oHqHtr/cIIBJA
 RuaxlMSzVBbwqG6k24KCVeU8Mpg64t1cev9JNDzulLsf/kzRPj3AP4LI3Y2+xbpoe9UQWrDowl
 izc=
X-IronPort-AV: E=Sophos;i="5.69,257,1571731200"; d="scan'208";a="43623921"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa3.mentor.iphmx.com with ESMTP; 29 Nov 2019 03:25:10 -0800
IronPort-SDR: NUwPZRuv8dBo3L+tNWf/4uIobHGAyj7QHfCv/Wg4c/LLr6JYDN1G97ir4/yjiGnG4hIakV8QG7
 ekhCqtfSbteXBRdVzNw7AlXGmGQXYsuzLRULYA1O700mCgkyQq3bPnFBgAxpaBHIXcUu1svOJs
 ew/YRkH0qWmeW3G55dlTETM5cz+Ube+/wC2S9Lsbp8wszQVD5Vr7jAYnMoWnZwwlJh3akDUUDX
 QzKyCNNXuHw3kRmMIakNynLPo6/nVCoRamvuHAdX7+TyONv+iizhFjpzDH+j89/Bnrzyj+j9/f
 K4o=
From: "Wasim, Bilal" <Bilal_Wasim@mentor.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "bilalwasim676@gmail.com"
 <bilalwasim676@gmail.com>
Subject: RE: [PATCH v3] net/cadence_gem: Updating the GEM MAC IP to properly
 filter out multicast addresses.
Thread-Topic: [PATCH v3] net/cadence_gem: Updating the GEM MAC IP to properly
 filter out multicast addresses.
Thread-Index: AQHVpp8tgvWMiE5SAUuNXNNescw4gqeiAVGAgAAAhAA=
Date: Fri, 29 Nov 2019 11:25:05 +0000
Message-ID: <1ed44ab59c784e3d97f9ffe871dbb476@SVR-IES-MBX-03.mgc.mentorg.com>
References: <20191129102414.14060-1-bilalwasim676@gmail.com>
 <20191129112227.GC25295@toto>
In-Reply-To: <20191129112227.GC25295@toto>
Accept-Language: en-GB, en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.137.180
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alistair@alistair23.me" <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for also helping me get through the "somewhat" tedious patch process=
 of QEMU.. Will be helpful for future submissions..=20

- Bilal

-----Original Message-----
From: Edgar E. Iglesias [mailto:edgar.iglesias@gmail.com]=20
Sent: Friday, November 29, 2019 4:22 PM
To: bilalwasim676@gmail.com
Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; alistair@alistair23.me; Was=
im, Bilal <Bilal_Wasim@mentor.com>; peter.maydell@linaro.org
Subject: Re: [PATCH v3] net/cadence_gem: Updating the GEM MAC IP to properl=
y filter out multicast addresses.

On Fri, Nov 29, 2019 at 03:24:14PM +0500, bilalwasim676@gmail.com wrote:
> From: bwasim <bilal_wasim@mentor.com>
>=20
> The current code makes a bad assumption that the most-significant byte=20
> of the MAC address is used to determine if the address is multicast or=20
> unicast, but in reality only a single bit is used to determine this.
> This caused IPv6 to not work.. Fix is now in place and has been tested=20
> with ZCU102-A53 / IPv6 on a TAP interface. Works well..


Thanks Bilal,

I ran this through our internal test-suite, looks good.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Cheers,
Edgar


>=20
> Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
> ---
>  hw/net/cadence_gem.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index=20
> b8be73dc55..6400b3653b 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -34,6 +34,7 @@
>  #include "qemu/module.h"
>  #include "sysemu/dma.h"
>  #include "net/checksum.h"
> +#include "net/eth.h"
> =20
>  #ifdef CADENCE_GEM_ERR_DEBUG
>  #define DB_PRINT(...) do { \
> @@ -601,7 +602,7 @@ static void gem_receive_updatestats(CadenceGEMState *=
s, const uint8_t *packet,
>      }
> =20
>      /* Error-free Multicast Frames counter */
> -    if (packet[0] =3D=3D 0x01) {
> +    if (is_multicast_ether_addr(packet)) {
>          s->regs[GEM_RXMULTICNT]++;
>      }
> =20
> @@ -690,21 +691,25 @@ static int gem_mac_address_filter(CadenceGEMState *=
s, const uint8_t *packet)
>      }
> =20
>      /* Accept packets -w- hash match? */
> -    if ((packet[0] =3D=3D 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_=
HASH)) ||
> -        (packet[0] !=3D 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HA=
SH))) {
> +    if ((is_multicast_ether_addr(packet)
> +        && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
> +        (is_unicast_ether_addr(packet)
> +        && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
>          unsigned hash_index;
> =20
>          hash_index =3D calc_mac_hash(packet);
>          if (hash_index < 32) {
>              if (s->regs[GEM_HASHLO] & (1<<hash_index)) {
> -                return packet[0] =3D=3D 0x01 ? GEM_RX_MULTICAST_HASH_ACC=
EPT :
> -                                           GEM_RX_UNICAST_HASH_ACCEPT;
> +                return is_multicast_ether_addr(packet) ?
> +                       GEM_RX_MULTICAST_HASH_ACCEPT :
> +                       GEM_RX_UNICAST_HASH_ACCEPT;
>              }
>          } else {
>              hash_index -=3D 32;
>              if (s->regs[GEM_HASHHI] & (1<<hash_index)) {
> -                return packet[0] =3D=3D 0x01 ? GEM_RX_MULTICAST_HASH_ACC=
EPT :
> -                                           GEM_RX_UNICAST_HASH_ACCEPT;
> +                return is_multicast_ether_addr(packet) ?
> +                       GEM_RX_MULTICAST_HASH_ACCEPT :
> +                       GEM_RX_UNICAST_HASH_ACCEPT;
>              }
>          }
>      }
> @@ -1083,7 +1088,7 @@ static void gem_transmit_updatestats(CadenceGEMStat=
e *s, const uint8_t *packet,
>      }
> =20
>      /* Error-free Multicast Frames counter */
> -    if (packet[0] =3D=3D 0x01) {
> +    if (is_multicast_ether_addr(packet)) {
>          s->regs[GEM_TXMCNT]++;
>      }
> =20
> --
> 2.19.1.windows.1
>=20

