Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD102C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 06:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829D520818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 06:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829D520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hndAg-0005KD-Oc
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 02:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32996)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hndAW-0004vc-US
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hndAV-0007ro-TP
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:12:00 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.235]:6435)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1hndAV-0007qb-Jf
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:11:59 -0400
Received: from tpw09926dag18f.domain1.systemhost.net (10.9.212.26) by
 RDW083A011ED67.bt.com (10.187.98.37) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 17 Jul 2019 07:13:02 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18f.domain1.systemhost.net (10.9.212.26) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 17 Jul 2019 07:08:12 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Wed, 17 Jul
 2019 07:08:12 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel]  [PATCH 3/4] cputlb: Byte swap memory transaction
 attribute
Thread-Index: AQHVPGYDzYgOtqpKbEi5mnjK931vog==
Date: Wed, 17 Jul 2019 06:08:12 +0000
Message-ID: <1563343691021.27469@bt.com>
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
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.235
Subject: [Qemu-devel] [PATCH 3/4] cputlb: Byte swap memory transaction
 attribute
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

Notice new attribute, byte swap, and force the transaction through the=0A=
memory slow path.=0A=
=0A=
Required by architectures that can invert endianness of memory=0A=
transaction, e.g. SPARC64 has the Invert Endian TTE bit.=0A=
=0A=
Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>=0A=
---=0A=
 accel/tcg/cputlb.c      | 10 +++++++++-=0A=
 include/exec/memattrs.h |  2 ++=0A=
 2 files changed, 11 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c=0A=
index baa61719ad..11debb7dda 100644=0A=
--- a/accel/tcg/cputlb.c=0A=
+++ b/accel/tcg/cputlb.c=0A=
@@ -731,7 +731,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulon=
g vaddr,=0A=
               vaddr, paddr, prot, mmu_idx);=0A=
 =0A=
     address =3D vaddr_page;=0A=
-    if (size < TARGET_PAGE_SIZE) {=0A=
+    if (size < TARGET_PAGE_SIZE || attrs.byte_swap) {=0A=
         /*=0A=
          * Slow-path the TLB entries; we will repeat the MMU check and TLB=
=0A=
          * fill on every access.=0A=
@@ -891,6 +891,10 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEn=
try *iotlbentry,=0A=
     bool locked =3D false;=0A=
     MemTxResult r;=0A=
 =0A=
+    if (iotlbentry->attrs.byte_swap) {=0A=
+        op ^=3D MO_BSWAP;=0A=
+    }=0A=
+=0A=
     section =3D iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs)=
;=0A=
     mr =3D section->mr;=0A=
     mr_offset =3D (iotlbentry->addr & TARGET_PAGE_MASK) + addr;=0A=
@@ -933,6 +937,10 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry=
 *iotlbentry,=0A=
     bool locked =3D false;=0A=
     MemTxResult r;=0A=
 =0A=
+    if (iotlbentry->attrs.byte_swap) {=0A=
+        op ^=3D MO_BSWAP;=0A=
+    }=0A=
+=0A=
     section =3D iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs)=
;=0A=
     mr =3D section->mr;=0A=
     mr_offset =3D (iotlbentry->addr & TARGET_PAGE_MASK) + addr;=0A=
diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h=0A=
index d4a3477d71..a0644ebba1 100644=0A=
--- a/include/exec/memattrs.h=0A=
+++ b/include/exec/memattrs.h=0A=
@@ -37,6 +37,8 @@ typedef struct MemTxAttrs {=0A=
     unsigned int user:1;=0A=
     /* Requester ID (for MSI for example) */=0A=
     unsigned int requester_id:16;=0A=
+    /* SPARC64: TTE invert endianness */=0A=
+    unsigned int byte_swap:1;=0A=
     /*=0A=
      * The following are target-specific page-table bits.  These are not=
=0A=
      * related to actual memory transactions at all.  However, this struct=
ure=0A=
-- =0A=
2.17.2=0A=

