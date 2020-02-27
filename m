Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866F5C3F2C0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB1224690
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="i0uROLNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB1224690
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7QI8-0002Ob-IF
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 16:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1j7QHN-0001aK-GU
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1j7QHL-0001Vd-H0
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:01:08 -0500
Received: from mail-bn8nam12on2094.outbound.protection.outlook.com
 ([40.107.237.94]:58401 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1j7QHK-0001UW-OY
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:01:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1K0NMkBBocpoLrnkAPjbPFm5W+8/jKT9Jv2nO5noNk3tpixCEDaMzmcKRwMYqGXNV8PTz8wNTPtybi7Jew2p3cD6w6bDfVOxosF+2qi3fekjXoMvUziOGYDubsXB8tpZTUIWHcw5q0tlJFj5Dl+56iU+Uvs7SHa8fCQ65xZCDZF6pMbv98wox62ggcgaihUtcVa7WqqSQUlzCXBh0uFfP5CjeivjK8As5QJ/VoG+PzmTePMtCM/zaKNEnun0mRUx4pfDVAR1yo0C8JNGZj3P97gugjP2DwmGCfnpERzBHV3z3kNfLX4I3EDK1fV4mRUChpYrqlq/lQb9PYkFxz5tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGws20AA9lLEqq+TTNOOXN+NA2P+8RJfjL6irS+DDeY=;
 b=L6uA91A5eOhbafG3WuuY0qjdWsy7km4RofzvWSIL5gm8786BC8HO4SHXUjzEpr1f3mNb4NR3gCrhjpUVPQUHpn4NDsRQqtKEELdIuoQSEACd08/5Rmz95WRC6DYFHuJh8CFTyoDL8vN+8utMVrZbPG7WSwkj5du03uB7qg7Kswiv68foFzA9QLW3iZBvPNdmTKZHFy28EkjQcbqgCAXihdsN2SAu7zDyJITA0EVQXCQkU86qHd2dyhDpPpH8KzK+NBVSjhm4E/cR7dGocmOY69/qQ0RjFw3tQCbdM/IFgNHYsOtAdR7gLTHRZyMI19s2X45ca/LcvTJEYt/eUNUCwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGws20AA9lLEqq+TTNOOXN+NA2P+8RJfjL6irS+DDeY=;
 b=i0uROLNULqWNuG2OrRTp4NXCfcHtxby2UUpAp+vQ9RPfowpiXStp6Gwp3zaKgzrpKyudlVnnoxXz9faVB4cYRxnGlko4PHJO0x6TT+wGjy1O7f9Xq94ZgFsEu+IUx8VQnQVbeVqcWXHAT+0P9i1FGxUVTQc/ApfMifyby4PtPc0=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN4PR2101MB0878.namprd21.prod.outlook.com
 (2603:10b6:803:51::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.9; Thu, 27 Feb
 2020 21:01:05 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::15c9:bf73:c204:7cb7]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::15c9:bf73:c204:7cb7%8]) with mapi id 15.20.2793.003; Thu, 27 Feb 2020
 21:01:05 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Weil
 <sw@weilnetz.de>
Subject: [PATCH] WHPX: Use QEMU values for trapped CPUID
Thread-Topic: [PATCH] WHPX: Use QEMU values for trapped CPUID
Thread-Index: AdXtsNoeJNEkd+WMTCOFtkYfkkG5Gw==
Date: Thu, 27 Feb 2020 21:01:04 +0000
Message-ID: <SN4PR2101MB0880A8323EAD0CD0E8E2F423C0EB0@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:b:3028:825f:ab03:1fb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: abce80f5-f9e4-4fcb-5337-08d7bbc828f1
x-ms-traffictypediagnostic: SN4PR2101MB0878:
x-microsoft-antispam-prvs: <SN4PR2101MB08783B4E88D4CA7924A9034FC0EB0@SN4PR2101MB0878.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(189003)(199004)(316002)(110136005)(86362001)(186003)(71200400001)(64756008)(66556008)(66946007)(66446008)(66476007)(52536014)(7696005)(33656002)(5660300002)(6506007)(76116006)(8990500004)(81156014)(8676002)(54906003)(8936002)(81166006)(478600001)(2906002)(55016002)(10290500003)(4326008)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN4PR2101MB0878;
 H:SN4PR2101MB0880.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u3LU/ajq8w4oYVZXQMYZjWQl9lGUy1fcIMhoMSko7OIbWzkBOjINcSf/WIazQYrkYiVtCTBhaLgZi6Zd9OCaK/Ixji4iIWip8uW5WDjMGqP0qKgfSy+pxWnk+o1NK+wavlBvpMYNEvlcxsFNgYiAaau7u71/dwT3a1Ky+GXxzoGmbGWzI0rvAU6fjSpRTIhyxroUlXzXsixEB8zAasYKaM+F/EB6qxI0uGDUWp0iQrldJD0HA+HzbnNDc1oLX3JNrNZpOMRPJYf5ve8Vk+/6kqPlY2B/w5HgPn63Nsq0+/Wjg6hsrVlojGb2/L4zFIFTm4hhOIpdpz3HRuYiGqp1sShaW6DKOH+2LqMh6xA+3kxByBKG5+Eeb01UrhJksYLxgKl+cZ5uCTbHGuFCRWG27AhMwJztm2Zv73bcgbrr6GjLuF5ZaekQu5gmufZzCQu/
x-ms-exchange-antispam-messagedata: GDVu587bScc9s/Y8jG/qLzJALj7cnm4PmTiXuOM8/RyFAM5v50v8V20Ap8ZscmdqVjLY3Dz57kWR+z38GGoE1kHn4Dymo94PtjRdu6LJTAc7oDGyBktQ/+qyYgJVD1aEFTmxN7b6ANpmZBtS1Vm+0CTetkUYYvFmXNVl890bpVl1JDr5Y16pIMiuIATYH4PLnrRKWdgNG+0A6e7kv/2fbg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abce80f5-f9e4-4fcb-5337-08d7bbc828f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 21:01:04.9422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5jVYQLnvP4rZVQNmyyvLTNzuEOSVS39FGDJQB6juFTzit58toU0DxxPDdz7Ys5dUZYj5YUylvOMTEkeHTo7PVENoUAf/sHEdGUGOFHzn8tE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0878
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.237.94
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

Currently, WHPX is using some default values for the trapped CPUID
functions. These were not in sync with the QEMU values because the
CPUID values were never set with WHPX during VCPU initialization.
Additionally, at the moment, WHPX doesn't support setting CPUID
values in the hypervisor at runtime (i.e. after the partition has
been setup). That is needed to be able to set the CPUID values in
the hypervisor during VCPU init.
Until that support comes, use the QEMU values for the trapped CPUIDs.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 target/i386/whpx-all.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 35601b8176..4fe5a78b29 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -980,38 +980,32 @@ static int whpx_vcpu_run(CPUState *cpu)
             WHV_REGISTER_VALUE reg_values[5];
             WHV_REGISTER_NAME reg_names[5];
             UINT32 reg_count =3D 5;
-            UINT64 rip, rax, rcx, rdx, rbx;
+            UINT64 cpuid_fn, rip =3D 0, rax =3D 0, rcx =3D 0, rdx =3D 0, r=
bx =3D 0;
+            X86CPU *x86_cpu =3D X86_CPU(cpu);
+            CPUX86State *env =3D &x86_cpu->env;
=20
             memset(reg_values, 0, sizeof(reg_values));
=20
             rip =3D vcpu->exit_ctx.VpContext.Rip +
                   vcpu->exit_ctx.VpContext.InstructionLength;
-            switch (vcpu->exit_ctx.CpuidAccess.Rax) {
-            case 1:
-                rax =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
-                /* Advertise that we are running on a hypervisor */
-                rcx =3D
-                    vcpu->exit_ctx.CpuidAccess.DefaultResultRcx |
-                    CPUID_EXT_HYPERVISOR;
-
-                rdx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
-                rbx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
-                break;
+            cpuid_fn =3D vcpu->exit_ctx.CpuidAccess.Rax;
+
+            /*
+             * Ideally, these should be supplied to the hypervisor during =
VCPU
+             * initialization and it should be able to satisfy this reques=
t.
+             * But, currently, WHPX doesn't support setting CPUID values i=
n the
+             * hypervisor once the partition has been setup, which is too =
late
+             * since VCPUs are realized later. For now, use the values fro=
m
+             * QEMU to satisfy these requests, until WHPX adds support for
+             * being able to set these values in the hypervisor at runtime=
.
+             */
+            cpu_x86_cpuid(env, cpuid_fn, 0, (UINT32 *)&rax, (UINT32 *)&rbx=
,
+                (UINT32 *)&rcx, (UINT32 *)&rdx);
+            switch (cpuid_fn) {
             case 0x80000001:
-                rax =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
                 /* Remove any support of OSVW */
-                rcx =3D
-                    vcpu->exit_ctx.CpuidAccess.DefaultResultRcx &
-                    ~CPUID_EXT3_OSVW;
-
-                rdx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
-                rbx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+                rcx &=3D ~CPUID_EXT3_OSVW;
                 break;
-            default:
-                rax =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
-                rcx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
-                rdx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
-                rbx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
             }
=20
             reg_names[0] =3D WHvX64RegisterRip;
--=20
2.17.1

