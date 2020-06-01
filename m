Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C731C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F402073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZudlbFqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F402073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfozx-0003Pj-1v
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouS-0004oW-RJ; Mon, 01 Jun 2020 14:11:40 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:39047 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouS-00026c-35; Mon, 01 Jun 2020 14:11:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZePe3+Jn3/Sd6lXfvMJI1ZR/4b8umcJCeKpjILARFjayhxB2Mre11ZKyTYkiImpvINaxOadGd6mrYjQF4hvnagq49dncfuFwLyNrWxeRnNl4Hw198tOHtfDKtM5uYVHVQ7yaCT07kLhelb/89kPu6ycCP1cF+NYmraEhl8rd22ApL4+ymShxFGL+RWQS1RvFEvdDOnlc2YUV7VlIfTRis3Ff/k8RLjSXxcHsBB/P/6xFtuKnnp7udwzlpbCwEeu79BLPso0YkHrfG1+ma5P7WesqZ14RdHd7eBeXxX3iG6X99bxLv2pJ0Qwcc8OnW91cJLAinR3B5MVVD98oIGd0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMBrNA+lx4UArfk+caCyxlVCfdti5JyL6rYl7fl72UY=;
 b=DQaimtRssIoID+9ZFADzgd85FZ3u3NECZIYIzOmUoau+0aRYVXavaRoLikRu87tcNeOJdF3oeQnLhasvoc3a4CaIBU/hMdKKmWnLDDbkgGtdBTTcbLPZBRxY2ffanJjlNyT441rIkHK6WNVtXf9xnkx8u7vfEJ4xUbcJya5lxbeUs898hXZptZkOaLIFOf6NKon/ouKDBvZK1DGDvy0VjnFUjS5iW+4FUwnzVHonGp/bND0zLAlebzATdXGdknhy68Gejsd8oT7BR/vSzpzUiDrR1u2QxHVr5SJWrkuGu3mDwArK6+vb6Kja++X/wt96qKhbsRRkVFHIV1I33k5Y4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMBrNA+lx4UArfk+caCyxlVCfdti5JyL6rYl7fl72UY=;
 b=ZudlbFqysrTubdzniOpfIGlYuC1Tadqjz6lQdnQK8lm0YLYsDUIqezGc/EfenSDtVN1VzAqrfupKCTjQAa8rmHweiBp1PuofvbBZE0sFJSq6zElLTS5zBCgG/hGX9RUqcOxhF48eKSoq4MZc191AztnMwhRY/7uuzXePD5sjOuc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 02/20] iotests: 129 don't check backup "busy"
Date: Mon,  1 Jun 2020 21:11:00 +0300
Message-Id: <20200601181118.579-3-vsementsov@virtuozzo.com>
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
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:32 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3ce34ca-387b-4932-c5ac-08d806573716
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5317F918201D481F487AB207C18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zb7td78y2udOu23JaapOx9id4F4ASmqRs4Sx4f3fym66/DL/uQuvFVtRqKfS7FcO/DH3qy85uwzn0Ytjik/AmM48Ymz+c4YrEKEHkIrKxG6Vg10d/jb3Iw+DqXL4+NxIAcBJ4bCiAr/0IuSUJXNqgtsF8oX7go7XqVcDylH/w5VwhQp8UFI1yyPHnzrMkMk/rpS22MvGz6OoIiiGIDVbpqQZ82yKBkBY2c5/kKWCd6Aq6Y5RSY+9oaqa0dvJQ2fzrLGiyA8GYbhfpzRaLEyoJWQxUiQzypj4zwTGhwGIWInI3VCBONotRWstytWNpuA/Ljy52pLYTlRyogVIk6Bbh7LSjhKtycrHElGln6IcFRng+rRWSCPiyxEWrDJhIfZ9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(4744005)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: d6YPWf5r6MTQwd+pbxCSggVIB5tFWi3Bb8JmKBO8vyM8MHPq0vvUHu9QoAtk34h+qGMtOvJ37H56ycz6h4Tku8WV9TzdqIt6FtxrjuU5cDmN3vA5qY5DFTCkk3tvOkHvRdR9c7UcnYi/e4j7ubVYTxeB+VW2E4yAD2kWS9KFTVHDEN6zeWA88ukY2jlHOmdvqzl7eXk+/OoJhFDzHU4DdiWRfVXfIxgKxHGB+URPi5MEa0fre74oQgQyk0bRkmV/6DY2rd4k+4mfAEA7koxeUbZYphFLFRSqsF/US6HW1KMQmlnc4uMfx9lqxibc/lx3sfODsrSueDeu8NR0tgKIbU0wFp5wM1rxZ75LBLPqcPgL/AR54vk08D2lnA/V130ln1Sy/GT04iZ1QhCnyjpn1IsZXhf+GdGJPc7VAqokwgvW1fXP+wTd3d8qsf30NK1O5GHLhWwURALI22IN3TW2q3H1cNfgFGT6umMU4RkqEwo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ce34ca-387b-4932-c5ac-08d806573716
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:33.0320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9w2OY+OMm0k17xOnuZYuZfZlaL0QqjLrJSXfATFiiWtOTKV4gob9PsecL9Dy9apyPw63Ypfo09jPTb+EdaiY8BNnbwDYVbD2MUIG8R3oFQ=
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

Busy is racy, job has it's "pause-points" when it's not busy. Drop this
check.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/129 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
index b0da4a5541..4db5eca441 100755
--- a/tests/qemu-iotests/129
+++ b/tests/qemu-iotests/129
@@ -66,7 +66,6 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
         result = self.vm.qmp("stop")
         self.assert_qmp(result, 'return', {})
         result = self.vm.qmp("query-block-jobs")
-        self.assert_qmp(result, 'return[0]/busy', True)
         self.assert_qmp(result, 'return[0]/ready', False)
 
     def test_drive_mirror(self):
-- 
2.21.0


