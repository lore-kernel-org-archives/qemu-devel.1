Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF33C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88092072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QHbVf3tp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88092072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bMT-00060n-TS
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFY-0007N3-TF; Mon, 17 Aug 2020 05:16:17 -0400
Received: from mail-eopbgr00134.outbound.protection.outlook.com
 ([40.107.0.134]:17743 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFP-00086n-Fh; Mon, 17 Aug 2020 05:16:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1hkJPT3AT6+6BkCwMiaS8nR+xECAHqfUnOCCudjWd9FhfIj+AS64a+/XVSwqleiqDoK5N2H2boch52iW7pYMfvWslvTGdyjeCxoCS4NEDyYjTuNAgUXZGW9qopG49cMeyW0K57o6sa7l7MEXJZa4CTUA9k/2a0mrViGlLep/pdMT8aLh8XkcqTM4BTcY/b09dud2DqRu5ZLA5D86DTRQ8EHNOslz3/69PFYAfFlx++T3pq7ZbbgOixVySkZw0QUfT9q4HviR+yhevfVKUKyETEpykNaEBSo7WPICDPJFzIA4LxuftWq/UtxBrvXhuc9nvVmsqV6OQ3IvCJD3QbQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj9ECzM/OAhVqh4aTFvMmB50izq4d2+4sHSw6CNlYMo=;
 b=Ct0E8DmTRFKZMRMl9GVNlBWKoH6iKtPZYZwtXPhS/zZ33S9RHN/tLpnnIy5Qgcxd2hduVk4Udb+cog0mleaS0IFGhmD8ATUfc+ylKl845GXZtBu7/vH8qC/bXIAcD5azuZT0BOdnOjVzpy2isdWSzWKgerOkWaFSIgTsBzGI1kbY447h0WcwHXfGdo0n611l2j9eZPf+GoAJbiimKjy/3lztfX82eUR8mr68GovO2HMEcWJqXPcvZQv62dIdSh83A+cITbh/tGcqOhMg7hK6iCVg+aswjXS4tZRXW2Ehwwr0AMNgtfJ+Z4YPnWlCtiAgNFe1Iyhflo8qtYERW46mqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj9ECzM/OAhVqh4aTFvMmB50izq4d2+4sHSw6CNlYMo=;
 b=QHbVf3tpUM1JjZjXso2E6/8KFd5BvRODNBk4rUQRECC+DpxVu5KXwUcpBqTczYSRnsPmMOiswiSEi/bd+yKNb38viBK0+73vKFa4NG+l1V1fjJfpJBIVbSpwySDXXRz8Q3+qffcMrMI0j20gZ3D64VZuiJHXXtbTGFXVYWZar4o=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4852.eurprd08.prod.outlook.com (2603:10a6:20b:cc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Mon, 17 Aug
 2020 09:16:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 09:16:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 00/12] preallocate filter
Date: Mon, 17 Aug 2020 12:15:41 +0300
Message-Id: <20200817091553.283155-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.174) by
 AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Mon, 17 Aug 2020 09:16:01 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.174]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97f1c59e-ce76-4d0b-58e6-08d8428e29b3
X-MS-TrafficTypeDiagnostic: AM6PR08MB4852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB48524F0A3C020444F6FB8BF8C15F0@AM6PR08MB4852.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tT7PznnFXN5Pb1+CPJrf3KIDV9iSnhM3owokAywSqp2FVQGePUXTJLjYXaIyU8sMN2zmS59uVgwudS+JC/MVybA1vx1Raw+KIOh/hXDZtgimi8VDOwB5wsHEgtFcP/BUnlhoHmbFXj2UTrbE1fK5dDXf9HApcTFZt/AfAZOdI8WZyk8P2SU+Uzxj/dj/lsnD4UnHA7Y70T9Z5w4KnU+zhxHufhJLdbUZVzmGc7c8ccXS9CqK+UoTkSp/cC6W6k7L7/FbwH3mUOwiHjHOxeS7WKTI3Q6GJDGo4f1mE9snoYB0xVsPuvZskJtGG2HVICSBs1ngntrpsbzYgIGvrrIf+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39840400004)(396003)(52116002)(26005)(86362001)(16526019)(6506007)(186003)(6486002)(107886003)(8676002)(8936002)(478600001)(36756003)(4326008)(6916009)(316002)(2906002)(1076003)(6512007)(5660300002)(2616005)(66556008)(66476007)(6666004)(66946007)(956004)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ngM58Jo7aRCUWsT4tF6SFK/+RVGr/0CiPw1Uo0PUwtjwRiFzZ7gPb5aKDk0Y2OtnbJ6+D1AilG5H0CcePN19E1eJR6ppdFv0xZ6aKuUQ1pemDiy3ZyEhRX64oxrxZixglRKc2fjmXsDLidzhwJq8Z4SSA22vdy7Ua4rDBp/YiKHwP5L0aRf/cPiElp1VcEbpTXgV6IqhaPbDjjpsXoSLvLt0TBHgQGa+Jj2ysHbHXIEVZ6fLRBmBHcXzz7oF8BsjG5GRBcxlobHO3sslHJStLBvaR/hXS9+QtecXYOjhEvFENx9E+rW95Qi4fCGNSygz8GNr+H5NfumguaL81u9JcE75Z168nd4++MDKMWOTM/AgImjrVm7fx5uzZ2MysKEP9qPp9AlPL9ZbDr/pZpOS0ihywqDMe1sAT/fvA84hUc/L6UKFeL9LPLj78SaaBE9zhsFeuQkNVYF6/RUKqi5nPakg7mtUkTeLJKBQbwrM6a/XEtZSnoWovoTrHs9gwptzqNspKHFwZajgHXWmBvMm3o+JTg7yJCUTvYmHJvXdLf6o7by3n1Q2W3QKTkr2ZFuhqb3pOvq5MyqWke08gn//TBMeqUhxt6Y0r7Oqtuwhc0svMxj1EKRvh4kCzzkibLFAT+19fwG+dmwF1zjBhlb1lQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f1c59e-ce76-4d0b-58e6-08d8428e29b3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 09:16:02.7484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsXDd5D1UKJG7QV9abNuxqcfvMlENKXvQIJtofGId9T9rwSpyz0qEvOB8UGcwldpdoVWSnIzN2sgAMnsoZyMjGkNDk107LcrsOrMRX2KcgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4852
Received-SPF: pass client-ip=40.107.0.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:16:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Here is a filter, which does preallocation on write.

In Virtuozzo we have to deal with some custom distributed storage
solution, where allocation is relatively expensive operation. We have to
workaround it in Qemu, so here is a new filter.

Patches 1-10 introduces the new filter and suggested to be merged
to master.

Patches 11,12 are here just to show how we are going to use the feature.
I don't know can they be somehow generally useful, ideas are welcome.

Difference from v1:
1-6 are new and substitutes bdrv_co_range_try_lock mechanism used in v1
07: add note to docs/system/qemu-block-drivers.rst.inc
    add open options
    rebase on new BDRV_REQ_NO_WAIT flag
    drop bs->file check in _co_flush()
    add active logic, to make it possible to insert filter dynamically
08,09: new
10: - use new iotests.verify_o_direct()
10: - add qemu-img check call
11,12: not for commit

Vladimir Sementsov-Ogievskiy (12):
  block: simplify comment to BDRV_REQ_SERIALISING
  block/io.c: drop assertion on double waiting for request serialisation
  block/io: split out bdrv_find_conflicting_request
  block/io: bdrv_wait_serialising_requests_locked: drop extra bs arg
  block: bdrv_mark_request_serialising: split non-waiting function
  block: introduce BDRV_REQ_NO_WAIT flag
  block: introduce preallocate filter
  iotests.py: add verify_o_direct helper
  iotests.py: add filter_img_check
  iotests: add 298 to test new preallocate filter driver
  block: add bdrv_is_file_on_fuse helper
  block/qcow2: automatically insert preallocate filter when on FUSE

 docs/system/qemu-block-drivers.rst.inc |  26 +++
 qapi/block-core.json                   |  20 +-
 include/block/block.h                  |  22 +-
 include/block/block_int.h              |   3 +-
 block/file-posix.c                     |  23 +-
 block/io.c                             | 131 ++++++-----
 block/preallocate.c                    | 291 +++++++++++++++++++++++++
 block/qcow2.c                          |  38 ++++
 block/Makefile.objs                    |   1 +
 tests/qemu-iotests/298                 |  50 +++++
 tests/qemu-iotests/298.out             |   6 +
 tests/qemu-iotests/group               |   1 +
 tests/qemu-iotests/iotests.py          |  10 +
 13 files changed, 554 insertions(+), 68 deletions(-)
 create mode 100644 block/preallocate.c
 create mode 100644 tests/qemu-iotests/298
 create mode 100644 tests/qemu-iotests/298.out

-- 
2.18.0


