Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CB7C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D5E2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dweBF6Hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D5E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bRP-0000Fr-Ow
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFb-0007Vf-89; Mon, 17 Aug 2020 05:16:19 -0400
Received: from mail-eopbgr140107.outbound.protection.outlook.com
 ([40.107.14.107]:49892 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFY-00087Y-H4; Mon, 17 Aug 2020 05:16:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lS5EVBYJsDAh1rZgS1dWmiFiUWvluZOtvwkafAKUQaeR6VjDKOwkbs6WCXROwojpEGYE2aQJkovKvoO6APluuSis8ICNL0vhuMbNAiyrXYoL3QGN1Nho4sFlRYdKVNQBongJil5HQJLy2DKJzHVHXt6k5lFeiy7b/pNS0eFg7S52tUHgd8lpohypfbZ/S4zEaO4/X58PEDQtU572fHwd0iIYh2aFPwELGz9pgGcEYD2v2Hz5WrNrG216Z8R0j3OtGEn0NiQl6GfawlVu6ig63sdfnSV/AGBLNKgo7/z4jYOc+60fV1Ug4II1xdFhxKWrdeq5vxLTCstUnGFeyQUejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m8rQuUx+OzptYRz38VBXXuVMUS36aKjqrnLFpM4dVE=;
 b=VNqwXR51Q3vqI1Pv6Dtqtw1zzKE8kjnoZw/7aUmG4X18E46kmDJRgqNJF8I9lnG5J3//Qppau/CiunFGQt4JwzDLZJiVqchPHKXKQAy3njg0EoxE7OrFYMW93+TJbhCwroXI+0ZuQGxaGz2giY0dZV5iZOUrcaVfWzkCoTz+4GdfchKWN3yEsQkBta/WVbErv7nD6/qJEyCGBJ0UX4G72fXCgY+bhkXFS7a4CgMembkAWI9kaZWZQBuNb2pR6XLD5xgiyJZsidU0Bpm1fLdxaC3jeKMhETIkjJHzfIQIp7mOBfuImWMdp0MrN/DKkAyah/6LRH+N+8uaUCIoHVOyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m8rQuUx+OzptYRz38VBXXuVMUS36aKjqrnLFpM4dVE=;
 b=dweBF6HjgLZDHXxVAHbw3l1nULlCrnbmn3Mt7kHe4kf3rwglSEf8tiOMECMtRHVjB8pEFpIZvk/GulexTWJ1PF/5uHTjFJhbQ3NuApgYhwFfthQAdIOo6TL734ZSlv/hSoGmLLdLJ4fAnMAbGdVk0pgwraxkWsqzdCQiOE8HTUw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4852.eurprd08.prod.outlook.com (2603:10a6:20b:cc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Mon, 17 Aug
 2020 09:16:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 09:16:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 01/12] block: simplify comment to BDRV_REQ_SERIALISING
Date: Mon, 17 Aug 2020 12:15:42 +0300
Message-Id: <20200817091553.283155-2-vsementsov@virtuozzo.com>
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
 Transport; Mon, 17 Aug 2020 09:16:02 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.174]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d00f7bfb-b85d-43b7-6e6e-08d8428e2a44
X-MS-TrafficTypeDiagnostic: AM6PR08MB4852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4852DAAD905B157896CDE5F8C15F0@AM6PR08MB4852.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZVUbTuHCTW+oahQhYgZqWcyT0ei1ZmyIniMESc1ceOkGWSEB4vginJfVrSutPCC7d9t76wCti+xCMisdEiKE+w/KwDVJBw2nsrIkCQRqRY4thzbIsoid70I5o1RR4jfKfINmnayla18BLes0NGpjoNsn4JqoTxWKCxiEx1MEm47hBcnHzyvc7iiqSPxiM/npQx0xdx6NdgnuuGW7wc7CRSyNJlE8H6oJuqmHg9xzTOIKRr9wdC8wNGOWO6vbqHWbPRZsVY6IM3wD7o4ygeqZaX96PPVIJPjSNZ/SfiMH0M8FbYtKuyg8DOmgg6jN4pmxZhXEw9QN2lmf2i7fk4TzNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39840400004)(396003)(52116002)(26005)(86362001)(16526019)(6506007)(186003)(6486002)(107886003)(8676002)(8936002)(478600001)(36756003)(4326008)(6916009)(316002)(2906002)(1076003)(6512007)(5660300002)(2616005)(66556008)(66476007)(6666004)(66946007)(956004)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Frl5gTU/lgg5BC7oCIay63Gqjwhfj9l87nbSdOjWdGUwizUFXBrRKhT1NmMtkCSxQxEGS8UDkzMZa+XRHQH84MF2W+OJuNMUWUWz9Po4uIxkfQ6QiyrTJlGJInYz+ipbImFocHnKCUAohYxLb7W0muJsNv+eew4PyJupwsvyhO7tPre5y/NWEHpZ3CAX2Sy7v4kd56fILuoPYts90pTwS+ORvapyW29tHR2vwf5MYwY3O2EWtsUqnZjwxobmQ2EU5dag7iyo31sSG8pFP17YfkmU3HJno2Lo9WweSnPsM+fMbZWgKquCqqN4PbfXsgb1ygO9j9FwmSRKVBHqJdGD3iT63V4DwT3NWaGCoow2QOglfhxob28jd7BdBpO3N5HY6LTFHppqp21P5vOf5J3/0uIw9MPMxUylOx3lu0nUmpMJ7sxZPYNSoWzIVr711PyfSRslslX6hV7GZ2wBTabSuPbXufHqO/sex34dxLrSVOOUtNiUZPiIxwVWJKbhcWuv0elhjkg45GJTX8fbr1QmJOw/h+eawogYI4n+WASsa4usgR+CAPdwSYEPZYom9xxnfJXZ6K3NXUsJxVIyLrD9u5H/YiqZDSJcuDbclALDipXmenRhO4BU4IgJbapwqgJDW46xCtSvtFFUgpbxNppG8g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00f7bfb-b85d-43b7-6e6e-08d8428e2a44
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 09:16:03.6395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgUfPLKdywfTXACqOh6LGTlGQMg8/adLWNu3pT9h7Q12kZqAGeUrHG/eyEifQWbislegY5oyiHDNd4V5dhBj1HILpU8M0e81O28OxcJ3hUM=
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

1. BDRV_REQ_NO_SERIALISING doesn't exist already, don't mention it.

2. We are going to add one more user of BDRV_REQ_SERIALISING, so
   comment about backup becomes a bit confusing here. The use case in
   backup is documented in block/backup.c, so let's just drop
   duplication here.

3. The fact that BDRV_REQ_SERIALISING is only for write requests is
   omitted. Add a note.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 6e36154061..b8f4e86e8d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -53,16 +53,7 @@ typedef enum {
      * content. */
     BDRV_REQ_WRITE_UNCHANGED    = 0x40,
 
-    /*
-     * BDRV_REQ_SERIALISING forces request serialisation for writes.
-     * It is used to ensure that writes to the backing file of a backup process
-     * target cannot race with a read of the backup target that defers to the
-     * backing file.
-     *
-     * Note, that BDRV_REQ_SERIALISING is _not_ opposite in meaning to
-     * BDRV_REQ_NO_SERIALISING. A more descriptive name for the latter might be
-     * _DO_NOT_WAIT_FOR_SERIALISING, except that is too long.
-     */
+    /* Forces request serialisation. Use only with write requests. */
     BDRV_REQ_SERIALISING        = 0x80,
 
     /* Execute the request only if the operation can be offloaded or otherwise
-- 
2.18.0


