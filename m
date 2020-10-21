Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689DCC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A0E2225F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VkQhXEYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A0E2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVG0M-0004vD-DX
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFab-0006hV-GU; Wed, 21 Oct 2020 10:59:45 -0400
Received: from mail-eopbgr70109.outbound.protection.outlook.com
 ([40.107.7.109]:36743 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaZ-00085a-3L; Wed, 21 Oct 2020 10:59:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhvFkJAN9Pm7RoFUFyi/hgOKc9VAm4ui4dK/6NnFAqdxvQEvwkQh70s5wmu7wNav3ZaUW6LpKjmRPZtt/ZAQafqDrKotnK9QXvvD0C8vBZO6Or3gdaMS0XArcQevg5UPHBOsMebELrIeKa+Yl1omzywqxdm24xhgQKkrEZUnoAr06epL25rimwtkg2qAtCe9KMpSVa3gHqr+jEi9IJO8IUJlgqEHS+CLvGBy/LkVFYj93A/Wd4p9FBRZS9ns2qktklRaxdAhWXx52U/YvWEwyEGx65NgXoPF10Mz86HlHmfv02F49hepaS/a4eNxC018WXLmFyp2UKsXcwvsxj0gjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAEpXnsbhIh3NaB8t0CK+0ql2QeitwSPmPQcUKxVYwQ=;
 b=eegC32X9dK2wTbCDbj7CZk8fgyYV4eqq26dgo/750WMb7cEMd0pxvXr1uVFjOZKi6riWwyRYf9C/x9P5donQ04YKm+fYp1HhFLZWdLtYDQNhDgcYaLNSQFJSwHHaqSPLhxl/tpIIAXqdw8EW+Amk79HrlV0q4elbLtd9YfzOx8a0E2Ln3fYZpdPeaDy6SHlm0Sh1v3vhTvc83PpdSnnr1UsMUH3bgqEkZc48oYmlQEf9RtlOg4nwdLzA/aoF1kRaFU0ZZCcdLYHJdtgBCjMmXJMcsZU5HlGYvd+SpohpgQ75XwDWDOUEkah0Y/h1LgvU7iKx6zO06/MClFGS0tjXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAEpXnsbhIh3NaB8t0CK+0ql2QeitwSPmPQcUKxVYwQ=;
 b=VkQhXEYBmM6sSOSgLQJNpxA9bWK7VXCFYlsHLoLrlVKf/Crq/LJ3cxRHonnwj0ct+c+KxWOc1JlOEl+u+qRORx4pr3ttQ8DczrwKFikfwMFpJWk8IgqzhwmYp0vupI1SVn8HUvADJkPWdcSw0s596sSk3hqcMtt8cicf8MJ7TmA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 20/21] simplebench/results_to_text: make executable
Date: Wed, 21 Oct 2020 17:58:58 +0300
Message-Id: <20201021145859.11201-21-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201021145859.11201-1-vsementsov@virtuozzo.com>
References: <20201021145859.11201-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5618415a-4657-49b4-343c-08d875d1e959
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB44723C2456C8D19386287278C11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sPds7YOonsVdMClR0f4BwNARjMjUt4i3ICV3uN9NM6GTt6gb6aW/UY8tHPLJMtTi90xVVRrfcCV90aVWvshiyo6IERKyHRHhYMak0zMuFvj3LQUMjWZi46VgvD/wrSrGkQx5SuGGaEaaDVJrH4f7IM4h+Lg2N4b/+7MSyrVE39wjY2jvMSbSvnDf3XZt4XPAomNEqrsoTVQGNIR0oWeWIh7hKoACGzCdcJTozFCVkRo+NeKOgZZYDJjctIRHrJXs+vWju8+k+vhIKAXzc7T3SRXEr3MIs0wpNeF5ZkeJZ3gR7njIQ41g8Hu1cixpVX6Ia2l494W5nZkZU+HHTErSiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(39850400004)(346002)(66556008)(16526019)(66476007)(6512007)(26005)(478600001)(66946007)(186003)(6506007)(6916009)(86362001)(1076003)(6486002)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(107886003)(4326008)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eT8kYlLS9U8wfE3FgpVggWgTPXhvys0cAUr+UzD7iZmlnR9Y+fBWv6s+AwsgoJFARzyh0OolVhw9+4T8uwU111526KP+cmY1djcMKRh73bZmAlTEW2LTzamlgB1fqud6BPGGGMCfIFlrYf4TBlEFBI/N8lUSbHQJlhyInKvoWK59qEVe76hYQWcjPNJ7YJXVm1LGHPfFtXUozX1PNfx/xYz4ext8L0WyOQQZ67xpedrhVVqOW6k/f8KtthyyHD+a81dBJH57RLl0ztSKoCg/JRWQi6+1v+EoTSNr8U/K8D7XqdbaN6ign2bIBalOrWJQf5gQxCi27AQUUVdn5VSDku0fhHtIrb8kVSUXc5sv5+aFLaw8OHlj6fpsBbC2tGEFwZAaXNa/Bd4+YU8fHOs9S5wQvFnFdYh3koRr/kFXO3bIy4rEOTORV5Cg1zcQomz9HBN1OYNLoS8Szb9nc8ji2zzwONn2O6TmkHOazMb1n6yRSkrL/AZrW7nI8WgS+5VHIerplfesGOeLcYXd3/g2ZJCTupWcRrbRn+owt8T9KFktv9hxq5eE7wtg310I9l5vu+FKTDd1dX8pJ8c+9FfEPyWorKeCROxIv5/Xt496U+gVjz0Fuiq+FM7JSI1CX1ULho64Rrle3S6PVhlmR5fmoQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5618415a-4657-49b4-343c-08d875d1e959
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:29.7871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heWlySvqVGskde8mLA2pqd3M8BYfkfXk8CZF+DfmJpSQHI6KzUpvygEhGC1HL2UIW8FHhloTI9W+npKs8XET48xBIh0VVoMg2KM1h+jZl5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4472
Received-SPF: pass client-ip=40.107.7.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make results_to_text a tool to dump results saved in JSON file.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/results_to_text.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 mode change 100644 => 100755 scripts/simplebench/results_to_text.py

diff --git a/scripts/simplebench/results_to_text.py b/scripts/simplebench/results_to_text.py
old mode 100644
new mode 100755
index 56fdacf7ca..db8ea41cf2
--- a/scripts/simplebench/results_to_text.py
+++ b/scripts/simplebench/results_to_text.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Simple benchmarking framework
 #
 # Copyright (c) 2019 Virtuozzo International GmbH.
@@ -110,3 +112,15 @@ def results_to_text(results):
         tab.append(row)
 
     return f'All results are in {dim}\n\n' + tabulate.tabulate(tab)
+
+
+if __name__ == '__main__':
+    import sys
+    import json
+
+    if len(sys.argv) < 2:
+        print(f'USAGE: {sys.argv[0]} results.json')
+        exit(1)
+
+    with open(sys.argv[1]) as f:
+        print(results_to_text(json.load(f)))
-- 
2.21.3


