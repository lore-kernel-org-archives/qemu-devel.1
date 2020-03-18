Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8846BC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1272071C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lxWwDozD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1272071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEc7Y-0008Ns-F9
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 13:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEc5h-0006Rn-OI
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEc5f-0000pc-Kx
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:02:48 -0400
Received: from mail-am5eur02on0713.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::713]:5947
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEc5f-0000ip-2e
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:02:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0nag3UT/d1Ds+16IIG799ahjRLWK+B9YuwlaUfWgdENkaMkUCchpgfiWipqUh0TquPMB3mAOXDF9ITrfZ/DvAZdynU2UnkpyZUcMYcDHLJIVITuQgrPVaxP+hHy2yO9dHIcqYQBR041HDX9gr6TNPsNnV8Ccf/gBuonU5hKUWX5+Ytn9hUdDkCYQjY+k4sX3fzmAhfJaHEkRW7p6p9+yTIZDOK8Tw1J02sbzO7mrKfKLy93bZQLHzH3DO/HlMcORiPb0BXarWeNnaE5kqMDCksVEDghzFFzquHaKraRR0N5bDuZlZsnAbOw27FcSICU+MIjmjECMDdpMJaKQE80Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg5ar+ehNaWrbJ84xx+aPsd8VPvc588j5QUYY5bOdO0=;
 b=FZrWSDFfTcBjeCPF8fTT3tHlMR1ezzb3rGhFyoKwd+iiq4S7KhHTGtuLx+Gbc7cEIuvVRakOAua+vm/qw0r09O0cKBsgUHRScQYLDE2B8kqwYON1Ga2Ok9+Z2ofCzHuMIGmfhlx4FCkHaVGVAayQOrcPc/xlOBxkX3q8Df053CJjPxUA/kTdO8B8HeaZqva0KnQ7nIY6exfNTEIQat2XMIOcprA3iZGUMWt7fO6c0n73Xd/voJJjjQHkN+QNBROKYiOnnjtDy8YPvsj7KUJQ8su4WLXXqR2PHwcysE77nb238U8U3fV2n8ou5VKA+9v+mSLW2JwnPT8PLfcxHod5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg5ar+ehNaWrbJ84xx+aPsd8VPvc588j5QUYY5bOdO0=;
 b=lxWwDozDWY2pGjdMyy67NMfBV/K7E12lr1PWYM69QrjzAe6xzM8DvpfWTPmfzZ/85/kG1vrtmNYeMyM3vqdzgnAScgF0KC0nM4e7a8tQQD6eCezanD10fZZ10au9f7NTL2vvN+LHWRo3EG4raBx4zXV4H0yUgv8YlT1Tr+IU0G0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2313.eurprd08.prod.outlook.com (10.172.127.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Wed, 18 Mar 2020 17:02:43 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2835.017; Wed, 18 Mar
 2020 17:02:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/4] scripts/simplebench: fix python script ! headers
Date: Wed, 18 Mar 2020 20:02:26 +0300
Message-ID: <20200318170226.12186-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200318011217.2102748-1-ehabkost@redhat.com>
References: <20200318011217.2102748-1-ehabkost@redhat.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0901CA0045.eurprd09.prod.outlook.com
 (2603:10a6:3:45::13) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.249) by
 HE1PR0901CA0045.eurprd09.prod.outlook.com (2603:10a6:3:45::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15 via Frontend Transport; Wed, 18 Mar 2020 17:02:42 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.249]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e820e28-77f2-44b9-db90-08d7cb5e2ca4
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2313:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2313809B00C6A7D7DA440DABC1F70@HE1PR0802MB2313.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(199004)(81156014)(81166006)(8676002)(4326008)(5660300002)(8936002)(6486002)(86362001)(36756003)(52116002)(498600001)(2616005)(4744005)(66946007)(2906002)(1076003)(6916009)(956004)(6512007)(26005)(6666004)(6506007)(66476007)(66556008)(186003)(16526019);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2313;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3nAQnhRKf7FSwQxA9lrCQ+9lC7E1gFfn+hf+JgWJiRYWgEfx9qnwPJzKzIs/eCN0PIhlouD902Ns2UNTW1fTD3plOG6qp5h/nXjGv4foT/NFilQzbnrmBtz5X+/ylT+o+Gq6pAZG6J/156Tg0S0TqFaVbL9LQ2ipWLuOyh0IOs4v7e89EilA1JvLmn0zeKq8Vxpf43n9Fv0SkarG/IfJXhKMwR0i334WWWS+QDawjh6fEf90h3uG9zssbHP11E+z6cLBeeDN6wZpq+1VwDUKeVR8UMK8Q36Gq9XHP288GieykJegQu/OGlGWR4WspSWFfQrgHt5GK+SYb6neGE6tRRb0/Ls9r6N0618SLAx6+dFFidyQv4ip8X1ec7POn9aIxXYOyCqlB1/C6kdgMfjtybyOPKs0kLneZTLPqDLLkztTVn523asUz9pjyvteQaj
X-MS-Exchange-AntiSpam-MessageData: fvr0CLjl4iltkFFnGv2H6tIF4kfHogx0A7+CDa/jZR8Rly99v7mDF8i9WVbhFxwgCxh0EmB4TKL2eNzI+hBRSiSOHTs+YbDy7tkW/JzuZZeM4cauo/Ly0U11+NzxFkFNvgIrRUFYlzNI9NJGOFIsDQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e820e28-77f2-44b9-db90-08d7cb5e2ca4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 17:02:43.6178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpoUMtlMNTaPAGFn9xrBTmdcConOkkDBVp5EQnaE4hPO/vut7oE1v2R2gGUbIheufNbFf0w8myFg3gKyS8yceR7pdscOcFjbhNwxN23jxuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2313
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe07::713
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
Cc: peter.maydell@linaro.org, aleksandar.qemu.devel@gmail.com,
 vsementsov@virtuozzo.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- simplebench.py is not for executing by itself, so drop the header
- in bench_block_job.py fix python to python3

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/bench_block_job.py | 2 +-
 scripts/simplebench/simplebench.py     | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/simplebench/bench_block_job.py b/scripts/simplebench/b=
ench_block_job.py
index 9808d696cf..a0dda1dc4e 100755
--- a/scripts/simplebench/bench_block_job.py
+++ b/scripts/simplebench/bench_block_job.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Benchmark block jobs
 #
diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/simpl=
ebench.py
index 59e7314ff6..7e25f3590b 100644
--- a/scripts/simplebench/simplebench.py
+++ b/scripts/simplebench/simplebench.py
@@ -1,5 +1,3 @@
-#!/usr/bin/env python
-#
 # Simple benchmarking framework
 #
 # Copyright (c) 2019 Virtuozzo International GmbH.
--=20
2.21.0


