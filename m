Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5536CC388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FCB24656
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bYMqssYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FCB24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfsr-00074g-MP
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 15:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVflf-0000lA-R4; Thu, 22 Oct 2020 14:56:55 -0400
Received: from mail-am6eur05on2090.outbound.protection.outlook.com
 ([40.107.22.90]:46561 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVfle-0007YP-5t; Thu, 22 Oct 2020 14:56:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCxAjvckBSRVdPAKAKeY3eZlGazUhj0DGNnuglXBvM21wC1QCcZWBCYESBfaSnPeFP4gbEw8j4nTyQJuffm74BS2ERZHku+qgie93w+U/IhwZLVT/87+3rQtGcBRNX73AXpB5tPdwJZE9bdbHWnX6LHky8uA3FJ0HW/5xlCDIQdxuFDzW8Yp2ABlz+AlAwLV/MGeEq3qX1tPhUxxo/37kR5iz2yvqJIJnay4seqR9FiU7WtAHe/AN5GouoiX6BOWTCE4TNzlFCJKZ+5+SFxZk0rviPgoN6GacPnNuwBgYSj4U4p/oTgdL/EBOSscIEs3fz3/+9WdcHzB4sFyGy0wFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBMZ0UNBB/RQUtJ4ojQrCS+AqxUZppka2gYEtFlqBoQ=;
 b=G45h2PYhp302eBlBhJszGUcbF0/oRYvo2OY2zLwDvAF9kDYYqaPiufIG99gJrDo3qn7zxoiSYEOZ92qo/AwuaTedhyE505PsT4vrWdaZd2WIj6wVD7hSk1jWknKQdgmRtNmnbTRsnt9bedZtw2JAzsm4hKNfJkahYDdUhEWJAIcT+YxsaZhfbZKAqk2Ooneqy8Bnamnm+BnamiuGP3zp5skdy6j9yUi+ghve2FNvvxQaqCZQLAlwmXrNLI7rtC4Dv4YUfgin0vH7CR8Lvfj46I+OGAfpCVzPPF/mPNQoqc/KcTTG7ZgSU1Xwg3dhG9wTMQir05fpQ1kGjBzg5eiDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBMZ0UNBB/RQUtJ4ojQrCS+AqxUZppka2gYEtFlqBoQ=;
 b=bYMqssYTiYEujuW0Kv/flrO+2YbKkmx6WK0KFkutPWO4EZa9ij6amJMuYBhW3PrV0GhCUbKIABwJ97qPjf35+7gYpOMecgVyF4IZlaRGWteBu3EHRkDtlvpjGlStw4jgC3v+JkSqBXIa8lbB55OQfSIjC/6Bm9LfyKS4FxA/Qg4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6309.eurprd08.prod.outlook.com (2603:10a6:20b:29f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 22 Oct
 2020 18:56:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 18:56:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com,
 jsnow@redhat.com
Subject: [PATCH v5 05/12] iotests/299: make executable
Date: Thu, 22 Oct 2020 21:56:20 +0300
Message-Id: <20201022185627.16987-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201022185627.16987-1-vsementsov@virtuozzo.com>
References: <20201022185627.16987-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR01CA0089.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Thu, 22 Oct 2020 18:56:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f24fda15-a059-443c-2e8c-08d876bc381f
X-MS-TrafficTypeDiagnostic: AS8PR08MB6309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB63093C0EF21FC2FE37E0C27FC11D0@AS8PR08MB6309.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTCkZC8oAC5yf6dCEb8IDt+3bt+6Brr6jCMZ8p9FjRDEGqTLZP0HcRyAvv4LObDz92SuRTVFEuh617KoIw2pDaYHSYaVPYthGlzGipF5DhSL+XNiCptjIBrrI97koiLB1uSj7AL+uyCSTIYC2f9XRydX9c/tXXKIw5kovbbFLqlA4AcO46vlX0CzM/oHUaFnzMXyABiT/7y1mBUuGBhxonu9fgKb99tzEwCRZlA+RATqUp7mD64VurXsogkqDXZlqFE6OvaDyUx38rVPpanEK1NctVbroNu1kgC6p+a812KZNmFXn9oVJYXdimhIvPcSFp3y4Dek4Qpz35ewzZuKdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(346002)(396003)(136003)(376002)(478600001)(6512007)(36756003)(2906002)(52116002)(4326008)(5660300002)(4744005)(26005)(16526019)(2616005)(956004)(186003)(6916009)(6666004)(8936002)(66476007)(83380400001)(316002)(66946007)(1076003)(6506007)(8676002)(86362001)(66556008)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sXwwwtfEtPpD2PsYzBPKcEpzpVQeoXbwex7/rYvnvX7grKDv80QongPLsXBNcls/87dSETUPL+E+Q2RwHhgbv1NEyFYdE9NL6BZbj3w2YYfw8daLSx6VPTGeUN17u0ApftBGajGCsrUrbxbL62g1INwRFY5ltFkcWEId3bQM+syZ/RUq9py1ETx0PH8lmKbajKNkXrRbrYtYzRN/OKPXw3NsWiYnik4jI9CSHKnOOqqXyskqDAWLnskWeUKCGeMLDMx5sCKV//uH3EOrKjFm1Wy3KeFmmoz7/3PT0//BzSEKYaxNOfeDSXFn2lHOii2AsTbJnJa5dZKXpHGoLBZq5wp2rm7nApO39c+3r8qIsBZjBA5IkkO2qweYP0d6XJ08vdxQ6WM3Pwl8qThooYu+vQm8ZuhiNAAVImsg5R/yBKwYARij4i5+rBPH4mf6yHz81PadNrhE8rfyc8cq6vfpRJHEYujD0u25Arbs5L2MlAT+55q7Y922rN6AL376N0dVZu070PtsvRRFn6lekivkaRLEyU36gWd/Aq+8LgrEJPY8Ic0zdfLG/5RWuM+Pkh9X/EjcHtG6gvtz1UiS2HmffX3Kpyu97epgXnarbnqx33kAWNG60DwQhEfxfhfZCwA10XvAsdX27/Ha/MXYrYkEhQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24fda15-a059-443c-2e8c-08d876bc381f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 18:56:44.1935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYka1awest7of0R2FhmnGDiU1qSwfUko/sVK/leFsogzGli13hgnHoccCVq8eAvHn4XTMnhd+jtecc07acS9TSqa4+dLkpacygiuH+pEu+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6309
Received-SPF: pass client-ip=40.107.22.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 14:56:45
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/299 | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tests/qemu-iotests/299

diff --git a/tests/qemu-iotests/299 b/tests/qemu-iotests/299
old mode 100644
new mode 100755
-- 
2.21.3


