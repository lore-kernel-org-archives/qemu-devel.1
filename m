Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F83FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB232073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="H72/atmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB232073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfp6k-0004vl-3G
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfoud-0005HJ-Hf; Mon, 01 Jun 2020 14:11:51 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com
 ([40.107.7.117]:10211 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouc-00027N-He; Mon, 01 Jun 2020 14:11:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUPxsbTaaPkc7uefdq/o9XGJ/J69Yd1chnPMn9b8B5DADsqlqotnX9IaPXoER78lFNVzpb8jFGxee4LYv2lv2kHXTO5CFywJMEKuEZ2HCFgfzs/7u+Cvwwp+ZokpV/3gW7G+5KbfmFN4S8IUojO8tmPyMMgMESz5uAHzmNKz/pkrCBFeoWbka8sD2bF6WAosQLbRB2VOgXZiYn6HsaGt3Ri8WdfSQmGyiiR1QrnMQNuSfjB6SInzjlQKVkRZb2Yvh59aB1jSmXpwYhZRJVH3usppImRs4f5WL7re+EN6pAa7D3NlwouUS3HyMPwHhvhGckp3+fqAR16UETSj7rkK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8yqqP4TiNxeZhmnF2MxKR+ffrvUBh0d/iUcko9ddiw=;
 b=IREJydDqH6/G6EyowtjFwFaEHQItoxHDf/r7km9WRVNyzPHm70qfiIAlqtdkFULKD7y4nCJ/qPHPspK4wX2MhNzo3UJwr/kwxMCocXBQymzCIGXwSQ0g92ap8K3LXkLxEtbC5k1PQJGxjWMbqqKI31VyMuOMa3sD1CNuCP5C/wpY1nXijrmAtMk/50XUUOtmRJEBIsDHfY3FQGHKdtwifljNDzqhSAazBZvJkKZX5/O7kRz2XofbsYJ7dh6Gg+a/fez9hFwD9DMJjRWAvSayn1/1ufWYB/PJiJrI/P9ZQkRbNPJ/sMcAONTQESm/qtqhnFOBPdKXrG3x5SeiFu8CgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8yqqP4TiNxeZhmnF2MxKR+ffrvUBh0d/iUcko9ddiw=;
 b=H72/atmCndqXDZyKnuX1VwWxiQMYy7eH40YkVJR6Eug+zoJNZ3DxUsx8nrM59zphCzs2MSLSeNaT7kgvIKtwfp8JCBXFSjnylLGHuqBqeGLyysfpFX2R7ftKQmluIDXuEG73/BssUXqmraYVyLszVbEl/z556Z0U9vVNhKq4II8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 14/20] iotests: 185: prepare for backup over block-copy
Date: Mon,  1 Jun 2020 21:11:12 +0300
Message-Id: <20200601181118.579-15-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200601181118.579-1-vsementsov@virtuozzo.com>
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.170) by
 AM0P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:42 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e699ce92-1544-4364-376b-08d806573d61
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5317F81621FAE7A51CDBEA1AC18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fkkVK6PM5UL1GdbnpD1hOMWlXc4A1wGv44ZshYjAgmgO9jVz4zWyGvV0VuABFLzkIvyLoEeS9L7sAlsK7D6K/GdIE14nUVBT6yjPnhbjfsp0WjY+ZcZ7SJIb2IZlnN9a5yZ5w9BuC36ruea6HKo5RgzSLDO0JcTqh40nYjyHw8RqZQsiNBjml4M5W9QEqYLKdJoorpR+wQwhLYs5PLW+OPDqBDWmjw61snRVaSZ6KWXzc12r/kNwWg8PWElhI9cMkmWvjfBtuaX5lM/8S3xymf1bPJ61S4g/9PbfsBH0XEzEDyMj1faQcUKIwJO0BbTG/ynv6EN9FnbmUWY8jPpMIe85TTqzO8FI7Gf/3wwRlIcYFrZiq1iKB1KA0c/CDQ0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cciS4roC2dZSbyIYdG0iaSJId0TNts3z/44CXjTLOMWVj2YdvvuO0o3UZb5capplItzmI5oaI1EP8SPytz8VtSULSxx/iv9Se965mTFl/Uaob5nAom0zNJ3T+jhxjOLH/imNLOuX5boCs4aq1SFDmyVEETIwI3cjSyiURU3Mwh0GeQ7Sa7jBZlVDBIkwNjypvdQyL5vZMePbjFlpmvp3XqesJBSaYSBIPLLbYZHimahf2uHgVnqs3f7TJN8DU20gDG9fbcMeqyn13mlvrX9RdbJBroHcw8maLzYcyofZScB202vnIAYLXh8FxgUoFfYMk48gOLIPr6b25Q2NNfFUcheU8obTDC8q3VfSMP/kvOpNJjxFuRAbDnimTJxPQoZQp1RhXGmIBESZTS9okeBfwrm7PK/YnUjLdX9ZO6/mRcf7PXs+6saa/UsJ00KEEEO3zarM3/N2hdT44ywjAjcMAxZlJfuPbbWVa9Jvf4HPy1Y=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e699ce92-1544-4364-376b-08d806573d61
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:43.6001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNdiSoPyKSepzmKErvkjpK3LB3WcMxmSHKfsbbVyPdXfg27z4wOrRckGoIjhUu5QjEK7LzQmY6/q/Lk6CJ6Al4KKjpntSwIqIsNDKGUfyTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:40
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The further change of moving backup to be a on block-copy call will
make copying chunk-size and cluster-size a separate things. So, even
with 64k cluster sized qcow2 image, default chunk would be 1M.
185 test however assumes, that with speed limited to 64K, one iteration
would result in offset=64K. It will change, as first iteration would
result in offset=1M independently of speed.

So, let's explicitly specify, what test wants: set max-chunk to 64K, so
that one iteration is 64K. Note, that we don't need to limit
max-workers, as block-copy rate limitator will handle the situation and
wouldn't start new workers when speed limit is obviously reached.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/185     | 3 ++-
 tests/qemu-iotests/185.out | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index fd5e6ebe11..6afb3fc82f 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -182,7 +182,8 @@ _send_qemu_cmd $h \
                       'target': '$TEST_IMG.copy',
                       'format': '$IMGFMT',
                       'sync': 'full',
-                      'speed': 65536 } }" \
+                      'speed': 65536,
+                      'x-max-chunk': 65536 } }" \
     "return"
 
 # If we don't sleep here 'quit' command races with disk I/O
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index ac5ab16bc8..5232647972 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -61,7 +61,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
-{ 'execute': 'drive-backup', 'arguments': { 'device': 'disk', 'target': 'TEST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536 } }
+{ 'execute': 'drive-backup', 'arguments': { 'device': 'disk', 'target': 'TEST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536, 'x-max-chunk': 65536 } }
 Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16 compression_type=zlib
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
-- 
2.21.0


