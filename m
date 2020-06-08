Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076FFC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 20:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF06820760
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 20:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eCt7TBcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF06820760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiOGo-0005zL-2v
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 16:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jiOEz-0004WC-Ou
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 16:19:29 -0400
Received: from mail-eopbgr760075.outbound.protection.outlook.com
 ([40.107.76.75]:58241 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jiOEy-0001UJ-Pa
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 16:19:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNxySnGU1oOPdf9RXcKge7FqnA1I51iCCEwlUMs5aMN0URJ95HH3DKCoMnFvMveXGIarKavkCmYtC4olItk96Q/L8geeZcTKWCdOhASs27Vox+ioz9f/g9RMmcbAsReCoXlrxwRk5znoo1DKU8tob0NCjgIhNAM2f8GbvH6KPLjUYrXTAjFt62/yKO/Rp0ogX1yyKetDN/f7Vd5fltG1cnHTPYJg8hn0t2FleC+tX5i67XR4eRxDzCaQEsFJ/VAmqpnQv1QCm/4OvBkFwGT5lJb5UFRhURZSb164ZXja0nRhIlschsE5VzSyJIfxyhtpM0axk/8Zaz4Kd3ILVDgKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN4EFUMJXJfNPOYYBkwA1M5gVO9GFfhGzmTYKjbbgxA=;
 b=Y7JUciQPHAgl4NA19hfOt2ATsQBUmBxd3WuSUSlU5XtamK8pcFId2YIGTzD2HrqcXYVPPkXLeYunzwByxt/mXQdqpRO1rc+z2XJOBtbegUJ54P28cU6LmACwPsl8Vj2obW03fS4RV2+TMn2nqUvBhy9p0eTWbI9j9YUPkD2IukfFIB55i/NfwA0eduodRdt2r92EGIf52K5ULy6U7LOKy5A/702qR5qyr2C9lTD7Eik1guDYQVQd6r9vnLHdFrbcokYF1j1sbvxUMtnFYKXlSNqJQCaYShYjJnWHDwbr7ZRyGmOD+3U6Sfd7TqR1Jml4sAXvB7d9yPdlTAEI5EaaNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN4EFUMJXJfNPOYYBkwA1M5gVO9GFfhGzmTYKjbbgxA=;
 b=eCt7TBcpvARjBGFeUtY4ufjEABIcFLty4t0DZdMhqWd40buIMjWloe1bWot34PZ/BA/Iku9zoE4CIwW4oVdmZTp45j9xx8hLR3N54jNGfey/yYWKzS/bfXxXcJbfgUzjeUyh30gc1K49oomLf5SAM/pTeH/TWDtVMLDCLYiTt5Q=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 20:18:51 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:18:51 +0000
Subject: [PATCH 1/2] hw/386: Fix uninitialized memory with -device and CPU
 hotplug
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, 
 marcel.apfelbaum@gmail.com
Date: Mon, 08 Jun 2020 15:18:50 -0500
Message-ID: <159164753015.20543.7987300339811704895.stgit@naples-babu.amd.com>
In-Reply-To: <159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com>
References: <159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR08CA0046.namprd08.prod.outlook.com
 (2603:10b6:4:60::35) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM5PR08CA0046.namprd08.prod.outlook.com (2603:10b6:4:60::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.20 via Frontend Transport; Mon, 8 Jun 2020 20:18:50 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6179b8d3-cc77-42b0-17e8-08d80be928ed
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB257305D47B024CFB4E1E39EF95850@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAcByDH8Hlafi8eWP5YdM/xpIxkLhlslX//UWDqceXY0vvn+6nMiXgZZA1qVmU6VHlbKN1WgdQa82eypWWT0uOBm1on2twcl97llXYzQ6zYZkq/ZYym2LA0AsSORxR7fz5F5SmYgyzCtPlvtJPUH8X4atUEqlosxUCeOg3Gey8h5EZP/EkLW8i2o7mtDsn4ziitsHses0RaXs1lyqus92d66tX2wr5pfWdcc3pZVwprBxGjUuvRzz7EoYP526I9nzS83pNB2grMVU8vUlTafIp1jDGWUqAz/RK3cpifN9D4b2XiC8qaWM6gCEBM8J2G8Lm2sREn5eTOLvjiN9uzzSPu4/axtaBfffTRZphPsCQuHlXVa4/es152wrSkh56ZZlsiu0P9vh7wMFiq2Ncn8AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(956004)(66556008)(26005)(8936002)(5660300002)(478600001)(66476007)(52116002)(103116003)(4326008)(86362001)(8676002)(7696005)(44832011)(83380400001)(966005)(2906002)(16526019)(186003)(55016002)(66946007)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dxwchHKWaZRtwPLtcqNBS/AkpgywfXaNJy2uAzMBvogWVls1snNySLox20KRyv/lqSGuPJQvI8zBTbZabNPXK0cwB496Ud4vEd1EdwhKDL9LAswJmx62Gvb4McHBtXVAjOXjC9c/LAxG7JjONuPg91lgcgsqHad/GQpXLaPyHYQMpAsXjBnW5FzGKrXMUbZqvZeCjY5Vud7f8lZRs0+gEI4PjbAdbh/kvakH/SWxXhfzQF1wf1m2PIPQ3+5aqhV1QyTvhvp8jlvTEm3P7SGDLPrlrWPyAOAZNLRkV6+FBL//gKK+6mnqR6zy0vmhkIZ0vR4188IllZ1L04PlhUJcQW9j9N4P6zHN7HVIeyDUtZ0FbdpG5z8vx812BWYuM9CMdJN0Eb8m5xyX1yoaalIzxcnk0ordrtj6M8D2rugnMxnQl1Lh4dnAQG2w9tPxIUllCsCv+qhLVuiIKJIUaJfPlYxQQysmy7NRLBg1o73xrUM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6179b8d3-cc77-42b0-17e8-08d80be928ed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 20:18:51.6196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inRz4PB3NXQLsQ+Lrd+VMY60e04+VugZcDONG6yewVNoHuIJRNxue2PRenaiLZ7q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
Received-SPF: none client-ip=40.107.76.75; envelope-from=Babu.Moger@amd.com;
 helo=NAM02-CY1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 16:19:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Noticed the following command failure while testing CPU hotplug.

$ qemu-system-x86_64 -machine q35,accel=kvm -smp 1,maxcpus=2,
  cores=1, threads=1,sockets=2 -cpu EPYC -device EPYC-x86_64-
  cpu,core-id=0,socket-id=1,thread-id=0

  qemu-system-x86_64: -device EPYC-x86_64-cpu,core-id=0,socket-id=1,
  thread-id=0: Invalid CPU [socket: 21855, die: 0, core: 0, thread: 0]
  with APIC ID 21855, valid index range 0:1

This happens because APIC ID is calculated using uninitialized memory.
This is happening after the addition of new field node_id in X86CPUTopoIDs
structure. The node_id field is uninitialized while calling
apicid_from_topo_ids. The problem is discussed in the thread below.
https://lore.kernel.org/qemu-devel/20200602171838.GG577771@habkost.net/

Fix the problem by initializing the node_id properly.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c               |    2 ++
 include/hw/i386/topology.h |   11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2128f3d6fe..974cc30891 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1585,6 +1585,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo_ids.die_id = cpu->die_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
+        topo_ids.node_id = cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type) ?
+                           x86_node_id_for_epyc(&topo_info, &topo_ids) : 0;
         cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info, &topo_ids);
     }
 
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 07239f95f4..ee4deb84c4 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -140,6 +140,17 @@ static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
            apicid_node_width_epyc(topo_info);
 }
 
+static inline unsigned x86_node_id_for_epyc(X86CPUTopoInfo *topo_info,
+                                            const X86CPUTopoIDs *topo_ids)
+{
+    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
+    unsigned cores_per_node = DIV_ROUND_UP((topo_info->dies_per_pkg *
+                                            topo_info->cores_per_die *
+                                            topo_info->threads_per_core),
+                                            nr_nodes);
+
+    return (topo_ids->core_id / cores_per_node) % nr_nodes;
+}
 /*
  * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
  *


