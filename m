Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5781C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CD622265
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FnlnhlIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CD622265
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrPW-0002GQ-0f
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIk-0001Qe-Fw; Tue, 20 Oct 2020 09:03:42 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:62453 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIi-0005ZO-KZ; Tue, 20 Oct 2020 09:03:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXH9HEXPSH92ftCCJJCgWWTBTz0ooZFnWpdX1tgdEFvS9PsDgnZL61HoPWl9CKvnJ7oKXHJVL7/hhbIEHZFhNzn7B4O6AYYWQnqf1DmnUfTW/RRy66xExDpkhhvEl+RX/ETtCr+QdiK76VTuSv16aGsYP/32VyGxtuPsh4EBQ/yBlPh62SL8D/YRznIdNbWbSRVWjwab1fLNiPgGXCi20SR9x5sjID7imKs7o4p0wDgdc+wuHbNEDvfCr1XIyFh7DzhdWD8bFl6dYQbxoisKQxZahYRu8JvSNdz/wwX6SvmJqJaqYHTVRTh5ed8tW36bLSomf04Y/M6v3CFutVa0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bM/yDRO6zZvK/PaX+VNtnT0xtbWXErol8S6UlMgxI8=;
 b=GsjEMC++a02CwID/K7bPWHkuCK7lncHPWCuxGTkzlDEf4mAzP7fz+tOIhRKLl/OTDh0OXhmdXX/Ypn5IXELED5YbmgDB3ERToNA0wCVlfp9W3b4vDp0zFWNgXq/gTOsrbNrpgilIhBBM7TqkcIxt4qdWUQKjzx86eotUumbICHvXou6sudGn8paJD9QATchFcO1FwssXeTeKLdJe6pFHKxSIq5b19V2r2I1Yxbn3iKNxx6QBrAyBQnc5e+xT4Bx0Vv6PvmIdNMGQWr1r3Grtz9nf2Vv/9Rk+xC9SDYnSEy/PLwSK7kv20xX/+GWvtxT65XFZjAvuzCWozhio7xu1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bM/yDRO6zZvK/PaX+VNtnT0xtbWXErol8S6UlMgxI8=;
 b=FnlnhlIJPlH4W6dSRimQA34/NVEzylyv0f3vLOmijpTe2cNXpWzHQDPCregEEmGYcodzBVve+p5BfXjveodSmxIteq1QXPv+97p/CdDVX1fUlWuHisxUUGW6ozka51iGnk/KgUUEv6TJRSwvkGgF1kLO8vuEnngPbAPhbdJrW+w=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6168.eurprd08.prod.outlook.com (2603:10a6:20b:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 13:03:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Tue, 20 Oct 2020
 13:03:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v4 05/14] block: drop extra error propagation for
 bdrv_set_backing_hd
Date: Tue, 20 Oct 2020 16:03:02 +0300
Message-Id: <20201020130311.14311-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201020130311.14311-1-vsementsov@virtuozzo.com>
References: <20201020130311.14311-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.66) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Tue, 20 Oct 2020 13:03:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5719d080-a832-4a97-8d8c-08d874f88b12
X-MS-TrafficTypeDiagnostic: AS8PR08MB6168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB61680C17C538B562A5D99229C11F0@AS8PR08MB6168.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWmqy/5r3q7D8fF58VPqiINfUJ7dF7sSm/66Oxz5widlZ01+pT0zbBnA0j5jzfeTbenLwIgtngz3BD/Ze3bOwt7D4KsBo/WoZCghrf4LasvO228Yu6F1NXYyU5hEfjX28libGJwYW+wYGJtOSZG7S4X32BF1WDgf6YGaNCzqI7CRl7lhv8CbOkFW6QczMXJXkdrRWe41g+/Lmx9kPC6Trqm8PhqQm5Bm9AWIVot6Xq2auA/P+HEnP6yZwfWO6kzcIJj17sz/6hcFZbS6+wLYCylzUaJBVvhw6JLl5an+3lv3lljCH6gyUKSrlH0mMcjY5mANyEWjdDF/LZFyUtIbHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(346002)(396003)(8676002)(66946007)(16526019)(478600001)(8936002)(186003)(5660300002)(52116002)(6506007)(6486002)(2906002)(6916009)(316002)(83380400001)(36756003)(2616005)(26005)(7416002)(956004)(4744005)(1076003)(86362001)(66556008)(4326008)(6512007)(6666004)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: RDvkIaWY7vbiwamqIQmRwirelSa9m4cdbVT5a/P4/7akiqy5JrHQG+RuA8M8DU6Ok3c8fdEMyDdbA+Pzummlzb/QaN263os3TQzkYtMe2cX3+/HTAsWRnO2oyxuVw+jRHH4NoLosLfEoK4kUxzqF4UHe1JLGbJG2rOG9R1fd/X+BTdSXeMwCN99eJvrnldYcP3m/1tFf/W8s55Mo5adWeXAub35PumJTj33/0AOY2T+0eTSw7aZEDtk4sptnXQAW15R0Yb6gp2JS5k2k8Sw8f6hTMZo/y1MhVVSbwg6JGndd//vbo+MjKwtbdCeSVZU/0ZO1iW6dpEocqIsDSdjdMj8CZNc3UNKmxeDVQOnJsPM1K7oUD65d8Juiw972lA74f3znpNDA5P5OvAVSCxJxPyf9y4u+SFvN0BnUz740qFQHOV6cPTtTNhykogbnHFS0XdQRCwDfa6QIlFdXfEobl3PM7050uGSDJzXf4yOtPBx60ckJ6rD2+6X0wxrSDA5wdQBagIFKu0qGPv/ktsqm6QtFPvGGBRyZwIZLuhbTpVUTedSVvXtxogGFUKvBB3r/c+iiEtvWqyIr8RNxTBOiXeNj5VxWFcbVfNT6Bnr9tF2gWsaFsl+xKa83t7JL9Vuw5GfItHZAqveiyPN6Ixm/aA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5719d080-a832-4a97-8d8c-08d874f88b12
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 13:03:30.8598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wlviIcmpqcDA7/BV1SCbxUKH2qnjoXPsFIgHMj/wPZDmgb1oaJPikMgo+7zROtb1LvPW7TzqGTcWs54WXXLtYsocGqwZItnfnXeoBk8UeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6168
Received-SPF: pass client-ip=40.107.7.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:03:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

bdrv_set_backing_hd now returns status, let's use it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 46d4ad0ea6..0ee36c1869 100644
--- a/block.c
+++ b/block.c
@@ -3018,11 +3018,9 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
 
     /* Hook up the backing file link; drop our reference, bs owns the
      * backing_hd reference now */
-    bdrv_set_backing_hd(bs, backing_hd, &local_err);
+    ret = bdrv_set_backing_hd(bs, backing_hd, errp);
     bdrv_unref(backing_hd);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret = -EINVAL;
+    if (ret < 0) {
         goto free_exit;
     }
 
-- 
2.21.3


