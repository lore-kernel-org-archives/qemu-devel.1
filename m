Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89A1C8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A612078D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TsdmKKNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A612078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8cY-0006jC-Ii
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bK-0004Kz-7O
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bJ-0005lh-EC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:38 -0400
Received: from mail-vi1eur05on2137.outbound.protection.outlook.com
 ([40.107.21.137]:53184 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU8bG-0005iG-EG; Thu, 30 Apr 2020 08:47:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQyHGwWT37bvw4jlix4TEkYfxMz6r2xLFOYGSpZc/JyTMpXzOn3SwYdLiW4O4i3/4AACx35VeAD/dnUv2dGnEFRQRnUBhQH3C5o1yNVA8hRvrUHhJpl+Q3EsZ0S/josa5+8KaI8zGUx+QI/XBwYKgO29AaPZzdmTYTT9rjCE3Cc624wEXEwLABmMwKkWEQTwRuZvdAsWQHrjv+iMKAUNSEdgbQWuhmO7oJ3Ip3JyxZ2VIB+rcSqHYLxP458X7/JdTOlmVSkRV1p44/KXSSUsE0ZB5okWiH1kXWVM2iD+6e5MjaBxn8iSvrr3BVLslt8OdrwEHgWDk9kltJDae/tCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP5xufoLD0xA1q47SpqFb4jRJe7pXt2DKeXN8z9Vk7M=;
 b=CTGP26Pi4oqya6goXHD/Pd7ShALLJqQWHtJwIrEOB1ceB40zy/c1dz5X5AMJOLL5JqypYgJHgCmqfqnw7ns4QGoS/RzAZNNaes4+pe4zq8gCs+tN52kOIH5U6KsMnpnnv6tBW3/DHvHFcLnZs4LJK7joBlwEN0zz/zxGssP37z3RcWHPgaTCk6oQy9A2iI1QuLPhU0jwYrrXN7BzSB9E/hdT5/G0CSMXiFAONXoN3Hg3fOCc4FASM04aITScPH6etruxf5d88jgfs9n4rZppt6PqU5+5ZeAxjM7jx80JF5Il0eqaOhHkEzJh2pxyiafpXmamkcXI3USofAyAG0g35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP5xufoLD0xA1q47SpqFb4jRJe7pXt2DKeXN8z9Vk7M=;
 b=TsdmKKNjzliey3Z83yFzLVEONWHFUF7laEF31llKgpNnJTt7kvVVOC0vbnBBUKZC1kD3eesHXHtS+/yoozAXrCIei0vsjvz32lrgbq1yHJAlk/R2y7fuLWhXWNDQfw/ElnkNy2rCqCM3ZL++U4Q7a5Ss3qSMUVPD4KBf8xLZWXU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 12:47:31 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 12:47:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/8] iotests/082: require bochs
Date: Thu, 30 Apr 2020 15:47:07 +0300
Message-Id: <20200430124713.3067-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200430124713.3067-1-vsementsov@virtuozzo.com>
References: <20200430124713.3067-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.138) by
 FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 12:47:30 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc0c7d42-2c9e-435d-316f-08d7ed04a570
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54781D398E04AFD0F06F8355C1AA0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILYzW+xt5WjyOKn2DZ6q5BTbCvCx0VBnrVGLu6+tVyQFoj4RKffXhFTK35Qp8c+XXCKUysCnpe7++um0l6mTpv58ZzqdaJKNCvqCBxK2JVqMsHpz+VXM95Prmc63JTBFH16sHgUaYW6YdkWlThfEH8K2GczrYhKChdOeqiXqsJFoIA4K/luVViXQaIQiChA5a0V+vSmNgejaP+CkxJaqrzxEdZsXSOvt33NDwLYMvYsVWwxf4QO5iAshaKnVKi7yD3iazF6vQunT8IY28ro6cYIbXcspc+8kYPAfXrveOtw78eFHH3qHsA+g+pYn/F/SEAiJ9+Eiup+5KLe/VSrpHgUCidB/rWZAz4rmx0csT9PVVff+ZDHmj6I2G0C7FlpmV8PsK4HyCbcZ1p64H5Mh+LLa64Feu4Ej0nJvpGB3H9+tPEWZkNYGhut3gWndaeSl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(376002)(366004)(136003)(346002)(316002)(2616005)(6666004)(956004)(2906002)(478600001)(107886003)(4326008)(6486002)(66476007)(66556008)(66946007)(86362001)(36756003)(6512007)(16526019)(186003)(26005)(8936002)(52116002)(8676002)(6506007)(1076003)(4744005)(6916009)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: s41Jro1WejNzlCTBiSPlTkDCCC3po0F9Y0ZnzH3AJKUzhQk0gkmx6xcZbY/Zkq/4IKl6C2fqatwAjZqw5H5QiB9VEf9Foax+T4GciilXM4OkOiJr6ro/zQ+ai4uD9DA5kpol0ICwiAdCMrVFCEgtYGnjv9HTdHcfG4JYutAccJbh8lLqyEbs+D2NLpax7CPmFxg6z7z3i8vISvh5nIl04Ob4g9KSQ6SbJ3pCE8QSW3P/TjJAKiHen/6iW28NKMX3VK3aTLLqn+eOd3MK7a3RMoiUq7TQUcmXrLmZbJXoevXfF7fTfe/gW/vs2qPpLqPrN3BcGvyh3qa4yyJuc2cLunKcM18OQwk0Ytx10zhCHSzIPqv2Z/Kroc2XW9tZ/kwEw70jz/T9IcbhNE1aMdqkGkyV09NAfOjm+VBIZ8/vbt8syNWmCKXdifp6xOHb/VnRiS6uFJEHyswcfxLNGO0WYDs2P3vNxK1qnKrftEmLCeUDWaxGx6fCmGpRlZ44MmuNRFPLcy7kpnYtywKZepDD5Ax6T7gepxRVuAMmfq9RLmu1njJP6do5r0nSnH5xtOuCpZRPc6jI8pReQxaM0gAFslEIlag2GcQvrABz9iCylRr53xYGK4MDLCxa+rM6SivRFaGN1lwPQ97W0Ej3KHEv3joPX9XkBPm6pDu0ErYuGWG7aOrfpsxtQOIoj1Mh47b385EFD3aGdfySbLaZRWf8surKVaQJ7+qaWszC9fYk4WOsT32MY6NXY0lIbUa1xQ+zDVS/XCHEq1cDZ6sm4uETTx6TIe/FXaSjsCq+BLopWfk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0c7d42-2c9e-435d-316f-08d7ed04a570
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 12:47:31.0028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrrE2pTaaCGuMA1r8EBg1nl9yxfeWd0mK9yAFk4iR4w0GVF18fWwe+4dIWeSL4Zu6eLtCrWO1W1dX9TchlVxcz6r8cbvR8+/UihlHiHGefg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.21.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 08:47:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.137
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
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test fails if bochs not whitelisted, so, skip it in this case.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/082 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index 3286c2c6db..1998965ed4 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file nfs
+_require_drivers bochs
 
 run_qemu_img()
 {
-- 
2.21.0


