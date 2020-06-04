Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13B2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F476206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="p6FEDHMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F476206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgttt-0005BP-Po
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsK-00037o-PM; Thu, 04 Jun 2020 13:41:57 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com
 ([40.107.0.103]:11696 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsH-0005oK-Nv; Thu, 04 Jun 2020 13:41:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyE5ECSSbCYheiONcDlvoGbXhNZH+iViCtgcnXZF8rs8q8yWYbFe/lpxdMTtRT4X1CDh58hgE44DFgCQKUbkwUJ65iBDNVlzVudIS6dnMJ2GO422BwNllD49Z9yjETGxYdPAeyVXI9yf/F7Aro93Vi/Dj5M4c36dWC2AhuYuKSEjGGg7ZBcaV3Af7FrmkgSKL9I6JnaTLXj9XUIMiFNcVVJjq05iVO2sQMZy1sDSJkZlk2xCRVdO/cEIUCvoNwoCtP6gfGIPDBmyyGTlHuAvK+KjoJhga9v2QV/2i3YWQz+uCVhbYLJ7HFeVnzpC7pnxqtPo4GN53yA8uVJ/oXcWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUp/ggiiTkNmpSuMGOBqnGrxBP615mP4hebJt1FD+5A=;
 b=Ecla6fE31ScTrmtdAIlft0DEbTzQAeqeNtEcoxuG3P9WBdxoWOsP0sqMcX18lEgMLul+HaOlgoOl6oHKHKL0CIs0w8ekJ/iz+W7hFRyjuqPhzvVT5cimaXSiacabeaJi4Bjwn3mGX+pwBpvdzxwjZPQ/pQfT35EhHBqQ7DUCbvUhJXYRPPbnuJXxf9ZIn2boPINN8APa/4XKmVsAb0lpY7Kmo0RCvc6A5AadJJp9iLO50foCuQ3OL0jpafrAKm0RV2tVM8nzcdK7mPTNXvu/SdAIoh6mlHQxce5ATrFlHzuItnbnyHEewjUZsNk74sohgECwNN7uNEukLXwmiToTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUp/ggiiTkNmpSuMGOBqnGrxBP615mP4hebJt1FD+5A=;
 b=p6FEDHMxi3HaZVI0a/k9ebmvRL3ANRASbHy1pfli4QRp2l471AijR1NqFBd/trnaUOo8ob+L3kbTlyFKWmWy9FWYFkG/0GztJPctBRPeDGbTVMVkT8qD2ygMiS3+39tSVFZzIu5L+we55zMEF2qO3F+o3u4f7/G0Pj64IsDlqkw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 4 Jun
 2020 17:41:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 17:41:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 00/12] iotests: Dump QCOW2 dirty bitmaps metadata
Date: Thu,  4 Jun 2020 20:41:23 +0300
Message-Id: <20200604174135.11042-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.190) by
 AM4PR0101CA0049.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend
 Transport; Thu, 4 Jun 2020 17:41:48 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0143394-c3eb-47b0-2e2c-08d808ae8f09
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381AB2543941DBF2AB1DC78C1890@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1QhdHlrc7k0KEwJqhvJx5kmb2QIlKIX+YImCflGr61uuy2P3qeoEzlFkMme4mMhEqNeXTh/oGBCsBbd1WT1DKDMGkW/Y7UoEYVSN22JQwc0SANyq35oE0Jw9R9KwX7c2nNIsj/BgTfX4ZqYkl6WNe0EWltke9ZsYDx9iZFBYfPfTDTHv7h+rauOrGR8e7WC6Y9d1+Bv6CWCgn0lUXV+3/EzqUjJYGpwmQ0w3FN1//O4coAxyQzbbcqS2uq8i8+iGf+MM68BW0iJ1QBOUdzlM3So2n4fZPtAivQ9wmTOPtqFRX1Te4Nc6j+zZesJl7jQXiGQ32Kp5jNuSbr/ONmh23C//lkUu4O85+TgTEbrFBGsPgynuDs1UMGsCUDb2SFU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(5660300002)(66556008)(26005)(66476007)(478600001)(2906002)(6916009)(107886003)(16526019)(4326008)(66946007)(1076003)(186003)(6666004)(36756003)(86362001)(2616005)(6506007)(83380400001)(316002)(956004)(8936002)(8676002)(52116002)(6512007)(6486002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Oaj0xo4JtLzbiqjxWtdmfSbJY+0LfTNiw8FQF6a3ZrC2IY1lTRn83qz3gzfNxAslSciPLJ3CEHh8pR2YBEQJAKnpNrBQBD8H+ZZCELEkrkHmU5Y5Jm6odQqwm6l3x2GNnxdP3oSOPk8IiaRLGDcWktDO9G7smGOaeiOjRSwdIqAkz1g2mi0V7ZuEsB4ljPZRo4gfuY5+BgUCm97Nu9nmuFNbYdcv1lpylbQp2bAwNYzsyrNow34G4Z/pX1zlhJLe5r+7qZj06WJczIv3KCdEN+nXeQmfXvvW6MfK9y+vFp9mDvYKa8HBrNXOPTOQW1TvjZneg3Tls243t0n9Ers+sI1AhGu7oWNKnDrJNr/CYBAMowT7PLFKidm99a/8GUPDvvkIReSSKgkvbbkS8ym5MO9d5fjIe2o6LkWzVSENNYhz4FuNsENPw699GXXV+LJesaNaRWfaoKwJXbKR6sH3tHVHzAdBa4WAnEP4uDIVny1qRChodX86bfCxZq4g+7m4
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0143394-c3eb-47b0-2e2c-08d808ae8f09
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 17:41:49.2170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbRjLO4w4irb/bKlxZdvoN7mtGKF7DC+Vr+SaW3ML/wZ4lRtNn0Lf8GuLpyr1u/PlqXDY052AMmozjHUrNbRHtZtpw8+IAPBwdUZg4KN5jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.0.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 13:41:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
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
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Here is my suggestion to substitute only first three patches :) of
Andrey's [PATCH v3 0/6] iotests: Dump QCOW2 dirty bitmaps metadata

so, I called it v4 for convenience.

What is here:
1. First, update code style
2. Next, try to refactor in a manner which will make adding new data
structures simple (look at Qcow2BitmapExt class in last patch)

I think, next step is to add type hints. Then add more structures.
And, anyway, at some point we should move it into python/ directory (at
least qcow2_format.py lib)

Vladimir Sementsov-Ogievskiy (12):
  qcow2.py: python style fixes
  qcow2.py: move qcow2 format classes to separate module
  qcow2_format.py: drop new line printing at end of dump()
  qcow2_format.py: use tuples instead of lists for fields
  qcow2_format.py: use modern string formatting
  qcow2_format.py: use strings to specify c-type of struct fields
  qcow2_format.py: separate generic functionality of structure classes
  qcow2_format.py: add field-formatting class
  qcow2_format.py: QcowHeaderExtension: add dump method
  qcow2_format: refactor QcowHeaderExtension as a subclass of
    Qcow2Struct
  qcow2: QcowHeaderExtension print names for extension magics
  qcow2_format.py: dump bitmaps header extension

 tests/qemu-iotests/031.out         |  22 +--
 tests/qemu-iotests/036.out         |   4 +-
 tests/qemu-iotests/061.out         |  14 +-
 tests/qemu-iotests/291             |   4 +
 tests/qemu-iotests/291.out         |  33 ++++
 tests/qemu-iotests/qcow2.py        | 200 ++++------------------
 tests/qemu-iotests/qcow2_format.py | 260 +++++++++++++++++++++++++++++
 7 files changed, 348 insertions(+), 189 deletions(-)
 create mode 100644 tests/qemu-iotests/qcow2_format.py

-- 
2.21.0


