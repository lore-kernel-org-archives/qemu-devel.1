Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC79EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF3D20674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BLs810KQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF3D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytKk-0004us-Vt
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJ3-0001NB-UA; Fri, 24 Jul 2020 04:43:53 -0400
Received: from mail-eopbgr60095.outbound.protection.outlook.com
 ([40.107.6.95]:40593 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJ2-0008Mg-4B; Fri, 24 Jul 2020 04:43:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YK4yTh1dn/Aol0ttF3/7FKK6DwE+m1hsGJdgFbbuqUjKkpuCMIrWxCPywjIzJKEu25Iaitf/Minq2yG4RsLk0zPv/3Afpf0HATI/WADYjjpmPA3ikHll36c7h3oz4ASAqnWsG9ixyNraYaRZrdEMVRBMI+A+59cv3ggrTgGzjq78HamDxuZFMJYhYAwwN4M7thS7uBafeWYzcu9fALRcQ/3KYgBMub9rpIqE+7GrQNYHBZYfS/IoMq34g4CEJ+1XDN2xKBvXgqqlfeQ1f603IyNtAvtGSvaeEY98qdJ7LV9ZdZFrsL0/Dn+PzeShjfz6OROHUgpk4POtDv14DJIJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRjEsKXCNKOMH92X12n2N4X/wygLaagQIufb/RiMPAg=;
 b=GrQwxXc0Se4c4y9JEQdQo2pBLQVW1e6yroh+/mjVqZ84/meA/cBMLEin/Rtm/7r2GUKZUxgjHDynT0OFtDG6rttXONRBs7720pfn7Aos9BtD9IDrmWbZUDkp3BfCHjhsS0Nq28dW+V344bYfwIyu+Ka+Bg9M2YkJfqbuYb5vb2+kvp1ThJc2oSEe5tCdqVOK4/HNmGR0fIrjN9TNPpaTAgUFUDQVfxJsKe0D9Z8elmLX8ZJkv3tlcyb86QSJPchmg5tAC9eU3TQKfHoI9UxcG72jLysp5CrZB3SgyXUcAyfdg0nrKLbiOKDyZQjK+WRtj3WidnU1wp5JYkOJR+3GLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRjEsKXCNKOMH92X12n2N4X/wygLaagQIufb/RiMPAg=;
 b=BLs810KQeCbbcxmarV2hP2q33sz3AnM1MBndQyrSoBvgqoSFvVhKMSfx4QQewOpKxSo2+8+0551jE8f5xbkGWl/R9Nu3gISet/nVhjhwqTRUTrmhzXzz1S+uEvHosn1J9ZIxjgYazTSDL3KRtKgznekOdT9yblJrSjsoy4jVbOk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 08:43:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 02/21] qemu-iotests/199: drop extra constraints
Date: Fri, 24 Jul 2020 11:43:08 +0300
Message-Id: <20200724084327.15665-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200724084327.15665-1-vsementsov@virtuozzo.com>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0160.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.156) by
 AM0PR01CA0160.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Fri, 24 Jul 2020 08:43:43 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b7e5a0f-7bd7-4e35-fa42-08d82fadac9e
X-MS-TrafficTypeDiagnostic: AM6PR08MB4849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB48496F52CF74E1C3085E7380C1770@AM6PR08MB4849.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wk4+kePn8MpJxXpxgwgteyi5IlY6Ay7E7yMkpa5RlQIo8r3heFE3PvxX/s3KcXLKtjGrQ5Jfuw+KGeSDhKfrOqTXnMPLnCgCHcF4pwiGwTHvKOv5itnIR1GkEvraD0KSHGOvja+nxhrl+6HjIXWq3sFtS+KCpjjBgpifNAmaDOGe7EEkI1EJ00Q7gy8vppwsN5pFOQ7QK0TEem3mLAWxFFKqapohZTin7P+s0kqvf3SciF4K4hrCP0MV0vuqOzZ2HUGkuXeMU+EK1qYyvBv6Kcy95U/qnUA2RHWMCwy2NhzS9/Ke7IKgSzIs2INHlkB2fSsCgLihhufbLWC+ioVEnLsto4ArELiXv1Oemyw/VaTX9qGQxPifvo93obdgc9LT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(346002)(396003)(366004)(376002)(26005)(6916009)(6512007)(478600001)(2616005)(6666004)(316002)(4326008)(186003)(6506007)(956004)(16526019)(86362001)(83380400001)(1076003)(6486002)(66946007)(36756003)(69590400007)(4744005)(8936002)(107886003)(2906002)(52116002)(5660300002)(7416002)(8676002)(66556008)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: KtU2/eAIseMn+7J5skIu87OVQQXSCHqp0jgqcv+F01H/KaTIUYcYvIZKtGePRM9PJa5m9l8aXGcn/8L3wab8bURocuUAfY/AIT4nETS2Qjchlc052L3daV/wsNbXN4TnAFxSslg0O93huUy9n4KcZn9fOtEY/BOJTmdnpgS6GRswKfjvpRBrx4HEwoPmYossUStOc/dbQSxmoGvmgzaqcDyaMUCeT1HBxU+zRXfMzbDMuiKpI7uzmFz4AClkk9KXsHXj9vlNvonzwX5oOCX01pKeW7qv4WQBVdlw2dTd4w69kgHazBgO3pDE11r/ivL0o2cAl0kAO6/14/2d7mnJBlrCRgPj+OcTMV1jlPkDLZr4c2f8Qg4JmK3dOAHIPEfKPbEEnQIXU2PPm/CS5RCTMJM73OTnF2HWUpLN11q6jXe+LVTP7UyvsOLraYo1Cmi0CLb/DHvexq8/9SHSaaLFe2mJM2qNpaqPl7qVrR/7557tGxqtOY/sXKEKJjLVx/Kv
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7e5a0f-7bd7-4e35-fa42-08d82fadac9e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:44.6226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jhhlve2B5Ak9p0r9rQjCb/q0OmXVweq3XvRrRgVqGUDeh66f1aOupLLDJGm9iNqSzBxFdbIa2BM4lkAc+k5XqolMRry1we+qNxNgpsnQzmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4849
Received-SPF: pass client-ip=40.107.6.95;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 04:43:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 stefanha@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need any specific format constraints here. Still keep qcow2
for two reasons:
1. No extra calls of format-unrelated test
2. Add some check around persistent bitmap in future (require qcow2)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/199 | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index de9ba8d94c..dda918450a 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -116,5 +116,4 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
 
 if __name__ == '__main__':
-    iotests.main(supported_fmts=['qcow2'], supported_cache_modes=['none'],
-                 supported_protocols=['file'])
+    iotests.main(supported_fmts=['qcow2'])
-- 
2.21.0


