Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A45CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3A52078B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gmKo5KZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3A52078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbtPW-0003Ux-6U
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 18:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbtLS-00048E-8h; Thu, 21 May 2020 18:07:18 -0400
Received: from mail-eopbgr70104.outbound.protection.outlook.com
 ([40.107.7.104]:17734 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbtLR-0007vC-Dw; Thu, 21 May 2020 18:07:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZvB/5XpB6Q08tSHkPxlkrZ+8FYS7Rd4fk0Spue8g7f1kxzEGUtK1aEbaE1yIGYQk294ou5nXShmmljtG7GtLWcyYM0saIilvVL6IDp2JDwS+V4pezvQEkxPYWkkjXeGEStt8imrv2QEtz6CYW/6t0i2BFdBLv2DkFiqZ1Kbb1nz/TWUyyQAl+ZrpgDr2r4a2nhcle9LQa+vFZDx8cdOe8woUxHhzEobV13V8VzkFFKtpQyx1WKnucTMEs9LbtQyEsaBFHW1oxgFVpoGfK+j2w1zrsWe4AFgsDP9Hc04oELkGueAJJYQ1KNNtbK42NWug7yiMg/SIH/ATDxymNGrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nh1oSws41SPggEtrgs3Oo8zYiqbmB66j9rd1Csi4WIY=;
 b=mHYfcrfqmRkauqt+p/7StBwuD6oWWqZ9k8Xw3eQO6I5auSzjRsfdXI5DPeE5JvTEQ1UGKdpjJVuhF90dmGv8bfzeXlJHwy5sUQh7hx9OBhQyvv68f0JRdPkUuGkALJiGiPs4mn8UleNZHzcxzli01HVkKOOjtVBtAHTRVZbYJ5xj2+MHMbOb2NDx/HSN1fAf1i7xhXAx7N+Fni3xBv4Z7OWR98gEUTz/0/stay+Mbo2r9gpCvp550kOxgSDuMiGLBTXZShUffftogDD8K4vhMYl2ldfKztNm08BpZUCfdWyOINg1LbxGqryr0hn+pGbnUQrpghIRbpFCMaTZpkndJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nh1oSws41SPggEtrgs3Oo8zYiqbmB66j9rd1Csi4WIY=;
 b=gmKo5KZcHf6NvJzYVlUazqJ2ywZ6deLLbUA/5XzgBVeEvGnGu6rzFzJfkCCoDMaAq99/eNA2S/KCUjfHFk/sGX66aG7/XsY568hyI6r3yrT9P5S6ZvtkDk/+SFSVPqOhkJ+12zqWtuFNsxlWFFl+pbj2c9+b+g2sil73bzQI9MA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5512.eurprd08.prod.outlook.com (2603:10a6:20b:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Thu, 21 May
 2020 22:07:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 22:07:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 6/6] migration/block-dirty-bitmap: forbid migration by
 generated node-name
Date: Fri, 22 May 2020 01:06:48 +0300
Message-Id: <20200521220648.3255-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200521220648.3255-1-vsementsov@virtuozzo.com>
References: <20200521220648.3255-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:207:8::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.167) by
 AM3PR07CA0137.eurprd07.prod.outlook.com (2603:10a6:207:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.12 via Frontend Transport; Thu, 21 May 2020 22:07:06 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93fdb6e3-2c73-4770-9fad-08d7fdd34d1b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB55120173FF8591C6B2BBCBE4C1B70@AM7PR08MB5512.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:15;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxixpQAQ+MZf1Kt5WJ3O+k9488LdLSqfELdMz0Lqyemvc9rYpXrA3h2000VLGL8otZlnrnq3VrOxUkgi108/UTesGOrc2JpCbcY1+U7PTbnl+M1Bd6I/qMxI/QiYUtzvXtF1eQT6QywlHnGeQK3Z/qIKLn2q6cyyhcad2t+a5MB4Y4dKaf6vCEddYjwieMoKLXyS9sBtXjMbH5rwTSynV/D9LJPdTioGWipwTcVRCom1XYTXzsUtzZKpXRXFp14NOY/VQuvJOgYEHo26UOAykeiCx9GtoqWmWammchDoqSAv2z4xEr2zAMKyf5Fdvv2/uCEazfRFw2U/70je5fydVGuS+xJIbq8Q8zJNRfpXk8Mkjf6pK/GFRmscIngcL0fzclkESxY5BViaBTpCB5EGvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39840400004)(8676002)(6512007)(186003)(26005)(6666004)(2906002)(7416002)(16526019)(316002)(6916009)(8936002)(6486002)(36756003)(6506007)(1076003)(107886003)(478600001)(4326008)(66556008)(66476007)(86362001)(5660300002)(66946007)(52116002)(2616005)(69590400007)(956004)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pe0rNW1ir4LQ3ghbP5HCgW1FmaP0euIjQDpDfBTEr8btXYtrCx3ZY8PL28ihAAK3cd92047A7t2nYxCggWMcSb2kKB276ywc99pF80KHBFQZ0RRNSl6C9yM7ECqeCDSYAljnhD04V9lThpYcuv1dUpDG/qDEPG/QwjKHodHvU8YrJKGM69iAFyp5RqRbvHlBh/pD468uyCl2IpATl6VsZk4o4OOE8mSsS0GMpmR6Mg4fGC/r58CLPaI26arjiYJAfIKfxBBqIFdqrXPM/dW7iwpz1dxyuspZItei1IytUYfYVSDO8AHCkx6wsVMd2cG2Wn75Wc77Z2hsgzPUdvdo2MPqjgSrb90AynXIvFqVkRpo0wmJH+Z1/QintdMAxONGPhU1Ha8LQdWNg7H2WgSxDKaC0Sk3R00+eDruNP4w8qMojwY3d55EjXJxhMziThtYiCV0kpm1SFeaD2uVjPMhoLSerhmeBWkVwfQnvasMhuQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fdb6e3-2c73-4770-9fad-08d7fdd34d1b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 22:07:07.1987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPRtoBk2FVzA3DgueYwB0zBeCSIgGjqvbhV74VKlh4ep1vn6rHHcz5HKSdFG+u4SQnxYqkwUhnqpj1GObJrwkoT4fhm+vTseDLgvvm3zEvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5512
Received-SPF: pass client-ip=40.107.7.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 18:07:01
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 quintela@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 den@openvz.org, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It actually never worked with libvirt, as auto-generated names are
different on source and destination.

It's unsafe and useless to migrate by auto-generated node-names, so
let's forbid it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 65f2948f07..71528581e4 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -285,6 +285,13 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
         return -1;
     }
 
+    if (bs_name[0] == '#') {
+        error_report("Bitmap '%s' in a node with auto-generated "
+                     "name '%s' can't be migrated",
+                     bdrv_dirty_bitmap_name(bitmap), bs_name);
+        return -1;
+    }
+
     FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
         if (!bdrv_dirty_bitmap_name(bitmap)) {
             continue;
-- 
2.21.0


