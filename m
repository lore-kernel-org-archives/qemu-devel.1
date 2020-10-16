Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E80C43467
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E571320874
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mHkILYbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E571320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTII-0004kd-N1
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGF-0002xt-Vl; Fri, 16 Oct 2020 13:11:24 -0400
Received: from mail-am6eur05on2128.outbound.protection.outlook.com
 ([40.107.22.128]:42592 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGA-0007NG-Vz; Fri, 16 Oct 2020 13:11:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOdvY5XhNIeVEWzbnpGtlIMcxHC/h7Yg3x7Dw/U9zXiqoB3+HgUChU2PswtQBshaLa0HWcgHWBZBsQMKcih8vZeOm3N3a+LcMHZ5YAIORjwiJnCUVZTmVop6D/4JF/p+wl4nRRCsXN/1bHAEZqz1S+YtA/ZPZzH72s7T+huqc8g6p4UVeP8GxeKZuFhsqikPHpFzSAxRIMYvlrRF9UfoHciylLW57pYJ5gkUFQEkGGgopsZh+8zEfWyL0e/WFWqwkdymgofNGrV8aOwaqQ/1cy5s+tHCk6yrCZlGnNebiZSjGyt+c9iJhynHTOy+pAkKYiU/ZMjGEnYso9lb/DZRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BASOl5cr5a/xNG0KYxJeYCAgA4LpgWDox81XUShwKVE=;
 b=HKZtIoSOUkrPnSxWmoMKHrDsJPIBXNXuaFewsoTGWcz4RmA3pxn1eYBNDnmpHGy2PAvHQ+wykmTQCIB5NEschSSo/R8BEoZPhVhQtNHJOfhedRdQ0j7VBDWXJbNxftNrlSpCxNtt8F9ZIRmAL/dcjVV8t/doOEkUDn6Vb+SU3f+2el4/5tRpFfRBA+bgTh5zv9BmdnDfF8xDp300Z3pBjTpvYFCukvad4IQe+qaMv3AI/gHyYeUcmd9D5crgG3hZ48eONbLk4miWih+8FIWimu5B2zY4w2G5mZCHhf2bH9RUGlvS73qkqpC8jNRRrcv9LWKPMfnY1sbscUm10RxUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BASOl5cr5a/xNG0KYxJeYCAgA4LpgWDox81XUShwKVE=;
 b=mHkILYbfM0onNuS+BWQ/XqwD3t1+gBBLp0gWxz8xTB4H1JPjjd9ZLgC4KvAZTEfeG1pMYA3S+MpFpA/AeFwZWI6G8tFeEfRsfmlyBfCxBf5+cqD1JKGwiSwcLlH4jySssbdHVY2acUqu57ckeKm6PmjjCmuNkes2UjD9vJqVpHM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Fri, 16 Oct
 2020 17:11:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Fri, 16 Oct 2020
 17:11:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v3 04/13] blockdev: fix drive_backup_prepare() missed error
Date: Fri, 16 Oct 2020 20:10:48 +0300
Message-Id: <20201016171057.6182-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016171057.6182-1-vsementsov@virtuozzo.com>
References: <20201016171057.6182-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.69]
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.69) by
 FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Fri, 16 Oct 2020 17:11:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e61748e5-9fac-4364-a353-08d871f67dab
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54955F3E32A6A284F1151B26C1030@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eO7xg808tiJ6dIurPcMIPvaXhBmMY/EIZsBYZVOK+N83Tay4BDPs+sfrifVlRTEU1xXYxXfPH0/q3QwvmxaY8XZ9CtZ6kTYHPeIsQbOl9/4GQSiB4f0OXPLviAoJYj9z5iAbzQ1wgju6ZYoc3l729YkZ73zNWnhooXDfGOV4K65OWueS2Il7Nb6F4JemHUzr0YUuoxkzP7uB4dRiX9/FIXJBqPya1JoPCNy1W5hOkrD+VgEvf0PfB3n9hoQDOwy7Q7vdW2wd+eeIXSTtQzSvyygJmIIxKcu/FYRxA6Pmxp2T873fXcpBq7nS1l695ZQEehq9f9RCRJPpLNNUFoQvxrZdD6rEPY5Vg0ny2PbRzu9DChAVmED0re77DvnWSGWk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39840400004)(376002)(346002)(136003)(66556008)(316002)(8936002)(36756003)(26005)(5660300002)(2616005)(6506007)(66946007)(86362001)(4744005)(16526019)(7416002)(6916009)(66476007)(478600001)(34490700002)(6666004)(186003)(6486002)(2906002)(52116002)(956004)(83380400001)(1076003)(4326008)(8676002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cM+7KtuUup8gYM7JVgTeaSmeew9Z9KHZHwm9ljtNCcXk1aBM5T2DSmPC32avnUzfJYT7kZWlHnaxJo7FvI4+OuHkXSKMJcZMnEDZRbDfvNAsvsV8M67YkaQioWvYo4i5pEmJikSbZb3jwhOflemp9TVmEAIHD/0miOvCDR+VAkegnV8N9SZSoeHWDoMDuIBJESuYOC7oig+9EbIO7U9fO13HWJvaaWEjCFOD+biF3zb8gVBtsVymh24kUhfJrVPQ/Mp/5oTPgM/6ytWA/Y+13fnKVKZnsRh4eHH8bl233NDuKTLROr2lTtlKUc4qpHmJkSEmX7fkyByf6VfcDYWJWFi4x4NIRCu7zKbLkNScnAyZS/9TWfKhKiQLn95+KJ6MkS5xuhHR00RHXtB8LRllW+7gfEvfGMQ/FdaxK0eUOFVZ4lc6bmIDNcTrMR71qdV8TtFsJv6qTvbTLaxNvfk34mtlso/ZUVrNoF8nvL9EhnWdwm5hUp8h0Fh2xpdZ3dhdqwdTUVkhe+o3d9LhbD+adq92Un0Ex2t7ArtePFLJGbHB624g+KyE3LeOHYLaczcf1x5lCPrxV6ZfgYwrozXCgjH2Abytv1LVl4FzU6VZaFH54g7+N5gAVsAe0NbZROHsds/7q+lUuNSflzeudE+kkQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61748e5-9fac-4364-a353-08d871f67dab
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 17:11:15.8533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DN+fmfS9cZqBDzpjV/3wruRHedENWhtH/gGbKiz6xt9tn3M+mQ6/wO4nxIQYGT28RLoFpTJv+KoYnU3xAZOgvHDBGkgtxaODu2FRSm7E4GE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.22.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 13:11:16
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

We leak local_err and don't report failure to the caller. It's
definitely wrong, let's fix.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 blockdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 3a896181fd..db59be7c68 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1823,8 +1823,7 @@ static void drive_backup_prepare(BlkActionState *common, Error **errp)
     aio_context_acquire(aio_context);
 
     if (set_backing_hd) {
-        bdrv_set_backing_hd(target_bs, source, &local_err);
-        if (local_err) {
+        if (bdrv_set_backing_hd(target_bs, source, errp) < 0) {
             goto unref;
         }
     }
-- 
2.21.3


