Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9004C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 21:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5FB2084C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 21:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ioomyoBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5FB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSTCx-0001xG-LK
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 16:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1iSSUr-0000Mn-8f
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 16:05:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1iSSUo-0003QJ-Sk
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 16:05:44 -0500
Received: from mail-eopbgr800132.outbound.protection.outlook.com
 ([40.107.80.132]:56668 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1iSSUo-0003OF-Ey
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 16:05:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNMJHsw/KWKOczBxdLykG7xfhO9M33MkAZZeEknHIrTBTuvS0HiO5TcGbY1M6ksKo2D9vGZrPJRrvbefjZbZCMYMbK5qLMrOL4Xl0+9EQuf1zFoRNpFZOuUMJIQtiDgO8KVNYBndFzhFN+csRcv3rsEQP1Zk6BTkH3HEtj7ZHCw+yachYEatnYISwxn0PxKT1LMypk4qSBYj3hl1ukbASuXb+0jU5yU3mC2tDxu00gNY8mRM9184I5xcoGu0xT94G/ACcGBI88cA7u1XmzWbsY6OEkzNu9wHjIO9Z/oV0cvE0VDS1GMTyBbeZI7IG6oalHtSlKnw9JYfXyVftATgHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0KUWq8H2IUEoDetgCO1kWQAG1jDc+86CitXQR7sH74=;
 b=Y5mTYsYV7sw1qxTQztdEI/bhOg1snQx2CBgWeRGOuOL6V03gCruowNWhlfXHpE/Ba/ySrolxs4IJ12eijZgIeZV9ZyifUTF1+d2DZ85PAfkJjKjrzltx+G5KXKvrMmNhjcilMBV/HxYMvaZLZrT4dchEI6LBFb6x1qefy24peINz7sgb8ZIuo57/oZNnRtyaerHPnKbVl9Ah56eWvkJvHNbLMcJ0otncEf+QoY7e92+vx1Q8AQ7znGVX01iUjw9wmmlKxBoOIYdyI5qHLOfniHbqoSGGwcaJSPdlhKFxk+EXTiXrl+ulSmp+opb9IlcL0HVDxJXcBaeMQYU6Ps7HgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0KUWq8H2IUEoDetgCO1kWQAG1jDc+86CitXQR7sH74=;
 b=ioomyoBODldQWn+cyI7ezwP6u8OUMAuuS/B0puVaxBSfS46+32j3HkZk81CEmF9iOvbqTtZdeFonj58wL3I8nxM6CcHwS1CbL6BAac4W8HTsxX+YKwicSSbHiJJbX6eeHK6rPSlfNuo3EekTz4KrkmH6yOXmpsX4p2gRFPl9rTE=
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com (52.132.149.33) by
 MW2PR2101MB0988.namprd21.prod.outlook.com (52.132.146.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 21:05:39 +0000
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9]) by MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9%7]) with mapi id 15.20.2430.017; Wed, 6 Nov 2019
 21:05:39 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] WHPX: support for xcr0
Thread-Topic: [PATCH] WHPX: support for xcr0
Thread-Index: AdWU5TD602z9UnduTf+niAL8Kdnsiw==
Date: Wed, 6 Nov 2019 21:05:39 +0000
Message-ID: <MW2PR2101MB1116E938A5BE3174EF5EC9B9C0790@MW2PR2101MB1116.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:78b2:55bc:2177:4b7d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a08611d4-8cbc-478e-a797-08d762fd13ff
x-ms-traffictypediagnostic: MW2PR2101MB0988:
x-microsoft-antispam-prvs: <MW2PR2101MB098849E2A349C290249478E0C0790@MW2PR2101MB0988.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(8990500004)(478600001)(71190400001)(81156014)(81166006)(8676002)(14454004)(6116002)(46003)(4326008)(66556008)(64756008)(7696005)(66476007)(2906002)(8936002)(10090500001)(33656002)(66946007)(66446008)(186003)(99286004)(55016002)(6506007)(86362001)(7736002)(316002)(71200400001)(5660300002)(6436002)(110136005)(74316002)(76116006)(102836004)(22452003)(9686003)(305945005)(486006)(10290500003)(256004)(476003)(25786009)(52536014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB0988;
 H:MW2PR2101MB1116.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GGnTJCjUz6RXLoQ5F9VDytJh+aTg06TYD/bu6SPA1z20KYcQSrcgl7855Gj5Hfwg4BlTJFCLNHCQQ3PWyGvF2ofdQJ6GT4iiwSCCmXNnvntmQ2x6uY7i7acd2CKopfW0hPGkCrTCToC2ZcOcsyNLGCOQD4oCS0S76BH1eaQD12ATCRdIpI9eusvutcmgWWtojfkuef578BpsG/kogO1mvzTUKDyWfFGqrphAJvzi7jJtsYNPt5GscsvXmbUIDgqdWxK1aSHYHi5h52iTcSQ44lpI1JihoOhueWujuMfbILkgBkXkiCBDu1yn/xFxzTe0mdC0MtahZNkSKB8Wd0+jdHxySRrN9D82oYMHK03nqYIAJCsRGEYdhk2gdUkQoksNvx4LzeygvvHoZXwzVW1iosaBXeHbM3Qfq4irv/WPfFlcmwrSAP4U8uh00nP4XjGr
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08611d4-8cbc-478e-a797-08d762fd13ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 21:05:39.6365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4w7TvB33US8/9O9t6P3qrG7SMYsLbVgvGcyFb6Ay7Yp30cQYYXD2l3+OJfEM0MGVg1jLyETTO5S2jH3KNDOwNrvB9j7e4BvTJjWsr+kT5cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0988
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.132
X-Mailman-Approved-At: Wed, 06 Nov 2019 16:48:46 -0500
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
---
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


