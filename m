Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04B7C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31FA92178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MV2rLVAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FA92178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSnn0-0005FJ-0p
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 14:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1iSnlm-0004ax-Hx
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:48:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1iSnlj-0005T9-6Q
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:48:36 -0500
Received: from mail-eopbgr740109.outbound.protection.outlook.com
 ([40.107.74.109]:38599 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1iSnli-0005RG-OM
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:48:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYT8qkr3n4X5BUcKQKSchZW6u2zuavcc2q+7ODfnMNABrFfRU0CiE/9qD3p6Flu0Intpyut1r8wmjwgsc/WJZ+AcQ+ibCXIQWJrnnUu88sNRAjvgetywwuPNfgJcG/nvxrW5WGPw+BmvJME8i2K6oI8NTsy6DVq0KZBtgMQ80ElAeehZf9ib5I1LTnAoXwb0DaU9yXzBnNNJTEUsolEJoPJgz7Jqy3xKtyOYyi+JWE9GVJzTIavf55ztdLP4BF64dh432heY1Udkxozjohd5tGVPL/4ZqO4SWVXMBAHk3QaiJnO//eZRTqb8d1IyrJTk44+47Our4FVqSK8jZGlDcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aqw5pGGHdyKCmVWb5AIGEicfRMBW+tnOZmW+SXYNL7g=;
 b=bYOOWkq6mCjboCUMI1zaxVIulaBrdayDpbx76Pjjz18FWt6LYrgxCLwnRXxZmzQormTj85dWy18mc3A+I0odIPjzxlipO4W18g+KQfLOY+vDlbgDdVIxEEfkSmtEQ/BcV463rMeWEZiZ6EFcQEJbuoMGet62h+WMifzU2f+mNG1sIlk73bGtze5+iU+yx50YxAra4lAap9au9cJEe456C51VSYOuokumGeC9XeSH0aVWFgGrymh+zasz76JQNiO/xNKuecowze5MBdL6g/wqSuG9MAq/QxDRyZvQOKOoH71kzcy3nmgkE7crjVrLTEh9SgQ83qGQ1/iSfR2ja0q2Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aqw5pGGHdyKCmVWb5AIGEicfRMBW+tnOZmW+SXYNL7g=;
 b=MV2rLVAdROu8WMkT2XTYjFHzD41ofGqEHhGuqEH2yiMc/RKLBxMoRT1Ugya4CBN7L3OOL05XbXMSQLiBidIgT/83WqhYgnlZL1O02nKPxysuheNNco3Uy1jjI5cSvl1mqwccZEAvoMwDfSNm4THia2mLpOfC9smX2F7LGuwx4FU=
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com (52.132.149.33) by
 MW2PR2101MB1017.namprd21.prod.outlook.com (52.132.146.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.11; Thu, 7 Nov 2019 19:48:33 +0000
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9]) by MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9%7]) with mapi id 15.20.2430.023; Thu, 7 Nov 2019
 19:48:33 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v2] WHPX: support for xcr0
Thread-Topic: [PATCH v2] WHPX: support for xcr0
Thread-Index: AdWVpCACQMQiiI0KR2iuY0/EuyLlQQ==
Date: Thu, 7 Nov 2019 19:48:32 +0000
Message-ID: <MW2PR2101MB1116F07C07A26FD7A7ED8DCFC0780@MW2PR2101MB1116.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:3:fdd2:fbfa:b235:c4a3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23d5f970-3029-4140-7514-08d763bb78af
x-ms-traffictypediagnostic: MW2PR2101MB1017:
x-microsoft-antispam-prvs: <MW2PR2101MB1017DF603B422FB6C96A92DEC0780@MW2PR2101MB1017.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39860400002)(396003)(376002)(136003)(366004)(189003)(199004)(8990500004)(10290500003)(81166006)(25786009)(76116006)(305945005)(74316002)(22452003)(5660300002)(52536014)(10090500001)(478600001)(316002)(110136005)(7736002)(8936002)(9686003)(256004)(99286004)(7696005)(186003)(14454004)(86362001)(486006)(55016002)(33656002)(6506007)(102836004)(6436002)(81156014)(476003)(71190400001)(4326008)(66556008)(2906002)(71200400001)(66476007)(46003)(64756008)(6116002)(8676002)(66446008)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1017;
 H:MW2PR2101MB1116.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dVvwzy6nk6LwbAY6PfdJW14dz27K7R7nW2cuBofsLbq7U51+JhVp8P4FCs2ncHt3CbX6/NiSaUXwiE7Mq2IHhJQBlF2RJJTzlfdWXkR2k0Bwp0r4YvT1G6UTX8ThVnrkLDMU9G9W/wuSjCuHztgjmDV9SVUWdg0vj3+DERVawS5Y+9FPg8P9T9uMVvv3uH1A/qEz16nGCBnNia8KvBgtrKNQ3c6iXx21OPtte8tMJW3NEkN0iCyw2DNbm2XbZ1tSj5eq/ZNrMIlKgMZTFOOIr2dPiSbpbLVrAbcnYT0bTDgKc994oHeNZzNyuAJNxf+SeU4EHzqeoNaRghPKGl5cOaeKdy61SQ08GigdORCxBpybSmyUQwljGgED1lRPWj2VQ85lkvYycPYn6G0T424/039qZbjccApz0zLmPjnlp6kikdLDpa2PhhpDOnfTHvRM
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d5f970-3029-4140-7514-08d763bb78af
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 19:48:32.9024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nn7F1uODtTfUJQjQst87fUyMJeEVI0RrGhQ9HaE4gXKm/qthj+cHkJKEj8OjSDkov20fXXNydKqkXTgp8pDfxWcMhJqbqwSkvVK4zU85n/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1017
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.109
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

Support for xcr0 to be able to enable xsave/xrstor. This by itself
is not sufficient to enable xsave/xrstor. WHPX XSAVE API's also
needs to be hooked up.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
You will need the Windows 10 SDK for RS5 (build 17763) or above to
to be able to compile this patch because of the definition of the
XCR0 register.

Changes since v1:
- Added a sign-off line in the patch.

 target/i386/whp-dispatch.h |  3 ++
 target/i386/whpx-all.c     | 88 ++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 91 insertions(+)

diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
index 23791fbb47..b5d56b22a3 100644
--- a/target/i386/whp-dispatch.h
+++ b/target/i386/whp-dispatch.h
@@ -6,6 +6,9 @@
 #include <WinHvPlatform.h>
 #include <WinHvEmulation.h>
=20
+/* This should eventually come from the Windows SDK */
+#define WHV_E_UNKNOWN_PROPERTY 0x80370302
+
 #define LIST_WINHVPLATFORM_FUNCTIONS(X) \
   X(HRESULT, WHvGetCapability, (WHV_CAPABILITY_CODE CapabilityCode, VOID* =
CapabilityBuffer, UINT32 CapabilityBufferSizeInBytes, UINT32* WrittenSizeIn=
Bytes)) \
   X(HRESULT, WHvCreatePartition, (WHV_PARTITION_HANDLE* Partition)) \
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index ed95105eae..1abaac70db 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -161,10 +161,15 @@ struct whpx_vcpu {
 static bool whpx_allowed;
 static bool whp_dispatch_initialized;
 static HMODULE hWinHvPlatform, hWinHvEmulation;
+static WHV_PROCESSOR_XSAVE_FEATURES whpx_xsave_cap;
=20
 struct whpx_state whpx_global;
 struct WHPDispatch whp_dispatch;
=20
+static bool whpx_has_xsave(void)
+{
+    return whpx_xsave_cap.XsaveSupport;
+}
=20
 /*
  * VP support
@@ -216,6 +221,28 @@ static SegmentCache whpx_seg_h2q(const WHV_X64_SEGMENT=
_REGISTER *hs)
     return qs;
 }
=20
+/* X64 Extended Control Registers */
+static void whpx_set_xcrs(CPUState *cpu)
+{
+    struct CPUX86State *env =3D (CPUArchState *)(cpu->env_ptr);
+    HRESULT hr;
+    struct whpx_state *whpx =3D &whpx_global;
+    WHV_REGISTER_VALUE xcr0;
+    WHV_REGISTER_NAME xcr0_name =3D WHvX64RegisterXCr0;
+
+    if (!whpx_has_xsave()) {
+        return;
+    }
+
+    /* Only xcr0 is supported by the hypervisor currently */
+    xcr0.Reg64 =3D env->xcr0;
+    hr =3D whp_dispatch.WHvSetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index, &xcr0_name, 1, &xcr0);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set register xcr0, hr=3D%08lx", hr);
+    }
+}
+
 static void whpx_set_registers(CPUState *cpu)
 {
     struct whpx_state *whpx =3D &whpx_global;
@@ -291,6 +318,12 @@ static void whpx_set_registers(CPUState *cpu)
=20
     /* 8 Debug Registers - Skipped */
=20
+    /*
+     * Extended control registers needs to be handled separately depending
+     * on whether xsave is supported/enabled or not.
+     */
+    whpx_set_xcrs(cpu);
+
     /* 16 XMM registers */
     assert(whpx_register_names[idx] =3D=3D WHvX64RegisterXmm0);
     idx_next =3D idx + 16;
@@ -380,6 +413,30 @@ static void whpx_set_registers(CPUState *cpu)
     return;
 }
=20
+/* X64 Extended Control Registers */
+static void whpx_get_xcrs(CPUState *cpu)
+{
+    struct CPUX86State *env =3D (CPUArchState *)(cpu->env_ptr);
+    HRESULT hr;
+    struct whpx_state *whpx =3D &whpx_global;
+    WHV_REGISTER_VALUE xcr0;
+    WHV_REGISTER_NAME xcr0_name =3D WHvX64RegisterXCr0;
+
+    if (!whpx_has_xsave()) {
+        return;
+    }
+
+    /* Only xcr0 is supported by the hypervisor currently */
+    hr =3D whp_dispatch.WHvGetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index, &xcr0_name, 1, &xcr0);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get register xcr0, hr=3D%08lx", hr);
+        return;
+    }
+
+    env->xcr0 =3D xcr0.Reg64;
+}
+
 static void whpx_get_registers(CPUState *cpu)
 {
     struct whpx_state *whpx =3D &whpx_global;
@@ -457,6 +514,12 @@ static void whpx_get_registers(CPUState *cpu)
=20
     /* 8 Debug Registers - Skipped */
=20
+    /*
+     * Extended control registers needs to be handled separately depending
+     * on whether xsave is supported/enabled or not.
+     */
+    whpx_get_xcrs(cpu);
+
     /* 16 XMM registers */
     assert(whpx_register_names[idx] =3D=3D WHvX64RegisterXmm0);
     idx_next =3D idx + 16;
@@ -1395,6 +1458,31 @@ static int whpx_accel_init(MachineState *ms)
         goto error;
     }
=20
+    /*
+     * Query the XSAVE capability of the partition. Any error here is not
+     * considered fatal.
+     */
+    hr =3D whp_dispatch.WHvGetPartitionProperty(
+        whpx->partition,
+        WHvPartitionPropertyCodeProcessorXsaveFeatures,
+        &whpx_xsave_cap,
+        sizeof(whpx_xsave_cap),
+        &whpx_cap_size);
+
+    /*
+     * Windows version which don't support this property will return with =
the
+     * specific error code.
+     */
+    if (FAILED(hr) && hr !=3D WHV_E_UNKNOWN_PROPERTY) {
+        error_report("WHPX: Failed to query XSAVE capability, hr=3D%08lx",=
 hr);
+    }
+
+    if (whpx_has_xsave()) {
+        printf("WHPX: Partition XSAVE capable\n");
+    } else {
+        printf("WHPX: Partition is not XSAVE capable\n");
+    }
+
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ProcessorCount =3D ms->smp.cpus;
     hr =3D whp_dispatch.WHvSetPartitionProperty(
--=20
2.16.4


