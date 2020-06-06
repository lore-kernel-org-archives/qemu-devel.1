Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3CBC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B40CC207D0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wXcmoiBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40CC207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhUHV-0001I7-27
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 04:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhUGj-0000mO-1c; Sat, 06 Jun 2020 04:33:33 -0400
Received: from mail-eopbgr70132.outbound.protection.outlook.com
 ([40.107.7.132]:33142 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhUGg-00032q-M0; Sat, 06 Jun 2020 04:33:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDn7qHfXfkRvFqoeP2nVaT2LpO8iL1FWRycahr72A++MxEDELa1rixVN5QuWvB23WL3+yxW5jftAYzdiTkPmEejcPMpvNdRm0YXLm8KZCsCGg3OiCLb2wLHwR+jU3iyarz0/gAB3fu72HrCzyPLJ8O1sRdy1Zs22UN4n6vOFEL9dwxFGB7YyGe8F244NeLX6dv3q9R3iMVsQbkuW5wL6IFKIAmuES/t/s7NlOBekm4CFZHS5np+INuQPdsin0tH5knidzQC/7ECf6W4NI9wI2iv9qE+2ywv9uHjvYglkT/vhljmxG7sbH9UvYJswCKvEjTCUskxOhBcs6T+VV0PtxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KLx3IYZglnf8DFSVzWTGSx9hGu/9Tpkghsr1XZmQhs=;
 b=H8dUcSdWEQllh6tEOVwwvaSsDnilBVWL9tr8pxFgZPqx/CMU2x/O5mph2dqpU1BBWFz3MEls2h+UKtbgwUk1W7rEoW7eQ1X47/igGy14xv5hCtdaS09rGYHu7BdMqe+2gN9C1oH+t3YgbOyq5BQmHVSKntLa0pB+9rtJTeRj/zzfMvxmZMzHU5rOSoqCxoAxe+/VnB792brbqDSDSIPir9eHxv6KIpJyu7f8kNX9PfOrPuiwrpxgwEPubeFFpTK7fUK/3mr5cI/Q+EyKgfarNtKiL8/lGqVA55A/t5uYJNRB/TAR3ciB10UdZoI7Ittn8vm61B4JsoOUjwHm6r70IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KLx3IYZglnf8DFSVzWTGSx9hGu/9Tpkghsr1XZmQhs=;
 b=wXcmoiBJ7Ki5BPypQMO94c0SJoTr8JLA9khLOxVFXAWVGUgu+HXq5uklJHp9+EZl8YDNQepYR2ZSdrpRaJ7HMI99Lh/8mmXqDLVuWNPrca5QSwn+gJtYgPqcVrGcRTQW8KVtbhSKP4tTSY0Dki6CXcVW1MObG/U+3C8dKcNYfKw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5480.eurprd08.prod.outlook.com (2603:10a6:20b:de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 08:18:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 08:18:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 00/13] iotests: Dump QCOW2 dirty bitmaps metadata
Date: Sat,  6 Jun 2020 11:17:53 +0300
Message-Id: <20200606081806.23897-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.130) by
 FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 08:18:22 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68196d7f-c47d-4fd7-cac7-08d809f22db6
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54800FD0E8E2DBBC5790A2E0C1870@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:72;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skdAXjRM1Kbrdas1JyCXU/Y2mXQD/zyPPeP3D065oz88yzmeN+b/FnoiHZLpcvczZE7i5XNz+kOa9c4+8QpW1kZeOQGvpFAI9hnP4wCavubRs58Bo2N3aCA3S6mYsRrICE2EUuzz8zAku2GvOz/A+VcWeAt6vURmn6R4Nx8Oa9CTfefsw5xIBvv5er2UGfxsPalNc018t0iNZRdXeNx/G8pCqGn8+5M4xmNn4lKfgW6MVkAQMRagokDzNTqMr7xaDvph9vQ2r7N1QIoZ223scEfWYlXX83uXDOZugU4wF6JRAG2Lahyn77SeUDFIKIiUHy0Ffq05T9HI7bhEDZ02272CwP/w5vulFyVk/ZD8S16HpK6ckW8PXo8jQlFHK/qbWDxOYrUw6mY0bRUNMW/0+GttOsuCYJYHa6WfVqKFey/jQ0RtAQbrTiYKUyozZDcZj6iZfmFGqWIJd5BlKrR93g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39830400003)(376002)(346002)(396003)(107886003)(1076003)(4326008)(2906002)(36756003)(6512007)(966005)(66946007)(66556008)(66476007)(6486002)(5660300002)(83380400001)(478600001)(86362001)(2616005)(956004)(316002)(26005)(6506007)(52116002)(6666004)(8936002)(6916009)(16526019)(186003)(8676002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ye3Q8tGtBCb4nDwdjt7LxUJMcEJERr/MHkQ+H9iMPSupIN2n5b2duJ41ngqqSsarkmZBVyO5eG1QkZ7OTGIjO24f98X2yK8J8UUNHnWf+gVxnmwJPqiaZGCBmNQnneRtMMEtFlSNenMdmMlkSL4D4H1T175Lc/PwVf59kQOf/C/QXeNbVqETw3w7TaVi4VYpjaaV820aCEZSQo2saUqnPkm201o2D12E7UykWwrsetNGhmgiVraN8zhbx7eq7VtRoEytFGDUsbWCj3D/thL2cU+ZMbO5ddbTSgZ6KCaPWl+P+aqna1QoYDD8EutEGDLhx12rWkI4Nwzyy5Eu+BEI5lJCE8qQBIM05DcwWdrgCIU0r8g0lagYB5x/bihGAof2FQMtxhX6Cbl5bCMtyFkenGPX3DUeuaXWx3CITefbmAoeyXSt4Kz5wPgJuNZgtVbXO75D0VLdejLhZM7RiyD6UqZk6EB3PbrgG9GbFWY6ZCGSaXD6yr7SEjFifoHkKevX
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68196d7f-c47d-4fd7-cac7-08d809f22db6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 08:18:22.8128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DotxdXsGOkvJgRqMVx5TdeDDzmbYzTqdKfWzNirxG5E+gvV5jeUqC88NU6CA8uabxwdzs2iYWY+nLr0glDYLkRpBs+ioQI6s9oTT8oPP0A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5480
Received-SPF: pass client-ip=40.107.7.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 04:33:27
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
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Here is my suggestion to substitute only first three patches :) of
Andrey's [PATCH v3 0/6] iotests: Dump QCOW2 dirty bitmaps metadata

v5:
01: - typo in commit message
    - fix over-79 lines
02: new, specify GPL license
03: specify GPL license
04-06: add Andrey's r-b
07: - grammar in commit message
    - add Andrey's r-b
08: - add copyright
    - note u8 and u16 in a comment
    - add doc for __init__ of Qcow2Struct
    - add Andrey's r-b
09-10: add Andrey's r-b
11: - note about current fd position in __init__ doc of
      QcowHeaderExtension
    - add Andrey's r-b
12: - keep magic in hex
    - use lower-case for magic constants
13: add Andrey's r-b

Tags up-refactor-qcow2.py-v4 and up-refactor-qcow2.py-v4 may be found
here: https://src.openvz.org/users/vsementsov/repos/qemu/browse
(git remote: https://src.openvz.org/scm/~vsementsov/qemu.git)

Plan for continuation:

- add type hints
- support compression_type field
- dump more about bitmaps

Vladimir Sementsov-Ogievskiy (13):
  qcow2.py: python style fixes
  qcow2.py: add licensing blurb
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
 tests/qemu-iotests/qcow2.py        | 218 +++++-----------------
 tests/qemu-iotests/qcow2_format.py | 286 +++++++++++++++++++++++++++++
 7 files changed, 393 insertions(+), 188 deletions(-)
 create mode 100644 tests/qemu-iotests/qcow2_format.py

-- 
2.21.0


