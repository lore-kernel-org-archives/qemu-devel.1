Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20462C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 20:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2D42074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 20:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S3IwZQPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2D42074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiOTl-0001fV-5S
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 16:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jiOSu-0001BX-7r
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 16:33:52 -0400
Received: from mail-bn8nam11on2055.outbound.protection.outlook.com
 ([40.107.236.55]:6034 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jiOSs-0003eh-OY
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 16:33:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etSuQ0yNFZWj1Semb7vBvLVCAYhZ3kMGS9tPzJpZN0U3+xq+13tT85BoWsWD92s4MrmkCsvNo3tAtwBncD4jWu75zggIiT47xe7m45/aDhmObtjIR0o/FkqdsvECK5gdcIF0yzLixt5yqliOWK590Z7VWfRcob8gNUyVbTn4uybxi7ItjoEe7rBuWleO1xXhLWKh9Ghr1TLGnIs9qHBAh4O6iLnhpR2RLj/q5HHbRIZSzBGCzcIhEkQ+kROBUhbRPle1ANxvI1XCeYZVXWTqoRO8KjlizGRkFO6+Rv2PkfTaoxcWSe7TUxB6GbcZeA0OFUNHZ13bp11NrCaJUv79cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRAEjfjZ2Y2ag3aCGWfxHEIQI9Rg/dKws4LAl8pH4P0=;
 b=UKJ1ZfCiV2dZy5esKOgNBKu5CANx7MAZHCYODy9o1nvCRG+17LFZ3QMush/VdItIcSJjtwdZYfZn6f0FS+B7nylMYS4iDkdZQdMmlQxQHs3xZDFF04aDirUgUscH1A4N6KTwSzsvrZuLWSlBnmrLUJVKmwcwhc9IiKTfAQa2NEHiZ9WVdfkgq3C46XUnEcka4D33Vh5seF95qmeMkj8qCHANBfzs2PIADrXXhpW0IUHmcJRfZclL3NbycyL3IZPR3rjAkUzHLYNhoOW0PDbLoB3cBjVyDSv8+UAS3l1HG7zEyxf+q97w1m0/VsBzM99gGEXKbuNSktWvsmygryzBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRAEjfjZ2Y2ag3aCGWfxHEIQI9Rg/dKws4LAl8pH4P0=;
 b=S3IwZQPd15qFxbtOzfpMudKHxr6p6dRULF/g84Ex0AHDdzuFbQWEUmh8FOZjwAiVIFnnCW9Do/yyoMi9rRUyRruWCKD+OOKmjXS6itAm2G0BayXOsftwKmoKfW7qdp130Tqx0qF87L9ScXGjXdgLJNCf4UKfWdslo+jc+OAdM20=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 20:18:45 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:18:45 +0000
Subject: [PATCH 0/2] Fix couple of issues with AMD topology
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, 
 marcel.apfelbaum@gmail.com
Date: Mon, 08 Jun 2020 15:18:43 -0500
Message-ID: <159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR10CA0024.namprd10.prod.outlook.com (2603:10b6:4:2::34)
 To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM5PR10CA0024.namprd10.prod.outlook.com (2603:10b6:4:2::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.19 via Frontend Transport; Mon, 8 Jun 2020 20:18:44 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67fbfd4a-6231-45d7-cde4-08d80be924e6
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2573AEB5C151C62308049F2295850@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cBe/48R79EVS6rJ7r1dw4D88Cw8Wt5Fg3RIwJ/l5crf9m40KDqjk5r5tY2gXd4qyw0dXowVlih5K5fnJeWqEf7Mdp0/dSm6+FfApxGJuVu53B13XmzHXsITPC+2iq4rmhEtH6phXdpG8ucEfSenHot5dJLlYWd5qpr+ilMOHjUGr4TKZYx83VzlkkF76UAnr0GFCqwSYiB+dpx54PutfZoDVXqpfCGKjgnBP3L+0J2hANvYeS9bXsxGaZ7IELQ9n3UdN9EviPGporr4wKXynGmUqHbjy0skLS1lQUq2Zjx9Y/OSEQGUNjwQIrm4dskwiUu4B5iq7GwVfCYd+Q0W0CxMdfqtT/HEC/6qYIXIPZTPTVw9t/FF+PbI1wPdso2H1V+FYZD1WAvji+aHMyAU1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(956004)(66556008)(26005)(8936002)(5660300002)(478600001)(4744005)(66476007)(52116002)(103116003)(4326008)(86362001)(8676002)(7696005)(44832011)(83380400001)(966005)(2906002)(16526019)(186003)(55016002)(66946007)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: aCTG8bmkx80Zr8YHj2awj7l7GczlvYEmgHqpqJrM1XygEETqbKdFESfGVj3Prj3jkdX9DBfhgDRsBz0HvFKe97nlCj0gxTqGXzdyT6SdkWDIW6Svu+Abk8hzswwMOlnHzBUmJ6C1b9s/RHyQFFvlSemkIQBLvESgwd2k7WYI6hC14RTkmpjpWY0xUTotPd+4kS0wClP655zlpXHmuBQOBstqywltTR2dZtMvSOTcMxgF3qE9mFar/1YDaBJEpzoMz4wGuZSsLPR4xSDekyJrPWt1Nx1coOb2oQhn16Edr0j9b2AC1A8bWGxt3pY5+o9yFjELIBP8oZO/4YsO/KbPk0tPXMM6w1t1yW7vD2naphuQb68DzPbBG48Clq0wu6LKv6L8e+tisJA/p8R3IlUqxoKdQdC0Cu2JRvw5QF2q4sKAkPGUjadE480b6e0pEUIQkyE2KVliNd4EQdQpVp784LmwTge+ZunGQCnN1Fod1Pw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fbfd4a-6231-45d7-cde4-08d80be924e6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 20:18:44.8985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyfh4P6FZwMUtR+2iJDf3Qf+6UYl87lv5CNfF9x5hPkZk5vgUT1Bqmds3qm6N1R7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
Received-SPF: none client-ip=40.107.236.55; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 16:33:49
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

This series fixes couple of issues with recent topology related code.
1. Fix uninitialized memory with -device and CPU hotplug
2. Simplify CPUID_8000_001E to generalize the support for higher
   number of cores and nodes

Here are the threads discussing the issue.
https://lore.kernel.org/qemu-devel/20200602175212.GH577771@habkost.net/
https://lore.kernel.org/qemu-devel/20200602175212.GH577771@habkost.net/
---

Babu Moger (2):
      hw/386: Fix uninitialized memory with -device and CPU hotplug
      i386: Simplify CPUID_8000_001E for AMD


 hw/i386/pc.c               |    2 +
 include/hw/i386/topology.h |   11 ++++++
 target/i386/cpu.c          |   78 +++++++++++++++++++++-----------------------
 3 files changed, 50 insertions(+), 41 deletions(-)

--

