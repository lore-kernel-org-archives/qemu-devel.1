Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F0FC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA6720657
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="fh9mTznR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA6720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXCf-00035t-2L
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37300)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX9E-0003Ki-5y
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX9D-0001w0-2S
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:12 -0400
Received: from mail-eopbgr680122.outbound.protection.outlook.com
 ([40.107.68.122]:17806 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX9C-0001vS-J2
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWW6OGNPIO0+NKVS51lzAbwgSc77I/lxegdFJvv6/Y3Oj1B0iyqMonWkoTK42NMH6k4Ef/7z/eZ/2/IKCz/layOtbgnAP3fUAEt9CUCzDBh/ejhZwnWbcm34BttB+d1/pJ0uIQE7Tx5f6MZDOohxlvWjiRKMpA3s3r1PzEj7SxFafZhj0t1j/ZDtt15koXYgOyv5ZvVYP090h/07hv37IFMxhu39hBILDSkjkabTSpapzQSDu/yFkdQAadDpA0vxwGUW6Hz3VUpAsyfNYNOA+9q3soSJeCkbP4b9Nbtj75JMG9f2bvxEec7BJ4B87OXi+rnNdr8p6NMFXbOYCYi5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsVw/QRkgEOUa3dsfzqFSCkjGmdskWC6z6uOWWu7Mxo=;
 b=Qb8Nx7FW3EHgwWDNjMg18abl+zAnV6cdRU69knf62S22WubHWSCm0C/qT4OUFBdZWSwENCieaqzb1K6BLrMt47JIPKEwGCAB5Pe+Z2CQIlvPuAYpEYzhp5vFjm77s2tW3+3mcc2i2hNW7SwuRInyYvC5IyTSnjhmUYiOqiJWS5a5aY0SSdjcAMrD1ANK3kehthbeYqr4WRb+kzOFY+XRNsb5jFQ6D+v/Zby568ptzuK2VfuHSWTSgUwn7lNxfzX7dYU/Mkm8hbpfu4Bl+Ssz1aAUIjLtTtq+xUZVErz6OGLs03PiL571m3JxDHXV29yAMoEMXGz7c/7mDafCV+5VlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsVw/QRkgEOUa3dsfzqFSCkjGmdskWC6z6uOWWu7Mxo=;
 b=fh9mTznRqZywdCTcB+WB3Nwj7m+11cQ+afxqsFpqPMkN5qY9gab0XsOtoeLVTXXVrGQnqPbgieC8fzqTcTutgziazyZh0xV0DSuI1Jg8kh6vGiNk7jtTp6hgLV90cjDOGpOvFLePSXvw7TjoPCtZrw/IIMtsokUv6DN+gtgMAV8=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:09 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:09 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 08/17] fuzz: Export the qemu_savevm_live_state
 function
Thread-Index: AQHVS1z0nVUDC3krhEOKfy50C1cofA==
Date: Mon, 5 Aug 2019 07:11:09 +0000
Message-ID: <20190805071038.32146-9-alxndr@bu.edu>
References: <20190805071038.32146-1-alxndr@bu.edu>
In-Reply-To: <20190805071038.32146-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:207:3d::45) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe317ad5-731b-43b9-ce27-08d71974173b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB264611CCE2BFF75AC05FDEFCBADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TMnNaRDM76Ho5TlB3xHCSEWpaHg/qEU/s5Nyz8MiBCohSpi9G+TfN1/67Ru25TRYuRk52deMm9EmYnxTtLtI5qjEbgiPBXvD95k2AdW2jluGrHiwiMj4ix6L+1O6Mq+65j6EmnXDAvKwEam0Wjl7asPxfapCNpb0Qj2OgKssPuoDfxConO3vyw4c6sTfHVVIkFcJ01L2Rr3zK5lVhzkg87Lu7s8OqbPYd/TDziRdkVrlWjQjfnONPme85hBf1/bVBquDt/F/N80JF1RONbZt3HmFzyrDQbApak6OUgHUCLCt3m5oGirZ6zWSXuY0H8+9ZcRSvcGRzPKeIGr4O44eOHMhTwoFbkcZeVZ+dJSatt5k2ivZA2Iut76VYwFYbXobj5gR+7ZsRD1tnZd56hFS35YvM/KWDm4Dagkrwt+gFFg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fe317ad5-731b-43b9-ce27-08d71974173b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:09.5599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.122
Subject: [Qemu-devel] [RFC PATCH v2 08/17] fuzz: Export the
 qemu_savevm_live_state function
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
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, "Oleinik,
 Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Skip the header when saving device state, as the header isn't handled by
qemu_load_device_state

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 migration/savevm.c | 9 +++++++--
 migration/savevm.h | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 79ed44d475..5eac36e6ca 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1405,7 +1405,7 @@ void qemu_savevm_state_cleanup(void)
     }
 }
=20
-static int qemu_savevm_state(QEMUFile *f, Error **errp)
+int qemu_savevm_state(QEMUFile *f, Error **errp)
 {
     int ret;
     MigrationState *ms =3D migrate_get_current();
@@ -1471,11 +1471,16 @@ void qemu_savevm_live_state(QEMUFile *f)
 int qemu_save_device_state(QEMUFile *f)
 {
     SaveStateEntry *se;
-
+    /*
+     * qemu_load_device_state doesn't load the header. Either skip writing=
 the
+     * header or seek forward in the file, prior to loading device state
+     */
+#ifndef CONFIG_FUZZ
     if (!migration_in_colo_state()) {
         qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
         qemu_put_be32(f, QEMU_VM_FILE_VERSION);
     }
+#endif
     cpu_synchronize_all_states();
=20
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
diff --git a/migration/savevm.h b/migration/savevm.h
index 51a4b9caa8..5405215cb4 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -64,4 +64,6 @@ void qemu_loadvm_state_cleanup(void);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);
=20
+int qemu_savevm_state(QEMUFile *f, Error **errp);
+
 #endif
--=20
2.20.1


