Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A41C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82DBB206EE
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="PU+e9zHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DBB206EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1ab-0006GO-Vx
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 17:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TP-000842-04
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TN-0007cs-Jv
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:50 -0500
Received: from mail-dm3nam03on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::72d]:36592
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TN-0007S1-CT
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuFGXjSjzBpP1iXA3MdzChAVggczH5spic/y6JSXnc/xrha9HmsEJ0N+w83qukR0yUOlUVDCpUw+HBPh8yN7GOtQ46LXg/gddphLOYzdO7lbKxS8Q+o6ge3cuu+uIFla7/1bc6Zl+0Y+vhgtwY19v9eY9PcYcE+IooyAbrY3OAr+2vZ5F1VWtpEdKk0muhA2d+gjK6mhTkeYn7EbPozYjcNYF8EI6cHyzr19xB9eXo6Cx473rnw8dMISJY2iCRgQHiHBLMT+TSLt3BzYrvKN9YMY18HRpoRtPoFByWf16ZyPtHpsi+9mOvbgL066p/jMoviu19uH/BsuxYXmknqeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f42GtU1dundjmqPvroCQkoGlcLjCzxTHi8ThvTWFiS8=;
 b=KBBL26EJNvVgvIx89rjzDCoGcgEWyOLPcDjbB9uSiDbXLiLO8RW5qez+OA6FK3oYg3Q/PmLwWpGzYGv99PUoz8AE7xjViNywSApcIDWIpkBny9xIrPSLsWJrmyNPiYtLdnlYSKIBfV0MR1eHKsuIAdxu4QPab94RPH/naG/4x9ROEi8Ws2nzpOwRWNIqjLNdy1+mjBI7VgdTBzobnFFt5ie+d+Peovv/LqIZrPio9P+p1LhBk71YCWC51BHOFRXdspAVWjCznWvZ745nejRxnK6tQ1ofdqxjN2WHj9spa4DpiWdYkVobCXUnKXpUVy4fobkPl5KZyFgTCnm75YsRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f42GtU1dundjmqPvroCQkoGlcLjCzxTHi8ThvTWFiS8=;
 b=PU+e9zHfYW/sA/c+2CjizdooW4TIrFPL1sJna7JgQpdbdRHw/4s9QLwN+neubu79LhMLju7voTos6II5Zv+tRDBTIdMSBxOTk5SUmhl3w9gVzIeqhIjFEdU6chnIwH0Z1xS/dt0KegLzjCYQjI7B9PK6f/hRdElcPzHgIDgxE3A=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:44 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:44 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 03/20] fuzz: Add FUZZ_TARGET module type
Thread-Topic: [PATCH v5 03/20] fuzz: Add FUZZ_TARGET module type
Thread-Index: AQHVmnTHbvrlThPAcUGTicmar6Ddcg==
Date: Wed, 13 Nov 2019 22:50:43 +0000
Message-ID: <20191113225030.17023-4-alxndr@bu.edu>
References: <20191113225030.17023-1-alxndr@bu.edu>
In-Reply-To: <20191113225030.17023-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::41) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a81ccc06-ef6f-4e1c-c281-08d7688bea23
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB5024DD213C6EAEDA1E6B3268BA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(14444005)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(4744005)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jde02/ZcdSXP6js7zPQWXny3SwRqw9oCPpe+gqiYs8+AoU+tbHW9cKH0vo59Cr4Qh/TKtWkO21Xo+wQZW78amJMmM6nlbW4ENJYiF7vMJPxL1RsILfSFZ39Ex1pP2GtGpXsWi8kh7hgr2xIGqn/xvpWmBLLcHXKxxggo7duQssxfs77E2tO99Uwr0iv6ttu5oQhZDqjXNIvcSw0KpkPLgxDDzYVn8JjN/w/FVZ4sj3BR2kQ48fzveWo3tyMWjHN5xuQGKWTiUmacZaFn1ikoL2Ir5IuPQ6j/ewpXNxQj5cETny/C9xgjDh/mr9BKhUaqMWtwCMRnr8/kP8DiuL484abu8c8CX/QTQHX3aF176TBN/Q+ITlTP6NC9FQNsJGyhJVhfNZKT/vN8yvK+u2mVjge23AnE7COOJY5M2Zi0ikIe6k/AlmieWhRgVOM8/RQ+
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a81ccc06-ef6f-4e1c-c281-08d7688bea23
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:43.7537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqHYnHUuIpEB6cB7J8CnU8onBH5yOVMmBS9YaVzOdrDtv99DTVSGWetU8yUUxOh1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5024
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe49::72d
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
 "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
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


