Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0A3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89E1A2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OhRd9dcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E1A2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bRI-0008Pg-SB
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFt-0007y8-Ii; Mon, 17 Aug 2020 05:16:37 -0400
Received: from mail-eopbgr140107.outbound.protection.outlook.com
 ([40.107.14.107]:49892 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFr-00087Y-H9; Mon, 17 Aug 2020 05:16:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3xbSew50WxIGJ3MrGR8GLzkr/M/f9foB85RUBvZVY2sxoRJHsKOiLEbtlPIi0BGff3NKvQ8+SEPdcU9K03S9ywYL6p6q9hf4dHGZqTmwY2ZFeEyy2qp3ILia8NZZep13pWSGk03dSwDV1uq1xRWXtClbXASO3CzW77E2jb+19Y5brS/h0CYGdFUZs+0k0r4YViSxlExgx/lPygag9741RW+HsI82wYoCJmKql9V1sWR6OGYPnUCCw/RK8HYOU/n9BKr9kLI/Q5+upbPkv79gUTFsBsrYczJgm8VIPuFUH8Vj3tmRxj+BMujFB2v7twlfvwEGQ/P+taVEc3UDssrfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIFMzK3gNIiORpm5I+2itLEztQCdodDNvWwcDAQTN4I=;
 b=SN1MnO3lJLVkgrE1+Wcr1oDFvsIwoqxwrHA3DiYvxBPpHEodQnA2rpep6zOgPJHUTxFmA/69LpmxsVTbX+gVMAzcQftcq2tha9FQRSRQiB64pR4Ya3xhphNKO9rAZQfBNuSQddI3iGgjuyWrCivuCnp7bDFJFpYeVOFuFFYV2kK88Nx8wxrIcH+CtNSRTMRV+y4SHWw/Wqy5yhJVXuWXrkFjfB1LFBxNaj6REqqFT0E6+hkAftzhepivOEw7/CZ+5O0Ove1SStmFWSCjIKO7rZ1p6MvIGZ0valUD1nNI+K2zeLMzJBCSUl0SvaOLKLb0JIfL/pzenKSJ7K8YFeKsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIFMzK3gNIiORpm5I+2itLEztQCdodDNvWwcDAQTN4I=;
 b=OhRd9dcUUKjz98Ri35+6y/INotq1r0rOSH2ZOBPVEFSmNIxRVUeLc0TrQe/BzPOHTB9LVVMZ0IDe+cQNloCJSQtu87w+Uf4c9uVErAFS3K7dSWwyhSMHnHfaRtkOM+G0lbPMPzsHVzFbr2+JfFQjpFnXgJVur+2I2JHQSrzGFUs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4852.eurprd08.prod.outlook.com (2603:10a6:20b:cc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Mon, 17 Aug
 2020 09:16:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 09:16:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 11/12] block: add bdrv_is_file_on_fuse helper
Date: Mon, 17 Aug 2020 12:15:52 +0300
Message-Id: <20200817091553.283155-12-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200817091553.283155-1-vsementsov@virtuozzo.com>
References: <20200817091553.283155-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.174) by
 AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Mon, 17 Aug 2020 09:16:12 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.174]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc29c0c5-9943-49c4-e2fb-08d8428e2fb8
X-MS-TrafficTypeDiagnostic: AM6PR08MB4852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4852C6B383AA6C90A5F3853FC15F0@AM6PR08MB4852.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:269;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcF8tInxAj6b+mobInF5j790dtb/oDOx0PBD5o3p5Icof4DgQUsFDQph0KANkaT7xsd01YKiAZhA8hJSxB99mH1sW2gyWuGUb5KHuzL0dOHOWheCX0ezpDoo10W5bb/X8nwWrWnCXOmRJHGhmy1n3mC6uuw/pdSmNuM/VGMOS8YzvkSHDzfZBFjF7Lno18la/OI+CUuN2Vkb+C1ZpRbdi3NVjGIFzmVNX6d9NK2Um8QXrPIySU/35bP9we/sR5r1G+AuSGKEt5Skm7CeFidLggliK0bMRj/l7s2PeEJZaQMRxK6bp7nC20I7F+CCWcNb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39840400004)(396003)(52116002)(26005)(86362001)(16526019)(6506007)(186003)(6486002)(107886003)(8676002)(8936002)(478600001)(36756003)(4326008)(6916009)(316002)(2906002)(1076003)(6512007)(5660300002)(2616005)(66556008)(66476007)(6666004)(66946007)(956004)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: c+YDlGIWAXiaPVHMTErhtVBMlEAIzm8z5hLOYq9nl+7X7iLcVaP7WYwq6giLoG1ZHfJMwUgXhqNscfK/G4IhTA1mTkt/eubKfSR+9XNBgNaT+okQtcOXzOyw0p/YtkkINjJaKHzesy3a3L7kXbE3KlBNmRMDGLm1tVli3sxcod4gColznQKDM/iLXm8dCrhiuLvNs+NRJpbcgNGD///kgvKahrncQ0InuqF/+fuWj+Vh/e2K/78STgJxH5byP+/I0xceiz9ghymmNMuzOPoNd8/jIDbHco8UdJraDW+PoK600WJiTmp4EcKJl1Tegi25TcoPveDrbPDZ6UuOHuYy7Ekkb6wX2N6Q+DiNVzrJD1FVEYDPgCmuUQxDU1aSV7uBGTcP/WcHQMyHByJnfioc1nZ2RGtYbjBkaMIV1RRrdi0Q+HsgVhXPYyUarfGuZT0PAmpARcnlbPTmL4e82vNyWq88q3xWrRr260Ohxq1NyI5WgnfkLz/jC5GOtShOxv5qV0LlAYY6koSKkzDs7QFPGcgF5mGz5dNFIHQGELDgwxKQvpAVWnw7WLsAkttbwp+1z04n/M7MohsGtGm9aHPoHTiNzCQqIuRGvjDC+eMvH4kSBYzvZuBjJBA6jfh8WAke8cfDknd6QRzl9Kl8jQ9xWg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc29c0c5-9943-49c4-e2fb-08d8428e2fb8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 09:16:12.8371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbFHE4C+WJLG0EkRKJg9bJWDwRKRGjc1yfQYPFRvTjM6cpTTx79f3BW0r8wgaikXkarNbsMndKi2JZEHvLmbYEeW9F+3p7yzpxWVXymaGeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4852
Received-SPF: pass client-ip=40.107.14.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:16:12
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a function to check, is it a file-posix node on top of file in
FUSE file system.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h |  2 ++
 block/file-posix.c    | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 877fda06a4..51e957f6fb 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -787,4 +787,6 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
                                     BdrvChild *dst, uint64_t dst_offset,
                                     uint64_t bytes, BdrvRequestFlags read_flags,
                                     BdrvRequestFlags write_flags);
+
+bool bdrv_is_file_on_fuse(BlockDriverState *bs);
 #endif
diff --git a/block/file-posix.c b/block/file-posix.c
index 560d1c0a94..4100b8dc89 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -324,6 +324,27 @@ static bool dio_byte_aligned(int fd)
     return false;
 }
 
+static bool is_fuse(int fd)
+{
+#ifdef __linux__
+    struct statfs buf;
+    int ret;
+
+    ret = fstatfs(fd, &buf);
+    if (ret == 0 && buf.f_type == FUSE_SUPER_MAGIC) {
+        return true;
+    }
+#endif
+    return false;
+}
+
+bool bdrv_is_file_on_fuse(BlockDriverState *bs)
+{
+    BDRVRawState *s = bs->opaque;
+
+    return !strcmp(bs->drv->format_name, "file") && is_fuse(s->fd);
+}
+
 /* Check if read is allowed with given memory buffer and length.
  *
  * This function is used to check O_DIRECT memory buffer and request alignment.
-- 
2.18.0


