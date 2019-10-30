Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3825CA9EC6
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFFB20856
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="hY0ePSQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFFB20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpMP-0002Je-9j
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 10:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIO-0004yo-JU
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIN-0007GR-HK
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:00 -0400
Received: from mail-eopbgr800135.outbound.protection.outlook.com
 ([40.107.80.135]:59246 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIN-0006yI-CN
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:49:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmcJj5CwNyMXgWLpy1TH9ntD9IOHs+/zEVVaVzW/GBFAtl9D2QsL9+UnwEItr848fEytPZbD9h8jqF0N/NUOC8D0syTBQ77iIxf6kD21Rsml6rfw6JaT62dQMg4UnyVmcIw3ky/B99USxzv/H2bqE8f0eUPhgb85/9j8j2BvBfBRB379O/LTYfmNPIdnYrD9dYne2XB+a6UoY42z8MEilbJasSp7zdvSk4tyAXZiz8TcwzvLTBY5aleBw2gqn0m/PZlWPVqYtTzgMsEpjshnQUU0VP2Iv3RO+Wy7gxP/h5ViAuNVl9+qQ9FfbwSY/FCq+9m0Zab4xwcReIbrQFL/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lleTwPEOmuHOWv76TpWtzEsR9UFaj3k2JZLSUUeFIic=;
 b=QhnCpfXh6hwNYnGNDgDrBxwRYeV1NW6YHb4BXDAfx3ewTzLyOWaoy5YsUet19tUR6pV1wmm70v9RLLQpJLcvTvTVB8o91PzHjWThsmIxsqWgATjz31ExikUFtLjOv9drGdn4FLtDVkt8Rl4UMZygBSYPofGM7rf0HYpNmnPfaKjwhx+Xdpp/iREU1fE6rFVOljhCC9PX130qft25O6WacjwbJmfbMrejj4FyHPH+Fewk2UaZVYkJTEQhi4W84SrLuCs7mzR18PyNA5m35H6sskcn/utGNFjwGLopctLoSQZzsPWjz36AuQpJzSOK3ufo2lD7wTu0xCrGO4Icg8mN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lleTwPEOmuHOWv76TpWtzEsR9UFaj3k2JZLSUUeFIic=;
 b=hY0ePSQPZIV1GT0B/q3+ajdLAPjyz7D4LCFdnRdKhzb5tx59MgJpglVb80loQAX7NGcdxPXmSEMPgXcWjQunEecwVvLHofxcpZNFiIzFv1+tYskQrEorZYrk7e6lfXftnJ6hfiYshWjn/T5Gxsv10NdpQFDmCD1Y1p9XG3y4KJM=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5054.namprd03.prod.outlook.com (52.132.170.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Wed, 30 Oct 2019 14:49:50 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:49:50 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 03/20] fuzz: Add FUZZ_TARGET module type
Thread-Topic: [PATCH v4 03/20] fuzz: Add FUZZ_TARGET module type
Thread-Index: AQHVjzFID0ZPgf5TxkC2vVrePjdmBQ==
Date: Wed, 30 Oct 2019 14:49:50 +0000
Message-ID: <20191030144926.11873-4-alxndr@bu.edu>
References: <20191030144926.11873-1-alxndr@bu.edu>
In-Reply-To: <20191030144926.11873-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: DM5PR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:4:60::37) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 188ca41e-31cb-4f08-5da0-08d75d486a68
x-ms-traffictypediagnostic: MN2PR03MB5054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB50541AD34E6386205FA49CB8BA600@MN2PR03MB5054.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(2501003)(36756003)(476003)(86362001)(88552002)(386003)(256004)(316002)(14444005)(5640700003)(1076003)(99286004)(6916009)(75432002)(486006)(786003)(11346002)(6506007)(4326008)(186003)(2906002)(66946007)(26005)(6116002)(14454004)(446003)(2616005)(6512007)(305945005)(71200400001)(478600001)(71190400001)(81166006)(102836004)(66556008)(64756008)(50226002)(8676002)(81156014)(66446008)(6436002)(2351001)(25786009)(5660300002)(66066001)(52116002)(66476007)(6486002)(3846002)(8936002)(7736002)(4744005)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5054;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t4+Vspu2zSf7iy6QjuVEMJCcGu2+3WsuqxZGNVIml2CsY4vFzPr3Ipj2hvuPI7Y3ANzlpqi5jidpS3dPxmRWVg2h0PNl1EJvlk5ZOMliGkuNProkiY4ouzbViV5nt7tu6fV5gSDvjZdSOGJH6OqJZlDdAE5Jz1HMH+BLY19ZoxwgywMBnTjRQR+mZEleaQX3ZOfwNArhPLoMHMRKrzreWOVFF1o3M9cMSlVQpVxMMMiyQFVcDOFEP7UHRb3mmpJ+n+isvbYXKyeiWZV8FVmeb6vUOOnuFnPXFh8atTV7cehrzZbXT2QvyarrAXoG5SS5pGi8BHhI0Do3yWkwDJRqehz+vm3lHt21o5e5UQz541b4iWP8ECd/MmDu9t8Sc8bhO+1MT99BxiuTmIIkaBO1L+Tq4PqEBYUKCBBMvCUTQZMEQsKyihwBVg5j0yyb2zil
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 188ca41e-31cb-4f08-5da0-08d75d486a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:49:50.3236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srohzds1C8ZuD8m49eGswqRIC/F0Bd4pn7uMdMAJiMGAUMKoyNRDaUQFz2c9hcco
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5054
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.135
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
Cc: "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Oleinik <alxndr@bu.edu>

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
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


