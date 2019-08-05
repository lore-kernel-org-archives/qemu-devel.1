Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80ECC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992E9205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="hWQo1Qb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992E9205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXEe-0006b2-TO
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37402)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX9L-0003iE-FB
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX9K-00025D-GJ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:19 -0400
Received: from mail-eopbgr680126.outbound.protection.outlook.com
 ([40.107.68.126]:42366 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX9K-00023d-Ap
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDFu94Pcy4BQZ+6RI+fa0MWUPkhQp/pngfJn6sHd6hNWH1mJWxBl9/h/MTKP0UnsRE2C/AKuZrvyYoMgFS+aGG94xb1q6yKn0+rETZvmF1/CBP+bz8nNVkHUpys6IwIa5k1S/2IG70dg8tMOjALdU2y8i2rEU+tRPBNaeVv1HYc/bsY4NKk0H/4dV0M8ofY5rCMjGaILBiP05aeRiwlLVPpbxTmcxKGqNRgKH5QzVW65a/8G35u9Lr/4xEwDKBPxv+fj15wf8BfryG1pmGnQC/+AxMAjyf9RxEtk/YUbZurIAHS+p2ceiIfmz2xBaIOzgKas5GeBCy1f0WNs1FDTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l8lnhPsOGDgd7skocNOZch6EG2f6gyeDYi2ODejIW0=;
 b=W3dPlGtsZaLAldvxJgvwupiRowY/PxpXcMbD+2pFrVv2JWCwtLiMwzcunKQFtv1qmZ9d1zwhXts4Er9OBItUzbAW4vncwN2rqnP2OlSJEeuUBolUPpzOYCzKHQjaR1hRy7WMGvJmnszHit4VCktTnLrb/KnbNq16kURDrupYasaSDyLK01ebS/wa/LElPn+7o73Pn2AofZ72hBM6prhD07VFUQ/YPytEv56CzIKkKEBCpYVe9g+s8N4b+BbtzoWtFW734l9tesV1b9WzzPRR2T+4sitgYrlpHwhsDPmu5blDBHgLQ+spq1nSm9pp3g6ox/rPguqjzFeyfSXF3E1vJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l8lnhPsOGDgd7skocNOZch6EG2f6gyeDYi2ODejIW0=;
 b=hWQo1Qb2iaL7fhkpKvhDfTNbaqlc23G0ARi6Q/WgfRUnVLM5UioBa/KxJzpywpHr267AF+NsqS0QXKV2mFgqVGeIoRlM2gNkZ77OYD/WnW4DotvUUSWG3sfs0/vQ8qj3R8TegFBQAvhhNhIEUOPFfPSFzT64mq3ZzCeYtduykcQ=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:17 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:17 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 17/17] fuzz: Add fuzz accelerator type
Thread-Index: AQHVS1z5W3/msAY5EkOGLIdOZGp/TA==
Date: Mon, 5 Aug 2019 07:11:17 +0000
Message-ID: <20190805071038.32146-18-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 071fca2f-bf7b-4f32-e28f-08d719741c09
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB26460FEB89A913B17D0BF721BADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IICle/Vs1sb/3LKzdu+yYdxNkSPuBL/HOHiZezQeANBmy58F3ydkubeNHhG3rYFzsaVmG7dRyvu84EXSH/xIgg/m7vx13xECQG8yhmlxAIF84kVJIjTYuWZMqUEYm9z9M4spDWbzr5kQfFg/CgP/04Y4XMwRtwlxa7AUxo6gGPh7wVAZ/GyGzFyChOUA/kIMwLt0zWAOHZzrBviK49FM/mDy4CU+AKQaIERFwnIhFIcXfU6k42jzqN+X5U2o/t6qWq+ZXBXoimSMVvyPGrau58aCOwOXwoUW4xLkX0uNmYQPJCq1m3MvXQNqihlzdfhdBBJ5EjZ31C5TUVLaVwz5MuXmGWkrLVLRNGbtadGyap1pK/E3s9uvT6UfVXKbxC+nDYJsfdmRQU37YsfZ/7lgsUgUDHsNjYpbIOuSK4XeG9U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 071fca2f-bf7b-4f32-e28f-08d719741c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:17.5724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.126
Subject: [Qemu-devel] [RFC PATCH v2 17/17] fuzz: Add fuzz accelerator type
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
 accel/fuzz.c          | 48 +++++++++++++++++++++++++++++++++++++++++++
 include/sysemu/fuzz.h | 15 ++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 accel/fuzz.c
 create mode 100644 include/sysemu/fuzz.h

diff --git a/accel/fuzz.c b/accel/fuzz.c
new file mode 100644
index 0000000000..9af989aaa1
--- /dev/null
+++ b/accel/fuzz.c
@@ -0,0 +1,48 @@
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
+static void fuzz_setup_post(MachineState *ms, AccelState *accel)
+{
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
+    ac->setup_post =3D fuzz_setup_post;
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


