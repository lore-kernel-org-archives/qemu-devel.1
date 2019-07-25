Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7E1C76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CFB22AED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="4vdtKz4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CFB22AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUOR-0004PI-IT
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40214)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUMF-0004BD-JP
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUMD-0001q6-GC
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:55 -0400
Received: from mail-eopbgr810110.outbound.protection.outlook.com
 ([40.107.81.110]:60544 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUMD-0001pn-AC
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6Gx78PvgKmKmQOzJrIuEANqqIiPoaL/L4a68Lfj3fVz3ujyUxXCEzsMy/Yjxroz+Xagp9KpXQglpjsSo55btlbfTBHTKRQTlujXGnmM/Gp4ECZG+ixka3Mbme78wqA0B9rGitZDTb/+KcyZ8JGxaFvYXCl/felOM+K8AL/7Q2Yh1KIokCVYJXM6HRw4316G+S98fLrClMJ3PKJWkqur77I3WcK1A7B0cui58ZIyUTpOX3TmPXiX/C+jiCaZWWI4TFVFE4ICz2ZaSbmVNE2dYY1pc6gDOvnRJhykQ0FEGFuyQGwhWblAAtV8A+sD3D3TUmaG6QUaCObrGkH1bWJHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1y7xLsVBAFj0PWQG4j2WzFMPCltVwNN/WItGP2H5CQ=;
 b=Nvpex6s4qGrd6tGXjAUnE0/FoTu0ZubbdAXCH1eys81G9CYiciTDegww2fEXAgprk60IhBH9n89d0ks+NRXDxYJD7tAuwZFLyC+PBLSu5Wpod/OuJ0i4RdPz5xur9pbniQdJXS9WdoYmZQhUKuT+uOI40hPGhPyd6FqrsQ8MkaSGcEuoJthYwz5ZGt3CScxrnVWiz8MqButYchHAZ9CqAXTJVREtd7Hsc3Djug/pQpiHFz75ORcmzW/FNL2yI0iVw6qb0XG2mme+r5xCMiYL1hGqINlrtHpt9lgiPpiUJnrikA+InfOsBQzIBcNdYooOWXVRYGCypxkoC4RI4hBJmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1y7xLsVBAFj0PWQG4j2WzFMPCltVwNN/WItGP2H5CQ=;
 b=4vdtKz4ocB2xPqxh+i+2Wgk8XlvoTxpsGquce9BW5Mfibi1awvW9fJOwEQTWKCQusyZloztLPV6xpGbHe6suCCZjfKAlzP5jwHmll9pghf+6xI7Cvvvsrbqm68czGT6ExldwxxQxkP3kS5AiZtgQT4RBgawjyeyZtY46+Y6tsMs=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2726.namprd03.prod.outlook.com (10.173.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:23:51 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:23:51 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 09/19] fuzz: use mtree_info to find mapped addresses
Thread-Index: AQHVQphhgNmRXRes/k+6OAsxe/qRMA==
Date: Thu, 25 Jul 2019 03:23:51 +0000
Message-ID: <20190725032321.12721-10-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 9e63b777-b669-432e-95c9-08d710af83fa
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2726; 
x-ms-traffictypediagnostic: CY4PR03MB2726:
x-microsoft-antispam-prvs: <CY4PR03MB2726F66AAF9095AA71A01CB5BAC10@CY4PR03MB2726.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(50226002)(3846002)(53936002)(6512007)(14454004)(66066001)(5660300002)(6116002)(25786009)(68736007)(316002)(99286004)(54906003)(1076003)(2351001)(2501003)(2616005)(75432002)(7736002)(76176011)(52116002)(305945005)(14444005)(6436002)(71200400001)(6506007)(26005)(6916009)(478600001)(8936002)(5640700003)(786003)(86362001)(4326008)(256004)(88552002)(71190400001)(386003)(2906002)(476003)(66946007)(446003)(11346002)(8676002)(81156014)(81166006)(66476007)(66446008)(36756003)(6486002)(66556008)(64756008)(486006)(186003)(102836004)(37363001)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2726;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AuG5v39EhJutU7+8gQAbhEvKUdJ+hxaHt8k1Ubz3awVUyjW0Nh1HN6J4ANRboOwsmFxp8O9c5yTJ7mPsGO7fyP7UG67JCVHFWfXg7nYn5/OZz4s0vGNGtzMNGOKVfVuiRVnd5gjvjNwFdlih3DaUD1+RuIU9urZ7QeZ0QkWYFSFwnOkfS401HqiWkjsDaAfPDxL+GjkYh9tZYozdXeZhUkNU+123gpB8ngy5Sk0W3cvAPlm+Dm0QcDczWCY06SBOUDlAJ6/f/hZWhTUNtEbWvd4kdMXwCejsNgdTR/pQ80+OCU7c/3FmACsGrfi/9/zgmeIp9AIn9cfDx9hGpU+cV9uY1n9B4shNdgAD+Aw/EbnfuDjXUMEOJ1Psch6UtcV5P/BshgU3rKSxk1GLsPakhVY0FtFdqdPmsEXTsRELDXI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e63b777-b669-432e-95c9-08d710af83fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:23:51.7642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2726
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.110
Subject: [Qemu-devel] [RFC 09/19] fuzz: use mtree_info to find mapped
 addresses
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

Locate mmio and port i/o addresses that are mapped to devices so we can
limit the fuzzer to only these addresses. This should be replaced with
a sane way of enumaring these memory regions.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 memory.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/memory.c b/memory.c
index 5d8c9a9234..fa6cbe4f1d 100644
--- a/memory.c
+++ b/memory.c
@@ -34,6 +34,11 @@
 #include "hw/qdev-properties.h"
 #include "hw/boards.h"
 #include "migration/vmstate.h"
+#ifdef CONFIG_FUZZ
+#include "tests/fuzz/fuzz.h"
+#include "tests/fuzz/qos_fuzz.h"
+#endif
+
=20
 //#define DEBUG_UNASSIGNED
=20
@@ -3016,12 +3021,20 @@ static void mtree_print_flatview(gpointer key, gpoi=
nter value,
     int n =3D view->nr;
     int i;
     AddressSpace *as;
+#ifdef CONFIG_FUZZ
+    bool io=3Dfalse;
+#endif
+
=20
     qemu_printf("FlatView #%d\n", fvi->counter);
     ++fvi->counter;
=20
     for (i =3D 0; i < fv_address_spaces->len; ++i) {
         as =3D g_array_index(fv_address_spaces, AddressSpace*, i);
+#ifdef CONFIG_FUZZ
+        if(strcmp("I/O",as->name) =3D=3D 0)
+            io =3D true;
+#endif
         qemu_printf(" AS \"%s\", root: %s",
                     as->name, memory_region_name(as->root));
         if (as->root->alias) {
@@ -3062,6 +3075,27 @@ static void mtree_print_flatview(gpointer key, gpoin=
ter value,
                         range->readonly ? "rom" : memory_region_type(mr),
                         memory_region_name(mr));
         }
+#ifdef CONFIG_FUZZ
+        if(strcmp("i/o", memory_region_type(mr))=3D=3D0 && strcmp("io", me=
mory_region_name(mr))){
+            fuzz_memory_region *fmr =3D g_new0(fuzz_memory_region, 1);
+            if(!fuzz_memory_region_head)
+            {
+                fuzz_memory_region_head =3D fmr;
+                fuzz_memory_region_tail =3D fmr;
+            }
+            fmr->io =3D io;
+            fmr->start =3D int128_get64(range->addr.start);
+            fmr->length =3D MR_SIZE(range->addr.size);
+            fmr->next =3D fuzz_memory_region_head;
+            fuzz_memory_region_tail->next =3D fmr;
+            fuzz_memory_region_tail =3D fmr;
+            if(io =3D=3D true){
+                total_io_mem +=3D MR_SIZE(range->addr.size)+1;
+            } else {
+                total_ram_mem +=3D MR_SIZE(range->addr.size)+1;
+            }
+        }
+#endif
         if (fvi->owner) {
             mtree_print_mr_owner(mr);
         }
--=20
2.20.1


