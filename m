Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270E0C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EBE20578
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YI2KJq6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EBE20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2nW-0003hm-6U
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 12:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50888)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2je-0003zf-1y
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hv2jc-0003i3-Bf
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:54 -0400
Received: from mail-eopbgr710055.outbound.protection.outlook.com
 ([40.107.71.55]:41284 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hv2jc-0003ei-4c
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:54:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVF4OKkq/2GPUfwGX0cP5fxYcRq9WfP5QmgPDncjre9Ij84YbjHGRHqieScqZOHOn3z8HTozskAYjRUeQcANctNcSF7+ycUXEYXXenklTdkWYBP86RYYD0S6s7GAgIGfCn/kXGN1bQNHgCwBT0uONPvcvTTFvDwsEh5KW6LgdhCtyMMRm/JxCyh9KXBRWh2cwKCWY/xCgtUst/kjpyH1T0BC4KL5SDJ0wlB8a9frMFCg5frbnDSBvM+D2Nar82Yor4XSpfC4BHWHOA8ZZ2fEvy/VE4cqrdXb+CwmHaeBtt6sjrMtDUAUC3yxXAB+BQqC+SpXxrucGgRT09LC/52ktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xGY6k4izIRMq1nHfe74JtfJtz/xPoPEgZ4BQdYuLH8=;
 b=iwGQFW/45WCP6btpCRuG0CnvKMklZNrZy7CV9SrW5SvWRUjrIYlAomY5UGk6ttlfzIN+UoPrFNDLh9UEH/TAv0TEujmTT5s5+q4sd6rseGSSEel2tD//qYfrgjqusb7r//j7khjf5qlmcOeXgIR3pG2A/ewDHFgkUBWswkN4CTYNPHYWBeSPq2RQRobg5JlVd5X3rQUPsV5NUwq1AH37FZgm9/NYE7nC+BGwJs4pTbFJyQ+N30PIZ2FGNYSx8ZlTw9EgrCF1JPSTST94teWsdNxq2XIGq0MwvHYKCYhmIvY6pF33jf/Ixz/0aYeaRDEtZ/2UvtQ5u5uexB89gk0n+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xGY6k4izIRMq1nHfe74JtfJtz/xPoPEgZ4BQdYuLH8=;
 b=YI2KJq6D+iuI45YR96Xu4Mt4ViSfEZBiI5NVkj38gAUlGeoSkPoAudJQUJls4pyB8pOZljE+KIs2EznWFWv7bfrYEROpkSkdBtjpPtXdrI0OLN1o50CR6W3EOUl4KrTqsTKS8ONc7bJ3lliX/R39KxRlyLYCAgcwzL9fMfWcPos=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB4233.namprd12.prod.outlook.com (10.141.184.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Tue, 6 Aug 2019 16:54:49 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 16:54:49 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 03/14] migration.json: add AMD SEV specific migration
 parameters
Thread-Index: AQHVTHeogJaMsuQ2A0iis34XZsrCEw==
Date: Tue, 6 Aug 2019 16:54:48 +0000
Message-ID: <20190806165429.19327-4-brijesh.singh@amd.com>
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
x-ms-office365-filtering-correlation-id: 0891bee3-2d8d-46f2-9f09-08d71a8eca86
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB4233; 
x-ms-traffictypediagnostic: DM6PR12MB4233:
x-microsoft-antispam-prvs: <DM6PR12MB423360842B48A6EB3F36258EE5D50@DM6PR12MB4233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(2501003)(71200400001)(36756003)(81166006)(71190400001)(81156014)(54906003)(5660300002)(1076003)(25786009)(7736002)(6116002)(305945005)(8676002)(76176011)(6916009)(68736007)(3846002)(8936002)(2351001)(99286004)(478600001)(102836004)(64756008)(66946007)(66446008)(66476007)(386003)(6506007)(66556008)(26005)(4326008)(50226002)(2616005)(186003)(476003)(6512007)(6486002)(486006)(86362001)(5640700003)(53936002)(66066001)(316002)(14454004)(11346002)(2906002)(446003)(256004)(14444005)(6436002)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4233;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MBBICxNqJE8AD+fGPVsnhvcX1tRoX0q17gLri9TvessKulVE8B09Koy1JSMvjpxrIbya5R/hkbC2IkF/GUUkOxEYtpLyh+QJ6/SZhd01Uq9j1fHc4JhQo2l6CqdBCk1I2mot6uAnplEelm2h0uE75OweYo645qqvZngpJQXNcRbhPdDNE+mcndcIOF6jkCuv7r+BKpZ4zZEqQhpio0nz2jIRtlWG/BovxwtPHuWkxErbNh/Cc16DCPtE/2Rh0wp73+S/pIboVTuxJW9xaGGSb+3v9kJaIE/+rbCHIh3klMnPcUyReeAMoTZFQe17PY30jl3CdPHzu6Il3EGW3pVeTihu9tkb0OvKn4MHPMFfJ90iOLTEkq4XGi502WwK51CH8E9dPmny0zBJG6gOIK4pX9MK7WfXqfsVr4EyTsFzEGo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0891bee3-2d8d-46f2-9f09-08d71a8eca86
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 16:54:48.4791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.55
Subject: [Qemu-devel] [PATCH v3 03/14] migration.json: add AMD SEV specific
 migration parameters
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

AMD SEV migration flow requires that target machine's public Diffie-Hellman
key (PDH) and certificate chain must be passed before initiating the guest
migration. User can use QMP 'migrate-set-parameters' to pass the certificat=
e
chain. The certificate chain will be used while creating the outgoing
encryption context.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---

I was able to pass the certificate chain through the HMP but somehow
QMP socket interface is not working for me. If anyone has any tips on
what I am missing in the patch then please let me know. In meantime,
I will also continue my investigation on why its not working for me.

 migration/migration.c | 61 +++++++++++++++++++++++++++++++++++++++++++
 monitor/hmp-cmds.c    | 18 +++++++++++++
 qapi/migration.json   | 41 ++++++++++++++++++++++++++---
 3 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8a607fe1e2..de66a0eb7e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -783,6 +783,12 @@ MigrationParameters *qmp_query_migrate_parameters(Erro=
r **errp)
     params->announce_rounds =3D s->parameters.announce_rounds;
     params->has_announce_step =3D true;
     params->announce_step =3D s->parameters.announce_step;
+    params->has_sev_pdh =3D true;
+    params->sev_pdh =3D g_strdup(s->parameters.sev_pdh);
+    params->has_sev_plat_cert =3D true;
+    params->sev_plat_cert =3D g_strdup(s->parameters.sev_plat_cert);
+    params->has_sev_amd_cert =3D true;
+    params->sev_amd_cert =3D g_strdup(s->parameters.sev_amd_cert);
=20
     return params;
 }
@@ -1289,6 +1295,18 @@ static void migrate_params_test_apply(MigrateSetPara=
meters *params,
     if (params->has_announce_step) {
         dest->announce_step =3D params->announce_step;
     }
+    if (params->has_sev_pdh) {
+        assert(params->sev_pdh->type =3D=3D QTYPE_QSTRING);
+        dest->sev_pdh =3D g_strdup(params->sev_pdh->u.s);
+    }
+    if (params->has_sev_plat_cert) {
+        assert(params->sev_plat_cert->type =3D=3D QTYPE_QSTRING);
+        dest->sev_plat_cert =3D g_strdup(params->sev_plat_cert->u.s);
+    }
+    if (params->has_sev_amd_cert) {
+        assert(params->sev_amd_cert->type =3D=3D QTYPE_QSTRING);
+        dest->sev_amd_cert =3D g_strdup(params->sev_amd_cert->u.s);
+    }
 }
=20
 static void migrate_params_apply(MigrateSetParameters *params, Error **err=
p)
@@ -1390,6 +1408,21 @@ static void migrate_params_apply(MigrateSetParameter=
s *params, Error **errp)
     if (params->has_announce_step) {
         s->parameters.announce_step =3D params->announce_step;
     }
+    if (params->has_sev_pdh) {
+        g_free(s->parameters.sev_pdh);
+        assert(params->sev_pdh->type =3D=3D QTYPE_QSTRING);
+        s->parameters.sev_pdh =3D g_strdup(params->sev_pdh->u.s);
+    }
+    if (params->has_sev_plat_cert) {
+        g_free(s->parameters.sev_plat_cert);
+        assert(params->sev_plat_cert->type =3D=3D QTYPE_QSTRING);
+        s->parameters.sev_plat_cert =3D g_strdup(params->sev_plat_cert->u.=
s);
+    }
+    if (params->has_sev_amd_cert) {
+        g_free(s->parameters.sev_amd_cert);
+        assert(params->sev_amd_cert->type =3D=3D QTYPE_QSTRING);
+        s->parameters.sev_amd_cert =3D g_strdup(params->sev_amd_cert->u.s)=
;
+    }
 }
=20
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp=
)
@@ -1410,6 +1443,27 @@ void qmp_migrate_set_parameters(MigrateSetParameters=
 *params, Error **errp)
         params->tls_hostname->type =3D QTYPE_QSTRING;
         params->tls_hostname->u.s =3D strdup("");
     }
+    /* TODO Rewrite "" to null instead */
+    if (params->has_sev_pdh
+        && params->sev_pdh->type =3D=3D QTYPE_QNULL) {
+        qobject_unref(params->sev_pdh->u.n);
+        params->sev_pdh->type =3D QTYPE_QSTRING;
+        params->sev_pdh->u.s =3D strdup("");
+    }
+    /* TODO Rewrite "" to null instead */
+    if (params->has_sev_plat_cert
+        && params->sev_plat_cert->type =3D=3D QTYPE_QNULL) {
+        qobject_unref(params->sev_plat_cert->u.n);
+        params->sev_plat_cert->type =3D QTYPE_QSTRING;
+        params->sev_plat_cert->u.s =3D strdup("");
+    }
+    /* TODO Rewrite "" to null instead */
+    if (params->has_sev_amd_cert
+        && params->sev_amd_cert->type =3D=3D QTYPE_QNULL) {
+        qobject_unref(params->sev_amd_cert->u.n);
+        params->sev_amd_cert->type =3D QTYPE_QSTRING;
+        params->sev_amd_cert->u.s =3D strdup("");
+    }
=20
     migrate_params_test_apply(params, &tmp);
=20
@@ -3466,6 +3520,9 @@ static void migration_instance_finalize(Object *obj)
     qemu_mutex_destroy(&ms->qemu_file_lock);
     g_free(params->tls_hostname);
     g_free(params->tls_creds);
+    g_free(params->sev_pdh);
+    g_free(params->sev_plat_cert);
+    g_free(params->sev_amd_cert);
     qemu_sem_destroy(&ms->rate_limit_sem);
     qemu_sem_destroy(&ms->pause_sem);
     qemu_sem_destroy(&ms->postcopy_pause_sem);
@@ -3507,6 +3564,10 @@ static void migration_instance_init(Object *obj)
     params->has_announce_rounds =3D true;
     params->has_announce_step =3D true;
=20
+    params->sev_pdh =3D g_strdup("");
+    params->sev_plat_cert =3D g_strdup("");
+    params->sev_amd_cert =3D g_strdup("");
+
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
     qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_sem, 0);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 5ca3ebe942..354219f27a 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1872,6 +1872,24 @@ void hmp_migrate_set_parameter(Monitor *mon, const Q=
Dict *qdict)
         p->has_announce_step =3D true;
         visit_type_size(v, param, &p->announce_step, &err);
         break;
+    case MIGRATION_PARAMETER_SEV_PDH:
+        p->has_sev_pdh =3D true;
+        p->sev_pdh =3D g_new0(StrOrNull, 1);
+        p->sev_pdh->type =3D QTYPE_QSTRING;
+        visit_type_str(v, param, &p->sev_pdh->u.s, &err);
+        break;
+    case MIGRATION_PARAMETER_SEV_PLAT_CERT:
+        p->has_sev_plat_cert =3D true;
+        p->sev_plat_cert =3D g_new0(StrOrNull, 1);
+        p->sev_plat_cert->type =3D QTYPE_QSTRING;
+        visit_type_str(v, param, &p->sev_plat_cert->u.s, &err);
+        break;
+    case MIGRATION_PARAMETER_SEV_AMD_CERT:
+        p->has_sev_amd_cert =3D true;
+        p->sev_amd_cert =3D g_new0(StrOrNull, 1);
+        p->sev_amd_cert->type =3D QTYPE_QSTRING;
+        visit_type_str(v, param, &p->sev_amd_cert->u.s, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/qapi/migration.json b/qapi/migration.json
index 9cfbaf8c6c..bb07995d2c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -580,6 +580,15 @@
 # @max-cpu-throttle: maximum cpu throttle percentage.
 #                    Defaults to 99. (Since 3.1)
 #
+# @sev-pdh: The target host platform diffie-hellman key encoded in base64
+#           (Since 4.2)
+#
+# @sev-plat-cert: The target host platform certificate chain encoded in ba=
se64
+#                 (Since 4.2)
+#
+# @sev-amd-cert: AMD certificate chain which include ASK and OCA encoded i=
n
+#                base64 (Since 4.2)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -592,7 +601,7 @@
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
-           'max-cpu-throttle' ] }
+           'max-cpu-throttle', 'sev-pdh', 'sev-plat-cert', 'sev-amd-cert' =
] }
=20
 ##
 # @MigrateSetParameters:
@@ -682,6 +691,15 @@
 # @max-cpu-throttle: maximum cpu throttle percentage.
 #                    The default value is 99. (Since 3.1)
 #
+# @sev-pdh: The target host platform diffie-hellman key encoded in base64
+#           (Since 4.2)
+#
+# @sev-plat-cert: The target host platform certificate chain encoded in ba=
se64
+#                 (Since 4.2)
+#
+# @sev-amd-cert: AMD certificate chain which include ASK and OCA encoded i=
n
+#                base64 (Since 4.2)
+#
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -707,7 +725,10 @@
             '*multifd-channels': 'int',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
-	    '*max-cpu-throttle': 'int' } }
+            '*max-cpu-throttle': 'int',
+            '*sev-pdh':'StrOrNull',
+            '*sev-plat-cert': 'StrOrNull',
+            '*sev-amd-cert' : 'StrOrNull' } }
=20
 ##
 # @migrate-set-parameters:
@@ -817,6 +838,15 @@
 #                    Defaults to 99.
 #                     (Since 3.1)
 #
+# @sev-pdh: The target host platform diffie-hellman key encoded in base64
+#           (Since 4.2)
+#
+# @sev-plat-cert: The target host platform certificate chain encoded in ba=
se64
+#                 (Since 4.2)
+#
+# @sev-amd-cert: AMD certificate chain which include ASK and OCA encoded i=
n
+#                base64 (Since 4.2)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -839,8 +869,11 @@
             '*block-incremental': 'bool' ,
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
-	    '*max-postcopy-bandwidth': 'size',
-            '*max-cpu-throttle':'uint8'} }
+            '*max-postcopy-bandwidth': 'size',
+            '*max-cpu-throttle':'uint8',
+            '*sev-pdh':'str',
+            '*sev-plat-cert': 'str',
+            '*sev-amd-cert' : 'str'} }
=20
 ##
 # @query-migrate-parameters:
--=20
2.17.1


