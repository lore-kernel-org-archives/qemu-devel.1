Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044B5C55181
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67F52073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="G0w2AROs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67F52073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQnWI-0003bd-U7
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnSd-0006SM-V6
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnSd-0007Wq-Ch
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:51 -0400
Received: from mail-am6eur05on2136.outbound.protection.outlook.com
 ([40.107.22.136]:49598 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQnSZ-0007MK-M7; Tue, 21 Apr 2020 03:36:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oc73efqEvLeAB1/NxhsHCc1v9U7MVzVJ4lwZkKSEnANC190JV9i1Zfrgr8aCsJS/+gxAVtz/RP2nSgw+NOyEdl1LSooas9GkwuPvdger60gkgKpSxjIT7uNk96gbtGGmuSI2bFBpEPtIAn6NvQDP0df9Xgce//8BYloRyRdKwnto2HA6DyPbhCEL3a15v7jPcn5YNVVKq+bbWlvTJNLWV9VGh/ZKZq/2MxvpPibn8/WWIiO3dZckkhQVgG/12ojZL+BcjByByYyEJ2FTJEx7Nti60KqNjd+H9MRVKS2x7FjbSN+6Xq8rD77SjRqea/ZfQmWdLY23wechKQChI+MXTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBXE899+U9wx/guBwXEn8hluQSjro6pyPPgCRPEgt24=;
 b=fJy8VX32wAazuegbmmGw6oA55IXHBz3ZEEeMi52OWfGOkO3BsnpqOPH9r9PVRmLpypexmlI1PyjW2LFPpbWHasJ8jmlm7VwX4oiWZl42HkwCtX5kFKizmuTfcubskGg/iKp6JnJ+hil8+8h2vC4bhy8YVZ3b4AZqSQ7MpigEKyJrHLAa1MrpESWyt1r5BvKEc9p8txvDji4L5xC/7IgI6CmGJ40GzcOi9tbQi/tccHo6oxhLr8sS3OG1YP2lq6Vy+gUmhjz32/o3FFRY+WuRHzkQrKtS13/Xsb+YMo5jmbaQdIGVEXUKuFy5gGVq5hJcZtyotp4O/0Luc2bChbe+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBXE899+U9wx/guBwXEn8hluQSjro6pyPPgCRPEgt24=;
 b=G0w2AROs6rZB2ns+K1jlctXGtF5fbA1Hwo7U0fjrof0DIPUtmhSuLQcISSNku05sNi0ejxV7Q85wboOryz34xajPtX5Gv9AzZOBItwA91afv3DfTcfRWgMlbg9r2ME7wc6z8Mp2k9nuqptWG8DYiPmZWbwxqyXK6V4ZjUFgLTH0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 07:36:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 07:36:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 10/10] iotests: rename 169 and 199
Date: Tue, 21 Apr 2020 10:36:01 +0300
Message-Id: <20200421073601.28710-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200421073601.28710-1-vsementsov@virtuozzo.com>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:207:8::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.142) by
 AM3PR07CA0137.eurprd07.prod.outlook.com (2603:10a6:207:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.9 via Frontend Transport; Tue, 21 Apr 2020 07:36:43 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 282c98f5-0dc9-4fe6-6cbe-08d7e5c6bde5
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5399C8A0A15ECC9A5B369464C1D50@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39850400004)(396003)(136003)(346002)(366004)(376002)(1076003)(86362001)(2906002)(2616005)(16526019)(6916009)(316002)(956004)(5660300002)(6666004)(81156014)(8676002)(66476007)(26005)(8936002)(52116002)(478600001)(6506007)(186003)(69590400007)(36756003)(6486002)(4326008)(66556008)(66946007)(6512007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mnShBjY497IWAxBHFlfzcqMMtOePh7KI8Zkj7rTHMmFCimu426ZNJfSnRPLTHOvV5GBflwZ0exgAe3hbeQHgPY17vvcjiFAz5AUctyMhKo3yE9kIyAZGoR/2s3wCjYH5aUm/xc3S0CjCLGQhBilMQoGayMTPQfNte65RWPUD2sAwOWIOO3gusZQ6l8A/k+GdSP00HAgJpiI3YPyHTD2RCS0z/X5QfBitIM8NqdCz2pudL4cBU4qJXFtEnDNL7a9XOAU8hbdg3MKBUcA2GH+UvNqDAOtGIojygfwwxK44Or2XiBYIK7hHrjB7byuAsp789W8LFpfSUWCBiUey27OnZE9tMpP9uX2R2O3D/R1pNGctkSfWm5RhcIeb8wfQbFEbogCGqva+rEHc+WE24f8OWNJu+azWD5aeHPvrYQEM2NVY0jlUxE7CFHEldgj47va2dScqWnouhcyxgYuhC6Ko61YoCM9eSt7UJ5Rm+Btvk7Oa1FWuZWr0nS522a2mxLEM
X-MS-Exchange-AntiSpam-MessageData: TThlVM89dIYMZVw7I6cyy4UqANSFh6TcLiMUAKfyu0kpk9dGiXXeY+nbshVUHuXWie+wiDfOD2UXk4iLinfWqJw6fg2l3s4hwm5IiH1kRJXWgy9CwfGIvpb6QI7Cu6Ln+Yu9Hi6DXK5f4aRoqb/IXg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282c98f5-0dc9-4fe6-6cbe-08d7e5c6bde5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 07:36:44.9872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzlbGcLOMMlu4b373TA0nmmDOoetdDVhAp4rp6pmuvpHh7uvJIVgsWsbhKGEuDXdgkRSSQfulOEAOfMgbCzHvwP01DXSiYjIEuyB6Swgz1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
Received-SPF: pass client-ip=40.107.22.136;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:36:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.22.136
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename bitmaps migration tests to demonstrate new test naming
convention.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/{199 => migrate-bitmaps-postcopy-test}         | 0
 tests/qemu-iotests/{199.out => migrate-bitmaps-postcopy-test.out} | 0
 tests/qemu-iotests/{169 => migrate-bitmaps-test}                  | 0
 tests/qemu-iotests/{169.out => migrate-bitmaps-test.out}          | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 rename tests/qemu-iotests/{199 => migrate-bitmaps-postcopy-test} (100%)
 rename tests/qemu-iotests/{199.out => migrate-bitmaps-postcopy-test.out} (100%)
 rename tests/qemu-iotests/{169 => migrate-bitmaps-test} (100%)
 rename tests/qemu-iotests/{169.out => migrate-bitmaps-test.out} (100%)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/migrate-bitmaps-postcopy-test
similarity index 100%
rename from tests/qemu-iotests/199
rename to tests/qemu-iotests/migrate-bitmaps-postcopy-test
diff --git a/tests/qemu-iotests/199.out b/tests/qemu-iotests/migrate-bitmaps-postcopy-test.out
similarity index 100%
rename from tests/qemu-iotests/199.out
rename to tests/qemu-iotests/migrate-bitmaps-postcopy-test.out
diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/migrate-bitmaps-test
similarity index 100%
rename from tests/qemu-iotests/169
rename to tests/qemu-iotests/migrate-bitmaps-test
diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/migrate-bitmaps-test.out
similarity index 100%
rename from tests/qemu-iotests/169.out
rename to tests/qemu-iotests/migrate-bitmaps-test.out
-- 
2.21.0


