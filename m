Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806F7C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 06:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F81320818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 06:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F81320818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnd9I-0004Oj-AQ
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 02:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60817)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hnd98-00040j-Ah
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hnd97-0007BW-16
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:10:34 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.79]:46839)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1hnd96-0007Av-Os
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:10:32 -0400
Received: from tpw09926dag18h.domain1.systemhost.net (10.9.212.42) by
 BWP09926084.bt.com (10.36.82.115) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Wed, 17
 Jul 2019 07:10:55 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18h.domain1.systemhost.net (10.9.212.42) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 17 Jul 2019 07:10:30 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Wed, 17 Jul
 2019 07:10:30 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 4/4] target/sparc: sun4u Invert Endian TTE
 bit
Thread-Index: AQHVPGZVYXEFmvoBG06hkPHWQOD+Rg==
Date: Wed, 17 Jul 2019 06:10:30 +0000
Message-ID: <1563343829014.86755@bt.com>
References: <a5f7f8854af046c18c6342035662a193@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <a5f7f8854af046c18c6342035662a193@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.79
Subject: [Qemu-devel] [PATCH 4/4] target/sparc: sun4u Invert Endian TTE bit
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
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This bit configures endianness of PCI MMIO devices. It is used by=0A=
Solaris and OpenBSD sunhme drivers.=0A=
=0A=
Tested working on OpenBSD.=0A=
=0A=
Unfortunately Solaris 10 had a unrelated keyboard issue blocking=0A=
testing... another inch towards Solaris 10 on SPARC64 =3D)=0A=
=0A=
Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>=0A=
---=0A=
 target/sparc/cpu.h        |  2 ++=0A=
 target/sparc/mmu_helper.c | 41 +++++++++++++++++++++++++++------------=0A=
 2 files changed, 31 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h=0A=
index 8ed2250cd0..77e8e07194 100644=0A=
--- a/target/sparc/cpu.h=0A=
+++ b/target/sparc/cpu.h=0A=
@@ -277,6 +277,7 @@ enum {=0A=
 =0A=
 #define TTE_VALID_BIT       (1ULL << 63)=0A=
 #define TTE_NFO_BIT         (1ULL << 60)=0A=
+#define TTE_IE_BIT          (1ULL << 59)=0A=
 #define TTE_USED_BIT        (1ULL << 41)=0A=
 #define TTE_LOCKED_BIT      (1ULL <<  6)=0A=
 #define TTE_SIDEEFFECT_BIT  (1ULL <<  3)=0A=
@@ -293,6 +294,7 @@ enum {=0A=
 =0A=
 #define TTE_IS_VALID(tte)   ((tte) & TTE_VALID_BIT)=0A=
 #define TTE_IS_NFO(tte)     ((tte) & TTE_NFO_BIT)=0A=
+#define TTE_IS_IE(tte)      ((tte) & TTE_IE_BIT)=0A=
 #define TTE_IS_USED(tte)    ((tte) & TTE_USED_BIT)=0A=
 #define TTE_IS_LOCKED(tte)  ((tte) & TTE_LOCKED_BIT)=0A=
 #define TTE_IS_SIDEEFFECT(tte) ((tte) & TTE_SIDEEFFECT_BIT)=0A=
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c=0A=
index cbd1e91179..f7b97d1e46 100644=0A=
--- a/target/sparc/mmu_helper.c=0A=
+++ b/target/sparc/mmu_helper.c=0A=
@@ -492,7 +492,8 @@ static inline int ultrasparc_tag_match(SparcTLBEntry *t=
lb,=0A=
 =0A=
 static int get_physical_address_data(CPUSPARCState *env,=0A=
                                      hwaddr *physical, int *prot,=0A=
-                                     target_ulong address, int rw, int mmu=
_idx)=0A=
+                                     MemTxAttrs *attrs, target_ulong addre=
ss,=0A=
+                                     int rw, int mmu_idx)=0A=
 {=0A=
     CPUState *cs =3D env_cpu(env);=0A=
     unsigned int i;=0A=
@@ -536,6 +537,10 @@ static int get_physical_address_data(CPUSPARCState *en=
v,=0A=
         if (ultrasparc_tag_match(&env->dtlb[i], address, context, physical=
)) {=0A=
             int do_fault =3D 0;=0A=
 =0A=
+            if (TTE_IS_IE(env->dtlb[i].tte)) {=0A=
+                attrs->byte_swap =3D true;=0A=
+            }=0A=
+=0A=
             /* access ok? */=0A=
             /* multiple bits in SFSR.FT may be set on TT_DFAULT */=0A=
             if (TTE_IS_PRIV(env->dtlb[i].tte) && is_user) {=0A=
@@ -686,7 +691,7 @@ static int get_physical_address_code(CPUSPARCState *env=
,=0A=
 }=0A=
 =0A=
 static int get_physical_address(CPUSPARCState *env, hwaddr *physical,=0A=
-                                int *prot, int *access_index,=0A=
+                                int *prot, MemTxAttrs *attrs,=0A=
                                 target_ulong address, int rw, int mmu_idx,=
=0A=
                                 target_ulong *page_size)=0A=
 {=0A=
@@ -716,11 +721,12 @@ static int get_physical_address(CPUSPARCState *env, h=
waddr *physical,=0A=
     }=0A=
 =0A=
     if (rw =3D=3D 2) {=0A=
+        *attrs =3D MEMTXATTRS_UNSPECIFIED;=0A=
         return get_physical_address_code(env, physical, prot, address,=0A=
                                          mmu_idx);=0A=
     } else {=0A=
-        return get_physical_address_data(env, physical, prot, address, rw,=
=0A=
-                                         mmu_idx);=0A=
+        return get_physical_address_data(env, physical, prot, attrs, addre=
ss,=0A=
+                                         rw, mmu_idx);=0A=
     }=0A=
 }=0A=
 =0A=
@@ -734,10 +740,11 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, =
int size,=0A=
     target_ulong vaddr;=0A=
     hwaddr paddr;=0A=
     target_ulong page_size;=0A=
-    int error_code =3D 0, prot, access_index;=0A=
+    MemTxAttrs attrs =3D {};=0A=
+    int error_code =3D 0, prot;=0A=
 =0A=
     address &=3D TARGET_PAGE_MASK;=0A=
-    error_code =3D get_physical_address(env, &paddr, &prot, &access_index,=
=0A=
+    error_code =3D get_physical_address(env, &paddr, &prot, &attrs,=0A=
                                       address, access_type,=0A=
                                       mmu_idx, &page_size);=0A=
     if (likely(error_code =3D=3D 0)) {=0A=
@@ -747,7 +754,8 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, in=
t size,=0A=
                                    env->dmmu.mmu_primary_context,=0A=
                                    env->dmmu.mmu_secondary_context);=0A=
 =0A=
-        tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, page_size);=0A=
+        tlb_set_page_with_attrs(cs, vaddr, paddr, attrs, prot, mmu_idx,=0A=
+                                page_size);=0A=
         return true;=0A=
     }=0A=
     if (probe) {=0A=
@@ -789,7 +797,7 @@ void dump_mmu(CPUSPARCState *env)=0A=
             }=0A=
             if (TTE_IS_VALID(env->dtlb[i].tte)) {=0A=
                 qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"=0A=
-                            ", %s, %s, %s, %s, ctx %" PRId64 " %s\n",=0A=
+                            ", %s, %s, %s, %s, ie %s, ctx %" PRId64 " %s\n=
",=0A=
                             i,=0A=
                             env->dtlb[i].tag & (uint64_t)~0x1fffULL,=0A=
                             TTE_PA(env->dtlb[i].tte),=0A=
@@ -798,6 +806,8 @@ void dump_mmu(CPUSPARCState *env)=0A=
                             TTE_IS_W_OK(env->dtlb[i].tte) ? "RW" : "RO",=
=0A=
                             TTE_IS_LOCKED(env->dtlb[i].tte) ?=0A=
                             "locked" : "unlocked",=0A=
+                            TTE_IS_IE(env->dtlb[i].tte) ?=0A=
+                            "yes" : "no",=0A=
                             env->dtlb[i].tag & (uint64_t)0x1fffULL,=0A=
                             TTE_IS_GLOBAL(env->dtlb[i].tte) ?=0A=
                             "global" : "local");=0A=
@@ -848,13 +858,20 @@ static int cpu_sparc_get_phys_page(CPUSPARCState *env=
, hwaddr *phys,=0A=
                                    target_ulong addr, int rw, int mmu_idx)=
=0A=
 {=0A=
     target_ulong page_size;=0A=
-    int prot, access_index;=0A=
+    int prot;=0A=
 =0A=
-    return get_physical_address(env, phys, &prot, &access_index, addr, rw,=
=0A=
-                                mmu_idx, &page_size);=0A=
+#ifdef TARGET_SPARC64=0A=
+    MemTxAttrs attrs =3D {};=0A=
+    return get_physical_address(env, phys, &prot, &attrs,=0A=
+                                addr, rw, mmu_idx, &page_size);=0A=
+#else=0A=
+    int access_index;=0A=
+    return get_physical_address(env, phys, &prot, &access_index,=0A=
+                                addr, rw, mmu_idx, &page_size);=0A=
+#endif /* TARGET_SPARC64 */=0A=
 }=0A=
 =0A=
-#if defined(TARGET_SPARC64)=0A=
+#ifdef TARGET_SPARC64=0A=
 hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,=0A=
                                            int mmu_idx)=0A=
 {=0A=
-- =0A=
2.17.2=0A=

