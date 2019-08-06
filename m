Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C684C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99DD20578
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q9Sjp6Ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99DD20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2m1-0000ZU-ON
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 12:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50968)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jh-00045k-PQ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jg-0003oz-30
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:57 -0400
Received: from mail-eopbgr710055.outbound.protection.outlook.com
 ([40.107.71.55]:41284 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hv2jf-0003ei-Qr
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjdVH0qubqWc80vM498BnCJFgwMqO32yp9lcLa+vvkAa18wtWN57fqoaczSNIIzhMatCmWdIiZYfSBLToB+m1WFgXe3HJzZJQ9RIfkk9FvY8ESSJ7LeLA+Ofw0TKR/oqajWPnOr2LCqua4BV+nkHgl6ZtWfasQZ5tPHkUMRxLkS80PG1Zind1pT7czBymUxE8JI1vWNBLRtcltZ1mU4x8ZlTS3p8LsdXmGprMhIrY1IHwFETauvc3Ln3eK4pD1emqsiVmnGPn/3Axu2/1yEDpeTJoN0kUw1szIMK4CFNDGPJQ+Q5g//uDzh5FddukMwOUi7Qo2fCE7FY0dglxkByzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hx9PpGjRU9HHoKEIUk8RlESJNI29I8Clvug+palw2lU=;
 b=PokxLPeXDTFzpb8MEhXniTPpGlYQiU/+nNkVr0JbFPqwpnORNWyBSsf8a1BHkqqzxpsCYWTd1AUjtQn0uHRu3cqP6OOslzgzlcEm3CmpVMwCP8jbwi6Y5yagaeuxMoEpvgCwgyklPqgC0fykMMLgBt+1hqBvdG2i4NKLgFIBm+J/RlYKsqQPDH//Kd7W5XBBCddE0CK3v1VyrJ7/BC5+8vejz8vi0AcXJEI5s3/F67GVtaVKuYugE6uY9Z9oD2I0phDkhQb0cs4GTMqOgpcp0Njznz8+3lqX0dTDSM4fl+FJ4McmJEObRpgVf0UOjgotZaUTqPLJe9OFViT6UOO8fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hx9PpGjRU9HHoKEIUk8RlESJNI29I8Clvug+palw2lU=;
 b=Q9Sjp6Ru7QDHprGNqYHUrArbSe50cH8eErfRMaSQi5pNovGy9S/5Pfl6WjKj+F/2DfitXGrYUnPQGTL0cibsQOt5922Da3z7vNcZ+kmfNuyoSeNqLbnn5t0gR8rYUW+wtTLZiB0/JBDkMspFQ0cbZBIHO5KWYzj9BmzNMcoG2Jk=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB4233.namprd12.prod.outlook.com (10.141.184.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Tue, 6 Aug 2019 16:54:54 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 16:54:54 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 10/14] target/i386: sev: add support to load incoming
 encrypted page
Thread-Index: AQHVTHer33/SYHKbD0CO/5n13cENHA==
Date: Tue, 6 Aug 2019 16:54:54 +0000
Message-ID: <20190806165429.19327-11-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: eb208243-9f56-4c54-acaa-08d71a8ece37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB4233; 
x-ms-traffictypediagnostic: DM6PR12MB4233:
x-microsoft-antispam-prvs: <DM6PR12MB42338160E60B5EA0549E3460E5D50@DM6PR12MB4233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(2501003)(71200400001)(36756003)(81166006)(71190400001)(81156014)(54906003)(5660300002)(1076003)(25786009)(7736002)(6116002)(305945005)(8676002)(76176011)(6916009)(68736007)(3846002)(8936002)(2351001)(99286004)(478600001)(102836004)(64756008)(66946007)(66446008)(66476007)(386003)(6506007)(66556008)(26005)(4326008)(50226002)(2616005)(186003)(476003)(6512007)(6486002)(486006)(86362001)(5640700003)(53936002)(66066001)(316002)(14454004)(11346002)(2906002)(446003)(256004)(14444005)(6436002)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4233;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i4YlR3HIlyxNXiME6LNdDYpcipKIIhRzWl7kB0BDN8cE2yqYZS+sGeiQGcTL0wD4u/gEwPP06eEqbULJKCKA4ux5tQQVSYPUyoFnMygWLoO932MxObB/ykI6aInK79KF0T6V+wSrZKUZTtw72A0GJwIlv/1HsOkV+5MQmCNt6592jUF3pGdLOQhhjfvWMp/yVh7w+cme8AUvzO0c3qyljcmDsEY/dFsegFhdWafzQ8Jci+/KEs+dQTfHieoisHfcWbT6Yfk63XZqwtN0/aKY2fT/fMrfID37IEK5AM2JGBPSh4+btl7p7LNSK3ZJOECBPQh2GFzglESbebcqBfGjL5j6yg9+p/1lcoGdk7eE4E8T5OFdzigJEtkgDsu6Dz3GrMC826FmEo1caX89s/YO2qP3G0YKB6X/l2xmC0hGbBQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb208243-9f56-4c54-acaa-08d71a8ece37
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:54:54.6006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.55
Subject: [Qemu-devel] [PATCH v3 10/14] target/i386: sev: add support to load
 incoming encrypted page
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

The sev_load_incoming_page() provide the implementation to read the
incoming guest private pages from the socket and load it into the guest
memory. The routines uses the RECEIVE_START command to create the
incoming encryption context on the first call then uses the
RECEIEVE_UPDATE_DATA command to load the encrypted pages into the guest
memory. After migration is completed, we issue the RECEIVE_FINISH command
to transition the SEV guest to the runnable state so that it can be
executed.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/kvm-all.c      |   6 ++
 accel/kvm/sev-stub.c     |   5 ++
 include/sysemu/sev.h     |   1 +
 target/i386/sev.c        | 137 ++++++++++++++++++++++++++++++++++++++-
 target/i386/trace-events |   3 +
 5 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a5b0ae9363..ba0e7fa2be 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -180,9 +180,15 @@ static int kvm_memcrypt_save_outgoing_page(QEMUFile *f=
, uint8_t *ptr,
                                   bytes_sent);
 }
=20
+static int kvm_memcrypt_load_incoming_page(QEMUFile *f, uint8_t *ptr)
+{
+    return sev_load_incoming_page(kvm_state->memcrypt_handle, f, ptr);
+}
+
 static struct MachineMemoryEncryptionOps sev_memory_encryption_ops =3D {
     .save_setup =3D kvm_memcrypt_save_setup,
     .save_outgoing_page =3D kvm_memcrypt_save_outgoing_page,
+    .load_incoming_page =3D kvm_memcrypt_load_incoming_page,
 };
=20
 int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
diff --git a/accel/kvm/sev-stub.c b/accel/kvm/sev-stub.c
index 51b17b8141..1b6773ef72 100644
--- a/accel/kvm/sev-stub.c
+++ b/accel/kvm/sev-stub.c
@@ -36,3 +36,8 @@ int sev_save_outgoing_page(void *handle, QEMUFile *f, uin=
t8_t *ptr,
 {
     return 1;
 }
+
+int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr)
+{
+    return 1;
+}
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index f06fd203cd..e9371bd2dd 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -22,4 +22,5 @@ int sev_save_setup(void *handle, const char *pdh, const c=
har *plat_cert,
                    const char *amd_cert);
 int sev_save_outgoing_page(void *handle, QEMUFile *f, uint8_t *ptr,
                            uint32_t size, uint64_t *bytes_sent);
+int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr);
 #endif
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1820c62a71..a689011991 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -721,13 +721,34 @@ sev_launch_finish(SEVState *s)
     }
 }
=20
+static int
+sev_receive_finish(SEVState *s)
+{
+    int error, ret =3D 1;
+
+    trace_kvm_sev_receive_finish();
+    ret =3D sev_ioctl(s->sev_fd, KVM_SEV_RECEIVE_FINISH, 0, &error);
+    if (ret) {
+        error_report("%s: RECEIVE_FINISH ret=3D%d fw_error=3D%d '%s'",
+                __func__, ret, error, fw_error_to_str(error));
+        goto err;
+    }
+
+    sev_set_guest_state(SEV_STATE_RUNNING);
+err:
+    return ret;
+}
+
+
 static void
 sev_vm_state_change(void *opaque, int running, RunState state)
 {
     SEVState *s =3D opaque;
=20
     if (running) {
-        if (!sev_check_state(SEV_STATE_RUNNING)) {
+        if (sev_check_state(SEV_STATE_RECEIVE_UPDATE)) {
+            sev_receive_finish(s);
+        } else if (!sev_check_state(SEV_STATE_RUNNING)) {
             sev_launch_finish(s);
         }
     }
@@ -1097,6 +1118,120 @@ int sev_save_outgoing_page(void *handle, QEMUFile *=
f, uint8_t *ptr,
     return sev_send_update_data(s, f, ptr, sz, bytes_sent);
 }
=20
+static int
+sev_receive_start(QSevGuestInfo *sev, QEMUFile *f)
+{
+    int ret =3D 1;
+    int fw_error;
+    struct kvm_sev_receive_start start =3D { };
+    gchar *session =3D NULL, *pdh_cert =3D NULL;
+
+    /* get SEV guest handle */
+    start.handle =3D object_property_get_int(OBJECT(sev), "handle",
+                                           &error_abort);
+
+    /* get the source policy */
+    start.policy =3D qemu_get_be32(f);
+
+    /* get source PDH key */
+    start.pdh_len =3D qemu_get_be32(f);
+    if (!check_blob_length(start.pdh_len)) {
+        return 1;
+    }
+
+    pdh_cert =3D g_new(gchar, start.pdh_len);
+    qemu_get_buffer(f, (uint8_t *)pdh_cert, start.pdh_len);
+    start.pdh_uaddr =3D (uintptr_t)pdh_cert;
+
+    /* get source session data */
+    start.session_len =3D qemu_get_be32(f);
+    if (!check_blob_length(start.session_len)) {
+        return 1;
+    }
+    session =3D g_new(gchar, start.session_len);
+    qemu_get_buffer(f, (uint8_t *)session, start.session_len);
+    start.session_uaddr =3D (uintptr_t)session;
+
+    trace_kvm_sev_receive_start(start.policy, session, pdh_cert);
+
+    ret =3D sev_ioctl(sev_state->sev_fd, KVM_SEV_RECEIVE_START,
+                    &start, &fw_error);
+    if (ret < 0) {
+        error_report("Error RECEIVE_START ret=3D%d fw_error=3D%d '%s'",
+                ret, fw_error, fw_error_to_str(fw_error));
+        goto err;
+    }
+
+    object_property_set_int(OBJECT(sev), start.handle, "handle", &error_ab=
ort);
+    sev_set_guest_state(SEV_STATE_RECEIVE_UPDATE);
+err:
+    g_free(session);
+    g_free(pdh_cert);
+
+    return ret;
+}
+
+static int sev_receive_update_data(QEMUFile *f, uint8_t *ptr)
+{
+    int ret =3D 1, fw_error =3D 0;
+    gchar *hdr =3D NULL, *trans =3D NULL;
+    struct kvm_sev_receive_update_data update =3D {};
+
+    /* get packet header */
+    update.hdr_len =3D qemu_get_be32(f);
+    if (!check_blob_length(update.hdr_len)) {
+        return 1;
+    }
+
+    hdr =3D g_new(gchar, update.hdr_len);
+    qemu_get_buffer(f, (uint8_t *)hdr, update.hdr_len);
+    update.hdr_uaddr =3D (uintptr_t)hdr;
+
+    /* get transport buffer */
+    update.trans_len =3D qemu_get_be32(f);
+    if (!check_blob_length(update.trans_len)) {
+        goto err;
+    }
+
+    trans =3D g_new(gchar, update.trans_len);
+    update.trans_uaddr =3D (uintptr_t)trans;
+    qemu_get_buffer(f, (uint8_t *)update.trans_uaddr, update.trans_len);
+
+    update.guest_uaddr =3D (uintptr_t) ptr;
+    update.guest_len =3D update.trans_len;
+
+    trace_kvm_sev_receive_update_data(trans, ptr, update.guest_len,
+            hdr, update.hdr_len);
+
+    ret =3D sev_ioctl(sev_state->sev_fd, KVM_SEV_RECEIVE_UPDATE_DATA,
+                    &update, &fw_error);
+    if (ret) {
+        error_report("Error RECEIVE_UPDATE_DATA ret=3D%d fw_error=3D%d '%s=
'",
+                ret, fw_error, fw_error_to_str(fw_error));
+        goto err;
+    }
+err:
+    g_free(trans);
+    g_free(hdr);
+    return ret;
+}
+
+int sev_load_incoming_page(void *handle, QEMUFile *f, uint8_t *ptr)
+{
+    SEVState *s =3D (SEVState *)handle;
+
+    /*
+     * If this is first buffer and SEV is not in recieiving state then
+     * use RECEIVE_START command to create a encryption context.
+     */
+    if (!sev_check_state(SEV_STATE_RECEIVE_UPDATE) &&
+        sev_receive_start(s->sev_info, f)) {
+        return 1;
+    }
+
+    return sev_receive_update_data(f, ptr);
+}
+
 static void
 sev_register_types(void)
 {
diff --git a/target/i386/trace-events b/target/i386/trace-events
index b41516cf9f..609752cca7 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -18,3 +18,6 @@ kvm_sev_launch_finish(void) ""
 kvm_sev_send_start(uint64_t pdh, int l1, uint64_t plat, int l2, uint64_t a=
md, int l3) "pdh 0x%" PRIx64 " len %d plat 0x%" PRIx64 " len %d amd 0x%" PR=
Ix64 " len %d"
 kvm_sev_send_update_data(void *src, void *dst, int len) "guest %p trans %p=
 len %d"
 kvm_sev_send_finish(void) ""
+kvm_sev_receive_start(int policy, void *session, void *pdh) "policy 0x%x s=
ession %p pdh %p"
+kvm_sev_receive_update_data(void *src, void *dst, int len, void *hdr, int =
hdr_len) "guest %p trans %p len %d hdr %p hdr_len %d"
+kvm_sev_receive_finish(void) ""
--=20
2.17.1


