Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8FFC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85B9206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oYkAs51I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85B9206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8pX5-00056R-4M
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 14:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pU4-0000f1-3d; Thu, 20 Aug 2020 14:40:20 -0400
Received: from mail-eopbgr00104.outbound.protection.outlook.com
 ([40.107.0.104]:1630 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pU0-0003CQ-LG; Thu, 20 Aug 2020 14:40:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBiRo/UBCqb/Ty3eTZVSxkxGszp2uwf6OLB1rRg7w37MJ3W6s4o5MVqfHwALBC3g8bfF9MNjBXRPRaHyqanaH+ytT2++q/oQyzSFqRLC/8xhkLB7DR36IhT8e53Q6mj/OVoU1R5Q4Ei1of70nhfJNdiz4LFIjLCs6HXn8n4PvOZl94UtOhn2L+lbzMYDPxT9TI0VBsVOsWxkbL9o+Bzzt/kdtuo0w7+yRFzRYMyEQ+0I08CjdCQS7iQBhxfgWQXKJhmAhnCuxREPo3l81RkyoBUdBoNLI8UL6kbYFdJ3k171DWjX9XQtGKv7OSGE5s1ZG8zcF21HHru40HtZJg57WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6ADkc6uYMLabKqyv9ENA7/hX8HBJxK5upg5p8B/ZEw=;
 b=NU55x8MyL95otdMvAoWufwfYClk+DkiNBgvCrPXKvgN2h4N1o/oMVIcjM8Xg84jZi60mPQQRQeKFusojqyA/WQKvAmVzQVnPj2/yeWg+rkVz03g9g6rpdLx/pWD6bAdwV9VBgyvjnEn8m6fNF+D/U00gGDEnBM/iPByWSGd9eozeu2YBeXFJ1or2831XfM/O4JP6BtJxyU4JLtoUbJhjDC1owNPtxHtN9YtrwcQSj4ukVeub7KU876G/i7v8iVfnF2h+FXwnxKVjd43RwxPkvq4J4JusqGQRvnm2xYtAEH08x1PuP6xYdGLZdpHxM/gt0tuewRKjtB9J4mi1jSsuYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6ADkc6uYMLabKqyv9ENA7/hX8HBJxK5upg5p8B/ZEw=;
 b=oYkAs51IndqwbZjPANADAN5XEAoGMqpCVZPwQXMt3RF032wLHIBlM+y1+iUvB3M8F4bQdxqcp0V2GNJaCNaJX7RQm79YvInAQ3wXHq5DZaBqoTE+ONdWNy3GQh27pnfUWol01c6GUFvAp/05k7wIQWzNmerxUkOalTHLjW0qgP8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 18:40:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 18:40:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 01/10] block: simplify comment to BDRV_REQ_SERIALISING
Date: Thu, 20 Aug 2020 21:39:41 +0300
Message-Id: <20200820183950.13109-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200820183950.13109-1-vsementsov@virtuozzo.com>
References: <20200820183950.13109-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:200:89::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.171) by
 AM4PR0202CA0003.eurprd02.prod.outlook.com (2603:10a6:200:89::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 18:40:04 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ffcc4da-8d39-48b8-b771-08d845387472
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB30329586B3551A9104C9D2D4C15A0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXQhYPOz6R9JYiHo6aLzPawunKaYYgM8un83h9oDLjLkt+jvJjvgJSocb0Kx95U7jqi3IqBl2QhYi6xxTuT2fnYnJqUnxCGSJtcDRP5zYIp3xMeFicw5QfX85LODMiMMpV6Dm37Nldb2DmyIoaalXgyDz1qDJ4X/Vhgq0nbRsRX+v1FrT2t0w5Y+1lX8kkpqEEKTu8x+T52WwpAnlQaFmQRaa/iTPqyj9xsADJR6ynYTEr88HZ3TDdKZsVeKguj9jbiIyct0ogVwml+hNlS7UBWRLZTwZAbOd5U8FJw83pXr4jtsYWvZN132hSCqfOQMgIQzwWhejMfj2avjuDTsXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(346002)(396003)(136003)(4326008)(6666004)(8676002)(16526019)(186003)(26005)(316002)(107886003)(6486002)(83380400001)(36756003)(86362001)(2906002)(478600001)(6916009)(5660300002)(8936002)(66946007)(66476007)(66556008)(6506007)(1076003)(6512007)(956004)(2616005)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zs5MA4mhq1cD7ueBJa1GLShLzC11u2wyIJuoru6WETglEoEw7Nsol5pEIqjdGARbolvR5D88ZVkWEBScyzgEnWHmc9Ru1rHqxk2hPQ47rVHq7faXSj7k3bjK09TRo0BhQIS60krYZo2y75oQrTS1c00qrisTH87Z0T4/ICOpnetg0/0K7OOiII9wmDdWCh7DbZ2Fd+IFNcii6YBiDfoyH7MZZAjk8a4RT605xR6UbEu7Jl0gz+pK2Y5+9otLMxQJZCpaqK24pvEVvzXEmt/Sqfe1I79UtUX5Kbdi4ce04FTctSInwKP5vur8tXcCcwsNghqfWov+aBPGNqhOlvqxj1BRpIQzsKAMLLKR6GXjEXzershB2m9VeoeBkS/2riPiYhDCgtVbyWg3zfoUMl/VpB8F+K7vWvpQXvBhR2rRZ1BZpCVDPoPvr31krY95KZdfNOfK8GdNncp9JplIl0x7gEcgK7CdQtQbzOsKLlQn8Ttlxkom1Niqn2aCZXnDv+6DXJ29WeAOVNz1PZbbB99qzW124/DdnYidKv4Q4xxfMrsPzX9NizgOkpSil/qvZgwfKEfnmHJaGQuYIsjZEh6+O6X8qLrvJ8tjc+9YOmWTXWZqPukr5bQCkUOfuNlCeFeHtvUlh4mU9De+UMvZIw02xw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffcc4da-8d39-48b8-b771-08d845387472
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 18:40:04.9106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/h7JLtHK+AKFiKmX68la/gXghj1zB8+U+4SJQNebbqYdzKluvLJqwjBw/Rxy7Ly+RPi+pMH04LSotDttAtjniVTuZb2SGZ/KgpdxyDk7Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.0.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 14:40:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.21.3


