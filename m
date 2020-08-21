Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5245C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7AA20855
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tGeUCdus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7AA20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9FJR-0007TX-WB
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 18:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FHL-0003uz-F9
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:12:55 -0400
Received: from mail-eopbgr770079.outbound.protection.outlook.com
 ([40.107.77.79]:39278 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FHJ-00027D-Vb
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:12:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aR3QyxsahycDNEBj83Zl/WxSJhQavgnvENqm0p7sioEzIwPaM5hnvj7RiKkdeVR9GGfiSzUPjy0SeEDvVkbOv+igO7Kz0F5aMXH6MepR9z6BQKdf7M2r9Ra+pC5KNt9KyVcEFEPn0k6cGcnaQg2FLAmJ4QwkKWUUusmE5uECaatrJuHv0AQ7v9zJDPYJvW6cbvkJ7GRQGpZMlgaPnAFMUmFMcBJEoLk2hZkIjv5KQUhtlBwFdI3EaNkp8Zy1dqkB31JkYpOogx3DR7OS938c63+BebCeViX8cPxz+a6r/wVZIkszBKzt/583pI3uQhUvN9+cOZHlr/lSZPD2zooMHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nY66Q6E0+u4nlcfBduANiuFue7ktD4Eg/ps+SWWevo=;
 b=Mlaoob7wR/EZ+uv5DeCT+oBG84TB8tQMOOjn+vJBzxNrTw5HIKBUyA5Be6LB3e+RwEFJaEHU3KCzUWgRSH1UBWNLLWKdYNZyatWBIe6F7YNKgKLu4YSGD9yHzShUWhZTq77vXUDxSMYlTlCu+vnXvUWWyd4J/GzxS7MN3+xz1iZsVaYKWByU6I8rJnGnIrmQgI7rOT0p4sa4AoO+/5riCMR3QGXut+krJydpcazl2w7qNa95WM6ODJHO08FuoxbDOGtfHYfiTLwLBh1AGsGbL0OJMaIOnYOt2aNF0dhYYzDQpKyjq1SOWwKaKc+uzkem11Nb22eO56HGP4scZVB06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nY66Q6E0+u4nlcfBduANiuFue7ktD4Eg/ps+SWWevo=;
 b=tGeUCdusoIVhhijMhuocv5YnOLkVZIdES5f428ZAQamjHdymRjmV1JCpxjdIpKyXX/AeRIMZqYxvCzTaD+6D1HTXiMbQnie1ozOw1qP/NZOafy+NGCNE1wcM9M9Lir3GTNL1eeQbsoOKCYrN/nfAlOqueB+79WFwFR3N6SMelYQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB2670.namprd12.prod.outlook.com (2603:10b6:805:6b::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 22:12:51 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 22:12:51 +0000
Subject: [PATCH v5 5/8] Revert "i386: Introduce use_epyc_apic_id_encoding in
 X86CPUDefinition"
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 21 Aug 2020 17:12:50 -0500
Message-ID: <159804797021.39954.773444808887474448.stgit@naples-babu.amd.com>
In-Reply-To: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0042.namprd07.prod.outlook.com
 (2603:10b6:803:2d::16) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0701CA0042.namprd07.prod.outlook.com (2603:10b6:803:2d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Fri, 21 Aug 2020 22:12:50 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef2f307c-5d9b-4138-c908-08d8461f5841
X-MS-TrafficTypeDiagnostic: SN6PR12MB2670:
X-Microsoft-Antispam-PRVS: <SN6PR12MB267044BF3533326265BB9067955B0@SN6PR12MB2670.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tLG8w6eWbPTUIMqotwhP7e8kj4m9mVpzJKdIoh+FSnp2WyFzXUu/g0WHvRcHRwz3njmWgHq/vw1Pw3W+9jv70yZy1LBv/ARJ93S9UiH1ky/qMZXwT1yZXYSEDpuTuaRj6kBrm8/A5pUTl5gObSu4f+ciASPmC58VWqZWg368GWMIhmQaKxWkMQKxv68Qz7l1p8MC2BXwESrhW1OtRmJ/QTQIcg5achUlQ7TgY+l+u4Ai7+/91QtrQQNmXsxzBGgv1yFSZ6Sj5F2hQLTFVvrqgWtYjktZrMYu23uaSu3jFCJLnunytx3PJe39ZobA/Yjy+NCoJd+QIjepCQM3HMM6YQ35vNUx9yJNN3pXD7P0swsjg40xqri2Yuu+g0rIsxvV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(4326008)(5660300002)(83380400001)(86362001)(52116002)(110011004)(8676002)(316002)(26005)(186003)(956004)(478600001)(6486002)(66946007)(66476007)(66556008)(8936002)(44832011)(16576012)(2906002)(103116003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: b8QvrEvQIUZ9rs00FRRB+CTlbdC3AYUJvtGr+JWvGHRtZxqXIH/50q5AVOJN6TWtLfpblNakjsdQNQDffrFVO51iRnmRDWYPMHMcivrnGYpX+JverBHQLh92jrfz30HISxr0sYwFsyLpj5iuzuvjYMmyRLnwmPE/R5l0rBq88rgicklUf6I7lczl24Yo9RG9BRynZGQ8S06k5XGjVYQIdR6AkEVnARh6U1SAjFRY1IA5KM5SeS3suAwRPtgihzS5EIocIxMMU/qPw4oojFsnPfTi/oU0ZmoCeDkYNIq6cVM2cvIBpBIAEJBqxb6ruz0307ydth1noK7/11sc8d0cXRni5FLoNubj90WUHjKCQzDdYdejMrw2GIDvwE+PUOlPBQYikISkp0PBY5iXWTbVb70wdEiOVhPO4dmvHAo6yh8wsdi3CIxwbW8wz8VKvmoKPyQ4mbwlm5yImVwyvWvxG+MaUwsLQXYmXCH79PvR37+aruDsu4iP+Y7+Hksa1NtkGfy+izXUZETDuKDThMeWpWlv9Hg5d+dFAyFkTjDzVtIQm+epPZ4xfNULkPRQiojeOXLuxRgbWdDFNooKhjYv7y3ONZW1tyh+aUbd7djMQ8AhTKJhSN2HO3P9ZXuMZqLkG/yZMFnm3tzBEi1+HHX/tg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2f307c-5d9b-4138-c908-08d8461f5841
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:12:51.7238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaKJAEInc5d/ztHS2810Q9eB8D6HZJJNyJ3RVXYhXxq8bnFPnq2838QCFEv+ooob
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2670
Received-SPF: none client-ip=40.107.77.79; envelope-from=Babu.Moger@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 18:12:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the EPYC specific apicid decoding and use the generic
default decoding.

This reverts commit 0c1538cb1a26287c072645f4759b9872b1596d79.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c |   16 ----------------
 target/i386/cpu.h |    1 -
 2 files changed, 17 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 567d864051..19198e3e7f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1636,10 +1636,6 @@ typedef struct X86CPUDefinition {
     FeatureWordArray features;
     const char *model_id;
     CPUCaches *cache_info;
-
-    /* Use AMD EPYC encoding for apic id */
-    bool use_epyc_apic_id_encoding;
-
     /*
      * Definitions for alternative versions of CPU model.
      * List is terminated by item with version == 0.
@@ -1681,18 +1677,6 @@ static const X86CPUVersionDefinition *x86_cpu_def_get_versions(X86CPUDefinition
     return def->versions ?: default_version_list;
 }
 
-bool cpu_x86_use_epyc_apic_id_encoding(const char *cpu_type)
-{
-    X86CPUClass *xcc = X86_CPU_CLASS(object_class_by_name(cpu_type));
-
-    assert(xcc);
-    if (xcc->model && xcc->model->cpudef) {
-        return xcc->model->cpudef->use_epyc_apic_id_encoding;
-    } else {
-        return false;
-    }
-}
-
 static CPUCaches epyc_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         .type = DATA_CACHE,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a345172afd..d3097be6a5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1917,7 +1917,6 @@ void cpu_clear_apic_feature(CPUX86State *env);
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
 void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
-bool cpu_x86_use_epyc_apic_id_encoding(const char *cpu_type);
 
 /* helper.c */
 bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,


