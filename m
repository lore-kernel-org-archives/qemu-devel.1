Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA588C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E98205CB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="r9miP/Dw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E98205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFEMU-0006ds-3t
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 06:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kFEKO-0004eq-UT; Mon, 07 Sep 2020 06:24:48 -0400
Received: from mail-eopbgr40097.outbound.protection.outlook.com
 ([40.107.4.97]:49945 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kFEKL-0002LE-Iv; Mon, 07 Sep 2020 06:24:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AF2RWbHS2bLw30GPhlPdEHOSyIYeWMPtiJ10wAwbnnunUpkZnZCK6Cu5FmaKKttQiRNzR9dLX2MnCPfWfJfaEdqtJxG9sDAoWcU1PsWeA8GfTuKgdnt8nVkRlfmAzSZnc1JYVYP5lLJPVWZGGXEFMo563szNbNEXsBVvitrQ1t61dT+6efeos2VuM0cYfSdaRbynIKHp9expunOozHD5CKRLaRqpioXS72WqNjsRnpA5Iea5jK3ESroarcng1Ihi2/1DuYMf7k4Z5//WoEY95g3o9wQ4IC+G/GuPEjZQrsoaXWDBk8dEajcF+BexK9+26NikjKTJpqht9ue8NvcGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdoWX73gt5TizDwHwdor5jehqH0lB4zDf/TS8wlWSRw=;
 b=BAo5Wi+thmdtiGsbSj1LUrdvQVL30kT9+Qwj9v/6roQljESRgMzODiPFv9G2hj2S935Fe1q2M9r5ob4fx2CwHDdeKl/JdxX6yZMqGdo8+H5WhaDVhgBFbvtJN2ANFGdFiLQbJAB9o6tY9Gf9Rato1PtLWInZXnN4eGMLlhKCWG51exinbjOynnFTXZ73MTZDHmXHlhuOeDciBDlGW07BQdYut7SRU/TXaI+WyML3Oxy63qBnlskINupF8NQLZF6AYhXLvtSaRyksEh6JM2cQ9UibmqL8j4FoEmOsCCk7sUfiQfJRsvWNwCKvlwC7kcgXHpICRD/8JePZOwFlGJjaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdoWX73gt5TizDwHwdor5jehqH0lB4zDf/TS8wlWSRw=;
 b=r9miP/DwPrLQB6ySGO+kKfJL5w+vqpHPR782x63j+sVEs+aYXFk9a61j04jxVnB3V1TNxvKYZ5wWfoR/YwNLUOn29EdXbnmZyadSanRimBn45OqfH42MyAn0A9/p/3qJx9IpsssSFugYNh0SJh5AB7AvuCgYhyIcQAkUnWYeAPU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4722.eurprd08.prod.outlook.com (2603:10a6:20b:c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 10:24:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 10:24:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH 0/3] nbd reconnect on open
Date: Mon,  7 Sep 2020 13:24:23 +0300
Message-Id: <20200907102426.24766-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0070.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.137) by
 AM0PR10CA0070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 10:24:39 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.137]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fc683b0-cf4c-4cac-caa0-08d853183a7c
X-MS-TrafficTypeDiagnostic: AM6PR08MB4722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB47221B32314097CE09D26E13C1280@AM6PR08MB4722.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUWuIeu+uY5VJ9QeOsb25vIwqJvzM8lZOeijJN6oEROO5C1dRR1SMAysIBa+a1a+SWD8tTqBkudkUy7UDMP7cA3SmHoiXRJiDk6Z7FVOsgt4v4DIPXCjISrjchHozALpagHGA+RqdDIR7/xPxsEfxznuwzYDxL8hZ3yIe6X48gDJd1F5G4QHk40Q83lUrEkFarHrStsa7572igpjRPYPoSGjiKLOC201Fgp4dAZq99Rrk8zXQD+TgDAFz545mSweL15Zv+IEtaEGY1y0gJhIyhAcuKtLXNvjmBdHmz8AE4R/VSIpgXQxALzbAE8XqlfQ9UNeebP+NoP9sY96DSGtOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(136003)(346002)(376002)(366004)(4326008)(86362001)(83380400001)(36756003)(956004)(2616005)(2906002)(6916009)(16526019)(186003)(107886003)(8676002)(8936002)(66556008)(66476007)(66946007)(5660300002)(478600001)(6486002)(1076003)(6506007)(6666004)(316002)(52116002)(26005)(4744005)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: onwJ9UwxYdG0cyfo1N1EHc7VYIZYnVWodtx+zu8aQ3WOEDIsTjUp4Y/9GIaHAGlu2AvZU42HcDgrrRe24ah+eKYF5aNxEC5H2Y8EGthFSEpDxU6q832aCMQ0l7Gs1xtzzql78SoaOUuwixpLJ6IPpfbVaIkWZMFckZ2CSbgJolSaLL830CUW1rSfs5XmGOQ93JyrJxrj2oDNmrRD4vW4GuF2cYKSLj3vFviAg+QSfS/+jwj0UDCzDLjFqfmxub9x6GxYDLlWx0TZ1X3+OoFNOBdxD0otaODtr/si9FMAGYHNVpfyXe602dW8AO2QCgHU3oF7R+awlhcjTMEryeeFOtkezCSGkIZnkihMILx/WWpyBp5S4fs9VALF7B5ITE+fzZQs+yJHgVUqdKCJHoqLMG6YI5EA3yPXkv5QAvh1vX4AJgLT8Z3uSIDxl5cI1lV85B85qzMmIC00SNdXHhma3NWli9XuZ9hB0iwPXHiOUUGQLDwLLqtJHCvh0/QrKDNIjy4LuVx5djnIMy+9fs+ZtFzoLq098DdebZc3KMn1kBWV+K0TzToiNlbTO6PbJyssk9LfMZDIkdFqp2Na49WKV2nviNyq/T8io4X0w/yyByhzfAzTAZA17DvP/EkpFDnXLIh8ZEMNgpaDoJbmhSI+3w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc683b0-cf4c-4cac-caa0-08d853183a7c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 10:24:40.0563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUr16s0s4PcGbs3P/UN/8xpBPctP0ZXrSG+DYyAzPwFaULLaNLDhO585PIyiP0bXZmwLAeMk7MjLS8QVr7XVz9goZvrsrKnv9Y7GfThfcXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4722
Received-SPF: pass client-ip=40.107.4.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 06:24:42
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

Hi all! There is a new feature: reconnect on open. It is useful when
start of vm and start of nbd server are not simple to sync.

This is based on "[PATCH 0/4] nbd reconnect new fixes"
Based-on: <20200903190301.367620-1-vsementsov@virtuozzo.com>

Vladimir Sementsov-Ogievskiy (3):
  block/nbd: move initial connect to coroutine
  nbd: allow reconnect on open, with corresponding new options
  iotests: add 306 to test reconnect on nbd open

 block/nbd.c                   | 173 +++++++++++++++++++++++++---------
 tests/qemu-iotests/306        |  46 +++++++++
 tests/qemu-iotests/306.out    |   5 +
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  11 +++
 5 files changed, 190 insertions(+), 46 deletions(-)
 create mode 100755 tests/qemu-iotests/306
 create mode 100644 tests/qemu-iotests/306.out

-- 
2.21.3


