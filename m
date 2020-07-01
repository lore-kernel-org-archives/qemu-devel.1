Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E02C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B1920781
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BtX27uHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B1920781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqgdP-0006vv-Vk
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 13:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jqgZu-0003qU-M6
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 13:31:22 -0400
Received: from mail-eopbgr680081.outbound.protection.outlook.com
 ([40.107.68.81]:64518 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jqgZr-0003Sq-O7
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 13:31:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUBllgLGKwOa/bJ3QLeuad/tpn6ZfsuDRQxxC9kAKLgTK2UMx3wSvXoGeKr4+wBkD5GT9Pudt1X67rMiIdlNbMgzaUbvcWvwZIWpgmr9DmiC9Gwb8hkCz90mK9n+pA9WNINTnn5Pa08XEDA/0mGHWFWysWVnLol4qQ3gUmMRH37ieEAHW8LCUvA8MvXMrH02KDMqQXVr/SK9giEc3K3i8+3bQ2RZzN0QUqnuBVHLDKKfdTU87/mGDXV6pMcixzSIokZQ6xXYPAyQs1tG0gx+bAT0Zu3zTS4UTrnU4lDdxe7EGzbsLnZRe5vxVR1We7vbtf4eHhqFw+LRZukWQc5Q0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn61hmSRTCU5uZewbjT73+TkUTdmzhnvgwrB2cJyfhA=;
 b=g+qXvpZTch6DQ2mvldC+1FXKrixkdJBo9i3qKR/hPj0tKUiHLAcT7hVtvjU82f6h+ZMcSQDA/4MEioJj0B5whmeSEILD2VzQ+CyT2fvSqAzHe4HrbPy7CKWlLO3R9Nalt8MroupiyqZ9n2oqM95+DLhhQgiDwequ+Xsj0ZhAZNMmZR5uirnOO5G7Q9N59MrRQPcKdcTSWZcyBrTTvvaQt1Jl8Gj7GHEDt0FwiLZ60JbcNc0YpO0aRiv9c4J5iWD6x8ZYVZC1/8MaKcHW5wnzKTrndr0UaSgK+4ghPE71HRw8vJwilQONqf0RIvXYINQBNK+GiafAn2gOQQEOX6287g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn61hmSRTCU5uZewbjT73+TkUTdmzhnvgwrB2cJyfhA=;
 b=BtX27uHn/BMYgVSrcqHK+XGlff60IXB2fDwieeZaegB3VWWQzz1QF9o/KuCswFUOTcA5UG1G2A4IJIdN7U4Hnfj3lWMhPDmO+BMW8gjOCe9NNVsEUa1TsbvY5bePNqswdSxvH4GCRc4QnpcHtoB6s4xfS6RJRML7UUI7O++2J0I=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2556.namprd12.prod.outlook.com (2603:10b6:907:a::11)
 by MWHPR12MB1278.namprd12.prod.outlook.com (2603:10b6:300:10::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 1 Jul
 2020 17:31:17 +0000
Received: from MW2PR12MB2556.namprd12.prod.outlook.com
 ([fe80::9c8e:f3d8:eb8a:255c]) by MW2PR12MB2556.namprd12.prod.outlook.com
 ([fe80::9c8e:f3d8:eb8a:255c%6]) with mapi id 15.20.3153.022; Wed, 1 Jul 2020
 17:31:17 +0000
Subject: [PATCH v2 3/3] hw/386: Fix uninitialized memory with -device and
 CPU hotplug
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Wed, 01 Jul 2020 12:31:15 -0500
Message-ID: <159362467562.36204.11074523095942812006.stgit@naples-babu.amd.com>
In-Reply-To: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
References: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:805:66::17) To MW2PR12MB2556.namprd12.prod.outlook.com
 (2603:10b6:907:a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN6PR08CA0004.namprd08.prod.outlook.com (2603:10b6:805:66::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Wed, 1 Jul 2020 17:31:16 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d137408e-5691-4b00-b7f9-08d81de48fa0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1278:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB12785810024AEBCB42A10834956C0@MWHPR12MB1278.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNh21ofYCTgKpQHaFus2+NTklSGSv/Nh2uO7FhGm+oLID6Xg9vrr2/6QC4Ue11MIWPHwTAFU/b3i8+NTHQIsNyxVPnkQLxC0IcPHBZBlbVHuPK9BDBwXA1J3WWNUMWY3F4oq+qUVFfG+/xYKn/BzcOHVh8G+tccoeynWzP9BUi8/e8r4qFGD42s6cSGwAcY7y1TKslm23yfnmmRwL5lvA40QBujpLVtVQmTTbiJzLadn+Xu/D0Y+uh0eed8kM9hUoeZQscsRQ6ApFoJi3enjDLUPgF0cutV1Wqf+pk9PD3TobmlE8d8VZu5N8pwr8quHM+rgCVS+RZtsyOtnTTiGj0zE9hA+FWJvUE0tUJSIU1VFVtYfaRcil7pM4ySJ99//JmVSM/0bSO8hZMGUZWBrCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2556.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(16526019)(316002)(8936002)(8676002)(26005)(66556008)(66946007)(66476007)(55016002)(5660300002)(966005)(83380400001)(478600001)(2906002)(186003)(4326008)(44832011)(86362001)(103116003)(7696005)(956004)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: eo6bxilfqT6pWyeTq9LVASSlI5hhswHAXbdksFA8GndYb4UCK3bGUX1jIApcO8JREV+a7EwNeag0OfaizdUEL384fwO/iE6v7xe3ocwbFLjKr5kiVUWLoMN87aL6K7cY15ztmAFnKl2YtnbKyb9Vr7ywVAhOZZ4S8BU2SLGRODEI5svfWx3NwC+VmtNc60lytdbApHtmz3Ip2rnH3rOXvmoPtxLWdqKaAY15oWn3BzKU49Ho0ryZZnPqpzWZtcdMy/KkeCpBJmw5Njy3Os6IKHB0jRdPSuser5cVO80SuEiqpwt+AmsEQ7wg8delBa2b3EN0a1irpsP++ThCnLjzJ/PYm3h/1Xvz3pMx5HFpbsUy7tJnszkPHaCDF8D9bHn8rUtbNtg5J85AoO62H8RpD1VzYdS590FPGyNvzY4qZU6HkA/0jBreeau0C/Se+ypkCgv/Ag4sBhvleGy7oPKyUDCqXMxzZG/C5+1O8+Ai3qs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d137408e-5691-4b00-b7f9-08d81de48fa0
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2556.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 17:31:17.4007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJbceUs3FRYw+gaz1B/v1AQoKN3wEljbYwxZwtRq0Rs8MJOruy680AvbAJmycVO1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1278
Received-SPF: none client-ip=40.107.68.81; envelope-from=Babu.Moger@amd.com;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 13:31:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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

Fix the problem by initializing the node_id from the device being added.

Fixes:
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1828750

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e613b2299f..aa9fb48834 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1553,6 +1553,15 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
             cpu->die_id = 0;
         }
 
+        /*
+         * If node_id is not set, initialize it to zero for now. If the user
+         * does not pass the correct node in case of numa configuration, it
+         * will be rejected eventually.
+         */
+        if (cpu->node_id < 0) {
+            cpu->node_id = 0;
+        }
+
         if (cpu->socket_id < 0) {
             error_setg(errp, "CPU socket-id is not set");
             return;
@@ -1587,6 +1596,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         }
 
         topo_ids.pkg_id = cpu->socket_id;
+        topo_ids.node_id = cpu->node_id;
         topo_ids.die_id = cpu->die_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;


