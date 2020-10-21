Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A348C55178
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CD020BED
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EroiWAVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CD020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFmd-0004De-LE
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaE-0005bm-LO; Wed, 21 Oct 2020 10:59:22 -0400
Received: from mail-am6eur05on2129.outbound.protection.outlook.com
 ([40.107.22.129]:44322 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaC-00085Q-SJ; Wed, 21 Oct 2020 10:59:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iF3Aa14pZ2JdXJgvmH+q/az5NIFSVMIbgPJhumH88V8wovcWFDRjeK96DIX+loqJ8IL7UPGKuA7RS2eTWOuQoRhlazOf9miYZmPlRKCtFgJI+K1kbYfS3Of5Kmhepvz0DWcyiY0eNiqHxdVhThBAxdv6es7zVixypFIdcz0I3kC7vGh8x1lmnhJ3md7CRMf4US2wE4+Z5FhT8YyHbfs0/bCatCLYAn/XChsRAOvbhkSkkYLqpffadbOkUwh+f6Ggzw81K5kFWKNoczEkgdNr5FLy09Vr8eHo/ti1EUwFdowbb3xVz0pbe4O6EgSpvt11y3nQA+k7G8topjafDFviPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH2aTS9trbgQmhNu9rEnjkjJNcjEs5av4nDYP4x782s=;
 b=EhyWNdFTrHYsRJBWFhegO6IYmhyzjm6Dw00qrz+CuZVAAtLq/fBrySVPjnXUkgMmGfjhyhQzAeDL9CjQ9GCJb9EUZM2MUI4BFUZAhqmDC6Hv20Naqq2WHFbNtgCC0CXvYJ4oe9UjDmTEqwfmOopMUbotc41fXwyQw2TEQ5lvDjCzRl96vgoJBkY3s4OriuyLcqmwy2BlLVNp4ozpgQkVmg1SGqYH/m8W81x9xXa0jnmB1AEBEDo2FB/gwBKR0m9biMU1IYKUdzDMWi3j20o3zys3L/uNn7N3i0NiQlVoTRb75L7oVB6Z9NaoCVh+Gj4pvsYFl4DMcHE6xfWFR28QRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH2aTS9trbgQmhNu9rEnjkjJNcjEs5av4nDYP4x782s=;
 b=EroiWAVJSdSusOVU9IIGaRXjlrZWpy8CdocHjuorWvVpFowxct7ccZYjTaYY4IgrOw76yFyd3WPBx8wPIwq1YZMzGYlneKA7NKDyC81E0muwalZ0gZTFlHZ2v1X9EcAJNHB1py7zLgP1UQL7kIISu9S9MhhG+qhO6JxRUwFBoc8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3541.eurprd08.prod.outlook.com (2603:10a6:20b:51::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 14:59:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com, Alberto Garcia <berto@igalia.com>
Subject: [PATCH v7 01/21] block: simplify comment to BDRV_REQ_SERIALISING
Date: Wed, 21 Oct 2020 17:58:39 +0300
Message-Id: <20201021145859.11201-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201021145859.11201-1-vsementsov@virtuozzo.com>
References: <20201021145859.11201-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4b43b6b-3da8-47ec-3cda-08d875d1dff3
X-MS-TrafficTypeDiagnostic: AM6PR08MB3541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3541298618AC6D7E03E920B4C11C0@AM6PR08MB3541.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPtc1R0dadnvFMydiH3SbIwPIGOQNifTqHrmENvcCbJv8vgw+WjVb0I93sAp7qNk4QaBsSSJ5+RsgWPV8WEM1CtynauFhPTMukQG0mfwmwwLIil7VOODj7t0sOBmxy2LxYOntVr55JqN2DQB0V06mFPFMiF76OGwlIXjt4/xw1v4qlaATLFyVp/bCXp0MsR3iRSsPK4GaINkifoBx52QMZsVghISpJEZNqQ3hBrTsBjHy3bw+8YSgB0qRwd+KumbpVlKC/mHr5ueHnLzSIN9CFySQIQZ62DhOBtqwIUDgE1H/H+Ll/+HTgMTx628+DN4FjUdmnKbVO/6sd5pKQJrJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(346002)(376002)(396003)(136003)(6512007)(8936002)(83380400001)(52116002)(4326008)(478600001)(6486002)(6506007)(8676002)(186003)(16526019)(2616005)(956004)(66946007)(66556008)(66476007)(6916009)(36756003)(26005)(2906002)(86362001)(1076003)(5660300002)(6666004)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nBmoEalIZ6AxM2PynnVsRh+t9bDuPzZxjDOmsZvFDnR36fpN3Z02CFfCbZXNGrQwiP05UaQ0u2Iv7b2B/3raxZFlUIXxbRCoxQFlce0BLPZsYoLY60D76NqymMdAssj2/nXauqCdo184YTvoGohLV6AlB1RzMDlWyATwV47H9MPwz9z6EzL20HBs/9YDg2aLfgBp4OEoI4ue9l6nQdEXb11evMiDzxw8Un6/4GmsJIVnyw7TZVC8ay2qZbsnx0pI4O9jGIbW1ShjNqD29KArT1jh07+CY4+7QFj0aya3cwZTG6eyTzYA5yrlrEq4LM0NxInmLsHX7xLvbT1OxpFXeIoangdQ05+QqRtdEPQFtJsrp0Xqb4dnqbvyhp6B5EDlsQmNAd9CdKDbOEI4vdDsd+yjo9cCwdgNLy/RRH0ELa8NTvGXhO2JjHjG75PKW8GWkpvJL0L4UY4cnhq7932XhKCjitvhOpeu1UrPCzel0FufLrlbNnfupOd3IpJ/2CQsPOzNrEz4bLAj51+E6SsLgLuAnXFJx9ty7vp85gaZQxOdFYWib5SB7cz4/dJVa0tS8ifxPd26RS1okUgZ5KldI4myGnFoyZJWcmF/yszS/4IsykbUZlE+WNDgZZKk9Mo8CjxkGZdKzZnQwOsZVK3zzw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b43b6b-3da8-47ec-3cda-08d875d1dff3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:14.0313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/UjMPq0qH/7CgnCRbzBOqfosfenc+X6oO1pjlcjx4xjTleP9ztGA4YjEyHWuY1j+mk1gdHdSZNy7zAxMCqLhEXenQ7azXqEslJUMQRT3mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3541
Received-SPF: pass client-ip=40.107.22.129;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

1. BDRV_REQ_NO_SERIALISING doesn't exist already, don't mention it.

2. We are going to add one more user of BDRV_REQ_SERIALISING, so
   comment about backup becomes a bit confusing here. The use case in
   backup is documented in block/backup.c, so let's just drop
   duplication here.

3. The fact that BDRV_REQ_SERIALISING is only for write requests is
   omitted. Add a note.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 include/block/block.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index d16c401cb4..f9ca42fd4b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -63,16 +63,7 @@ typedef enum {
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


