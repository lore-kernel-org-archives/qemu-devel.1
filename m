Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABFDC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1379B2071B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sAvJz901"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1379B2071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kComf-0000EK-4c
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kColb-0006xO-20
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:42:55 -0400
Received: from mail-dm6nam10on2048.outbound.protection.outlook.com
 ([40.107.93.48]:39137 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kColZ-0007X7-82
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:42:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWX6e4WhsYDHC4yLEY8/oCOzFiZbi0xKIYxaulyKgdXhpStfPDD4N5n2mf9/nCw3J6EX3zEIGuI/nmNNxyvpZqgvxsX0Vi7tZlHwr7QYSJ/l948JPbc04FcqX4+aQzXp4WFzo2cbAFsED9T+EOZkWPfiOTQd3vG4emgvzDasi04usInqgT8EkvPqHOr3GVtfh0z6ovQCCDJSa1dP/nVe1b16qUOmhAiiKzMBehAbxgQUznGPpQtQ6Fzj1feaj4mGD87B5a2lVnMzlO6X8iSkul97LZ2eY4f+PVXCj8daM+Flbl+Yr9dKCyW0ox1ZK0qJUPWiK1c7Sq6AfXvPxZ52XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRt2401dv7ssbjPZqebOfDuTFxwpaPHpzWq9zredbaw=;
 b=l8BUzFAiuWJqN4HDWICST8jnWNUJi9DqldYxax/Rl7/VuJaVljZway/uduIR7ikUlpsC6vFvluHk2V7YIGOm+P3/kKI90CfLc7eITDf5+Y8EhYxL1cQnD1tmW1wIN8yNJdQX1o65U0WXMEWZA0HBxIHP7LQwDTbM4Qz8ILPkE0rml0JIQmOmb7l0JMfyuXQEMSKVJMtEJzYlHLl8q5YcfOzdQ2rirncK+PnUS41d27FhPjr8XHGKAXGhf/SOGb0P8giCCWeBplyb8XfIa0tO1DlrJUNJLngdRkmhgtEfKridmGjhLtFImQapU5z2ASM+VdJOpDwp2Rf2IZe3ucSegg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRt2401dv7ssbjPZqebOfDuTFxwpaPHpzWq9zredbaw=;
 b=sAvJz901MoG4kk7EVovwp9KG5Ysp0iJA4L0l3GCk5sFjfL4Zdg4WmzQ27+WVCWCJORlTTrbFpkru/fOMkUL7DQ9cMTKp1J8x+/ACNjho+UQIsBU0GpgTcgtBsMzDyVlYb3yIT8oSPrAoZfK+L3S36t3HTUaaXGl/b1bT7j6N7xk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Mon, 31 Aug
 2020 18:42:49 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 18:42:49 +0000
Subject: [PATCH v6 07/10] Revert "hw/386: Add EPYC mode topology decoding
 functions"
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Mon, 31 Aug 2020 13:42:48 -0500
Message-ID: <159889936871.21294.1454526726636639780.stgit@naples-babu.amd.com>
In-Reply-To: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0031.namprd07.prod.outlook.com
 (2603:10b6:803:2d::34) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0701CA0031.namprd07.prod.outlook.com (2603:10b6:803:2d::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 18:42:49 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72c114a4-580c-48b1-e160-08d84ddda941
X-MS-TrafficTypeDiagnostic: SA0PR12MB4383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4383188AB72353265E9C31DE95510@SA0PR12MB4383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y65sflPYIWgIW4JbpOL+j40qplKMngrIzp4vnhW94uZBqF9KD26PKUDSmpy7L0dW1yLYikP97prNc4o6wYgfFfXRefjjhDThbKc0hEOAKwTlSwJpS7k8l9a96RJASlu7PZEHsYRSyQiX5Ku5eCQ3JtjRXCkPnV4zn7rV3EjU0SuzBDcmrc1WoFzdP79L6zsAVUwLdrl7sn1d5mux0P3x8Xbuka2XEL1LRw5yKHjXfdGDF/GHzJWpJos5zRyDaVA/X0j5Y0C+Mnls3QUkUVBMKzcH0O4iCLtOSoMinUJLUXLo94HaBcXiGxfDWcHohdtw7Su1ERYBBUnMnaYV44o92Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(316002)(2906002)(26005)(66556008)(478600001)(6486002)(4326008)(186003)(956004)(83380400001)(8676002)(66946007)(86362001)(5660300002)(52116002)(103116003)(8936002)(66476007)(16576012)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bw/OSFed5fQxKxO4Lm4t2Y3244ePZhqSW8G7yjrljLgSCydAozIHluET6NSvoyeRJEGt+421FN6FwBuGibvFqBoZswK09bejtr+NNFGPMjr1lrCN7SeM3ZcPm0YS1+PdcPy6Yo7I8YVblvhRPRtWt61mZmbBFTOproMdhaoxbfY8YCso2B2wrvmWn42vpERShBGUZxjJ6nrbEEMAFR5pJNChmFA6eTAC2Jc+cvjDLmw7FVKUXBdl7AR0X9d+yevhfzy33OVPpGZc6Ahuz7t2I1hBqdt81VlNdpDu31Dxz3tuvGWOn/1PjXxXB1G1wFBQQA/O2a4Q8uJsGqGTzx7UINesvh/UH34PlTfLXQDrIg1niM7CkP/7Leh8lmAb5Qh1F5YxU0L7vir/+9vPmqYPaPqu69lj4jJjqOj5AjhvO8DHDmZvYzbrS73EuEih+olxLRKtEAodJZZgMiZ1WAM8bqY4ZhffBgRd2dwRlfRy9IVJzdw2usyhI7L1QDG/PSX7Ye8Yc4Zc2T9GImjiN9N4ZTy0tR5yHHXydlX5+HjGOR535TklJ3NsLs71ltySa9avHzDu4iwTkz66+GpkO6SZwiOE2DOxI8HXjpEGIOvfoIXhcYuz/A5ruBPgCXYAwBkg71zTVqs7nhyJsduUr6hqxw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c114a4-580c-48b1-e160-08d84ddda941
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 18:42:49.6522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIzK+EpdLLi34Q9HCTDfdrYGYR8VlA3aoR1cxLBEo0eEYNHZLbB8JYV/02yN8/co
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
Received-SPF: none client-ip=40.107.93.48; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 14:42:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001, RCVD_ILLEGAL_IP=1.3,
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
Cc: babu.moger@amd.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit 7568b205555a6405042f62c64af3268f4330aed5.

Remove the EPYC specific apicid decoding and use the generic
default decoding.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 include/hw/i386/topology.h |  100 --------------------------------------------
 1 file changed, 100 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 07239f95f4..b9593b9905 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -47,7 +47,6 @@ typedef uint32_t apic_id_t;
 
 typedef struct X86CPUTopoIDs {
     unsigned pkg_id;
-    unsigned node_id;
     unsigned die_id;
     unsigned core_id;
     unsigned smt_id;
@@ -89,11 +88,6 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
     return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
 }
 
-/* Bit width of the node_id field per socket */
-static inline unsigned apicid_node_width_epyc(X86CPUTopoInfo *topo_info)
-{
-    return apicid_bitwidth_for_count(MAX(topo_info->nodes_per_pkg, 1));
-}
 /* Bit offset of the Core_ID field
  */
 static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
@@ -114,100 +108,6 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
     return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
 }
 
-#define NODE_ID_OFFSET 3 /* Minimum node_id offset if numa configured */
-
-/*
- * Bit offset of the node_id field
- *
- * Make sure nodes_per_pkg >  0 if numa configured else zero.
- */
-static inline unsigned apicid_node_offset_epyc(X86CPUTopoInfo *topo_info)
-{
-    unsigned offset = apicid_die_offset(topo_info) +
-                      apicid_die_width(topo_info);
-
-    if (topo_info->nodes_per_pkg) {
-        return MAX(NODE_ID_OFFSET, offset);
-    } else {
-        return offset;
-    }
-}
-
-/* Bit offset of the Pkg_ID (socket ID) field */
-static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
-{
-    return apicid_node_offset_epyc(topo_info) +
-           apicid_node_width_epyc(topo_info);
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
-           (topo_ids->node_id << apicid_node_offset_epyc(topo_info)) |
-           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
-           (topo_ids->core_id << apicid_core_offset(topo_info)) |
-           topo_ids->smt_id;
-}
-
-static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_info,
-                                              unsigned cpu_index,
-                                              X86CPUTopoIDs *topo_ids)
-{
-    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
-    unsigned nr_dies = topo_info->dies_per_pkg;
-    unsigned nr_cores = topo_info->cores_per_die;
-    unsigned nr_threads = topo_info->threads_per_core;
-    unsigned cores_per_node = DIV_ROUND_UP((nr_dies * nr_cores * nr_threads),
-                                            nr_nodes);
-
-    topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
-    topo_ids->node_id = (cpu_index / cores_per_node) % nr_nodes;
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
-            (apicid >> apicid_die_offset(topo_info)) &
-            ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
-    topo_ids->node_id =
-            (apicid >> apicid_node_offset_epyc(topo_info)) &
-            ~(0xFFFFFFFFUL << apicid_node_width_epyc(topo_info));
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


