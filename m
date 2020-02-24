Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBC2C38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 19:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8985E20836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 19:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H472yfx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8985E20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6JOz-00030c-PD
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 14:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1j6JOI-0002aZ-Ba
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1j6JOG-00033c-Ft
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:27:41 -0500
Received: from mail-bn8nam12on2123.outbound.protection.outlook.com
 ([40.107.237.123]:2529 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1j6JOG-00031D-2D
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:27:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z11pMtWFI9XPxDiynjdQ91y2d3ZOFgmCCKvYZrbkN3OcmDFA6hlEJ5nh6XLhGgeXfztr8wDlWQUWx1AkVSTqrAo+lyrJsj5NxOxRvnRYy2N7HQPTPI0a/X4vF13EuddS3UtzQJAnhEZwuBhDekxRsbiUx1iBz0UJ9k6/01rQO8yZyV0hMXPSPqyUAUgAvRF4tAJ4Zzr8rDPhfeJtK0LP7jXphqNLd17HkdAyoS/uvWjpsGC7D5srqJ0uQw8agzGBFddr6DdYOVCu051JhK9yAeVDg0a/xfXIMCn2SdTYzoPdyX7WuwgLkeGQDjz65UHkMvqY5X9hRWDaz8rnDPRYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3zXzOvJG42hTXPPxbAA40+uGANfr6OcKfdtWRkhDIE=;
 b=nJE9l4FEIhM86gCZ+G18ft4OxZWaQoH9G3oVk8Vn7be+w936ZbZwa2W7DzQBH83cIPzhDT+OnbaJlQH9HlWh/fg7LHopwpHqzsesKXjcjR2hBESOqc/0qC1GWw6bKttQlgGhk3MgKVEj42RQDQ4th/PyybERo+1HlLJdohYToWKVNRt21RtzT7i8nqIVh/V2PrER4utjVMCXFdSWhLp0PZMpgV3+ZcJ/xgfDNCJEqRmIwbNJR0TTrvwwgQ4eB3Bn8uMDC5nbMPDSxYGqXljFnD439f/rUpuq/2Fv/vE7iSdhM+AJAxhgfJILW6yPeTPAw9PCsjD0VYoM+otOhMu5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3zXzOvJG42hTXPPxbAA40+uGANfr6OcKfdtWRkhDIE=;
 b=H472yfx/Za1yTHM+sRXeOa7xyW6lk0t7ZeofELuKS3SA9mq3UW2+ZvwflVl23gy09piAR+d0N8I7O92fJmUifQnp6ffR+uHQ3CboLx4V03qfqj/gz5SK+BKNvEBVTJe1I5wGj4UZBKwsnMywtwR19VnYL41vOPIZmGY+e9WqAHM=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN4PR2101MB0877.namprd21.prod.outlook.com
 (2603:10b6:803:46::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.1; Mon, 24 Feb
 2020 19:27:38 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::15c9:bf73:c204:7cb7]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::15c9:bf73:c204:7cb7%9]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 19:27:38 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Weil
 <sw@weilnetz.de>, "Justin Terry (SF)" <juterry@microsoft.com>
Subject: [PATCH] WHPX: Use proper synchronization primitives while processing
Thread-Topic: [PATCH] WHPX: Use proper synchronization primitives while
 processing
Thread-Index: AdXrRhI7Cc8PiKCvTlmOyf8oQX8z/g==
Date: Mon, 24 Feb 2020 19:27:38 +0000
Message-ID: <SN4PR2101MB0880A1C19D64131DE3D261B5C0EC0@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:9:5493:668f:681d:c7d6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a8231eb2-de00-4ecf-1bd7-08d7b95f9bd0
x-ms-traffictypediagnostic: SN4PR2101MB0877:|SN4PR2101MB0877:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR2101MB0877F2F31929B76C8009A66FC0EC0@SN4PR2101MB0877.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:102;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(76116006)(64756008)(66556008)(10290500003)(55016002)(186003)(54906003)(66446008)(66476007)(66946007)(33656002)(110136005)(478600001)(9686003)(6506007)(5660300002)(4326008)(7696005)(2906002)(86362001)(71200400001)(8936002)(52536014)(316002)(107886003)(8990500004)(8676002)(81166006)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN4PR2101MB0877;
 H:SN4PR2101MB0880.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UtrQzFCA0s+5dTgfo7efA5k5qQwTP7mL/l7YDyzKeSx5slvdROsYgcjnRrf0yq1wqVJzyvB946e1W2om1kDQuNU5JwyxTaAlsYr4JOBpHc39OJlCl0WBLXCso3Qra9UzadJidTg1+c6lJPZwplfAHqWLTRHSs8tQB9TSypkd3MLhZCpgjIIt2+mQJx7qIw7Jw8WI8Re99t9qEKe2YL71nW6nkjK3R+2VZd147EXZ3y93SpbTdptrOJbBfdNS4sAI0vmhiPdagmgN7C9VZn+10Rot6ORz08PNx+aGxeBm+H1xUr8zLTp8FqMunqv0P3oQ6AYgNwihVNavtp/kd/+XHgCHgYH54sJaoABcB7vSINcCTFJAn/jhElj8Bn884rCdGOZEhbTvY+Kb/YJDzCwZqO/SFI7g/iWIjrYXkDuHu140906C4rVNg2XcvA5nyGSo
x-ms-exchange-antispam-messagedata: Gx4HWzypP8K9NU+9GvN5HVbD0EUEfftQ47vT4izMoJziop1cyKfFDK9UIUTkbsehjP/EqLIQBsj9uP6bB79Gx03+VHveojpebZdVITOGrq8xOJfGNhTesZMSEpoF61nL27FozulG+HKPv7CipFtVr06MYVWkz5rsx7w0nBoACHlL7UevdG5aKArmpEhRc/GCDMvcAltjbxIBK5Pv/rUDbw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8231eb2-de00-4ecf-1bd7-08d7b95f9bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 19:27:38.1684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bdug7jmykqzAGD02TuEB6I2Kp/QC1foopfTPiwwQ4rFs1oDcHZ6HToOvrVm7C6Hh6PtKLRfwKW1f0/HmQwyALciLNL6b8Rnz0CoX0FobUA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0877
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.237.123
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

WHPX wasn't using the proper synchronization primitives while
processing async events, which can cause issues with SMP.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 target/i386/whpx-all.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 35601b8176..868ade5fd0 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -841,9 +841,8 @@ static void whpx_vcpu_process_async_events(CPUState *cp=
u)
=20
     if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
         !(env->hflags & HF_SMM_MASK)) {
-
+        whpx_cpu_synchronize_state(cpu);
         do_cpu_init(x86_cpu);
-        cpu->vcpu_dirty =3D true;
         vcpu->interruptable =3D true;
     }
=20
@@ -859,17 +858,13 @@ static void whpx_vcpu_process_async_events(CPUState *=
cpu)
     }
=20
     if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
-        if (!cpu->vcpu_dirty) {
-            whpx_get_registers(cpu);
-        }
+        whpx_cpu_synchronize_state(cpu);
         do_cpu_sipi(x86_cpu);
     }
=20
     if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
         cpu->interrupt_request &=3D ~CPU_INTERRUPT_TPR;
-        if (!cpu->vcpu_dirty) {
-            whpx_get_registers(cpu);
-        }
+        whpx_cpu_synchronize_state(cpu);
         apic_handle_tpr_access_report(x86_cpu->apic_state, env->eip,
                                       env->tpr_access_type);
     }
@@ -1067,8 +1062,10 @@ static int whpx_vcpu_run(CPUState *cpu)
=20
 static void do_whpx_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data a=
rg)
 {
-    whpx_get_registers(cpu);
-    cpu->vcpu_dirty =3D true;
+    if (!cpu->vcpu_dirty) {
+        whpx_get_registers(cpu);
+        cpu->vcpu_dirty =3D true;
+    }
 }
=20
 static void do_whpx_cpu_synchronize_post_reset(CPUState *cpu,
--=20
2.17.1

