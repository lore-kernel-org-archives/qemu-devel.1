Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69DDC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B3D20637
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IlzGXVsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B3D20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBrGq-0000y0-OJ
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 22:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrCm-0000kz-1Z
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrCf-0008JU-8p
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:43 -0400
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com
 ([40.107.223.41]:12769 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBrCf-0008Gb-3O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GL7bL4eLsSR0ZVCheenlUg7K+EDcGlzyOIi49iPbX+MmxpwnRX4nCwcuj3jIzwKjD8bXzFjbmfJda5KKqp9pDN2bAMWiKrFZW6DAVvpT9/oFLvJNliYFOWzdDx4ILbkbN1ABwaYNokbai/yAoIAmX3HF8Ofqy7umpBji24zIZDJ+znX24i6qPuMlpiR9rKu4QeQn25tb8KOud4EMTi101vOgxwMJrcJuUWygCwQwRIJZ3tzyldIXCXDGujtZJpNiUz0IgtGF+Y7x6jC61awRvz7rJZ11lJmSvSFBG/CBTb+ULn4zGu0dQkuDbviaB2jK3NAINadRAuP4cT8Fr7tucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HToBpq4lqO1HP3/AXHPI45iWacBIykNE1mXi6WEgDaQ=;
 b=k0y+6CkM+2g67G0wbGq/wCXWVZIXKNAYQhp2P8445FUY3UB2ins129lGHTQUG6oNiyqQ9VbWjEsmN5w5kXTPSNXco6CfJkOrWIb+vwxw9Vs+uPHIizX1B2obJMLpQVKMiuo41RG7504zGZusOgirtV2MkvjXWKuQ4/FduG3WLBAZ2duthOx4Ld3uma+BU/d5AlEEPug31EiaxbQdsu0GDaAmE3HXOVHHq0HVRvdX8FcbAc5mWzk6cmcEE3h5jhAbcpVz249Vq9Zag5Ulp9IsgV17ra4ClIJPmZLhBs6qkfwny6t2NQVQ6pc3F+6eJhk6WFOXQAuMQFkFN36AOT2LUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HToBpq4lqO1HP3/AXHPI45iWacBIykNE1mXi6WEgDaQ=;
 b=IlzGXVsz/v7P36u7JWsVCosH7Hjksdb7gWKekEGOeJ8wtgUS2/IS2tm3HXF1aGE5MKQWeQhJ3rsDLz7oZTI3NrpIzODWlBYR+Kd6cISdumS+JQEqEtu8EGDnMkhNtBpC+r7pIG1b9FotwJcZrRSPFmm3fLgAYO7ORxry1xzb+08=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 02:34:34 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 02:34:34 +0000
Subject: [PATCH v6 11/13] target/i386: Enable new apic id encoding for EPYC
 based cpus models
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 10 Mar 2020 21:34:32 -0500
Message-ID: <158389407283.22020.13704666183488372052.stgit@naples-babu.amd.com>
In-Reply-To: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
References: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM5PR2001CA0002.namprd20.prod.outlook.com
 (2603:10b6:4:16::12) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM5PR2001CA0002.namprd20.prod.outlook.com (2603:10b6:4:16::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 02:34:33 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d326265-95ba-49a8-7d97-08d7c564bc60
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:|SN1PR12MB2575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB257526E736AA48C30AD3909895FC0@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(103116003)(81166006)(81156014)(8936002)(8676002)(7696005)(186003)(16526019)(66556008)(66476007)(2906002)(55016002)(5660300002)(52116002)(44832011)(956004)(966005)(66946007)(478600001)(316002)(4326008)(86362001)(26005)(170073001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2575;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEovjQnt53QpEutwjsZbfRPaKygVciYvZ5aUszPo4GlA8FWP0km8h94Zg24fSdrddqgu45hlU/mPRFtQpYKBlUqnxh+r+31WCSx4um2WQ/WiaFP6GRNitpKFppqqrxUDI20tx8zcKIHVk9vaSL830YrJkPpjXQWtYUhePpPqcohw3e9cGft4jmBU40dHvwTytRyRI8bI+wQhanxVKhgstqQHQZbvekyGMurIvWufwI0yOsO8UAWeHlFkmuKw/DBYbOumAXuyT9fiN9cco7eH9HAb34z6oZFQWMGDDm9LVkrgR8620sYaTTm3/c5fnV92jb+x0asiuJ0gaZXCylKfgME7L0OU/1h6shjPNUHunVFnfeLl4lZLXdfzei1Gw5TgrFE83WiQo4ERaTxE/braBBc5OrumOkkqTE5hNU8tJ6llbh6RdLDSwiC1+uPqcb6StWY2ONQhbGSA05lYVZ4fYeMXf3w6mkn9LG95s9x7Nhf8E6cepiRKbBHoGZmoTDH7eXy94mJ5vs2M9TiooKU7uNpa7QujB8f5SI7v6o5h95Bn6PSX/qN9sJdKtMbNsMlJ
X-MS-Exchange-AntiSpam-MessageData: oopNbXiKemt/oYaN/0x40Hdc8d6P6ejSG1G8OEU08TGCc3DOxPYVNUSikarurZ9vQEywpPV4evj8Nz/+IoTf1xV9STj1BmxGS5VcDc1rjFog436oqk0gEfgAD2zW1sm+vkHZQW/KhrCqumDCwMW+CQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d326265-95ba-49a8-7d97-08d7c564bc60
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 02:34:34.5955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zctfcysSZq1NJqLG4QkHLUNhCaVvcdZKpK8HHOMLk8DYzfe9PinTxr/p/x7onBzT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.223.41
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
---
 target/i386/cpu.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 19de79d01c..5d5734af76 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3921,6 +3921,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
         .xlevel =3D 0x8000001E,
         .model_id =3D "AMD EPYC Processor",
         .cache_info =3D &epyc_cache_info,
+        .use_epyc_apic_id_encoding =3D 1,
         .versions =3D (X86CPUVersionDefinition[]) {
             { .version =3D 1 },
             {
@@ -4048,6 +4049,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
         .xlevel =3D 0x8000001E,
         .model_id =3D "AMD EPYC-Rome Processor",
         .cache_info =3D &epyc_rome_cache_info,
+        .use_epyc_apic_id_encoding =3D 1,
     },
 };
=20


