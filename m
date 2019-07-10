Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F984C74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E7C208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OiF8xPgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E7C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJFI-0002fF-4I
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57220)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7S-0001cl-0D
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7P-0002VO-8l
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:13 -0400
Received: from mail-eopbgr790080.outbound.protection.outlook.com
 ([40.107.79.80]:1472 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlJ7O-0002MZ-Ne
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCwJf/vy1vfgC82I+2J59nLHSF5FAZJ/E8lMaNycqyU=;
 b=OiF8xPgpSMoqTGIjXY4JWrWXmpCYGcPC7UsCfoiZvWXKZYi9AuKq9MQtJwTcsIKmPysM5exwRlS+pVFwgEPFTu8bM19xldWlL1fcZIEJe47j/3Ub/UeKyET4bBm/qMvWu0odJH+QtlwS2sf/4ri/Nq/YXAq+pGdOV2uJW4vrb4g=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3820.namprd12.prod.outlook.com (10.255.173.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Wed, 10 Jul 2019 20:23:08 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 20:23:08 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 08/13] misc.json: add migrate-set-sev-info command
Thread-Index: AQHVN11IB0jBOURssEaB+JuEzUXc9g==
Date: Wed, 10 Jul 2019 20:23:06 +0000
Message-ID: <20190710202219.25939-9-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 8aeb044e-1e6f-43d8-2b20-08d705746a6f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3820; 
x-ms-traffictypediagnostic: DM6PR12MB3820:
x-microsoft-antispam-prvs: <DM6PR12MB3820A86EDCA2FA90A0FE0F64E5F00@DM6PR12MB3820.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(256004)(8936002)(2616005)(1076003)(316002)(14444005)(476003)(81166006)(478600001)(54906003)(81156014)(2351001)(8676002)(486006)(25786009)(6436002)(6486002)(4326008)(66476007)(66946007)(446003)(53936002)(50226002)(71190400001)(66446008)(68736007)(6506007)(14454004)(386003)(5660300002)(36756003)(66066001)(186003)(6512007)(99286004)(305945005)(102836004)(26005)(2501003)(11346002)(64756008)(52116002)(5640700003)(66556008)(76176011)(86362001)(6116002)(6916009)(3846002)(7736002)(71200400001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3820;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +Npc5CYcQErpA8tdT2Sm4XN2grA+jINXf7ymJDwUjE2AZV8jPP5ilHE5D0UZosBdgH8Qai5SEIXZ/hJMymx/uAyMOl1ixCvCrYQFRibOGvLodFsc7p1TP499DSLnIr4+rFAuVZXgaE61tvuu0XOYxLO2Z19TA+sLT1oaIZObtaJT7iXqoYACAoIkt8+15BPda0UVw+o4kFLH151LvlVyjaqkzH4Zq92D62dN7WMvNob5OVe2+6xFd5jfqjNZRfmwq3jptO8em89GsTQ6g0qQRO42SvQ6/Fg+wo+jVInVaHZOP2oWjhahVM5BRaMQ8b8AdBbMLIySB621cEdiNXp2+d+L9EmLhEQXVNgP6ex/G22Ax2Xzyu69WX/mrqeettRGFTZuORa8hOCeOCr9+/tRaEMlgIvZPo1Gjro244AwPlo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aeb044e-1e6f-43d8-2b20-08d705746a6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 20:23:06.4175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3820
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.80
Subject: [Qemu-devel] [PATCH v2 08/13] misc.json: add migrate-set-sev-info
 command
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

The command can be used by the hypervisor to specify the target Platform
Diffie-Hellman key (PDH) and certificate chain before starting the SEV
guest migration. The values passed through the command will be used while
creating the outgoing encryption context.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 qapi/misc-target.json  | 18 ++++++++++++++++++
 target/i386/monitor.c  | 10 ++++++++++
 target/i386/sev-stub.c |  5 +++++
 target/i386/sev.c      | 11 +++++++++++
 target/i386/sev_i386.h |  9 ++++++++-
 5 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index a00fd821eb..938dcaea14 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -266,3 +266,21 @@
 ##
 { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
   'if': 'defined(TARGET_ARM)' }
+
+##
+# @migrate-set-sev-info:
+#
+# The command is used to provide the target host information used during t=
he
+# SEV guest.
+#
+# @pdh the target host platform diffie-hellman key encoded in base64
+#
+# @plat-cert the target host platform certificate chain encoded in base64
+#
+# @amd-cert AMD certificate chain which include ASK and OCA encoded in bas=
e64
+#
+# Since 4.2
+#
+##
+{ 'command': 'migrate-set-sev-info',
+  'data': { 'pdh': 'str', 'plat-cert': 'str', 'amd-cert' : 'str' }}
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 1f3b532fc2..4a5f50fb45 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -736,3 +736,13 @@ SevCapability *qmp_query_sev_capabilities(Error **errp=
)
=20
     return data;
 }
+
+void qmp_migrate_set_sev_info(const char *pdh, const char *plat_cert,
+                              const char *amd_cert, Error **errp)
+{
+    if (sev_enabled()) {
+        sev_set_migrate_info(pdh, plat_cert, amd_cert);
+    } else {
+        error_setg(errp, "SEV is not enabled");
+    }
+}
diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
index e5ee13309c..173bfa6374 100644
--- a/target/i386/sev-stub.c
+++ b/target/i386/sev-stub.c
@@ -48,3 +48,8 @@ SevCapability *sev_get_capabilities(void)
 {
     return NULL;
 }
+
+void sev_set_migrate_info(const char *pdh, const char *plat_cert,
+                          const char *amd_cert)
+{
+}
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 49baf8fef0..6c902d0be8 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -825,6 +825,17 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t =
len)
     return 0;
 }
=20
+void sev_set_migrate_info(const char *pdh, const char *plat_cert,
+                          const char *amd_cert)
+{
+    SEVState *s =3D sev_state;
+
+    s->remote_pdh =3D g_base64_decode(pdh, &s->remote_pdh_len);
+    s->remote_plat_cert =3D g_base64_decode(plat_cert,
+                                          &s->remote_plat_cert_len);
+    s->amd_cert =3D g_base64_decode(amd_cert, &s->amd_cert_len);
+}
+
 static void
 sev_register_types(void)
 {
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
index 55313441ae..3f3449b346 100644
--- a/target/i386/sev_i386.h
+++ b/target/i386/sev_i386.h
@@ -39,7 +39,8 @@ extern uint32_t sev_get_cbit_position(void);
 extern uint32_t sev_get_reduced_phys_bits(void);
 extern char *sev_get_launch_measurement(void);
 extern SevCapability *sev_get_capabilities(void);
-
+extern void sev_set_migrate_info(const char *pdh, const char *plat_cert,
+                                 const char *amd_cert);
 typedef struct QSevGuestInfo QSevGuestInfo;
 typedef struct QSevGuestInfoClass QSevGuestInfoClass;
=20
@@ -81,6 +82,12 @@ struct SEVState {
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


