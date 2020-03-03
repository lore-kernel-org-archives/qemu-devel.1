Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE05C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:00:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DCD2073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z+mKsaOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DCD2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9DiY-0005dT-F1
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 15:00:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9DfV-0000Gk-AY
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9DfU-00031I-9i
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:29 -0500
Received: from mail-bn3nam04on0623.outbound.protection.outlook.com
 ([2a01:111:f400:fe4e::623]:28322
 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9DfU-00030y-3e
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD/ppDCIP/M3rWJxbB/aQbCH2hq8rH0IJUceMawgRpSAcagj5K7ZvxG8LZChnRYDH9dZF5PMaA8LHoGvqk2DiJU6QVL2izZMKSduNNrDD5IHh+kneYga3fNHUMmc86R5sGgvLzxID/QAGEUQo0ALrdUuFjmh4yam+4k452tt8vQUq6mmKi6zTOuFJg8MeEO/gp4Y2FuPmIYAyzzmBZpDELh2qI4Czc7HZCr8JcV6qhfDc0Wd0+jQv4NG7nC+IBdsglyGQzlNd2Amo/Flofpw6FIvn17kfr2n/bUYc6pCG81KHqa0qkXvDsEiSLMI23ffx8TIApK3/ucLhezat/QKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vBOvC4A3FWBf/rhF7wTUjoUPneTqtm5XEO4DeULwi0=;
 b=auPZ3x0c3SXwM42U2zlOGDvsYuC23CQyimBTUXUS/v1yeoRapd34oMQpBwqEJwN0ulNd8y84UL7c++JMkoyLt4xGvHoynADrkPEigHQtR6jurUg4vsLrcmL1akVD9AbR9yx4Vo5L0zpe1e/HRqDTeb8bC75twKeNn7oiwMJt1nxtv9b2s4GpLyP3LWvZruWOoJp3BDGhnHB6/qcSGEdfmgiWaXbZ8g1TULBjv+ChM1yvGG0VtDT6kcTl0VoqR+z6ZiLJb8szmT3OuXDN8EdGw3B5p5DdOMAnrUw2tVX7o4wN46JU7+l4UPEVztGnXc0B3UWqribkp3fbxdqRycPAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vBOvC4A3FWBf/rhF7wTUjoUPneTqtm5XEO4DeULwi0=;
 b=z+mKsaOCYYze4PKDZmTf2eLpg1e8l6WM4sbfhFoyRvziqgWD4ZYLf71r/Wl8A8OprshP4tmjw1+3LGylISNt2ZvPXjl+IQN8E7zbFLezL+W2S0Ld+fzf1PlnYCbkvjJwJ9ZppW8zoJaF08RRR27w9sDrCxmOe7UfqMdB62nvTt8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:57:25 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:57:25 +0000
Subject: [PATCH v5 05/16] hw/i386: Remove unnecessary initialization in
 x86_cpu_new
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:57:24 -0600
Message-ID: <158326544443.40452.17613849801643778536.stgit@naples-babu.amd.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0097.namprd12.prod.outlook.com
 (2603:10b6:802:21::32) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN1PR12CA0097.namprd12.prod.outlook.com (2603:10b6:802:21::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18 via Frontend Transport; Tue, 3 Mar 2020 19:57:24 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd830821-e987-44a4-b505-08d7bfad1834
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:|SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB257311386F40C922A573C49A95E40@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(2906002)(316002)(81166006)(8676002)(81156014)(8936002)(103116003)(4744005)(52116002)(5660300002)(55016002)(7696005)(66556008)(66946007)(44832011)(16526019)(186003)(86362001)(956004)(26005)(4326008)(66476007)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2573;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I00bwM6Wxh3oRfJIJ3D/cisQbLusDfGjQnovxxnfyF2Yf0ygKKHRKu1Qxe6h2pn2i0uBSaHDiSOhHPgesS9neBcJ3wqY8TebhPzKoujlqeFUdl5ZrQqThWR5rMGDbsrmJULeC4QzjzyO6XBXqphPRNI0svLVYLdkRwq2pMMU2xbSJKe0lzloJxbEPxONvXvaruYJ4vb+50KwCTU1jUdEtpcasXBGU6k8tWR8OyzXsyY5NNOJDkOo8IBLUD5RGJtZ9K9umJvrWSKWsfdaItW3xfVm9J7zK8dJ/eFemhJTynazcsrb/dOtl90fOOpADaEpsFQw5VPhWKNzwZU5bPjl/bQ/J4nvD+bGuOqZ/DAADFWmBovEsMxM3NvmRUdgXP3NNaIjTJmVCrKMUWY6apmrfNE6b+yG8n+fpP9y8raObLhuv9CeqxpgIGpNtiPFGdP+
X-MS-Exchange-AntiSpam-MessageData: ozafyQWvEhb4Tyss575nW65AUvFKXwpHCZP1OUq4VlnhnlplA8grrpoOBH9EKKxTj7UWdlgVvj2Yr3JvLtdpp63QkTwOT+mJ5UhV96APluz+kYvT4yPHDcRxwhX2gZb5i+X1QXKoXtJQqJXwm+5fjQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd830821-e987-44a4-b505-08d7bfad1834
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:57:25.4188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxX9b2Aqdt0BJ/NZF3Z1Xi+IIYrkPoGCQLl8PREEftYVDI7WNjM1RPwk9o/RFtgg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:fe4e::623
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

The function pc_cpu_pre_plug takes care of initialization of CPUX86State.
So, remove the initialization here.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/x86.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 03b8962c98..79badcc4ec 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -103,13 +103,9 @@ void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
 {
     Object *cpu = NULL;
     Error *local_err = NULL;
-    CPUX86State *env = NULL;
 
     cpu = object_new(MACHINE(x86ms)->cpu_type);
 
-    env = &X86_CPU(cpu)->env;
-    env->nr_dies = x86ms->smp_dies;
-
     object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
     object_property_set_bool(cpu, true, "realized", &local_err);
 


