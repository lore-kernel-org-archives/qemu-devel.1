Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4A4C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C882082E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="K8a+ha37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C882082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTfxH-0007Kc-Op
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTfw7-0005a1-C8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTfw6-00026E-Px
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:11 -0400
Received: from mail-db8eur05on2137.outbound.protection.outlook.com
 ([40.107.20.137]:43808 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTfw3-00023u-Qd; Wed, 29 Apr 2020 02:11:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDIsEPCBM0dagF4VJIhTDmkZ7u4bwucAFsMgcpVr3CMgjzihF7983ynhj7t0tdTNfVe9mmcD8S1ymdRTsyLnqLvxGjDwBh+nMkyWphVQXDhgf0nOn1Lve4maeaghZXXzGNfZrt3A5CSfDKN50AoxFNYGajdSAr2WQb7t6beeAcKMoVC2duvRt92p+XE2zQ0KAqWFrxx/4h4oF0cVAu7zL66gs6Mf3wZkDNRipiXZBQTlH/g4s9FDSi8eWvqEdJczd/ILYZ6cxbevz0EOced0NzkdY1RWjQomjkUNvtlJFe0VUzYMNEtfNxJJ0mRDrHSZtkHsl6W+Y4Sli3WI4qcJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE2Kw5GDWK4VWbS/3MJSLYfWIGdijEuwzQ1Dik8oA8Y=;
 b=JPyfX3gCNQOloLGLtn+XiOPMdByjzupc60J4Y5MCCxMzgzv+Hes/XdB6tE7cdZFEq6Fv3nnNJFipvsXCuThPNuZSe/5uKkUKpghKDZ0khVi1ic94lySWNIQMXk0XLKdhQMm0aDGbVLGAMhFh1G4PjxkLPXOsbUXru8O5JU6C4tx07OCcVH88yinO0V/8yAOCQW7teZc/3n+IVnrqwCYPNbbaHRjLlVp8wgIOro+bnaejnHMdFeDZF/zWJjIeldUEpSczLFrGZ5FCxUUQzuhLzuhDk6x+sYeyzXe7Py+sazMz8Lf9+QwJI3NOcuQX2ga7JbXiFD5FkJ2CzfIEGGapPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE2Kw5GDWK4VWbS/3MJSLYfWIGdijEuwzQ1Dik8oA8Y=;
 b=K8a+ha37ZvGkJSAeImWnpvCABGliB1xMwdtiMtWKJTsPuLLCEAB84+l/me602oPeHE18CFkDr/IW6ROsjc7aqDa+Fs2SjoV+O26gmp3Hqop7EsZozjuE2Itqy7SVc5+HXaDeAgYlMnZ7NMIYz+J9JKAd4cRnoyJgh+7ouhi2AY0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5382.eurprd08.prod.outlook.com (2603:10a6:20b:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 06:11:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 06:11:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 0/5] block-copy: use aio-task-pool
Date: Wed, 29 Apr 2020 09:10:34 +0300
Message-Id: <20200429061039.12687-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.184) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Wed, 29 Apr 2020 06:11:04 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51be3b49-79b4-4d11-2913-08d7ec04196a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5382E3DD0171D7C5D740FB6DC1AD0@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(376002)(39830400003)(396003)(26005)(5660300002)(16526019)(36756003)(316002)(86362001)(6486002)(956004)(6666004)(107886003)(8676002)(1076003)(2616005)(8936002)(186003)(4326008)(6506007)(69590400007)(52116002)(2906002)(478600001)(66946007)(66476007)(6512007)(66556008)(6916009);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDZpDO5U9/ddN7YCAQtZCzE+hfeWMmjkWjACI0k8W6ziVbP7WWQVgcr+xeDa/qoj3/H7WBn2L0CDHDlt9zOMdgYxfZe57vpH/SQyK2ZaA6FLdyvu3GqH3v1TQsJ0TbJ0nzwGOiY3qcsTPWWr7pYtL6YgpbgiBD7x5QFqJjdwTkdwORYzntFViKpGB1kjuAlEN2WvNSAC5jWmwS9J2qRQRjaAgcPCl49FPxA1XHgGGQpDscuSgmc4fpbyiLnAtHmt9EXKgICXJVLUNlSWae1pDOqlmEDmqKsCV5nblajYFVmas033wxKARH7tIaOIfzy7KTqaTi3dmd1nLUA8XcUjF4sPGLxR2XyleJ0pLdhHEzcXafljKyWQlNIFZuKEGOWteJcRPSxSpZfyp7qmtg9tUn2Q5XGxS/Z8FljWiYDWUGtJqbHTIRoqlPe0fDs8GY7LHg2JazBO86X6kGfxgXmlqbKvNU3SftXOwxz5iNG8KOuLKo7XH7o+/JgD8AM3iwO4
X-MS-Exchange-AntiSpam-MessageData: e6KCD+MR3wDDzj3DlaOKaw5vqcW30qXQSi0KMpMjdbGAfd6hWZFtKBDh4oNk3Z4wggBcFQZ4gb34vQekqrJ4I4ja6De21E/99FwDRfRcimmG+ahjW12G+IlYb9n+KSHNgUBMPB1NPARY3ZRlsAqnkgpIhFBcQMZ1b1dG9Zj4hls7GlB54pZHM8zWuUNAbo+iGc10TX3NCviieygceOX5Lw87/1WYqZVeIvanFBnip3xnUtVArCTN9df3PBA9M8Nq0DcCymCOWeS1+h2N7wBp4MUQoL9Q9rmQKOxq37zaXV2V92puHqIMRqCGMjFyO0R8/nU3ZrmokXx7Zj90dngoFv9wW8ZPW3DSEVkMUlJztmFZTJScK66P0aXO+64BgozQ4Kd692W+DYRIGLzuNZCd78E6Jn60lSywZnrZ44QDKmn7xFErWm2h1KKdMdCk5F80YvTBigvphucClf+L2R9JA4b2JhApETJHSQPj0IJOmqWXR8YoZqOH88NnpZTfwUa23f6YfdW/QYBRRte8acW6a1SkZ9DirXDu1ncsTrrWquFZzBMVLPbV53ETr3QzOK67K/pWug7xkVweyNRDrXQTPGljTn9/e4zAR8WkRXtXMlSjWPOHxx1jSl2UTbrr+fSj1nMIlMeZZZNIRNiowCkUhXj9YBrl8KSWEZhewTRxtAxL29lzyiD2Vf11qHC6MOPrnLNFZv12vWypyLk7UcMdvpk4NC+Us1mPQ3MDlZfZna9TKqG7jugkDp0uvxID6HVwKpRMQJgPU9X+6CSCtQKFTAhWK7cOpJiqzXkGfq3WiRw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51be3b49-79b4-4d11-2913-08d7ec04196a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 06:11:04.8597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAEVAkBs6FJS+oNd8H424QyCc2Eth5toZmTn0ZL7bpka+WC2tep1TuaXrCxbiOMR7lxaIsCZgvquvH3kInNrfMcEbHF3c+yVhnl7yy5V6E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
Received-SPF: pass client-ip=40.107.20.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 02:11:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.137
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

v3:
01: drop extra line "+    s->in_flight_bytes -= task->bytes - new_bytes;"
02: add Max's r-b
03: rebased on 01 fix (dropped line not updated now). keep Max's r-b
04: more refactoring:
     don't require offset argument of block_copy_task_create being dirty,
     use !bdrv_dirty_bitmap_next_dirty_area() in block_copy_task_create()
05: declare block_copy_task_entry (as moving patch dropped)
    rebased on 04 changes

==

This is the next step of improving block-copy: use aio task pool.

Async copying loop has better performance than linear, which is shown
in original series (was
"[RFC 00/24] backup performance: block_status + async".

Vladimir Sementsov-Ogievskiy (5):
  block/block-copy: rename in-flight requests to tasks
  block/block-copy: alloc task on each iteration
  block/block-copy: add state pointer to BlockCopyTask
  block/block-copy: refactor task creation
  block/block-copy: use aio-task-pool API

 block/block-copy.c | 262 ++++++++++++++++++++++++++++++---------------
 1 file changed, 177 insertions(+), 85 deletions(-)

-- 
2.21.0


