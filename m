Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65256C2BAEE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 486602074D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oYT4uYBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486602074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCAJZ-0002HQ-CW
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 18:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAE3-0007DO-3Q
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAE2-0004qs-2y
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:19 -0400
Received: from mail-mw2nam10on2044.outbound.protection.outlook.com
 ([40.107.94.44]:6947 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jCAE1-0004oc-QK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzNjN+8qFos538bvHckG1AnmS3EK31AAyTA0Jw0bFG/bo9dcgN8Rd38nVQnaGvT95BlQJ3+ytDZO1rXz1gEuhGroO0on9HqnfVYNWt9nSofvgLKlI9YJhE0W4VFZgWWAB6oHhindxNIXc+JjIAwfbbdfrZ+ITOiRyYjh8dl2veww0DrDEE+XSajzruXVJS4D+o1lTgYowVG1scx88LBhGFE151UrNt5RRcG7UyZEtuQBXNahZ/qh8AqfE/pGds17gyNrOQA1tFC0RQtSjcBMTEf5GXNE3xo8DCcrpvjnEk6Xbt+/w3ykWg6ut6160aiWWxCrLjcCGWQsLygbB0pO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9yFhJJvBK70llWkw83gnFQIYf6PUSsn7+85HtUUYf8=;
 b=TH/+THMDi1VxP7HXLqrK9vgS1oZjZmwJ3swsKGpBpdnHFv3r2cjaqSzQkAg2XMHa5xwZ2KrZYZs25rZ+qY9hYCD2FMDdHe+NGGy6dGHr8DUbv22dxlizDJAmEmvwNdgzJMZhw+Z1vW4xeHeM0IW9Di1yNWeR/djbiBjrWKVnQcxzu4ZDuWXiRSj6t2/axPpTprYsNXx/VajfsR9icu/4VVTBDa7e73aL3xRqiqjiZAVNq+4HoC6oiLpDcuvvn2vayDcQ0Xzqg/RxHwCq0hiYQyrsD0LS4gc+Y+Fo/iThKUecTPvq3/Dx3aPe96YEKRuAbazSHxyH462lGNKS7EbtMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9yFhJJvBK70llWkw83gnFQIYf6PUSsn7+85HtUUYf8=;
 b=oYT4uYBzYsjIkhY5IirzEMfR45DPFRnnSRaAUeRDuUJixqOJcbQbucN1M6oWa0RFkh//MQIyceXLkfZXykchTCGCK5tTcpDJphVeiq8hV74fLqkYtewesvXV7vae8ArkG5UoNyyb62ElTLSl99HRCY52uGNB/QkZtsh+t+oyWKg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2349.namprd12.prod.outlook.com (2603:10b6:802:2a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 22:53:15 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 22:53:15 +0000
Subject: [PATCH v7 04/13] hw/i386: Remove unnecessary initialization in
 x86_cpu_new
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Wed, 11 Mar 2020 17:53:13 -0500
Message-ID: <158396719336.58170.11951852360759449871.stgit@naples-babu.amd.com>
In-Reply-To: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:5:120::35) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR06CA0022.namprd06.prod.outlook.com (2603:10b6:5:120::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Wed, 11 Mar 2020 22:53:14 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aee8c446-0042-4005-47e7-08d7c60efb9a
X-MS-TrafficTypeDiagnostic: SN1PR12MB2349:|SN1PR12MB2349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB234995D78F6163C9BFFD9B0395FC0@SN1PR12MB2349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(44832011)(478600001)(55016002)(5660300002)(956004)(4744005)(81166006)(8676002)(7696005)(81156014)(86362001)(103116003)(4326008)(52116002)(16526019)(186003)(66556008)(66946007)(316002)(8936002)(2906002)(66476007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2349;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+6X5NrQb9iVGpwoHrUiZAtFlBFjbjfiJs8yApWr3XafPcKQ6cjy3m1cumLsg88udyhPYEfzNtim+2Y/uE8m3Z9uk/dbwUTqlPQwk9UYX77Chr8WRyqexE4opNDU/HkqeUCK1FQpXyONKdMCyFIZGDy8VvBkZ7NtOr/X45zubP+2DJ3193R8Z1QeGWTuL8vbdYleOWrf1LlMlOUiqESPAAacV78ynteCFyQ3pAQ1inxpUlhRfIe4zUSf2sMufS4COrlN43VDilG4N+ToAcBj6O47lo86xB9vAI+xN3Q4641IvkViTPjBsA3h43Cck85vbrwYuFIM6htzvry2UBhJqBzX0aTLRPD9Ol9b5QcCboe4AVGwDMn6v7FRcUBS1crRxDuPx1SaYffMzg+CLNnxIZUt7trggNCVX21d4Zj1Qr82sZMR6KFbCkVsEVx9TcyY
X-MS-Exchange-AntiSpam-MessageData: 1S5YHZAcfHHDhXOHStiiOvajou2mJZFbyV1ujONy7+o33di7Hi68+lxQCCcnEYFn/ZKiGbHwb4e+EgmVXt5IHIgEmK3Dok1qqDXpu5IMEs6X7VTU2xGQoIYHA7PMru8YDpJpeB8b242KUpqKYpEV3A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee8c446-0042-4005-47e7-08d7c60efb9a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 22:53:15.1067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIt0LqtGt5FYUeUvII6icGBA9RNrOf2iYuozYkDkKNcrzo4ifWcu5AlODFNVZ2IT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2349
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.44
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/x86.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index dbbff46a4b..84d1944a34 100644
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
 


