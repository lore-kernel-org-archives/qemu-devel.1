Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0F5C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9273A2176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9273A2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaPc4-0007h6-Qd
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 14:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Bilal_Wasim@mentor.com>) id 1iaNhA-0000oP-T7
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Bilal_Wasim@mentor.com>) id 1iaNgx-0004Gd-In
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:35:03 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:29068)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Bilal_Wasim@mentor.com>)
 id 1iaNgx-0003u4-7Y; Thu, 28 Nov 2019 12:34:59 -0500
IronPort-SDR: 18WT71BmfIRhfauOWChApTv/xUVgZwB7PjrlKeNWeXmFx5vnUtIs8wppXz85Ze59PZd7qzJZPb
 ThXsNPePYu2rcizaweYddnBjKE8TSf4xrU9yuhVTt0Vym+hIUdEz5Eum/MdebqVhhKDezZd4zL
 u9Ritt4QngY8fxXH0bDuKxbMX8c1mCJoP1PiREX7BCCDFiAup03XPe5jlsrUKcYIl1zVBNd283
 5L5g985anjeFF6gTDUbnJrTAzOSn47ijijGpZrOKasTs/8nKctiBPXnxebbyB1fWNdWVWZSRoC
 rVI=
X-IronPort-AV: E=Sophos;i="5.69,253,1571731200"; d="scan'208";a="43608530"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa3.mentor.iphmx.com with ESMTP; 28 Nov 2019 09:34:49 -0800
IronPort-SDR: wyPPMdGKIwNy8p6ThmiMNVV/I3oa3zzm7j6E1DsHxVjX5NhVmfUBwENpufWx+loNXmRB3EuoV4
 8MsCFdKwu9gdCe/uXEtNIe4RhNUT5WD321gWeSNkz/rG/AG3eHGfhF3cvVNrY/94DuWctSeILl
 wqmopUbp40t5P6asWRXHCWPaPFyHrRdPhx60EiUGy0+hScEfmbM8WislNd5NNA81ByLXEAoIrd
 NPC7A9mXfIjqAagQeLKssKCm8164+YDYY5AdtqBBa4g+J0Tdu3sfvin2CC2dk1JpQKHYbq/2NQ
 QZ8=
From: "Wasim, Bilal" <Bilal_Wasim@mentor.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: RE: [PATCH] Updating the GEM MAC IP to properly filter out the
 multicast addresses
Thread-Topic: [PATCH] Updating the GEM MAC IP to properly filter out the
 multicast addresses
Thread-Index: AdWl/aPyGC40ldXeTIuqOxj9pJGCcwABzzoAAAIbwuAAARoxAAAAFd1A
Date: Thu, 28 Nov 2019 17:34:44 +0000
Message-ID: <ef4adfa40b5543fba4b8e673e36cbd9e@SVR-IES-MBX-03.mgc.mentorg.com>
References: <2632212d4c8a40bead72ffdcf288e600@SVR-IES-MBX-03.mgc.mentorg.com>
 <20191128155956.GB29312@toto>
 <2b7a42487a5d4a258062bd209a0d13fa@SVR-IES-MBX-03.mgc.mentorg.com>
 <20191128173152.GC29312@toto>
In-Reply-To: <20191128173152.GC29312@toto>
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
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for the pointers.. I will incorporate all these changes and post an =
updated thread asap..=20

-----Original Message-----
From: Edgar E. Iglesias [mailto:edgar.iglesias@gmail.com]=20
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

