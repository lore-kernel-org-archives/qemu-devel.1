Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8214C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 967EB24656
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Yi5c55M5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967EB24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfoe-0002nb-JL
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 15:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVflb-0000fb-3k; Thu, 22 Oct 2020 14:56:51 -0400
Received: from mail-am6eur05on2108.outbound.protection.outlook.com
 ([40.107.22.108]:5089 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVflY-0007Y8-7k; Thu, 22 Oct 2020 14:56:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0Xrr7LQrA9GAcO6KnPgR4pPPT86uwuqHgWYnOZMLbbftCLeYtNpRORzjm9Em03BNxlOpH/7aA17xbJZzpPjloQsKSgfJTan6WDrjcZrWup45YhwMl9eFn8Z6O1LMHAovmXjLy06esRORHgqcDsHuHumHd9AA/GDaTdENycR/kfbT1/Hctgo8WezpApEoyezypUq0wdWsTvuI+nK0qxQqDnSx22l7xmk6HaYnuQOP/jeO6OPfvNII0JNawQSGkq/uRKK/05bER1/Kc9P8Z/7ftf2whQ4RwmDZQFWYaQB3F1TyCAuR4pM0aX4FzjK7K+wFJhKElggykIR883VvWtBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xQVPK1UX3aflvNnzU6pFswPdts+z4pNlC4ZInZDxms=;
 b=TY21xUrkEjVqnHIedB4CHvxe4zVPtKYgYQN37vL3gxGOLkdCoaFxUvcgHR2Ci15HFEk5Kpz4B5OzGyMVsKseIEHATzYNJpScOk3VAqciLUjoDityX9ctlA2LuXEj7aRWtWz2n7a3QL5XJCM7P5J+vDvUDrrB6ruK1Drf3Ojl0GY91cTguxzHe2IIK7gz7z+O0E4oTA5o+amfMHtTd/O3I+kd3UVut/q3VsVwA5bOaKWAnXIT9os3HI/1SWrRyCyEg6eaKD6UZ8rdijYeDjCyP9yKKzw8x+4PkoY8/Ds3HNghJ6tA1rA81TTjw4GC6XkRuKQEDxGV+mLxqO16TGjJlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xQVPK1UX3aflvNnzU6pFswPdts+z4pNlC4ZInZDxms=;
 b=Yi5c55M5WJJULvrR5C1uQnBBONeRWlvVim88vI8J6J0kk4HqWj/JG+zfRwG5oToViqT3FmCBLO/ZPtXO6iWYBD7oVLsC0+Oft+tLWhIbeXhXJCTkVDHyPAeOyVSVwdHIrLo6PRVRQ+a06SIdLJV19PKD6PXu9LyhThYTx3neU58=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6309.eurprd08.prod.outlook.com (2603:10a6:20b:29f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 22 Oct
 2020 18:56:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 18:56:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com,
 jsnow@redhat.com
Subject: [PATCH v5 02/12] iotests/303: use dot slash for qcow2.py running
Date: Thu, 22 Oct 2020 21:56:17 +0300
Message-Id: <20201022185627.16987-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201022185627.16987-1-vsementsov@virtuozzo.com>
References: <20201022185627.16987-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR01CA0089.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Thu, 22 Oct 2020 18:56:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7a82ace-0415-4cc1-41a0-08d876bc36b9
X-MS-TrafficTypeDiagnostic: AS8PR08MB6309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB6309F99796F6592EF50E6230C11D0@AS8PR08MB6309.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQ+PwZhlsWb0/uAEqtk5PfH7c/POP19o2s371YyRve7Qzv7dZiPw6vc4EFS4Mp7hun8kQoSUcKUSIDMs0OeqYv12YY5gOUjxoqNJf92QLcVhjCnmKWQQjybiq3YHynkdQoY/NRJiKqhpGmSuFAJfgTZI/UjsVnp0uSmQedGuXDsDoOKdbrzXYvBAPX27IcpS70cKbBEblBMd9xDw97BwSMOcF4++/DJFvmsRGpsxKYq9R7fUpT8Cv/ub+n7FOByZ0ACxJHgqH6iWIz1vXjN+YG3JaH6QvpZN1FWgn+504M/nDgFgaNV92ioZJ8FzcLOOC6N+qqqMvOQ+T3E/LwY+WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(346002)(396003)(136003)(376002)(478600001)(6512007)(36756003)(2906002)(52116002)(4326008)(5660300002)(4744005)(26005)(16526019)(2616005)(956004)(186003)(6916009)(6666004)(8936002)(66476007)(83380400001)(316002)(66946007)(1076003)(6506007)(8676002)(86362001)(66556008)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nsotcn//V2AsK/XDoyiCSuBda6Ji0ZMHQ9t7zVVAQ17Vkw873/fc5X/S4vz2zvxitoFeh9FPL0CTMiIdttw13rzAA3Pm/F0H2X6mK/5GzIHXfQiAhBnw9V3Gqm+3v0GgvHuCJ21ZXfayXloCiPJmyUddGdA/xAqgfOvqJenariLt3rKnEDxChYnEIAdcoQdpx0l4tpKgnqKr3n051dshpJF1y0UPd5cj74HklFsijUMS2sqqUhND9fCHYPjBs3gDXe+hOi1B2LoMNwzfiPLcHMk3NXfOG4ONV0Z+l1lDp+4czVW8BvTgCydyRkipfCDTNfQl3WrVAoRsBZGb9T5bdz5hxQGj4CNVo+WraIVTAmsNee2DlBYbqFeN45jO0AWRX5iWCERCMo+gJMlJYRUmqLFo7IJ+FwYy9yb3vidkDLZXhNMTgzCOhx9Z1t+VVGrTXQ05IgEypjUp2BHg/tBM4UKgA4G0veo9NI6HsDY4S+zg4+rYDvosTjffelFqLawA4FegP6wl8BQI5z2LKy7dKjGHt9XmWWuBa8sBBwX5H5grDoxEWZWTUjTh9GppX+OWmGy6GLQCVgsKel9W/DF1eTZ9873zjGwHk6i7VFQq/oIHBFSLqrNBSuTth75hyqhav7eaKnqE8Y6N3RDvld+0jg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a82ace-0415-4cc1-41a0-08d876bc36b9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 18:56:41.8229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bq8tqvb0K8TAe/X9380jkapMsthS6irddQcyw50H+6HRBNdZuApQgxD7qncq8IoN5GL0lTmCRWj/8ryRTGpsQtUkCQbdwg0DRkPwl8UoTdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6309
Received-SPF: pass client-ip=40.107.22.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 14:56:41
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

If you run './check 303', check includes common.config which adjusts
$PATH to include '.' first, and therefore finds qcow2.py on PATH.  But
if you run './303' directly, there is nothing to adjust PATH, and if
'.' is not already on your PATH by other means, the test fails because
the executable is not found.  Adjust how we invoke the helper
executable to avoid needing a PATH search in the first place.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/303 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/303 b/tests/qemu-iotests/303
index 6c21774483..11cd9eeb26 100755
--- a/tests/qemu-iotests/303
+++ b/tests/qemu-iotests/303
@@ -56,7 +56,7 @@ qemu_img_create('-f', iotests.imgfmt, disk, '10M')
 
 add_bitmap(1, 0, 6, False)
 add_bitmap(2, 6, 8, True)
-dump = ['qcow2.py', disk, 'dump-header']
+dump = ['./qcow2.py', disk, 'dump-header']
 subprocess.run(dump)
 # Dump the metadata in JSON format
 dump.append('-j')
-- 
2.21.3


