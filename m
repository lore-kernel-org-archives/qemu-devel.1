Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3E5C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 07:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12222077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 07:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12222077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyX73-00026E-Hy
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 03:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1hyWqY-00069W-Pb
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hyWqU-0004I0-Qm
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:40:26 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.79]:36484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hyWpo-0003xR-FG; Fri, 16 Aug 2019 03:39:40 -0400
Received: from tpw09926dag18f.domain1.systemhost.net (10.9.212.26) by
 BWP09926084.bt.com (10.36.82.115) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Fri, 16
 Aug 2019 08:39:17 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18f.domain1.systemhost.net (10.9.212.26) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 16 Aug 2019 08:39:38 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Fri, 16 Aug
 2019 08:39:38 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v7 41/42] target/sparc: Add TLB entry with
 attributes
Thread-Index: AQHVVAXCWvmw8IlXtEyhXVZLY/cOBA==
Date: Fri, 16 Aug 2019 07:39:38 +0000
Message-ID: <1565941177600.7672@bt.com>
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
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.79
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v7 41/42] target/sparc: Add TLB entry with
 attributes
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

Append MemTxAttrs to interfaces so we can pass along up coming Invert
Endian TTE bit on SPARC64.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/mmu_helper.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index cbd1e91..826e14b 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -88,7 +88,7 @@ static const int perm_table[2][8] =3D {
 };

 static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
-                                int *prot, int *access_index,
+                                int *prot, int *access_index, MemTxAttrs *=
attrs,
                                 target_ulong address, int rw, int mmu_idx,
                                 target_ulong *page_size)
 {
@@ -219,6 +219,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, in=
t size,
     target_ulong vaddr;
     target_ulong page_size;
     int error_code =3D 0, prot, access_index;
+    MemTxAttrs attrs =3D {};

     /*
      * TODO: If we ever need tlb_vaddr_to_host for this target,
@@ -229,7 +230,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, in=
t size,
     assert(!probe);

     address &=3D TARGET_PAGE_MASK;
-    error_code =3D get_physical_address(env, &paddr, &prot, &access_index,
+    error_code =3D get_physical_address(env, &paddr, &prot, &access_index,=
 &attrs,
                                       address, access_type,
                                       mmu_idx, &page_size);
     vaddr =3D address;
@@ -490,8 +491,8 @@ static inline int ultrasparc_tag_match(SparcTLBEntry *t=
lb,
     return 0;
 }

-static int get_physical_address_data(CPUSPARCState *env,
-                                     hwaddr *physical, int *prot,
+static int get_physical_address_data(CPUSPARCState *env, hwaddr *physical,
+                                     int *prot, MemTxAttrs *attrs,
                                      target_ulong address, int rw, int mmu=
_idx)
 {
     CPUState *cs =3D env_cpu(env);
@@ -608,8 +609,8 @@ static int get_physical_address_data(CPUSPARCState *env=
,
     return 1;
 }

-static int get_physical_address_code(CPUSPARCState *env,
-                                     hwaddr *physical, int *prot,
+static int get_physical_address_code(CPUSPARCState *env, hwaddr *physical,
+                                     int *prot, MemTxAttrs *attrs,
                                      target_ulong address, int mmu_idx)
 {
     CPUState *cs =3D env_cpu(env);
@@ -686,7 +687,7 @@ static int get_physical_address_code(CPUSPARCState *env=
,
 }

 static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
-                                int *prot, int *access_index,
+                                int *prot, int *access_index, MemTxAttrs *=
attrs,
                                 target_ulong address, int rw, int mmu_idx,
                                 target_ulong *page_size)
 {
@@ -716,11 +717,11 @@ static int get_physical_address(CPUSPARCState *env, h=
waddr *physical,
     }

     if (rw =3D=3D 2) {
-        return get_physical_address_code(env, physical, prot, address,
+        return get_physical_address_code(env, physical, prot, attrs, addre=
ss,
                                          mmu_idx);
     } else {
-        return get_physical_address_data(env, physical, prot, address, rw,
-                                         mmu_idx);
+        return get_physical_address_data(env, physical, prot, attrs, addre=
ss,
+                                         rw, mmu_idx);
     }
 }

@@ -734,10 +735,11 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, =
int size,
     target_ulong vaddr;
     hwaddr paddr;
     target_ulong page_size;
+    MemTxAttrs attrs =3D {};
     int error_code =3D 0, prot, access_index;

     address &=3D TARGET_PAGE_MASK;
-    error_code =3D get_physical_address(env, &paddr, &prot, &access_index,
+    error_code =3D get_physical_address(env, &paddr, &prot, &access_index,=
 &attrs,
                                       address, access_type,
                                       mmu_idx, &page_size);
     if (likely(error_code =3D=3D 0)) {
@@ -747,7 +749,8 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, in=
t size,
                                    env->dmmu.mmu_primary_context,
                                    env->dmmu.mmu_secondary_context);

-        tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, page_size);
+        tlb_set_page_with_attrs(cs, vaddr, paddr, attrs, prot, mmu_idx,
+                                page_size);
         return true;
     }
     if (probe) {
@@ -849,9 +852,10 @@ static int cpu_sparc_get_phys_page(CPUSPARCState *env,=
 hwaddr *phys,
 {
     target_ulong page_size;
     int prot, access_index;
+    MemTxAttrs attrs =3D {};

-    return get_physical_address(env, phys, &prot, &access_index, addr, rw,
-                                mmu_idx, &page_size);
+    return get_physical_address(env, phys, &prot, &access_index, &attrs, a=
ddr,
+                                rw, mmu_idx, &page_size);
 }

 #if defined(TARGET_SPARC64)
--
1.8.3.1

?

