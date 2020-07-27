Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0453DC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15DE20738
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SVbnQQyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15DE20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k092S-0003Oq-10
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091U-0001ZP-Aq; Mon, 27 Jul 2020 15:42:56 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com
 ([40.107.8.131]:43617 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091R-0003fa-BM; Mon, 27 Jul 2020 15:42:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlTIabKuDPz8nzs6rNrz4RHfIEG/x8q3iVkfMBOMdtrAH8ylHq9DjECrgXJl9tr5cwl3xmfn/SAHuqlUpeZ5qosirXI9RGebd6ajFv+81h+oX1gOzsUseEMY2sF3l4V9tueD1i9z2YqsozHJZ9cFCYrjaYCJXda+w5pKkrqhs0bYXbumxpFDQpONzhUrST3RbNo0x2emH2fDwLldES4lvjDgdrl8+cr8zag7leIKIimgk0F2Yqb3JnI2iELzbg/6Fd+IJCR8ifSjx7XWvrzW9ma76NOiaSQwZjThHac5NCsONZyHS6TFe1Vjx/gOtFJijAeyvOxQIkZqoLsTFdfqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7F58cbhKLixyUvFnJMDjo4wCipkskUS/qjh36O8xdJ4=;
 b=g4NWoxm51mOy+LgIvK0NpHtRiK/uMS9dk05ebr7Hmk9h8Qhm6y8TFkOaWkoCHDlVPSUUv/GPycWe3UuWH7LRzsskWTq6qD0R99zQfivLljGidBLfCVglLCKZYSNDlhD3TJoQiDyTNRDsXAKJofhHgS68e9NURQPhPHnzOdKlNEoren19j+rPGyaQuEtoRpLpJRP4fjFNCWVsVQefVL4i5TwBjlA6Hsy4lvsLqCLnICKkFumxeZOvvO/4xSJhk7I5owBY+GLaOLhel4ocAJ5ZNJBqzNxp/mpIe30b0lDKphPXtgKoxcCIDjdLnKNu5x/eLM3z1qd1c7YFXeUqNOiFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7F58cbhKLixyUvFnJMDjo4wCipkskUS/qjh36O8xdJ4=;
 b=SVbnQQyFGrqH3PvmftZH8aSOFkarXiR+8MxntXdDSx1SdZRYouiUuc9ztjHK/LfDZ2HBhQaxzlxjgA5q3LEDpdxfGdGGXKGtRIrLZ03W2SK/UsQaaR3HdGDTHNJgVitZGtC0T2PUWUQi8/VaUSuYR3m3JZmS7UYH3NNBnYpHrr0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:42:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:42:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 for-5.1 00/21] Fix error handling during bitmap postcopy
Date: Mon, 27 Jul 2020 22:42:15 +0300
Message-Id: <20200727194236.19551-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0084.eurprd05.prod.outlook.com
 (2603:10a6:208:136::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.158) by
 AM0PR05CA0084.eurprd05.prod.outlook.com (2603:10a6:208:136::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Mon, 27 Jul 2020 19:42:48 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b88bf96b-e777-4c97-7888-08d832653e88
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610119502F1500B3410C1DFC1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/G6eKeuOyZldLp02gROh1iQOp35DUygsywCOonaO1pkUbGBIwU2yCRAPClxqKa4EDawJKcnZJYscTZAicwamwqxvz/36RjJ1c+6XxxZ57a9dQQ2WaeLMVLrKvZ/Ot+inmt49nlJjGNkZJt1TbsXP3PJSx9zIT66cS84mQfH9nhF9oqI/4IlaVIpeskubtinOGRTW+XIBrByfZsX27lM0IjXfyQnRgs6Gy/0UXPdoY2r/GXYpnPK3OY1WyoV5ewI6rKv1WaDJKfDIo577dWhOVeOiABG4x4lqWHpGG5zt9T0lb57IQn/4Tn83d38YP9KBniPIAihMvfg5ZH/6O9XLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39840400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Z09Q9BNtnfHFhG4P+iSu42Bv2h+CGu3j3vQEaq11avsWFNO0klNVijITfXZ6VL+n3wjUnUyKaO2F1/XRxsCf0IEpchFNffcGeUGixKgRCmWh3mb4uYZk3XYN73HhRBSO0ONiHxZTQ9Y8xDveRSUrwLobW4Bm7XS8lKD0RfsLHqHusiX6iwMyNhJej8Eyemd7ra0ETQ/ugBSxjnQ4mJhcnFCsN4lvGzidK1al3J5C5pWj1pDfWBApLWABDk6+8KY9R4JuuSPm6MppD7/iVvu2dxIbwQFa5S/JpnY29P5hAPHPPxSsqkv+GAzQja/KXMoBMxGKZ+VClTxWLaARJA5FE5e7h6VXuH/l/jofEO5tiSGUPKcHCTxRXEn8VmUYHskxgrQPPK3dfN+FoUEWSZFGbQcI2v++DiQJ5rPr2/O8CucTVbRFwAf/tdWPxq9kSoP7yILvU/2ROFkqfnpypUH03baPkol8ewNL2j2W1VbmPiqnBsyIaq3I3fIQ1WNPodfl
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88bf96b-e777-4c97-7888-08d832653e88
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:42:49.6754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSicGFTDinbjQBnlh64AXXl15z6Om8zmAgAtpTjamINs48h5geoUgVQQnjCcCXFZMmjetR1KU8NnjaXQNDVS1IuSUuTiWhtg7nV6CgJcyMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.8.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:42:50
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
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v4:

01: typo in commit msg
07: reword commit msg, add Eric's r-b
10: add Dr. David's r-b
15: add check for buf_size
    use g_autofree (and fix introduced in v3)
    use QEMU_LOCK_GUARD
17: fix commit msg, add Eric's r-b
20-21: add Eric's t-b

Original idea of bitmaps postcopy migration is that bitmaps are non
critical data, and their loss is not serious problem. So, using postcopy
method on any failure we should just drop unfinished bitmaps and
continue guest execution.

However, it doesn't work so. It crashes, fails, it goes to
postcopy-recovery feature. It does anything except for behavior we want.
These series fixes at least some problems with error handling during
bitmaps migration postcopy.

Vladimir Sementsov-Ogievskiy (21):
  qemu-iotests/199: fix style
  qemu-iotests/199: drop extra constraints
  qemu-iotests/199: better catch postcopy time
  qemu-iotests/199: improve performance: set bitmap by discard
  qemu-iotests/199: change discard patterns
  qemu-iotests/199: increase postcopy period
  migration/block-dirty-bitmap: fix dirty_bitmap_mig_before_vm_start
  migration/block-dirty-bitmap: rename state structure types
  migration/block-dirty-bitmap: rename dirty_bitmap_mig_cleanup
  migration/block-dirty-bitmap: move mutex init to dirty_bitmap_mig_init
  migration/block-dirty-bitmap: refactor state global variables
  migration/block-dirty-bitmap: rename finish_lock to just lock
  migration/block-dirty-bitmap: simplify dirty_bitmap_load_complete
  migration/block-dirty-bitmap: keep bitmap state for all bitmaps
  migration/block-dirty-bitmap: relax error handling in incoming part
  migration/block-dirty-bitmap: cancel migration on shutdown
  migration/savevm: don't worry if bitmap migration postcopy failed
  qemu-iotests/199: prepare for new test-cases addition
  qemu-iotests/199: check persistent bitmaps
  qemu-iotests/199: add early shutdown case to bitmaps postcopy
  qemu-iotests/199: add source-killed case to bitmaps postcopy

 migration/migration.h          |   3 +-
 migration/block-dirty-bitmap.c | 470 +++++++++++++++++++++------------
 migration/migration.c          |  15 +-
 migration/savevm.c             |  37 ++-
 tests/qemu-iotests/199         | 250 ++++++++++++++----
 tests/qemu-iotests/199.out     |   4 +-
 6 files changed, 545 insertions(+), 234 deletions(-)

-- 
2.21.0


