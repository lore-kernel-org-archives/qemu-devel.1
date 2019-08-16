Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0BEC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 08:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745032077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 08:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745032077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyXDO-0002n1-9N
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 04:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1hyWlq-0000TX-83
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hyWlm-0001Xx-Hw
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:35:34 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.235]:51437)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hyWlL-0001Ek-QA; Fri, 16 Aug 2019 03:35:04 -0400
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 RDW083A011ED67.bt.com (10.187.98.37) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 16 Aug 2019 08:40:57 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18e.domain1.systemhost.net (10.9.212.18) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 16 Aug 2019 08:35:00 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Fri, 16 Aug
 2019 08:35:00 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v7 26/42] hw/net: Declare device little or
 big endian
Thread-Index: AQHVVAUcPICP1n2ya0Cx6fWxt6l8Gg==
Date: Fri, 16 Aug 2019 07:35:00 +0000
Message-ID: <1565940899704.36138@bt.com>
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.40]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.235
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v7 26/42] hw/net: Declare device little or big
 endian
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
Cc: frederic.konrad@adacore.com, berto@igalia.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, lersek@redhat.com,
 jasowang@redhat.com, jiri@resnulli.us, ehabkost@redhat.com,
 b.galvani@gmail.com, eric.auger@redhat.com, alex.williamson@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 andrew@aj.id.au, claudio.fontana@suse.com, crwulff@gmail.com,
 laurent@vivier.eu, sundeep.lkml@gmail.com, michael@walle.cc,
 qemu-ppc@nongnu.org, kbastian@mail.uni-paderborn.de, imammedo@redhat.com,
 fam@euphon.net, peter.maydell@linaro.org, david@redhat.com, palmer@sifive.com,
 keith.busch@intel.com, jcmvbkbc@gmail.com, hare@suse.com,
 sstabellini@kernel.org, andrew.smirnov@gmail.com, deller@gmx.de,
 magnus.damm@gmail.com, atar4qemu@gmail.com, minyard@acm.org, sw@weilnetz.de,
 yuval.shaia@oracle.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 jan.kiszka@web.de, clg@kaod.org, shorne@gmail.com, qemu-riscv@nongnu.org,
 i.mitsyanko@gmail.com, cohuck@redhat.com, philmd@redhat.com,
 amarkovic@wavecomp.com, peter.chubb@nicta.com.au, aurelien@aurel32.net,
 pburton@wavecomp.com, sagark@eecs.berkeley.edu, green@moxielogic.com,
 kraxel@redhat.com, edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn,
 robh@kernel.org, borntraeger@de.ibm.com, joel@jms.id.au,
 antonynpavlov@gmail.com, chouteau@adacore.com, Andrew.Baumann@microsoft.com,
 mreitz@redhat.com, walling@linux.ibm.com, dmitry.fleytman@gmail.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, jslaby@suse.cz, marex@denx.de,
 proljc@gmail.com, marcandre.lureau@redhat.com, alistair@alistair23.me,
 paul.durrant@citrix.com, david@gibson.dropbear.id.au,
 xiaoguangrong.eric@gmail.com, huth@tuxfamily.org, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For each device declared with DEVICE_NATIVE_ENDIAN, find the set of
targets from the set of target/hw/*/device.o.

If the set of targets are all little or all big endian, re-declare
the device endianness as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN
respectively.

This *naive* deduction may result in genuinely native endian devices
being incorrectly declared as little or big endian, but should not
introduce regressions for current targets.

These devices should be re-declared as DEVICE_NATIVE_ENDIAN if 1) it
has a new target with an opposite endian or 2) someone informed knows
better =3D)

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 hw/net/allwinner_emac.c | 2 +-
 hw/net/imx_fec.c        | 2 +-
 hw/net/lan9118.c        | 4 ++--
 hw/net/lance.c          | 2 +-
 hw/net/smc91c111.c      | 2 +-
 hw/net/stellaris_enet.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index eecda52..97e22e7 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -418,7 +418,7 @@ static void aw_emac_set_link(NetClientState *nc)
 static const MemoryRegionOps aw_emac_mem_ops =3D {
     .read =3D aw_emac_read,
     .write =3D aw_emac_write,
-    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
     .valid =3D {
         .min_access_size =3D 4,
         .max_access_size =3D 4,
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 404154e..76d42c8 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1278,7 +1278,7 @@ static const MemoryRegionOps imx_eth_ops =3D {
     .write                 =3D imx_eth_write,
     .valid.min_access_size =3D 4,
     .valid.max_access_size =3D 4,
-    .endianness            =3D DEVICE_NATIVE_ENDIAN,
+    .endianness            =3D DEVICE_LITTLE_ENDIAN,
 };

 static void imx_eth_cleanup(NetClientState *nc)
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index f6120be..bb1bbb3 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -1304,13 +1304,13 @@ static uint64_t lan9118_16bit_mode_read(void *opaqu=
e, hwaddr offset,
 static const MemoryRegionOps lan9118_mem_ops =3D {
     .read =3D lan9118_readl,
     .write =3D lan9118_writel,
-    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
 };

 static const MemoryRegionOps lan9118_16bit_mem_ops =3D {
     .read =3D lan9118_16bit_mode_read,
     .write =3D lan9118_16bit_mode_write,
-    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
 };

 static NetClientInfo net_lan9118_info =3D {
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 2978c01..d95f170 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -74,7 +74,7 @@ static uint64_t lance_mem_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps lance_mem_ops =3D {
     .read =3D lance_mem_read,
     .write =3D lance_mem_write,
-    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .endianness =3D DEVICE_BIG_ENDIAN,
     .valid =3D {
         .min_access_size =3D 2,
         .max_access_size =3D 2,
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 4a612ee..49e4bf5 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -757,7 +757,7 @@ static const MemoryRegionOps smc91c111_mem_ops =3D {
     .write =3D smc91c111_writefn,
     .valid.min_access_size =3D 1,
     .valid.max_access_size =3D 4,
-    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
 };

 static NetClientInfo net_smc91c111_info =3D {
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 2f645bf..15ec227 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -456,7 +456,7 @@ static void stellaris_enet_write(void *opaque, hwaddr o=
ffset,
 static const MemoryRegionOps stellaris_enet_ops =3D {
     .read =3D stellaris_enet_read,
     .write =3D stellaris_enet_write,
-    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
 };

 static void stellaris_enet_reset(DeviceState *dev)
--
1.8.3.1

?

