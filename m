Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD070C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:20:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7CFE2073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ub44yxjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CFE2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfp3E-0007Bo-RK
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfoud-0005GD-5j; Mon, 01 Jun 2020 14:11:51 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:39047 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouc-00026c-8N; Mon, 01 Jun 2020 14:11:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaVEGV1Q0G8BQ9Clj0TCg/RFljGm8XjUzAluOrE/31byWEq6WfDQnhKFGvoTIS0xcrrZ+ep42jZOgGTqgMg7SB9ZnkRF0x0rHjLeXvSNhQqRz+EcuxUmn2kS4aneZajjUBR+npkZoJDOyMn0GbqBP1vdVaMEJJTZZJHEbADvwcfkVo89f6di0goN8G4orEM6OJ8nampPGB7+PeZ0kyFOjjB+wV7Cz+M7k7CYu9dNXQUl1Zsuyiton7COut6ULSkrWkGEPalZAaaC76ulM9xTlj6cGcxoitOPqQ74DnEj9921jf8Qow6uNQciSafU+EbvT39+8erLULM4xn6bLUOvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h82TpyYMbuKPfS8sjUB/b//yqwwG7Jeo3MhfNUlVMK8=;
 b=Tkii+hwrAkAx5luQyWZ/pYv0PP8mivvFpH/AFsD/G8BGMtR6DnohqRS2UelE8l51r+qLhnf1w87NnINRWjPLEK+Y7/EJPcceaxEko3nru8JAQy05uz16c+cz0uAZ+963e3JHnTBKGUsCwdwZIISpt4h2c+g83WEkQGSv5CeQEqJqDyxFRfKPCufSJaigve7iEzUO0v+Cgnkc/Ypet6ZB0aek/TBmjfIXybulwy8RApOL8EXDjPBSmp1wuI3TDi8uvbb2hWuuN3B3kkggAKSWywYKXdZqmuXsA1QXGPoC/uBqYh0nHtfWsW3hA31UsxDgbzicShrqk2lI0F5vPxjHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h82TpyYMbuKPfS8sjUB/b//yqwwG7Jeo3MhfNUlVMK8=;
 b=Ub44yxjRf2P1ehJMehu+bZp86dF9PkJHYS2Qh2bMnN+ZBiSPWAQxTnF8IbXwqzofzOFpzCzavTYWXrsy/ek+pK1SfJ0L2nj+Db5kfTQNqMR55qXTdFJaEqVbTnCT3/JQ/+JPNuWDKZ8lwU0+ndyj9dZb0gb5e9uTft0tVr6JhhU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 13/20] iotests: 129: prepare for backup over block-copy
Date: Mon,  1 Jun 2020 21:11:11 +0300
Message-Id: <20200601181118.579-14-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200601181118.579-1-vsementsov@virtuozzo.com>
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.170) by
 AM0P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:41 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f870c227-7dc6-4e9e-bdaa-08d806573cdc
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53174E7BB2B5B13845A858B8C18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BvaCRRmYmZXMm6uf97o5JXICcAwRP9OY0dTEK1ZoCGhIjxaIh1vm2NNIMpo/HwtCpFG7ig/ZtikGajTjmMsahynvkPVM/EBOxbFBsqZ4DJS+wS8kOfunRm/JUKkcdZVVu0D2qivHSECFjfEPaJPSFp0krrfqPwX3KcaV4ViI8ZDvxsfoADIXwoElD2ALqixfEA21UABDzs/cz2SXsBc/BRuFZUVb26EEHVZveONeWByqRSxoM3ZH0VL4i9zKeCVYSDsYreW8mqY5aOC/XGg66ASbtpl/HOyQ888orG3cwPuplOIQ/SuieMJ2t8osw80saP4euBYZD6K/REI0EAthiGo+27/L+CI+6aStbdrFAO6DKSrVdytU2kHlGzgFU04S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(4744005)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: r/mhPF3G0ZxdZwmRikjRbhmCoATTqOoZIvXOWEFW1EvB+UvBJ3RMFnF1hoPLqPujnte2Q2VDDRuEON69wYNxWrzAUibpO5nwEnT6MC8M8B3aZgxFFgaDF1mz0cD+y2I2BXrwFBzNUcCkMQDonl1V13aAvreURd6dVU1AoHvlCSHW0u52H9iw0AckUOm+bnhGKrOmvRvR0r8f/2wfJl/7IaI89pBCvx0xcd1R5qkdUIYKuC17hdi8KOVrDaHNvclpv/fqJAGB30J1jO07O5NhMDRcgV2c0fH0vQL8wzyYbXMEYRO5YxwixC555Jo68x68J1jooVBN4FwOebKWmRceg3nw9+LabK5WzrcXU3ds+UrMjv1OnHmYzZMVoKwr7AMZIDppXGEZYyUI3oXi3w1RC4zJ+tiVVkUlFDRGrK1H6tHCMa+Hv7V0OzRoFpitTatzKRtK2pfZlOzJFdG8tCnsAbIdt45LJfpSy0B6WgazE0g=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f870c227-7dc6-4e9e-bdaa-08d806573cdc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:42.7260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4R78oB6xYDLQdmo4RIeUohcK4deBes/iiD0qhYcmlPjL/Aki4Zar1XHXGlDGmlx8jWMXsUcDmR9yutgbcCAHIOYoKfklmytLfdXJHJhGzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:32
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After introducing parallel async copy requests instead of plain
cluster-by-cluster copying loop, backup job may finish earlier than
final assertion in do_test_stop. Let's require slow backup explicitly
by specifying speed parameter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/129 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
index 4db5eca441..bca56b589d 100755
--- a/tests/qemu-iotests/129
+++ b/tests/qemu-iotests/129
@@ -76,7 +76,7 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
     def test_drive_backup(self):
         self.do_test_stop("drive-backup", device="drive0",
                           target=self.target_img,
-                          sync="full")
+                          sync="full", speed=1024)
 
     def test_block_commit(self):
         self.do_test_stop("block-commit", device="drive0")
-- 
2.21.0


