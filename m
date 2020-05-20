Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED8BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8C1207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RUyuslmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8C1207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKF4-0006PO-CY
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbKCe-0000mO-Fb; Wed, 20 May 2020 04:35:52 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com
 ([40.107.8.90]:21573 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbKCd-0005RQ-CX; Wed, 20 May 2020 04:35:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbzGMFWvhtjDoBta6blByiSlmgPYW91Kyf+Xu0MjrqGYgksYu3mKOvW69X+FiWPaLoxpv/9Yq1/d69trRVjzaSuPJ4HgjvU18zg0ckRK9Nc0SBBFV1gfo8eZW9X5xtAaEKHFk7kvKTFrgGc+1NcKkekftOoxm8+bSf/IPmG0FRmn9RHSXP+lNx2XgdWdB8fr5HkjfWconnqlFQ6IVMk3tC/ZVjVO8FFbyE4LLcetSZkECx+0xNkhxjRw0hEGiN0vFMaHc27iNbS4/i1EafaozNnRejfKyxv/i/jf3BWHe5/mkOKG+h1WFQIHxUGvQZgg8a4jR637l/dSTJWc3IE12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX/tbxLARYZgvdr5Dz0gjygHDRRy/qk1VQmWfHv7dnk=;
 b=ILPdiKSy90wNL62BgZ24J4LGwkeeCnmm+WnJygLdzwsXe7pUYi8HRdTyyLQHmZnd45FVsduB2YaEpt2KkF7CACWD1S4q+9TEhYDPhL24J7Y8BxdY0+D0IxPgQ28DqM634Wh1c+jri5YNSv5vzKKXRMgqFFUATzqtBV8DEkEcp0doQR+KW7MFU3fHdVrqOeRPPKsfJLVV58j/P9dTH1FqylfQjh5JOWn4cReT8E5J2IJsYP2Z+aE5aOHtRtFBTHxoHWA2YJ+NzAKpUepXZIsLm5/tAQQcVpMFbeE3pTcnqURb94nwmLLbEuuX0nwvVWJ/kuwGzoqo7DWimhrQatkNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX/tbxLARYZgvdr5Dz0gjygHDRRy/qk1VQmWfHv7dnk=;
 b=RUyuslmqkUWnLoUc0E4RY9l11dCiNe4AuJS6vaZKZrOWz9gbuIPNbzhPZO+AwdJ4POjb05/Ko5yc/PxFN0Kj6CG2ftoKk2p5Bcze4X51WMtL59F13yGI7Rs0DZ57QNKpysXjf0ZWvYiy3cP5kQ5d34eH+s/4XJb6n5SznkFDbWo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 08:35:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 08:35:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 3/5] block/io: bdrv_common_block_status_above: support bs
 == base
Date: Wed, 20 May 2020 11:35:18 +0300
Message-Id: <20200520083520.25793-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200520083520.25793-1-vsementsov@virtuozzo.com>
References: <20200520083520.25793-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0092.eurprd02.prod.outlook.com
 (2603:10a6:208:154::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.147) by
 AM0PR02CA0092.eurprd02.prod.outlook.com (2603:10a6:208:154::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Wed, 20 May 2020 08:35:44 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf7e4f99-b408-4aaa-ae10-08d7fc98c9e2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5448BD2FC128CCD8550E289EC1B60@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pO/uwQJA8fBNABCpsmlrehezth3BNNTlewJtqUd2kpsHB5Der7Yeh5R6Vde5bXMHTZCOte27TxAHjd9Q3of58htmMH8N64ByjJRwX7kYcxDIZeQztkCrI8VDnj8kTDcRyQj691YtEhQncD0Yeoav2SaYj6jxe0gsSlaaRdgbAWAZHZeT2BPFmpEc1sTk8kJnYyExmMUQKmYkrHxHONap7XAo9ygs94c+qyPygdZgIzDYp5qGMdl4j7TkRRecZghVlNdoDy7KUr/98Tc/QdsMfyxLQsue5VwCD377Qrr4t66R3YBppYWNHpgfQ27ukYdYDlm4s851Z4wR9x10SFm0pAbMUoKPtE7RNZCQ6gBY+ZrNNFyW0YJMwStQsANegOPGuqBNxJcgaMVREam2rFJ/Xrq1UwDC0rta+jXPDuO53xNojKOoSJfTlqowQ/K9mZm6GNkigyh6EEXCn616ZEoyk9WDGBRGAugXmY5QsGBxzNKE9Ej9OWNaJERi3/fuH2j9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39840400004)(6506007)(4744005)(26005)(8676002)(6486002)(52116002)(186003)(16526019)(1076003)(2906002)(86362001)(5660300002)(8936002)(36756003)(66556008)(4326008)(316002)(107886003)(478600001)(2616005)(69590400007)(956004)(6666004)(6512007)(66476007)(6916009)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dgwAVYyvEguKlANv4be5okoLRmwSRX1ot68j1x5lJ7su9qJy27PCx4aGzCVFUYEDd1+p6gBWyqXnSPKx2GC0bQufQ2X01BfeTNM9w1vUdha6k8N0r0xVnKFt8qPzceXNHULfcUqowLblpx+S1wACic8CX7DlGYfr+ypPiwsoLX1fsc9O/ddO4iO2v95togC9MXsV/eI7l2bBRdz0DyuIcbnorgX4ktWxampNexNgX+RBmS77LckHW5vNF3SLshua5D6KpZ4rzsPJMIUGqW62vlH/Tm1W57CIt/udxiiq5wKu6x+LpxaHnh7LoyO1/knICt04N5Lgq8VzlcPs74quyppE2QgJrFPcTJfCGIzjKg+XflmSWWxyZjNuVqdRoFF7s5iFP777ZKypryqZMKBz/KIO+OHkB0syQtxNz60qJcpdxMqut20mtUiKgQXOg/uZHQL0Y4QsI8JG+duzBE2fVhqkfdRVq729wiS58BZ2hd0qEN6q3i1o5BBi7qzNSi6L
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7e4f99-b408-4aaa-ae10-08d7fc98c9e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 08:35:44.9903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KX11LwpFI8bgNhvLWYdfPijjLcOy1+nbREfEDXxkKwsbjqP1no8rY3rUbRRpMQLkY7eB9Jn6F+l+DNAv2SFG5sr0ZA7zqCxraqMoq1X2164=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.8.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:35:42
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to reuse bdrv_common_block_status_above in
bdrv_is_allocated_above. bdrv_is_allocated_above may be called with
include_base == false and still bs == base (for ex. from img_rebase()).

So, support this corner case.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index ae1c806720..6f90b322f4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2458,7 +2458,11 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
     int ret = 0;
     bool first = true;
 
-    assert(include_base || bs != base);
+    if (!include_base && bs == base) {
+        *pnum = bytes;
+        return 0;
+    }
+
     for (p = bs; include_base || p != base; p = backing_bs(p)) {
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
                                    file);
-- 
2.21.0


