Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7ECC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A981218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Yf6jOXMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A981218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjKD-0006E9-JM
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEV-0000Ec-1j
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjET-0002Tl-TS
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:34 -0400
Received: from mail-eopbgr710132.outbound.protection.outlook.com
 ([40.107.71.132]:6167 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjET-0002SZ-CY
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPi2eE2uIjIs0bwDpol2tHf14LaqtaREnmRad69uQd/GGjeS558wGi6VtJOZFXo8To3G5WEqjt+U9vJsFvyPnMV6/GtQflA06QvE5pr4WU9avr5ORRty1+fxdmrXFcYdoBEObU1iTdxgh1RS5SJ5oBoMLWgFg2ju8DuqUoJj79E1tczv7c/Iw6GLGJQNFl5yw8kctp4MprwV2zWZxOk966Q92GmZSVmWvYlIcRnEKcIrDiq/4xQKLxwTZ+Jam8y0hfcgcAywzheJ/X0LlqEc735kbRrHlZHdxZbE9RA4PXy8UOeKMuqtkryT8j0pUeGwE4TGsE4aM7/XThMpNrGa2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGLjoyRkxM+RA9W3RsLlnf2NA1JAxArFta6ypbMhKok=;
 b=iFHl3LSx/shUSwC2Th0Ab+FWYXhrd1Ej9wLEklSc5Z0jKYS+D56qhuAfTJY5Ifg8+0Ek555Jk92OVOWjQ+yhOGVBoMvlj19s3UXe0gynoS+wfBaDEdw9bsOiTYvfYK6PO0ilrtFu+higMkWycF4pQNxB5OYuJJRa4up1T9+cHZEfI/WJmI9q6oD6xx4rj1wlbUTF4PQCeqdHFDska0GypOG3fBa7EIxU7xfSr2X8ejWeU+/wtQcGThVqHc/ug7u2O0L/S3hH5JarCyUfipQSUWmUqsV486o1jVQnxA6Pj0P69tERVxXStJy4UDHPlQX7+jxLx7aibSJd9fAbU2EraQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGLjoyRkxM+RA9W3RsLlnf2NA1JAxArFta6ypbMhKok=;
 b=Yf6jOXMnZbDO0F2biEXsgYMJx2TYAPgQpjnXs3KrEwO38gu6+K7d2PMUOXGN5KM33WVeS1KDe0/TZ9+R1lTd2ytiOGQJr0gcW4bcdxSUcNAWDduB980fqKbfoLk2FMpUfdcsnfXwogMEJClBGK5PidqLyuvy1WVhn57aLUC7wQ8=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:30 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:30 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 03/22] fuzz: Add FUZZ_TARGET module type
Thread-Index: AQHVbneFfSE2l4yKnUCWrum04P7nlg==
Date: Wed, 18 Sep 2019 23:19:30 +0000
Message-ID: <20190918231846.22538-4-alxndr@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 927b65ea-ba9c-46ca-7864-08d73c8ea85d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB30163EE055880D4B29A04F7ABA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(14444005)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(4744005)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tSzEEyzjpDX+Bzgvf3h9ttb6xZIGyqupsQpUe+6whi91mm4NEiA8v94So14+77riw7imeqvc+RP6AVdvj9KeCuGUdvSJqI52gFOM7jWUGi/28h5um+VabpNjYwyqo4TIx3ZCc4PcawGXvIvWn5GxFWoi2qIhcBaa3bx2Nj1uvgzjSAyxvNWGPa+zD8KP7OYBXUfUK2Qa1aJj+bZTJi1hVLESkH1Q5juVFZFLqN0nzWx80updzMAEcOc0cVCVsxa+EuPYWHQnF9shvLpBWVOMa2i2sYoQxmSiYS9uvtC5yeiQhWTtdfOLekeFGtOmyN8sn6Vq+s3MPkAJ2EfqCtbVdMSTv8oiQcmA49U70WdIjiT4RBODUNyvdlki9htp3heY8ciKynde1ruVfIqyiVgkUVpEC66si2WcHaaxCFd3lFE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 927b65ea-ba9c-46ca-7864-08d73c8ea85d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:30.6094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yIZJUf++m7Opd+sXFAszFjbkSY/LEXDX2z/bq5wODKEoX8BoxYUxFKczr/AkhDMM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.132
Subject: [Qemu-devel] [PATCH v3 03/22] fuzz: Add FUZZ_TARGET module type
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


