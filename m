Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5484C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BFF2074D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dljKEq7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BFF2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCAHa-0005kE-O4
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 18:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAEx-0000fM-Rk
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAEv-0006Z9-V2
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:54:15 -0400
Received: from mail-eopbgr750048.outbound.protection.outlook.com
 ([40.107.75.48]:50407 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jCAEu-0006UQ-9i
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:54:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQ2lub62RgeKyRaxG5jNDcfJtW9zbd4KZVlJrwnpaByY0vRqYJ7kQHOxkP04loBz/7cGy2UqlvOVhWLy4LbN65ZvzyJMhV4zsZCNaxVsxuudvavK3NZpA7/MLzMqdEDzkP+PjjkLm4n/4zHXuRksuCsQJ+rM62ODXOAwmjyiBBOpCQ2Ud1giqUskuX4nR5GXxVQxeNxwhLlDPN+2IjB/jqw3DN1vxztBcdUOktjD/XFxaFeD7XFdohKfhgPI4LlCzONZ34cWkWpx6jrTVic1i9/AmUTcRT6+8GRWc6ZD+BqX7g95u4T975bjFQ1HIakVbVq+CzsOdr3OnxQLUiTgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8utAM5Lmyyaq5dc2jSANleQyZJsJgNRe0ihae4QBGM0=;
 b=R69+WDy9+5i9ewVorn/hbUZ9vYqHLtE8XMHftRmOqrw4eFWzlQtpuifvy7032bCBZYNY474Xt+3PvZMRi4H9eSStOzOSUcuomUfjNG/5sg03N2YuIvIJnTatgc227n27sXGXWpWTn1h2lu9ls1SQO7jRty8GSKnWOmzbZFDo5CQDdBSHcMPIIfN6axc9SAm9it1EErXXA12yvbpNx+uwTApml691mfeEHcjASESqe1Jh1t/7Srm2336XERHQWE42ri81S5z5abAKdotLV9txGfBci7PKeYSTzb7lCUUuwAcNmZt/ed1SPD97aXGatShugcCf+3oqC3TQW4zGTvNauQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8utAM5Lmyyaq5dc2jSANleQyZJsJgNRe0ihae4QBGM0=;
 b=dljKEq7vownNURcaGWRk8VNo8j0FSMEekTX9yeHpTKp8QNscwooXuH3B0TTuV8NKtD2Tzd8fqZxIYv8oJMD2htFMOVYYKFSIGgwdBtXjBMcKjkFrVDOPHfwBa4EdvackTxfDwv+UOtgoFAF2fAU1RF6D88rYh2ladHQXRgZwL6Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2349.namprd12.prod.outlook.com (2603:10b6:802:2a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 22:54:10 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 22:54:10 +0000
Subject: [PATCH v7 12/13] target/i386: Enable new apic id encoding for EPYC
 based cpus models
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Wed, 11 Mar 2020 17:54:09 -0500
Message-ID: <158396724913.58170.3539083528095710811.stgit@naples-babu.amd.com>
In-Reply-To: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM6PR14CA0064.namprd14.prod.outlook.com
 (2603:10b6:5:18f::41) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR14CA0064.namprd14.prod.outlook.com (2603:10b6:5:18f::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17 via Frontend Transport; Wed, 11 Mar 2020 22:54:09 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 334a5991-6483-4034-1c32-08d7c60f1cbd
X-MS-TrafficTypeDiagnostic: SN1PR12MB2349:|SN1PR12MB2349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2349FCA2F9DC23C013FE8BD495FC0@SN1PR12MB2349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(44832011)(478600001)(55016002)(5660300002)(956004)(966005)(81166006)(8676002)(7696005)(81156014)(86362001)(103116003)(4326008)(52116002)(16526019)(186003)(66556008)(66946007)(316002)(8936002)(2906002)(66476007)(26005)(170073001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2349;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3M+kyxomXhQPnqWG+1JDWFFZip5SqQ0wTFX9yeZ5ST9V77apdsxsTv/DG5/xZG/D1aqPoCrDmzYpUIsppyGiKbv+mJtayKHklX8tmEOQmiW/26DTdL593sFq9jooYETA10NoOiae+VtWcMAkETF+oVdFnrzNWBJ12g+vCXdmFIANU5yaDIR/hwJZL2xb31wVICpUDFuI7iz1DEJmkSLxbQQE2EoHnR6LOSaStbo9BHiER3jCKf5PdNHfcM3sGcYwvKRhhW0LkjvJZKVk5G7qEbOtaXoqbEGcnGwm0A+QBL3IPJGGalBZfNpoOb4i/Vj7sMQu7SIgz5eZgMpkZFlRG6i3s4/bPH4w1o58WHgsRXLOguRSLKuVJfZo9OYqAeHOadIJRYAcWFBRv+Ysose9s6FNuzoNCdQ0Xl22uK+Rizz+jAWC7LZGAV7dDI1Hjh7MQ0FzWD7A2Jc+McnuFffF3GwClq/6oo25En8/lrJICggIYQre3d+m5tLPphA0tnjhT577oA7G37ZZiqG9dy4Cl62fKXGl+ZlKzI4/HdcojKbRZ9A+LyGuNvVKjX9JoE3
X-MS-Exchange-AntiSpam-MessageData: QhC8utAL1PWLH2CTOYfVzIHTeaGn9lzMXYImqJt/J/YUp5NYEcY+BLz51h4OfGTooH5pKb42Kc5dZReLhorEtLZyq+Ou+SacQxZ5XtRHNK66psbAxJzXjUUz8onVv5g0BT/SryH5YBGPO28UbIuaJg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334a5991-6483-4034-1c32-08d7c60f1cbd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 22:54:10.6628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEF/ZugntUa6N4k0ZLfpnvryuWdeSYvFbdfT/KUl8wHD3oqwvTBdDfF1QXtHzLC2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2349
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.48
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

The APIC ID is decoded based on the sequence sockets->dies->cores->threads.
This works fine for most standard AMD and other vendors' configurations,
but this decoding sequence does not follow that of AMD's APIC ID enumeratio=
n
strictly. In some cases this can cause CPU topology inconsistency.

When booting a guest VM, the kernel tries to validate the topology, and fin=
ds
it inconsistent with the enumeration of EPYC cpu models. The more details a=
re
in the bug https://bugzilla.redhat.com/show_bug.cgi?id=3D1728166.

To fix the problem we need to build the topology as per the Processor
Programming Reference (PPR) for AMD Family 17h Model 01h, Revision B1
Processors. The documentation is available from the bugzilla Link below.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
It is also available at
https://www.amd.com/system/files/TechDocs/55570-B1_PUB.zip

Here is the text from the PPR.
Operating systems are expected to use Core::X86::Cpuid::SizeId[ApicIdSize],=
 the
number of least significant bits in the Initial APIC ID that indicate core =
ID
within a processor, in constructing per-core CPUID masks.
Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum number of cores
(MNC) that the processor could theoretically support, not the actual number=
 of
cores that are actually implemented or enabled on the processor, as indicat=
ed
by Core::X86::Cpuid::SizeId[NC].
Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
=E2=80=A2 ApicId[6] =3D Socket ID.
=E2=80=A2 ApicId[5:4] =3D Node ID.
=E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
=E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'b0,Logi=
calCoreID[1:0]}

The new apic id encoding is enabled for EPYC and EPYC-Rome models.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 target/i386/cpu.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1e4400df7a..9ffaf5e2a0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3925,6 +3925,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
         .xlevel =3D 0x8000001E,
         .model_id =3D "AMD EPYC Processor",
         .cache_info =3D &epyc_cache_info,
+        .use_epyc_apic_id_encoding =3D 1,
         .versions =3D (X86CPUVersionDefinition[]) {
             { .version =3D 1 },
             {
@@ -4052,6 +4053,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
         .xlevel =3D 0x8000001E,
         .model_id =3D "AMD EPYC-Rome Processor",
         .cache_info =3D &epyc_rome_cache_info,
+        .use_epyc_apic_id_encoding =3D 1,
     },
 };
=20


