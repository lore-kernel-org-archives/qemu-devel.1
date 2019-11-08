Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4979FC6196
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 20:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E65020674
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 20:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EMlnzs0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E65020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTAw4-0002P4-LQ
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 15:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1iTAvJ-0001w8-8r
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1iTAvH-0006yO-6x
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:32:00 -0500
Received: from mail-eopbgr740114.outbound.protection.outlook.com
 ([40.107.74.114]:47264 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1iTAvG-0006y0-QQ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:31:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQNxmmozSYrkhZ6OIpaUlnvwUvHmVqNKr4Gsj97TbnD2i4B7h6er0QzPsKb7kqavlpB+7a/u8gblXw9MxE1Mbj8D9LufWFz5gqSjIYZ+RNAiPyR5QhDwpkXvKR0nuZglYOCbh+91cR8z47qUaaJfQxZHf60tGNutcw/dy2/setQWah4vgxKPGTDzWZgxXLRQtBY81uDvzUdbR8PRX+fCFomikLUbjDYi+T62E/4K4RCvBZie/mduJQ8EZFAp+x/ktx/mA845hBT0cfomrzBtXkiSt+YsF4pVVTwmf+YQbJxQKzrHEekUgBeVYAsyJFGgrCtUyoYBeX3TocNXK6+m2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87UZAE5LtjaW4wRFZzMSaoP+4y7sDK+4GwB5jFenl1Q=;
 b=bHgSuS8lZ3DBp1/U1/aRpMsP+aKECJXr/NYXZhQInehvmPrXHkIJJG0LbScs4l+C8fjRGIxQkDFx+pCv020QxAHrVXGZrbAOEkYZ2sL14z8oluaf/FIo/gvVUE8XXMsQbiFoTVYGypPcumr0guC3i2qd/7zW1yUxnnQTpKRip2k75xiyATjbEbvpG2Y6PcGp8K//3/XYLo6USQvcOHiGNDBGiBnfmizGCxs8lFqjoo2lPBHn3S851kPvF7djKXcR1lngWAABpsfQAH+dLsxHLChB6WK5kBFkgpb8dy2pdKwtjbUuGsf/VcyEomiQqFY5murY7O5wr63Vm0L8PJV0tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87UZAE5LtjaW4wRFZzMSaoP+4y7sDK+4GwB5jFenl1Q=;
 b=EMlnzs0x9QgPQcRtutvMaAXLinFUMWsOpsybdUkS2k5SrQy2Q7FA1i8UWGWIvPWSam7+iOQHhevTpoiETido1UhxLDrkw6ERUU2kXUfhWqfJR3de7RRs3tODe+O0f5eULLN09j8b9yZHSFAeTUX5MnmGFPHiV7fGTRPc62/2cQY=
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com (52.132.149.33) by
 MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.13; Fri, 8 Nov 2019 20:31:54 +0000
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9]) by MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9%7]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 20:31:53 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Justin Terry (VM)"
 <juterry@microsoft.com>
Subject: [PATCH] WHPX: refactor load library
Thread-Topic: [PATCH] WHPX: refactor load library
Thread-Index: AdWWczxfa/0gc1vPTEu6TOvflPR6ng==
Date: Fri, 8 Nov 2019 20:31:53 +0000
Message-ID: <MW2PR2101MB1116386CFE4628B6767D6CDBC07B0@MW2PR2101MB1116.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:0:fdd5:fbfa:b235:c4a3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc832620-548e-40ff-68d1-08d7648ab152
x-ms-traffictypediagnostic: MW2PR2101MB1052:|MW2PR2101MB1052:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1052A6E0849B16941127F645C07B0@MW2PR2101MB1052.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:462;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(199004)(189003)(54906003)(5660300002)(107886003)(71190400001)(71200400001)(476003)(305945005)(74316002)(8990500004)(10090500001)(4326008)(256004)(7736002)(478600001)(2906002)(6436002)(52536014)(14454004)(186003)(6116002)(10290500003)(66946007)(46003)(66556008)(64756008)(66446008)(8936002)(25786009)(7696005)(9686003)(22452003)(8676002)(81156014)(86362001)(33656002)(55016002)(6506007)(102836004)(76116006)(316002)(66476007)(81166006)(99286004)(110136005)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1052;
 H:MW2PR2101MB1116.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ItU+VTQBKMGNtSS+oMqHZC689rIYbtGPplXXqLnjfUecBFfWRzT6GsdPjiCyBw3ySTEqbtE0zg8EQvyAYZQvZSCCNFLczBaSwxXjYeB7PKSqJXAiZbRbFBRiF3Ql2l3EiKhX6B/MkkjwCD9deVGOA8vwJUu9JdbHXlZkK9FVv3bzkmVG9pJMw+ugY9kEL3+XjyFGfJd61mf/jmcc4bdjZky41+f3zHAhWayQs+NPTbH8MSffmcKcBD3ujW42S2jYyZrEpL1GgAvnYKeQALTLQOvme6QCbLTeB9mzcLuv4XRzJ1DsZFHXw55zIiX7TQFawdHNFJJ4gvptwemvNHCyv3Po2JvA4FVGfUvuRqHiIe7Aso8mHZrLp/mTu8RLssfVQ4O78L0LgQ+0M/kkxOLCXA5504fFWvljcQgPeHHsFf4RqmAIouRgZHCODvVkAl2f
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc832620-548e-40ff-68d1-08d7648ab152
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 20:31:53.7777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6h/LpZqzcgRpdTxc/MmY3cBf+uMTZIm4h2yCJtnHPYlvkhNygA/B9DJPxFcXi+SJ/WohsJd5ag5XuJpVPS4XiLq9c+QubuO37BfM4uMexSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1052
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.114
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This refactors the load library of WHV libraries to make it more
modular. It makes a helper routine that can be called on demand.
This allows future expansion of load library/functions to support
functionality that is depenedent on some feature being available.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 target/i386/whp-dispatch.h |  4 +++
 target/i386/whpx-all.c     | 84 +++++++++++++++++++++++++++++++-----------=
----
 2 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
index 23791fbb47..87d049ceab 100644
--- a/target/i386/whp-dispatch.h
+++ b/target/i386/whp-dispatch.h
@@ -50,5 +50,9 @@ extern struct WHPDispatch whp_dispatch;
=20
 bool init_whp_dispatch(void);
=20
+typedef enum WHPFunctionList {
+    WINHV_PLATFORM_FNS_DEFAULT,
+    WINHV_EMULATION_FNS_DEFAULT,
+} WHPFunctionList;
=20
 #endif /* WHP_DISPATCH_H */
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index ed95105eae..4688f40a65 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -1356,6 +1356,57 @@ static void whpx_handle_interrupt(CPUState *cpu, int=
 mask)
     }
 }
=20
+/*
+ * Load the functions from the given library, using the given handle. If a
+ * handle is provided, it is used, otherwise the library is opened. The
+ * handle will be updated on return with the opened one.
+ */
+static bool load_whp_dipatch_fns(HMODULE *handle, WHPFunctionList function=
_list)
+{
+    HMODULE hLib =3D *handle;
+
+    #define WINHV_PLATFORM_DLL "WinHvPlatform.dll"
+    #define WINHV_EMULATION_DLL "WinHvEmulation.dll"
+    #define WHP_LOAD_FIELD(return_type, function_name, signature) \
+        whp_dispatch.function_name =3D \
+            (function_name ## _t)GetProcAddress(hLib, #function_name); \
+        if (!whp_dispatch.function_name) { \
+            error_report("Could not load function %s", #function_name); \
+            goto error; \
+        } \
+
+    #define WHP_LOAD_LIB(lib_name, handle_lib) \
+    if (!handle_lib) { \
+        handle_lib =3D LoadLibrary(lib_name); \
+        if (!handle_lib) { \
+            error_report("Could not load library %s.", lib_name); \
+            goto error; \
+        } \
+    } \
+
+    switch (function_list) {
+    case WINHV_PLATFORM_FNS_DEFAULT:
+        WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
+        LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
+        break;
+
+    case WINHV_EMULATION_FNS_DEFAULT:
+        WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
+        LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
+        break;
+    }
+
+    *handle =3D hLib;
+    return true;
+
+error:
+    if (hLib) {
+        FreeLibrary(hWinHvEmulation);
+    }
+
+    return false;
+}
+
 /*
  * Partition support
  */
@@ -1491,51 +1542,30 @@ static void whpx_type_init(void)
=20
 bool init_whp_dispatch(void)
 {
-    const char *lib_name;
-    HMODULE hLib;
-
     if (whp_dispatch_initialized) {
         return true;
     }
=20
-    #define WHP_LOAD_FIELD(return_type, function_name, signature) \
-        whp_dispatch.function_name =3D \
-            (function_name ## _t)GetProcAddress(hLib, #function_name); \
-        if (!whp_dispatch.function_name) { \
-            error_report("Could not load function %s from library %s.", \
-                         #function_name, lib_name); \
-            goto error; \
-        } \
-
-    lib_name =3D "WinHvPlatform.dll";
-    hWinHvPlatform =3D LoadLibrary(lib_name);
-    if (!hWinHvPlatform) {
-        error_report("Could not load library %s.", lib_name);
+    if (!load_whp_dipatch_fns(&hWinHvPlatform, WINHV_PLATFORM_FNS_DEFAULT)=
) {
         goto error;
     }
-    hLib =3D hWinHvPlatform;
-    LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
=20
-    lib_name =3D "WinHvEmulation.dll";
-    hWinHvEmulation =3D LoadLibrary(lib_name);
-    if (!hWinHvEmulation) {
-        error_report("Could not load library %s.", lib_name);
+    if (!load_whp_dipatch_fns(&hWinHvEmulation, WINHV_EMULATION_FNS_DEFAUL=
T)) {
         goto error;
     }
-    hLib =3D hWinHvEmulation;
-    LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
=20
     whp_dispatch_initialized =3D true;
-    return true;
-
-    error:
=20
+    return true;
+error:
     if (hWinHvPlatform) {
         FreeLibrary(hWinHvPlatform);
     }
+
     if (hWinHvEmulation) {
         FreeLibrary(hWinHvEmulation);
     }
+
     return false;
 }
=20
--=20
2.16.4


