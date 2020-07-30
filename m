Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D1FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 22:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABEFC20838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 22:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SzQNMmdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEFC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1GmY-0001Fe-15
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 18:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1k1Glv-0000pV-H3
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 18:11:31 -0400
Received: from mail-dm6nam11on2132.outbound.protection.outlook.com
 ([40.107.223.132]:19160 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1k1Glt-0001AG-Ij
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 18:11:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBrmVBwkmwWt5ePcMZ4bBW7e+A7Ud+IqX3aY1slI3JoT7HJPxXh6gu4ohPfK7mEj7MUQP+SEJ/Fzfk82HTz0LLenZQ4LfohfGiCtXm3xp9srWzKzbAx6kKIUG1jKhXp/rcNQlwTQRQEHCpZyUYle7H/S2SUjyr2H2qV2IVFqYw4061yY7aSUbwJ7dtVoSVOHTFJUDIfb3UpNW3qkmJvo5ZvVRqGIKK/6ijWzjgvs1qV0YqRZChYLErVjyMB3t/SPxe5yPG2efjPcv93tyT9ZotmfJu6zi+b7gUQuhWZD1QHef8zQteFSvdm9Dm/UFu1Ndwp/ZYWl7vzXvZt59s6jNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wsYCZ20nnPnoGpbpPWwggkwDhavPDQGWBA1ruojhco=;
 b=LSbr8macfplaNOmGJmqtYcZmXcpQ4kPC/Sw4a6mvbh2CIAcvCl//w/9FNgwbp/JGlCn/TLCKyY5pfQNSgZTEq6c1Fkihz4oA9ZhMpDTBvR3Egoz0xCa/q6jdak+FWmYiJ6gCZya73/5gK5KnaAv9os63pX5z2vfGke6M0bqRH+QSojLHZnJrx71s1XSO0oVixjnaBg3XiQHBhcmgHo1fTAw99ia1RJXSksUtpXfXi9npsrr1AW2oddJmDWKppR5ryyGMyWoxarRwM0bZlpaAsYSg/AusbnEUqohFmb7UR6Ul6sBsiaE2q7F0iAjr71pt2Q8O3LO2eN5vsuqXQyjnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wsYCZ20nnPnoGpbpPWwggkwDhavPDQGWBA1ruojhco=;
 b=SzQNMmdObO26i1SNKqWYsj3GHO19fVy8ynjOOdvZWn01fffPc96S61g5N0U1DlPKuJIAaJ6zhLJepLy5NSUsuUEA4UF6vPfep5r74LNyX62Jo4RAPRH0157Ya/i0T+ChxldJj6Th764FgBu4cSNZQaV4zq6EjzYlIz4IDtjOXYc=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB0911.namprd21.prod.outlook.com
 (2603:10b6:805:a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9; Thu, 30 Jul
 2020 22:11:26 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::99a:30fe:609e:be35]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::99a:30fe:609e:be35%8]) with mapi id 15.20.3239.016; Thu, 30 Jul 2020
 22:11:26 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Weil
 <sw@weilnetz.de>
Subject: [PATCH] WHPX: vmware cpuid leaf for tsc and apic frequency
Thread-Topic: [PATCH] WHPX: vmware cpuid leaf for tsc and apic frequency
Thread-Index: AdZmvkwMdobd7GWITmu6pdxDKVKTrw==
Date: Thu, 30 Jul 2020 22:11:26 +0000
Message-ID: <SN4PR2101MB08808DFDDC3F442BBEAADFF4C0710@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:c5c8:1863:df3a:3ff6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bcc1222f-f17c-4f58-a14f-08d834d580d7
x-ms-traffictypediagnostic: SN6PR2101MB0911:
x-microsoft-antispam-prvs: <SN6PR2101MB0911B0E23A6E7F4EF3D51C17C0710@SN6PR2101MB0911.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R7xkHctqGUi7yCXetWjq7WPw87mnQ9oWheTpkS/d5QNuU4KIqaYY5U4OmfeJ/LLOWdN8fXmqVYrCegGX0lThoTWvyFdlwwYYHHIobcQBPykGs8jKd7kluBzyqOvIp5eYBt1UvVQ/vhhpJ6itLkFFf79bXyBrlmznurZnOr6/6awW2PAvkvjBMOMx566/cikOC+bufpQZMwbi1ldTbwkqWgnYU72PhzRKSlGupY2vf/6gZcpaUtiexKwrbGvHJmnO0sBy8EIYANBWAe2TB9w3CUasVALfosNfXsJQqiWBVML8QScH+B5PvmiUrUCKwRLx113N9rX/6WqGs197v2yNHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR2101MB0880.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(71200400001)(54906003)(66556008)(8990500004)(66946007)(478600001)(66476007)(76116006)(10290500003)(110136005)(55016002)(64756008)(66446008)(316002)(9686003)(5660300002)(8936002)(6506007)(8676002)(86362001)(83380400001)(186003)(52536014)(2906002)(7696005)(33656002)(82950400001)(82960400001)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Nyd5/fZsrZcgXa3DgRoH9neZ5U6NZgHY1zCUmZMj6iUd6HdzwWAVhbqLe28lGL5X3GUWCwwtXiHiNYb4G7YQvuaVOJ69tHfWest1UCQrhmREqZmyp2UxwFQYlRyeH11LmXfBRaARnZiSglK68g+vUhzFNRqfQjIT8wu/nMCJT6a1XpMjb9q7z79nWf1gYREB5MwPvcqm27zoXmBZ8V1lqy+aL2u++jDC4KcCSS9cvqfTV8hB9OsQvXffIe3hVgVfX6hJTpwRWjsJD5NEX+McvLfA1PUZhjJyREXZWjDspbPB92/nyiZsKvC4iS+yAv1EatZ6ZrenFTj6oG33afdWaPmba8D0NgMB6KoFjNUlWaVkB8SJ1K0K+v/YeVtp2FvGDqBNtA2pZIRxqwSnC7ndo8iGf9LN9ZL3zsYqG7aYXQ13wtQ+uJVdU38Za1iY8PxrAWc5EWI+sXs5qmwziSdWOBZ95kB4oJpuyIr7IJt6be7tPyn0QUbg3a3C+SNTYAvR2LxWg0rVI3AGnf5VtwVNNeJf3IP3JweAP4zL1aanf/o0b0dMj0nonHYcDa7CdveEDP/lm0SI/kh6hZ2B4YhMfUVqFYiYlm7fuF2uh5bvy59Bg+gedujR9MQjARCrOu3eXfDw6mzuEij42BM0/pR0/pGL0Rc3cl1yMfasbe7YtzZCpzW1Uh7MPRPlirrH+XZN41HGmmdJbyd0IBZK9Awc0Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc1222f-f17c-4f58-a14f-08d834d580d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 22:11:26.6519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9DXCLPMExc5+3oG1IwXWnaVhiu+/LM13eHt3cJ6DonsYA4utJ5XcRrOtKlBuEPpH9EeZJbZyxLgW3PrIdXW2rm1bpTr/CiWaXXhH6iTSwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0911
Received-SPF: pass client-ip=40.107.223.132;
 envelope-from=sunilmut@microsoft.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 18:11:28
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Newer versions of WHPX provide the capability to query the tsc
and apic frequency. Expose these through the vmware cpuid leaf.
This patch doesnt support setting the tsc frequency; that will
come as a separate fix.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 target/i386/whp-dispatch.h |  3 +-
 target/i386/whpx-all.c     | 94 ++++++++++++++++++++++++++++++++++----
 2 files changed, 86 insertions(+), 11 deletions(-)

diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
index e4695c349f..b18aba20ed 100644
--- a/target/i386/whp-dispatch.h
+++ b/target/i386/whp-dispatch.h
@@ -2,10 +2,11 @@
 #define WHP_DISPATCH_H
=20
 #include <windows.h>
-
 #include <WinHvPlatform.h>
 #include <WinHvEmulation.h>
=20
+#define WHV_E_UNKNOWN_CAPABILITY 0x80370300L
+
 #define LIST_WINHVPLATFORM_FUNCTIONS(X) \
   X(HRESULT, WHvGetCapability, (WHV_CAPABILITY_CODE CapabilityCode, VOID* =
CapabilityBuffer, UINT32 CapabilityBufferSizeInBytes, UINT32* WrittenSizeIn=
Bytes)) \
   X(HRESULT, WHvCreatePartition, (WHV_PARTITION_HANDLE* Partition)) \
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index c78baac6df..da4c135925 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -27,6 +27,8 @@
 #include <WinHvPlatform.h>
 #include <WinHvEmulation.h>
=20
+#define HYPERV_APIC_BUS_FREQUENCY      (200000000ULL)
+
 struct whpx_state {
     uint64_t mem_quota;
     WHV_PARTITION_HANDLE partition;
@@ -1061,6 +1063,18 @@ static int whpx_vcpu_run(CPUState *cpu)
             cpu_x86_cpuid(env, cpuid_fn, 0, (UINT32 *)&rax, (UINT32 *)&rbx=
,
                 (UINT32 *)&rcx, (UINT32 *)&rdx);
             switch (cpuid_fn) {
+            case 0x40000000:
+                /* Expose the vmware cpu frequency cpuid leaf */
+                rax =3D 0x40000010;
+                rbx =3D rcx =3D rdx =3D 0;
+                break;
+
+            case 0x40000010:
+                rax =3D env->tsc_khz;
+                rbx =3D env->apic_bus_freq / 1000; /* Hz to KHz */
+                rcx =3D rdx =3D 0;
+                break;
+
             case 0x80000001:
                 /* Remove any support of OSVW */
                 rcx &=3D ~CPUID_EXT3_OSVW;
@@ -1193,6 +1207,10 @@ int whpx_init_vcpu(CPUState *cpu)
     struct whpx_state *whpx =3D &whpx_global;
     struct whpx_vcpu *vcpu;
     Error *local_error =3D NULL;
+    struct CPUX86State *env =3D (CPUArchState *)(cpu->env_ptr);
+    X86CPU *x86_cpu =3D X86_CPU(cpu);
+    UINT64 freq =3D 0;
+    int ret;
=20
     /* Add migration blockers for all unsupported features of the
      * Windows Hypervisor Platform
@@ -1207,7 +1225,8 @@ int whpx_init_vcpu(CPUState *cpu)
             error_report_err(local_error);
             migrate_del_blocker(whpx_migration_blocker);
             error_free(whpx_migration_blocker);
-            return -EINVAL;
+            ret =3D -EINVAL;
+            goto error;
         }
     }
=20
@@ -1215,7 +1234,8 @@ int whpx_init_vcpu(CPUState *cpu)
=20
     if (!vcpu) {
         error_report("WHPX: Failed to allocte VCPU context.");
-        return -ENOMEM;
+        ret =3D -ENOMEM;
+        goto error;
     }
=20
     hr =3D whp_dispatch.WHvEmulatorCreateEmulator(
@@ -1224,8 +1244,8 @@ int whpx_init_vcpu(CPUState *cpu)
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup instruction completion support=
,"
                      " hr=3D%08lx", hr);
-        g_free(vcpu);
-        return -EINVAL;
+        ret =3D -EINVAL;
+        goto error;
     }
=20
     hr =3D whp_dispatch.WHvCreateVirtualProcessor(
@@ -1234,17 +1254,72 @@ int whpx_init_vcpu(CPUState *cpu)
         error_report("WHPX: Failed to create a virtual processor,"
                      " hr=3D%08lx", hr);
         whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
-        g_free(vcpu);
-        return -EINVAL;
+        ret =3D -EINVAL;
+        goto error;
     }
=20
-    vcpu->interruptable =3D true;
+    /*
+     * vcpu's TSC frequency is either specified by user, or use the value
+     * provided by Hyper-V if the former is not present. In the latter cas=
e, we
+     * query it from Hyper-V and record in env->tsc_khz, so that vcpu's TS=
C
+     * frequency can be migrated later via this field.
+     */
+    if (!env->tsc_khz) {
+        hr =3D whp_dispatch.WHvGetCapability(
+            WHvCapabilityCodeProcessorClockFrequency, &freq, sizeof(freq),
+                NULL);
+        if (hr !=3D WHV_E_UNKNOWN_CAPABILITY) {
+            if (FAILED(hr)) {
+                printf("WHPX: Failed to query tsc frequency, hr=3D0x%08lx\=
n", hr);
+            } else {
+                env->tsc_khz =3D freq / 1000; /* Hz to KHz */
+            }
+        }
+    }
=20
+    env->apic_bus_freq =3D HYPERV_APIC_BUS_FREQUENCY;
+    hr =3D whp_dispatch.WHvGetCapability(
+        WHvCapabilityCodeInterruptClockFrequency, &freq, sizeof(freq), NUL=
L);
+    if (hr !=3D WHV_E_UNKNOWN_CAPABILITY) {
+        if (FAILED(hr)) {
+            printf("WHPX: Failed to query apic bus frequency hr=3D0x%08lx\=
n", hr);
+        } else {
+            env->apic_bus_freq =3D freq;
+        }
+    }
+
+    /*
+     * If the vmware cpuid frequency leaf option is set, and we have a val=
id
+     * tsc value, trap the corresponding cpuid's.
+     */
+    if (x86_cpu->vmware_cpuid_freq && env->tsc_khz) {
+        UINT32 cpuidExitList[] =3D {1, 0x80000001, 0x40000000, 0x40000010}=
;
+
+        hr =3D whp_dispatch.WHvSetPartitionProperty(
+                whpx->partition,
+                WHvPartitionPropertyCodeCpuidExitList,
+                cpuidExitList,
+                RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
+
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to set partition CpuidExitList hr=
=3D%08lx",
+                        hr);
+            ret =3D -EINVAL;
+            goto error;
+        }
+    }
+
+    vcpu->interruptable =3D true;
     cpu->vcpu_dirty =3D true;
     cpu->hax_vcpu =3D (struct hax_vcpu_state *)vcpu;
     qemu_add_vm_change_state_handler(whpx_cpu_update_state, cpu->env_ptr);
=20
     return 0;
+
+error:
+    g_free(vcpu);
+
+    return ret;
 }
=20
 int whpx_vcpu_exec(CPUState *cpu)
@@ -1493,6 +1568,7 @@ static int whpx_accel_init(MachineState *ms)
     WHV_CAPABILITY whpx_cap;
     UINT32 whpx_cap_size;
     WHV_PARTITION_PROPERTY prop;
+    UINT32 cpuidExitList[] =3D {1, 0x80000001};
=20
     whpx =3D &whpx_global;
=20
@@ -1551,7 +1627,6 @@ static int whpx_accel_init(MachineState *ms)
         goto error;
     }
=20
-    UINT32 cpuidExitList[] =3D {1, 0x80000001};
     hr =3D whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
         WHvPartitionPropertyCodeCpuidExitList,
@@ -1579,14 +1654,13 @@ static int whpx_accel_init(MachineState *ms)
     printf("Windows Hypervisor Platform accelerator is operational\n");
     return 0;
=20
-  error:
+error:
=20
     if (NULL !=3D whpx->partition) {
         whp_dispatch.WHvDeletePartition(whpx->partition);
         whpx->partition =3D NULL;
     }
=20
-
     return ret;
 }
=20
--=20
2.25.1


