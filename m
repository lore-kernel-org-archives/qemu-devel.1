Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B370EC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1233F2177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oPVKj5dh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1233F2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFrG-0001tJ-Tb
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaV-0006Rj-Tk; Wed, 21 Oct 2020 10:59:39 -0400
Received: from mail-eopbgr70109.outbound.protection.outlook.com
 ([40.107.7.109]:36743 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaU-00085a-6q; Wed, 21 Oct 2020 10:59:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0O5jHvneBnkDyb3bvrZEoyNII/RKaA+n8O2zgVJJ4Vs9prC6//6gLWwdD197NgET5RIZHsoiENEukBgz0GKzjB4/BwtEUg6PjDWC8NX+sO44+2c9pqzftMyav2NuOvifDewO+caBUq5ipzrGI7jpqOg+94J/HADbCrK1fYQAm/YVXq1KqomJfmK2+ydIrhQnkibvNRDBGKAk9TaL9Gzvw0m5UeeHcBQ/iEo1CWQJP+lCLtMl1k+1/cBttVAALKHdEmeaOtE6x1Lx0Y0KgNzg/54V8O8Shz9M4N+2S/IPagraGl6osO3oyFBuH9yzurV1/sAjFQvcnnACcJpSinNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWu577RRtAL9jg22BYbaZSnth7FPOjVTlrtxPp6/6S4=;
 b=SFOcTBkz+RYtW03HizzvEcRQkky/8IXKp7pBYEFPROhn4asaAXwG40Zx3WoM9/yXAf9C3W/H1YRcWxePMrsGftoN2ONPBd9qESh1NwLOUXsCmqocWNQzFE6fa+krcvzN+rTXTgwQ4S7sRzY+oy3mYcv/lQJNQ5bT4FrIkocsDKWuZHwij24WHspnqgdebiN1+PWp/S1rZ9GEek8q6aNZ4o7TkxH4RV9vnfuFDJZQxrf8Sp40mvIdyGAqpKQy2cnZHN9NiwZxQLlySwhXzGSWP/1otEPw4hVFbEgQumSUWAjfOpDqubFVtqASmHveJS7udnykaK4BsQrLr5UG5YuvsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWu577RRtAL9jg22BYbaZSnth7FPOjVTlrtxPp6/6S4=;
 b=oPVKj5dhkqYxk8ccPM8ZTfjomB7yKFXerxZWA4dliRFw9HvEgQkUSAubCJsLLws2dKfDj/6wu65WpWphVaxNl4U+PxeZCOxNl5ZzYyK9U5cMwHFIvhzieGP8Xff4dsyj5IQPvP5mMAKpZT7UYc0TM4t7X5Pf4AJMO+2CZw0wvBM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 13/21] scripts/simplebench: fix grammar:
 s/successed/succeeded/
Date: Wed, 21 Oct 2020 17:58:51 +0300
Message-Id: <20201021145859.11201-14-vsementsov@virtuozzo.com>
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
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7bf21d7-9212-405d-9b00-08d875d1e5cf
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB44723B4E597BABA2E67F4060C11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTA9eKrLiCdj92Sdbv+yU+xMSefjI3rcqAcsHtybwG8yYgXCKtLBNvEJdmOB8Qo+ShG/W7MHC2aPpLJuVFPJj0VSheRFG9pdBqUOy3tdii/7J/9u1XJuaHyNzTbrEMzhVJzzGbYovscxjulGZH2QmJKSuDD0VZv7gCu+ck5cpRHOCsolzuGMpfCHrCcvetFzUjnI8SHyukMESC112i04JGdUwD8vc8xUx9O9bWESeAkbCb7PV51IlFuQ5HDyTMznQon7P5JR/e2L6jy4VUg94jOMfra0edQ/TEYpdk+bFT8lKwnY9K6bZMU5UuSYjxi9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39840400004)(66556008)(16526019)(66476007)(83380400001)(6512007)(26005)(478600001)(66946007)(186003)(6506007)(6916009)(86362001)(1076003)(6486002)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(107886003)(4326008)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XOMo7HN0vLHPS2NqF//tT/ELXT8ICo7OOMJDnJKQeCuYF3GVpI/Ejg34FrjpKbENp7A2bGVxjLTDbRMlrMjQxn7sdYzATB1ZW1sWLbdfytWn6GClTXbbtq7sevtdwGs4wguUtui9nrpZS2OEOBUPwlacFr4xsRZpnzy4Nk3vIF5wlo1mU925NYFwjZ2+wMYCKgintnXbCWrdTwB9Hfsy4g/5bMxGKML0Qc60vwbUdvxjcivG6so7zBZlENvK0O7TcA6GZWSqq31MQtc2JRlN+WZZXZoB3bkZdDwbCW3uckYWuegEINGGAVGarRUU7ddjs+srA3gLGTBWh7c8edGoIfvtiFItK85GjhIqlLz9mm1qRry+6Us+7Af65RaVdEgHYL9PZd/2WC4beIZEfijmIkQkW6ZBw5zti6eaCmEr35ZO2NM0RBYnjKXsL1DNMyLQjBfLTuTnCO7gJGqyupKyYDXey3ZY2xM6iDQqzo5H4n6oeevYrhlSCCK41lF2LhhMOMbkPScZxJWg6NteXCU/bw3cvsM3DaIzGQMN5n06VG3/TpTaTo/3IjUi7+UtuTuEz7UFApuC8CcNZ1eptLJl8ZZU/k/6Ho+nKYWIVor5PHuNgOTsOCm9K2MTa+vyXA1K2N6X6lEtjy5tw8E/VWzG2Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bf21d7-9212-405d-9b00-08d875d1e5cf
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:23.9079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYBZGRVb+OQpnEa2q8Gk6iKCre9P7SWA8XuivnXYpiaqA5neRqXQEvqbLz/ahhFhcOs+zefA1YXxcIwOVh/SaErZ6QosZwQO0Dtcc6BwmCI=
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/simplebench.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/simplebench.py
index 59e7314ff6..2445932fc2 100644
--- a/scripts/simplebench/simplebench.py
+++ b/scripts/simplebench/simplebench.py
@@ -54,14 +54,14 @@ def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
 
     result = {'runs': runs}
 
-    successed = [r for r in runs if ('seconds' in r)]
-    if successed:
-        avg = sum(r['seconds'] for r in successed) / len(successed)
+    succeeded = [r for r in runs if ('seconds' in r)]
+    if succeeded:
+        avg = sum(r['seconds'] for r in succeeded) / len(succeeded)
         result['average'] = avg
-        result['delta'] = max(abs(r['seconds'] - avg) for r in successed)
+        result['delta'] = max(abs(r['seconds'] - avg) for r in succeeded)
 
-    if len(successed) < count:
-        result['n-failed'] = count - len(successed)
+    if len(succeeded) < count:
+        result['n-failed'] = count - len(succeeded)
 
     return result
 
-- 
2.21.3


