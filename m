Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD51C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED19820578
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oL71u85O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED19820578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2nX-0003kl-87
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 12:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50999)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jj-0004BL-H8
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jh-0003tl-TL
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:59 -0400
Received: from mail-eopbgr810057.outbound.protection.outlook.com
 ([40.107.81.57]:52144 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hv2jh-0003qo-KG
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjNPovtETtqlyI6bj9sarSD1ukIZO72FQjjHCziQiXfzGsTls6tq1I38YoyzvwKSrzq2kfapUWof7S1qnDZ8m7D8xOrQxBgvdYFOzahN9uQeB2lk4vPZM3LGqHB+yLQn2LX0UYUgDyk24legVHkhA6RsFCX5ZYrUO1C35HauxHCRp4yASA+FTnr0bRDaXgnfPwxMFx6nYxOE81tPu6X7uqbObw7vdPUtnGwRDug1A+l7zyVN9cTzEAIo2cUSZGJqiMZ5MXIpeDMCqm6Z/ryw6VrHKQKTe6ybevcjfakuL7yjN61sCZ2uqihXXwR4uVCooyX83AyPbizlZm4EFJgvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX3Ec+pkZ67tVh+VH8XBXnTG63RCePAYrknKVcjoimI=;
 b=JvjCojtdXZsdnwL3ubQZ50GEohNXubn4Hv+xS4E6guwQLDF31F7MuNr0aUHfFi2P1v9QuCXTgxwENqAI9AAWf6kAvf9xmxwvKQnPkIszSo3OTMdb+/28ZswE2fHz6pUERU7aKw/SiCPkX0+AMx1jHpYUSVi+3ucmaQgVtLxraogSnbX79Js93TH11dzKgCX6yZPg4di11XDVc01KikA/OeT/asJXly1ent5jY+GX3ho2i+pwXhCmfKSBn4tD77tO1GwYl7h65T/ez+7EH0ncf0giaTtP4URO+y7/Dq3k/BCnd6QB0V796pT34/KzdYcfIeYrJZocPsWtRHRQJXzMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX3Ec+pkZ67tVh+VH8XBXnTG63RCePAYrknKVcjoimI=;
 b=oL71u85Oj21qvWN+JENyQymX3OJJnlOZu17zw/fIiLqmCyCkFU+C7j3/CPzKH+nvzR+0tpDN84cZMqWrtO7SeYCoDZjNdtkW9XdqhxQLSROljh3wDThK9VbnT9BqgNBnM6RChcm6kxNMi2pTFyjw99GGJbkOT9r/rft9PjaTiII=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB2891.namprd12.prod.outlook.com (20.179.71.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Tue, 6 Aug 2019 16:54:55 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 16:54:55 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 11/14] migration: add support to migrate page
 encryption bitmap
Thread-Index: AQHVTHesETFK0p52pU+09bo5KhPqgw==
Date: Tue, 6 Aug 2019 16:54:55 +0000
Message-ID: <20190806165429.19327-12-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 83131def-4fe8-494b-c741-08d71a8eceae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB2891; 
x-ms-traffictypediagnostic: DM6PR12MB2891:
x-microsoft-antispam-prvs: <DM6PR12MB2891AAB87E1CB3EF3D683EAAE5D50@DM6PR12MB2891.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6116002)(3846002)(2906002)(6436002)(50226002)(54906003)(316002)(8676002)(81156014)(86362001)(81166006)(5640700003)(99286004)(76176011)(52116002)(6486002)(386003)(102836004)(71200400001)(71190400001)(2616005)(2501003)(476003)(8936002)(14444005)(11346002)(26005)(66066001)(256004)(6506007)(2351001)(446003)(186003)(486006)(6512007)(66556008)(478600001)(66476007)(64756008)(66946007)(7736002)(53936002)(1076003)(66446008)(6916009)(5660300002)(36756003)(68736007)(25786009)(4326008)(305945005)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2891;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nAO/Fx/GH2if+2U8JqSV+EAfQdznLfKkRdwYBPWga9KyXykP8NzSwJfnUhjpUll3ZOmOl34SJFCdmLCnvzBBC8j+306Cexmkyh7URXIVNYlchEHmVw2gofsm1jEYyq//kY0TfjFR4BOsiSMFuX7vT1BYKHqbPjuTYwduPno2dJrVjYb/Fb1sdXTVGFrNaVYt+3AFNQEVOV4xjHabteZUAn5YGyvtbByFuU2rmCy6sRX+bBGIj7v4OLJfw0ycej69irG1d5CIyMKi1MKTHrpgCv6ZlAFrrySF9fV4T8TD66fooejfDAdBzSZFrvOE+wcD2au7F0TeON4vQybpEQUFl8irLXX32Arbd5L907ytTyNx9XHBfOLVadnxHia49tuo2DwZTCH44A5E972pVBmnzwA3d3W+8oyeQx/0mr3jLBw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83131def-4fe8-494b-c741-08d71a8eceae
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:54:55.3612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.57
Subject: [Qemu-devel] [PATCH v3 11/14] migration: add support to migrate
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
 accel/kvm/kvm-all.c      | 27 ++++++++++++
 accel/kvm/sev-stub.c     | 11 +++++
 include/sysemu/sev.h     |  6 +++
 target/i386/sev.c        | 93 ++++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events |  2 +
 5 files changed, 139 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ba0e7fa2be..f4d136b022 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -185,10 +185,37 @@ static int kvm_memcrypt_load_incoming_page(QEMUFile *=
f, uint8_t *ptr)
     return sev_load_incoming_page(kvm_state->memcrypt_handle, f, ptr);
 }
=20
+static int kvm_memcrypt_save_outgoing_bitmap(QEMUFile *f)
+{
+    KVMMemoryListener *kml =3D &kvm_state->memory_listener;
+    KVMState *s =3D kvm_state;
+    int ret =3D 1, i;
+
+    /* iterate through all the registered slots and send the bitmap */
+    for (i =3D 0; i < s->nr_slots; i++) {
+        KVMSlot *mem =3D &kml->slots[i];
+        ret =3D sev_save_outgoing_bitmap(s->memcrypt_handle, f, mem->start=
_addr,
+                                       mem->memory_size,
+                                       (i + 1) =3D=3D s->nr_slots);
+        if (ret) {
+            return 1;
+        }
+    }
+
+    return ret;
+}
+
+static int kvm_memcrypt_load_incoming_bitmap(QEMUFile *f)
+{
+    return sev_load_incoming_bitmap(kvm_state->memcrypt_handle, f);
+}
+
 static struct MachineMemoryEncryptionOps sev_memory_encryption_ops =3D {
     .save_setup =3D kvm_memcrypt_save_setup,
     .save_outgoing_page =3D kvm_memcrypt_save_outgoing_page,
     .load_incoming_page =3D kvm_memcrypt_load_incoming_page,
+    .save_outgoing_bitmap =3D kvm_memcrypt_save_outgoing_bitmap,
+    .load_incoming_bitmap =3D kvm_memcrypt_load_incoming_bitmap,
 };
=20
 int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
diff --git a/accel/kvm/sev-stub.c b/accel/kvm/sev-stub.c
index 1b6773ef72..fa96225abc 100644
--- a/accel/kvm/sev-stub.c
+++ b/accel/kvm/sev-stub.c
@@ -41,3 +41,14 @@ int sev_load_incoming_page(void *handle, QEMUFile *f, ui=
nt8_t *ptr)
 {
     return 1;
 }
+
+int sev_save_outgoing_bitmap(void *handle, QEMUFile *f,
+                             unsigned long start, uint64_t length, bool la=
st)
+{
+    return 1;
+}
+
+int sev_load_incoming_bitmap(void *handle, QEMUFile *f)
+{
+    return 1;
+}
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index e9371bd2dd..f777083c94 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -16,6 +16,9 @@
=20
 #include "sysemu/kvm.h"
=20
+#define RAM_SAVE_ENCRYPTED_PAGE        0x1
+#define RAM_SAVE_ENCRYPTED_BITMAP      0x2
+
 void *sev_guest_init(const char *id);
 int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
 int sev_save_setup(void *handle, const char *pdh, const char *plat_cert,
@@ -23,4 +26,7 @@ int sev_save_setup(void *handle, const char *pdh, const c=
har *plat_cert,
 int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
                            uint32_t size, uint64_t *bytes_sent);
 int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr);
+int sev_load_incoming_bitmap(void *handle, QEMUFile *f);
+int sev_save_outgoing_bitmap(void *handle, QEMUFile *f, unsigned long star=
t,
+                             uint64_t length, bool last);
 #endif
diff --git a/target/i386/sev.c b/target/i386/sev.c
index a689011991..9d643e720c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -65,6 +65,8 @@ static const char *const sev_fw_errlist[] =3D {
 #define SEV_FW_MAX_ERROR      ARRAY_SIZE(sev_fw_errlist)
=20
 #define SEV_FW_BLOB_MAX_SIZE            0x4000          /* 16KB */
+#define ENCRYPTED_BITMAP_CONTINUE       0x1
+#define ENCRYPTED_BITMAP_END            0x2
=20
 static int
 sev_ioctl(int fd, int cmd, void *data, int *error)
@@ -1232,6 +1234,97 @@ int sev_load_incoming_page(void *handle, QEMUFile *f=
, uint8_t *ptr)
     return sev_receive_update_data(f, ptr);
 }
=20
+#define ALIGN(x, y)  (((x) + (y) - 1) & ~((y) - 1))
+
+int sev_load_incoming_bitmap(void *handle, QEMUFile *f)
+{
+    void *bmap;
+    unsigned long bmap_size, base_gpa;
+    unsigned long npages, expected_size, length;
+    struct kvm_page_enc_bitmap e =3D {};
+    int status;
+
+    status =3D qemu_get_be32(f);
+
+    while (status !=3D ENCRYPTED_BITMAP_END) {
+        base_gpa =3D qemu_get_be64(f);
+        npages =3D qemu_get_be64(f);
+        bmap_size =3D qemu_get_be64(f);
+
+        /*
+         * Before allocating the bitmap buffer, lets do some bound check t=
o
+         * ensure that we are not dealing with corrupted stream.
+         */
+        length =3D npages << TARGET_PAGE_BITS;
+        expected_size =3D ALIGN((length >> TARGET_PAGE_BITS), 64) / 8;
+        if (expected_size !=3D bmap_size) {
+            error_report("corrupted bitmap expected size %ld got %ld",
+                    expected_size, bmap_size);
+            return 1;
+        }
+
+        bmap =3D g_malloc0(bmap_size);
+        qemu_get_buffer(f, (uint8_t *)bmap, bmap_size);
+
+        trace_kvm_sev_load_bitmap(base_gpa, npages << TARGET_PAGE_BITS);
+
+        e.start_gfn =3D base_gpa >> TARGET_PAGE_BITS;
+        e.num_pages =3D npages;
+        e.enc_bitmap =3D bmap;
+        if (kvm_vm_ioctl(kvm_state, KVM_SET_PAGE_ENC_BITMAP, &e) =3D=3D -1=
) {
+            error_report("KVM_SET_PAGE_ENC_BITMAP ioctl failed %d", errno)=
;
+            g_free(bmap);
+            return 1;
+        }
+
+        g_free(bmap);
+
+        status =3D qemu_get_be32(f);
+    }
+
+    return 0;
+}
+
+int sev_save_outgoing_bitmap(void *handle, QEMUFile *f,
+                             unsigned long start, uint64_t length, bool la=
st)
+{
+    uint64_t size;
+    struct kvm_page_enc_bitmap e =3D {};
+
+    if (!length) {
+        /* nothing to send */
+        goto done;
+    }
+
+    size =3D ALIGN((length >> TARGET_PAGE_BITS), 64) / 8;
+    e.enc_bitmap =3D g_malloc0(size);
+    e.start_gfn =3D start >> TARGET_PAGE_BITS;
+    e.num_pages =3D length >> TARGET_PAGE_BITS;
+
+    trace_kvm_sev_save_bitmap(start, length);
+
+    if (kvm_vm_ioctl(kvm_state, KVM_GET_PAGE_ENC_BITMAP, &e) =3D=3D -1) {
+        error_report("%s: KVM_GET_PAGE_ENC_BITMAP ioctl failed %d",
+                    __func__, errno);
+        g_free(e.enc_bitmap);
+        return 1;
+    }
+
+    qemu_put_be32(f, ENCRYPTED_BITMAP_CONTINUE);
+    qemu_put_be64(f, start);
+    qemu_put_be64(f, e.num_pages);
+    qemu_put_be64(f, size);
+    qemu_put_buffer(f, (uint8_t *)e.enc_bitmap, size);
+
+    g_free(e.enc_bitmap);
+
+done:
+    if (last) {
+        qemu_put_be32(f, ENCRYPTED_BITMAP_END);
+    }
+    return 0;
+}
+
 static void
 sev_register_types(void)
 {
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 609752cca7..853a3870ab 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -21,3 +21,5 @@ kvm_sev_send_finish(void) ""
 kvm_sev_receive_start(int policy, void *session, void *pdh) "policy 0x%x s=
ession %p pdh %p"
 kvm_sev_receive_update_data(void *src, void *dst, int len, void *hdr, int =
hdr_len) "guest %p trans %p len %d hdr %p hdr_len %d"
 kvm_sev_receive_finish(void) ""
+kvm_sev_save_bitmap(uint64_t start, uint64_t len) "start 0x%" PRIx64 " len=
 0x%" PRIx64
+kvm_sev_load_bitmap(uint64_t start, uint64_t len) "start 0x%" PRIx64 " len=
 0x%" PRIx64
--=20
2.17.1


