Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4FAC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:17:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181C1206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="d52uacKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181C1206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZhht-0003cB-4j
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 17:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhfz-0001jP-CI; Fri, 15 May 2020 17:15:27 -0400
Received: from mail-db8eur05on2100.outbound.protection.outlook.com
 ([40.107.20.100]:45280 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhfw-0005Vf-JW; Fri, 15 May 2020 17:15:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCJyXuuyBjG4cJw9wSyhWGJ8XeoDHHAoi3ak2auTcTfQPEf2oHAqeGCg9/hN4RhiUPIBL5mUPw5ZzXwuPp8vdsPHOQK2daZJdSCE6QkE0RhJr7/6kYrOxprPIfyx1KOhLu1IdFZuGfc362O7xIpPenm2CH8xRQCY30vY1XHQU4wgzNALXlZ5S6nU49BCg46focma5S7fd5SpLhQKmhy2wefv135nHQdLAEE8usLonoMZA69rkbYSJM3nSByXlH6SEw0puCV9Qr0i3t6m/8xAtQ/gQ7sPRGsu0QSMCNkR7fpThsv5H1K7dz3cE6d5PtL7j8Yh9vReTdp0ocMOUWjc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GilkJu+QJc0f1mrnJfBw76rC1UYyIXg9o4zHLgateJk=;
 b=iGI79eGaPp9D8zpGyVEf2kMYlaCRsjoo4objZZFEpDtrCHqeHDV+uWGOrpMdB7LbRf4oAgqrjlqlK72a7Xy8FAzlaSJILpmv0q8kM6CMlO3vUDO2r5NCwuc+FZJiJ7DaTFuWcI0yR1S5GefcdeD+4BmwPlITq9E411vIcSa9Uj2qzxuNlJYv6s47eV5Ceh8JWwNRXoA+r5S4cnpp/dBaRfZrIfzJD+hgOReillTYL5S4ujd5AtfyCF7EcpaWBpB21FOQM1sxmSYOzSu632WTr6A89BVqlDv3znCFmtczZ2DpF1y0mZICgh6bq+F/1CPZZZ7ZFl8ZaVt6JtYcZJJzNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GilkJu+QJc0f1mrnJfBw76rC1UYyIXg9o4zHLgateJk=;
 b=d52uacKZQ2vnChT9fWCU551cWO6LBVrBYbozbkcO2k245TDiIcyCRTy6wLzl0mtpR4VZHJKaSIMn81GVfSg0Qi3OjNGeytcEx9dUN+i33ZQCGEBnKMFS2Q+ZIYfzfyYZ4VrKI1n/kfle/0MJGTxKONJAu3QAsBFR6ryo2h1Ha0U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 21:15:18 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 21:15:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 0/9] Rework iotests/check
Date: Sat, 16 May 2020 00:14:56 +0300
Message-Id: <20200515211505.3042-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.184) by
 AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 21:15:17 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaf8df83-e9e5-4db8-bdf1-08d7f91511b8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB547872BE064375A5B23B5116C1BD0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGRUCF1TmU9F3ue3hzPPg8hGzWIZ4AXNfOn/yAbp9SkAiNqIAH3loWWbo2wsS0B7jIpy773MamIJxH0Uyi/5hYdo5QcWrOwYx+kr4dfNU3DVPNTc3AkWZxBnXYY2rB40kIESVBzkeueRCLWeyg4ai1iltBofQfQ7+J6Y1/20OpQcVeOh+yj/vwmGJKO74Unkc1bXxHwIqzpZpWciVrTRsBZ3z+5iZZcUpnYL6ZZEu/4SfB6kGRzInMhhVHmoS3QRcdZy4lOyL1viDQK50PFX+mG918PNa020QnYPUeLk1T9OOBGxF4FYQ+D+CKTfUApFZaU7q/Zr5/75laNFANZpYw95td6NFa/yL8KjRY4IW3Q2QMYEEeQ43wbyDXG6wjWL0pIQ0t4CxVRL6zZJXgyAfzJnsvM86nAzY2wY/HQr2bYFA31Oz1q1FDvTJCJWmkn+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(346002)(376002)(366004)(396003)(26005)(86362001)(6486002)(2906002)(6916009)(36756003)(8936002)(316002)(8676002)(66476007)(66946007)(1076003)(66556008)(956004)(52116002)(4326008)(186003)(16526019)(478600001)(6506007)(6666004)(6512007)(2616005)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sKC8FZquEFhR2VxGGr8W/QpG0AFq8G5hrtsTIr/C29j7+Hodiywmo50WU8I02/yhLMz1SPse3hGHtogljxUXsm81TalXJay9eQ5sb7Q2aFqZjx43sDIDNs0cUvrsrJzgkwR1G+pc5zbMPA+mXRv9Dg36ZdOCbOSsVFK1tAWVVofnUj86K6iCzh5pVuKdb2dIhCDc6Jmhx4OsJ7aJJ2WNTU7u0O+kCDfnQ9Z7PZQfFs8pOZHlaEdpYmCpQpGVcs8VjC6n6Z6YLbMQXzIwBsDgkAAGS+O+0exEQ6axxAkZNortAsFafAhDwQEDdRh9vn3q+An942I1JWvBejbydbmIE1ue1+gybfkpR2CewCfZ7Z1EYm12xipEyiR9qWlkhsXrkYdBec4r6Q28yey4uSpGphCOC3eDkEomDULDdYlOYC3zFmAlHW0qI65vPS1BwglKhjk/ge3/Si6MxSOdCMc+UTq5+FoiBz514udfyK7n+tQoO2wn5cSo0iJCY0Vf63Kb
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf8df83-e9e5-4db8-bdf1-08d7f91511b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 21:15:18.7046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcEHofyv0NrsuHhoVU7Uv4LX2BxP57NOZ0ayjRbqQco8Dhfxg5nnHJGGbu0xXSSUJGib79obTdG1wRwnh35yXtphoKCQNbtQJ8wskss8+54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.20.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 17:15:19
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

These series has 3 goals:

 - get rid of group file
 - introduce human-readable names for tests
 - rewrite check into python

v4:
   - human readable tests in  ..qemu-iotests/tests subdirectory
   - add --start-from argument for findtests
   - add type hinting

Vladimir Sementsov-Ogievskiy (9):
  iotests/277: use dot slash for nbd-fault-injector.py running
  iotests: fix some whitespaces in test output files
  iotests/283: make executable
  iotests: define group in each iotest
  iotests: add findtests.py
  iotests: add testenv.py
  iotests: add testrunner.py
  iotests: rewrite check into python
  iotests: rename and move 169 and 199 tests

 docs/devel/testing.rst                        |  50 +-
 tests/qemu-iotests/001                        |   1 +
 tests/qemu-iotests/002                        |   1 +
 tests/qemu-iotests/003                        |   1 +
 tests/qemu-iotests/004                        |   1 +
 tests/qemu-iotests/005                        |   1 +
 tests/qemu-iotests/007                        |   1 +
 tests/qemu-iotests/008                        |   1 +
 tests/qemu-iotests/009                        |   1 +
 tests/qemu-iotests/010                        |   1 +
 tests/qemu-iotests/011                        |   1 +
 tests/qemu-iotests/012                        |   1 +
 tests/qemu-iotests/013                        |   1 +
 tests/qemu-iotests/014                        |   1 +
 tests/qemu-iotests/015                        |   1 +
 tests/qemu-iotests/017                        |   1 +
 tests/qemu-iotests/018                        |   1 +
 tests/qemu-iotests/019                        |   1 +
 tests/qemu-iotests/020                        |   1 +
 tests/qemu-iotests/021                        |   1 +
 tests/qemu-iotests/022                        |   1 +
 tests/qemu-iotests/023                        |   1 +
 tests/qemu-iotests/024                        |   1 +
 tests/qemu-iotests/025                        |   1 +
 tests/qemu-iotests/026                        |   1 +
 tests/qemu-iotests/027                        |   1 +
 tests/qemu-iotests/028                        |   1 +
 tests/qemu-iotests/029                        |   1 +
 tests/qemu-iotests/030                        |   1 +
 tests/qemu-iotests/031                        |   1 +
 tests/qemu-iotests/032                        |   1 +
 tests/qemu-iotests/033                        |   1 +
 tests/qemu-iotests/034                        |   1 +
 tests/qemu-iotests/035                        |   1 +
 tests/qemu-iotests/036                        |   1 +
 tests/qemu-iotests/037                        |   1 +
 tests/qemu-iotests/038                        |   1 +
 tests/qemu-iotests/039                        |   1 +
 tests/qemu-iotests/040                        |   1 +
 tests/qemu-iotests/041                        |   1 +
 tests/qemu-iotests/042                        |   1 +
 tests/qemu-iotests/043                        |   1 +
 tests/qemu-iotests/044                        |   1 +
 tests/qemu-iotests/045                        |   1 +
 tests/qemu-iotests/046                        |   1 +
 tests/qemu-iotests/047                        |   1 +
 tests/qemu-iotests/048                        |   1 +
 tests/qemu-iotests/049                        |   1 +
 tests/qemu-iotests/050                        |   1 +
 tests/qemu-iotests/051                        |   1 +
 tests/qemu-iotests/052                        |   1 +
 tests/qemu-iotests/053                        |   1 +
 tests/qemu-iotests/054                        |   1 +
 tests/qemu-iotests/055                        |   1 +
 tests/qemu-iotests/056                        |   1 +
 tests/qemu-iotests/057                        |   1 +
 tests/qemu-iotests/058                        |   1 +
 tests/qemu-iotests/059                        |   1 +
 tests/qemu-iotests/060                        |   1 +
 tests/qemu-iotests/061                        |   1 +
 tests/qemu-iotests/062                        |   1 +
 tests/qemu-iotests/063                        |   1 +
 tests/qemu-iotests/064                        |   1 +
 tests/qemu-iotests/065                        |   1 +
 tests/qemu-iotests/066                        |   1 +
 tests/qemu-iotests/067                        |   1 +
 tests/qemu-iotests/068                        |   1 +
 tests/qemu-iotests/069                        |   1 +
 tests/qemu-iotests/070                        |   1 +
 tests/qemu-iotests/071                        |   1 +
 tests/qemu-iotests/072                        |   1 +
 tests/qemu-iotests/073                        |   1 +
 tests/qemu-iotests/074                        |   1 +
 tests/qemu-iotests/075                        |   1 +
 tests/qemu-iotests/076                        |   1 +
 tests/qemu-iotests/077                        |   1 +
 tests/qemu-iotests/078                        |   1 +
 tests/qemu-iotests/079                        |   1 +
 tests/qemu-iotests/080                        |   1 +
 tests/qemu-iotests/081                        |   1 +
 tests/qemu-iotests/082                        |   1 +
 tests/qemu-iotests/083                        |   1 +
 tests/qemu-iotests/084                        |   1 +
 tests/qemu-iotests/085                        |   1 +
 tests/qemu-iotests/086                        |   1 +
 tests/qemu-iotests/087                        |   1 +
 tests/qemu-iotests/088                        |   1 +
 tests/qemu-iotests/089                        |   1 +
 tests/qemu-iotests/090                        |   1 +
 tests/qemu-iotests/091                        |   1 +
 tests/qemu-iotests/092                        |   1 +
 tests/qemu-iotests/093                        |   1 +
 tests/qemu-iotests/094                        |   1 +
 tests/qemu-iotests/095                        |   1 +
 tests/qemu-iotests/096                        |   1 +
 tests/qemu-iotests/097                        |   1 +
 tests/qemu-iotests/098                        |   1 +
 tests/qemu-iotests/099                        |   1 +
 tests/qemu-iotests/101                        |   1 +
 tests/qemu-iotests/102                        |   1 +
 tests/qemu-iotests/103                        |   1 +
 tests/qemu-iotests/104                        |   1 +
 tests/qemu-iotests/105                        |   1 +
 tests/qemu-iotests/106                        |   1 +
 tests/qemu-iotests/107                        |   1 +
 tests/qemu-iotests/108                        |   1 +
 tests/qemu-iotests/109                        |   1 +
 tests/qemu-iotests/110                        |   1 +
 tests/qemu-iotests/111                        |   1 +
 tests/qemu-iotests/112                        |   1 +
 tests/qemu-iotests/113                        |   1 +
 tests/qemu-iotests/114                        |   1 +
 tests/qemu-iotests/115                        |   1 +
 tests/qemu-iotests/116                        |   1 +
 tests/qemu-iotests/117                        |   1 +
 tests/qemu-iotests/118                        |   1 +
 tests/qemu-iotests/119                        |   1 +
 tests/qemu-iotests/120                        |   1 +
 tests/qemu-iotests/121                        |   1 +
 tests/qemu-iotests/122                        |   1 +
 tests/qemu-iotests/123                        |   1 +
 tests/qemu-iotests/124                        |   1 +
 tests/qemu-iotests/125                        |   1 +
 tests/qemu-iotests/126                        |   1 +
 tests/qemu-iotests/127                        |   1 +
 tests/qemu-iotests/128                        |   1 +
 tests/qemu-iotests/129                        |   1 +
 tests/qemu-iotests/130                        |   1 +
 tests/qemu-iotests/131                        |   1 +
 tests/qemu-iotests/132                        |   1 +
 tests/qemu-iotests/133                        |   1 +
 tests/qemu-iotests/134                        |   1 +
 tests/qemu-iotests/135                        |   1 +
 tests/qemu-iotests/136                        |   1 +
 tests/qemu-iotests/137                        |   1 +
 tests/qemu-iotests/138                        |   1 +
 tests/qemu-iotests/139                        |   1 +
 tests/qemu-iotests/140                        |   1 +
 tests/qemu-iotests/141                        |   1 +
 tests/qemu-iotests/143                        |   1 +
 tests/qemu-iotests/144                        |   1 +
 tests/qemu-iotests/145                        |   1 +
 tests/qemu-iotests/146                        |   1 +
 tests/qemu-iotests/147                        |   1 +
 tests/qemu-iotests/148                        |   1 +
 tests/qemu-iotests/149                        |   1 +
 tests/qemu-iotests/150                        |   1 +
 tests/qemu-iotests/151                        |   1 +
 tests/qemu-iotests/152                        |   1 +
 tests/qemu-iotests/153                        |   1 +
 tests/qemu-iotests/154                        |   1 +
 tests/qemu-iotests/155                        |   1 +
 tests/qemu-iotests/156                        |   1 +
 tests/qemu-iotests/157                        |   1 +
 tests/qemu-iotests/158                        |   1 +
 tests/qemu-iotests/159                        |   1 +
 tests/qemu-iotests/160                        |   1 +
 tests/qemu-iotests/161                        |   1 +
 tests/qemu-iotests/162                        |   1 +
 tests/qemu-iotests/163                        |   1 +
 tests/qemu-iotests/165                        |   1 +
 tests/qemu-iotests/170                        |   1 +
 tests/qemu-iotests/171                        |   1 +
 tests/qemu-iotests/172                        |   1 +
 tests/qemu-iotests/173                        |   1 +
 tests/qemu-iotests/174                        |   1 +
 tests/qemu-iotests/175                        |   1 +
 tests/qemu-iotests/175.out                    |   2 +-
 tests/qemu-iotests/176                        |   1 +
 tests/qemu-iotests/177                        |   1 +
 tests/qemu-iotests/178                        |   1 +
 tests/qemu-iotests/179                        |   1 +
 tests/qemu-iotests/181                        |   1 +
 tests/qemu-iotests/182                        |   1 +
 tests/qemu-iotests/183                        |   1 +
 tests/qemu-iotests/184                        |   1 +
 tests/qemu-iotests/185                        |   1 +
 tests/qemu-iotests/186                        |   1 +
 tests/qemu-iotests/187                        |   1 +
 tests/qemu-iotests/188                        |   1 +
 tests/qemu-iotests/189                        |   1 +
 tests/qemu-iotests/190                        |   1 +
 tests/qemu-iotests/191                        |   1 +
 tests/qemu-iotests/192                        |   1 +
 tests/qemu-iotests/194                        |   1 +
 tests/qemu-iotests/195                        |   1 +
 tests/qemu-iotests/196                        |   1 +
 tests/qemu-iotests/197                        |   1 +
 tests/qemu-iotests/198                        |   1 +
 tests/qemu-iotests/200                        |   1 +
 tests/qemu-iotests/201                        |   1 +
 tests/qemu-iotests/202                        |   1 +
 tests/qemu-iotests/203                        |   1 +
 tests/qemu-iotests/204                        |   1 +
 tests/qemu-iotests/205                        |   1 +
 tests/qemu-iotests/206                        |   1 +
 tests/qemu-iotests/207                        |   1 +
 tests/qemu-iotests/208                        |   1 +
 tests/qemu-iotests/209                        |   1 +
 tests/qemu-iotests/210                        |   1 +
 tests/qemu-iotests/211                        |   1 +
 tests/qemu-iotests/212                        |   1 +
 tests/qemu-iotests/213                        |   1 +
 tests/qemu-iotests/214                        |   1 +
 tests/qemu-iotests/215                        |   1 +
 tests/qemu-iotests/216                        |   1 +
 tests/qemu-iotests/217                        |   1 +
 tests/qemu-iotests/218                        |   1 +
 tests/qemu-iotests/219                        |   1 +
 tests/qemu-iotests/220                        |   1 +
 tests/qemu-iotests/221                        |   1 +
 tests/qemu-iotests/222                        |   1 +
 tests/qemu-iotests/223                        |   1 +
 tests/qemu-iotests/224                        |   1 +
 tests/qemu-iotests/225                        |   1 +
 tests/qemu-iotests/226                        |   1 +
 tests/qemu-iotests/227                        |   1 +
 tests/qemu-iotests/228                        |   1 +
 tests/qemu-iotests/229                        |   1 +
 tests/qemu-iotests/231                        |   1 +
 tests/qemu-iotests/232                        |   1 +
 tests/qemu-iotests/233                        |   1 +
 tests/qemu-iotests/234                        |   1 +
 tests/qemu-iotests/235                        |   1 +
 tests/qemu-iotests/236                        |   1 +
 tests/qemu-iotests/237                        |   1 +
 tests/qemu-iotests/238                        |   1 +
 tests/qemu-iotests/239                        |   1 +
 tests/qemu-iotests/240                        |   1 +
 tests/qemu-iotests/241                        |   1 +
 tests/qemu-iotests/242                        |   1 +
 tests/qemu-iotests/243                        |   1 +
 tests/qemu-iotests/244                        |   1 +
 tests/qemu-iotests/245                        |   1 +
 tests/qemu-iotests/246                        |   1 +
 tests/qemu-iotests/247                        |   1 +
 tests/qemu-iotests/248                        |   1 +
 tests/qemu-iotests/249                        |   1 +
 tests/qemu-iotests/250                        |   1 +
 tests/qemu-iotests/251                        |   1 +
 tests/qemu-iotests/252                        |   1 +
 tests/qemu-iotests/253                        |   1 +
 tests/qemu-iotests/254                        |   1 +
 tests/qemu-iotests/255                        |   1 +
 tests/qemu-iotests/256                        |   1 +
 tests/qemu-iotests/257                        |   1 +
 tests/qemu-iotests/258                        |   1 +
 tests/qemu-iotests/259                        |   1 +
 tests/qemu-iotests/260                        |   1 +
 tests/qemu-iotests/261                        |   1 +
 tests/qemu-iotests/262                        |   1 +
 tests/qemu-iotests/263                        |   1 +
 tests/qemu-iotests/264                        |   1 +
 tests/qemu-iotests/265                        |   1 +
 tests/qemu-iotests/266                        |   1 +
 tests/qemu-iotests/267                        |   1 +
 tests/qemu-iotests/267.out                    |  48 +-
 tests/qemu-iotests/268                        |   1 +
 tests/qemu-iotests/270                        |   1 +
 tests/qemu-iotests/272                        |   1 +
 tests/qemu-iotests/273                        |   1 +
 tests/qemu-iotests/274                        |   1 +
 tests/qemu-iotests/277                        |   3 +-
 tests/qemu-iotests/279                        |   1 +
 tests/qemu-iotests/280                        |   1 +
 tests/qemu-iotests/281                        |   1 +
 tests/qemu-iotests/282                        |   1 +
 tests/qemu-iotests/283                        |   1 +
 tests/qemu-iotests/284                        |   1 +
 tests/qemu-iotests/286                        |   1 +
 tests/qemu-iotests/287                        |   1 +
 tests/qemu-iotests/287.out                    |  10 +-
 tests/qemu-iotests/288                        |   1 +
 tests/qemu-iotests/289                        |   1 +
 tests/qemu-iotests/290                        |   1 +
 tests/qemu-iotests/292                        |   1 +
 tests/qemu-iotests/check                      | 983 +-----------------
 tests/qemu-iotests/findtests.py               | 229 ++++
 tests/qemu-iotests/group                      | 302 ------
 tests/qemu-iotests/testenv.py                 | 325 ++++++
 tests/qemu-iotests/testrunner.py              | 351 +++++++
 .../migrate-bitmaps-postcopy-test}            |   1 +
 .../migrate-bitmaps-postcopy-test.out}        |   0
 .../{169 => tests/migrate-bitmaps-test}       |   1 +
 .../migrate-bitmaps-test.out}                 |   0
 285 files changed, 1287 insertions(+), 1289 deletions(-)
 mode change 100644 => 100755 tests/qemu-iotests/283
 create mode 100755 tests/qemu-iotests/findtests.py
 delete mode 100644 tests/qemu-iotests/group
 create mode 100755 tests/qemu-iotests/testenv.py
 create mode 100644 tests/qemu-iotests/testrunner.py
 rename tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test} (99%)
 rename tests/qemu-iotests/{199.out => tests/migrate-bitmaps-postcopy-test.out} (100%)
 rename tests/qemu-iotests/{169 => tests/migrate-bitmaps-test} (99%)
 rename tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out} (100%)

-- 
2.21.0


