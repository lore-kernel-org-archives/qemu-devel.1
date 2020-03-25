Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93DEC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA6920775
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Fx35ruaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA6920775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3Bs-0004e3-KN
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH3Af-0002l0-Vo
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH3Ae-0001m0-1g
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:22:01 -0400
Received: from mail-eopbgr140113.outbound.protection.outlook.com
 ([40.107.14.113]:42565 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jH3AV-0001Y3-Je; Wed, 25 Mar 2020 06:21:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJPS0Mjm1k2b5CeGJx+7OzcW4EpAhVY9MpIKeEHII2CbSNePkJtexYDc+Ez4csRsM20malRE9JZZ5rr68r002ABS2SNf0KsOmhipf+5rOvyOEF5t4zQni1PuIoeudMFXylyJU8ffNG/G5BO81YnCgwlhhpBBpiEMqZsRiDZh2RNNmRN6mzdoTXmtWxW25YibomNzRYYzeIl8EjEhhhpUumzwaKpZ8NYIUYetu8lustfOt1AGsESkk/mx8pom+8uTwoCnvmNYdS43iw3dd61GVNKTsXIkuw2gH9lxh0lKOkuwt6j5X9X/6Skp7MY/yr3qjZPLIN1tiBKuhW2l/LwQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDYIkaFOtoKZmkLh+NvoNIoxiujAY/q3wx/SP1ne6FY=;
 b=e+Vbh+zctjXb6YclI41g6eMLg/i/AZZg2FvkLlQM/23RfoI5pP6V5meE7xKH0IS2f+jd7DknyZkXdGMbX3RXkn72W1yGQYij5l1SnJsqDVGftgz+oKxNhbPCZ5JfMRJTS7PIng5arfN1jh2mgCARIlMSvIDYqF4546VOP7NnCFy16APJFID6s0N9GorTPoqepBToLiEXIvkIvtyfQ8yBm4QOGFR4v4rEIUFet8gFcb9L/30ekDNrbEri79JPUHNbQEVuJ4NIjTzuFUJfS/lx/eJk7SL3yVZXgyTkIefxA9baU8UrbvXhV48cgRqD7c2Xnj4Ub4ZqLZGKFU0yPxxEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDYIkaFOtoKZmkLh+NvoNIoxiujAY/q3wx/SP1ne6FY=;
 b=Fx35ruaBcyULB073Cj/UDXuOpEToEIeOpoR0o1NS7Vk0KaMs52ShmXf9uGpTxdDjHLkGN9Yq0M/gpUjj71Bi2FOTS5KGW3RBYLwYjgG3wDQf+Ih3lnae551r9btRfUw+a91XxaGLvl9GQi3tzQ/XPiwxQ5P4ElN0umBX+LVxRkA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5479.eurprd08.prod.outlook.com (10.141.172.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Wed, 25 Mar 2020 10:21:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 10:21:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/2] Rework iotests finding
Date: Wed, 25 Mar 2020 13:21:29 +0300
Message-ID: <20200325102131.23270-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.39) by
 AM4P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Wed, 25 Mar 2020 10:21:47 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cb004ab-68ae-4e3d-1f3b-08d7d0a65362
X-MS-TrafficTypeDiagnostic: AM7PR08MB5479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54793288BEEFF475FFED4A96C1CE0@AM7PR08MB5479.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(39850400004)(136003)(376002)(366004)(396003)(6916009)(478600001)(186003)(5660300002)(8676002)(81156014)(316002)(81166006)(8936002)(69590400007)(26005)(36756003)(4326008)(16526019)(6666004)(2616005)(956004)(86362001)(6512007)(1076003)(6486002)(52116002)(66946007)(66476007)(66556008)(2906002)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5479;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OyiLrITEIN0Xzc6DPqnIK1J4FLs85hB6n7UEpJuWtrzH/9aPEJmwFM7E6h9p1/YZ2UrXJA8h7fFGa7/JMirpHw4wqzgGj0y99sdj0CkCjFUz+HYLzZEBkiFBTll/lp3kT5tnF9sL+Rl/khRkYkXbr/CnwGcT5oZENOVisZZbQxhvcIqt0DueGp0Qdu5yFq8xgbiVQsjDIJtwFzBiwgnJ+FzKa2ExiLWeuNNkxxSt+A/NRYvQeL/2vFK7aqSKCVfHow8m64O3BTCMqdnNBa0jUhKseHtKAwSVeBwkiM3K3vnB/8bLPeN6t+pCZ5K/KxXWZRP/B2A59vzdSw+4wRhXNnktEWe/a8F7hgBkrBBEeEIN/MIVFx8reNZ463lvzPGeSOv2oxA21XcA3wfycUvGVI5pzvh7KaIJtIYYL+wlyGKI2av5n4iOzshBdEtjr7xWYJojfhBtY2Oc8nvJ4jtVwqwYFBoerosknPbHGYTb5r+6+DPyaM+hEOAkvBCj/rid
X-MS-Exchange-AntiSpam-MessageData: bWg4Jny4cqk6jDhiLQMTQWZaxj6msM2d+8QYSABiDw7Qw1kz33e7j2L7Y28oYWPntWhjwo6eVwYlCUUrToLYpxfD7uFCFaY4Z85zIabZyg+DJ2nbqUNtMcOecPvUhV9AcuH/2YIfu5mxYCH3bnoiLg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb004ab-68ae-4e3d-1f3b-08d7d0a65362
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 10:21:48.2056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcYWYOPe5QQmysAm8GBYYnq2se+jw6+88vcIlz+PVrqsZSznCBXDV0o524TcX16RQl0Y9LIkyvmwXURMoHf/xCjXmQg0/kmxxWswCEUSS6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5479
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.113
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

Hi all!

When sending iotests to upstream or do patch porting from one branch
to another we very often have to resolve conflicts in group file, as
many absolutely independent features are intersecting by this file.
These conflicts are simple, but imagine how much time we all have
already spent on resolving them? Let's finally get rid of group file.

Next, another thing I don't like about iotests is race for test number
chosing: you should search through mail box, before chosing test number
for new test.

So, I propose to get rid of group file and search for tests another way
[look at patch 02]. Additionally I propose to move to human-readable
names for test files, with notation test-* .

v1 was one patch "[PATCH] iotests: drop group file"

Vladimir Sementsov-Ogievskiy (2):
  iotests: define group in each iotests
  iotests: rework test finding

 docs/devel/testing.rst           |  51 +++++-
 tests/qemu-iotests/001           |   1 +
 tests/qemu-iotests/002           |   1 +
 tests/qemu-iotests/003           |   1 +
 tests/qemu-iotests/004           |   1 +
 tests/qemu-iotests/005           |   1 +
 tests/qemu-iotests/007           |   1 +
 tests/qemu-iotests/008           |   1 +
 tests/qemu-iotests/009           |   1 +
 tests/qemu-iotests/010           |   1 +
 tests/qemu-iotests/011           |   1 +
 tests/qemu-iotests/012           |   1 +
 tests/qemu-iotests/013           |   1 +
 tests/qemu-iotests/014           |   1 +
 tests/qemu-iotests/015           |   1 +
 tests/qemu-iotests/017           |   1 +
 tests/qemu-iotests/018           |   1 +
 tests/qemu-iotests/019           |   1 +
 tests/qemu-iotests/020           |   1 +
 tests/qemu-iotests/021           |   1 +
 tests/qemu-iotests/022           |   1 +
 tests/qemu-iotests/023           |   1 +
 tests/qemu-iotests/024           |   1 +
 tests/qemu-iotests/025           |   1 +
 tests/qemu-iotests/026           |   1 +
 tests/qemu-iotests/027           |   1 +
 tests/qemu-iotests/028           |   1 +
 tests/qemu-iotests/029           |   1 +
 tests/qemu-iotests/030           |   1 +
 tests/qemu-iotests/031           |   1 +
 tests/qemu-iotests/032           |   1 +
 tests/qemu-iotests/033           |   1 +
 tests/qemu-iotests/034           |   1 +
 tests/qemu-iotests/035           |   1 +
 tests/qemu-iotests/036           |   1 +
 tests/qemu-iotests/037           |   1 +
 tests/qemu-iotests/038           |   1 +
 tests/qemu-iotests/039           |   1 +
 tests/qemu-iotests/040           |   1 +
 tests/qemu-iotests/041           |   1 +
 tests/qemu-iotests/042           |   1 +
 tests/qemu-iotests/043           |   1 +
 tests/qemu-iotests/044           |   1 +
 tests/qemu-iotests/045           |   1 +
 tests/qemu-iotests/046           |   1 +
 tests/qemu-iotests/047           |   1 +
 tests/qemu-iotests/048           |   1 +
 tests/qemu-iotests/049           |   1 +
 tests/qemu-iotests/050           |   1 +
 tests/qemu-iotests/051           |   1 +
 tests/qemu-iotests/052           |   1 +
 tests/qemu-iotests/053           |   1 +
 tests/qemu-iotests/054           |   1 +
 tests/qemu-iotests/055           |   1 +
 tests/qemu-iotests/056           |   1 +
 tests/qemu-iotests/057           |   1 +
 tests/qemu-iotests/058           |   1 +
 tests/qemu-iotests/059           |   1 +
 tests/qemu-iotests/060           |   1 +
 tests/qemu-iotests/061           |   1 +
 tests/qemu-iotests/062           |   1 +
 tests/qemu-iotests/063           |   1 +
 tests/qemu-iotests/064           |   1 +
 tests/qemu-iotests/065           |   1 +
 tests/qemu-iotests/066           |   1 +
 tests/qemu-iotests/067           |   1 +
 tests/qemu-iotests/068           |   1 +
 tests/qemu-iotests/069           |   1 +
 tests/qemu-iotests/070           |   1 +
 tests/qemu-iotests/071           |   1 +
 tests/qemu-iotests/072           |   1 +
 tests/qemu-iotests/073           |   1 +
 tests/qemu-iotests/074           |   1 +
 tests/qemu-iotests/075           |   1 +
 tests/qemu-iotests/076           |   1 +
 tests/qemu-iotests/077           |   1 +
 tests/qemu-iotests/078           |   1 +
 tests/qemu-iotests/079           |   1 +
 tests/qemu-iotests/080           |   1 +
 tests/qemu-iotests/081           |   1 +
 tests/qemu-iotests/082           |   1 +
 tests/qemu-iotests/083           |   1 +
 tests/qemu-iotests/084           |   1 +
 tests/qemu-iotests/085           |   1 +
 tests/qemu-iotests/086           |   1 +
 tests/qemu-iotests/087           |   1 +
 tests/qemu-iotests/088           |   1 +
 tests/qemu-iotests/089           |   1 +
 tests/qemu-iotests/090           |   1 +
 tests/qemu-iotests/091           |   1 +
 tests/qemu-iotests/092           |   1 +
 tests/qemu-iotests/093           |   1 +
 tests/qemu-iotests/094           |   1 +
 tests/qemu-iotests/095           |   1 +
 tests/qemu-iotests/096           |   1 +
 tests/qemu-iotests/097           |   1 +
 tests/qemu-iotests/098           |   1 +
 tests/qemu-iotests/099           |   1 +
 tests/qemu-iotests/101           |   1 +
 tests/qemu-iotests/102           |   1 +
 tests/qemu-iotests/103           |   1 +
 tests/qemu-iotests/104           |   1 +
 tests/qemu-iotests/105           |   1 +
 tests/qemu-iotests/106           |   1 +
 tests/qemu-iotests/107           |   1 +
 tests/qemu-iotests/108           |   1 +
 tests/qemu-iotests/109           |   1 +
 tests/qemu-iotests/110           |   1 +
 tests/qemu-iotests/111           |   1 +
 tests/qemu-iotests/112           |   1 +
 tests/qemu-iotests/113           |   1 +
 tests/qemu-iotests/114           |   1 +
 tests/qemu-iotests/115           |   1 +
 tests/qemu-iotests/116           |   1 +
 tests/qemu-iotests/117           |   1 +
 tests/qemu-iotests/118           |   1 +
 tests/qemu-iotests/119           |   1 +
 tests/qemu-iotests/120           |   1 +
 tests/qemu-iotests/121           |   1 +
 tests/qemu-iotests/122           |   1 +
 tests/qemu-iotests/123           |   1 +
 tests/qemu-iotests/124           |   1 +
 tests/qemu-iotests/125           |   1 +
 tests/qemu-iotests/126           |   1 +
 tests/qemu-iotests/127           |   1 +
 tests/qemu-iotests/128           |   1 +
 tests/qemu-iotests/129           |   1 +
 tests/qemu-iotests/130           |   1 +
 tests/qemu-iotests/131           |   1 +
 tests/qemu-iotests/132           |   1 +
 tests/qemu-iotests/133           |   1 +
 tests/qemu-iotests/134           |   1 +
 tests/qemu-iotests/135           |   1 +
 tests/qemu-iotests/136           |   1 +
 tests/qemu-iotests/137           |   1 +
 tests/qemu-iotests/138           |   1 +
 tests/qemu-iotests/139           |   1 +
 tests/qemu-iotests/140           |   1 +
 tests/qemu-iotests/141           |   1 +
 tests/qemu-iotests/143           |   1 +
 tests/qemu-iotests/144           |   1 +
 tests/qemu-iotests/145           |   1 +
 tests/qemu-iotests/146           |   1 +
 tests/qemu-iotests/147           |   1 +
 tests/qemu-iotests/148           |   1 +
 tests/qemu-iotests/149           |   1 +
 tests/qemu-iotests/150           |   1 +
 tests/qemu-iotests/151           |   1 +
 tests/qemu-iotests/152           |   1 +
 tests/qemu-iotests/153           |   1 +
 tests/qemu-iotests/154           |   1 +
 tests/qemu-iotests/155           |   1 +
 tests/qemu-iotests/156           |   1 +
 tests/qemu-iotests/157           |   1 +
 tests/qemu-iotests/158           |   1 +
 tests/qemu-iotests/159           |   1 +
 tests/qemu-iotests/160           |   1 +
 tests/qemu-iotests/161           |   1 +
 tests/qemu-iotests/162           |   1 +
 tests/qemu-iotests/163           |   1 +
 tests/qemu-iotests/165           |   1 +
 tests/qemu-iotests/169           |   1 +
 tests/qemu-iotests/170           |   1 +
 tests/qemu-iotests/171           |   1 +
 tests/qemu-iotests/172           |   1 +
 tests/qemu-iotests/173           |   1 +
 tests/qemu-iotests/174           |   1 +
 tests/qemu-iotests/175           |   1 +
 tests/qemu-iotests/176           |   1 +
 tests/qemu-iotests/177           |   1 +
 tests/qemu-iotests/178           |   1 +
 tests/qemu-iotests/179           |   1 +
 tests/qemu-iotests/181           |   1 +
 tests/qemu-iotests/182           |   1 +
 tests/qemu-iotests/183           |   1 +
 tests/qemu-iotests/184           |   1 +
 tests/qemu-iotests/185           |   1 +
 tests/qemu-iotests/186           |   1 +
 tests/qemu-iotests/187           |   1 +
 tests/qemu-iotests/188           |   1 +
 tests/qemu-iotests/189           |   1 +
 tests/qemu-iotests/190           |   1 +
 tests/qemu-iotests/191           |   1 +
 tests/qemu-iotests/192           |   1 +
 tests/qemu-iotests/194           |   1 +
 tests/qemu-iotests/195           |   1 +
 tests/qemu-iotests/196           |   1 +
 tests/qemu-iotests/197           |   1 +
 tests/qemu-iotests/198           |   1 +
 tests/qemu-iotests/199           |   1 +
 tests/qemu-iotests/200           |   1 +
 tests/qemu-iotests/201           |   1 +
 tests/qemu-iotests/202           |   1 +
 tests/qemu-iotests/203           |   1 +
 tests/qemu-iotests/204           |   1 +
 tests/qemu-iotests/205           |   1 +
 tests/qemu-iotests/206           |   1 +
 tests/qemu-iotests/207           |   1 +
 tests/qemu-iotests/208           |   1 +
 tests/qemu-iotests/209           |   1 +
 tests/qemu-iotests/210           |   1 +
 tests/qemu-iotests/211           |   1 +
 tests/qemu-iotests/212           |   1 +
 tests/qemu-iotests/213           |   1 +
 tests/qemu-iotests/214           |   1 +
 tests/qemu-iotests/215           |   1 +
 tests/qemu-iotests/216           |   1 +
 tests/qemu-iotests/217           |   1 +
 tests/qemu-iotests/218           |   1 +
 tests/qemu-iotests/219           |   1 +
 tests/qemu-iotests/220           |   1 +
 tests/qemu-iotests/221           |   1 +
 tests/qemu-iotests/222           |   1 +
 tests/qemu-iotests/223           |   1 +
 tests/qemu-iotests/224           |   1 +
 tests/qemu-iotests/225           |   1 +
 tests/qemu-iotests/226           |   1 +
 tests/qemu-iotests/227           |   1 +
 tests/qemu-iotests/228           |   1 +
 tests/qemu-iotests/229           |   1 +
 tests/qemu-iotests/231           |   1 +
 tests/qemu-iotests/232           |   1 +
 tests/qemu-iotests/233           |   1 +
 tests/qemu-iotests/234           |   1 +
 tests/qemu-iotests/235           |   1 +
 tests/qemu-iotests/236           |   1 +
 tests/qemu-iotests/237           |   1 +
 tests/qemu-iotests/238           |   1 +
 tests/qemu-iotests/239           |   1 +
 tests/qemu-iotests/240           |   1 +
 tests/qemu-iotests/241           |   1 +
 tests/qemu-iotests/242           |   1 +
 tests/qemu-iotests/243           |   1 +
 tests/qemu-iotests/244           |   1 +
 tests/qemu-iotests/245           |   1 +
 tests/qemu-iotests/246           |   1 +
 tests/qemu-iotests/247           |   1 +
 tests/qemu-iotests/248           |   1 +
 tests/qemu-iotests/249           |   1 +
 tests/qemu-iotests/250           |   1 +
 tests/qemu-iotests/251           |   1 +
 tests/qemu-iotests/252           |   1 +
 tests/qemu-iotests/253           |   1 +
 tests/qemu-iotests/254           |   1 +
 tests/qemu-iotests/255           |   1 +
 tests/qemu-iotests/256           |   1 +
 tests/qemu-iotests/257           |   1 +
 tests/qemu-iotests/258           |   1 +
 tests/qemu-iotests/259           |   1 +
 tests/qemu-iotests/260           |   1 +
 tests/qemu-iotests/261           |   1 +
 tests/qemu-iotests/262           |   1 +
 tests/qemu-iotests/263           |   1 +
 tests/qemu-iotests/264           |   1 +
 tests/qemu-iotests/265           |   1 +
 tests/qemu-iotests/266           |   1 +
 tests/qemu-iotests/267           |   1 +
 tests/qemu-iotests/268           |   1 +
 tests/qemu-iotests/270           |   1 +
 tests/qemu-iotests/272           |   1 +
 tests/qemu-iotests/273           |   1 +
 tests/qemu-iotests/277           |   1 +
 tests/qemu-iotests/279           |   1 +
 tests/qemu-iotests/280           |   1 +
 tests/qemu-iotests/281           |   1 +
 tests/qemu-iotests/282           |   1 +
 tests/qemu-iotests/283           |   1 +
 tests/qemu-iotests/284           |   1 +
 tests/qemu-iotests/286           |   1 +
 tests/qemu-iotests/288           |   1 +
 tests/qemu-iotests/289           |   1 +
 tests/qemu-iotests/check         |  20 +--
 tests/qemu-iotests/find_tests.py |  72 ++++++++
 tests/qemu-iotests/group         | 298 -------------------------------
 274 files changed, 402 insertions(+), 309 deletions(-)
 create mode 100755 tests/qemu-iotests/find_tests.py
 delete mode 100644 tests/qemu-iotests/group

--=20
2.21.0


