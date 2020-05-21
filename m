Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288B2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE016206F6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oKfn9vwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE016206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbtMK-0005TV-VD
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 18:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbtLH-0003rP-J2; Thu, 21 May 2020 18:07:07 -0400
Received: from mail-eopbgr70104.outbound.protection.outlook.com
 ([40.107.7.104]:17734 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbtLF-0007vC-0p; Thu, 21 May 2020 18:07:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt0aYiAvsHs5RBJF5ZdnHEPU5hdar25GsooZcSpQjevWtvNjN1d9N72nt0E0cS0jbzhg2rtcU7s1i2zQQHO6Hw8HjOsMoYkiPw/b9I5hYimJIf8LWgkPrFcdEhdczecC2Hz+D7H5OEEHjpM/JPirs1RqIwCMWYxqJ0tkwqmuD8YbkTywBVpWRasyoQZLFQoIUVO3YwQTBfEM5EN6E4nwMSV35D+s8WVdhPLhCTkSwAtDMeMIbqaMmWxTDpsapJJ7255owl7D9QG9L6O1EgylrV5DjX417BSGRgHVOKLnKFoGdCEQ/gWhQrjqRo4a4gWSiS8OtMj700mYJkORMR4YPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5vKTrKGzADpU5P6dX4Gl/2vGohejsYVKPZxj7Pu32I=;
 b=Kg2m4eLRQZbiEY+yFeEFATrAEGrBLKXP1VfmVxiNOBMnxzFvtjWstXVXduuZKCFadpdFi6HsccIRggS7hy6bhKdg6HoeQbBfvrRg76kmPRsvkpb2qnmnJyYdSFzuoft0WNG2VMl1ZxuKdHuTj7rAK9EcdFNY3T5fPr/Jowcfwqtd6aCbOqi8g7cFK8OsatNoY6ozUfSDt3cksfKTOKK43L9tbHw8iyBcHjst1QH+UK7s8ureoI6thdPo9FqspqII/4CillNCtP+qih7zRzhnOGrY6S0PVSzE5Ho8TuwZ7PiqQgkReA/rSKogkR0+VjdKf94xiX8WWotecmGKFJhi9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5vKTrKGzADpU5P6dX4Gl/2vGohejsYVKPZxj7Pu32I=;
 b=oKfn9vwkhuOBj9XXMbdjpXny9AYDX18UIafdYxZ7zEno2HZPzsJzGGMhjbXtSnE98lL9wLrW8isldofUpQlE/sx4z9PxAq9QiFrQilUpRJrEmgQVTuM14mhbXZ/HY34uLhnVJuRiv20rlYP6sLr58YL7/B21X4iPkiImMXyBrnQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5512.eurprd08.prod.outlook.com (2603:10a6:20b:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Thu, 21 May
 2020 22:07:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 22:07:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 0/6] fix migration with bitmaps and mirror
Date: Fri, 22 May 2020 01:06:42 +0300
Message-Id: <20200521220648.3255-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:207:8::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.167) by
 AM3PR07CA0137.eurprd07.prod.outlook.com (2603:10a6:207:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.12 via Frontend Transport; Thu, 21 May 2020 22:06:59 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebd3b56d-f229-4932-e71b-08d7fdd34951
X-MS-TrafficTypeDiagnostic: AM7PR08MB5512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5512F134CD604CBC92AA735AC1B70@AM7PR08MB5512.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QcnVK1gvAdy8GiAGMZlC3gykp6a3JJD/F02BOC98GeCW3BIf5wUMQZpWOu2lfuVts3bGSEdfdJFUAs1XqaW+fXPsP0LVlQCFqsGsZExEgtTngqAFb8+ZjQQdWpMdKacBN0K8WqUAkDCJCCnA3Xd1Fk3lzOtkkXFVbNp76voM2c1P2x23vukkaYt9F/PR0d3dwigLgEXfzf1cMgO6DpduqXJIOwdnfqd7qoGwjM66chb7/aOhZOFflCBRZSVGmgnFkt1pm9c4tAiOnXjq/nPhYgwWip7z2VGdnQaraTlXMj8hdQz4a0GeDbNkP+sn6Una7mipSq8p7joIUtKDPuQ3vGWzzdz+YaPEea+Y1lWH2V2khVohmkWnsehktyNxRBJP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39840400004)(8676002)(6512007)(4744005)(186003)(26005)(6666004)(2906002)(7416002)(16526019)(316002)(6916009)(8936002)(6486002)(36756003)(6506007)(1076003)(107886003)(478600001)(4326008)(66556008)(66476007)(86362001)(5660300002)(66946007)(52116002)(2616005)(69590400007)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vdDIiB4z9q1rKzyzkVD0WeRy/4lWcWtqpz1xMnTP6Wac/Zic7g6nPAgkKWv2Rz7NVGnXX8XYa8en/BKRg31KKmNK8lnWt0US4qJlBv/BLJb+YzOCNxn8OXM8Dwji+7RhGAqjGkid30c+iiBOqCcfRdbK5yORwqvFIjBwumsXsq3+AJbFDOBO/ATWx7TQAUIZmuGm/CauTHOjsTKOzmZX5013EZ+BgxesXQnYCqK73fIKliuqPm3ISPGAkyNod3Xc+0e14MXzWyafNUJpKgH2yz3t2pXh10/WFqPZy/x+yl6nv8EuXT0dalIIZRYx4MuXBmMejCS0w/GQNMQaE+tuoxdpJ9GV4u1I93l4AOhnbQgbxqax9ztYJkx/Al6QNh0Tzg4ypkKKNmynUWrlAPdEcHx6kNqR0yJKGJOz7KvTTGnnCaJKfi/CgNk4d6T+mMkm5Wzt+ZTEsr0YKzKhc069jCe5ISjPMrGqQ+xTPFFrG8Xn8ZNYRom7Uel+kOe6BxBF
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd3b56d-f229-4932-e71b-08d7fdd34951
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 22:07:00.8406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SvenhZqZ+YTZPHDyjPHvSSnD1NSy7eR5pwa7/mv4K8daHN9PscJqmmxAlCi9PWvkc353QPOi6WwaGFJLPGPt/+NmlFQYJu6SJgRfA/dyhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5512
Received-SPF: pass client-ip=40.107.7.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 18:07:01
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
 quintela@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v4: (Max's patch marking filters as filters already in master)
03: careful select child of filter, avoid crash 
04: add Eric's r-b
05-06: tweak error message, keep Andrey's r-b, add Eric's r-b

Vladimir Sementsov-Ogievskiy (6):
  migration/block-dirty-bitmap: refactor init_dirty_bitmap_migration
  block/dirty-bitmap: add bdrv_has_named_bitmaps helper
  migration/block-dirty-bitmap: fix bitmaps pre-blockdev migration
    during mirror job
  iotests: 194: test also migration of dirty bitmap
  migration/block-dirty-bitmap: add_bitmaps_to_list: check disk name
    once
  migration/block-dirty-bitmap: forbid migration by generated node-name

 include/block/dirty-bitmap.h   |   1 +
 block/dirty-bitmap.c           |  13 ++++
 migration/block-dirty-bitmap.c | 130 ++++++++++++++++++++++++---------
 tests/qemu-iotests/194         |  14 +++-
 tests/qemu-iotests/194.out     |   6 ++
 5 files changed, 127 insertions(+), 37 deletions(-)

-- 
2.21.0


