Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993C4C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628F62074B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ezhdF/YS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628F62074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQna2-0000io-Ig
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnSf-0006VZ-El
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnSe-0007Y1-1h
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:52 -0400
Received: from mail-db8eur05on2093.outbound.protection.outlook.com
 ([40.107.20.93]:57857 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQnSQ-0006mI-2P; Tue, 21 Apr 2020 03:36:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZhshJWuQ/Nre1ZFXEqqnBwST0j10bhSH7lahYmDifuccJLQ7MGLNBr8HikIR8iJ/UUz9bvs938TR+89VdDexBDYhmowoawCFuA2qhCv0w+XkOHiJdPZ+4EVsjhoxDu7fdMeJ7b6zzlmG9zn7AKGRo1ilFPfFa2R9rdoT+9gvjznIwmJwLFLQzQ8LhVQ/TW+bIpaBRmYVNa07OlOxs48IFQJLu/gmdTshz6XgwLzxnKxBNp9ixjtGBpe0DawIlhnktxDUGfQncnkR0NkTenyRe2/YMIonK6hQVI/KPamzyn4ozFll7lXfmyZWyY+QWaKuNP1PMplvVia3H9krq2uyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhsV2blu3/8us3UokET5KbuNLkv+72YdsiDwQkLEgQ4=;
 b=OuEN4DIxjXUtSjDm3XSqSxBUbnEOLfSrpN8AtWElNrrf2If3Y8zhXvCz0S2baqPGWJqiI4meZ3s8hcwILKJLn5XXBbtf/BGYnqSf5T+vrK5qUBvIdC0MxazIVlHSZCg/1R0aha59Yz1+nC0OUApr2iENh/QcV/KqAx+IhXSEaLAJBiv76ROSUbJlb6s8oPFTFUjz31K8Jh7dCk6XRQErMosMMDUbR1aV3dkPktFh1CVsBxfG6NS5PVvBnBjll5OheRuGa3Gf4LQSPsfUUFgJJfZzPhaDNgpi3xsPzXarT+JD7nvJzi83kx3ZIfI2a8YHQ/KVzJ1m1aMMqB8qD+3MzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhsV2blu3/8us3UokET5KbuNLkv+72YdsiDwQkLEgQ4=;
 b=ezhdF/YSR/dZKs+GxRLO+eIoSvuktC3MFFGwSX51B7YLPdqgNCYhn7QP2wbGsXCuXasQzKKi2h0hte3WB8l6o2/jtuBR7N7cxUSDrdc+Bdy1XnI8b1LV//D58BqH3oNOpoUdRnIDCk4s+27ibeh+rgLIeTsgRop8Cn6mCLiAa8A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 07:36:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 07:36:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 03/10] iotests/283: make executable
Date: Tue, 21 Apr 2020 10:35:54 +0300
Message-Id: <20200421073601.28710-4-vsementsov@virtuozzo.com>
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
 15.20.2937.9 via Frontend Transport; Tue, 21 Apr 2020 07:36:30 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5680eb17-b273-4ac5-af63-08d7e5c6b774
X-MS-TrafficTypeDiagnostic: AM7PR08MB5397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB539736CDDEA81153396AB015C1D50@AM7PR08MB5397.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(396003)(376002)(39840400004)(136003)(366004)(36756003)(1076003)(6916009)(5660300002)(6666004)(6512007)(186003)(4326008)(316002)(2616005)(956004)(16526019)(69590400007)(66556008)(66476007)(66946007)(26005)(2906002)(4744005)(8936002)(8676002)(81156014)(6506007)(6486002)(478600001)(86362001)(52116002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCZOxFVzqrMYfokWEHS5L4PjRmlund8MkVlZs8VJ+GovgcwUpisUjrxEteoHhzYorlJbwFwX083AXa+z3ChSbZNFcJpGF5UqJDsUa52qM1fez8fKcddQa6iS2GmODsyJsXmoKPyDjnuMX6qMAZh/uNEgg69BO8rVfQYY/LoxYMH5bc8LppeLNXEfgSP71Z9iV5FWFrWiEMQPwftUCbuUaR6A5YPYjopwxfTf1JzbToyu3QG//mr9AUlBLhUQunXE/cgK77zbZA2M7rM94/ftThv2PvwRI9WSsvNhXwE1WX9Np89NK5pot+tBfLLjKeDXg4fcLI+houM/EiCfk/S3SDLhVq93NWP8hUo7UTe/Q0qlraC6qy9I89voSFnlyLKWBWK8yrjxdcDBFhKm06O3D+pHRFeZZj8CtzjHm2m/2Mkpswq3FVxjrBuV4z5/TJ3jbx6IHewuqtUcM+IHUjQIDwrnbLDr0eAxWMNI/Jlfdwddv5jPtsQtZDZhBCj+g3dN
X-MS-Exchange-AntiSpam-MessageData: EqRdlb3UYyEgh/9ZEWNYRgUoJF6i28NIwStRqJDDFooraL7Q3DwSSOzoYgmBOJ1dGlZioH/V8QjaRrwM6urX/uDej1UABbG6Ylax3ijH5lBcmhkJpYa3qtbsZntPIEaFDUaW3X6koDRGnE2TQSlSVw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5680eb17-b273-4ac5-af63-08d7e5c6b774
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 07:36:34.5365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYejikzBHdIYS8jIQk+R9MuaS4UAEZB0hFRT685i5Dc7iNSef/MuNZRIn7gwReoFlkxDZ6HiKQwPn/m9TGWXirSn0zCavNA/BrIi7K2+Cqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
Received-SPF: pass client-ip=40.107.20.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:36:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.93
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

All other test files are executable, except for this one. Fix that.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/283 | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tests/qemu-iotests/283

diff --git a/tests/qemu-iotests/283 b/tests/qemu-iotests/283
old mode 100644
new mode 100755
-- 
2.21.0


