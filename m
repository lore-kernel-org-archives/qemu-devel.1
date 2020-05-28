Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F526C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB83208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hs1zSXqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB83208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeF6Q-0001IW-It
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5M-00083E-Om; Thu, 28 May 2020 05:44:24 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com
 ([40.107.8.134]:2978 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5L-0002k0-I4; Thu, 28 May 2020 05:44:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQNwDur1DXqTAZ6UViT2xM7ADvnSH3Qo5NKpxUJMtLtiOcJx3b+++WCEc1gBO0kZ/6vGYrdjzAGiQYgsS/MSeNPoe84ju8srpUZyQa0yeaUn6M9vfWtulGxeC18tspE/8y1OIe5xqdWeCRxFRzgIWsGv5z5rHKpd5ObNFHHhTE5TrYnGmaaVwwtdO8K6wyzVFY83tJbJnrMURseao5M/QTENNap6NbS2bFFt59EuTwOb1yrTVLuOMM80ZSMrgsdqk60Gj20jFSqsGLdkVvz7J0zLpyXQEGuEcuA5zh8FyG2hDJEG2sGLB5eIKpCJce2PQTZaqBK5cEmQMnixkmt7WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXu/gKq4Wl67OR3F11VPGh+VLwJw5TVF+p9rh/Xobss=;
 b=VVYLHPvV+B5k5QxtGwO2t4uJ57QAnGk0HsWkZpmk9ZchQ5SMVzPYXU6MrhWOqitZ9/NrWpzDSg2RWJZLfUX3iybngN9fsV0PKDMSyfgui+kuyNRrStcZz6LLUI4qSE8QKWUOz2JQpxyR6G4NM4x0QVCTT9z3YURln4dc0uQ3rBx96MJdnvVfIfJgUrhH+yl0AXfGQDoDkBU1kwOTOEluprUAKkxv8kUC2q7q4wyLpaMvm0Lc7ClArSnfmZoaWzFupI2CiCjZH7ki9MAXxSuZK8UUd0k1m876NmUdwoqsGmsNacnzofbx6k5LgGGaV8Vb/jC6Nm+oO3myNTAx8nCP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXu/gKq4Wl67OR3F11VPGh+VLwJw5TVF+p9rh/Xobss=;
 b=hs1zSXqD+hsahug2brHo01+FsTyaaePfGVOQFx40Vd6p56Ot9U1YGx3dIyq4NWTXuYp06RzLwAa34IHxfChnQaOmcPPMgTdMMG3HGeJQIU1ubhd2hbNsEn+EReCZRegW9ssF+t0qBwG6MOYZSfV3IHmHFSaw8pVtwZmdyjtdR0U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 09:44:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 09:44:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 01/10] qemu-img: convert: don't use
 unallocated_blocks_are_zero
Date: Thu, 28 May 2020 12:43:56 +0300
Message-Id: <20200528094405.145708-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200528094405.145708-1-vsementsov@virtuozzo.com>
References: <20200528094405.145708-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:207:1::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.localdomain (185.215.60.178) by
 AM3PR05CA0089.eurprd05.prod.outlook.com (2603:10a6:207:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 09:44:17 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07db0098-5513-4e65-a330-08d802ebb1ca
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5366C57BFD86C0DE449C18E5C18E0@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaoEKw0xTRVlgMTV8Mg1w92KnfxEL/motoRjIkGkTugBgPKDXidAF1QxLZa5X0OHxzXdmvVMsCCyBH+HVw480JI+LzhWj685q+WTsRTJ2M826sni74rbxfqOwPhie28UqTUrKnWa8I0CUWY4M3Z6QcRtBME8CopWmXNew/LzAI3p7a0YAqW0hfliAESZqC4/7d5PRMfofD1XvCgJBJS9NnevnGA6FHonYcbilq/1xHvg/HaQwMp/QVI5BwHCRyJXr1Xmn484fKNsWW3hOd5CCP8C1qjl2KWRqV0Zf7svbvSPMLB4ejOoxE8kSRxlD9Y6XtQuwtS6I6A1Ddx/3gKK6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(366004)(136003)(346002)(376002)(396003)(2616005)(86362001)(316002)(5660300002)(7416002)(956004)(1076003)(6916009)(66946007)(83380400001)(6666004)(66476007)(66556008)(8936002)(4326008)(6512007)(36756003)(478600001)(8676002)(26005)(186003)(16526019)(2906002)(52116002)(6486002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YKLNjKB58vn3RTN6jJwgWpK9DSyhrk0oL/NLHlJA2o6rnv/w/CmRRltG+PfFCeL/DjjND0iU5JIu3Lo3ij2jG4oylegNz0dCHnzTRZlEWBQYYGWVP2+yQciW0ZZ4VRBkjckeHw4xU07g9vi1X7mOyCz/cOqY++yvObYBDUKy16+EYLk5k8S2QVG4XinKkJb+IIol/Xn4OUDnwVV6rhXEwsIBYxYaWZn1YGx2XLSNStX4MzSyt+SGEO5BW4TasZjLPI2LPTYr0XF9FLTudiIX+8HnNBH0AhLC5qs5Pw7WFk2N35fBgkbeoLWEhv3GbMjP9kL3wbJ1VEQcRAe7Ke14CllSvF1BrLCnM0Yre+O/dlG8GtuaFBNjZ/sUxbiLW7aPGFPuiMjIhYIgtWPFmnbdIfXBQZw49hDm53bDmIAcpYWWaFKzCzqOFndRacPZ2dGrebp516vzS/V/tqh0IxJmjxg4KESoCDfwHAwMEoQdtro=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07db0098-5513-4e65-a330-08d802ebb1ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 09:44:19.8931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUr27YFy5d4ALZZM9iblLSK2VjaPG9bVStqZOEfyatLEl0X70HradPzuKUfIUNvbTr2hMa4AprboVi+iPoICdvYDQLtTT01BWX4VQXK8zMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Received-SPF: pass client-ip=40.107.8.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 05:44:18
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
 ronniesahlberg@gmail.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu-img convert wants to distinguish ZERO which comes from short
backing files. unallocated_blocks_are_zero field of bdi is unrelated:
space after EOF is always considered to be zero anyway. So, just make
post_backing_zero true in case of short backing file.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 2d30682f12..9fcfafe470 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1660,7 +1660,6 @@ typedef struct ImgConvertState {
     BlockBackend *target;
     bool has_zero_init;
     bool compressed;
-    bool unallocated_blocks_are_zero;
     bool target_is_new;
     bool target_has_backing;
     int64_t target_backing_sectors; /* negative if unknown */
@@ -1705,7 +1704,7 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
 
     if (s->target_backing_sectors >= 0) {
         if (sector_num >= s->target_backing_sectors) {
-            post_backing_zero = s->unallocated_blocks_are_zero;
+            post_backing_zero = true;
         } else if (sector_num + n > s->target_backing_sectors) {
             /* Split requests around target_backing_sectors (because
              * starting from there, zeros are handled differently) */
@@ -2610,7 +2609,6 @@ static int img_convert(int argc, char **argv)
     } else {
         s.compressed = s.compressed || bdi.needs_compressed_writes;
         s.cluster_sectors = bdi.cluster_size / BDRV_SECTOR_SIZE;
-        s.unallocated_blocks_are_zero = bdi.unallocated_blocks_are_zero;
     }
 
     ret = convert_do_copy(&s);
-- 
2.18.0


