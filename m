Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F247C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F85A218EA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F85A218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpacR-00079w-OO
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 11:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55285)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hpacI-0006eT-0B
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hpacG-00039q-PF
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:52:45 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.236]:41601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hpacA-00032V-LW; Mon, 22 Jul 2019 11:52:38 -0400
Received: from tpw09926dag18h.domain1.systemhost.net (10.9.212.42) by
 RDW083A009ED65.bt.com (10.187.98.35) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 22 Jul 2019 16:48:58 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18h.domain1.systemhost.net (10.9.212.42) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Mon, 22 Jul 2019 16:52:35 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Mon, 22 Jul
 2019 16:52:35 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 18/20] cputlb: Byte swap memory
 transaction attribute
Thread-Index: AQHVQKV7c9bUDlL56U+J3UKnlx1+xw==
Date: Mon, 22 Jul 2019 15:52:35 +0000
Message-ID: <1563810755207.16357@bt.com>
References: <e9c6e5310b1a4863be45d45bf087fc3d@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <e9c6e5310b1a4863be45d45bf087fc3d@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.37]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.236
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v2 18/20] cputlb: Byte swap memory transaction
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, mst@redhat.com,
 palmer@sifive.com, mark.cave-ayland@ilande.co.uk, Alistair.Francis@wdc.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, sw@weilnetz.de, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, david@gibson.dropbear.id.au, qemu-riscv@nongnu.org,
 cohuck@redhat.com, claudio.fontana@huawei.com, alex.williamson@redhat.com,
 qemu-ppc@nongnu.org, amarkovic@wavecomp.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Notice new attribute, byte swap, and force the transaction through the
memory slow path.

Required by architectures that can invert endianness of memory
transaction, e.g. SPARC64 has the Invert Endian TTE bit.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 accel/tcg/cputlb.c      | 11 +++++++++++
 include/exec/memattrs.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6f5262c..619787b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -738,6 +738,9 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulon=
g vaddr,
          */
         address |=3D TLB_RECHECK;
     }
+    if (attrs.byte_swap) {
+        address |=3D TLB_FORCE_SLOW;
+    }
     if (!memory_region_is_ram(section->mr) &&
         !memory_region_is_romd(section->mr)) {
         /* IO memory case */
@@ -891,6 +894,10 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEn=
try *iotlbentry,
     bool locked =3D false;
     MemTxResult r;

+    if (iotlbentry->attrs.byte_swap) {
+        op ^=3D MO_BSWAP;
+    }
+
     section =3D iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs)=
;
     mr =3D section->mr;
     mr_offset =3D (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -933,6 +940,10 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry=
 *iotlbentry,
     bool locked =3D false;
     MemTxResult r;

+    if (iotlbentry->attrs.byte_swap) {
+        op ^=3D MO_BSWAP;
+    }
+
     section =3D iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs)=
;
     mr =3D section->mr;
     mr_offset =3D (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index d4a3477..a0644eb 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -37,6 +37,8 @@ typedef struct MemTxAttrs {
     unsigned int user:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
+    /* SPARC64: TTE invert endianness */
+    unsigned int byte_swap:1;
     /*
      * The following are target-specific page-table bits.  These are not
      * related to actual memory transactions at all.  However, this struct=
ure
--
1.8.3.1



