Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F5CC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 20:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBBEC21771
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 20:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBEC21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaQ7A-0005Jb-VL
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 15:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Bilal_Wasim@mentor.com>) id 1iaNIt-0005P4-Mz
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Bilal_Wasim@mentor.com>) id 1iaNBK-0005Sw-3v
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:02:21 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:9371)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Bilal_Wasim@mentor.com>)
 id 1iaNBI-0005OV-Fm; Thu, 28 Nov 2019 12:02:18 -0500
IronPort-SDR: T9xF/gxdfmbLiQfx4t02MDUuxToL6Xkvh45fvyd0xC4t0XX8/Wpw98Y8lYIBCc6X/gammwcYk+
 8uvTwXbPtdUDehaqYtgIqeOGMXN4dGxHu6QlXzW1IxpGKwfzru28KAw0hEqyYYPyIH1i0h/Rq1
 1KlVDl8VUbf2eaVguRnbq1EuMECqgdL4AvNgkajZ04dsUIozlfIh6uSQ8YK+5VE/my8sejibRb
 senN8dPO/cKj4Xnuw7R26hNCXkPvPXwI9b9FI9RnvOAor7Q8IcQ2eInZj3176BS1nTXheNXFoD
 dws=
X-IronPort-AV: E=Sophos;i="5.69,253,1571731200"; d="scan'208";a="43547596"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa2.mentor.iphmx.com with ESMTP; 28 Nov 2019 09:02:05 -0800
IronPort-SDR: DjQ599I0sE3eIppajBwpzeZvIpMUZBcWGaBmn45CsdgYf6y9znZK46Nvlb+zzDzVNcD2bELOgN
 nZqC5SNd5hKrp6xga1NoLPdH/js5Q6peqNQQiF61KSfo668bkWJXXkrTvmCIECwFvsW94+H06i
 SRozdQTGxeLAvq45Oe+z6reLN8IgJRrueHBv/wxBW92stH0yvBEAEzLHrhNHAm2CjAG5ydnuZV
 ooJ0T7DVgnaz5pPrdgP72wj40RQpCXnyUcPXwY6pda8pEN9yE0/DN1aLZu1PBqYkqMlNnZcjAq
 rHs=
From: "Wasim, Bilal" <Bilal_Wasim@mentor.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: RE: [PATCH] Updating the GEM MAC IP to properly filter out the
 multicast addresses
Thread-Topic: [PATCH] Updating the GEM MAC IP to properly filter out the
 multicast addresses
Thread-Index: AdWl/aPyGC40ldXeTIuqOxj9pJGCcwABzzoAAAIbwuA=
Date: Thu, 28 Nov 2019 17:02:00 +0000
Message-ID: <2b7a42487a5d4a258062bd209a0d13fa@SVR-IES-MBX-03.mgc.mentorg.com>
References: <2632212d4c8a40bead72ffdcf288e600@SVR-IES-MBX-03.mgc.mentorg.com>
 <20191128155956.GB29312@toto>
In-Reply-To: <20191128155956.GB29312@toto>
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

This was one of my first attempts, and so I was sure to miss something.. I'=
ve incorporated all the updates in this patch.. Let me know what you think =
about this..=20

net/cadence_gem: Updating the GEM MAC IP to properly filter out the multica=
st addresses.

The current code makes a bad assumption that the most-significant byte
of the MAC address is used to determine if the address is multicast or
unicast, but in reality only a single bit is used to determine this.
This caused IPv6 to not work.. Fix is now in place and has been tested
with ZCU102-A53 / IPv6 on a TAP interface. Works well..

Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
---
 hw/net/cadence_gem.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index b8be73dc55..98efb93f8a 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -34,6 +34,7 @@
 #include "qemu/module.h"
 #include "sysemu/dma.h"
 #include "net/checksum.h"
+#include "net/eth.h"
=20
 #ifdef CADENCE_GEM_ERR_DEBUG
 #define DB_PRINT(...) do { \
@@ -315,6 +316,12 @@
=20
 #define GEM_MODID_VALUE 0x00020118
=20
+/* IEEE has specified that the most significant bit of the most significan=
t byte be used for
+ * distinguishing between Unicast and Multicast addresses.
+ * If its a 1, that means multicast, 0 means unicast.   */
+#define IS_MULTICAST(address)           is_multicast_ether_addr(address)
+#define IS_UNICAST(address)             is_unicast_ether_addr(address)
+
 static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *de=
sc)
 {
     uint64_t ret =3D desc[0];
@@ -601,7 +608,7 @@ static void gem_receive_updatestats(CadenceGEMState *s,=
 const uint8_t *packet,
     }
=20
     /* Error-free Multicast Frames counter */
-    if (packet[0] =3D=3D 0x01) {
+    if (IS_MULTICAST(packet)) {
         s->regs[GEM_RXMULTICNT]++;
     }
=20
@@ -690,21 +697,21 @@ static int gem_mac_address_filter(CadenceGEMState *s,=
 const uint8_t *packet)
     }
=20
     /* Accept packets -w- hash match? */
-    if ((packet[0] =3D=3D 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HA=
SH)) ||
-        (packet[0] !=3D 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH=
))) {
+    if ((IS_MULTICAST(packet) && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HAS=
H)) ||
+        (IS_UNICAST(packet)   && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HAS=
H))) {
         unsigned hash_index;
=20
         hash_index =3D calc_mac_hash(packet);
         if (hash_index < 32) {
             if (s->regs[GEM_HASHLO] & (1<<hash_index)) {
-                return packet[0] =3D=3D 0x01 ? GEM_RX_MULTICAST_HASH_ACCEP=
T :
-                                           GEM_RX_UNICAST_HASH_ACCEPT;
+                return IS_MULTICAST(packet) ? GEM_RX_MULTICAST_HASH_ACCEPT=
 :
+                                              GEM_RX_UNICAST_HASH_ACCEPT;
             }
         } else {
             hash_index -=3D 32;
             if (s->regs[GEM_HASHHI] & (1<<hash_index)) {
-                return packet[0] =3D=3D 0x01 ? GEM_RX_MULTICAST_HASH_ACCEP=
T :
-                                           GEM_RX_UNICAST_HASH_ACCEPT;
+                return IS_MULTICAST(packet) ? GEM_RX_MULTICAST_HASH_ACCEPT=
 :
+                                              GEM_RX_UNICAST_HASH_ACCEPT;
             }
         }
     }
--=20
2.19.1.windows.1

---------------------------------------------------------------------------=
---------------------------------------------------
-----Original Message-----
From: Edgar E. Iglesias [mailto:edgar.iglesias@gmail.com]=20
Sent: Thursday, November 28, 2019 9:00 PM
To: Wasim, Bilal <Bilal_Wasim@mentor.com>
Cc: qemu-devel@nongnu.org; alistair@alistair23.me; peter.maydell@linaro.org=
; qemu-arm@nongnu.org
Subject: Re: [PATCH] Updating the GEM MAC IP to properly filter out the mul=
ticast addresses

On Thu, Nov 28, 2019 at 03:10:16PM +0000, Wasim, Bilal wrote:
> [PATCH] Updating the GEM MAC IP to properly filter out the multicast=20
> addresses. The current code makes a bad assumption that the=20
> most-significant byte of the MAC address is used to determine if the=20
> address is multicast or unicast, but in reality only a single bit is=20
> used to determine this. This caused IPv6 to not work.. Fix is now in=20
> place and has been tested with
> ZCU102-A53 / IPv6 on a TAP interface. Works well..

Hi Bilal,

The fix looks right to me but I have a few comments.

* Your patch seems a little wrongly formated.
[PATCH] goes into the Subject line for example and you're missing path pref=
ixes.

Do a git log -- hw/net/cadence_gem.c to see examples on how it should look.

* The patch will probably not pass checkpatch since you seem to have long l=
ines.

* We also need to update gem_receive_updatestats() to use the corrected mac=
ros.

More inline:

>=20
> Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
> ---
> hw/net/cadence_gem.c | 18 ++++++++++++------
> 1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index=20
> b8be73d..f8bcbb3 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -315,6 +315,12 @@
>  #define GEM_MODID_VALUE 0x00020118
> +/* IEEE has specified that the most significant bit of the most=20
> +significant byte be used for
> + * distinguishing between Unicast and Multicast addresses.
> + * If its a 1, that means multicast, 0 means unicast.   */
> +#define IS_MULTICAST(address)           (((address[0] & 0x01) =3D=3D 0x0=
1) ? 1 : 0)



This can be simplified:
#define IS_MULTICAST(address) (address[0] & 1)

Actually, looking closer, we already have functions to do these checks in:
include/net/eth.h

static inline int is_multicast_ether_addr(const uint8_t *addr) static inlin=
e int is_broadcast_ether_addr(const uint8_t *addr) static inline int is_uni=
cast_ether_addr(const uint8_t *addr)



> +#define IS_UNICAST(address)             (!IS_MULTICAST(address))
> +
> static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t=20
> *desc) {
>      uint64_t ret =3D desc[0];
> @@ -690,21 +696,21 @@ static int gem_mac_address_filter(CadenceGEMState *=
s, const uint8_t *packet)
>      }
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
> 2.9.3
>=20

