Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B48C8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512CC2074A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mkWlNo2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512CC2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8eq-0002PC-Ab
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bN-0004QW-7d
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bM-0005nU-L0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:40 -0400
Received: from mail-vi1eur05on2137.outbound.protection.outlook.com
 ([40.107.21.137]:53184 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU8bK-0005iG-9v; Thu, 30 Apr 2020 08:47:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+fucSguKaoEjJg48qmjWXrKpyXNZbtxQbI4zNcZ3ANj4MR+Up0KBIf/0qBreJgLZBde/vcM18ZGn8OxDploSijQPRD80yu/ujIGBWDTgqAtVotMunNIJXbmWMgMjO0ueHAPZ6rNDAN5RhgetXB4F5eU3B+ZqGA4FLbXI4y2ewdBNUXByygBKhlUJL4qXMZCIdxTItJBQkJxg4acV/MjkmJWDBOJX2/9EfRSLWz9+wzFLmYoVg5dTwNLazqrv+LdExlT17KmLce9Clvm2fiXrtDOfIG+c62b4LDFrnoKUt6Xk2OnIG+TWHpwfUWKV+s3A2WddZgVrdZ4J8BEKzBIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6i+as+vsuGo6jmRBSyW87NeEV8kGj5w0gUs6PWX3zBc=;
 b=ZgFxpS6e5JnfirWmsYJkgGpTk0HR7eZHw7+nG6Om7VIUgaaDzL+m+IzGcBrwMNFm4YhtuWtwgSGrCCK/5sV6SB5JO7KOShkv2kkxVOD3luCKSUcqrGma16vC4hscnYkJHwWL0IY2YyAvKBwYbXpPKdOFTw3jCQR7l/xFTqOtxfFOosTFXc9YmmbPbTsCbBtH86yciYfxUnJPxU/SLVD7sUqpObhUIneruRo141OHdJlqB9q9Uw/J24q39rRPeOtW6FJOSk2tLI/TDvzA7o87sFgYGbmriILVFuUlAmsZTWk6hCOgBUCP1MGFdu5oFz7e9kq9w8nLcEM7ZTm0pmGDeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6i+as+vsuGo6jmRBSyW87NeEV8kGj5w0gUs6PWX3zBc=;
 b=mkWlNo2VfhFm7IOqwoXQhV6LdR6ypG+NLh9M4ssfIzcYPRhnCl9iv4Wtd7VIJ0hmCqlqxYM0/8fjBZzjkN6uOJ5MuFMqckdt9ETgz3Np8Mnm74zAi2Ge0LfSd3GmLkGCiUXq3Fk2iwvQiJCffT2b3WmR//eZwV9CEMCqft7sOkA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 12:47:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 12:47:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 6/8] iotests/055: skip vmdk target tests if vmdk is not
 whitelisted
Date: Thu, 30 Apr 2020 15:47:11 +0300
Message-Id: <20200430124713.3067-7-vsementsov@virtuozzo.com>
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
 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 12:47:33 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7398cee-cd82-4930-002f-08d7ed04a71c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54782D795A6C1158503CF162C1AA0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ym6YpxVmc44y7Q9Af2jom9jvFZW8Pi36aLLUr0tgWf23PkYyeTBNJngkPIAeotaNJZ/a7A5/LRuOuYQSH8tfkhh4TiLIedEltgA8fZIXPecI+HyvrEhJL0DWfaBk08eNji7ZAJB+xYULgc86k4caSzCyt+K4S88aM9VITDSa4eq8eaUA2VSyNo42j31XI07blIMEB9XCacdw6bNOHKTyCHfOysvQsTJiGRlx0amFk6oyh8YWP8BkfIgwZGE1zqyt5oPt93IRVWtKTqnqMjwuBx5WLGZqES8384aK7LipvZ/4nQ5WscCKWv3Z7Ad5tqT+s65LiW6C9jljFsez4n2pxZhi2mpjuH1fhugVjDNLMenRJgpm61kDOw1GByDU5ihQqhPHEf55xblv+LwvHd548BlwHnTfiSFE90Qw4y2JrqrLtgomsWm6rGp6OBuOhaQJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(376002)(366004)(136003)(346002)(316002)(2616005)(6666004)(956004)(2906002)(478600001)(107886003)(4326008)(6486002)(66476007)(66556008)(66946007)(86362001)(36756003)(6512007)(16526019)(186003)(26005)(8936002)(52116002)(8676002)(6506007)(1076003)(4744005)(6916009)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: MJOrCC9oXpuGc961ftd/6RvnBXi5wLE9v0BiZBGjnrRBOJf2cBpOWwVZUn+4Q2k7LB9pal5Lphde54ZqKEAX/z+dJ0AWHXzmK5JWybbIw+pl23toIpWpqGvwnpYz0qWzkGSqyoHFA4zx6MTpnoAF5ntFPRBbcfI8icC3efgjRA14AwwTvb/9SUFzKTaNOEXIleQkP3D8MuUbtWIPi48pbhYOTPIbfL6NL8fNtWGy4OCWhl3KnVWZbQ0400NgWrU7YZfNUlnkr6QORjV+HmV0GgBCKETHgcWVdaazIbWK5UvdCxfkFH5or6gbKx81kZcSDuv4phoCTv9qst67T/cX5nv4+3rN+8WsPSp13VmeP+7uknzhoigaSxylrp9VMxIAo88YuiIeT0xjFbFXNM+p+5NGg/kjhbHSq/5mk1QkQUqOQUDpjds8AgfRPygFwwfHqziyjne1G5+1dhtAADOKh0PjHTJbSODyrcYPn0qccdFs/mKpZYvDxlGSvSCYiccbsDxUMKSmuePhB80nYg9hWEUNfkMAoaXl0/cT769DPHOHVKPZII5Jpq0lIe2FWyY2/KwQiEKCygIuHYVsVQh6po6a5Fw5QzyK3qUa4um8hYFNcYtWhphS3OnPior+fdtJ7CnIJ5/6NfFeYm7+fHefuMfEiHlDDwqqZYZ66x4ZaeOq2NwxbQ4pCT2fYK4Ps1ASA0sCvffSR5rziexHthiGI4jtIJgnqTTgohQTgnx5zvpaA2QZ9VEJYPpFQeaT3VRw+mH+0gyhw5FtbF2cwhRbo5HWL4kSrLes5C/rzzxHqq4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7398cee-cd82-4930-002f-08d7ed04a71c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 12:47:33.7099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMCMjU0Fi331FgTb/PMRRxVGm0Zv8RiJxDSfGI1XmUDhCOBmIfR3ipzEMOaUpRU80kBxMzxsE3rGq5HOnIRI5Nguwmnn+u0vmRQDSqso8ww=
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/055 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 13a999c391..c75b855eef 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -565,6 +565,10 @@ class TestCompressedToQcow2(iotests.QMPTestCase):
 class TestCompressedToVmdk(TestCompressedToQcow2):
     target_fmt = {'type': 'vmdk', 'args': ('-o', 'subformat=streamOptimized')}
 
+    @iotests.skip_if_unsupported(['vmdk'])
+    def setUp(self):
+        pass
+
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['raw', 'qcow2'],
-- 
2.21.0


