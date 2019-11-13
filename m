Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2AEC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 18:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3929220658
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 18:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ElU5uCVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3929220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUxny-0003S5-Vh
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 13:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1iUxmv-0002qC-9G
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 13:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1iUxms-0003OS-Qz
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 13:54:44 -0500
Received: from mail-eopbgr820109.outbound.protection.outlook.com
 ([40.107.82.109]:47392 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1iUxms-0003Mz-DC
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 13:54:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUQ0oSjco8cQtOGc81+zLNVupzKXklqmnrkj/eduB5aQbCgptyCi1XlemHJFlES342G5Nb9qxq3bYxj+81yIwXVZ4gbxmqmdSCeFL7Z/JWvLqAM1j9E1fXgo9zVoSrswypOIHfmJSJSSNdxpuYiOP8U6jVTL9v2Id/fNNr4OG2Dj/SBL42osfRLvRldR8GwfxoQ5nVti9t7Y3Q6317GCM+gqGj0u42cHNW+VfbIHQe75fApOTCTDNoJYauA+JbufehFyP/4+a9s5steu3938HH/meB5yLdA+1C3tsK7LQ/6CN4330fyooqaZZB3qh9QplsZi4/k4S+atQOD+yj2CBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0Fgw5bWLVeKwtICpTax3foBs9SEuMOQ1KecCnAc5rM=;
 b=Igtwly+6Alfkl5NRvbunryCoWvDYl6FydDh5p/WKi1yeHLKWCAOGeYqJ7albWGWJgLml0bpzll31esfOJvULHCGDdAUeD5puudQUSLsSQ9M1flK37OKpLzPfNQg92APELk/NS8DhXcgmjLoi+6s8kF4qY7R/hQ2EsVJPktmvxHeAxBO4U1JZLFzD6VZZI3yWOz+QAFtur/Fi4kmcajKEIGrQ1WoAglMaX4498EUeiXnG4/D7bjTQW8TUkksB9UXD4GCtdnMGCc7PV9fqqC/vd0UMuykCVnwLn9sdM2MBYzVVCi85iH+0PBHQIqelc7pNardIFQwAVOdnsJjlnLpmFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0Fgw5bWLVeKwtICpTax3foBs9SEuMOQ1KecCnAc5rM=;
 b=ElU5uCVhDtPwb+IMaq4Axnj0/BKgi5Vg3XAaZX408Acjb6wwwHxjNgX5shdQyihHgwAV3YjhmBWCKNtNhUY2smVTeirAEjEcHMiAdMClzdxJ3Q3jzWIXjRUkCODsTtM57HnTjVBAg5AhfIno1SIdksVH4950z0vwtPyEE5raRbc=
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com (52.132.149.33) by
 MW2PR2101MB1033.namprd21.prod.outlook.com (52.132.146.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.13; Wed, 13 Nov 2019 18:54:39 +0000
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9]) by MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9%6]) with mapi id 15.20.2474.008; Wed, 13 Nov 2019
 18:54:39 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Justin Terry (VM)" <juterry@microsoft.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson
 <rth@twiddle.net>, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH V2] WHPX: refactor load library
Thread-Topic: [PATCH V2] WHPX: refactor load library
Thread-Index: AdWaUd8/6mEmp4uvSD+66MN6upFeBA==
Date: Wed, 13 Nov 2019 18:54:39 +0000
Message-ID: <MW2PR2101MB1116578040BE1F0C1B662318C0760@MW2PR2101MB1116.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:8:1cef:6b41:87e5:6afe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a423fcd-46f8-42d7-5c6d-08d7686aefc7
x-ms-traffictypediagnostic: MW2PR2101MB1033:|MW2PR2101MB1033:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1033170549C6968670398BCCC0760@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:462;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(316002)(2906002)(8676002)(81166006)(81156014)(5660300002)(54906003)(110136005)(7736002)(8936002)(478600001)(305945005)(8990500004)(74316002)(99286004)(6636002)(33656002)(10290500003)(22452003)(256004)(55016002)(102836004)(9686003)(86362001)(186003)(71200400001)(71190400001)(6436002)(6506007)(1511001)(7696005)(14454004)(4326008)(476003)(46003)(76116006)(6116002)(66946007)(66476007)(66556008)(64756008)(66446008)(10090500001)(52536014)(486006)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1033;
 H:MW2PR2101MB1116.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xdzUjjK5IGXUmxMoy0pcLi6KqzYGG9ltQxfNZYKcRbw56SWN3SnDvW+RDxLmUapsXlAXs0eedrxuxD9aNmjgU4mUizBH2STxjIwqHSreIvh0dd5xH/Hta8lnkqsPXUAiTx1cOkTgKmnlAn4yvg6G9MRYPR7VbO55PV8znUbLNWKZcAsoEvsX3qXoGazdVvxRG0YxyfzRua/HEINN1R9CgBnrWN3O9cAiAC57+7b6hDfPmX5nKzTgzPHTcHP3Dm8zgRprBvtbUv4XXVr6ZcS8lHVAtALqRwAdtIQrngewcU/sG3FZ38ZKv8BEU39STlvQSUpL0W699xyT6FWHEVFNuYNSdLfdAGahsKYOmEe4PK5DbLw8UO9+pI263Vgd8hajPQAdswCdzeuj3if/5RGIKsSnw5t0u//jy/fEs0B6W7AmcnEKo9Ki7ap6ti2JyqGr
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a423fcd-46f8-42d7-5c6d-08d7686aefc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 18:54:39.3397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /KRCyoDxLrbff3B+/5kNafS2JHHxzc824zvnhLe1uQd3LX7+brdPBES496WvLDbN9s9VBNF66OcU5euWPUUQXLKuRqKs8b16C7B7WMm64g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.109
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
functionality that is dependent on some feature being available.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
Changes since v1:
- Fixed typo of load_whp_dispatch_fns
- Fixed free of the right handle

 target/i386/whp-dispatch.h |  4 +++
 target/i386/whpx-all.c     | 85 +++++++++++++++++++++++++++++++-----------=
----
 2 files changed, 62 insertions(+), 27 deletions(-)

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
index ed95105eae..f3c61fa5d8 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -1356,6 +1356,58 @@ static void whpx_handle_interrupt(CPUState *cpu, int=
 mask)
     }
 }
=20
+/*
+ * Load the functions from the given library, using the given handle. If a
+ * handle is provided, it is used, otherwise the library is opened. The
+ * handle will be updated on return with the opened one.
+ */
+static bool load_whp_dispatch_fns(HMODULE *handle,
+    WHPFunctionList function_list)
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
+        FreeLibrary(hLib);
+    }
+
+    return false;
+}
+
 /*
  * Partition support
  */
@@ -1491,51 +1543,30 @@ static void whpx_type_init(void)
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
+    if (!load_whp_dispatch_fns(&hWinHvPlatform, WINHV_PLATFORM_FNS_DEFAULT=
)) {
         goto error;
     }
-    hLib =3D hWinHvPlatform;
-    LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
=20
-    lib_name =3D "WinHvEmulation.dll";
-    hWinHvEmulation =3D LoadLibrary(lib_name);
-    if (!hWinHvEmulation) {
-        error_report("Could not load library %s.", lib_name);
+    if (!load_whp_dispatch_fns(&hWinHvEmulation, WINHV_EMULATION_FNS_DEFAU=
LT)) {
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


