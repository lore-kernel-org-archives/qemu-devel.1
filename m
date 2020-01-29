Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC791C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8703720720
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="bjLviW/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8703720720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwg0a-00010h-Mn
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 00:35:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iwfzX-0007jN-A8
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iwfzW-0001tI-E0
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:19 -0500
Received: from mail-mw2nam10on2091.outbound.protection.outlook.com
 ([40.107.94.91]:22496 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iwfzW-0001pW-7l
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6cWeLiS+56ptQ+VKl2WfGblpHmyJV57MzJkwSLK8KYdf2c8jgn6e3aiJvwcnJ/y4zR274Wqpi7SQCAcaSg4FWNNS9snsTFZJcjlwdMc3BIJmSneL8SniA8pSd23YxZe81mn53Wi8WpqLG7u5GxJsZUoF0oG8tvQ4V0tcT9IqaEXcRUEKf8JIDy72bKRYPp/KaUa38EeIrADnqUfx2Zw+QcbXh2EX3YPiIBKhUh7dD3QPQ2EgTH/gUWZpYqIn2dQqcVsU0gfOG8DH4GgBJfSv3Kb03BajgbIOr22BZf8NC2VhomOTCUcoXfUXZ12uZEi3mbX7cxxjw5GYbb6tMZ7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDcyKBGnhfVKL9MV14vCpp1u3vtovcs2UihQKuSPZwg=;
 b=dN+Lq1qkaaMbmyimssRNxK8GwybC2vKBRl5ZrY7m92jmStpuhPRa+NoXXqpoV5NkpesYVBlBRDETpKSy4nz+W9D9evQhz6kufC3Si+y7ayXrQFFsSw3Ow+CUIFXf4/2wADUuf/Gpzpk6dzYj3b9smmrqzV1BxmB+HmP0YZOpKJCKaxqUrxQTds/yXnRjg4JPb65j5TnkwqAO2/mjTG49+hoECn5uIml8NmNynkLz4dDqxz9VS5oRfPY8UMsgSDAYDykGU7HhcEW1IWccbmKtJS7PmfgrSB7Aar9u4MDpjxyPoPzP5ChnSIo3Ocap4+7WgqL9qZ84wyCxWQi6esWXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDcyKBGnhfVKL9MV14vCpp1u3vtovcs2UihQKuSPZwg=;
 b=bjLviW/pJNuMWE8puGRIGT+50c/U1w3iFANPD/t9vcBwk1T3BDCHXqoLj9aUsZt2mH1uvD/yFZjcxim6dTpLie3rulpXs2kLFhzC5UPtjgI95268M5xGF34z1eHUaW9UQSINwD+52oCRDgmaN2A4F+8kAsCcaL75hVzjKu8CvY4=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4206.namprd03.prod.outlook.com (52.135.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 05:34:13 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 05:34:13 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19 via Frontend Transport; Wed, 29 Jan 2020 05:34:13 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v8 03/21] fuzz: add FUZZ_TARGET module type
Thread-Topic: [PATCH v8 03/21] fuzz: add FUZZ_TARGET module type
Thread-Index: AQHV1mW9M3AjBeAeDUWQvSmFUZ0yPg==
Date: Wed, 29 Jan 2020 05:34:13 +0000
Message-ID: <20200129053357.27454-4-alxndr@bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
In-Reply-To: <20200129053357.27454-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:c0::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab848bbd-e26a-49ee-be17-08d7a47cdfc4
x-ms-traffictypediagnostic: SN6PR03MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB420641D8EA9F6211CDC4BC0BBA050@SN6PR03MB4206.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(199004)(478600001)(4744005)(75432002)(36756003)(316002)(6916009)(2906002)(786003)(4326008)(54906003)(26005)(186003)(956004)(2616005)(6486002)(7696005)(52116002)(16526019)(1076003)(5660300002)(71200400001)(86362001)(66446008)(66556008)(66946007)(66476007)(8936002)(81156014)(81166006)(64756008)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4206;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g0Ca0A7vmEv09vHuyrZQ3QJdFusB6om8dFPGfQ/Zfad0dvqCrWgujNw7LzCQuFdIAkiE1CnpinDeqEqr6jtlLoxUlJrr9gJ9Q1I0I8dFJDa4RAYmq0/c6f1XT5qoH1eFfzbGDirX6FKJ3Up0Py87CRDgLeCnwMZikdrUz2BnCa0ZBs0GUaNms6gmalnU8w8wd/S/nMogVvZiFUZduBpfrahzthxZVO9SP8dnLSEcbLdJyj/+jzDKCu/dqBGnb2/X/PjX3lPy52yg83M5aoYXq7K18MzXgJ3FMgH/D3M8maoj+tmQ8yenmzuWZJC+a6K/g4MUtIuP2y/E9M17xbqGKi/cE23Mp6dNk9TO5HFRXy/hWqqcLEY1dDoIdPihfIh4xdXBDiFMXbRHmWASjYO7EPbzhSgHZMOncQifRYtQSAilHjgxipKdfgM1oh4Ylz/f
x-ms-exchange-antispam-messagedata: 89eybzVJg2+JHkCVghAKPyelrB/sm+fIgpjRk6AThtqujLcBPnLRHxebQ5EXtborpX3zMCLa7Elr2CvoKCR5tqs5ikf84lWXabU0uFPlyl3H5HfzVlcsXKw80zQuj9YO0uNXLryscyRtMHX1jk5iJQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ab848bbd-e26a-49ee-be17-08d7a47cdfc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:34:13.8054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 653YGkR+zc11x4usSqyk+WoCCuACM05EPF/zXLdgimzSSbarQd5DZOiyhN5tnH+c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4206
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.91
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
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "Bulekov, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/module.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index 65ba596e46..684753d808 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -46,6 +46,7 @@ typedef enum {
     MODULE_INIT_TRACE,
     MODULE_INIT_XEN_BACKEND,
     MODULE_INIT_LIBQOS,
+    MODULE_INIT_FUZZ_TARGET,
     MODULE_INIT_MAX
 } module_init_type;
=20
@@ -56,7 +57,8 @@ typedef enum {
 #define xen_backend_init(function) module_init(function, \
                                                MODULE_INIT_XEN_BACKEND)
 #define libqos_init(function) module_init(function, MODULE_INIT_LIBQOS)
-
+#define fuzz_target_init(function) module_init(function, \
+                                               MODULE_INIT_FUZZ_TARGET)
 #define block_module_load_one(lib) module_load_one("block-", lib)
 #define ui_module_load_one(lib) module_load_one("ui-", lib)
 #define audio_module_load_one(lib) module_load_one("audio-", lib)
--=20
2.23.0


