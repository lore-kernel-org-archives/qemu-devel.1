Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBB2C19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CD9229F5
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CD9229F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvHQa-00084R-OM
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 04:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44936)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hvHMB-0007Tu-Ue
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hvHM8-00027b-CL
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:31:39 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.76]:6992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hvHLL-0001jx-RY; Wed, 07 Aug 2019 04:30:48 -0400
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 BWP09926081.bt.com (10.36.82.112) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Wed, 7 Aug
 2019 09:30:24 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18e.domain1.systemhost.net (10.9.212.18) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 7 Aug 2019 09:30:45 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Wed, 7 Aug 2019
 09:30:45 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v6 14/26] exec: Hard code size with
 MO_{8|16|32|64}
Thread-Index: AQHVTPpoMuuROMAgcEKe8DxLFbduJw==
Date: Wed, 7 Aug 2019 08:30:45 +0000
Message-ID: <1565166644883.25395@bt.com>
References: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.44]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.76
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v6 14/26] exec: Hard code size with
 MO_{8|16|32|64}
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 cohuck@redhat.com, sagark@eecs.berkeley.edu, david@redhat.com,
 jasowang@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 i.mitsyanko@gmail.com, keith.busch@intel.com, jcmvbkbc@gmail.com,
 frederic.konrad@adacore.com, dmitry.fleytman@gmail.com, kraxel@redhat.com,
 edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn, pburton@wavecomp.com,
 xiaoguangrong.eric@gmail.com, peter.chubb@nicta.com.au, philmd@redhat.com,
 robh@kernel.org, hare@suse.com, sstabellini@kernel.org, berto@igalia.com,
 chouteau@adacore.com, qemu-block@nongnu.org, arikalo@wavecomp.com,
 jslaby@suse.cz, deller@gmx.de, mst@redhat.com, magnus.damm@gmail.com,
 jcd@tribudubois.net, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 mreitz@redhat.com, hpoussin@reactos.org, joel@jms.id.au,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org,
 david@gibson.dropbear.id.au, lersek@redhat.com, green@moxielogic.com,
 atar4qemu@gmail.com, antonynpavlov@gmail.com, marex@denx.de, jiri@resnulli.us,
 ehabkost@redhat.com, minyard@acm.org, qemu-s390x@nongnu.org, sw@weilnetz.de,
 alistair@alistair23.me, yuval.shaia@oracle.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 jan.kiszka@web.de, clg@kaod.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, shorne@gmail.com, jsnow@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, qemu-riscv@nongnu.org, proljc@gmail.com,
 pbonzini@redhat.com, andrew@aj.id.au, kbastian@mail.uni-paderborn.de,
 crwulff@gmail.com, laurent@vivier.eu, Andrew.Baumann@microsoft.com,
 sundeep.lkml@gmail.com, andrew.smirnov@gmail.com, michael@walle.cc,
 paul.durrant@citrix.com, qemu-ppc@nongnu.org, huth@tuxfamily.org,
 amarkovic@wavecomp.com, imammedo@redhat.com, aurelien@aurel32.net,
 stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Temporarily no-op size_memop was introduced to aid the conversion of
memory_region_dispatch_{read|write} operand "unsigned size" into
"MemOp op".

Now size_memop is implemented, again hard coded size but with
MO_{8|16|32|64}. This is more expressive and avoid size_memop calls.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 memory_ldst.inc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index 1e8a2fc..de658c4 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -38,7 +38,7 @@ static inline uint32_t glue(address_space_ldl_internal, S=
UFFIX)(ARG1_DECL,
         release_lock |=3D prepare_mmio_access(mr);

         /* I/O case */
-        r =3D memory_region_dispatch_read(mr, addr1, &val, size_memop(4), =
attrs);
+        r =3D memory_region_dispatch_read(mr, addr1, &val, MO_32, attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian =3D=3D DEVICE_LITTLE_ENDIAN) {
             val =3D bswap32(val);
@@ -114,7 +114,7 @@ static inline uint64_t glue(address_space_ldq_internal,=
 SUFFIX)(ARG1_DECL,
         release_lock |=3D prepare_mmio_access(mr);

         /* I/O case */
-        r =3D memory_region_dispatch_read(mr, addr1, &val, size_memop(8), =
attrs);
+        r =3D memory_region_dispatch_read(mr, addr1, &val, MO_64, attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian =3D=3D DEVICE_LITTLE_ENDIAN) {
             val =3D bswap64(val);
@@ -188,7 +188,7 @@ uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
         release_lock |=3D prepare_mmio_access(mr);

         /* I/O case */
-        r =3D memory_region_dispatch_read(mr, addr1, &val, size_memop(1), =
attrs);
+        r =3D memory_region_dispatch_read(mr, addr1, &val, MO_8, attrs);
     } else {
         /* RAM case */
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -224,7 +224,7 @@ static inline uint32_t glue(address_space_lduw_internal=
, SUFFIX)(ARG1_DECL,
         release_lock |=3D prepare_mmio_access(mr);

         /* I/O case */
-        r =3D memory_region_dispatch_read(mr, addr1, &val, size_memop(2), =
attrs);
+        r =3D memory_region_dispatch_read(mr, addr1, &val, MO_16, attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian =3D=3D DEVICE_LITTLE_ENDIAN) {
             val =3D bswap16(val);
@@ -300,7 +300,7 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL=
,
     if (l < 4 || !memory_access_is_direct(mr, true)) {
         release_lock |=3D prepare_mmio_access(mr);

-        r =3D memory_region_dispatch_write(mr, addr1, val, size_memop(4), =
attrs);
+        r =3D memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);
     } else {
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
         stl_p(ptr, val);
@@ -346,7 +346,7 @@ static inline void glue(address_space_stl_internal, SUF=
FIX)(ARG1_DECL,
             val =3D bswap32(val);
         }
 #endif
-        r =3D memory_region_dispatch_write(mr, addr1, val, size_memop(4), =
attrs);
+        r =3D memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);
     } else {
         /* RAM case */
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -408,7 +408,7 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     mr =3D TRANSLATE(addr, &addr1, &l, true, attrs);
     if (!memory_access_is_direct(mr, true)) {
         release_lock |=3D prepare_mmio_access(mr);
-        r =3D memory_region_dispatch_write(mr, addr1, val, size_memop(1), =
attrs);
+        r =3D memory_region_dispatch_write(mr, addr1, val, MO_8, attrs);
     } else {
         /* RAM case */
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -451,7 +451,7 @@ static inline void glue(address_space_stw_internal, SUF=
FIX)(ARG1_DECL,
             val =3D bswap16(val);
         }
 #endif
-        r =3D memory_region_dispatch_write(mr, addr1, val, size_memop(2), =
attrs);
+        r =3D memory_region_dispatch_write(mr, addr1, val, MO_16, attrs);
     } else {
         /* RAM case */
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -524,7 +524,7 @@ static void glue(address_space_stq_internal, SUFFIX)(AR=
G1_DECL,
             val =3D bswap64(val);
         }
 #endif
-        r =3D memory_region_dispatch_write(mr, addr1, val, size_memop(8), =
attrs);
+        r =3D memory_region_dispatch_write(mr, addr1, val, MO_64, attrs);
     } else {
         /* RAM case */
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
--
1.8.3.1

?

