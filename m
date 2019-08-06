Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB82C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 17:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9942F214C6
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 17:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DZzu+CVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9942F214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2tW-0004Dj-V4
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 13:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51022)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jk-0004E2-7f
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2ji-0003uT-Et
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:55:00 -0400
Received: from mail-eopbgr810057.outbound.protection.outlook.com
 ([40.107.81.57]:52144 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hv2ji-0003qo-6L
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbh0I40dpwQta0NVyed+/ZJZYZFFj+3ST/La7IrTJENe9N0RO5pSEZiyHs6lSauNbSsPJonxCqbPCtHEDr7HRTlzw/mRfZ8DvMIbX8VWW6x+J6RiCFUgw0hQ9gr7N5yzKffu2ieAF5eZcgIj+2NmLHKW7Ilm8nDcvBPSbF/0sIqhHIu6oOkBYxHrsZyCofnUZWtEBVzRdypg4gpzSEIjfmdaZJzdmd+tj9p+3HtHXRAY9dSeiM5fY/9mVAvAYlCy6mSrc7RakJRJzOcUUtsAEabK+v9S4PrR8S1mQUJit1bfjpZbfTQK+slC2zgdsaxhgx10dLbfjsGyzYT1WUnBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p67RJbxFBdSqvDR3K9CPuHWJSkf7t4l7WBDZwvN1B6Q=;
 b=b/dyNBJmqThaJnLwJOoLPQBSkFRGfoiXkL0n3XuKTeLzQGaj963ASly3KU0rcw5gK4DSwnch2szpUH7VU0DJW0McRBHcmprvBcsXZW8Xwjedd9o4bgHDI8qJjv8FHNJxSfcUu0QXrI8Me3uRAiNUgMGWgp9QeOLUKtxEWDc294RcghU1tAU5VTy9g//bb1uX7DR4viPNRmUztWasyE6GKFcS3o5bxz2eXqZP0SYrEP81LqgHINDZXN8WZfSstCB2h8m1Z3rCSA+CQEv4b4j/hhG1Gx4qqmlwk+sPRossqyyWmGgGfsrFwBUx4/0AexoIh8cjnQdbN3Nu9l8/lnM0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p67RJbxFBdSqvDR3K9CPuHWJSkf7t4l7WBDZwvN1B6Q=;
 b=DZzu+CVjJC86D5NMV52sumYW5nBIcmv5HKopLQeQkVlU1gyFqmXFNpNp2bzR2z9i1XNVCjqTJEOcYsPaB2iajkiyX8GM8dER3i0digFxcxKMGL4qADuJw1o0Imd3ebYmXJ+ZE8PczzOzWLd9IigL8XSpPecP76O9tNHRNRer+9U=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB2891.namprd12.prod.outlook.com (20.179.71.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Tue, 6 Aug 2019 16:54:56 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 16:54:56 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 12/14] kvm: add support to sync the page encryption
 state bitmap
Thread-Index: AQHVTHesgM1MTpxCT0yv0eSIWJm4aw==
Date: Tue, 6 Aug 2019 16:54:56 +0000
Message-ID: <20190806165429.19327-13-brijesh.singh@amd.com>
References: <20190806165429.19327-1-brijesh.singh@amd.com>
In-Reply-To: <20190806165429.19327-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0027.namprd07.prod.outlook.com
 (2603:10b6:803:2d::13) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:42::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27f6b8a8-5a54-41b4-c3bb-08d71a8ecf21
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB2891; 
x-ms-traffictypediagnostic: DM6PR12MB2891:
x-microsoft-antispam-prvs: <DM6PR12MB2891DCA28211F33E4DEA5B79E5D50@DM6PR12MB2891.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6116002)(3846002)(2906002)(6436002)(50226002)(54906003)(316002)(8676002)(81156014)(86362001)(81166006)(5640700003)(99286004)(76176011)(52116002)(6486002)(386003)(102836004)(71200400001)(71190400001)(2616005)(2501003)(476003)(8936002)(14444005)(11346002)(26005)(66066001)(256004)(6506007)(2351001)(446003)(186003)(486006)(6512007)(66556008)(478600001)(30864003)(66476007)(64756008)(66946007)(7736002)(53936002)(1076003)(66446008)(6916009)(5660300002)(36756003)(68736007)(25786009)(4326008)(305945005)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2891;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f4X/rAaRCwPNqqKcZmi3aGAuwL/Cw/H92imCdr4tG0Osjq7KfqIF5lLUpO2Ulaqa0+ikpz3yjbFpPmJybPPiUYnI9qvGObmR2EmMJRNUKQrqFBE34qrROc2Udtbu9uLMB5WMDngiMB1nxW/aMpFO9n2zPzA5w4Z0BhZmmcbzWCv33OO8z9lGmEeKe84HnVRbrer2bf/FdutLEKEtPJ0iT1CVjRA6Q9sL1WI7BlW1R4i6HOx5vhj08UTr/9ezZQHB4z8QYOhifrscbTfb3AnXxeTUGDp5I8hbgwqRHIltS4PfZqaGE1zcVipsrVXjo1bmtEP4HjFg6MY5iDYCttnpR9MQ1IfDYRK2rRARmCwt6v6ATzLnq4ei68ZbqkMLDZQOlauf5IdkSzrTghSUH+Tf4gGBS04vqkbD/7jtfa69Jew=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f6b8a8-5a54-41b4-c3bb-08d71a8ecf21
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:54:56.1637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.57
Subject: [Qemu-devel] [PATCH v3 12/14] kvm: add support to sync the page
 encryption state bitmap
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SEV VMs have concept of private and shared memory. The private memory
is encrypted with guest-specific key, while shared memory may be encrypted
with hyperivosr key. The KVM_GET_PAGE_ENC_BITMAP can be used to get a
bitmap indicating whether the guest page is private or shared. A private
page must be transmitted using the SEV migration commands.

Add a cpu_physical_memory_sync_encrypted_bitmap() which can be used to get
the page encryption bitmap for a given memory region.

The page encryption bitmap is not exactly same as dirty bitmap. The page
encryption bitmap is a purely a matter of state about the page is encrypted
or not. To avoid some confusion we clone few functions for clarity.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/kvm-all.c     |  37 ++++++++
 include/exec/ram_addr.h | 199 ++++++++++++++++++++++++++++++++++++++++
 include/exec/ramlist.h  |   3 +-
 migration/ram.c         |  17 ++++
 4 files changed, 255 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f4d136b022..d942e10896 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -560,6 +560,36 @@ static int kvm_get_dirty_pages_log_range(MemoryRegionS=
ection *section,
=20
 #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
=20
+/* sync page_enc bitmap */
+static int kvm_sync_page_enc_bitmap(KVMMemoryListener *kml,
+                                    MemoryRegionSection *section,
+                                    KVMSlot *mem)
+{
+    unsigned long size;
+    KVMState *s =3D kvm_state;
+    struct kvm_page_enc_bitmap e =3D {};
+    ram_addr_t pages =3D int128_get64(section->size) / getpagesize();
+    ram_addr_t start =3D section->offset_within_region +
+                       memory_region_get_ram_addr(section->mr);
+
+    size =3D ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS), 64) / 8;
+    e.enc_bitmap =3D g_malloc0(size);
+    e.start_gfn =3D mem->start_addr >> TARGET_PAGE_BITS;
+    e.num_pages =3D pages;
+    if (kvm_vm_ioctl(s, KVM_GET_PAGE_ENC_BITMAP, &e) =3D=3D -1) {
+        DPRINTF("KVM_GET_PAGE_ENC_BITMAP ioctl failed %d\n", errno);
+        g_free(e.enc_bitmap);
+        return 1;
+    }
+
+    cpu_physical_memory_set_encrypted_lebitmap(e.enc_bitmap,
+                                               start, pages);
+
+    g_free(e.enc_bitmap);
+
+    return 0;
+}
+
 /**
  * kvm_physical_sync_dirty_bitmap - Sync dirty bitmap from kernel space
  *
@@ -616,6 +646,13 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryLis=
tener *kml,
         }
=20
         kvm_get_dirty_pages_log_range(section, d.dirty_bitmap);
+
+        if (kvm_memcrypt_enabled() &&
+            kvm_sync_page_enc_bitmap(kml, section, mem)) {
+            g_free(d.dirty_bitmap);
+            return -1;
+        }
+
     }
 out:
     return ret;
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index b7b2e60ff6..6dbeac6567 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -67,6 +67,8 @@ struct RAMBlock {
      */
     unsigned long *clear_bmap;
     uint8_t clear_bmap_shift;
+    /* bitmap of page encryption state for an encrypted guest */
+    unsigned long *encbmap;
 };
=20
 /**
@@ -323,6 +325,60 @@ static inline void cpu_physical_memory_set_dirty_flag(=
ram_addr_t addr,
     rcu_read_unlock();
 }
=20
+static inline void cpu_physical_memory_set_encrypted_range(ram_addr_t star=
t,
+                                                           ram_addr_t leng=
th,
+                                                           unsigned long v=
al)
+{
+    unsigned long page;
+    unsigned long * const *src;
+
+    page =3D start >> TARGET_PAGE_BITS;
+
+    rcu_read_lock();
+
+    src =3D atomic_rcu_read(
+            &ram_list.dirty_memory[DIRTY_MEMORY_ENCRYPTED])->blocks;
+
+    if (length) {
+        unsigned long idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
+        unsigned long offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
+        int m =3D (start) & (BITS_PER_LONG - 1);
+        int n =3D MIN(length, BITS_PER_LONG - m);
+        unsigned long old_val =3D atomic_read(&src[idx][BIT_WORD(offset)])=
;
+        unsigned long mask;
+
+        mask =3D (~0UL >> n);
+        mask =3D mask << m;
+
+        old_val &=3D ~mask;
+        val &=3D mask;
+
+        atomic_xchg(&src[idx][BIT_WORD(offset)], old_val | val);
+        page +=3D n;
+        length -=3D n;
+    }
+
+    /* remaining bits */
+    if (length) {
+        unsigned long idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
+        unsigned long offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
+        int m =3D (start) & (BITS_PER_LONG - 1);
+        int n =3D MIN(length, BITS_PER_LONG - m);
+        unsigned long old_val =3D atomic_read(&src[idx][BIT_WORD(offset)])=
;
+        unsigned long mask;
+
+        mask =3D (~0UL >> n);
+        mask =3D mask << m;
+
+        old_val &=3D ~mask;
+        val &=3D mask;
+
+        atomic_xchg(&src[idx][BIT_WORD(offset)], old_val | val);
+    }
+
+    rcu_read_unlock();
+}
+
 static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
                                                        ram_addr_t length,
                                                        uint8_t mask)
@@ -376,6 +432,62 @@ static inline void cpu_physical_memory_set_dirty_range=
(ram_addr_t start,
 }
=20
 #if !defined(_WIN32)
+static inline void cpu_physical_memory_set_encrypted_lebitmap(
+                                                        unsigned long *bit=
map,
+                                                        ram_addr_t start,
+                                                        ram_addr_t pages)
+{
+    unsigned long i;
+    unsigned long hpratio =3D getpagesize() / TARGET_PAGE_SIZE;
+    unsigned long page =3D BIT_WORD(start >> TARGET_PAGE_BITS);
+
+    /* start address is aligned at the start of a word? */
+    if ((((page * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D start) &&
+        (hpratio =3D=3D 1)) {
+        unsigned long **blocks[DIRTY_MEMORY_NUM];
+        unsigned long idx;
+        unsigned long offset;
+        long k;
+        long nr =3D BITS_TO_LONGS(pages);
+
+        idx =3D (start >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
+        offset =3D BIT_WORD((start >> TARGET_PAGE_BITS) %
+                          DIRTY_MEMORY_BLOCK_SIZE);
+
+        rcu_read_lock();
+
+        for (i =3D 0; i < DIRTY_MEMORY_NUM; i++) {
+            blocks[i] =3D atomic_rcu_read(&ram_list.dirty_memory[i])->bloc=
ks;
+        }
+
+        for (k =3D 0; k < nr; k++) {
+            if (bitmap[k]) {
+                unsigned long temp =3D leul_to_cpu(bitmap[k]);
+
+                atomic_xchg(&blocks[DIRTY_MEMORY_ENCRYPTED][idx][offset], =
temp);
+            }
+
+            if (++offset >=3D BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) {
+                offset =3D 0;
+                idx++;
+            }
+        }
+
+        rcu_read_unlock();
+    } else {
+        i =3D 0;
+        while (pages > 0) {
+            unsigned long len =3D MIN(pages, BITS_PER_LONG);
+
+            cpu_physical_memory_set_encrypted_range(start, len,
+                            leul_to_cpu(bitmap[i]));
+            start +=3D len;
+            i++;
+            pages -=3D len;
+        }
+    }
+}
+
 static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *b=
itmap,
                                                           ram_addr_t start=
,
                                                           ram_addr_t pages=
)
@@ -478,6 +590,8 @@ static inline void cpu_physical_memory_clear_dirty_rang=
e(ram_addr_t start,
     cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_M=
IGRATION);
     cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_V=
GA);
     cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_C=
ODE);
+    cpu_physical_memory_test_and_clear_dirty(start, length,
+                                             DIRTY_MEMORY_ENCRYPTED);
 }
=20
=20
@@ -556,5 +670,90 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBloc=
k *rb,
=20
     return num_dirty;
 }
+
+static inline bool cpu_physical_memory_test_encrypted(ram_addr_t start,
+                                                      ram_addr_t length)
+{
+    unsigned long end, page;
+    bool enc =3D false;
+    unsigned long * const *src;
+
+    if (length =3D=3D 0) {
+        return enc;
+    }
+
+    end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
+    page =3D start >> TARGET_PAGE_BITS;
+
+    rcu_read_lock();
+
+    src =3D atomic_rcu_read(
+            &ram_list.dirty_memory[DIRTY_MEMORY_ENCRYPTED])->blocks;
+
+    while (page < end) {
+        unsigned long idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
+        unsigned long offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
+        unsigned long num =3D MIN(end - page, DIRTY_MEMORY_BLOCK_SIZE - of=
fset);
+
+        enc |=3D atomic_read(&src[idx][BIT_WORD(offset)]);
+        page +=3D num;
+    }
+
+    rcu_read_unlock();
+
+    return enc;
+}
+
+static inline
+void cpu_physical_memory_sync_encrypted_bitmap(RAMBlock *rb,
+                                               ram_addr_t start,
+                                               ram_addr_t length)
+{
+    ram_addr_t addr;
+    unsigned long word =3D BIT_WORD((start + rb->offset) >> TARGET_PAGE_BI=
TS);
+    unsigned long *dest =3D rb->encbmap;
+
+    /* start address and length is aligned at the start of a word? */
+    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D
+         (start + rb->offset) &&
+        !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
+        int k;
+        int nr =3D BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
+        unsigned long * const *src;
+        unsigned long idx =3D (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_=
SIZE;
+        unsigned long offset =3D BIT_WORD((word * BITS_PER_LONG) %
+                                        DIRTY_MEMORY_BLOCK_SIZE);
+        unsigned long page =3D BIT_WORD(start >> TARGET_PAGE_BITS);
+
+        rcu_read_lock();
+
+        src =3D atomic_rcu_read(
+                &ram_list.dirty_memory[DIRTY_MEMORY_ENCRYPTED])->blocks;
+
+        for (k =3D page; k < page + nr; k++) {
+            unsigned long bits =3D atomic_read(&src[idx][offset]);
+            dest[k] =3D bits;
+
+            if (++offset >=3D BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) {
+                offset =3D 0;
+                idx++;
+            }
+        }
+
+        rcu_read_unlock();
+    } else {
+        ram_addr_t offset =3D rb->offset;
+
+        for (addr =3D 0; addr < length; addr +=3D TARGET_PAGE_SIZE) {
+            long k =3D (start + addr) >> TARGET_PAGE_BITS;
+            if (cpu_physical_memory_test_encrypted(start + addr + offset,
+                                                   TARGET_PAGE_SIZE)) {
+                set_bit(k, dest);
+            } else {
+                clear_bit(k, dest);
+            }
+        }
+    }
+}
 #endif
 #endif
diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
index bc4faa1b00..2a5eab8b11 100644
--- a/include/exec/ramlist.h
+++ b/include/exec/ramlist.h
@@ -11,7 +11,8 @@ typedef struct RAMBlockNotifier RAMBlockNotifier;
 #define DIRTY_MEMORY_VGA       0
 #define DIRTY_MEMORY_CODE      1
 #define DIRTY_MEMORY_MIGRATION 2
-#define DIRTY_MEMORY_NUM       3        /* num of dirty bits */
+#define DIRTY_MEMORY_ENCRYPTED 3
+#define DIRTY_MEMORY_NUM       4        /* num of dirty bits */
=20
 /* The dirty memory bitmap is split into fixed-size blocks to allow growth
  * under RCU.  The bitmap for a block can be accessed as follows:
diff --git a/migration/ram.c b/migration/ram.c
index 889148dd84..57c707525b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -57,6 +57,7 @@
 #include "qemu/uuid.h"
 #include "savevm.h"
 #include "qemu/iov.h"
+#include "hw/boards.h"
=20
 /***********************************************************/
 /* ram save/restore */
@@ -700,6 +701,13 @@ typedef struct {
     QemuSemaphore sem_sync;
 } MultiFDRecvParams;
=20
+static inline bool memcrypt_enabled(void)
+{
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+
+    return machine_memory_encryption_enabled(ms);
+}
+
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
 {
     MultiFDInit_t msg;
@@ -1754,6 +1762,9 @@ static void migration_bitmap_sync_range(RAMState *rs,=
 RAMBlock *rb,
     rs->migration_dirty_pages +=3D
         cpu_physical_memory_sync_dirty_bitmap(rb, 0, length,
                                               &rs->num_dirty_pages_period)=
;
+    if (memcrypt_enabled()) {
+        cpu_physical_memory_sync_encrypted_bitmap(rb, 0, length);
+    }
 }
=20
 /**
@@ -2768,6 +2779,8 @@ static void ram_save_cleanup(void *opaque)
         block->bmap =3D NULL;
         g_free(block->unsentmap);
         block->unsentmap =3D NULL;
+        g_free(block->encbmap);
+        block->encbmap =3D NULL;
     }
=20
     xbzrle_cleanup();
@@ -3310,6 +3323,10 @@ static void ram_list_init_bitmaps(void)
                 block->unsentmap =3D bitmap_new(pages);
                 bitmap_set(block->unsentmap, 0, pages);
             }
+            if (memcrypt_enabled()) {
+                block->encbmap =3D bitmap_new(pages);
+                bitmap_set(block->encbmap, 0, pages);
+            }
         }
     }
 }
--=20
2.17.1


