Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F206C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 14:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2682623BCD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 14:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PC8U8UYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2682623BCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmed7-0004O9-BI
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 10:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmecD-0002GD-Mw; Sat, 20 Jun 2020 10:37:05 -0400
Received: from mail-eopbgr50102.outbound.protection.outlook.com
 ([40.107.5.102]:35810 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmecA-0004UK-4b; Sat, 20 Jun 2020 10:37:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpPlRRc8d+48XBwbRfCFZljEYqTkYRLbSnHPJogX751/3lVwjCLjKZjw6IOfGt7iwtnw0rEquHS0va9oB8I0w9tL+9NdwV/L+rFkcWAFFATA6vgbi0XusfEFyGO5h0AjcutwrHdYZEYef1nFlBN3Z0qDifOZhghGpeXMjOgqTDRCp3vHKXJR3AFt1znJyCyU8pee7gELLGC1v2qVy0K4dSunvKTrEJi3UZl6e7/WFaoqX4fHBeoRwIf/UAGKowEtb0z5LAoNXLneB2zgqygdySyzAskEIdKQwkRF+dI92Upun/563e9trzFvPcaRQ/DztO19ukQovP0kr7Jdc0IIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwa47rHGbjq4lPcho0ThmI1a97tF+JuM2CtWvzV8c8w=;
 b=ZDAH7Tkgo9tqP5Eb1JHOxPFLircPkKaIcUfkDiCGtjEXE+T1POUs41mCPlOhWxSqf9d213OZZppFvL6pejhB4G6MRTQG37mzolMd1TdLLY60CjV04xFkc2/42uixCyWRpLDTmL+svJ64CugFMW1jWNTBxN6S7PcrToqt4yfzJx2kuc2Esb3+IvL/cRS0RmdvevtjmGRpJ94z9Dpz2AgK6WbQA6RKVLYvXglVgr5OYG7boRKNjoALLeF8XBEPukVKI3Gt3wrD1wLm19N62EDjgEm4N2GQv1R2Awb/PB9C0JAvc5cVKYobYGqqIRwSedhMI7xtfYJ4gU/jVxkvB/vFCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwa47rHGbjq4lPcho0ThmI1a97tF+JuM2CtWvzV8c8w=;
 b=PC8U8UYGJ9XoYCsfUvKUv7wR+mpRfkTC953csSmiTnQ2ysBoD8Pauyoe5DifgBC8/A4iy6YCPNWhjKTrC/i/NxCPy3gLhvR7R5vlJsx1hSy49KmO3ULFOpStHrXszTTx2/eKy+AYyfYCAdRp5rLeoHnJubi0GW6DjdSUpzYgW2U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5430.eurprd08.prod.outlook.com (2603:10a6:20b:106::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Sat, 20 Jun
 2020 14:36:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 14:36:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/5] preallocate filter
Date: Sat, 20 Jun 2020 17:36:44 +0300
Message-Id: <20200620143649.225852-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
Content-Type: text/plain
X-ClientProxiedBy: AM3PR03CA0055.eurprd03.prod.outlook.com
 (2603:10a6:207:5::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.122) by
 AM3PR03CA0055.eurprd03.prod.outlook.com (2603:10a6:207:5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Sat, 20 Jun 2020 14:36:56 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b910025-9e56-4010-660b-08d815276247
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB543020105D727013820DB4B8C1990@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0440AC9990
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJ+mjl0DBXN9i1BM7yc4540MUZMY8EZKkhIiLccWTaNRlFFoPf7iRnO5c6YeX80d6LAOUWTXzW6aU7LNapjfLe+R8EY4bEG/ySMqEAOM7EaOvehW1umn/Kt/uHJPymyEdBfFgq6/tfGE9dixqq3LCnIl22xyNrn2EqHsjHhqj7QqKb+PQaSbvZ9G/VNeomhbKOgGdkmZtgvp2IqfYXX3et0Wq6xfcXFP64WRHE2DUhmQYGbgdF1LVsjud+uNMShkZWoPdaO2C1PyJXoo9cl/+44UgqOY1qbUEjiAVe4Z+F7vDDI0o63e0e9jQl8DfVk8ISCWoILXSzal+xVelwPNBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39840400004)(6666004)(26005)(186003)(16526019)(86362001)(2906002)(6916009)(6512007)(4326008)(83380400001)(52116002)(2616005)(6506007)(478600001)(956004)(36756003)(5660300002)(6486002)(8676002)(316002)(66946007)(8936002)(66476007)(1076003)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ksa75O+VIHpU9+n9xe0xiRx01+mFjHCILxSiQk1Nza28Qtwtpg5hmOXDtS4qlcd3a/62dZ/nR3s0cVq7PwaHLiaPE6iRzDMvfJq48vW6B7evA6msokEl0E1H2BJYfJJQFNFv1Sc/U4rZwlwuWm7THRdhrRZU5KgiNQjk368bFjFFfBGhzkQDsJZhSOomxiLupM9IcrO+tzCj+ZI/UO0vSkCbfqjNDZmGycS5cVYEPiOZ+UfNv33SmYwCLsGdriw+ApGPAOedISSwQu5Qv5G9b9cDLAi/MivY9cMNEi7K/CAqaZs2eVt1HZLboYzffNoKQhAERH0XG3/WE0vAdPpbED8e7Qn/5awYxaaVwmJhS5IR9a0qcr15qgGi3ehCmK7iSeZCLkBAiMyccrla3t/SSpf94qTa647ltFHddR2AOf2l6sP7jxZesY8NRq6DqNvcA3ijpL66JigpuP6GOZ7qS7+0XYXOnX5Fs61/+0+fkMDzLzPnNT3l2Mz9aOjD2f8a
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b910025-9e56-4010-660b-08d815276247
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2020 14:36:57.1600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDzlO6gJHB0GsXLeUMzAwapyZXnoni6ZGpllXeozCjMLZe86pFwY+5Ug7PNCndEQV26lT2efLucOJFHzNeu6ZyGdxY8boNTCy9kt9vzxafE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Received-SPF: pass client-ip=40.107.5.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 10:36:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 Anton.Nefedov@acronis.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Here is a filter, which does preallocation on write.

In Virtuozzo we have to deal with some custom distributed storage solution,
where allocation is relatively expensive operation. We have to workaround it
in Qemu, so here is a new filter.

Performance results with the following test are very significant:

    IMG=/megassd/z; FILE_OPTS=file.filename=$IMG; COUNT=15000; CHUNK=64K; \
    CLUSTER=1M; rm -f $IMG; \
    ./qemu-img create -f qcow2 -o cluster_size=$CLUSTER $IMG 1G; \
    ./qemu-img bench -c $COUNT -d 1 -s $CHUNK -w -t none --image-opts driver=qcow2,$FILE_OPTS;

 - qemu-img bench reports ~44.3s, and if I switch FILE_OPTS to be

    FILE_OPTS=file.driver=preallocate,file.file.filename=$IMG

 qemu-img bench reports ~4.3s, 90% benefit!

(/megassd is a mount point of distributed storage)

Unfortunately, I don't know another real-world case where preallocation
would so helpful. If someone have running ceph instance and can check
it I'd be very grateful.

Still, I hope, it may be useful at least for some testing purposes.
And, small example I have: small writes with small sectors on usual ext4 over ssd gives
the following for me:

    IMG=/ssd/z; FILE_OPTS=file.filename=$IMG; COUNT=15000; CHUNK=512; \
    CLUSTER=512; rm -f $IMG; \
    ./qemu-img create -f qcow2 -o cluster_size=$CLUSTER $IMG 1G; \
    ./qemu-img bench -c $COUNT -d 1 -s $CHUNK -w -t none --image-opts driver=qcow2,$FILE_OPTS;

 ~17.1s

 and, if I switch FILE_OPTS to use new filter, the result is ~14.9s, i.e ~13% better.

=====

The series also introduces bdrv-lock-region interface, which may be reused to
implement copy-on-read operation directly inside copy-on-read filter, instead of
handling the special flag in generic code.

Vladimir Sementsov-Ogievskiy (5):
  block/io: introduce bdrv_try_mark_request_serialising
  block/io: introduce bdrv_co_range_try_lock
  block: introduce preallocate filter
  iotests: QemuIoInteractive: use qemu_io_args_no_fmt
  iotests: add 298 to test new preallocate filter driver

 qapi/block-core.json          |   3 +-
 include/block/block.h         |   9 ++
 include/block/block_int.h     |  16 +++
 include/qemu/typedefs.h       |   1 +
 block/io.c                    | 142 ++++++++++++++++---
 block/preallocate.c           | 255 ++++++++++++++++++++++++++++++++++
 block/Makefile.objs           |   1 +
 tests/qemu-iotests/298        |  45 ++++++
 tests/qemu-iotests/298.out    |   5 +
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |   2 +-
 11 files changed, 455 insertions(+), 25 deletions(-)
 create mode 100644 block/preallocate.c
 create mode 100644 tests/qemu-iotests/298
 create mode 100644 tests/qemu-iotests/298.out

-- 
2.18.0


