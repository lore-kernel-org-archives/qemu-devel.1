Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77832C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435E12073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="k7/IheOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435E12073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQPU-0003Mh-EL
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 01:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1f-0007Es-8f
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1c-0006Rd-PT
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:03 -0500
Received: from mail-bn7nam10on2137.outbound.protection.outlook.com
 ([40.107.92.137]:56161 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1c-0006RK-Kx
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaoNWI6boG0/naGiZhBzznc9/dtwqVk0cgoIabqa5wWO9dt9yCSAtytB9ElfYbS402wIJHtaTSq7soAWB+nq5+1ra4VSWaozbNcV/uqNqRryLFlbFStwYgIhaOHaMjhnNzj0ZM9qK+m2E/lJ6grH89av9NLUW8zhSPwxRVydHYaA+Rjh2l4uaki08xAdVyEYqnB8PXP578fmOExnKq1iCuSYawI1DiQEOVuB2w7WAd9Y4jkqtdvCvZZthuIk1t3U0UnIRsQz/eVlU3AfhI6v5nXfytPi1b/GtQJmvRdO3fogs3ZWfsmki+icZIffTkHXCGPGrMOdB3LB2GujHHckLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui0cO3mn4zGmGs0rIHRGsmsj5MEjM8q6EfnLFSQsmv4=;
 b=VFkHZCM7annUsUPAiYNF5vGnTKunYIpLj72eQT2tRV8VKd5bhpgKLcLECeXDzdTmNfPSW1GiNfoG78EdpBjQ7MSZ86JN2+RssgGaIxUQpeIOGy02iS8FfO2hkdlTY3MJo+xEKa8zsww8wbg7OsTeh5TLiVAZ4bKLhR2Eeh6XqsE9BevbNLc/Ki131bGLAd78KEL3ZYMs/iFw/ZR0wjYt9mxGhzqo0k0sPwFauz2+sx75ma/3BNsUmpQQTjv+1bs6mCC3QCnVM421PP93biIZoimWFQBjzgxqk77xb3OjUz/yxv67wmXebYsSdEyGVdWdkRYxlwTq3gV2e87jATI7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui0cO3mn4zGmGs0rIHRGsmsj5MEjM8q6EfnLFSQsmv4=;
 b=k7/IheOBAQ+WzqHJvGr+2cBq3h7Xb03PGc5Hc74MSc1ZyIcsSXfNYLn/IY51xrGE6yttvs2fWFmtgLGvRX6ovX8D45ZkOvVAhIVRiv9QjUWWnGbGl6nw99BPG4VSDJor6v2QWRRqlyYaW3LSMFccyd4ez2CqVVsstYshbxaArmw=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:54:59 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:54:59 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:54:58 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 12/20] exec: keep ram block across fork when using qtest
Thread-Topic: [PATCH v7 12/20] exec: keep ram block across fork when using
 qtest
Thread-Index: AQHVz1YmyMQHZuW7XUiNZvtV7JSQOw==
Date: Mon, 20 Jan 2020 05:54:59 +0000
Message-ID: <20200120055410.22322-18-alxndr@bu.edu>
References: <20200120055410.22322-1-alxndr@bu.edu>
In-Reply-To: <20200120055410.22322-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:208:e8::45) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 305f31b8-2321-429a-8ddd-08d79d6d4880
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB4399514A2FD6E16B39731986BA320@SN6PR03MB4399.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(956004)(2616005)(8936002)(86362001)(6916009)(6486002)(7696005)(1076003)(52116002)(316002)(71200400001)(16526019)(186003)(786003)(478600001)(2906002)(26005)(81166006)(66946007)(66476007)(64756008)(36756003)(8676002)(75432002)(81156014)(66446008)(4326008)(66556008)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4399;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pXIRwzizj6sulw+IzwxNWjEn5VtFWV3sgo8ROLq1mL0FaHRAQD26mw6ptuHv7Z3Nrv9BadE7EoaSRQjtzPp5RyqQJfpi2314p8cS6bns8Axv2GuEqol5q+zWeOW3ErlAapS9XyP0uJucW/nECgQXh+GbbzW6tBtGyMFasOcGO/Og2PU/QGBNeX+NW6bBM6hhBqWF3rngyMD0cloPjkrwU4fZHxfxm1vIbXniycUiyJCZvYbKMTuX3kQ+0YNYQxguQptbAy6l9c3F4RB+rKDtvpBp/zojqhy96PiWo/O6VCA+C5FR4P6RSoo3NPA845b4Z66YLJ2H3cFua5nm6nBGz+RpSQgSbcAm6uq3z92qxF1G4ytn/IXs13Bl7ZOYyS3I+tS7/0VGtOESeehWWPt+/x80atYY2ThsotFgmSsYTFisg9BzUiZGqKzaE484iZHP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 305f31b8-2321-429a-8ddd-08d79d6d4880
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:54:59.3293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPST2ncAgTM4bT7I8EOnrrg5HWibEjXe8le1tgov4cA4LE9Uq4MvhqEmzO3ZpTbQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.137
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Bulekov, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ram blocks were marked MADV_DONTFORK breaking fuzzing-tests which
execute each test-input in a forked process.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 exec.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index d4b769d0d4..99368f175b 100644
--- a/exec.c
+++ b/exec.c
@@ -35,6 +35,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
+#include "sysemu/qtest.h"
 #include "qemu/timer.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
@@ -2306,8 +2307,15 @@ static void ram_block_add(RAMBlock *new_block, Error=
 **errp, bool shared)
     if (new_block->host) {
         qemu_ram_setup_dump(new_block->host, new_block->max_length);
         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUG=
EPAGE);
-        /* MADV_DONTFORK is also needed by KVM in absence of synchronous M=
MU */
-        qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_DON=
TFORK);
+        /*
+         * MADV_DONTFORK is also needed by KVM in absence of synchronous M=
MU
+         * Configure it unless the machine is a qtest server, in which cas=
e
+         * KVM is not used and it may be forked (eg for fuzzing purposes).
+         */
+        if (!qtest_enabled()) {
+            qemu_madvise(new_block->host, new_block->max_length,
+                         QEMU_MADV_DONTFORK);
+        }
         ram_block_notify_add(new_block->host, new_block->max_length);
     }
 }
--=20
2.23.0


