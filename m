Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D70C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0112073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ImSiVmoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0112073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9DmT-0003x0-Eo
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 15:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9DgN-0002Dq-Nm
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9DgM-0003Nc-C9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:23 -0500
Received: from mail-eopbgr680080.outbound.protection.outlook.com
 ([40.107.68.80]:27877 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9DgM-0003NP-6f
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nrx52wsnwG+i3VapGKFuD7ERY+aibzdPn6tHdj9ePYpLawZaTvYtaNSXV5jk75meZssTaEF7XeCe9ak8oEr1xPoSEz3iwXPyQ2YkOFxFK4Pz6n9F6DpWrP+mI7y9+PD1v6dbZArwmdgRwjE5GMV4G4unR1SPHSSsE0SFk6dXisC4JnmADW9JXaxX4iK2dFtvqWvy0Onm+LUjqUtm22J6Nhat07340KfCvlGaArT4MWEhMfASAd2IcqFUGZk18Uk4sdc8nPUGeC1M6dwFyrm/MTv4c9OVZuUnuUXlUIqGKCsVFOrxS83qg7BQtCRWVeQrvNV/MZvgmfnqdB9OjXqUcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oRuo/lh28/2XJWy4dP6mZpTXzVZAlN3SENyqm0S/p8=;
 b=MXijhLxL9BZiWZE5oeU/YpwBvl1g6G9UO+ObkYPYInJM115sIxxYFRjkO0dLyhYPfWRUgQs6ynYV06Dm+8MsHa/EiIvUdZ2lN/CWuCOtg1R1vnuEz4ese0JrnDXcF7Mxp+x0IFBb3XCAzhDME7MP4TtKB0px/2sP9YAsFVgMkoGKOgvUhCROztM5zNNhtHIanYV1RzM04xs4+Xd4c6rUD3KJoj94n4XAWhQIUqhFiew4WQbXPBlVv6AJ0+nnBZiTxlCYah2tJGyzOgv4HBepLsVLbq7asNZAuAZ40AiWXpB4MDYY/snzim2WbSzowQdDHbCDxGBmM711DynDqzJf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oRuo/lh28/2XJWy4dP6mZpTXzVZAlN3SENyqm0S/p8=;
 b=ImSiVmohE+iaTTYNbdQuZOFY91XH4jdNAYriXSPygiqDJNWrbLgP0HT0eVVdHS3tme5dKSzKweuwJxleDfUL22+KF4ot/SHDqdCUqhnfm2JTlf6YSZgsNMUXKz57OsVasO4akUOa+njcxbx8CTCD4kT6rL0wHNb7CPTNGAOi47Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:58:18 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:58:18 +0000
Subject: [PATCH v5 13/16] target/i386: Add EPYC model specific handlers
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:58:16 -0600
Message-ID: <158326549681.40452.14219781294371149597.stgit@naples-babu.amd.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM6PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:5:80::20) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR08CA0007.namprd08.prod.outlook.com (2603:10b6:5:80::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 19:58:17 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13e008c4-1ec6-4ef2-3d19-08d7bfad37f9
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:|SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB257354FB9C168A144D68889E95E40@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(2906002)(316002)(81166006)(8676002)(81156014)(8936002)(103116003)(52116002)(5660300002)(55016002)(7696005)(66556008)(66946007)(44832011)(16526019)(186003)(86362001)(956004)(26005)(4326008)(66476007)(478600001)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2573;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNkGIYX7+giDPNiCs5a/Vptw9LrFz610efNrHXwVZtsIAKALIRG+xoqqYRTc9xxXgHu8X75mdE1rlRx5i5JkFtDhB0X1AegluolDykn/sVrthR3AFV76uTN3G2YXZOBOhO3fVSiD0Yaqh9dZizF5OqNSYwSiIB+cBES97NqwVQfpofMpKtfXV1YedVY8mwME5QBWOI8lkKDhZTWdLFEUdhTe9TXLJDezBQKQa761Py/wARNr7hJBxS78TUUxYs+cMi/IriOKiWi2Au0dMW/7wAq88I7xmQ236DZwrW/3sJGb4rWJDTLp0m6AtrIDKtGDZINye38VDxM+oeLdD4lvEDWbCf6uNMf6w4IZ2u80a3LeCtsi1wHVSeqx2tB7Qrc9rtd4X6sOSRkZErtrKTiQFam58VKadmAc4prprI6MCQnB9Hz4K67yEpfw0w7WiXY75sWifhXhvprw68cY9kV5qjKjcPnPALVJa9VCewZiqXOlcSq7Cmk6r3fhkJ0jOLijKU99ltKYLRAikc6FDNu0fA==
X-MS-Exchange-AntiSpam-MessageData: j3+S2E/b1thR2q+ZizlINipCZCMbm4R91r+8NF9m9EHotmLRd7r/6xZhxAEXHELdZlcKkxm/YicGaTqTahwUPNOYNm/BhmmvY6uy8Nel2Fr28SwG7RFfwfasNdV2oQtFf+iVI8DDCpsbdL8x1GupVw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e008c4-1ec6-4ef2-3d19-08d7bfad37f9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:58:18.7331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNlR4gByN25vr44F8BYxe5+Kzwn8sDb6cs9zWYFq50+z2j1wWQKTDaQrUF458T8G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.68.80
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
index f33d8b77f5..f870f7c55b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3884,6 +3884,10 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
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


