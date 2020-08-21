Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445E3C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF07207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u0GsYT6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF07207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9FJo-00083j-9n
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 18:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FHY-0004H8-5l
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:13:08 -0400
Received: from mail-eopbgr770088.outbound.protection.outlook.com
 ([40.107.77.88]:30117 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FHW-000289-DH
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:13:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsUfeaKm3uzATpUBoXAFeIfziTJyVWfTkqXnnEyb20qDYB/tvwc5KVH1VKhjJ7lQOVTtgoZNI0D7RJ3VKMeuXpaff/71aSbIHk1H2wkANmyrvUAdM5Adt2iPkrfsNGvVM/wzoYbcdTONTjL9aevGwVx87XNB4fVefJGVkFh/omgEoKQwD1YC0BIMuFP1nGB70zi88KPUTsg8RtwGugVxeJDBy8loONfElIe/8kmcaOyNCbtQQCksjS9j7kSTZcOBdqSbamRXh40DaBF/WRKD0lSJssnDzArzfmJm6MNY/DKFtxdIYsmhfd/cQuVK8aRr3psgObJ3LO2ME/26FHPx1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBkqZudWToFHDCYyzU0iuzhMlRS3dxQow6d0kA1PyBo=;
 b=FR4iT2Qp/dOF9V6QdBlUvwf2nIlwgQmrWplJYojUOATEEXIZm1QWet2mNTi0ueKCLIVFrLXxkpMkRlWwE4c6+X4Mf93dY7ye/dwA/MXAbCtokI5vcme5xL1XbZOWgH7Py6yuDzTmG/mwMmTbl91NxzPeVTLJPmGFDpgtXCWKg0eLQsAF5tO3Kcd4CEL3BlnQMoyN6BkBctgBwjqdHkETtZZr56LoxOR0XC8Tvz8iNIyAadg4WyHG62y/u6sYQUs/Gbyf3k8KJrRmDmSqbVTCvBIrIGpEye8DkH+XJqDmazZApku8zmDloSOGp+lwZugFA6czJlj4OVcmXJbOpqyX8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBkqZudWToFHDCYyzU0iuzhMlRS3dxQow6d0kA1PyBo=;
 b=u0GsYT6bARueqd84iT8ZhA9S8sn+LPlk5dKeDZqqm6/Cro0MI5Q2s2qI+Zs4hhKxmCkRZ+QLXh7qiA6lJrNsm55xhs4L/g072G1cxjNsI2cIRsEAkDM9rtv7fSglcgZVS9yjkg/rgLZpqMlCRsTWVEbLSKiSg6Hk84+dioOsuyw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB2670.namprd12.prod.outlook.com (2603:10b6:805:6b::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 22:13:04 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 22:13:04 +0000
Subject: [PATCH v5 7/8] Revert "hw/386: Add EPYC mode topology decoding
 functions"
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 21 Aug 2020 17:13:03 -0500
Message-ID: <159804798309.39954.1879996211709102099.stgit@naples-babu.amd.com>
In-Reply-To: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0035.namprd02.prod.outlook.com
 (2603:10b6:803:2e::21) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0201CA0035.namprd02.prod.outlook.com (2603:10b6:803:2e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Fri, 21 Aug 2020 22:13:03 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 088e003a-c075-4493-e7c1-08d8461f5fd3
X-MS-TrafficTypeDiagnostic: SN6PR12MB2670:
X-Microsoft-Antispam-PRVS: <SN6PR12MB267070440475B43660BB750C955B0@SN6PR12MB2670.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmcgtwWPWP8zG5fVQO3Sfkjj0FvCByJ7ibrCTM/4tqSZ6BhjkH9TLuGEB+kk/u/Yx5YfYVOm1KTkdVED3MbitexoqrkDRj4jiZAUsKGTp7L1Jv9IqpN80QQcMDs20gRNYT7ptPrJHP1VuqlAiokya7VzUDhOa3GWBR2MLV6mfQr6YBKPKWyElx3HilOBOxAJKf6Js8XldyDcL1ikb2qytsKE0IagpwOCroIUgLW+44A20/RwDk48CXArELdj5ct+USMDvJRaHJkn7gJqn3uJa7oANn2QWajWkdh1odV/bF80g/Evr+KbgBGNjSPvhVK88kkpx7t95eCl25J50LluX2VZFpAv+t7FipwzYvnpXd56r14zmpMv0ya0MHYgXuP+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(4326008)(5660300002)(83380400001)(86362001)(52116002)(110011004)(8676002)(316002)(26005)(186003)(956004)(478600001)(6486002)(66946007)(66476007)(66556008)(8936002)(44832011)(16576012)(2906002)(103116003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /PkbBWJTLQHrbtMhcJz+DD2Gfh6x72v+KHxQ1riqx66uJ88VKKH+TeblTr09qQ75uvFxw2IEZjs03Txzw3BifpkMNIMqt6rBbgUQvFIyQjT50xHIV1hmSPxpQPMmENAZ63sEv08gUPQd+2Af/oGGhpMA6pY6SrcJWkC0wKAEaJO/KYFp6tMMKEFvEugO9ij8sCFVjr5CH0H+/yQoFE6obR7Vw9n+H4dRSkPDAVOziQieHSoD1xpfz1ALXnB/m8XIfez+3K3z8k6tTu8MuQLSLiLRhc2Zqiko8HH5/Gw3ypYiWQLi/zOl5JH4bkk5gR/p7lYJndXI454UKtMJUNT025P+V6TLxr8uSfPLnbXd4C5b7MQZb9hQ3jUDBD18WlhuA+iN1VML327ptnmy5kMNdcRBa15K2ovhqoSSmALiagwMphqiMogpVssi8VJWdOJNC/7YJ2n5+O+9Upvg+o93m5Efu+1UatCghfz9Zx76N67Dy3zCcW5Dje6y2k/jprzPV/RBFkXBuzLCo03uVTF7BVAzhdss5TOKFxaeOWSzV5tLTMTFTrIDPesp7pFYi+rKKXTj6bkmgbiw5E/PxRNTJF/WYaJO6Gl73bR73aA4lkXKn34NX/NqWic3M7Z25Zk02tR3XdbenEz9PmIUVHt2xA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088e003a-c075-4493-e7c1-08d8461f5fd3
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:13:04.2096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fBKsqcoY7cNeIOnmjyZvo+fAz+veHq2lDSMlXpWfYC4qXiWLbiXSZI9mH1mU+LW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2670
Received-SPF: none client-ip=40.107.77.88; envelope-from=Babu.Moger@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 18:12:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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

This reverts commit 7568b205555a6405042f62c64af3268f4330aed5.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 include/hw/i386/topology.h |   79 --------------------------------------------
 target/i386/cpu.c          |    2 +
 2 files changed, 1 insertion(+), 80 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 05ddde7ba0..81573f6cfd 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -107,85 +107,6 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
     return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
 }
 
-#define EPYC_DIE_OFFSET 3 /* Minimum die_id offset if numa configured */
-
-/*
- * Bit offset of the die_id field
- */
-static inline unsigned apicid_die_offset_epyc(X86CPUTopoInfo *topo_info)
-{
-    unsigned offset = apicid_core_offset(topo_info) +
-                      apicid_core_width(topo_info);
-
-    return MAX(EPYC_DIE_OFFSET, offset);
-}
-
-/* Bit offset of the Pkg_ID (socket ID) field */
-static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
-{
-    return apicid_die_offset_epyc(topo_info) + apicid_die_width(topo_info);
-}
-
-/*
- * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
- *
- * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
- */
-static inline apic_id_t
-x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
-                              const X86CPUTopoIDs *topo_ids)
-{
-    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
-           (topo_ids->die_id  << apicid_die_offset_epyc(topo_info)) |
-           (topo_ids->core_id << apicid_core_offset(topo_info)) |
-           topo_ids->smt_id;
-}
-
-static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_info,
-                                              unsigned cpu_index,
-                                              X86CPUTopoIDs *topo_ids)
-{
-    unsigned nr_dies = topo_info->dies_per_pkg;
-    unsigned nr_cores = topo_info->cores_per_die;
-    unsigned nr_threads = topo_info->threads_per_core;
-
-    topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
-    topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
-    topo_ids->core_id = cpu_index / nr_threads % nr_cores;
-    topo_ids->smt_id = cpu_index % nr_threads;
-}
-
-/*
- * Calculate thread/core/package IDs for a specific topology,
- * based on APIC ID
- */
-static inline void x86_topo_ids_from_apicid_epyc(apic_id_t apicid,
-                                            X86CPUTopoInfo *topo_info,
-                                            X86CPUTopoIDs *topo_ids)
-{
-    topo_ids->smt_id = apicid &
-            ~(0xFFFFFFFFUL << apicid_smt_width(topo_info));
-    topo_ids->core_id =
-            (apicid >> apicid_core_offset(topo_info)) &
-            ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
-    topo_ids->die_id =
-            (apicid >> apicid_die_offset_epyc(topo_info)) &
-            ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
-    topo_ids->pkg_id = apicid >> apicid_pkg_offset_epyc(topo_info);
-}
-
-/*
- * Make APIC ID for the CPU 'cpu_index'
- *
- * 'cpu_index' is a sequential, contiguous ID for the CPU.
- */
-static inline apic_id_t x86_apicid_from_cpu_idx_epyc(X86CPUTopoInfo *topo_info,
-                                                     unsigned cpu_index)
-{
-    X86CPUTopoIDs topo_ids;
-    x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
-    return x86_apicid_from_topo_ids_epyc(topo_info, &topo_ids);
-}
 /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
  *
  * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 19198e3e7f..b29686220e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -388,7 +388,7 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
     unsigned long dies = topo_info->dies_per_pkg;
     int shift;
 
-    x86_topo_ids_from_apicid_epyc(cpu->apic_id, topo_info, &topo_ids);
+    x86_topo_ids_from_apicid(cpu->apic_id, topo_info, &topo_ids);
 
     *eax = cpu->apic_id;
     /*


