Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D22CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19234206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vxyvIKaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19234206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZhnX-0003iw-Ad
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 17:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhgF-00025c-TF; Fri, 15 May 2020 17:15:43 -0400
Received: from mail-db8eur05on2100.outbound.protection.outlook.com
 ([40.107.20.100]:45280 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhgE-0005Vf-2Z; Fri, 15 May 2020 17:15:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+jdN5TsPOMA13Fffj0gK2+MR7e0NB9mHXo3NHw1hpHZZjVisEU55tXCvGfMEKo/ZVHf5HqGJ3gXQbba1LHHHE9IDFoByiHjQi53A4Kb41nQ0s1G1N/9KMjRZ1fRyYRm2x4CUE0iNH4e/v34CIEpe/cRqyjqDdpXAT2Y7giv8GWGBpJSH3UfktXVrVe07CxI+jNfoVVv5RkZ3dRQ5X0LpeJ3U6zZRll/ispGKTt95if18VpFW5yBKSLAfKjEElCV2A1Oxtq9DkCMwYxAy+k5xVmv8HVsJS4epUZtu2m5MZsuiC97DTCGa5r9HpPGEMyEWBHTcILCYK+sUlj6Heb8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58tllaQSx3xlrSyNMw9zhcUqNHzoe10DjyvVV9vrwcM=;
 b=B6AwEL8riqACNQV0wN3Bzeaiq12w4Tn2N3zLXTQQV1SVIWF8YMqz5jNMULPoeo4ucOQsOzSTNTnWOElgU3LLUVspjzNS8wCVpXN9ClNUKTeVRW45sVbSPfA/LPP2s+I7QiSdj+rE/Z2YVH3T8xe4VWAgiNB2q7lDclN9qvKFcF3TAnEwvgZeju4EZKf1NcfuslXXogcJyVRct5lAKLRzFq9svtzbdPNJ59JRPUGZoIfDYphOPnaKB79C9osWNdPqYOTqpAdMuMaVa2cpSFaY0ld4zy+xnPdlLBPNszC9V2jxGvHnOU+5kYgEAajpzwMOs01QH46w5KA3bX2vZNXVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58tllaQSx3xlrSyNMw9zhcUqNHzoe10DjyvVV9vrwcM=;
 b=vxyvIKaKdOrGMx40N5Rc7mg/4k4aFj4yZ9frHkv9DlO0Hzq1pPmhCSGYv99NF2CgcwEs9R5+za08+4udyDAtvozzHEJmIIhV80W7f9B3ScwKvz+lVVnKaBJtBDaq45PAC3s310vqaZ7F3ogpEgzBSkqvLBEi11qm8TslSYcFUAo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 21:15:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 21:15:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 9/9] iotests: rename and move 169 and 199 tests
Date: Sat, 16 May 2020 00:15:05 +0300
Message-Id: <20200515211505.3042-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200515211505.3042-1-vsementsov@virtuozzo.com>
References: <20200515211505.3042-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.184) by
 AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 21:15:26 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d17adb77-95ab-4179-85dc-08d7f91516e3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5478B6E1F415F00C188E9498C1BD0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Pj0TQGBlOMU4ddm+tGy8Hew7gUu76obNnxC6PJkxaZEWKwIRaGUE3wJRT2En0tHWSN7SMGv7lnPPXujWwF6ZM+3zBiN4+OjOyDqSquvHF5/BmV1QKdNJUrv+o2vXSvhwp7Uyu2+x0GhGjYcFGcCxl4GM300YEP0ttTZrNjADC0sRl6JJYK9lmr7H4jMkSytSrCbDHSQQy+u/OOsRGtmJB2l7YYvb1YvCm++nex89q7JjgYdkeIZr2fjps76ZRJHVtM+uuldIkgrD8q8u+6yT6UQr9XYcM8mMiuQqvveamw9uQZH6qSw+uwm/qm8TdzUxHqeXymxK6U7X5Y2LSi9eXqUGVKzSq0fRqAtJ1OoDirSz5BBvJOkWRWvj7h3ntYeqze3u5I9tTjAPSgCeFUZ0jHuBM7vYtpwmb/s1zVNqgdnW5tMI5AAiGq2b7aJjtDH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(346002)(376002)(366004)(396003)(26005)(86362001)(6486002)(2906002)(6916009)(36756003)(8936002)(316002)(8676002)(66476007)(66946007)(1076003)(66556008)(956004)(52116002)(4326008)(186003)(16526019)(478600001)(6506007)(6666004)(6512007)(2616005)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: P/pNjV/vV1XC6WM4kZjNQwCCXxQP+faQbm3TmAf1WwfOsg2/voNaQtKhN7WyMN2LGwB2Tvv0eVqiha+ZDAWwCUoznQmWHyiASEVV8T9LR02Brf63CYHf7Vkenz7el9pOVOPneGUVLb5oxQtG5MXJqB9lPLk8X2lfFt9KWR0/nut/5CtZ5JY7EjrtPfWDQYzxNjwMvRa5bk9/aEioxCzEqJFnlpP7Bqn3u0OyL1qQu6oAcwY4kXU4Q4/sGx1htDGpGqntl+q5GRzCp7lURD8qAlzxkNCEFcJAWcil8M7FY78MKD2taH1qMVSKIhFis0vNkAitt9SnrOJCkL1PElerlarmsCTvFb5aXUbPcUfeoxcJMcoCL+kcfLqyqfO8ktOSYfZFMi5+VI44EZzcAKYPR9x1V+aboKxtlPiRa8eH54o/XWiNAVaxPlvOD3xJTgtHQl6LiItQeLChdCd8I4jIQuYCb9AxWK76Bypi17lxQ5Y=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17adb77-95ab-4179-85dc-08d7f91516e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 21:15:27.1605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpaXrlgVC8RN50HhnN4xNA4aOuJBSSV665dkL3wl3LUM6EBBeEeofjB10xL2tz1yD5TGR64cDWDW7FFm5Oid+/6fiDwO7eDEFlZbusX2dOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.20.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 17:15:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename bitmaps migration tests and move them to tests subdirectory to
demonstrate new human-friendly test naming.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test}   | 0
 .../{199.out => tests/migrate-bitmaps-postcopy-test.out}          | 0
 tests/qemu-iotests/{169 => tests/migrate-bitmaps-test}            | 0
 tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out}    | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 rename tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test} (100%)
 rename tests/qemu-iotests/{199.out => tests/migrate-bitmaps-postcopy-test.out} (100%)
 rename tests/qemu-iotests/{169 => tests/migrate-bitmaps-test} (100%)
 rename tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out} (100%)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
similarity index 100%
rename from tests/qemu-iotests/199
rename to tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
diff --git a/tests/qemu-iotests/199.out b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
similarity index 100%
rename from tests/qemu-iotests/199.out
rename to tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/tests/migrate-bitmaps-test
similarity index 100%
rename from tests/qemu-iotests/169
rename to tests/qemu-iotests/tests/migrate-bitmaps-test
diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/tests/migrate-bitmaps-test.out
similarity index 100%
rename from tests/qemu-iotests/169.out
rename to tests/qemu-iotests/tests/migrate-bitmaps-test.out
-- 
2.21.0


