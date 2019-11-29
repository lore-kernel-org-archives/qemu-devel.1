Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30026C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFEF224249
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="mo1wNpL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEF224249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ianzl-00069p-RH
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianua-00004u-PB
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianuY-0002ms-SQ
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:48 -0500
Received: from mail-eopbgr740102.outbound.protection.outlook.com
 ([40.107.74.102]:45028 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianuX-0002ik-VO
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coiGjGWR2q1SXoYd5m16ijaimfM77pyvh2Srtd/EamW3hOWwn37zycaOCnJ2QCwnStp+yXlPXJm+X4dI2DR+HX859lhN6voO0QSWzJXu8vu8DWuE/SDQ8tnn4wfCCrP+1gBqGTS8YiYGf9kGudfxA+XXFcYcv+EQzznIu459jDiS7JNKJLQ9fpABxOIdfXNoPR/L6TmBQoDDgJ7vAYcpj+IUyDj20M2Wt0dqo4VveZDwP88BrpriZl93rYLod/Jz3NFPxp5YYzvO9HQMfIFimfeLx9+DghkVDw0UA/NVhe+wQ12Slrog2WpDnIYj4O1KD9o4rYx8uq1Awy214iJt2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDcyKBGnhfVKL9MV14vCpp1u3vtovcs2UihQKuSPZwg=;
 b=ivkU0mmmrHeSskBhLVyBpZ8g8ay8PYGbezqupklBkTk6a7YRVvS0AIA0keOrgQ7LsSdGqzq+9RiWjj1xy/ZJ8U9Ql3hikApw/LYWPFs15tA77tr5l4/vHF18as+vmF6rmKk5H6Wu/IAQDiZ4XqbBWclib3Spw4iA+aK1Ovm6Uyx6XB9AAsxlthxYLaKacSoaTEckgMd+ivT3ZI0mHltDbmhNceb3PSzgnLy09/QP5QxYX7Uipc6/pRHPe43GGNFU0rw2vYsZHJ+S+K5UTtrlQKdCWQe4kYO6RPuLIuQ4AurqbC6OPpdEuc5jvi7dVj80abXi4ehreMUcw+crbk3JNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDcyKBGnhfVKL9MV14vCpp1u3vtovcs2UihQKuSPZwg=;
 b=mo1wNpL3EXe3RJ/1dCQBeZ/00iqp9yLI2uIZcp2IBevbeDup0HZ81E4Hv2+Gex40Ilb4L/3Sio4uf9Z1s905/cResRppWjn1I/hFIAstRt27f54SqYTt8j1q/0T82hfk4YXP7yLKjt6fjeuEmLb3UAkmyw5ZqVcf6qSUjYMYC0A=
Received: from DM6PR03MB4795.namprd03.prod.outlook.com (20.179.107.22) by
 DM6PR03MB5050.namprd03.prod.outlook.com (10.141.161.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 21:34:40 +0000
Received: from DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74]) by DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74%2]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 21:34:40 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v6 03/21] fuzz: Add FUZZ_TARGET module type
Thread-Topic: [PATCH v6 03/21] fuzz: Add FUZZ_TARGET module type
Thread-Index: AQHVpvzOhdMFHF2ESUuniN8QGvS0rA==
Date: Fri, 29 Nov 2019 21:34:39 +0000
Message-ID: <20191129213424.6290-4-alxndr@bu.edu>
References: <20191129213424.6290-1-alxndr@bu.edu>
In-Reply-To: <20191129213424.6290-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) To DM6PR03MB4795.namprd03.prod.outlook.com
 (2603:10b6:5:18c::22)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f5e55a7-6690-40bb-bab6-08d77513f04e
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB505023D6CCDD7DFE06D4FC14BA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(81156014)(81166006)(66066001)(6436002)(3846002)(4744005)(8936002)(66946007)(6116002)(1076003)(66446008)(64756008)(66476007)(14444005)(256004)(66556008)(316002)(786003)(8676002)(6512007)(102836004)(6486002)(478600001)(71190400001)(71200400001)(2351001)(86362001)(6506007)(14454004)(2501003)(75432002)(386003)(5640700003)(2906002)(6916009)(7736002)(2616005)(25786009)(26005)(52116002)(88552002)(99286004)(5660300002)(76176011)(186003)(446003)(11346002)(305945005)(50226002)(36756003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR03MB5050;
 H:DM6PR03MB4795.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PJ3kkliADW8nCKhqZm7J3JQW9qga19aDmEOvWlGtfPR/UnjcVkzG2o+NJlsn93HxZSxtxHHo3ZEV5tMh3LYF9WMrZEaUxg5gdkkn36LgcD42CsHbNkIcHUHoDe2OhWJwVaVFfaaRu2tunvfjTI0CaQEKW7NhLF4GLUqbQTq553uVBSwcWj3g9/+Yoyka/FaEkDhb+hGYiqsMKkyWEXCyr/cKErUn0Vpq+qdPYVUFZ3S0Ai6fUQVR5tHWO2YFh+IyJOZROTudQeN5YuXMjguJgqVWUTDzv9V1lc9Sj7mGjeLrI2QOjYyCmtw6JCEJd1wRjZp7z8dSQW0iZzr6KsnQHMAPlFz15RfwgV6zUbfFYJKmfyPc5Y3nquMi79aOxn9Tb5Emj3i0oCcKWLee3TpGNDQ0qD8llUniUwEbvXl14zWJ8CgDJzGtlW0X1eScwCfy
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5e55a7-6690-40bb-bab6-08d77513f04e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:39.7621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRbmXSFcTjxQf3L2E6wQ9honnmqtVD8eD7OFWcbHpe/eK0S7RrcwdayHpLQNCnyv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.102
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


