Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A60C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65695222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="my6IOFvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65695222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2JIh-00069T-J8
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J3u-0003eP-4I
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:18:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J3r-0001Bl-Vv
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:18:06 -0500
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com
 ([40.107.223.54]:52256 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J3r-00018r-Q2
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:18:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCWKWSKaljpv6Nfc+VB0Wkb8/BDl32m2+snxXAXtW90LS4eky9QqgIVxNWOiQAI7iSuiz4Kuo4KciDsHhI1ol8mxtSRUbml9wZng2knwmO732V5TMlqnMydIYpaq+54t5dKzgg6J28fj+SX05F+Rk5+MGj0iewLrEJx6s5QZy/Utjj7bsozacTx3081sgDLhchNypBjdvzU8+fnxyFfKL66uiAuvGfmh5iqWRyD4aUKGIaJdYJipVQGMbIdyjA01skQ9joR++ARGRO6jB5kTIPksuo5rdXi+cj+EkB8SX/y3xPIYhCdFn7bIVdgdNgdLL90K0reiPb28pjVaLXx0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tsL/MUJX5I/sqAwLygswH8EhwfKNLXQYS5v4pDYVkA=;
 b=ilMA9e/8qOa318bXu5Rac8nE1LFZd5s6WTBx1AKV1X79QvzVwcuxtc45hyXUXWRViIxrRgi16O5oXm80fCRPQdbnufYtbtebsOIqi3z8p+5/yt+/9HTvdhyBtrx0XIF2a/Iu5zd/M/0Aq7Jr2QVaceftrtHZ88bFm+vI4fGn4AzBsbNuOZnDjXfeUaRqReLmkAVw2HaCjwWwmD0pKz1RXFv5POibCF/JaXA3h/Kpnm8/lMkwRIHCpd/cG4P7N03l12w1wbbdiIQlNOA3QT9pjGcaGUp8XxunVYj8rBTubD1ACGPgbOOQFa5elIHBFzEwZzIWZOWg768AkNFELEdtbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tsL/MUJX5I/sqAwLygswH8EhwfKNLXQYS5v4pDYVkA=;
 b=my6IOFvg8Lnp1H3L/la9zZ69xFyWV3S4tlCWPmM7EPUA0G4zlzH0G2hoGMPNbXmDZrVgAnkf3WdiO4uBfkkkac33GyvFb+/ywdFCAYrdHMdpVH86yKIeUFXeuyHFPm5owJ+QEyQb/ycgJRB2D4jxW6qgUyhmjaUPyD3bvYW2mIw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1222.namprd12.prod.outlook.com (10.168.166.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Thu, 13 Feb 2020 18:18:02 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:18:02 +0000
Subject: [PATCH v4 14/16] hw/i386: Move arch_id decode inside x86_cpus_init
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:17:59 -0600
Message-ID: <158161787984.48948.11401269513856632633.stgit@naples-babu.amd.com>
In-Reply-To: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0032.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::45) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR17CA0032.namprd17.prod.outlook.com (2603:10b6:5:1b3::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24 via Frontend Transport; Thu, 13 Feb 2020 18:18:01 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 662c555e-a083-4921-e5e5-08d7b0b10fe8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1222:|CY4PR12MB1222:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1222B2D71DC587EB0FE9AA0D951A0@CY4PR12MB1222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(52116002)(66946007)(66556008)(66476007)(7696005)(26005)(5660300002)(103116003)(956004)(55016002)(4326008)(86362001)(2906002)(44832011)(186003)(16526019)(478600001)(316002)(81156014)(81166006)(8936002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1222;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJ44Y/Y1k6ETRHolTONzcOcz3MDlvzyEL9/IuBVZn0uK5+s8Z6YqjjEgFZZtlWY6Yyy/5I+tAvD7RtpJ3jAHsMZN7kteAS58aDRXPUj0qT3I2jo8s1wj/Imk1C//wWp6WE8aW09oLEjdkXjwmRnsnwyLb0qj8FCNkzUuqAHp07HUrwhuvOUPT30py5iyoErAdw/BgjM4I5XAheYYnOArh/AThnjxM8yZ08bzL2dSggQlejFS4P+0pkzb8cK0Nu1ZjAA/iiyr/meu8E6UPRklL3+XqjCbSeayMUvf3mbNdZY7yt/YencglIsXDttpInpPkUyn96NGupquUg6TXJFF6I8lEDDIiIts8ZweY57of8FB0v1omGo2zCXwcles2Stz5XXr2FXvlCkiiBAZQAHFhipUNT1WePj8XekztVfPbcXwOGwjPygg/yoVibxZYghG
X-MS-Exchange-AntiSpam-MessageData: rDPsLegkW6VVKhnLo+VY43Zvx47DkSFblIpHznnKiu/2cRU8kOo2STbhHN8ogAvDn4Pp+zLxg8u7EB/PPjBoP7nPcmnAzpbAy/HAd5e4Op2Hx5dGPEbDGa6ekpmUy9e0yeRtbRlch+cZY+aBMHNkQw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662c555e-a083-4921-e5e5-08d7b0b10fe8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:18:02.0105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sapVXe9pWq77rVbWB2A54LHhjSBBeq9Edl0Lj7sAtXXbkN5pO+M6LlhMsWb7p26X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1222
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.223.54
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

Apicid calculation depends on knowing the total number of numa nodes
for EPYC cpu models. Right now, we are calculating the arch_id while
parsing the numa(parse_numa). At this time, it is not known how many
total numa nodes are configured in the system.

Move the arch_id inside x86_cpus_init. At this time smp parameter is already
completed and numa node information is available.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/x86.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index b825861b85..472dc3eb77 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -127,6 +127,9 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
     MachineState *ms = MACHINE(x86ms);
     MachineClass *mc = MACHINE_GET_CLASS(x86ms);
 
+    /* Initialize apicid handlers first */
+    x86_check_apicid_handlers(ms);
+
     x86_cpu_set_default_version(default_cpu_version);
 
     /*
@@ -140,6 +143,11 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
     x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
                                                       ms->smp.max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(ms);
+
+    for (i = 0; i < ms->smp.cpus; i++) {
+        ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(x86ms, i);
+    }
+
     for (i = 0; i < ms->smp.cpus; i++) {
         x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal);
     }
@@ -164,8 +172,7 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
    init_topo_info(&topo_info, x86ms);
 
    assert(idx < ms->possible_cpus->len);
-   x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                               &topo_info, &topo_ids);
+   x86_topo_ids_from_idx(&topo_info, idx, &topo_ids);
    return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
 
@@ -199,10 +206,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 
         ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
-        ms->possible_cpus->cpus[i].arch_id =
-            x86_cpu_apic_id_from_index(x86ms, i);
-        x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                 &topo_info, &topo_ids);
+        x86_topo_ids_from_idx(&topo_info, i, &topo_ids);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
         if (x86ms->smp_dies > 1) {


