Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112B1C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF83217BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF83217BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iacBt-0002iO-TH
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Bilal_Wasim@mentor.com>) id 1iac3A-00071j-Eo
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Bilal_Wasim@mentor.com>) id 1iac30-00080X-QV
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:54:44 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:20890)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Bilal_Wasim@mentor.com>)
 id 1iac30-0007YU-H0; Fri, 29 Nov 2019 03:54:42 -0500
IronPort-SDR: kFnqDZaQu70W3Xm7rwh0M8bJtuwCoq6dMil+uB/IYuhQbJGYa6mqKKt6RTvyGuKEOqQUvldLH6
 uviLNSx2ArIQ3DBzk5/yd4elSJBBYq7IQ8mynW/emwKuEV06uQt4dHJuIuyKBpzanLth/zfyOK
 4+uowywLFSJq6cWklZIfZXGaQo7ct+kbfmc75ezdZS1fg9EPzbSNSmbTnuadBaMWtZsJp0fPS3
 6qGcV0yFypSMv8peCsPqmRto2TVBHP/2MsRxqHzHT4o7D/wHFgzzOLWlA3j75hGhn5OULyCD5F
 nK8=
X-IronPort-AV: E=Sophos;i="5.69,256,1571731200"; d="scan'208";a="43559764"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa2.mentor.iphmx.com with ESMTP; 29 Nov 2019 00:54:34 -0800
IronPort-SDR: j5tEU0mc7h35MshJacf+Akn28EprdNRT5DU8srTbqrDkONbEKs8Kj1gT67Rv8/JHoOklicsJ/2
 3tKhEx6PU1m2chM/FAugsxJByLjk55gVr/SpndIt9Bt+somfiaxISfBrVCPyuv1QcAh8w50L27
 pJVuUJQykgvpleDW8S+ndNHdn0pLFQ6ydYGHpqd6DT9e3tEHC/z/PkqOIPD8roWcF3w2AwhWml
 ySkhv7GHFPfUBd6KZpmkWFYnKGPnTPe+m2qTi80zsG36A6oQpwy2ELybvXNA/ZRxCA/V8bPofD
 vnU=
From: "Wasim, Bilal" <Bilal_Wasim@mentor.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: RE: [PATCH] Updating the GEM MAC IP to properly filter out the
 multicast addresses
Thread-Topic: [PATCH] Updating the GEM MAC IP to properly filter out the
 multicast addresses
Thread-Index: AdWl/aPyGC40ldXeTIuqOxj9pJGCcwABzzoAAAIbwuAAARoxAAAAFd1AACAZLEA=
Date: Fri, 29 Nov 2019 08:54:29 +0000
Message-ID: <103588e5aa0c43858123d77131ff136f@SVR-IES-MBX-03.mgc.mentorg.com>
References: <2632212d4c8a40bead72ffdcf288e600@SVR-IES-MBX-03.mgc.mentorg.com>
 <20191128155956.GB29312@toto>
 <2b7a42487a5d4a258062bd209a0d13fa@SVR-IES-MBX-03.mgc.mentorg.com>
 <20191128173152.GC29312@toto>
 <ef4adfa40b5543fba4b8e673e36cbd9e@SVR-IES-MBX-03.mgc.mentorg.com>
In-Reply-To: <ef4adfa40b5543fba4b8e673e36cbd9e@SVR-IES-MBX-03.mgc.mentorg.com>
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
X-Received-From: 68.232.141.98
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
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

git "send-email" doesn't really work well with my work account because the =
server considers it "less secure" and does NOT provide a way around it.. I'=
ve had to re-submit the patch from my secondary email...=20

-----Original Message-----
From: Qemu-arm [mailto:qemu-arm-bounces+bilal_wasim=3Dmentor.com@nongnu.org=
] On Behalf Of Wasim, Bilal
Sent: Thursday, November 28, 2019 10:35 PM
To: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Cc: peter.maydell@linaro.org; alistair@alistair23.me; qemu-devel@nongnu.org=
; qemu-arm@nongnu.org
Subject: RE: [PATCH] Updating the GEM MAC IP to properly filter out the mul=
ticast addresses

Thanks for the pointers.. I will incorporate all these changes and post an =
updated thread asap..=20

-----Original Message-----
From: Edgar E. Iglesias [mailto:edgar.iglesias@gmail.com]
Sent: Thursday, November 28, 2019 10:32 PM
To: Wasim, Bilal <Bilal_Wasim@mentor.com>
Cc: qemu-devel@nongnu.org; alistair@alistair23.me; peter.maydell@linaro.org=
; qemu-arm@nongnu.org
Subject: Re: [PATCH] Updating the GEM MAC IP to properly filter out the mul=
ticast addresses

On Thu, Nov 28, 2019 at 05:02:00PM +0000, Wasim, Bilal wrote:
> This was one of my first attempts, and so I was sure to miss something.. =
I've incorporated all the updates in this patch.. Let me know what you thin=
k about this..=20
>=20
> net/cadence_gem: Updating the GEM MAC IP to properly filter out the multi=
cast addresses.
>=20
> The current code makes a bad assumption that the most-significant byte=20
> of the MAC address is used to determine if the address is multicast or=20
> unicast, but in reality only a single bit is used to determine this.
> This caused IPv6 to not work.. Fix is now in place and has been tested=20
> with ZCU102-A53 / IPv6 on a TAP interface. Works well..

Thanks Bilal,

This looks better but not quite there yet.

* You don't seem to be using git-send-email to post patches, try it, it wil=
l make life easier wrt to formatting. The patch should be in a separate ema=
il. The subject line should be the subject of the email.
git-format-patch and git-send-email will take care of that for you.

* You don't need to define IS_MULTICAST, you can directly use is_multicast_=
ether_addr() and friends.

* The patch still has long lines (longer than 80 chars) You can run scripts=
/checkpatch.pl on your commit before posting the patch.

Cheers,
Edgar



>=20
> Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
> ---
>  hw/net/cadence_gem.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index=20
> b8be73dc55..98efb93f8a 100644
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
> @@ -315,6 +316,12 @@
> =20
>  #define GEM_MODID_VALUE 0x00020118
> =20
> +/* IEEE has specified that the most significant bit of the most=20
> +significant byte be used for
> + * distinguishing between Unicast and Multicast addresses.
> + * If its a 1, that means multicast, 0 means unicast.   */
> +#define IS_MULTICAST(address)           is_multicast_ether_addr(address)
> +#define IS_UNICAST(address)             is_unicast_ether_addr(address)
> +
>  static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s,=20
> uint32_t *desc)  {
>      uint64_t ret =3D desc[0];
> @@ -601,7 +608,7 @@ static void gem_receive_updatestats(CadenceGEMState *=
s, const uint8_t *packet,
>      }
> =20
>      /* Error-free Multicast Frames counter */
> -    if (packet[0] =3D=3D 0x01) {
> +    if (IS_MULTICAST(packet)) {
>          s->regs[GEM_RXMULTICNT]++;
>      }
> =20
> @@ -690,21 +697,21 @@ static int gem_mac_address_filter(CadenceGEMState *=
s, const uint8_t *packet)
>      }
> =20
>      /* Accept packets -w- hash match? */
> -    if ((packet[0] =3D=3D 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_=
HASH)) ||
> -        (packet[0] !=3D 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HA=
SH))) {
> +    if ((IS_MULTICAST(packet) && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_H=
ASH)) ||
> +        (IS_UNICAST(packet)   && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_H=
ASH))) {
>          unsigned hash_index;
> =20
>          hash_index =3D calc_mac_hash(packet);
>          if (hash_index < 32) {
>              if (s->regs[GEM_HASHLO] & (1<<hash_index)) {
> -                return packet[0] =3D=3D 0x01 ? GEM_RX_MULTICAST_HASH_ACC=
EPT :
> -                                           GEM_RX_UNICAST_HASH_ACCEPT;
> +                return IS_MULTICAST(packet) ? GEM_RX_MULTICAST_HASH_ACCE=
PT :
> +                                             =20
> + GEM_RX_UNICAST_HASH_ACCEPT;
>              }
>          } else {
>              hash_index -=3D 32;
>              if (s->regs[GEM_HASHHI] & (1<<hash_index)) {
> -                return packet[0] =3D=3D 0x01 ? GEM_RX_MULTICAST_HASH_ACC=
EPT :
> -                                           GEM_RX_UNICAST_HASH_ACCEPT;
> +                return IS_MULTICAST(packet) ? GEM_RX_MULTICAST_HASH_ACCE=
PT :
> +                                             =20
> + GEM_RX_UNICAST_HASH_ACCEPT;
>              }
>          }
>      }
> --
> 2.19.1.windows.1
>=20
> ----------------------------------------------------------------------
> --------------------------------------------------------
> -----Original Message-----
> From: Edgar E. Iglesias [mailto:edgar.iglesias@gmail.com]
> Sent: Thursday, November 28, 2019 9:00 PM
> To: Wasim, Bilal <Bilal_Wasim@mentor.com>
> Cc: qemu-devel@nongnu.org; alistair@alistair23.me;=20
> peter.maydell@linaro.org; qemu-arm@nongnu.org
> Subject: Re: [PATCH] Updating the GEM MAC IP to properly filter out=20
> the multicast addresses
>=20
> On Thu, Nov 28, 2019 at 03:10:16PM +0000, Wasim, Bilal wrote:
> > [PATCH] Updating the GEM MAC IP to properly filter out the multicast=20
> > addresses. The current code makes a bad assumption that the=20
> > most-significant byte of the MAC address is used to determine if the=20
> > address is multicast or unicast, but in reality only a single bit is=20
> > used to determine this. This caused IPv6 to not work.. Fix is now in=20
> > place and has been tested with
> > ZCU102-A53 / IPv6 on a TAP interface. Works well..
>=20
> Hi Bilal,
>=20
> The fix looks right to me but I have a few comments.
>=20
> * Your patch seems a little wrongly formated.
> [PATCH] goes into the Subject line for example and you're missing path pr=
efixes.
>=20
> Do a git log -- hw/net/cadence_gem.c to see examples on how it should loo=
k.
>=20
> * The patch will probably not pass checkpatch since you seem to have long=
 lines.
>=20
> * We also need to update gem_receive_updatestats() to use the corrected m=
acros.
>=20
> More inline:
>=20
> >=20
> > Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
> > ---
> > hw/net/cadence_gem.c | 18 ++++++++++++------
> > 1 file changed, 12 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
> > b8be73d..f8bcbb3 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -315,6 +315,12 @@
> >  #define GEM_MODID_VALUE 0x00020118
> > +/* IEEE has specified that the most significant bit of the most=20
> > +significant byte be used for
> > + * distinguishing between Unicast and Multicast addresses.
> > + * If its a 1, that means multicast, 0 means unicast.   */
> > +#define IS_MULTICAST(address)           (((address[0] & 0x01) =3D=3D 0=
x01) ? 1 : 0)
>=20
>=20
>=20
> This can be simplified:
> #define IS_MULTICAST(address) (address[0] & 1)
>=20
> Actually, looking closer, we already have functions to do these checks in=
:
> include/net/eth.h
>=20
> static inline int is_multicast_ether_addr(const uint8_t *addr) static=20
> inline int is_broadcast_ether_addr(const uint8_t *addr) static inline=20
> int is_unicast_ether_addr(const uint8_t *addr)
>=20
>=20
>=20
> > +#define IS_UNICAST(address)             (!IS_MULTICAST(address))
> > +
> > static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s,=20
> > uint32_t
> > *desc) {
> >      uint64_t ret =3D desc[0];
> > @@ -690,21 +696,21 @@ static int gem_mac_address_filter(CadenceGEMState=
 *s, const uint8_t *packet)
> >      }
> >      /* Accept packets -w- hash match? */
> > -    if ((packet[0] =3D=3D 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAS=
T_HASH)) ||
> > -        (packet[0] !=3D 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_=
HASH))) {
> > +    if ((IS_MULTICAST(packet) && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST=
_HASH)) ||
> > +        (IS_UNICAST(packet)   && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST=
_HASH))) {
> >          unsigned hash_index;
> >          hash_index =3D calc_mac_hash(packet);
> >          if (hash_index < 32) {
> >              if (s->regs[GEM_HASHLO] & (1<<hash_index)) {
> > -                return packet[0] =3D=3D 0x01 ? GEM_RX_MULTICAST_HASH_A=
CCEPT :
> > -                                           GEM_RX_UNICAST_HASH_ACCEPT;
> > +                return IS_MULTICAST(packet) ? GEM_RX_MULTICAST_HASH_AC=
CEPT :
> > +                                             =20
> > + GEM_RX_UNICAST_HASH_ACCEPT;
> >              }
> >          } else {
> >              hash_index -=3D 32;
> >              if (s->regs[GEM_HASHHI] & (1<<hash_index)) {
> > -                return packet[0] =3D=3D 0x01 ? GEM_RX_MULTICAST_HASH_A=
CCEPT :
> > -                                           GEM_RX_UNICAST_HASH_ACCEPT;
> > +                return IS_MULTICAST(packet) ? GEM_RX_MULTICAST_HASH_AC=
CEPT :
> > +                                             =20
> > + GEM_RX_UNICAST_HASH_ACCEPT;
> >              }
> >          }
> >      }
> > --
> > 2.9.3
> >=20


