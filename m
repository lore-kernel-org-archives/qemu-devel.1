Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1BEC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80658215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KQWFzame"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80658215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5OJ-00075A-Ir
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5KB-00073x-3g; Wed, 09 Sep 2020 15:00:07 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com
 ([40.107.7.118]:32002 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5K8-0001MM-5Y; Wed, 09 Sep 2020 15:00:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBj1Rhfnynl2CjuvPgco6IxPIGXKi3YDki1Lv97B4D79FNnhDVLGmf+FwT4ufEa3leWa9tRokCbBxPfrFIYzpbf7nsZMVuR1D/01p4WsTt/S8AXsFqKUvk8Cymq6AgNIwPtt+zAMkpFDmll+yo0IomqP9q/Oq4tA81DJM9Pg4pVpjTli5mFJkByiOftbM2QUZE79lD5MHHeUCPu/F03yVUtKq5AANQQ9PUQdjz3vbFQXiyq2y5xPqsCSio4asI3fJmNtXw5u1vbj1y+1mMeCQyQMa0VdCKwsHOs4m4unrMO2Qw+qehOf3N5FbvElJ1S7anzF2dOrdN21Wr21prrbfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mW4I7KHBzeDfVLQKA/gOyV4J2sqOW69KTqoEJ378qM=;
 b=NPRe64kF2n/1wSgxDYbolDQXPlEN+drvxLdYC0oqce5bdULhYT4clWjYlF6AIZ9w562oVvHh2a/5BIKcdWb7VE1/UwzCDsTj/dJp+fI4pPfnkr+qLejMUlOX7u6/zkRHYZ49CX387SmtFypuVyvk8ncTsBAONPdICuWe8L6PwagDe9kl9fKwkacBocWQgXvnwZgv8oACdMzq+wtYav1hUzXoMj+t+GmUfR5QEPSHMSv+M8D63S9NlXTHg/Qx+mWv1iinLwITennGFZA8T22sXORQhStP8hXlYaZQ+uNSfDmkweNeVbZNIoEEv97Urd2ng3obzOvcvpbFr4pg4la61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mW4I7KHBzeDfVLQKA/gOyV4J2sqOW69KTqoEJ378qM=;
 b=KQWFzameV4i/c7UlWIfxU7lHA1toQwByM45iZgBqG684bu2hZJj+VqORZOv3YQe0oG1BFtI8j7CChZGiVlNuGX48Co7yp1RikFOp6iuFTGI1rnMWvuYeHoRt5VyCiZSiA70Rnb5kQ7qtlDQUEASRy7m9NMlSOLoENznTOe9EDu4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3445.eurprd08.prod.outlook.com (2603:10a6:20b:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 18:59:55 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 18:59:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH 04/14] blockdev: fix drive_backup_prepare() missed error
Date: Wed,  9 Sep 2020 21:59:20 +0300
Message-Id: <20200909185930.26524-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200909185930.26524-1-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0054.eurprd07.prod.outlook.com
 (2603:10a6:207:4::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.136) by
 AM3PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:207:4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Wed, 9 Sep 2020 18:59:54 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62c5c997-4e19-417d-a59f-08d854f28a27
X-MS-TrafficTypeDiagnostic: AM6PR08MB3445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB34451CB3B2EF63E78C27314FC1260@AM6PR08MB3445.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGdSdcdLiuKvO7N83ngmBAMFelUl9PTMgSoT+aH6+iTM6t/4foyBqkAE+YC/+iU1KUDEGyFDcV12WaL3H813O45Zgb99DR505shGseLUxVckoa4xHObpVgahI3xE/MUrdCHcNDqXscfbTm+CkXbrOg4VbW2zlBn7zIve/exBcIIojDWZKG9+gXZrvNVHYlW7CDrI5cBDi27FrPWBO5cawozGdIFuGlSNJafFGl+nl6R5bQJrekPHlZ+DGI6AXAzTmTctb2WYX42LPEUmKE41sK0hDrGR1s5n6CcrWWutVpSdvVJVdniOmcNR4BOoFJMK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39840400004)(376002)(346002)(66946007)(52116002)(83380400001)(4744005)(2616005)(956004)(2906002)(6666004)(8676002)(6512007)(1076003)(86362001)(5660300002)(26005)(36756003)(6916009)(478600001)(6506007)(8936002)(316002)(16526019)(66556008)(186003)(66476007)(7416002)(6486002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Tzxqfh8tAMe6qi89BSBUHT7vSOITk0kBFi32xcJYpOG70Wh71lO4TcrDi/47bqDprrVamebBUPvEHOR7xGg2vlbYA4idbOesXRvRgWT3UmwvfSQ2+d02QvRbWbmQuMhyhd0SpGoa8V/d2X/CTVpdtzeC+eQMLIEpGU/2xx/l2FZAgYQMh1phNAh5mIeTN5VRPPOWdTTkMMqyY7zJKqtOI1YeufC8DPZhXqdyvCqHoI8Gvg3mk/3ZRu/iHI4Djo/ca2NQ7T7KM6QZeMhC4RqLeikUW7EvFjrAI2tRWp4coIeb65bxfGayK94wdhva2xlZVfZ7581QK/Bf4sqeTQdhW+GUvyqEszGtlO9W6q8nA5GVClRcrnFd+96MmOcqUqohJybEETtch6e9RS9Es4lD8GfuXl7unKrCHW6XjEZADqly9N4j+LEAv6WHZ5AQ6Tj7tQjoW5FIudh7LtOzrPjwJOWx4p7ijKQhWE41eGozOidaVAThqGC8xptHxPVtzggmidbJ5XooUYHCPApnPq4aHfZzn5GlHcVv5dEAidqZay4URtZ72Stl6ZcNDTqbY/ixgVDuDTgfopGOU9nHVcvaZEacHxzgpMKpw3TmstWE0K2g8VaeEqd9CvRuUGLYUV/N4V49nazvzvt5dgnnmvHTyQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c5c997-4e19-417d-a59f-08d854f28a27
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 18:59:55.1350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83P0+c+LkfFQ8FdlQjJ33BC4J97sDDlLdKpPrZp8NexiTH4pi/cDbOvXL00A0CRfYTxkIF+fMgIJSeWpyaoucvTLNQ2WvWQZ4LpMnVZf3Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3445
Received-SPF: pass client-ip=40.107.7.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 14:59:58
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
---
 blockdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 36bef6b188..74259527c1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1797,8 +1797,7 @@ static void drive_backup_prepare(BlkActionState *common, Error **errp)
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


