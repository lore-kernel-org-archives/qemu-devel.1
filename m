Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B81C74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941EB208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oYaJT7i6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941EB208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJJ3-000737-AA
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57307)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7Y-0001fq-6E
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7V-0002dv-Rq
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:19 -0400
Received: from mail-eopbgr790080.outbound.protection.outlook.com
 ([40.107.79.80]:1472 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlJ7U-0002MZ-18
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVZwyG19gNDYgzLx26Rmjpd9gBSMifIOcZmiFf05UYg=;
 b=oYaJT7i6XwrR6i8Lu+uZqVtZeVr40LDXhoszDRntAHkWxWcRt1Qn60TpHnXQQUsVX9dAAlo9qV7u02HJge42cYXyBs9DWlmMPGgY9kC1Cdb2hCuyypK/oeFCxWiJ4Jn9TDJHC8mtzCQdtC2Jxb6NyV49xRH5rDeA5rqyiUvK0pg=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3820.namprd12.prod.outlook.com (10.255.173.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Wed, 10 Jul 2019 20:23:10 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 20:23:10 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 12/13] migration: add support to migrate page
 encryption bitmap
Thread-Index: AQHVN11JNOx08kq+nEiBgv3DRmN3NA==
Date: Wed, 10 Jul 2019 20:23:08 +0000
Message-ID: <20190710202219.25939-13-brijesh.singh@amd.com>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
In-Reply-To: <20190710202219.25939-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM3PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:0:54::30) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9a90104-272e-440b-399b-08d705746c51
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3820; 
x-ms-traffictypediagnostic: DM6PR12MB3820:
x-microsoft-antispam-prvs: <DM6PR12MB3820AE04DFA5945BB1FC5D85E5F00@DM6PR12MB3820.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:556;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(256004)(8936002)(2616005)(1076003)(316002)(14444005)(476003)(81166006)(478600001)(54906003)(81156014)(2351001)(8676002)(486006)(25786009)(6436002)(6486002)(4326008)(66476007)(66946007)(446003)(53936002)(50226002)(71190400001)(66446008)(68736007)(6506007)(14454004)(386003)(5660300002)(36756003)(66066001)(186003)(6512007)(99286004)(305945005)(102836004)(26005)(2501003)(11346002)(64756008)(52116002)(5640700003)(66556008)(76176011)(86362001)(6116002)(6916009)(3846002)(7736002)(71200400001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3820;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 83dsrjFKSd/B9z+CJqN+R5429XTTna6o/hbvcXj++gGhaWmSJJB4eLXM10egq2JiK1Nf8huCVjRYTyOe9ZKLq/J+UAol5mYbld13pMtrAUKZLlPMFTi2GhCAdnfyEs3dnZfMulw56tqoDFMgy8LsSpQmApGshfqpvHzCCO+Q4FFnW5eHI8rsVttQVzHWXikBjxhBpNbrN5vORHTHDI3Gh0XLEg4AbHRzJmSaJYcUJnkjmBwROMEsV9lcOk36TBpkdSgYn+I9uKlYUHKTFpinf4wyu5Ds+HFvbDsfhYOna8m8wGY4C5/JMkMuKh8CysfLWk6zEI3raUGPf1+VZgi+A3WEfmFY+y/wtLoqQmvIxpNicbo/RLw8L7hrVu32ALOjiP+t5e7GfxZasu9lIW2OIsN1peK2WJJSKzS2K/zh7XE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a90104-272e-440b-399b-08d705746c51
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 20:23:08.9291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3820
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.80
Subject: [Qemu-devel] [PATCH v2 12/13] migration: add support to migrate
 page encryption bitmap
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

When memory encryption is enabled, the hypervisor maintains a page
encryption bitmap which is referred by hypervisor during migratoin to check
if page is private or shared. The bitmap is built during the VM bootup and
must be migrated to the target host so that hypervisor on target host can
use it for future migration. The KVM_{SET,GET}_PAGE_ENC_BITMAP can be used
to get and set the bitmap for a given gfn range.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/kvm-all.c      |  4 +++
 migration/ram.c          | 11 +++++++
 target/i386/sev.c        | 67 ++++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events |  2 ++
 4 files changed, 84 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 442b1af36e..9e23088a94 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1831,6 +1831,10 @@ static int kvm_init(MachineState *ms)
         kvm_state->memcrypt_encrypt_data =3D sev_encrypt_data;
         kvm_state->memcrypt_save_outgoing_page =3D sev_save_outgoing_page;
         kvm_state->memcrypt_load_incoming_page =3D sev_load_incoming_page;
+        kvm_state->memcrypt_load_incoming_page_enc_bitmap =3D
+            sev_load_incoming_page_enc_bitmap;
+        kvm_state->memcrypt_save_outgoing_page_enc_bitmap =3D
+            sev_save_outgoing_page_enc_bitmap;
     }
=20
     ret =3D kvm_arch_init(ms, s);
diff --git a/migration/ram.c b/migration/ram.c
index d179867e1b..3a4bdf3c03 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -78,6 +78,7 @@
 /* 0x80 is reserved in migration.h start with 0x100 next */
 #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
 #define RAM_SAVE_FLAG_ENCRYPTED_PAGE   0x200
+#define RAM_SAVE_FLAG_PAGE_ENCRYPTED_BITMAP       0x400 /* used in target/=
i386/sev.c */
=20
 static inline bool is_zero_range(uint8_t *p, uint64_t size)
 {
@@ -3595,6 +3596,10 @@ static int ram_save_complete(QEMUFile *f, void *opaq=
ue)
     flush_compressed_data(rs);
     ram_control_after_iterate(f, RAM_CONTROL_FINISH);
=20
+    if (kvm_memcrypt_enabled()) {
+        ret =3D kvm_memcrypt_save_outgoing_page_enc_bitmap(f);
+    }
+
     rcu_read_unlock();
=20
     multifd_send_sync_main();
@@ -4469,6 +4474,12 @@ static int ram_load(QEMUFile *f, void *opaque, int v=
ersion_id)
                     ret =3D -EINVAL;
             }
             break;
+        case RAM_SAVE_FLAG_PAGE_ENCRYPTED_BITMAP:
+            if (kvm_memcrypt_load_incoming_page_enc_bitmap(f)) {
+                error_report("Failed to load page enc bitmap");
+                ret =3D -EINVAL;
+            }
+            break;
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
             multifd_recv_sync_main();
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 09a62d6f88..93c6a90806 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -63,6 +63,7 @@ static const char *const sev_fw_errlist[] =3D {
 };
=20
 #define SEV_FW_MAX_ERROR      ARRAY_SIZE(sev_fw_errlist)
+#define RAM_SAVE_FLAG_PAGE_ENCRYPTED_BITMAP       0x400
=20
 static int
 sev_ioctl(int fd, int cmd, void *data, int *error)
@@ -1189,6 +1190,72 @@ int sev_load_incoming_page(void *handle, QEMUFile *f=
, uint8_t *ptr)
     return sev_receive_update_data(f, ptr);
 }
=20
+#define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
+
+int sev_load_incoming_page_enc_bitmap(void *handle, QEMUFile *f)
+{
+    void *bmap;
+    unsigned long npages;
+    unsigned long bmap_size, base_gpa;
+    struct kvm_page_enc_bitmap e =3D {};
+
+    base_gpa =3D qemu_get_be64(f);
+    npages =3D qemu_get_be64(f);
+    bmap_size =3D qemu_get_be64(f);
+
+    bmap =3D g_malloc0(bmap_size);
+    qemu_get_buffer(f, (uint8_t *)bmap, bmap_size);
+
+    trace_kvm_sev_load_page_enc_bitmap(base_gpa, npages << TARGET_PAGE_BIT=
S);
+
+    e.start_gfn =3D base_gpa >> TARGET_PAGE_BITS;
+    e.num_pages =3D npages;
+    e.enc_bitmap =3D bmap;
+    if (kvm_vm_ioctl(kvm_state, KVM_SET_PAGE_ENC_BITMAP, &e) =3D=3D -1) {
+        error_report("KVM_SET_PAGE_ENC_BITMAP ioctl failed %d", errno);
+        g_free(bmap);
+        return 1;
+    }
+
+    g_free(bmap);
+
+    return 0;
+}
+
+int sev_save_outgoing_page_enc_bitmap(void *handle, QEMUFile *f,
+                                      unsigned long start, uint64_t length=
)
+{
+    uint64_t size;
+    struct kvm_page_enc_bitmap e =3D {};
+
+    if (!length) {
+        return 0;
+    }
+
+    size =3D ALIGN((length >> TARGET_PAGE_BITS), /*HOST_LONG_BITS*/ 64) / =
8;
+    e.enc_bitmap =3D g_malloc0(size);
+    e.start_gfn =3D start >> TARGET_PAGE_BITS;
+    e.num_pages =3D length >> TARGET_PAGE_BITS;
+
+    trace_kvm_sev_save_page_enc_bitmap(start, length);
+
+    if (kvm_vm_ioctl(kvm_state, KVM_GET_PAGE_ENC_BITMAP, &e) =3D=3D -1) {
+        error_report("%s: KVM_GET_PAGE_ENC_BITMAP ioctl failed %d",
+                    __func__, errno);
+        g_free(e.enc_bitmap);
+        return 1;
+    }
+
+    qemu_put_be64(f, RAM_SAVE_FLAG_PAGE_ENCRYPTED_BITMAP);
+    qemu_put_be64(f, start);
+    qemu_put_be64(f, e.num_pages);
+    qemu_put_be64(f, size);
+    qemu_put_buffer(f, (uint8_t *)e.enc_bitmap, size);
+
+    g_free(e.enc_bitmap);
+    return 0;
+}
+
 static void
 sev_register_types(void)
 {
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 609752cca7..4c2be570f9 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -21,3 +21,5 @@ kvm_sev_send_finish(void) ""
 kvm_sev_receive_start(int policy, void *session, void *pdh) "policy 0x%x s=
ession %p pdh %p"
 kvm_sev_receive_update_data(void *src, void *dst, int len, void *hdr, int =
hdr_len) "guest %p trans %p len %d hdr %p hdr_len %d"
 kvm_sev_receive_finish(void) ""
+kvm_sev_save_page_enc_bitmap(uint64_t start, uint64_t len) "start 0x%" PRI=
x64 " len 0x%" PRIx64
+kvm_sev_load_page_enc_bitmap(uint64_t start, uint64_t len) "start 0x%" PRI=
x64 " len 0x%" PRIx64
--=20
2.17.1


