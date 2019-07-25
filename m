Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F710C76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E174020828
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="xiglhz9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E174020828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUOf-0005O8-NX
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40183)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUMD-00040h-5n
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUMC-0001pK-1p
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:53 -0400
Received: from mail-eopbgr810120.outbound.protection.outlook.com
 ([40.107.81.120]:6127 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUMB-0001mt-Qa
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6cNV58BZet46l5ZKjdaL9EZ5NXQBqP0P1W7DXdlcMl+4+Em13gVtPeg97jnSJiYcsvziDoN+wBQV/vDUIWsxAIvDhSDBzdcTBe1LjOz3aQiwOxbBFGsy3RfDY+9xCaht4pLgPdcixpuzdL8gvEinDGfyyBdvJQF3au713J4O/pdPVgydLfe99cWFONsnz2DngAAR4zU1azKP+32ylXXJ+7iQVxESw8p/UFSgJHJ1qyhn00Di/76c+UlahxQPvqKsIFF9xcFTDc0f4KcxONithqkTB44sGuZ5MYceC+M68UKdsapMYouQqAaMf7adOuefEzzjRqhISkjovoqfUA7LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh+WGC69WtESuVqW8k8FIXRC3KHJpnYQRf6HhUE30Iw=;
 b=ecdrlU6WPf59LwomOcYD03qEGKuQ14/93LaBRPO/GQLnw5XGVxcWCzNPhThmQoWMPLlk5aUDcZ+wc/FTFsv7J6peN9S7g2pxaR5UuVzzPNknX+6AnTMZ+2A43wipMXvxVqwCHXEVmnMddFqBW8UhHqXeke92DHkYl5OCyzqdbM0c16rFcDKd2aXGOA5sfL5lo8A3TdJ3kQRoZ4aZZkhUDbdMRYY+vCliGaf+8VuFgjtLNEx66/4x2yS2mVeYr5rcz/fWsNWnirvqdE/Vvsci8nEW9bq0bg1iKkIWW/devnZ57JCTJM/TKa2tmE7sAc06p9dzqEOfUurLz7NANvhrMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh+WGC69WtESuVqW8k8FIXRC3KHJpnYQRf6HhUE30Iw=;
 b=xiglhz9UWZVH0erpO0Gw70VLSfFb6D7izUW+RGGgNoTqDZE8krZtyTkb3FGiJXZsMuJKRHywx4OHP3m9XMTMaDMgDBwTzstGFgun+Q5YIJEngUpcYd7vouNMLO6yQXSGMZ5KsCWLI0iifkt/AaFEcY1r9MBgNh36SFf9RY+811A=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2726.namprd03.prod.outlook.com (10.173.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:23:51 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:23:50 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 08/19] fuzz: add shims to intercept libfuzzer init
Thread-Index: AQHVQphhJV35HGYgOESUtyqymOzCXA==
Date: Thu, 25 Jul 2019 03:23:50 +0000
Message-ID: <20190725032321.12721-9-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: f7556b28-500b-48f0-e9b1-08d710af836a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2726; 
x-ms-traffictypediagnostic: CY4PR03MB2726:
x-microsoft-antispam-prvs: <CY4PR03MB2726065CD2DA56C0023B3DC8BAC10@CY4PR03MB2726.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(50226002)(3846002)(53936002)(6512007)(14454004)(66066001)(5660300002)(6116002)(25786009)(68736007)(316002)(99286004)(54906003)(1076003)(2351001)(2501003)(2616005)(75432002)(7736002)(76176011)(52116002)(305945005)(6436002)(71200400001)(6506007)(26005)(6916009)(478600001)(8936002)(5640700003)(786003)(86362001)(4326008)(256004)(88552002)(71190400001)(386003)(2906002)(476003)(66946007)(446003)(11346002)(8676002)(81156014)(81166006)(66476007)(66446008)(36756003)(6486002)(66556008)(64756008)(486006)(186003)(102836004)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2726;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YDnt9VNfcZZ0QBEINp2Nu39Uy87EsLiCzRETVlvKwBeCuMW08MKTFgepGBwu0YbGftPHpvJsCOoIMJRbYKuUakrg60jcgJYoEnYryx7G/Yqp5zI/sK/csds/rm6mm8wVOpACXRO/l9BaYui0Xs2sznDSWc6zOUsLaRSfA56E+nI9Paic7rj2/Tgyxdmsl48RnJSdXfSY1kxA6rZZAKsJ5mu0WxHhC5k4FJtwjVSjdk0KKnzzpwloy51t7huBdOzgQc8aS2lMziQh6AYvYdmB5Fjf+uoSjsQk9RwBzR7OJjC2JNBb+BzuKSFiBK4QHIZsJn9vXnISMWUOAWhRY54DmksMeFdZNpEdSoeCl2wfdHKSSunt67ZqT5MdqfrcxT3Jpr1qIH/luE8oLrNt2S+63SkIOgIRSLz/Nm28ogAGyzI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f7556b28-500b-48f0-e9b1-08d710af836a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:23:50.8736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2726
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.120
Subject: [Qemu-devel] [RFC 08/19] fuzz: add shims to intercept libfuzzer init
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

Intercept coverage buffer registration calls and use this information to
copy them to shared memory, if using fork() to avoid resetting device
state.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/fuzzer_hooks.c | 106 ++++++++++++++++++++++++++++++++++++++
 tests/fuzz/fuzzer_hooks.h |   9 ++++
 2 files changed, 115 insertions(+)
 create mode 100644 tests/fuzz/fuzzer_hooks.c
 create mode 100644 tests/fuzz/fuzzer_hooks.h

diff --git a/tests/fuzz/fuzzer_hooks.c b/tests/fuzz/fuzzer_hooks.c
new file mode 100644
index 0000000000..5a0bbec413
--- /dev/null
+++ b/tests/fuzz/fuzzer_hooks.c
@@ -0,0 +1,106 @@
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "fuzzer_hooks.h"
+
+#include <dlfcn.h>
+#include <elf.h>
+
+
+extern void* _ZN6fuzzer3TPCE;
+// The libfuzzer handlers
+void __real___sanitizer_cov_8bit_counters_init(uint8_t*, uint8_t*);
+void __real___sanitizer_cov_trace_pc_guard_init(uint8_t*, uint8_t*);
+
+void __wrap___sanitizer_cov_8bit_counters_init(uint8_t *Start, uint8_t *St=
op);
+void __wrap___sanitizer_cov_trace_pc_guard_init(uint8_t *Start, uint8_t *S=
top);
+
+
+void* counter_shm;
+
+typedef struct CoverageRegion {
+    uint8_t* start;
+    size_t length;
+    bool store; /* Set this if it needs to be copied to the forked process=
 */
+} CoverageRegion;
+
+CoverageRegion regions[10];
+int region_index =3D 0;
+
+void __wrap___sanitizer_cov_8bit_counters_init(uint8_t *Start, uint8_t *St=
op)
+{
+    regions[region_index].start =3D Start;
+    regions[region_index].length =3D Stop-Start;
+    regions[region_index].store =3D true;
+    region_index++;
+    __real___sanitizer_cov_8bit_counters_init(Start, Stop);
+}
+
+void __wrap___sanitizer_cov_trace_pc_guard_init(uint8_t *Start, uint8_t *S=
top)
+{
+    regions[region_index].start =3D Start;
+    regions[region_index++].length =3D Stop-Start;
+    regions[region_index].store =3D true;
+    region_index++;
+    __real___sanitizer_cov_trace_pc_guard_init(Start, Stop);
+}
+
+static void add_tpc_region(void)
+{
+    /* Got symbol and length from readelf. Horrible way to do this! */
+    regions[region_index].start =3D (uint8_t*)(&_ZN6fuzzer3TPCE);
+    regions[region_index].length =3D 0x443c00;=20
+    regions[region_index].store =3D true;
+    region_index++;
+}
+
+void counter_shm_init(void)
+{
+    /*
+     * Add the  internal libfuzzer object that gets modified by cmp, etc
+     * callbacks
+     */
+    add_tpc_region();=20
+
+    size_t length =3D 0;
+    for(int i=3D0; i<region_index; i++){
+        printf("%d %lx\n", i, length);
+        length +=3D regions[i].length;
+    }
+
+    /*=20
+     * Map some shared memory. When we use a fork-server we can copy the
+     * libfuzzer-related counters
+     * */
+    counter_shm =3D mmap(NULL, length, PROT_READ | PROT_WRITE,=20
+            MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+    if(counter_shm =3D=3D MAP_FAILED) {
+        printf("mmap() failed\n");
+        do { perror("error:"); exit(EXIT_FAILURE); } while (0);
+        exit(-1);
+    }
+}
+
+void counter_shm_store(void)
+{
+    size_t offset =3D 0;
+    for(int i=3D0; i<region_index; i++) {
+        if(regions[i].store) {
+            memcpy(counter_shm + offset, regions[i].start, regions[i].leng=
th);
+        }
+        offset+=3Dregions[i].length;
+    }
+}
+
+void counter_shm_load(void)
+{
+    size_t offset =3D 0;
+    for(int i=3D0; i<region_index; i++) {
+        if(regions[i].store) {
+            memcpy(regions[i].start, counter_shm + offset, regions[i].leng=
th);
+        }
+        offset+=3Dregions[i].length;
+    }
+}
+
diff --git a/tests/fuzz/fuzzer_hooks.h b/tests/fuzz/fuzzer_hooks.h
new file mode 100644
index 0000000000..90dca254d4
--- /dev/null
+++ b/tests/fuzz/fuzzer_hooks.h
@@ -0,0 +1,9 @@
+#ifndef FUZZER_HOOKS_H
+#define FUZZER_HOOKS_H
+
+void counter_shm_init(void);
+void counter_shm_store(void);
+void counter_shm_load(void);
+
+#endif
+
--=20
2.20.1


