Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEF5C76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B929C22AED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="5gZyvD3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B929C22AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUOw-0006jP-Jf
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40277)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUMJ-0004Rm-Qb
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUMI-0001rv-OH
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:59 -0400
Received: from mail-co1nam04on072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe4d::72e]:55968
 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUMI-0001rP-IP
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhAaPyyRtUJe+bMi57NEOp8YqWTRoQ3OQqFy/orhhOqEtVSrwDke7RJ8599NUQpy4SZD84JeCaunwRwYq12Ualejsh7i0gNz/RyY+Tj6U0nMVVGeUGUG0dyb0IGEeIkVA9vZAB4vQ93UxpEXDS6un4y1E2XGwVN5JJCxcgrBKwyWj4S5V96gA6+g5iibdYlogawOoZEPdM7SME9e5Qini1/hKCUW6r//YJLk10/LNY4OR7ZOKy7Nenry+jpFBNa/DMIJn6XY8HU0b1KjMl6ClAYGu4eI1ZeBYhLGMoyT2P6GLcygcOAeksy+OsGsx94R4UZ/3frSW8/jzXIrAQg3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwR+eJPjzThQ7yBp/BMa/jKg9v152biAblzTLHWG+Wo=;
 b=fgHvXYyrTWbsrksbfnxaeaqo3auZwaxoE/Suq06cyz0xjue+0lulZzwk5uBDoZ1iyaD2lAcfzeRI9sCkC/N/ZINSbtLv34Ag//ejxe43McPp3DyPPFHiWeJaU5MMYdt840H2PR2I9bBGVO22k5yA4q5QdSW+5FsUTvaKJqcLoIm5WrcxNewMpoKFqWjY02pJkBt19O7vpFT8UNMvUM+dNtDEYRVtlE4Y82M9suW3g5D62yTGf+WTyP+Dtb6Pj9hSDULsV2xEqAvx9WLHqdVb7ZTRDRRUxzJhjFWAMMTbsnIX2RrXgiFvDBLylL3QQxHrUZmI0VglK9zo2DZLdrfyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwR+eJPjzThQ7yBp/BMa/jKg9v152biAblzTLHWG+Wo=;
 b=5gZyvD3e9mfE0kDp7QFALnidsdLt6Jf9uNORu8Fi1+cMW0d1YSfa+9fxe0RIUW5N/7M6ucpMmjwRpvGO89aax/udprH3ksr3I9wxjKEUx2twn+UhUv49z5yA0JfwPLHN4pip7jbK1yI0MagSJrR5K+ssfi+Q/BL8gcCvFNVraWg=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2726.namprd03.prod.outlook.com (10.173.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:23:57 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:23:57 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 15/19] fuzz: add fuzz accelerator type
Thread-Index: AQHVQphkEe3iKfVN1UGEQrxl+IyIQg==
Date: Thu, 25 Jul 2019 03:23:57 +0000
Message-ID: <20190725032321.12721-16-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 8b8480a6-a3b7-4be7-b449-08d710af874e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2726; 
x-ms-traffictypediagnostic: CY4PR03MB2726:
x-microsoft-antispam-prvs: <CY4PR03MB2726BD8639CC9B5EF34B5E4EBAC10@CY4PR03MB2726.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(50226002)(3846002)(53936002)(6512007)(14454004)(66066001)(5660300002)(6116002)(25786009)(68736007)(316002)(99286004)(54906003)(1076003)(2351001)(2501003)(2616005)(75432002)(7736002)(76176011)(52116002)(305945005)(6436002)(71200400001)(6506007)(26005)(6916009)(478600001)(8936002)(5640700003)(786003)(86362001)(4326008)(256004)(88552002)(71190400001)(386003)(2906002)(476003)(66946007)(446003)(11346002)(8676002)(81156014)(81166006)(66476007)(66446008)(36756003)(6486002)(66556008)(64756008)(486006)(186003)(102836004)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2726;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DxT3sm5JIcIbmLhkpkKUA22Q02Be6+2AYOfahtKhkxbwRyDoHVjKjzkZkcbWOOEMeFqMkJ3zoa1DQXuebdmGL1RBdxrmb4JWHdrSqjT/be+Ok9hk8opRvoP3xUOuiQ4YyN0NgImqZ9ad0i23O6kmgtRgrY2ENK2JNjF67Bkb+WdHqMyXxETEh3FSmF/C3CSsgxIb9PlaEWHcAUiWqcG6pXnMLDmuQl9uiPobRj5KmPaxDs4X/F0LARvyLL4Srv99gvT+aDi5a2QtdYgepBRuHy9kEDioWldXWL+JnG9RA2iy44q/8wSNTd7s9Rm5a69y49zF4NCSNQhq2sWl/vBe25NvipYlSBM9MCPDqmSFxuuLUz8sDgh6t4puMd60gUbont2bn6/zNuzMGGW6IfnDL3AFOtLHizg4j4ygi9kb+oU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8480a6-a3b7-4be7-b449-08d710af874e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:23:57.3337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2726
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe4d::72e
Subject: [Qemu-devel] [RFC 15/19] fuzz: add fuzz accelerator type
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
 accel/fuzz.c          | 47 +++++++++++++++++++++++++++++++++++++++++++
 include/sysemu/fuzz.h | 15 ++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 accel/fuzz.c
 create mode 100644 include/sysemu/fuzz.h

diff --git a/accel/fuzz.c b/accel/fuzz.c
new file mode 100644
index 0000000000..1694cf46e8
--- /dev/null
+++ b/accel/fuzz.c
@@ -0,0 +1,47 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
+#include "sysemu/accel.h"
+#include "sysemu/fuzz.h"
+#include "sysemu/cpus.h"
+
+
+static void fuzz_setup_post(MachineState *ms, AccelState *accel) {
+}
+
+static int fuzz_init_accel(MachineState *ms)
+{
+    QemuOpts *opts =3D qemu_opts_create(qemu_find_opts("icount"), NULL, 0,
+                                      &error_abort);
+    qemu_opt_set(opts, "shift", "0", &error_abort);
+    configure_icount(opts, &error_abort);
+    qemu_opts_del(opts);
+    return 0;
+}
+
+static void fuzz_accel_class_init(ObjectClass *oc, void *data)
+{
+    AccelClass *ac =3D ACCEL_CLASS(oc);
+    ac->name =3D "fuzz";
+    ac->init_machine =3D fuzz_init_accel;
+	ac->setup_post =3D fuzz_setup_post;
+    ac->allowed =3D &fuzz_allowed;
+}
+
+#define TYPE_FUZZ_ACCEL ACCEL_CLASS_NAME("fuzz")
+
+static const TypeInfo fuzz_accel_type =3D {
+    .name =3D TYPE_FUZZ_ACCEL,
+    .parent =3D TYPE_ACCEL,
+    .class_init =3D fuzz_accel_class_init,
+};
+
+static void fuzz_type_init(void)
+{
+    type_register_static(&fuzz_accel_type);
+}
+
+type_init(fuzz_type_init);
+
diff --git a/include/sysemu/fuzz.h b/include/sysemu/fuzz.h
new file mode 100644
index 0000000000..09a2a9ffdf
--- /dev/null
+++ b/include/sysemu/fuzz.h
@@ -0,0 +1,15 @@
+#ifndef FUZZ_H
+#define FUZZ_H
+
+bool fuzz_allowed;
+
+static inline bool fuzz_enabled(void)
+{
+    return fuzz_allowed;
+}
+
+bool fuzz_driver(void);
+
+void fuzz_init(const char *fuzz_chrdev, const char *fuzz_log, Error **errp=
);
+
+#endif
--=20
2.20.1


