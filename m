Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C53EC4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 23:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C8923A63
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 23:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Bwo5wByu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C8923A63
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKUq5-0001B0-Hm
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 19:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kKUpT-0000m0-1e
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 19:02:39 -0400
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com
 ([40.107.237.85]:34304 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kKUpQ-0007lf-3J
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 19:02:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6yu7gyg7rI+i28/lF85q617IL2ODlN4dafb3qbGUol19J5UyZGPxbei28jWNO+jACLFFMicaIvpQEzUXugv0yG+XhkLYn1TpwLz2MAJ9IrKZbt+vsnkz+UiPe8RWEydtpKTZEqV1kqSCvKkVHn7yT7OQR5pQsQ/Cnhto7QY/Lad6GigvyF/5NxaursrnrlHsDexVLYl6Dq3wU9QrqdSr9rbcZLpXNM2VkWkqzM4meQVNwQPDy0TgEOEH2Gl8HwOhSPfQkuXIvEory8eTiRq2vYstljzgEQizZgEh5ukjpPwA3aSraBUwhuXHEi7YMpL1pdDhg3Y3/nXT3Y9YDOdag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzdLYdHhza8fg86VL2UybKQTU7+RCr9gqDb0VN7Tgsc=;
 b=B9vtyL4vWCSneJ30bRaiVJ2xlg/ZwXLeQkaVmVOrAXPbRuvnIOZu2EGUMhizn4L5Y7BgjWK36yk1u4miXP5T4w6gGAsb0iHYgo1sMtECV8Uo1tooyHUnjFm5LxHTGJsSsvFTdDUZN5kcT0qlM+HdKPgF7JXk8EUhl7uj5jjZUgfsHvbtPFegU6dcZu5cG3EUrtGVtMafQd3gtl06NyKfb30TAfn1UH4SimovHFkB/0ZM7k40a3F7fikRezjajooYTlQ7BueYiK6T/vh+SFBV4LFJpBsXIO8uZZ5B8PogDY28wErRcbU/cU5mHmGfKg4Cqy191uQjr6HIFjawILhweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzdLYdHhza8fg86VL2UybKQTU7+RCr9gqDb0VN7Tgsc=;
 b=Bwo5wByusCZaoANBwUItKGXN+RGG0O6abEpb5enSVr1tZ7xJffg7TfExfMKNu3wODjgVwUxfw81Lsd94G6VzbyEtZPKEBcz/Kqol71uX2puQSqvzyOEDiBNvJYtwEENaTthwK+Z+2a/7ksyvWs7awioS+8IneqN4LnJdiZ1xym0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB2621.namprd12.prod.outlook.com (2603:10b6:805:73::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.17; Mon, 21 Sep
 2020 22:47:30 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3391.026; Mon, 21 Sep 2020
 22:47:30 +0000
Subject: [PATCH v2] target/i386: Remove core_id assert check in CPUID
 0x8000001E
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Date: Mon, 21 Sep 2020 17:47:28 -0500
Message-ID: <160072824160.9666.8890355282135970684.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR19CA0052.namprd19.prod.outlook.com
 (2603:10b6:3:116::14) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM5PR19CA0052.namprd19.prod.outlook.com (2603:10b6:3:116::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Mon, 21 Sep 2020 22:47:29 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10ddd47c-c12f-4fdc-bbbe-08d85e805228
X-MS-TrafficTypeDiagnostic: SN6PR12MB2621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB262139239E28321A9EE7D10B953A0@SN6PR12MB2621.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vC6QLY8y1AZZvb74VtpTSpAbkkOQ49C9o3YvZv19H4guNc3d5aKqpJL/ty6OTJfrZtRcKLs9AnUcfl2QM1vRgN3oQKi8/t3DxhgxMgCnGKlUbKdI2ibQqH3lIQVEE4XfzNu4REcx6pRTWHIO+tpwGuJpw8/z6tK4XVtkroehjrduB59bC4t0AM0sLo0V0P+dV2dFTxI2GiBmTK7byD7eEPFSlXNPfu180b7pyZWI2zzThR1AodkGoiERzdSJcuavRSNZzoGC+iUhrjESqOKsemqWIyE59hLcSAdhCYakcnf2V6fy65/oe6A7+YfAZgfVDhJTHgZ8EeXJp7zb4AV2jaOqTq7sfN0Gj4q08wIh+4mZSw7yoI2i/hXNVrw80nx/KOXIVaphILdtp8W2Er3pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(478600001)(103116003)(86362001)(4326008)(966005)(956004)(2906002)(83380400001)(8936002)(8676002)(66476007)(66556008)(44832011)(5660300002)(66946007)(26005)(16526019)(186003)(55016002)(7696005)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cMS46IIvRUR2DTuEELlXwWNsKIFWiP/D8vhQ0QJuSYZxQMGI/vV8zmr3Q53hUAb+T3AGzOp8xIQQj1vcXEB7vUvdWhV4BdtKv3E6290GEW7giwh54Fm5NRYsUwRY1UWOdHEmhALrpH7pJr17Eh2PNSxQLWIBEeu/RRwN3hKcbapZWl1sB3vFsrS+5OK5VNZp8/DddLNf8inD1JtljC3O0qZRIgFQeXej0fa7b3lTylv0ISktivKG8MhJ4i1YL7QEtdLYT3XzkmYpqEKUuk+t1sx9Gr8zbUY8fQcC3Flb6HYNTMvaxxy6zof0s2uv/OtWypSEu/vyHfPSpofyO9oM+pcKHycb7DwaQVZ8xqx8XVko9kBOOaAOlWrCMHl1jy28IRefmtndwrf7iqMI3LUtzF7Yenu3pOEs2nQbSsEYSACf6VtCrOMThjg6dlotstrDEBRBv6M3AcAYoppwBelELJ3ixQvK5K04Fnwrw7ILPfmCfBj17jGC4A7mUiXEMyGvs8RmXehkqI/3IyJGzbzPpbZhRULDSvIK0ig664kR9t4YQCoTD8xg72UhO4EQDo3L4snakPvuGBWNOY0w9pfS8hzp7HNhL4rwqBBFsVtEauU9Tf3t6sK/171IoaqvdsAxX+egExxSk4Nj4KmlHho3TA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ddd47c-c12f-4fdc-bbbe-08d85e805228
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 22:47:30.2709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qInnrKBUQ6fR4cw4qT3gXYGxJ50Lt3FUcU4SGYbdpbN+Vd2q6JbABAL9eH/xq0U9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2621
Received-SPF: none client-ip=40.107.237.85; envelope-from=Babu.Moger@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 19:02:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With x2apic enabled, configurations can have more that 255 cores.
Noticed the device add test is hitting an assert when during cpu
hotplug with core_id > 255. This is due to assert check in the
CPUID 0x8000001E.

Remove the assert check and fix the problem.

Fixes the bug:
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1834200

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2:
  Resubmitting an old patch which was lost in the mix.
  Just rebased on the latest tree.
v1:
  https://lore.kernel.org/qemu-devel/159257395689.52908.4409314503988289481.stgit@naples-babu.amd.com/

 target/i386/cpu.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1c58f764dc..4f1d62c838 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5912,9 +5912,14 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     case 0x8000001E:
-        assert(cpu->core_id <= 255);
-        encode_topo_cpuid8000001e(cpu, &topo_info,
-                                  eax, ebx, ecx, edx);
+        if (cpu->core_id <= 255) {
+            encode_topo_cpuid8000001e(cpu, &topo_info, eax, ebx, ecx, edx);
+        } else {
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
+        }
         break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;


