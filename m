Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B6EC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E36E206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AxL4rBnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E36E206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k097f-0003qX-K9
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091i-0001sW-CA; Mon, 27 Jul 2020 15:43:10 -0400
Received: from mail-eopbgr80137.outbound.protection.outlook.com
 ([40.107.8.137]:20036 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091f-0003fu-4E; Mon, 27 Jul 2020 15:43:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j25s9zQ3JC/BmvpPM4wTgiG0yv85DroHKfqc2Uww+4o7BfZald9lZlGfdHjkAHMNPVJldYGDeAbt9+eeyenCkReZp2GNh5yS2K1tqYrhTyppzir6VmQYibI6BuDCwohF9c8w3/zdPppaKiAu21FV/z2s0UzHjpCLE+OnocrBsrAh5kMjFP8IaLM3kFFDkb5/+aMyUuTW/qPH/NxS7AK06YpamjuM4Rx/x7ZY00f054c579//s79xa1Zd3WQQIJ9bRmN79ymOKDOByQQBjtSo8HeCXduLxVlVvKmKU4VndpB/OpsQf3W5Xtgh7Ta3OG0+TkwoJbLw2ZZHZOMjWxKMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PLiYKOJeipp4Ek1ln6J5zdMDZ3rMS492RpkiaOFiK4=;
 b=RZEcBIKIgQrszh2TzHmFrf5RlQQnWIg+RaIS7+i9ZjHE9myQDi0L1+FZWLwwO7lkZzaD2D2fYDAwGXY4j9o7dJONhV4MNOsOGvibQWx5tR/WsPKk89J0BC2rEsuzVi+qo2jzmKWOIUoa38wEIVdBglPVtn/JsllUFgJ+BqlMG8dQgEncFXw12mRKpqMInBdurGwRmxsicN2gb+QWqow/g809U/77hK3fbcoiPRGasoaK0uOHVjcY/iwH+9cPFCJvWFzwzFMgCWamr8oRTFRZDurO1rQXxXwtrpLuuA+879zmNPyDuRJf4VYCLSaZGnqTZ35cEzdmylW1nO95j1ZZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PLiYKOJeipp4Ek1ln6J5zdMDZ3rMS492RpkiaOFiK4=;
 b=AxL4rBnFAmaoeAx1gItezqc5ssG5vJ6eiWC0fyiEQPqTR8IF0zPSzKw7YCO+CQGhhmxaQYRwe5JTdLibUKTrrpE7ZNvwgXiMdVemCfCUhjIK2/IDiHBjzCrIHh90RAaEuU1RPnZPEQMQpoqD8ZTLy+gPHsU+a47hbtwbF0JsZnY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:42:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:42:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 07/21] migration/block-dirty-bitmap: fix
 dirty_bitmap_mig_before_vm_start
Date: Mon, 27 Jul 2020 22:42:22 +0300
Message-Id: <20200727194236.19551-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727194236.19551-1-vsementsov@virtuozzo.com>
References: <20200727194236.19551-1-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 19:42:55 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e037ed8b-0e2c-4e52-634d-08d8326542a9
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610A7CBD316387A765597A5C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrZ0CoYMixd1h0kauhOrUAYjGwcA3/TotH6ACmr3IJOA5rtVWGMi10TK2nh2srrn53VV345TM1KbpZ0Ezvovlu+YpZeRn4VZ3j/c1BYxSDOm0TxpwazvKVS9ZOjEmJVfHETYPcj59Ca5+w1OgGFfcZpX827YXocS3zdHb9elyLVOwl+7sQw7JJtLYr8jPg0aQ81MESGiqvzfNKIzygUfQYnFNaUSfjm1KuMwGIfCk5/AMSrLH9JFKYRg0hZSuFHX+dz5EuHc4pSHVbPK31w0Q3NdDTzownfCCsQ1b1TDmq/K0vK8UKzluJ3V1eru5yhvJG74gD2mIS8BX8awaGZbswZMn2R2TB3JAg+yZc4nphHVN0B0l74jzb8TiXDLSDP8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39840400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(4744005)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TYUFXXjCegQvpeKElqtytoeO0op8ujpjlxURT7NN5RCvTuoMACNvvxDBDvt/9n8Oj6bzD0588Nz+5+KBMKA9+GSWFvpJy/P4bh5vFsLZh1NoHMWefk82T7K3+iYJTdUt/x/W8t+4ly8aYLeBIG8oLfi35gByjPAfIv6sRNWZErH+92GLtvN0i/97ZEDDrSR5gXW1KF527v/O04mx2dwFq1SMxgOUTo3N3LMpWvDBpvjHGd7I1RA23xld87+B9WOtwHhzcsa1uoG3p1u06lQE6v+DdTi0PnNIl5kAM3M/1rAab/8fUXCXvegt+kUYGFJzIleYm9icapFBzWEbkXE4ZcxClx+EXvodhHtQ8ppYLwW/3f2O1hQxUH9XP3XRE+6TLr7isDhehetrAZmfbXO/dvRqYBg57xYijAZeJErMnGdbfwaYqPDBy4xrWRPMu+kgFpl6RYtxiy3lx3Zbc/gYV+wf0zewdUaCtamB8RIQBIU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e037ed8b-0e2c-4e52-634d-08d8326542a9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:42:56.6688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzmqCQfgHAPifzKyPV2pfktNE6/RITDhO3enHKw47obXeLHICiPS+wHmQWcpuvvhI3EPSJnUpl+jm2zyq1FaMRNtqF/GvDkv3U3a6TfwJfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.8.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:42:57
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
 quintela@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 dgilbert@redhat.com, stefanha@redhat.com,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using the _locked version of bdrv_enable_dirty_bitmap to bypass locking
is wrong as we do not already own the mutex.  Moreover, the adjacent
call to bdrv_dirty_bitmap_enable_successor grabs the mutex.

Fixes: 58f72b965e9e1q
Cc: qemu-stable@nongnu.org # v3.0
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index b0dbf9eeed..0739f1259e 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -566,7 +566,7 @@ void dirty_bitmap_mig_before_vm_start(void)
         DirtyBitmapLoadBitmapState *b = item->data;
 
         if (b->migrated) {
-            bdrv_enable_dirty_bitmap_locked(b->bitmap);
+            bdrv_enable_dirty_bitmap(b->bitmap);
         } else {
             bdrv_dirty_bitmap_enable_successor(b->bitmap);
         }
-- 
2.21.0


