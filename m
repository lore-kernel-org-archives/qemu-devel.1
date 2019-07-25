Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CABC7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160AD22AED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="IzMetGSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160AD22AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUMg-0005Uf-70
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40144)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUMB-0003xG-Kl
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUMA-0001oW-Mb
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:51 -0400
Received: from mail-eopbgr810120.outbound.protection.outlook.com
 ([40.107.81.120]:6127 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUMA-0001mt-GE
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwQH0dJnGCU3M2l34XC9Hs5EThy8Cw4fRmjAKe5ycxAn8LZIVi7mlqsdMD5YhghqvHpzMHP6NKXbao1FVDRwPRLz4BaO03sn6BjdtxmkNJPRLOQ21SX4KfZ6q6t1F+UyuIuSWs8clrfT+1Ni+BY80WHxCsLkaoPmevKmA7LnjBECsnT0ifuMFJlFs7RMIa1cP7JgMxD7JhesZi76Dp4El2k4RgqhxyKBO5nokaQUYd+ec18cJD0f0NbOlZ2iZ/3ljz+fmli26j7keEhXEA9ZShmDzBkGcTPR2JKE5OvlxAFwkmNnkZXucxfLawXsiChENSmuj1LEjzniDAHFzbDSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CkcpSdjqTQXR7KE0qSJDjyJFMc0lcnIutT7JHX6pXA=;
 b=Qnoph2Tgzkv9v0nfPqzE/u8v7JTLm+YK6CROJdhvgEQPFT4NszPDG0hcxYGrxFlv8FQz1Sni1t8+oSRTgu4FaTytMTXGcG5U+INUOL7+yB5hwL3E77X7Qtxfp0wrw3hCTR23nQMHhQ7x4EQR9L5YTbySbjvJHrK/bxfim2jpHuktBRfZXK9Ed4r6Y5PQusqgxPWEl/inHc3i8CA/t9a4nAcVfMg26iqUh5ktmlO5bOf3HTMlEIBLQVh92dFFzO59KgTwSIgHXfWYvbZzdBbY4NojHwAd0OKCwTS1djCHPS0mmPZEI7fTGn2SIZCW0xXPWWvDglnsoZWcFnVc/TlFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CkcpSdjqTQXR7KE0qSJDjyJFMc0lcnIutT7JHX6pXA=;
 b=IzMetGSecOhNHt6ynAf6jLXEtSPhvfQ91hDMTkqPD28W4Wi2iY47zEgQo0TO2KcSFRa2rZOKWOMSDhk2HEnSUlqCzZuoXEzgylAVKMECum/nPM5umX5a/nw6dVVbxSq3pK0btSKvtXZGkL9JeUF5oyYvXXVjy88rnGfFYnwXxU0=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2726.namprd03.prod.outlook.com (10.173.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:23:48 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:23:48 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 05/19] fuzz: expose qemu_savevm_state & skip state header
Thread-Index: AQHVQphf00Of8EfzIU6Dfljoa6uWtQ==
Date: Thu, 25 Jul 2019 03:23:48 +0000
Message-ID: <20190725032321.12721-6-alxndr@bu.edu>
References: <20190725032321.12721-1-alxndr@bu.edu>
In-Reply-To: <20190725032321.12721-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:207:3d::16) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd61530f-c5ef-492b-17f5-08d710af81e3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2726; 
x-ms-traffictypediagnostic: CY4PR03MB2726:
x-microsoft-antispam-prvs: <CY4PR03MB27264D21ECA444C5843F9DF0BAC10@CY4PR03MB2726.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(50226002)(3846002)(53936002)(6512007)(14454004)(66066001)(5660300002)(6116002)(25786009)(68736007)(316002)(99286004)(54906003)(1076003)(2351001)(2501003)(2616005)(75432002)(7736002)(76176011)(52116002)(305945005)(6436002)(71200400001)(6506007)(26005)(6916009)(478600001)(8936002)(5640700003)(786003)(86362001)(4326008)(256004)(88552002)(71190400001)(386003)(2906002)(476003)(66946007)(446003)(11346002)(8676002)(81156014)(81166006)(66476007)(66446008)(36756003)(6486002)(66556008)(64756008)(486006)(186003)(102836004)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2726;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y3s4ekXnvtvID29hT3jB1aTf9MG0yM7kpvESBWfty0k0UGvUOhzTE/xneKxHf0+hSnCE6tzRAez56CNqPU3OrLLvyir3njT7BG+H14I/Rhe+z9Su2mTYDV9w0ZZJ3Ngi1sHDuF95UgFXDoAXU9cbrEbjlBS7bz4aOSMaKKsS7J+N80W0Rvj7AnNHYS17IxJChLAipV1r4Xbwi2TJeWPyiE1h33TiU32xquAkcxyBlh9hSM66eErI9k0DyzaNxmD6zMtJ4ZKgLufjZAPjur15DAqsCTuj8wvnnp4Tq0weyrKuqJdPFzwGsYmfe0ODDiJhU7lf6J/Ebf6JQ4vYFgLOrjs4z8KMWyBi5UCyi+PtvJiYx9aIWnlzmyb794CmYHqbUEHhbbrgkO8i4ZYM9qHgv7CePU0QzwNbVoI8IhptUDA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: cd61530f-c5ef-492b-17f5-08d710af81e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:23:48.2318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2726
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.120
Subject: [Qemu-devel] [RFC 05/19] fuzz: expose qemu_savevm_state & skip
 state header
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
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 migration/savevm.c | 8 ++++++--
 migration/savevm.h | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 79ed44d475..80c00ea560 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1404,8 +1404,11 @@ void qemu_savevm_state_cleanup(void)
         }
     }
 }
-
+#ifdef CONFIG_FUZZ
+int qemu_savevm_state(QEMUFile *f, Error **errp)
+#else
 static int qemu_savevm_state(QEMUFile *f, Error **errp)
+#endif
 {
     int ret;
     MigrationState *ms =3D migrate_get_current();
@@ -1471,11 +1474,12 @@ void qemu_savevm_live_state(QEMUFile *f)
 int qemu_save_device_state(QEMUFile *f)
 {
     SaveStateEntry *se;
-
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
index 51a4b9caa8..30315d0cfd 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -64,4 +64,7 @@ void qemu_loadvm_state_cleanup(void);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);
=20
+#ifdef CONFIG_FUZZ
+int qemu_savevm_state(QEMUFile *f, Error **errp);
+#endif
 #endif
--=20
2.20.1


