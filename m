Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BC7C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E0C21734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gRocEXli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E0C21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2JFD-00024L-0T
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J3l-0003RB-K2
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J3k-0000uJ-DE
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:57 -0500
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com
 ([40.107.223.70]:35872 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J3k-0000sv-6E
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ez8EdLCX53VGF/f0urRp/3LfTx8Xd8LfA0opCLGk5EqeHHqbid2pSAUu4GEuknvl5kCv4Qnpa75ySouJejl7DsfGH8oH4wm6gZAorCc0RFNFuYbmdsuyn76IQ01qmX+oiOWMiovOFkZfdy0IVE+N1+ICROjdDDgXHFd8OG5AYp1sdZM+zWOmreWF4XVSxj4acW1aN4KKy5I01NzGY/wELuNxQwXAj4DPvV8M40LmcUr2X0ImDPDdCnkGlJClN5pGv8v9Yb1ILlhO2PU1qiNT7/tygqjgmqoAyC+juml7EvmSE1HMGPFRarz/ou1Vy2cPQQO3hUSSgYXdWL4f/MoCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx3jWkvuTGXZFRu5dVlng5kpV99py/1BnDEzQyaPZGY=;
 b=m9luCGqVgO5pVxGmkuBkpH/CByR4NQD7ugOve5VgwPF5AojX3HbnAC43b3v/bQH7aERkaHRkw+wAX5rNyu+HFQpc0Gnszt7mOzb08bZIZRh/ul2fFYMFkAxZb7eNScRXt9e40fXrhIUh1GPT1CPnYZ2Cyx1MzE/51+FQOIymPpugABvG3jQcJP4z9y1prDBepiL5udG/DXhzNkgUj5TNB5ig/Potz5cUTsSkE+nvwlk7Nx2jgmHd3dMzvGumJXpQseKearc9iv7XGp+a3/9BAUnQYARIPisvASfogwNQIsqqjGaYsaQ0h1wKsPEHPWx8SMoAA49utUbbnGPAwOSwEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx3jWkvuTGXZFRu5dVlng5kpV99py/1BnDEzQyaPZGY=;
 b=gRocEXliPKSSMle1KJR59sLQU5U1m9D49Nz8f/o7VOMBGgT+UV+cgumwmyqwpVpBWQo6wZq9AHvtLh++8GRrB98ySz085ILqQeK2ayAWts2GjAPIIYqWqqaAogccUP/siQyaP1lnRstlxPEijTJ1+qmHAhoQkfz31MMbOO6oRkA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1222.namprd12.prod.outlook.com (10.168.166.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Thu, 13 Feb 2020 18:17:54 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:17:54 +0000
Subject: [PATCH v4 13/16] target/i386: Add EPYC model specific handlers
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:17:53 -0600
Message-ID: <158161787313.48948.4764091270796216726.stgit@naples-babu.amd.com>
In-Reply-To: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM6PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::16) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR17CA0003.namprd17.prod.outlook.com (2603:10b6:5:1b3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Thu, 13 Feb 2020 18:17:53 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d032832e-a91f-47dd-8b1f-08d7b0b10b70
X-MS-TrafficTypeDiagnostic: CY4PR12MB1222:|CY4PR12MB1222:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1222B1A5F80499AE4A05C204951A0@CY4PR12MB1222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(52116002)(66946007)(66556008)(66476007)(7696005)(26005)(5660300002)(103116003)(956004)(55016002)(4326008)(86362001)(2906002)(44832011)(186003)(16526019)(478600001)(316002)(81156014)(81166006)(966005)(8936002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1222;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nAaiWZu3+yY4n4HLrHI13OqQq0MOr+oSB/MNINHe+pVnpTNZTpQ55VNw3ztcm4L/hRRvyP7MFdakxY2sUfnkIt3M6ryTbjyfkmcsy1UU3EVxjLHLohiBEBolC8xP8Z3Ry+iN+Pp8aE0zgCnE/CNPXV327yy+9Xn1xL1sOjiC6YpKmzsdiGztAOEWjpElE+3sFBCL8NLS3TpkGXmS9O0eqrt4aHGZzc0foNJ8ve7NuvIY6ioum+mZaKiyh2ZlCxHip57CjezhCV88fElC/vtmSZTSXszspTs3N9JE2EZ5KdSqewZGpcs+pa/Sia9igxmwpbjeoUOWtHAGtJ7uQH//N3fT98rdsHLWNkA5XSt4quEkoWiX02Falwr3m2gtZl+3baqRkMK2Q0imSgtWJpklEYd/KN1dCLW2LhhxH7woFqc/e4C2IU8+TGmAmTkLU9cYDwNyftRTiKq+QSUqK2Nyzdng0zTHDxBHCudqhRkFCWMDFI8RjfiYWoohirsH+f7Lua1tJ8DrATcZ5tDWFoPI/g==
X-MS-Exchange-AntiSpam-MessageData: rcJf30jdMgy1Z2JIm+YxUbwomu1Bxknty1+EUp2vIIQSAp2n/yMOKAgrnayDHOprwCXg9vZpdXNG0s6B69ecetOL2iZ+5bpl/Q5OEpl8fGQQvmBMwYg4zE0fabmSL+xMrq3OJyLdyJyK8zloUxmduQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d032832e-a91f-47dd-8b1f-08d7b0b10b70
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:17:54.5928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BN7TGUCiwfxFzB6MpA4+WTmsAIGN15AnYV8FfdUfccUrlvUDk51QmoziKvgURsrH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1222
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.223.70
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

Add the new EPYC model specific handlers to fix the apicid decoding.

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
Processors.
It is available at https://www.amd.com/system/files/TechDocs/55570-B1_PUB.z=
ip

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

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 389b68d765..082865d72b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3835,6 +3835,10 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
         .xlevel =3D 0x8000001E,
         .model_id =3D "AMD EPYC Processor",
         .cache_info =3D &epyc_cache_info,
+        .apicid_from_cpu_idx =3D x86_apicid_from_cpu_idx_epyc,
+        .topo_ids_from_apicid =3D x86_topo_ids_from_apicid_epyc,
+        .apicid_from_topo_ids =3D x86_apicid_from_topo_ids_epyc,
+        .apicid_pkg_offset =3D apicid_pkg_offset_epyc,
         .versions =3D (X86CPUVersionDefinition[]) {
             { .version =3D 1 },
             {


