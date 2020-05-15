Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A425C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415A520759
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nMSCjOk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415A520759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZku-0005Cb-Ck
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZZeE-0002UN-Sy; Fri, 15 May 2020 08:41:06 -0400
Received: from mail-eopbgr150102.outbound.protection.outlook.com
 ([40.107.15.102]:11310 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZZeD-0008VJ-VS; Fri, 15 May 2020 08:41:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uo+Y7/dLEtZAbHZoFOoi72qFFzJJ/lZLqOxTOjiZ+3uMVV21n2vH6mN7mGqUWcICz4S/lrSHNgGAViWq9cg2xKythx5Poxi+clQ07oBas17YYAT06BtU2UmlMWIK7BURgsz5G7OjyTPXciQvbC2cvewy+9cKMux9dU4OYHB3NtXLE+IOc/z5OGHOMRSjhxNBNChanPhkLL4V0/gF8D+Byv4ikZMKYOZU/4vQ5OgTZyyrvugGROQcgx3WOSFCBr+AEiKfW8/2ttJgy/vmiorRPRnyxFBb90O12uidpcR4ncOyazRKp69mGBP/wp6VR9H9B+NZJtj6lSMizoQ+ycGa3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSB2hKNLczbYc9ZqKMwDegweqQ1vr9FoUCy1i1/yrhY=;
 b=Y8MTdplWyJ9E58i+nqTR4yLhHE57Rd6c3jsnYevnBm3mgzAAInjdwx393F8vpbF/fUYVfPQNdaw5GpOCstTCIYcAKuf4FxxN9FdlLPSuh3arzrRGvYtfsnCGu1KpoLc8RCkvbXRBalQwq3XZ+BzkkC6+ikXfEhcU3Jazg4LvjuNesNFG+O1EohPfTeQsuv3IZziPCgQSlYKlhDfSJqA+5/eDT1HT6+ILVXXz99IDyDRZah6rTx60YHrZlJZOfYSn4Yu0wcMfYRBeDEoBu5BbGTb+5C38tpXz/S1Im+yK1/a19zI7L8dG+0z38KU+Mt/E0YAvN/oos1qAMZLgh97skA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSB2hKNLczbYc9ZqKMwDegweqQ1vr9FoUCy1i1/yrhY=;
 b=nMSCjOk5Tg+RI2Mf9cH+6u0Jn5+1xDl1t1hbbQNB8aWTnU09e8pDyVQ8RxEqwwlsKFZsppmilKR7Xfpo8tCjyrJURX9cJlPoX9SYo7f7okfNw0lM1mhbw6Z0nOXpWF4CkiOK9oJKcL0X76l37t65tNBuqFxiiGJoYkk/NH38W6U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 12:40:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 12:40:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 7/7] migration/block-dirty-bitmap: forbid migration by
 generated node-name
Date: Fri, 15 May 2020 15:40:24 +0300
Message-Id: <20200515124024.3491-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200515124024.3491-1-vsementsov@virtuozzo.com>
References: <20200515124024.3491-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.184) by
 AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 12:40:58 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40384dc3-e3ee-432d-8281-08d7f8cd3828
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381C5F2798949C78EB5A123C1BD0@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:15;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUAgAEGaz9voBAd7c+WiVBi59q/g9HKmxhZaFka8AxrGtnodN4USYXXKKbCutG/z8tE3d+xGRchbehr4GX1tcsA1AJpVFYpeb6CXMd+EDeBUxOXi4WWw6m6MmRABriYpB3GtHvjVoxsjC32Mv1vLdyloPc7twbZu2FRAM1jb71ubrHc9+E6wsYJJZF5aueJlG1/6TQCcnLrc+byXn9sQ+H1+y3SpUCpWAJV9ZDhf8wh2RLWcySspATquvORVAZM+HPpPa76iVtVTDdKb6/c1Pk514JvJEmBxwndUrXGAp7BSUIOorMRlIZ+dLOR/LLUbGvo8Pe72l1T2cIB8CsORborx96bWktfz9I+6ZXvebP14iyWs7vbpfV7CuUCfPfapSbziwi3TNnCcCWy4tQkJmtiJ2SoH794vMWOeKRgyKZ1YU266xluU5PC9LCmXj9nj+1TcV1Qu3ak/+watjhuwDWCx5+J5Kl9J3FlRQCi00W0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39840400004)(52116002)(6486002)(36756003)(8676002)(7416002)(8936002)(6916009)(478600001)(6666004)(86362001)(6512007)(4326008)(316002)(107886003)(26005)(5660300002)(16526019)(186003)(6506007)(4744005)(2616005)(2906002)(1076003)(956004)(66556008)(66946007)(66476007)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: j4dCfSXhzIXKSGG5CbbQ8KFUbnCF9q3aseQdDhkHiRx7qaAbzwCttfrqN79gN3yaWOSdubUxad2MP8MRSt6rFOGUvK09dknXFkNz8KP5uOghHvBYrkCuV4+E1VwEBZtCHZI40D30v95M+sUywiU0+qNLKi2/ZShyuGpRDNDojGmi3novMjLLGVotR8FOFiYPHeC0xybR4ZdPOiCRd22ZFWENuS6aNfXKmC5A9Sdg2g8HjzHRz+bTN43uIBU4JT4LqAxoSgSQ6Gonwhl3xhdCsDo8Lc7jeG0ihMd3Ug4vCdhYIUENvhjHnel4ngo11JH9TSNsSzi6NIpuWaLOgIKpkHxjxHLdzICYslJwlnd4ur4i9j7/jfRk5kYmr+oARHRErFSM5qPTolVFnlf7WHcYptBJn4BNRgPCGRO02AV8h5CpjnazNJisgJOqx4k897yKgbGd7seap+U4D4z5eDdRJdVO2Qz+KtsdfI+++SC0LFc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40384dc3-e3ee-432d-8281-08d7f8cd3828
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 12:40:59.1930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghieIhwabVWeVtyJKO0IrIVC7Z7a7qiTAWL2k3e9S1j42ypkMOgfMr1d1+d7CBPCB6S4KprbQGE0Tdbg0FKaasHMT8X8cNsKA4rdXvcILBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.15.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 08:40:51
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
 stefanha@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, mreitz@redhat.com,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, pavel.dovgaluk@ispras.ru,
 den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It actually never worked with libvirt, as auto-generated names are
different on source and destination.

It's unsafe and useless to migrate by auto-generated node-names, so
let's forbid it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index e0e081ce60..f5744c35e6 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -285,6 +285,13 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
         return -1;
     }
 
+    if (bs_name[0] == '#') {
+        error_report("Found bitmap '%s' in a node with auto-generated "
+                     "name: %s. It can't be migrated",
+                     bdrv_dirty_bitmap_name(bitmap), bs_name);
+        return -1;
+    }
+
     FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
         if (!bdrv_dirty_bitmap_name(bitmap)) {
             continue;
-- 
2.21.0


