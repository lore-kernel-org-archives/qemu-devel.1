Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283ACC18E5A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42AE222D9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mFvRkMSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42AE222D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBrFA-0005xQ-49
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 22:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrCA-0000CH-GR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrC9-00075v-Fg
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:06 -0400
Received: from mail-dm6nam10on20615.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::615]:19297
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBrC9-000743-9f
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pw+E3ptXoHYWYx9pEu3kl03MoRAAubVmkzL6RzYFVrWtsZDJBo5YSXUM/gVfeTSpeP1xsJ9yZsfNWpivsM7iNsH1Wzr0MrcLHsj7BX0n2+DcMn4ccJSOeo4Pop74xNRSm3gI1FsWkL26RwTvgxKMS5dhYYOzOKAtQJEEaF/TkcAC8qeuSphlVk7bFHA0MyFT2GuuDytFNLff2LA8suXXwDhwMTxv2/Ad01ZWcxDyVdY0bYuMGyYDrNdM7KDUDLAtsczcD+Xh22O1sdwgUvJZUVvtVxlhUCm36V/RYZ2vxE16VEDrq7cZIGg2rCYf56BjzDekuODI6Xpad5z1/moEbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7oU+Qnipw9z5TbfEZvYAYu9y74tQIsRx/5rqU6s+0c=;
 b=civskOQBD59L8Eezu+2Zd66O73lZaPzp9rp3OLY57yTMjWMDW78j4Icg4/1DEaItZOAIsxqgc/FO+ZVkIE2q+FzWiABvA+XpI9lps5+pIYPMwo48yD7gk/ouE5uPi7UbLZyqH9TusR3TffLFd61aI5+GSTr2NmXSEy4s96MUoBPV9k50MAorSSvkCrwebcT/h+IoqfnV2VHJ01OvE+A4OCjjvuvU9IKTLmEiweMY+2P6K49HaLjsOPJ+5tyMecTFQ8+MV+truhQO7WGZl4vQr8gzkktjLiW4pX9gUaiDvMnYQYMgbtREDAxqQOxmu9QCHfvmd9oMBUMfi/WysYHAcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7oU+Qnipw9z5TbfEZvYAYu9y74tQIsRx/5rqU6s+0c=;
 b=mFvRkMSdsBPeiMwEeu6EYMquXLzld0/UIcTda7f48BCA75CFV+LvmoIeiZi/5Y2+W57Hou8rVeB5Udz/qIoMyS5cCY7GfA8gqxukNzCpTm3e9GLMnJ5SDpl0rpz4G44t8vzGSdCUdw7tZCKntGOIF7uDrlmpspMTYyMqCE2ZvBs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Wed, 11 Mar
 2020 02:33:59 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 02:33:59 +0000
Subject: [PATCH v6 06/13] hw/i386: Rename apicid_from_topo_ids to
 x86_apicid_from_topo_ids
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 10 Mar 2020 21:33:58 -0500
Message-ID: <158389403816.22020.5329773045205545769.stgit@naples-babu.amd.com>
In-Reply-To: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
References: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM3PR12CA0083.namprd12.prod.outlook.com
 (2603:10b6:0:57::27) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM3PR12CA0083.namprd12.prod.outlook.com (2603:10b6:0:57::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 02:33:59 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01e761a6-91d4-42e6-89c3-08d7c564a7af
X-MS-TrafficTypeDiagnostic: SN1PR12MB2493:|SN1PR12MB2493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2493FC318ACA46E01DD48D1B95FC0@SN1PR12MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(199004)(86362001)(44832011)(55016002)(66946007)(956004)(8936002)(316002)(8676002)(5660300002)(66476007)(52116002)(7696005)(103116003)(66556008)(81166006)(4326008)(478600001)(16526019)(2906002)(186003)(81156014)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2493;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dql0Qxiv/tT1ZeFEVSSrvM5jqDh0F3j0L/Z5/3q5W81NnI9zIkxq1NOr4tSS2Cse7zS8WlWP3avEYNJkWOgr0x7R/LmIfQ2H4+LsX3BIDOFOXxGZX9HE/3DoyGhG3v/vKT7SHUCe/LR8Z4B4UcK/2iRZVKf1RuUq1CgaMX4TJZnPRDaiGm/6ptk46NeZKpEIJQd8pqte4R9rbOxglkGg9SOWLS9PtWM+MDwd2F4h/RTFnFhlPQ3mB62ETZPIXPE6iDO/JhxdKStUlA0GPGmJtiLvOwIyEcnpWWAIq1G7HW8anEzxhCjg6PLO734EZzvtfdh2+mmyFKbskH9h6kDzviTUDajWdhuA2y2N1DrJijHsoi8hKqLiKK4woJLkWs0OtcOws2nDRxd+FuXqIlAPlYJVpuW7wYSukVFI2MAzVd423TYKYx3YXWE2hmTrxgw4
X-MS-Exchange-AntiSpam-MessageData: iKkvBfxR7kSJ/RT6RtX0Sd4iS/xJuolmlcgZApv2KfOHZmc33vkNbEw3HNz2mlByffgPLkTN1fZ6oSeGdFXK3TEVDM3sMPZXSIi0OGtt2MQGBOyrgA0RwScGx8UKhqczlIh13Yy3DkSLhIVaQdC9rw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e761a6-91d4-42e6-89c3-08d7c564a7af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 02:33:59.8664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxPoXqezHZHaRcqjLimUdc6MZto/3HvacLy6K6GAR5zeOpF3WqtOWPRzvbEkk7h/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7e88::615
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

For consistancy rename apicid_from_topo_ids to x86_apicid_from_topo_ids.
No functional change.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c               |    2 +-
 include/hw/i386/topology.h |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ee89fcd1c3..98ee763f68 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1580,7 +1580,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo_ids.die_id = cpu->die_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
-        cpu->apic_id = apicid_from_topo_ids(&topo_info, &topo_ids);
+        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
     }
 
     cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 04f01e2a09..b9593b9905 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -112,8 +112,8 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
  *
  * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
  */
-static inline apic_id_t apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
-                                             const X86CPUTopoIDs *topo_ids)
+static inline apic_id_t x86_apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
+                                                 const X86CPUTopoIDs *topo_ids)
 {
     return (topo_ids->pkg_id  << apicid_pkg_offset(topo_info)) |
            (topo_ids->die_id  << apicid_die_offset(topo_info)) |
@@ -165,7 +165,7 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
 {
     X86CPUTopoIDs topo_ids;
     x86_topo_ids_from_idx(topo_info, cpu_index, &topo_ids);
-    return apicid_from_topo_ids(topo_info, &topo_ids);
+    return x86_apicid_from_topo_ids(topo_info, &topo_ids);
 }
 
 #endif /* HW_I386_TOPOLOGY_H */


