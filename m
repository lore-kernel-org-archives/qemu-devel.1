Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D9CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B227820781
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="flJDgnFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B227820781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqgpJ-0005WI-Vo
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 13:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jqgoB-0004Bg-5a
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 13:46:07 -0400
Received: from mail-eopbgr680057.outbound.protection.outlook.com
 ([40.107.68.57]:64321 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jqgo5-0005pw-Tz
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 13:46:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyBx+yLkJtVhe3O2p/67ZHK7Ap+2tkyzhSXlglqB5EsOnsKrhfuHQtAtZd0Kr16+p2K/RFVsAmLiJfxf5NDn55+tdispIi11cHLz5nhanAXNUruWHzgFIyi3eNplKju4zQrkFoVZ07AJMg6gSSvH8Hg8H+1htt3OE2rne9V4ZqBiVEJZu55LMniUlfqYjFnv8T81CbiZ0hPk6ZX9XBH4R9+5WqqHm+mN+tUySkuWryAa/YIKUqamv8CiTNXnIJmQKK9Lo+dw6PIDQsKZITZdRi2ZCidXFP2SV6oQ6uzNiVrCNaOBpNr9aFg6tF525sWZ5fQGvqnFXxj9EQ2tY7HMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3at8STXIWeOy6LW95iSOoRexAeB/u9P6ien6UJOPak=;
 b=IQmu4yVN4FwTHuVzoOOxSRpg3cM3lo2jARFHsa7jHnaI33PxjZP7fXTT8PP+VPaE1t92I3JzpxKxCgwLzfye+uPOnADdOSX/yyzsdwnQBjQcA0HtBF+7WhT6clXur9FKgWNaOgaMvqKp3PlrSkRV7cf9yv1VU9ItTSeU6pukx0FD7KWxOxiZ09huNj8gwDIC36hRhki6uSSjjp/3RNHp3yoZqk1TuXCx6K9ich/0WYKJcN29//XRi9jPjIEV0mUZo1pl348Y0sShgzOevdihNLDMDfwXxA2TyJSdomIUjpJq2ak+YLqb3oJxxb7v3/TnyE33mU1dDg9ZXKmXPCd6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3at8STXIWeOy6LW95iSOoRexAeB/u9P6ien6UJOPak=;
 b=flJDgnFV6QemsFH20+WQ6zLyfe1lbwqDhr8o/N3t0jMCatMVkyiBdJKmfS1DJkUkugolPechhu6vDR+OBm9n+jovnDr4Vj6TAPLx0OysarJlcQt6zADU/ClJsCLGjHkBp/sgG2s5s5ExFfNIZnmFk2CGhO/Trx2P9ywElqv1ipc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2556.namprd12.prod.outlook.com (2603:10b6:907:a::11)
 by MWHPR12MB1342.namprd12.prod.outlook.com (2603:10b6:300:e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Wed, 1 Jul
 2020 17:30:56 +0000
Received: from MW2PR12MB2556.namprd12.prod.outlook.com
 ([fe80::9c8e:f3d8:eb8a:255c]) by MW2PR12MB2556.namprd12.prod.outlook.com
 ([fe80::9c8e:f3d8:eb8a:255c%6]) with mapi id 15.20.3153.022; Wed, 1 Jul 2020
 17:30:55 +0000
Subject: [PATCH v2 0/3] Fix couple of issues with AMD topology
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Wed, 01 Jul 2020 12:30:53 -0500
Message-ID: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR15CA0068.namprd15.prod.outlook.com
 (2603:10b6:3:ae::30) To MW2PR12MB2556.namprd12.prod.outlook.com
 (2603:10b6:907:a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM5PR15CA0068.namprd15.prod.outlook.com (2603:10b6:3:ae::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Wed, 1 Jul 2020 17:30:55 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8da4a4d5-0d7a-4be8-e608-08d81de482b9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB13426C5AF09BBF12E12DF8C5956C0@MWHPR12MB1342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1YPPVow3uV06Hi4/KhxC/iIzqSheEgS4OD38YgR9UShf3DBPoLLV7+VILIMUf5Skutd+AUikagC9guCF7ACv/2OTgAfxx52C7oRUv8HM236WxNEgx/lyQOrSBfaYL5OI4jYzpxl5ReRk1eAeiHA2aCT5S65OhJVR/EfXj9DhGgG86UoQL2dazd0b7zGTWLQcgQsOxq/dWMyEdGPELW/XQQwGB1vp1WZL/sJxGzkZ4uGYnrqaU0VrU5mL0w3SiJAnwWTwpmEuYibOb3tmhlpKAApTNPfhusVPxm1dEhXzqVmP7PZcsLJjEqFtLgag18qO9KwKmQrL4pinQL8c1wLSAyD0X7rQ33/cK3sAI58oWJ/eUOf20umGM7hwpJklid8ZeVXXx5x7ikyaOqCFtl3eNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2556.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(2906002)(8676002)(7696005)(8936002)(103116003)(26005)(4326008)(86362001)(55016002)(966005)(66556008)(316002)(16526019)(478600001)(52116002)(44832011)(66476007)(186003)(5660300002)(956004)(66946007)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: klm+9IOwheIUtnoR4k9Gj4tAGXZcWIEWTCoWgkM+/AoU7LEQUWqBc7VgRvfmOxNLTNKjrZl9Gp1H2oo/OPotlgdyVDEm5aj5gSzAyjzznAU4hH+A4PkpMqQc9HrBQC0cStnI6Ipr+PGWgT+RJYSk9/wD4NfBjttFmwiZuj4l6rMV7SuDUH5PA9jqDPV0RisPOeQJuwdf4bXK2CEE/caJ5I0kSrrwx6VIhlWR2+mMH0EEo6NN3UiQjD6nOVU6fbcK/yIcVBHtO7sZaTkzAzHSpL9UwgSNdPqC3RD7HJV8VDyxzq2EhvnNA9bEh9ZcMZYiBRINQeAeA1N5PJAioYUeFjrLZu4ZgtVv/rZV16EKxFTb8QY8hdl0NxgEiWemuQ3MbNv0lGi3MhTr5Uplrw1mYpFK0+RmEYhjeWcgMlYGWnlIbCkgZkLbI5HwFQHydABLwgPLgPE7wfQx932nT3RT7eZfi2/RAkT3FErAnSCRmWM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da4a4d5-0d7a-4be8-e608-08d81de482b9
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2556.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 17:30:55.7644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgRJ5zcoki4+7kQ6nfhojFi6PyCSI/XlnF0kqU+vlYaVasWuqM7NOU7oYv75Qo1n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1342
Received-SPF: none client-ip=40.107.68.57; envelope-from=Babu.Moger@amd.com;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 13:46:00
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

This series fixes couple of issues with recent topology related code.
1. Maintain consistency while building the topology. Use the numa
   information passed from user to build the apic_id.
2. Fix uninitialized memory with -device and CPU hotplug

Here are the discussion thread.
https://lore.kernel.org/qemu-devel/159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com/
https://lore.kernel.org/qemu-devel/20200602175212.GH577771@habkost.net/

Fixes:
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1828750
---

v2:
 - Used the numa information from CpuInstanceProperties for building
   the apic_id suggested by Igor.
 - Also did some minor code re-aarangement to take care of changes.
 - Dropped the patch "Simplify CPUID_8000_001E" from v1. Will send
   it later.

v1:
 https://lore.kernel.org/qemu-devel/159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com
   
Babu Moger (3):
      hw/i386: Initialize topo_ids from CpuInstanceProperties
      hw/i386: Build apic_id from CpuInstanceProperties
      hw/386: Fix uninitialized memory with -device and CPU hotplug


 hw/i386/pc.c               |   16 +++++++++++++++-
 hw/i386/x86.c              |   19 +++++++++++++------
 include/hw/i386/topology.h |   33 ++++++++++++++++++++++++++++++---
 include/hw/i386/x86.h      |    6 ++++--
 tests/test-x86-cpuid.c     |   39 ++++++++++++++++++++-------------------
 5 files changed, 82 insertions(+), 31 deletions(-)

--
Signature

