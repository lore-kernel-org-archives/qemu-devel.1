Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5497C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D51A20578
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UQ8Cyvxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D51A20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2nY-0003og-Q2
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 12:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50965)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jh-00044p-Dn
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jf-0003oG-Hh
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:57 -0400
Received: from mail-eopbgr710055.outbound.protection.outlook.com
 ([40.107.71.55]:41284 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hv2jf-0003ei-AA
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auP7pdnlBSQX0Mh/s5yoH658JSYrbJ+20u/BccIJeju3iUJLCddpp53vrPFOCFkI8bXdB8e5jh0tfYBhq6eWQG4iTVvuTm8SjjtfJwAQMpT9sg57Bp0fOtXm79o0tdvGpn+au+GQmOWTeX4TC1PSb5pnRSwJRg63y/pdzuWS3N71E5lWUfQBR/RH6ugX3TA2RZgNDNBBOjrzo0IF6gCQSpBTvLbhB/QOB5bNBCFZnlJrhcgnQR9pHL57v6kdvldfCMztGfnZSWqp359LhOnnyYjm4ZFhw3vZL4DdYGzSNG5mbe9f6OOH9lNZshCWyqqHJJVRgZbQJj9aH4v8yv0Dgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A6lImf7rAfGPsVC1yJhfOyQ4Pad0Dem3q6S3V93tek=;
 b=L/i3DvhzhwrFd+IEavJ85eguijFdiZcqT06lpKpxYh8v16XWwi++jDgsrZhJskibD2/qPLcTvzfbN8/UspLQoOwAVBiCJryq5YyXfqxpqzNTtSXHfpap1iXP4pOKoNNtJ+8LWm+GrklLwMM3t7VocLGjI7iA7imYuO7HWLex1+wTyNd7UIi9195zhjYzvd0384+bB6wd1fZZPd9qRPAsoyIxN+VUvgoKn2zty/parSqLovIxbOh7VUJPZpPnh3TEtR6oWGdqrdgilPYlrzlHTixT14/x566W1O+yoaBva/8UzQYNQ5YIg8YiOQ6jccKU8DcAyq7ASVWmJsQF5cE/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A6lImf7rAfGPsVC1yJhfOyQ4Pad0Dem3q6S3V93tek=;
 b=UQ8CyvxnBDJlE6JBbbkUZ3U1lODBl/5u+n07vu/LGBu5owmY/NTfqrwDuGu5VwDdpa1RLFethMj2VLo92EFlgc9ZSHZo55bWtojICJdztyW+7c2eQKjrUe5rXClh5x38yHrn0AWAJuYst8UzGcHy5HQEfIZCXO9AS/FKBrQWjSg=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB4233.namprd12.prod.outlook.com (10.141.184.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Tue, 6 Aug 2019 16:54:53 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 16:54:53 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 09/14] target/i386: sev: add support to encrypt the
 outgoing page
Thread-Index: AQHVTHerf1yW7BLbT0K/ygBstlBEBA==
Date: Tue, 6 Aug 2019 16:54:53 +0000
Message-ID: <20190806165429.19327-10-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 1a7eba99-9c8b-47e5-be31-08d71a8ecdb5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB4233; 
x-ms-traffictypediagnostic: DM6PR12MB4233:
x-microsoft-antispam-prvs: <DM6PR12MB423398D68F1BD24833BB7790E5D50@DM6PR12MB4233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:214;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(2501003)(71200400001)(36756003)(81166006)(71190400001)(81156014)(54906003)(5660300002)(1076003)(25786009)(7736002)(6116002)(305945005)(8676002)(76176011)(6916009)(68736007)(3846002)(8936002)(2351001)(99286004)(478600001)(102836004)(64756008)(66946007)(66446008)(66476007)(386003)(6506007)(66556008)(26005)(4326008)(50226002)(2616005)(186003)(476003)(6512007)(6486002)(486006)(86362001)(5640700003)(53936002)(66066001)(316002)(14454004)(11346002)(2906002)(446003)(256004)(14444005)(6436002)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4233;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vVFmLRx392ElD44OKelqSgFLofCPaYAvS0lJofamh1kgTxekgcL+epm+Lhx8j3Jz7mH0D3f9wDzqtt64Y6Pbvj/1Wn7kfzGSu+r/krLYENliVqfnXpzV0YTageQL+8vjMeZip+jRpfb7+NFNvAu3o6GlZZRKhJh5kFwK4CqKauipjRXv8AMdDG1RNYqF2hUUDWxt4OybGqvCdRlNCunETDfgFUKc4MnYKuJXXUovjRv/egY1gJ6WIbtXti16vszk1okwBtN7Qm1reosCnbtsKLC38CJyBuN3nRNxj+6sZ2PQmKc5h1iXyiiDX8Q8Ib03fL9XdnmmnzIJXcYSiOuldbuPhRUJevbXr4O6oT+2WknKfekUl6C6aG8Y42oKINfVgG8S+tp11wzknj2SQwcj0OjzCEtihvwX2fIk3BtlwiU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7eba99-9c8b-47e5-be31-08d71a8ecdb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:54:53.8400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.55
Subject: [Qemu-devel] [PATCH v3 09/14] target/i386: sev: add support to
 encrypt the outgoing page
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

The sev_save_outgoing_page() provide the implementation to encrypt the
guest private pages during the transit. The routines uses the SEND_START
command to create the outgoing encryption context on the first call then
uses the SEND_UPDATE_DATA command to encrypt the data before writing it
to the socket. While encrypting the data SEND_UPDATE_DATA produces some
metadata (e.g MAC, IV). The metadata is also sent to the target machine.
After migration is completed, we issue the SEND_FINISH command to transitio=
n
the SEV guest state from sending to unrunnable state.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/kvm-all.c      |   9 ++
 accel/kvm/sev-stub.c     |   6 ++
 include/sysemu/sev.h     |   2 +
 target/i386/sev.c        | 216 +++++++++++++++++++++++++++++++++++++++
 target/i386/sev_i386.h   |   2 +
 target/i386/trace-events |   3 +
 6 files changed, 238 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d0304c6947..a5b0ae9363 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -172,8 +172,17 @@ static int kvm_memcrypt_save_setup(const char *pdh, co=
nst char *plat_cert,
                           plat_cert, amd_cert);
 }
=20
+static int kvm_memcrypt_save_outgoing_page(QEMUFile *f, uint8_t *ptr,
+                                           uint32_t size,
+                                           uint64_t *bytes_sent)
+{
+    return sev_save_outgoing_page(kvm_state->memcrypt_handle, f, ptr, size=
,
+                                  bytes_sent);
+}
+
 static struct MachineMemoryEncryptionOps sev_memory_encryption_ops =3D {
     .save_setup =3D kvm_memcrypt_save_setup,
+    .save_outgoing_page =3D kvm_memcrypt_save_outgoing_page,
 };
=20
 int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
diff --git a/accel/kvm/sev-stub.c b/accel/kvm/sev-stub.c
index 528f8cf7f1..51b17b8141 100644
--- a/accel/kvm/sev-stub.c
+++ b/accel/kvm/sev-stub.c
@@ -30,3 +30,9 @@ int sev_save_setup(void *handle, const char *pdh, const c=
har *plat_cert,
 {
     return 1;
 }
+
+int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
+                           uint32_t size, uint64_t *bytes_sent)
+{
+    return 1;
+}
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index d5123d4fa3..f06fd203cd 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -20,4 +20,6 @@ void *sev_guest_init(const char *id);
 int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
 int sev_save_setup(void *handle, const char *pdh, const char *plat_cert,
                    const char *amd_cert);
+int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
+                           uint32_t size, uint64_t *bytes_sent);
 #endif
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 483d9bb0fa..1820c62a71 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -28,6 +28,7 @@
 #include "trace.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
+#include "migration/misc.h"
=20
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
@@ -774,6 +775,40 @@ error:
     return 1;
 }
=20
+static void
+sev_send_finish(void)
+{
+    int ret, error;
+
+    trace_kvm_sev_send_finish();
+    ret =3D sev_ioctl(sev_state->sev_fd, KVM_SEV_SEND_FINISH, 0, &error);
+    if (ret) {
+        error_report("%s: SEND_FINISH ret=3D%d fw_error=3D%d '%s'",
+                     __func__, ret, error, fw_error_to_str(error));
+    }
+
+    g_free(sev_state->send_packet_hdr);
+    sev_set_guest_state(SEV_STATE_RUNNING);
+}
+
+static void
+sev_migration_state_notifier(Notifier *notifier, void *data)
+{
+    MigrationState *s =3D data;
+
+    if (migration_has_finished(s) ||
+        migration_in_postcopy_after_devices(s) ||
+        migration_has_failed(s)) {
+        if (sev_check_state(SEV_STATE_SEND_UPDATE)) {
+            sev_send_finish();
+        }
+    }
+}
+
+static Notifier sev_migration_state_notify =3D {
+    .notify =3D sev_migration_state_notifier,
+};
+
 void *
 sev_guest_init(const char *id)
 {
@@ -860,6 +895,7 @@ sev_guest_init(const char *id)
     ram_block_notifier_add(&sev_ram_notifier);
     qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
     qemu_add_vm_change_state_handler(sev_vm_state_change, s);
+    add_migration_state_change_notifier(&sev_migration_state_notify);
=20
     return s;
 err:
@@ -881,6 +917,186 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t=
 len)
     return 0;
 }
=20
+static int
+sev_get_send_session_length(void)
+{
+    int ret, fw_err =3D 0;
+    struct kvm_sev_send_start start =3D {};
+
+    ret =3D sev_ioctl(sev_state->sev_fd, KVM_SEV_SEND_START, &start, &fw_e=
rr);
+    if (fw_err !=3D SEV_RET_INVALID_LEN) {
+        ret =3D -1;
+        error_report("%s: failed to get session length ret=3D%d fw_error=
=3D%d '%s'",
+                     __func__, ret, fw_err, fw_error_to_str(fw_err));
+        goto err;
+    }
+
+    ret =3D start.session_len;
+err:
+    return ret;
+}
+
+static int
+sev_send_start(SEVState *s, QEMUFile *f, uint64_t *bytes_sent)
+{
+    gsize pdh_len =3D 0, plat_cert_len;
+    int session_len, ret, fw_error;
+    struct kvm_sev_send_start start =3D { };
+    guchar *pdh =3D NULL, *plat_cert =3D NULL, *session =3D NULL;
+
+    if (!s->remote_pdh || !s->remote_plat_cert || !s->amd_cert_len) {
+        error_report("%s: missing remote PDH or PLAT_CERT", __func__);
+        return 1;
+    }
+
+    start.pdh_cert_uaddr =3D (uintptr_t) s->remote_pdh;
+    start.pdh_cert_len =3D s->remote_pdh_len;
+
+    start.plat_cert_uaddr =3D (uintptr_t)s->remote_plat_cert;
+    start.plat_cert_len =3D s->remote_plat_cert_len;
+
+    start.amd_cert_uaddr =3D (uintptr_t)s->amd_cert;
+    start.amd_cert_len =3D s->amd_cert_len;
+
+    /* get the session length */
+    session_len =3D sev_get_send_session_length();
+    if (session_len < 0) {
+        ret =3D 1;
+        goto err;
+    }
+
+    session =3D g_new0(guchar, session_len);
+    start.session_uaddr =3D (unsigned long)session;
+    start.session_len =3D session_len;
+
+    /* Get our PDH certificate */
+    ret =3D sev_get_pdh_info(s->sev_fd, &pdh, &pdh_len,
+                           &plat_cert, &plat_cert_len);
+    if (ret) {
+        error_report("Failed to get our PDH cert");
+        goto err;
+    }
+
+    trace_kvm_sev_send_start(start.pdh_cert_uaddr, start.pdh_cert_len,
+                             start.plat_cert_uaddr, start.plat_cert_len,
+                             start.amd_cert_uaddr, start.amd_cert_len);
+
+    ret =3D sev_ioctl(s->sev_fd, KVM_SEV_SEND_START, &start, &fw_error);
+    if (ret < 0) {
+        error_report("%s: SEND_START ret=3D%d fw_error=3D%d '%s'",
+                __func__, ret, fw_error, fw_error_to_str(fw_error));
+        goto err;
+    }
+
+    qemu_put_be32(f, start.policy);
+    qemu_put_be32(f, pdh_len);
+    qemu_put_buffer(f, (uint8_t *)pdh, pdh_len);
+    qemu_put_be32(f, start.session_len);
+    qemu_put_buffer(f, (uint8_t *)start.session_uaddr, start.session_len);
+    *bytes_sent =3D 12 + pdh_len + start.session_len;
+
+    sev_set_guest_state(SEV_STATE_SEND_UPDATE);
+
+err:
+    g_free(pdh);
+    g_free(plat_cert);
+    return ret;
+}
+
+static int
+sev_send_get_packet_len(int *fw_err)
+{
+    int ret;
+    struct kvm_sev_send_update_data update =3D {};
+
+    ret =3D sev_ioctl(sev_state->sev_fd, KVM_SEV_SEND_UPDATE_DATA,
+                    &update, fw_err);
+    if (*fw_err !=3D SEV_RET_INVALID_LEN) {
+        ret =3D -1;
+        error_report("%s: failed to get session length ret=3D%d fw_error=
=3D%d '%s'",
+                    __func__, ret, *fw_err, fw_error_to_str(*fw_err));
+        goto err;
+    }
+
+    ret =3D update.hdr_len;
+
+err:
+    return ret;
+}
+
+static int
+sev_send_update_data(SEVState *s, QEMUFile *f, uint8_t *ptr, uint32_t size=
,
+                     uint64_t *bytes_sent)
+{
+    int ret, fw_error;
+    guchar *trans;
+    struct kvm_sev_send_update_data update =3D { };
+
+    /*
+     * If this is first call then query the packet header bytes and alloca=
te
+     * the packet buffer.
+     */
+    if (!s->send_packet_hdr) {
+        s->send_packet_hdr_len =3D sev_send_get_packet_len(&fw_error);
+        if (s->send_packet_hdr_len < 1) {
+            error_report("%s: SEND_UPDATE fw_error=3D%d '%s'",
+                    __func__, fw_error, fw_error_to_str(fw_error));
+            return 1;
+        }
+
+        s->send_packet_hdr =3D g_new(gchar, s->send_packet_hdr_len);
+    }
+
+    /* allocate transport buffer */
+    trans =3D g_new(guchar, size);
+
+    update.hdr_uaddr =3D (uintptr_t)s->send_packet_hdr;
+    update.hdr_len =3D s->send_packet_hdr_len;
+    update.guest_uaddr =3D (uintptr_t)ptr;
+    update.guest_len =3D size;
+    update.trans_uaddr =3D (uintptr_t)trans;
+    update.trans_len =3D size;
+
+    trace_kvm_sev_send_update_data(ptr, trans, size);
+
+    ret =3D sev_ioctl(s->sev_fd, KVM_SEV_SEND_UPDATE_DATA, &update, &fw_er=
ror);
+    if (ret) {
+        error_report("%s: SEND_UPDATE_DATA ret=3D%d fw_error=3D%d '%s'",
+                __func__, ret, fw_error, fw_error_to_str(fw_error));
+        goto err;
+    }
+
+    qemu_put_be32(f, update.hdr_len);
+    qemu_put_buffer(f, (uint8_t *)update.hdr_uaddr, update.hdr_len);
+    *bytes_sent =3D 4 + update.hdr_len;
+
+    qemu_put_be32(f, update.trans_len);
+    qemu_put_buffer(f, (uint8_t *)update.trans_uaddr, update.trans_len);
+    *bytes_sent +=3D (4 + update.trans_len);
+
+err:
+    g_free(trans);
+    return ret;
+}
+
+int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
+                           uint32_t sz, uint64_t *bytes_sent)
+{
+    SEVState *s =3D sev_state;
+
+    /*
+     * If this is a first buffer then create outgoing encryption context
+     * and write our PDH, policy and session data.
+     */
+    if (!sev_check_state(SEV_STATE_SEND_UPDATE) &&
+        sev_send_start(s, f, bytes_sent)) {
+        error_report("Failed to create outgoing context");
+        return 1;
+    }
+
+    return sev_send_update_data(s, f, ptr, sz, bytes_sent);
+}
+
 static void
 sev_register_types(void)
 {
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
index 32906de998..e475304f5f 100644
--- a/target/i386/sev_i386.h
+++ b/target/i386/sev_i386.h
@@ -87,6 +87,8 @@ struct SEVState {
     size_t remote_plat_cert_len;
     guchar *amd_cert;
     size_t amd_cert_len;
+    gchar *send_packet_hdr;
+    size_t send_packet_hdr_len;
 };
=20
 typedef struct SEVState SEVState;
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 789c700d4a..b41516cf9f 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -15,3 +15,6 @@ kvm_sev_launch_start(int policy, void *session, void *pdh=
) "policy 0x%x session
 kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRI=
u64
 kvm_sev_launch_measurement(const char *value) "data %s"
 kvm_sev_launch_finish(void) ""
+kvm_sev_send_start(uint64_t pdh, int l1, uint64_t plat, int l2, uint64_t a=
md, int l3) "pdh 0x%" PRIx64 " len %d plat 0x%" PRIx64 " len %d amd 0x%" PR=
Ix64 " len %d"
+kvm_sev_send_update_data(void *src, void *dst, int len) "guest %p trans %p=
 len %d"
+kvm_sev_send_finish(void) ""
--=20
2.17.1


