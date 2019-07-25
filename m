Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90B3C76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C3B22BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="blkpl3Ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C3B22BEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUNR-0000Mj-4M
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40118)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUMA-0003wz-F1
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUM9-0001nj-Bt
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:50 -0400
Received: from mail-eopbgr810120.outbound.protection.outlook.com
 ([40.107.81.120]:6127 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUM9-0001mt-5v
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dc1vPQTF/LnFFWQuTGo/1QZzOoq0xq+zYdHIamEepWV5sKoCNYSEMWl1ba/V+Zqh73zzsFJLCKLls44JEOsOQVZobGwlXkkWxJvuRcgm1699jzn76/2zVCCkyNEVw1eO9+UHi6PZjsN9p2O/Evu9nzEMiz6cTgTc+UJ41HyDfU8bLB+Y0te/GJzjc6yvb/ZvxWat0bLueAXnz3BOY6dz+5+4VQ9jcnrI838337iRk5HLBGqMRGaT4Fv0mE0jvFhOfv5ku8eYmAALs6XeMFuqDnPyivCrSRW20m1sle2mS2Q9u9a1Px4SP9SEipXZjOLAWvo9WS8dvmf2vzF1ffRhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjYMqT6/BF7MLNaZv2l287+T79d1p/sIrLwutZSSeKc=;
 b=img6GInmhPaQcfcGenwMtS/BD9/O4huWcqQdEApPUuRGKlScD3J+1jeQQyHc0azZC6iA4ANZ5lCEs3gEBRxgMvJV7CG471zMczUK2/sZe2hcjuSjgeI22ssoO6vKZuVY+KbDnkEJnuKvk09v6MlvMm2+14LG6j8cB3Ehpyc9kHY3c2EfehxHaeo3Ekv7PWrjv+RznMAjY3G7WjxTqwKMlSbrC1CxTY2VD58MITIqICObqDNesg7xhbq5o4ObIfdP6FjyqYnwiD42LxQa6eIizaStbzoKjFpsUQ/tJmYWWLFqgcCqE6/cJBkGnpiTdQmWBjVbU/DK5WxLnj1vsD59HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjYMqT6/BF7MLNaZv2l287+T79d1p/sIrLwutZSSeKc=;
 b=blkpl3QlPKojp2VNUORSJvFXs1OT/g/6rNweKKVvqTmQ8erD+qfgrV/z/xnBTLa6sPU2LTqi94xW+DdAMuySCWQu99akdJTlARhRrwjqurdv5nF1xwbQyKdt3bqKgDiJgPaXT1myrlkgmQt7JOPVZQH4xjITzFZI6p4OAxdIi9E=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2726.namprd03.prod.outlook.com (10.173.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:23:45 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:23:45 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 02/19] fuzz: add FUZZ_TARGET type to qemu module system
Thread-Index: AQHVQphd6kl6A62vGEuoMNhMkAtTxg==
Date: Thu, 25 Jul 2019 03:23:45 +0000
Message-ID: <20190725032321.12721-3-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: dbcbbe70-5fa2-4065-f5f2-08d710af8026
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2726; 
x-ms-traffictypediagnostic: CY4PR03MB2726:
x-microsoft-antispam-prvs: <CY4PR03MB27261E29B0489B5CC7DA826BBAC10@CY4PR03MB2726.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(50226002)(3846002)(53936002)(6512007)(14454004)(66066001)(5660300002)(6116002)(25786009)(4744005)(68736007)(316002)(99286004)(54906003)(1076003)(2351001)(2501003)(2616005)(75432002)(7736002)(76176011)(52116002)(305945005)(14444005)(6436002)(71200400001)(6506007)(26005)(6916009)(478600001)(8936002)(5640700003)(786003)(86362001)(4326008)(256004)(88552002)(71190400001)(386003)(2906002)(476003)(66946007)(446003)(11346002)(8676002)(81156014)(81166006)(66476007)(66446008)(36756003)(6486002)(66556008)(64756008)(486006)(186003)(102836004)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2726;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t5qtLg0CtufJm3jUR9P702ejIDIqEe8r+rK/xucDNudEhTw/V3sliPFPL7/qDp6S/C5JEumD3bfoiVDs7hZMBvb1YRzvjWra65x1f9C3i/C4h4WWJ4Vp/J7cinqggAQeRSkrl0uVYbNkUzfCST6keqdSuQpL/KyuyjizrjqEzbz/BNP2uz5zRVN3yyiRkW7CrU21KQzZZho0avyFdrx/V2uUVsG5tCC3sigLxK7TZXV8qOTDR1PRD4cMGOXBvLXhXCmreYxK2zVU0fuenLz9Zb+/6Hm2uf9jFMpGu2VSg+tH75lzHzsX0t5jzF/HRCzLMXpuxEe45oEjQGchrehwr+2RjZExUmjnp+r9LUNZhNyfso6XIwqb1x93cnPFmt9vxYdA4+2igD6F25/7g16JO000Em+Y7odvSnEXNxPlTyk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcbbe70-5fa2-4065-f5f2-08d710af8026
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:23:45.3971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2726
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.120
Subject: [Qemu-devel] [RFC 02/19] fuzz: add FUZZ_TARGET type to qemu module
 system
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
 "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Oleinik, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 include/qemu/module.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index db3065381d..531fe7ae29 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -46,6 +46,9 @@ typedef enum {
     MODULE_INIT_TRACE,
     MODULE_INIT_XEN_BACKEND,
     MODULE_INIT_LIBQOS,
+#ifdef CONFIG_FUZZ
+    MODULE_INIT_FUZZ_TARGET,
+#endif
     MODULE_INIT_MAX
 } module_init_type;
=20
@@ -56,7 +59,9 @@ typedef enum {
 #define xen_backend_init(function) module_init(function, \
                                                MODULE_INIT_XEN_BACKEND)
 #define libqos_init(function) module_init(function, MODULE_INIT_LIBQOS)
-
+#ifdef CONFIG_FUZZ
+#define fuzz_target_init(function) module_init(function, MODULE_INIT_FUZZ_=
TARGET)
+#endif
 #define block_module_load_one(lib) module_load_one("block-", lib)
 #define ui_module_load_one(lib) module_load_one("ui-", lib)
 #define audio_module_load_one(lib) module_load_one("audio-", lib)
--=20
2.20.1


