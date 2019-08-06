Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351D5C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002862075B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mqu4/2TE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002862075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2mD-0000tF-99
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 12:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50944)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jf-00041C-Tf
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2je-0003m3-Gp
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:55 -0400
Received: from mail-eopbgr710055.outbound.protection.outlook.com
 ([40.107.71.55]:41284 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hv2je-0003ei-9B
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFGPXQGfZL2e7uZGaQjApzdH4hZX8GvdRiTf8MIekqkiHAM1ySLwQzLBKLWGmWh+RKLtjkhRgRmNNWjfH4zAPhKaEdazlgnBGZ5FQTSyrP+ikxv/nVFmtzGfhU3/8XxWwW42kk8mnqgXuabSWuuoCDdUpT/+DpMB8vg7g5jlHQAYNov/cEbhInNmj6Fe8X/P3XUE2ERInqueK/Vlr/j72oVT/3OiGtmKCleakNhL8mY/6NbOPkmgiS/OWxZQiizJyK6/iicHGy5V12PZXIdCZV1NE9N/PIA8MR/IHEbZSd0/DWjXLElj7F02kGi4IXDm6ActzUxDkyXoY+zTAj8K/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4iMyP9C0DkhedLgJ7krOSFlo9/EBZuc2PeihQVh+lo=;
 b=j4VeYJ2+UyuimPenWrzGdECiN3kS6NoIZcnlBK5wb5JmtNp0tTBZLoUC8O4y1ZaGvfJ1JPzEJC46jYAi+fpvUIzgGOHlJAgp/dWWGEKyX2sL1ElRjniWza/IowsH9Vt+38s93EyFbJdZxxU+inZAHbY9hpEIE4X1BSR2GAb5x4CUe6Zhp/cissgPgwhfhug8niq8hlPDYPHwRggeMX7ZVwMDa7Iy2E5LA+HTp/3WmC+sYJZJnkUqcW5Q0ShugszHDORtN9mZ3aMj5JQkUAnwfE6Mu9Qwoqmfj8g1pBx1rv6uZUkwOkxHZAmfcFboTL9Y9CQ57GzbsL9hFQQn8yABlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4iMyP9C0DkhedLgJ7krOSFlo9/EBZuc2PeihQVh+lo=;
 b=mqu4/2TEPHrPCtiG9ssRPxd0YbzSKleEhqwxpy9EHhN4CtPSM8L9to6CqoCCLAKJOx0AL1pqlcLM65DEL8VHUJy0GG+UMbt85OrMOfAtS6vYLq4Z5wSh7rbY6phGxkUlPxyuwJCTzso9R48G8nQpMOgSA86e9jHj4sQVk8MD5uU=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB4233.namprd12.prod.outlook.com (10.141.184.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Tue, 6 Aug 2019 16:54:52 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 16:54:52 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 07/14] target/i386: sev: provide callback to setup
 outgoing context
Thread-Index: AQHVTHeqAFYxQ7DhSEOaBG3TErDUzw==
Date: Tue, 6 Aug 2019 16:54:52 +0000
Message-ID: <20190806165429.19327-8-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 99c15282-3b08-40cb-9b8a-08d71a8eccb6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB4233; 
x-ms-traffictypediagnostic: DM6PR12MB4233:
x-microsoft-antispam-prvs: <DM6PR12MB42336195AE4D732127C005D3E5D50@DM6PR12MB4233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:250;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(2501003)(71200400001)(36756003)(81166006)(71190400001)(81156014)(54906003)(5660300002)(1076003)(25786009)(7736002)(6116002)(305945005)(8676002)(76176011)(6916009)(68736007)(3846002)(8936002)(2351001)(99286004)(478600001)(102836004)(64756008)(66946007)(66446008)(66476007)(386003)(6506007)(66556008)(26005)(4326008)(50226002)(2616005)(186003)(476003)(6512007)(6486002)(486006)(86362001)(5640700003)(53936002)(66066001)(316002)(14454004)(11346002)(2906002)(446003)(256004)(6436002)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4233;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mU5xV0CSKlKUa6RoJLW9KEBdN8wttYkWlHTT7cFpuQ8Pui6AQHPscSn3lJtSUAlJpMuzRhDB26yADFM4D9I4mhahFF+6WB5AOdDmh1dgKXoL9k0+cLYuFitKy3oJZNfvZ140dA0Y4vfbxAHsv4DvtqFh19ADsznAqeUXm5L2FDrd7r1t8uPu03CfMjOzvlAPbGcAGxzSUPMqhX3cNuGb1NK4aB+XFL0imOcyYZQZ65YyvKy/CxSlRXxKiEe+oS5JfhtvOF75rS33WmOw2KnLNLqc+GAXUnufa/Ih8KHPBWqTaHrfMpxT9kNUWeiQgUGVBgSO7fNdPyjwAn4uZAQKPntS4xAPegjgLMoBDK5tUEG9lwiZDcCJu5QK50CnCLi8y1I6sIYVPuMRBtyS/jZqhcm1ZeefL0GLvrMCf9X1UBo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c15282-3b08-40cb-9b8a-08d71a8eccb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:54:52.1580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.55
Subject: [Qemu-devel] [PATCH v3 07/14] target/i386: sev: provide callback to
 setup outgoing context
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

The user provides the target machine's Platform Diffie-Hellman key (PDH)
and certificate chain before starting the SEV guest migration. Cache the
certificate chain as we need them while creating the outgoing context.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/kvm-all.c    | 12 +++++++++++
 accel/kvm/sev-stub.c   |  6 ++++++
 include/sysemu/sev.h   |  2 ++
 target/i386/sev.c      | 45 ++++++++++++++++++++++++++++++++++++++++++
 target/i386/sev_i386.h |  6 ++++++
 5 files changed, 71 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f450f25295..d0304c6947 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -165,6 +165,17 @@ bool kvm_memcrypt_enabled(void)
     return false;
 }
=20
+static int kvm_memcrypt_save_setup(const char *pdh, const char *plat_cert,
+                                   const char *amd_cert)
+{
+    return sev_save_setup(kvm_state->memcrypt_handle, pdh,
+                          plat_cert, amd_cert);
+}
+
+static struct MachineMemoryEncryptionOps sev_memory_encryption_ops =3D {
+    .save_setup =3D kvm_memcrypt_save_setup,
+};
+
 int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
 {
     if (kvm_state->memcrypt_handle &&
@@ -1968,6 +1979,7 @@ static int kvm_init(MachineState *ms)
         }
=20
         kvm_state->memcrypt_encrypt_data =3D sev_encrypt_data;
+        mc->memory_encryption_ops =3D &sev_memory_encryption_ops;
     }
=20
     ret =3D kvm_arch_init(ms, s);
diff --git a/accel/kvm/sev-stub.c b/accel/kvm/sev-stub.c
index 4f97452585..528f8cf7f1 100644
--- a/accel/kvm/sev-stub.c
+++ b/accel/kvm/sev-stub.c
@@ -24,3 +24,9 @@ void *sev_guest_init(const char *id)
 {
     return NULL;
 }
+
+int sev_save_setup(void *handle, const char *pdh, const char *plat_cert,
+                   const char *amd_cert)
+{
+    return 1;
+}
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index 98c1ec8d38..d5123d4fa3 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -18,4 +18,6 @@
=20
 void *sev_guest_init(const char *id);
 int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
+int sev_save_setup(void *handle, const char *pdh, const char *plat_cert,
+                   const char *amd_cert);
 #endif
diff --git a/target/i386/sev.c b/target/i386/sev.c
index f1423cb0c0..70e9d86815 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -27,6 +27,7 @@
 #include "sysemu/sysemu.h"
 #include "trace.h"
 #include "migration/blocker.h"
+#include "migration/qemu-file.h"
=20
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
@@ -62,6 +63,8 @@ static const char *const sev_fw_errlist[] =3D {
=20
 #define SEV_FW_MAX_ERROR      ARRAY_SIZE(sev_fw_errlist)
=20
+#define SEV_FW_BLOB_MAX_SIZE            0x4000          /* 16KB */
+
 static int
 sev_ioctl(int fd, int cmd, void *data, int *error)
 {
@@ -729,6 +732,48 @@ sev_vm_state_change(void *opaque, int running, RunStat=
e state)
     }
 }
=20
+static inline bool check_blob_length(size_t value)
+{
+    if (value > SEV_FW_BLOB_MAX_SIZE) {
+        error_report("invalid length max=3D%ld got=3D%d",
+                     value, SEV_FW_BLOB_MAX_SIZE);
+        return false;
+    }
+
+    return true;
+}
+
+int sev_save_setup(void *handle, const char *pdh, const char *plat_cert,
+                   const char *amd_cert)
+{
+    SEVState *s =3D (SEVState *)handle;
+
+    s->remote_pdh =3D g_base64_decode(pdh, &s->remote_pdh_len);
+    if (!check_blob_length(s->remote_pdh_len)) {
+        goto error;
+    }
+
+    s->remote_plat_cert =3D g_base64_decode(plat_cert,
+                                          &s->remote_plat_cert_len);
+    if (!check_blob_length(s->remote_plat_cert_len)) {
+        goto error;
+    }
+
+    s->amd_cert =3D g_base64_decode(amd_cert, &s->amd_cert_len);
+    if (!check_blob_length(s->amd_cert_len)) {
+        goto error;
+    }
+
+    return 0;
+
+error:
+    g_free(s->remote_pdh);
+    g_free(s->remote_plat_cert);
+    g_free(s->amd_cert);
+
+    return 1;
+}
+
 void *
 sev_guest_init(const char *id)
 {
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
index 55313441ae..32906de998 100644
--- a/target/i386/sev_i386.h
+++ b/target/i386/sev_i386.h
@@ -81,6 +81,12 @@ struct SEVState {
     int sev_fd;
     SevState state;
     gchar *measurement;
+    guchar *remote_pdh;
+    size_t remote_pdh_len;
+    guchar *remote_plat_cert;
+    size_t remote_plat_cert_len;
+    guchar *amd_cert;
+    size_t amd_cert_len;
 };
=20
 typedef struct SEVState SEVState;
--=20
2.17.1


