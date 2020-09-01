Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41733C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043F620767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JznI+4Tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043F620767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8fm-0002Sv-4K
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kD8f1-00012N-84
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:57:27 -0400
Received: from mail-co1nam11on2086.outbound.protection.outlook.com
 ([40.107.220.86]:25473 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kD8ez-0003YS-7U
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:57:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OF/3LlauoBtHS4b2lMCXojHX6m+SLY9AloID2lh+u6lqidoRBMyAlHGFPYiX65+AInPVAaLRD0B/H4GUG1KdOP+Lg8bHJR5ZY+yMcG35CThNtIbq86F2W8oz2GdgGbBezlqO8eAvG18PeNaAqHiUBBc1aoaBgmgl00/hm1zzk8MSDW6fjVrINEIJpd+DkPrd8AgSvR1RKnxh8WXrbjabMIubqmjrFcmAGOVPYtderdY8x7XHs2+JqCN0DIp8o5xVO91CS1HHxtyBvIKuwehx9blZ2rmkZ58TupCnDGMkJHtGE0iBLONPoqkVlRHx+LpvjuR2noSR5CbfRnemmWJMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLT9esZvqBAA3HjD3cQwWN+2eqYMxDqB9ch9bzMj4tQ=;
 b=EfMaEtk+gmI3A8gX0E4deiacycZJu3eah52oHyTKm9hsaYJ9RR/WpugeBCuu4N5L/OcdbBxD7klErw0QMjNWjhoxC+YVUvMiJ93my/RiPKDrJGiBCQWrM7/GG09DwaET+UFOxgo5T+dB5LShEZFiLgG6Q3m4qtVWbCFkaY7K3/bGBi//zCDsuiUDYlxeIrWIJrHS8TXbJNOl5RC+WVXlNvPcfaNqb0aUeOs6nL9tvokPA7Nmy8OAvouIEoi2st/hqu4MQ1AhS5RyimPMG+eI7e/RjIPJrqIvHbkjIRx4wqWfYLyUaH+JmOKOfTG9zf4obR6p3+UOjIlMs6a7oxWPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLT9esZvqBAA3HjD3cQwWN+2eqYMxDqB9ch9bzMj4tQ=;
 b=JznI+4TjpivPVMxqs03edKr0X/TJVXc6LmJZEglmG+EXU3N0yzjZKIQe5qY9ZCBNoN8e/ckYMz2eS0jOhrzm4Uw+xRQqGqzBNiu/GlvXjhTvjwmOrXjZbvbtUJz7TrnFAMnd6r+oyaz24aSdaV8++RjouUvEevIRnSwaTx2Ms00=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB2606.namprd12.prod.outlook.com (2603:10b6:805:6e::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Tue, 1 Sep
 2020 15:57:21 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 15:57:21 +0000
Subject: [PATCH v7 0/2] Remove EPYC mode apicid decode and use generic decode
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Tue, 01 Sep 2020 10:57:20 -0500
Message-ID: <159897580089.30750.12581669374705391794.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0092.namprd12.prod.outlook.com
 (2603:10b6:802:21::27) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN1PR12CA0092.namprd12.prod.outlook.com (2603:10b6:802:21::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 15:57:21 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17fcd5f2-8094-4383-f9d1-08d84e8fb5f2
X-MS-TrafficTypeDiagnostic: SN6PR12MB2606:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26066A69A8F784EFF1765AFB952E0@SN6PR12MB2606.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhvrqgrPm1MDN1ZCfDfD97NyKLHG+BTWrBij8FWHybLrIDwiOpZVl1q6Kfd4ap9Ijss9PfWR1vpkU0b3S4Igd3jzvj4AAML+IurtuecGrmGLC60adjikvTSUz+UEkNQvd8ppl7RU7kZnsqk6b7KyyD3Z/SnM7eiYGtyAdAFcBaF7irSLItr/l5hq/G2xJiPZWkELVtME7x6nCPDDxnYYuCptjUZQxjwmjFvRa6q6SyiDwBjimVg9RpGNRRdXZcq0QdG8zqNr78tfRMxHcyX9Uy8thxmBDhbBFEKv2dRAkkc7xZ6cEPsM9Cs1eMM4QICweTYapGF6vv4Y/JF6I6i2E9iymJd+ZkBjk80jY+Az4R9kPfb1EbSO/CLYHa3sSOroyA1Mbx6nrFE3w8/Yt3iIO8TTs4AeFDRLmka3kDQUCz3vkQv6N9l0PLUTvxpkoSsmG4xvCRzRMQSwhByWQnEg3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(16576012)(5660300002)(186003)(52116002)(966005)(8676002)(26005)(6486002)(316002)(478600001)(4326008)(956004)(103116003)(66476007)(66556008)(2906002)(86362001)(83380400001)(66946007)(44832011)(8936002)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: iVJyPKwK3irkJsFp01xfGAw/wHAqDe6JN5VJAsFRaGPlmLdeJqzPARZngWh+ZNSxJHwnshOVcQOwTzzZUQKkpYZXMMKzdC8vn8yk+pbzLFooBG5eRSK3BO2DFNJ12IJOk0tzC7vZ58WUAiYYQpLE7anSZaU/Hi5OBQ5P6WIo39SkMY8BFmWvCQ9h+AO4BsxlC0RooNrSy2i38wnRPSRnO4vJPwh9JMDjiLCD92f250ScvHsBMhrRyFdhknXwTgF9oA5NLRPqjI3ygsFbn8Ohj91wFrwvp7nt0kT1LBeWAOw16m5K5Iv7siTia5gqRU/pYY+So9JU29ggiPzgO97vDzWyFCbhe4WbSyFqxC7JbcbLjTlBygLfJwawGO5SPakEEoOyfR9BY10Qq7PMrztniGZ30o/GU+hZzS3cuHSdJ2rpH5zoAB1G61Rp0PhZIwxUH9JaByFcucDezAktAOmhxTTThOJOemDwe0FSlGD53H0wEKMq59kqQ7ExDeE0kF458VgpUys7TkAwg+Kh+sCH6HRle1yHY+UmxP2IEz+NFjW/oJKpEzKmKZ5OtDH0jd0WoSTtrBGh7/PcslKbHYJgHzJYSJyRwOMd1JKbw2qZMM4nEK8dJAQ/7dZYwxawOM1d2oUbxn/jCTUbuOtciFdWsw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fcd5f2-8094-4383-f9d1-08d84e8fb5f2
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 15:57:21.3714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNH/Dv6+/B6OKcTcWI+xPjSOhs+1tcGxdRD7ts3Jp53M0K+JHX8RDzbSGMaN6Mve
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2606
Received-SPF: none client-ip=40.107.220.86; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 11:57:22
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
v7:
 Eduardo has already queued 1-8 from the v6. Sending rest of the patches.
 Fixed CPUID 800000ld based on Igor's comment and few text changes.
 
v6:
 https://lore.kernel.org/qemu-devel/159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com/
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

Babu Moger (2):
      i386: Simplify CPUID_8000_001d for AMD
      i386: Simplify CPUID_8000_001E for AMD


 target/i386/cpu.c |  226 ++++++++++++++---------------------------------------
 1 file changed, 61 insertions(+), 165 deletions(-)

--

