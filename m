Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE307C4BA21
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 20:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DD524656
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 20:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AlQAINvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DD524656
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j73iS-0004HQ-Hr
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 15:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1j73hd-0003qa-I1
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1j73hb-00088w-4X
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:54:44 -0500
Received: from mail-mw2nam10on2097.outbound.protection.outlook.com
 ([40.107.94.97]:4680 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1j73ha-000830-Mc
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:54:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6sdPjgiuuLlgSj+2xKHfogIdprQH6ywbJX+eBmFBcrqngAbNuCvE1SkPUuAxpAXkAHNvVIHxGZkQ+/ZydwPRD0pmEaPXwVqmTOn1F4oEE/uUYCdhFuC/FJv4pFT+Twn4gftUUXB0Yptco9da9A+HLJJ5XXEaAhnOh7vdb8YNs21lcxzaRI1IbEev8K/5ReO56H+qn2F6LYlTsHh0IWW2pnHQ+1+Z0nXPApygIz1b9RGsjDCwf59fO3c1b8lVjThf2FXjFPEZdd2EbV66CDBf5EfJJyS9qC7qsnTZIw1iJjVVcgGQfeC9ByhNTKdBd1atwQfgXkvhjZFVJDpT80dIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEgk934HlgL/l3GWEQJp/kCVPPf/74IAttkEneD6WX0=;
 b=EixHaFp/DntxPojpabM2zXwtD/8xxJZotbE4Ahz70LuoNuqj/KQI0CguXjts9cZWtenYd+TgVPIYwQTc8cM92PRsYyK6IuWrW+WDPwHRT4DaR4BkAvcJOKYw5SyeK/QzgL9N74A+JqrccUyK8McbtrX6ozr8+PGtMbvib0et/CJdImUQu2laLygHuj2zoNNwU4DoTWGO31fFg/hekSVHyGX7WYmMwlE+MnRX+VqnX16IF/D6+IHRJfnOgQ7PFDdik6gX1djasBbgIeRaPc+GItcK9SX3P8cNOl5yEqc3K+ovRIvyqQLBaS6xC1DXFni4U3xkaD7vVU2trbGkx49Nxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEgk934HlgL/l3GWEQJp/kCVPPf/74IAttkEneD6WX0=;
 b=AlQAINvdahFb72hden6hbS41uxuFhM8MyO+KP4oXuC6TuwvEIHMJ3whm4EgYyml/o7EAjVN0m+IO452FK/iHBgjZh6ea3SPFUy2pFP12MXoUWqwswU+WckM1zKiK2AQV2qwKXMzNkCAo2xL+ggHoIn/khCpJI+rtXnHJKl2LF0g=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN4PR2101MB0878.namprd21.prod.outlook.com
 (2603:10b6:803:51::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.3; Wed, 26 Feb
 2020 20:54:39 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::15c9:bf73:c204:7cb7]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::15c9:bf73:c204:7cb7%8]) with mapi id 15.20.2793.003; Wed, 26 Feb 2020
 20:54:39 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Weil
 <sw@weilnetz.de>
Subject: PATCH] WHPX: TSC get and set should be dependent on VM state
Thread-Topic: PATCH] WHPX: TSC get and set should be dependent on VM state
Thread-Index: AdXs5oCBJsjFayPuQg++a0KvVJgCQQ==
Date: Wed, 26 Feb 2020 20:54:39 +0000
Message-ID: <SN4PR2101MB08804D23439166E81FF151F7C0EA0@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:b:3028:825f:ab03:1fb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14cb7dce-8827-4361-91ff-08d7bafe18ed
x-ms-traffictypediagnostic: SN4PR2101MB0878:
x-microsoft-antispam-prvs: <SN4PR2101MB0878133844A79AADB8E74675C0EA0@SN4PR2101MB0878.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(199004)(189003)(66476007)(66556008)(76116006)(66946007)(64756008)(478600001)(55016002)(4326008)(10290500003)(9686003)(66446008)(110136005)(54906003)(316002)(33656002)(8936002)(71200400001)(7696005)(186003)(2906002)(52536014)(8990500004)(81166006)(6506007)(81156014)(86362001)(8676002)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN4PR2101MB0878;
 H:SN4PR2101MB0880.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NuShxZ5ek+tpoBhkUrHo4qMUFp8ygVG6uHK0JaIdXKB9x0Rk7d8USlPnV6nleI9wYIF6AzTiaor1tK520x93eklmwAgUZr1J4qq7YI/Dar+8WFDaPesQGeKKKSAo/4bDaYtMYPE4EMMZ6yP9aswXl3IfRaCbmjDxuZOlOfMQQREC0RFIMUo/5vmndzTYBhfG0EALM7NkF9lC/oLVxzuER/V5GrvgIGCcRlZ3t5AOmYpRY6ClaVBHqHxiRaU2Q2goDaGuDbrnX8XZliIcROlYQSSrjnLywVC2JYx07JKuj1PL5S2DPfjBqbTA9bdqcMbi5ua7betw0k+AoiEbdgOIAEPW9p6jCp06fDzZn/E+MjwSb+RfrFioL3lqs9npI38w9u25BwuEQbuOFx+8VUy1hv8SL6bAR5+3PaRqPP0Cvh5pAYOcq4I58D5tFm8j46fT
x-ms-exchange-antispam-messagedata: xPbSgP8U4Omz0pH1hLezVxApDcgCYYYytgg/xZbe3TuYTGFn73bjt28RalPtTU6ZzvxrUzFKw6IVoBuGpHcrzKoZrE4oe2vrZdiVciiqh3iJHo2uPxCV2idbGf/vTMcErOj9WZJgnHDHWcLMUBn2K1zOZ8oizvmXL8INJYzbpfQajHI+nJbn0whE4N/fuGalyG6Vc5iDfobuPWiiekwzGQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cb7dce-8827-4361-91ff-08d7bafe18ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 20:54:39.7877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLifqiqTMcqouHW62jBk6Mx+1OU72jLsXvnuzH/061Qx+f4n1/QKwJeI4gf5K8UXKU7kLen8ctkrl0h/fWeZAe95QRYQYCB6LwYgyX93nvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0878
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.97
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

Currently, TSC is set as part of the VM runtime state. Setting TSC at
runtime is heavy and additionally can have side effects on the guest,
which are not very resilient to variances in the TSC. This patch uses
the VM state to determine whether to set TSC or not. Some minor
enhancements for getting TSC values as well that considers the VM state.

Additionally, while setting the TSC, the partition is suspended to
reduce the variance in the TSC value across vCPUs.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 include/sysemu/whpx.h      |   7 +++
 target/i386/whp-dispatch.h |   9 ++++
 target/i386/whpx-all.c     | 103 +++++++++++++++++++++++++++++++++----
 3 files changed, 110 insertions(+), 9 deletions(-)

diff --git a/include/sysemu/whpx.h b/include/sysemu/whpx.h
index 4794e8effe..a84b49e749 100644
--- a/include/sysemu/whpx.h
+++ b/include/sysemu/whpx.h
@@ -35,4 +35,11 @@ int whpx_enabled(void);
=20
 #endif /* CONFIG_WHPX */
=20
+/* state subset only touched by the VCPU itself during runtime */
+#define WHPX_SET_RUNTIME_STATE   1
+/* state subset modified during VCPU reset */
+#define WHPX_SET_RESET_STATE     2
+/* full state set, modified during initialization or on vmload */
+#define WHPX_SET_FULL_STATE      3
+
 #endif /* QEMU_WHPX_H */
diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
index 87d049ceab..e4695c349f 100644
--- a/target/i386/whp-dispatch.h
+++ b/target/i386/whp-dispatch.h
@@ -23,6 +23,12 @@
   X(HRESULT, WHvGetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partit=
ion, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 Registe=
rCount, WHV_REGISTER_VALUE* RegisterValues)) \
   X(HRESULT, WHvSetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partit=
ion, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 Registe=
rCount, const WHV_REGISTER_VALUE* RegisterValues)) \
=20
+/*
+ * These are supplemental functions that may not be present
+ * on all versions and are not critical for basic functionality.
+ */
+#define LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(X) \
+  X(HRESULT, WHvSuspendPartitionTime, (WHV_PARTITION_HANDLE Partition)) \
=20
 #define LIST_WINHVEMULATION_FUNCTIONS(X) \
   X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Cal=
lbacks, WHV_EMULATOR_HANDLE* Emulator)) \
@@ -40,10 +46,12 @@
 /* Define function typedef */
 LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
 LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
+LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DEFINE_TYPE)
=20
 struct WHPDispatch {
     LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
     LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
+    LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DECLARE_MEMBER)
 };
=20
 extern struct WHPDispatch whp_dispatch;
@@ -53,6 +61,7 @@ bool init_whp_dispatch(void);
 typedef enum WHPFunctionList {
     WINHV_PLATFORM_FNS_DEFAULT,
     WINHV_EMULATION_FNS_DEFAULT,
+    WINHV_PLATFORM_FNS_SUPPLEMENTAL
 } WHPFunctionList;
=20
 #endif /* WHP_DISPATCH_H */
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 35601b8176..6a885c0fb3 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -114,7 +114,6 @@ static const WHV_REGISTER_NAME whpx_register_names[] =
=3D {
     WHvX64RegisterXmmControlStatus,
=20
     /* X64 MSRs */
-    WHvX64RegisterTsc,
     WHvX64RegisterEfer,
 #ifdef TARGET_X86_64
     WHvX64RegisterKernelGsBase,
@@ -215,7 +214,44 @@ static SegmentCache whpx_seg_h2q(const WHV_X64_SEGMENT=
_REGISTER *hs)
     return qs;
 }
=20
-static void whpx_set_registers(CPUState *cpu)
+static int whpx_set_tsc(CPUState *cpu)
+{
+    struct CPUX86State *env =3D (CPUArchState *)(cpu->env_ptr);
+    WHV_REGISTER_NAME tsc_reg =3D WHvX64RegisterTsc;
+    WHV_REGISTER_VALUE tsc_val;
+    HRESULT hr;
+    struct whpx_state *whpx =3D &whpx_global;
+
+    /*
+     * Suspend the partition prior to setting the TSC to reduce the varian=
ce
+     * in TSC across vCPUs. When the first vCPU runs post suspend, the
+     * partition is automatically resumed.
+     */
+    if (whp_dispatch.WHvSuspendPartitionTime) {
+
+        /*
+         * Unable to suspend partition while setting TSC is not a fatal
+         * error. It just increases the likelihood of TSC variance between
+         * vCPUs and some guest OS are able to handle that just fine.
+         */
+        hr =3D whp_dispatch.WHvSuspendPartitionTime(whpx->partition);
+        if (FAILED(hr)) {
+            warn_report("WHPX: Failed to suspend partition, hr=3D%08lx", h=
r);
+        }
+    }
+
+    tsc_val.Reg64 =3D env->tsc;
+    hr =3D whp_dispatch.WHvSetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index, &tsc_reg, 1, &tsc_val);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set TSC, hr=3D%08lx", hr);
+        return -1;
+    }
+
+    return 0;
+}
+
+static void whpx_set_registers(CPUState *cpu, int level)
 {
     struct whpx_state *whpx =3D &whpx_global;
     struct whpx_vcpu *vcpu =3D get_whpx_vcpu(cpu);
@@ -230,6 +266,14 @@ static void whpx_set_registers(CPUState *cpu)
=20
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
=20
+    /*
+     * Following MSRs have side effects on the guest or are too heavy for
+     * runtime. Limit them to full state update.
+     */
+    if (level >=3D WHPX_SET_RESET_STATE) {
+        whpx_set_tsc(cpu);
+    }
+
     memset(&vcxt, 0, sizeof(struct whpx_register_set));
=20
     v86 =3D (env->eflags & VM_MASK);
@@ -330,8 +374,6 @@ static void whpx_set_registers(CPUState *cpu)
     idx +=3D 1;
=20
     /* MSRs */
-    assert(whpx_register_names[idx] =3D=3D WHvX64RegisterTsc);
-    vcxt.values[idx++].Reg64 =3D env->tsc;
     assert(whpx_register_names[idx] =3D=3D WHvX64RegisterEfer);
     vcxt.values[idx++].Reg64 =3D env->efer;
 #ifdef TARGET_X86_64
@@ -379,6 +421,25 @@ static void whpx_set_registers(CPUState *cpu)
     return;
 }
=20
+static int whpx_get_tsc(CPUState *cpu)
+{
+    struct CPUX86State *env =3D (CPUArchState *)(cpu->env_ptr);
+    WHV_REGISTER_NAME tsc_reg =3D WHvX64RegisterTsc;
+    WHV_REGISTER_VALUE tsc_val;
+    HRESULT hr;
+    struct whpx_state *whpx =3D &whpx_global;
+
+    hr =3D whp_dispatch.WHvGetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index, &tsc_reg, 1, &tsc_val);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get TSC, hr=3D%08lx", hr);
+        return -1;
+    }
+
+    env->tsc =3D tsc_val.Reg64;
+    return 0;
+}
+
 static void whpx_get_registers(CPUState *cpu)
 {
     struct whpx_state *whpx =3D &whpx_global;
@@ -394,6 +455,11 @@ static void whpx_get_registers(CPUState *cpu)
=20
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
=20
+    if (!env->tsc_valid) {
+        whpx_get_tsc(cpu);
+        env->tsc_valid =3D !runstate_is_running();
+    }
+
     hr =3D whp_dispatch.WHvGetVirtualProcessorRegisters(
         whpx->partition, cpu->cpu_index,
         whpx_register_names,
@@ -492,8 +558,6 @@ static void whpx_get_registers(CPUState *cpu)
     idx +=3D 1;
=20
     /* MSRs */
-    assert(whpx_register_names[idx] =3D=3D WHvX64RegisterTsc);
-    env->tsc =3D vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] =3D=3D WHvX64RegisterEfer);
     env->efer =3D vcxt.values[idx++].Reg64;
 #ifdef TARGET_X86_64
@@ -896,7 +960,7 @@ static int whpx_vcpu_run(CPUState *cpu)
=20
     do {
         if (cpu->vcpu_dirty) {
-            whpx_set_registers(cpu);
+            whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
             cpu->vcpu_dirty =3D false;
         }
=20
@@ -1074,14 +1138,14 @@ static void do_whpx_cpu_synchronize_state(CPUState =
*cpu, run_on_cpu_data arg)
 static void do_whpx_cpu_synchronize_post_reset(CPUState *cpu,
                                                run_on_cpu_data arg)
 {
-    whpx_set_registers(cpu);
+    whpx_set_registers(cpu, WHPX_SET_RESET_STATE);
     cpu->vcpu_dirty =3D false;
 }
=20
 static void do_whpx_cpu_synchronize_post_init(CPUState *cpu,
                                               run_on_cpu_data arg)
 {
-    whpx_set_registers(cpu);
+    whpx_set_registers(cpu, WHPX_SET_FULL_STATE);
     cpu->vcpu_dirty =3D false;
 }
=20
@@ -1123,6 +1187,15 @@ void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu)
=20
 static Error *whpx_migration_blocker;
=20
+static void whpx_cpu_update_state(void *opaque, int running, RunState stat=
e)
+{
+    CPUX86State *env =3D opaque;
+
+    if (running) {
+        env->tsc_valid =3D false;
+    }
+}
+
 int whpx_init_vcpu(CPUState *cpu)
 {
     HRESULT hr;
@@ -1178,6 +1251,7 @@ int whpx_init_vcpu(CPUState *cpu)
=20
     cpu->vcpu_dirty =3D true;
     cpu->hax_vcpu =3D (struct hax_vcpu_state *)vcpu;
+    qemu_add_vm_change_state_handler(whpx_cpu_update_state, cpu->env_ptr);
=20
     return 0;
 }
@@ -1367,6 +1441,10 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
=20
     #define WINHV_PLATFORM_DLL "WinHvPlatform.dll"
     #define WINHV_EMULATION_DLL "WinHvEmulation.dll"
+    #define WHP_LOAD_FIELD_OPTIONAL(return_type, function_name, signature)=
 \
+        whp_dispatch.function_name =3D \
+            (function_name ## _t)GetProcAddress(hLib, #function_name); \
+
     #define WHP_LOAD_FIELD(return_type, function_name, signature) \
         whp_dispatch.function_name =3D \
             (function_name ## _t)GetProcAddress(hLib, #function_name); \
@@ -1394,6 +1472,11 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
         WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
         LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
         break;
+
+    case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
+        WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
+        LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_LOAD_FIELD_OPTIONAL)
+        break;
     }
=20
     *handle =3D hLib;
@@ -1554,6 +1637,8 @@ bool init_whp_dispatch(void)
         goto error;
     }
=20
+    assert(load_whp_dispatch_fns(&hWinHvPlatform,
+        WINHV_PLATFORM_FNS_SUPPLEMENTAL));
     whp_dispatch_initialized =3D true;
=20
     return true;
--=20
2.17.1

