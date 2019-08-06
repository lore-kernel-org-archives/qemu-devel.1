Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEAAC31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 17:00:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C13420578
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 17:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gFMVqPwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C13420578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2pH-0006Qw-UO
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 13:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51027)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jk-0004Et-ET
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2ji-0003vd-Ua
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:55:00 -0400
Received: from mail-eopbgr810057.outbound.protection.outlook.com
 ([40.107.81.57]:52144 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hv2ji-0003qo-Nz
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnH9YSLXIR8vfz+OIHnLDdieXWENAlxnSlbjVr1Nu/evWFCNs39BoVf7Wsg7Ewg0S/Pyjh1P1dMDfjyVQFy6eTA1hOpTQ3xO0q5wg34EiBUZHeeF63fun3RGJjQRBTFqAz+ue2pqHNXfUlzarjyWDsOKkcZQOiF18YLGgPAlzohnQ/y62kvmBUQxTQEaG9f51udaCUdGW7QLxbon+86wxBr/Dx3joTixasqZtQVZhYDFd66+GncI28wGc4xgCiLwLQN2GkBmHytXsUPojg2szdovKjvs4k1zLySesgr+8bFQWMfhMa09wYPISRutIpmsmAms3VJR19m2uDoKSeemQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJIY46v9TBblbS9x1cgn+Bsbo1uFuY7GAe9HXDBAAA4=;
 b=M/NSmTQDyS6UgVfVYhkf1i/poOw7MRxw9zbgSxarKvn4K5ZfLU1f7sbLVAtb4DL5KleNECT7gGMiJyzyrSou8v8RaBPs7jBHLJqvzKVVk3JsRz9m7hqDguZzDI7KoDT1tptyQa3VS/oGNIx7Yi7jwIDYZYIJoY4/eGT5H5MU5bNGFTPXx9Hys95l3pLSNYAkPAr809Jp0RhCHtXUnnGYNU2/1mtIHf+jf6mf1Gt95f6tUr5m8csl7LjGdYKCACNW6HlhWmd0LQRmsmZpSkeUwIphG5csFdrz0wFaFYrW9+KAgxmFis8EeeIy2ByaQ+kknyYeMXiX9I8u23W13xzVNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJIY46v9TBblbS9x1cgn+Bsbo1uFuY7GAe9HXDBAAA4=;
 b=gFMVqPwKRchhnIhtyY4DOAG4Yq2Pq+HUrkyx7WqxYRu2DxlmACFHYYZ1NVTW4SlrYBNiT3w3+4f+ry0VoKcOFUvuqhLKbwAgD00ooFlX1tH59PHscl6DgBCrBvx9/thyzBWBgub6pTX+tKvk4pmFfPlAFYbDnGE6b+f271KqDtU=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB2891.namprd12.prod.outlook.com (20.179.71.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Tue, 6 Aug 2019 16:54:57 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 16:54:57 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 13/14] migration/ram: add support to send encrypted
 pages
Thread-Index: AQHVTHetRSrN3wcZoUOui2rEdXwQuQ==
Date: Tue, 6 Aug 2019 16:54:56 +0000
Message-ID: <20190806165429.19327-14-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: d8e57f1f-b0fb-4461-bf00-08d71a8ecfa6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB2891; 
x-ms-traffictypediagnostic: DM6PR12MB2891:
x-microsoft-antispam-prvs: <DM6PR12MB289193F86745C4F31A579218E5D50@DM6PR12MB2891.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(43544003)(6116002)(3846002)(2906002)(6436002)(50226002)(54906003)(316002)(8676002)(81156014)(86362001)(81166006)(5640700003)(99286004)(76176011)(52116002)(6486002)(386003)(102836004)(71200400001)(71190400001)(2616005)(2501003)(476003)(8936002)(14444005)(11346002)(26005)(66066001)(256004)(6506007)(2351001)(446003)(186003)(486006)(6512007)(66556008)(478600001)(66476007)(64756008)(66946007)(7736002)(53936002)(1076003)(66446008)(6916009)(5660300002)(36756003)(68736007)(25786009)(4326008)(305945005)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2891;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iwr9R34Xl071rELSjI3oRcJTv6rk2iOXmaFkVKGTDji5I7LK8LbCKNPQwG3bsKSlwygE8SsACArdJvuig6YNJz4p8s0AzwiVPjQ4Hs6+oLYwxIyvu1k+RQ8lbF23GYcNZh8sIh/SaBMB8vkdezZRVmmuyVeZic537t8xUfWjRgKuNLoIxV3Kdo5kFKaCiWmTFCyS6ZpUNZN/2Pk1yttUmix48Fl31t/uQPhskkm0EJHqYyVYhIsKyOEXXQfmUiBN2QtL6ItJPPsDpXAjhitSYR02oCjH3yYGtirQPF7zhCLCdcvc7Yq0Fr+Q7im36qEp1weI7QUDExWymMXiJLEwUYNyIzjoiXneBswKVdfFOVEG4hjjZHXiJFgznsgVFGTUUTnjkXkvhCqi2xARdQ4kzQ2qeYQTOHA1l+IARUHL8LY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e57f1f-b0fb-4461-bf00-08d71a8ecfa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:54:56.9803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.57
Subject: [Qemu-devel] [PATCH v3 13/14] migration/ram: add support to send
 encrypted pages
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

When memory encryption is enabled, the guest memory will be encrypted with
the guest specific key. The patch introduces RAM_SAVE_FLAG_ENCRYPTED_PAGE
flag to distinguish the encrypted data from plaintext. Encrypted pages
may need special handling. The kvm_memcrypt_save_outgoing_page() is used
by the sender to write the encrypted pages onto the socket, similarly the
kvm_memcrypt_load_incoming_page() is used by the target to read the
encrypted pages from the socket and load into the guest memory.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 migration/ram.c | 131 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 57c707525b..100a5a10cd 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -59,6 +59,9 @@
 #include "qemu/iov.h"
 #include "hw/boards.h"
=20
+/* Defines RAM_SAVE_ENCRYPTED_PAGE and  RAM_SAVE_ENCRYPTED_BITMAP */
+#include "sysemu/sev.h"
+
 /***********************************************************/
 /* ram save/restore */
=20
@@ -77,6 +80,7 @@
 #define RAM_SAVE_FLAG_XBZRLE   0x40
 /* 0x80 is reserved in migration.h start with 0x100 next */
 #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
+#define RAM_SAVE_FLAG_ENCRYPTED_DATA   0x200
=20
 static inline bool is_zero_range(uint8_t *p, uint64_t size)
 {
@@ -460,6 +464,9 @@ static QemuCond decomp_done_cond;
=20
 static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *=
block,
                                  ram_addr_t offset, uint8_t *source_buf);
+static int ram_save_encrypted_page(RAMState *rs, PageSearchStatus *pss,
+                                   bool last_stage);
+
=20
 static void *do_data_compress(void *opaque)
 {
@@ -2039,6 +2046,73 @@ static int save_normal_page(RAMState *rs, RAMBlock *=
block, ram_addr_t offset,
     return 1;
 }
=20
+/**
+ * ram_save_encrypted_page - send the given encrypted page to the stream
+ */
+static int ram_save_encrypted_page(RAMState *rs, PageSearchStatus *pss,
+                                   bool last_stage)
+{
+    int ret;
+    uint8_t *p;
+    RAMBlock *block =3D pss->block;
+    ram_addr_t offset =3D pss->page << TARGET_PAGE_BITS;
+    uint64_t bytes_xmit;
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
+    struct MachineMemoryEncryptionOps *ops =3D mc->memory_encryption_ops;
+
+    p =3D block->host + offset;
+
+    ram_counters.transferred +=3D
+        save_page_header(rs, rs->f, block,
+                    offset | RAM_SAVE_FLAG_ENCRYPTED_DATA);
+
+    qemu_put_be32(rs->f, RAM_SAVE_ENCRYPTED_PAGE);
+    ret =3D ops->save_outgoing_page(rs->f, p, TARGET_PAGE_SIZE, &bytes_xmi=
t);
+    if (ret) {
+        return -1;
+    }
+
+    ram_counters.transferred +=3D bytes_xmit;
+    ram_counters.normal++;
+
+    return 1;
+}
+
+/**
+ * ram_save_encrypted_bitmap: send the encrypted page state bitmap
+ */
+static int ram_save_encrypted_bitmap(RAMState *rs, QEMUFile *f)
+{
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
+    struct MachineMemoryEncryptionOps *ops =3D mc->memory_encryption_ops;
+
+    save_page_header(rs, rs->f, rs->last_seen_block,
+                     RAM_SAVE_FLAG_ENCRYPTED_DATA);
+    qemu_put_be32(rs->f, RAM_SAVE_ENCRYPTED_BITMAP);
+    return ops->save_outgoing_bitmap(rs->f);
+}
+
+static int load_encrypted_data(QEMUFile *f, uint8_t *ptr)
+{
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
+    struct MachineMemoryEncryptionOps *ops =3D mc->memory_encryption_ops;
+    int flag;
+
+    flag =3D qemu_get_be32(f);
+
+    if (flag =3D=3D RAM_SAVE_ENCRYPTED_PAGE) {
+        return ops->load_incoming_page(f, ptr);
+    } else if (flag =3D=3D RAM_SAVE_ENCRYPTED_BITMAP) {
+        return ops->load_incoming_bitmap(f);
+    } else {
+        error_report("unknown encrypted flag %x", flag);
+        return 1;
+    }
+}
+
 /**
  * ram_save_page: send the given page to the stream
  *
@@ -2528,6 +2602,22 @@ static bool save_compress_page(RAMState *rs, RAMBloc=
k *block, ram_addr_t offset)
     return false;
 }
=20
+/**
+ * encrypted_test_bitmap: check if the page is encrypted
+ *
+ * Returns a bool indicating whether the page is encrypted.
+ */
+static bool encrypted_test_bitmap(RAMState *rs, RAMBlock *block,
+                                  unsigned long page)
+{
+    /* ROM devices contains the unencrypted data */
+    if (memory_region_is_rom(block->mr)) {
+        return false;
+    }
+
+    return test_bit(page, block->encbmap);
+}
+
 /**
  * ram_save_target_page: save one target page
  *
@@ -2548,6 +2638,17 @@ static int ram_save_target_page(RAMState *rs, PageSe=
archStatus *pss,
         return res;
     }
=20
+    /*
+     * If memory encryption is enabled then use memory encryption APIs
+     * to write the outgoing buffer to the wire. The encryption APIs
+     * will take care of accessing the guest memory and re-encrypt it
+     * for the transport purposes.
+     */
+    if (memcrypt_enabled() &&
+        encrypted_test_bitmap(rs, pss->block, pss->page)) {
+        return ram_save_encrypted_page(rs, pss, last_stage);
+    }
+
     if (save_compress_page(rs, block, offset)) {
         return 1;
     }
@@ -3445,6 +3546,16 @@ void qemu_guest_free_page_hint(void *addr, size_t le=
n)
     }
 }
=20
+static int ram_encrypted_save_setup(void)
+{
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
+    MigrationParameters *p =3D &migrate_get_current()->parameters;
+    struct MachineMemoryEncryptionOps *ops =3D mc->memory_encryption_ops;
+
+    return ops->save_setup(p->sev_pdh, p->sev_plat_cert, p->sev_amd_cert);
+}
+
 /*
  * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
  * long-running RCU critical section.  When rcu-reclaims in the code
@@ -3480,6 +3591,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
=20
     rcu_read_lock();
=20
+    if (memcrypt_enabled()) {
+        if (ram_encrypted_save_setup()) {
+            return -1;
+        }
+    }
+
     qemu_put_be64(f, ram_bytes_total_common(true) | RAM_SAVE_FLAG_MEM_SIZE=
);
=20
     RAMBLOCK_FOREACH_MIGRATABLE(block) {
@@ -3644,6 +3761,11 @@ static int ram_save_complete(QEMUFile *f, void *opaq=
ue)
     flush_compressed_data(rs);
     ram_control_after_iterate(f, RAM_CONTROL_FINISH);
=20
+    /* send the page encryption state bitmap */
+    if (memcrypt_enabled()) {
+        ret =3D ram_save_encrypted_bitmap(rs, f);
+    }
+
     rcu_read_unlock();
=20
     multifd_send_sync_main();
@@ -4391,7 +4513,8 @@ static int ram_load(QEMUFile *f, void *opaque, int ve=
rsion_id)
         }
=20
         if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
-                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) =
{
+                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE |
+                     RAM_SAVE_FLAG_ENCRYPTED_DATA)) {
             RAMBlock *block =3D ram_block_from_stream(f, flags);
=20
             /*
@@ -4505,6 +4628,12 @@ static int ram_load(QEMUFile *f, void *opaque, int v=
ersion_id)
                 break;
             }
             break;
+        case RAM_SAVE_FLAG_ENCRYPTED_DATA:
+            if (load_encrypted_data(f, host)) {
+                    error_report("Failed to load encrypted data");
+                    ret =3D -EINVAL;
+            }
+            break;
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
             multifd_recv_sync_main();
--=20
2.17.1


