Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD68BC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7900920657
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="kFhV9qFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7900920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXCr-0003KF-Ne
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37368)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX9J-0003b5-8h
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX9I-00022q-3b
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:17 -0400
Received: from mail-eopbgr680101.outbound.protection.outlook.com
 ([40.107.68.101]:34519 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX9H-00022H-Us
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZJPbC6ubhOYMV05sKdlI2bwQy8s4HkvAR0H5XJnFcRe8LEGSSAWGizfV2XtSRt6Pmx9VS8TsQCBFdnsReO/l3a28sOCblY+J7S6IwH/3Tf3V4IZUO6OgeJcm3XM+YwkOUrmtFdJq1TWwixU57fDqG7/a65j8tsf7r6yZIueMrV73bJT+BM8WgTNDwAKE3xw4i8qLQrtD6XbLchz1skEIbjH/Jqa3KhriKOYAISMoLSCJvM/gtBngmHjDracM6o7fOa/9THFU6bdg+Ff6ycOYMoRQiweIjGXWV9tvuf/VIAsO4hDR9xUdQieTdTiAIDmep8BgNFfF8CTZmIwS8Rhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j64WcXAtrFzH8PuU4KljLiL2xd3ZBo7ZqZsYscC2wWg=;
 b=UY8rcte0OUhwN1QueCCnTJVxSqyJlFlj87TbE/WNOw1nDpHcTCAt8r3DKMYfKLX85wt7wFPxj/OaGRy5iINJ36DDP1xCFPDhkxMeyseyPsfUD/LROGYL84vGw8DcFyJ9rNjkkFnw2Hh/eyi8KZL6qLYHDFeGsLaPTEDLVdm78u3o0eWKqN8OMcVzqEiMEq6cQXyFKa1p50tc53xEDo5R7TqSTl3V4iMyVs6+zXfvrUQxQpLTpah9TEYc3ZSxL5Pjmf9hKSdk5AaY1wDJGy22GKeT4n/c2W6seGL+vQJkt3TyOfYqJEdc1PMwTU9LkwTVYTw9Y3UD6x4mmtqW2HheIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j64WcXAtrFzH8PuU4KljLiL2xd3ZBo7ZqZsYscC2wWg=;
 b=kFhV9qFnbVudGmWdn7OD154HCbzLMZ8pI54HsDrtF00bdPWznxMoZvsFA9BQS8VPesu4I98hCLwArFKo/MF4GoIOGO4GbVkq2GkpMhDkA75FK6OtZJK1PIKoOAk/G7TJn5duZDr/fo3aUjYb2vT5Dvkbn0yDHxgc38vwRnPFl40=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:15 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:15 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 14/17] fuzz: Add forking support to the fuzzer
Thread-Index: AQHVS1z4+DrgWQpDM0G8sJ7j+7r3GA==
Date: Mon, 5 Aug 2019 07:11:15 +0000
Message-ID: <20190805071038.32146-15-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 9bf4c8bd-43a0-47a7-5ca5-08d719741a94
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <CY4PR03MB264658DD83E4B36A30C8101EBADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6306002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(966005)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(14444005)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rJhK5zHmXDcXJ8DIfM7pIaa64qTrOrL9MKEV7mCXkCsLU3wW6npK4pa7EKYdJFNg5IBqT8H0fHHNX7g/Xbn47JPyzLCa3lmXYrKi9pYlvc65itFcrsys31HmqfFG7vjgOHz+HjksNklG/25CI3UCQI76S84yoK1sqf46QiaBqDjWHvxepF1lZ9Q7LYDT+unxgdLlaZQM0oY2s4eFtYn81+eQBxWT6SGyMO7v2/QvpKosZmNvcL+D8Cly1yA2qpWhTFw8YuulX4vRgjA6vRNemCPKKDeF2+Pzbb4D/FQwppmpNxBSY3B1JLPK6K8PNF6GM90/IhZoTM3GxqEADwk3Plk0ZqFdDK6hbv1qdf8Hj/Tz0qNO6u+ZCkZbL05wkIoxoKouZTgr+W5KTkQEudO/XitWwOAbXUS/NMHlOzk3iFo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf4c8bd-43a0-47a7-5ca5-08d719741a94
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:15.0975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.101
Subject: [Qemu-devel] [RFC PATCH v2 14/17] fuzz: Add forking support to the
 fuzzer
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

Forking is a simple way of ensuring that state doesn't leak between
runs. This patch depends on a modification to libfuzzer:
https://reviews.llvm.org/D65672

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/fuzzer_hooks.c | 62 +++++++++++++++++++++++++++++++++++++++
 tests/fuzz/fuzzer_hooks.h | 21 +++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 tests/fuzz/fuzzer_hooks.c
 create mode 100644 tests/fuzz/fuzzer_hooks.h

diff --git a/tests/fuzz/fuzzer_hooks.c b/tests/fuzz/fuzzer_hooks.c
new file mode 100644
index 0000000000..87c94ef65f
--- /dev/null
+++ b/tests/fuzz/fuzzer_hooks.c
@@ -0,0 +1,62 @@
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
+
+void *counter_shm;
+size_t feature_shm_len;
+uintptr_t feature_shm;
+size_t offset;
+
+typedef struct CoverageRegion {
+    uint8_t *start;
+    size_t length;
+    bool store; /* Set this if it needs to be copied to the forked process=
 */
+} CoverageRegion;
+
+CoverageRegion regions[10];
+int region_index;
+
+
+void counter_shm_init(void)
+{
+    LLVMFuzzerIterateFeatureRegions(&measure_shm_size);
+    feature_shm =3D (uintptr_t)mmap(NULL, feature_shm_len,
+            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+void counter_shm_store(void)
+{
+    offset =3D 0;
+    LLVMFuzzerIterateFeatureRegions(&feature_store);
+}
+
+void counter_shm_load(void)
+{
+    offset =3D 0;
+    LLVMFuzzerIterateFeatureRegions(&feature_load);
+}
+
+void feature_load(void *start, size_t len)
+{
+    memcpy(start, (void *)(feature_shm + offset), len);
+    offset +=3D len;
+}
+
+void feature_store(void *start, size_t len)
+{
+    memcpy((void *)(feature_shm + offset), start, len);
+    offset +=3D len;
+}
+
+void measure_shm_size(void *start, size_t len)
+{
+    feature_shm_len +=3D len;
+}
+
diff --git a/tests/fuzz/fuzzer_hooks.h b/tests/fuzz/fuzzer_hooks.h
new file mode 100644
index 0000000000..2f411193dd
--- /dev/null
+++ b/tests/fuzz/fuzzer_hooks.h
@@ -0,0 +1,21 @@
+#ifndef FUZZER_HOOKS_H
+#define FUZZER_HOOKS_H
+
+
+/* NOTE: Pending https://reviews.llvm.org/D65672
+ * Alternatively, a similar functionality can be added fairly straightforw=
ardly
+ * with AFL deferred fork mode, albeit requiring a different fuzzer and co=
mpiler
+ * https://github.com/mirrorer/afl/blob/master/llvm_mode/README.llvm#L82
+ */
+extern void LLVMFuzzerIterateFeatureRegions(void (*CB)(void *, size_t));
+
+void measure_shm_size(void *start, size_t len);
+
+void counter_shm_init(void);
+void counter_shm_store(void);
+void counter_shm_load(void);
+void feature_load(void *start, size_t len);
+void feature_store(void *start, size_t len);
+
+#endif
+
--=20
2.20.1


