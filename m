Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2316AC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E377A20678
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tHPR5lhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E377A20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCoQe-0004IX-5F
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kCoO6-0002TD-Hh
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:18:38 -0400
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com
 ([40.107.236.81]:62432 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kCoO3-0004rM-Tj
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:18:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNH7tLn8KcTsHKWwZLaa5Qe0mBjU0dfWl/ulmIWVd/HnzvfYHG/6YSpAsRsWYM+8hZCTNk0zIt17+Aq4u/EcDrogLhK6005m5tvdo6EO2o6ijDpQ80QMXdi0Zi/ywBAm5OCcvN6XIXEZcT2xrdI/ejzlpC5AAM9qLjsIh3MSXGRo1CvA5v6TU/LUfHvYpyi1untvHX3eCOgSF/7pGvONYGEqBrFIeD+llZrFyVTYNXLu4jE+SvFhlcBr9vw6B0ayuMJ6zFjaIAU/pCPLutNbEmhVN9Bzhlm0i6U/h1hRZi/2oUSqBjbmi41EwgwJSp1xDv8npqYkfFqUcu1tReF2ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iq1tRS1HizzUVL4opWeMhxqD+m6k+VbxPAPr6tXgKM=;
 b=AB8mR9I1N3GxJ5noflJN4NX/9etXjLalxKGmtuWua6VvJ1cj5CDkz+VX16NbFa/4+E71QF3Fi6rgOyRfb5t7BFgoBet7Gpi2HRElVJhvIdyUTqIepZf/3yX+T6UzbHz5ROoeQgMv5zjdNhJ+8TjQKTUzVzok6uBVKIMk/PGj/v5+meBjqps7xdv6hUo8vvxET7DoT02cUTeLlNxqOeosP6+imN5lW/gXiT++dq8Z2QcU4eehL8kqJpA2IWxc77XJxx6R5YUOuH0iWMa0eE588gBZXw/j7El+2l6f5vY8vGaxB77EVZnr/vvEMY/Tx3DVWcCLnON9LbcJtzEAU4W87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iq1tRS1HizzUVL4opWeMhxqD+m6k+VbxPAPr6tXgKM=;
 b=tHPR5lhxjCUQkX8gEzN+SQH4id/y9U23NFdlN5aAD2swkNXgsWVvDnXa1rXYAzMp+G7yFkWoKMSL8PvjxQ+UJM6IWUvGrZNlQUedq3E4MFbm11LQZ2Ag9Ew6P6XI8zEYANNEiKpSl2TIF2KaK+fXoizQ/10pfBl6Ka9qcHOjmo4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 18:18:33 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 18:18:33 +0000
Subject: [PATCH v6 00/10] Remove EPYC mode apicid decode and use generic decode
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Mon, 31 Aug 2020 13:18:31 -0500
Message-ID: <159889789019.20938.2058841590323655989.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0015.prod.exchangelabs.com (2603:10b6:804:2::25)
 To SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN2PR01CA0015.prod.exchangelabs.com (2603:10b6:804:2::25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 18:18:32 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5de62f7d-7321-4892-ce8d-08d84dda451c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4477DB6D566939E8B608B53395510@SA0PR12MB4477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1cg5WRH42YgNyewnIsBdRjjlGXlQO39ve8LJnOoqlDnBcpfuTENig/ln+siQpAaJZB/vMtTfyXsVdHrMMiM0u/Z/DNVxuiNs4aFKroikmKa8WFls6m+q08PShW3ZzQU/YAxENX8LaeoAELzRrybTp32ymTZlnfqjTZELXwHGmzUDaRaqFP5uL3/9RXbocOe2skZKNhgrA/BNsn2EXidsyfwik3MqNVvE0ygoNRy5esZ1rv/aqp2wb1e8IJWFihkyXVYO7pvb/el23CoZB4iRsxa1OAqRpxedzdbbikFQqq49To2HnwYVob82yrmyTeJVfd8NGh9QNa7a5TqaeD6W0mRBSqZ/DFZ3tfbeinZWPZG6ZAojo2BUyVehd566FM4YWbHOUDbeC7iv+tyvpguCfyr3xJXfDza1ntyxcsfDQoJKqMbOq72LDnpM8nJudNQDRatFpiId8O5v3iY5S2lFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(8676002)(2906002)(44832011)(86362001)(5660300002)(8936002)(103116003)(16576012)(316002)(956004)(26005)(478600001)(4326008)(186003)(52116002)(83380400001)(6486002)(66476007)(66946007)(966005)(66556008)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 99FTmH4pr2q/XZOy5wdqVxYz02PsBQenrsRyM2Fg+yByQXLZziD17UpaIzADkVlBtJrCn2r0LM7600PsDPT9K3ijTrHUUnqDfaQQ2DRo3N3D3Vl1WTQJwc2hqDdwZ9CEMwjKbNin8gIf2nfpOu7FuzPhFVSAcvLMSJeil+ayjRflXSnLZcPC0gcAsSKgRcBqDXGXwl0EkljAI1mWwlJrt3pEVGHx3kwNuYVlt/sJMN5CoFu8fuDbWOwnntxXpfdglECG3cEb3vUQJ5u465mR7KsSJcYSi6Ht5EZ3uS9+aRFbWbVffRo3EYtuJJ8qVYH1gutSFewqL2RQnZOM5gmZdenZY3nrBAkJfcFP9CrO3aaPLw2h4lUBfE4ZV5a4+t9RTw+Q75sZTPlOcME5DLlI2IDkp2MpPoJIjtMgNKr9ENReXme4QwA56RQhGgr+0ecViITc5RLNdW3+G6oRlJzOFt4paYP9OauTd10pPAxR+2l2a5WwcyBn6ue+0JxvZGVkXO8fD3EVbT2Uq8NMVRMa4Hb3YmsCxAxrfAMqUefrWb0ks0CeABwIoe4RSyAmDDhzmiIdTSDwvkxTvIyhmaoh1Lo9MUnIKju2ZYDgoC+lxE6uAX8zpns6ija0XCYXP5+h5mR5zzcA39oHJhmyCxR69A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de62f7d-7321-4892-ce8d-08d84dda451c
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 18:18:33.3088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEfl4/bCzaCpvqcDTDqtjVb/jmoo1R/p62jRzD7CwfGLeqkVZGNk1peDH4d9r4iD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477
Received-SPF: none client-ip=40.107.236.81; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 14:18:34
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

To support some of the complex topology, we introduced EPYC mode apicid decode.
But, EPYC mode decode is running into problems. Also it can become quite a
maintenance problem in the future. So, it was decided to remove that code and
use the generic decode which works for majority of the topology. Most of the
SPECed configuration would work just fine. With some non-SPECed user inputs,
it will create some sub-optimal configuration.

Here is the discussion thread.
https://lore.kernel.org/qemu-devel/c0bcc1a6-1d84-a6e7-e468-d5b437c1b254@amd.com/
https://lore.kernel.org/qemu-devel/20200826143849.59f6970b@redhat.com/

This series removes all the EPYC mode specific apicid changes and use the generic
apicid decode.

---
v6:
 Found out that numa configuration is not mandatory for all the EPYC model topology.
 We can use the generic decode which works pretty well. Also noticed that
 cpuid does not changes when the numa nodes change(NPS- Nodes per socket).
 Took care of couple comments from Igor and Eduardo.
 Thank you Igor, Daniel, David, Eduardo for your feedback.  

v5:
 https://lore.kernel.org/qemu-devel/159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com/
 Revert EPYC specific decode.
 Simplify CPUID_8000_001E

v4:
  https://lore.kernel.org/qemu-devel/159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com/
  Not much of a change. Just added few text changes.
  Error out configuration instead of warning if dies are not configured in EPYC.
  Few other text changes to clarify the removal of node_id, nr_nodes and nodes_per_pkg.

v3:
  https://lore.kernel.org/qemu-devel/159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com/#r
  Added a new check to pass the dies for EPYC numa configuration.
  Added Simplify CPUID_8000_001E patch with some changes suggested by Igor.
  Dropped the patch to build the topology from CpuInstanceProperties.
  TODO: Not sure if we still need the Autonuma changes Igor mentioned.
  Needs more clarity on that.

v2:
  https://lore.kernel.org/qemu-devel/159362436285.36204.986406297373871949.stgit@naples-babu.amd.com/
  Used the numa information from CpuInstanceProperties for building
  the apic_id suggested by Igor.
  Also did some minor code re-aarangement to take care of changes.
  Dropped the patch "Simplify CPUID_8000_001E" from v1. Will send
  it later.

v1:
 https://lore.kernel.org/qemu-devel/159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com

Babu Moger (10):
      Revert "i386: Fix pkg_id offset for EPYC cpu models"
      Revert "target/i386: Enable new apic id encoding for EPYC based cpus models"
      Revert "hw/i386: Move arch_id decode inside x86_cpus_init"
      Revert "i386: Introduce use_epyc_apic_id_encoding in X86CPUDefinition"
      Revert "hw/i386: Introduce apicid functions inside X86MachineState"
      Revert "target/i386: Cleanup and use the EPYC mode topology functions"
      Revert "hw/386: Add EPYC mode topology decoding functions"
      Revert "hw/i386: Update structures to save the number of nodes per package"
      i386: Simplify CPUID_8000_001E for AMD
      i386: Simplify CPUID_8000_001E for AMD


 hw/i386/pc.c               |    8 +--
 hw/i386/x86.c              |   43 ++------------
 include/hw/i386/topology.h |  101 ----------------------------------
 include/hw/i386/x86.h      |    9 ---
 target/i386/cpu.c          |  131 +++++++++++++++++---------------------------
 target/i386/cpu.h          |    3 -
 tests/test-x86-cpuid.c     |   40 +++++++------
 7 files changed, 81 insertions(+), 254 deletions(-)

--

