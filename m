Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66095C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9AF2071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OuDSFvpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9AF2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDj5R-0004il-B3
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 02:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDj4b-00046A-Dl; Thu, 03 Sep 2020 02:50:18 -0400
Received: from mail-eopbgr40130.outbound.protection.outlook.com
 ([40.107.4.130]:5305 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDj4W-0005oF-IL; Thu, 03 Sep 2020 02:50:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLbTM6TsLY7YUlooB4HjttCfAuXi/C3LV+RkCUDbKlEypIMiEOwkZiq+/GTLDQHC7/fnBzYrZeju+2gb2eP4OBDUjdUErmNIa56aAJJNllYI2Gwi8Zw9EepfffRlRHaE3S+vsI/JI8dlaehf0HB8d2xGctWhzqHD5pAgherUP6jfUpPR1ujmtYV3mXqBuT3+oUL8n3AyfvNHyyPQ3n7ePaQW4yyZ7PDtZ5+8N0L/E8y90yTe+Lpmw0Cfb1YoGaGJ5GOO6ERoAqqJHmGV5ISWXkG8Gf7vNKeRu79Z5yYwiKRUNf2APOXwostC9PLE4JMkMYPwoMcFYADAKYn80/PUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnLiclauLqO2Jq/uSuxCYCh5NevB/OEsIUFAdJajWP8=;
 b=EeZicxkAQ1gh2yzk/xkGa8f4wrf8sgIsQK78xL49dzZgVyHERNT83iNr8Htxz1Dh8+znH+mcvESlVDlxeC7vtVNdhuw8wC8/PRc5UDREtJvN+CTxo04fsfPGeGm9YaPHlbB9skuobtV3RhElrKfIsnWyItkAVb18lHpAQJ/o//nnUezqIsWzhVxO6qqOWfHxwO65B7yafZ/SwckEiPMWl45qMrsZKpuxcLBZmeIJIz1tzQ4NFXjxR1VoBGW1z4IrcNwF26eTosWw4u8bciBCRINc2I/N7b6mhMH8NyapifRb5aE+Wea4K/w9XcZS2zSpXqD/4hwTbgYGYchSS7l80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnLiclauLqO2Jq/uSuxCYCh5NevB/OEsIUFAdJajWP8=;
 b=OuDSFvpu7AYvgDQAeDQDHE/i6NXcYOfvt0M2/HAkoj8dX2tI2PVyV3NfswGozX5zG/TqF0hV0x3ALeB+O6fBY/9OeUivQdVkxKKTOwoR4SOGNywrGRjOyPROxG11BvZHE5OMX+kyUF2OhKMHh4AodViXSK7tfpL2JpPUrnYbS5E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2529.eurprd08.prod.outlook.com (2603:10a6:203:9e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 3 Sep
 2020 06:50:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 06:50:08 +0000
Subject: Re: [PATCH v4 0/5] block: add block-dirty-bitmap-populate job
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com,
 pkrempa@redhat.com, qemu-block@nongnu.org
References: <20200902181831.2570048-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b718ea63-76d6-1c9c-0b16-956ca1045735@virtuozzo.com>
Date: Thu, 3 Sep 2020 09:50:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200902181831.2570048-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.9 via Frontend Transport; Thu, 3 Sep 2020 06:50:07 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a773868-f486-42c2-7963-08d84fd59866
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2529:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB25290B20B2FFA0886A53FA33C12C0@AM5PR0802MB2529.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikXl1vNuzwIKFG9IxwOYFWEJal5K4+WfHsfjv6dObYlr++jkppWVxio2LtpHHsfwVpsphvbzMuEkiBrrosoR2H3bi3qLjtGdqxJm5tROnWO/UM0gzAvsyEnyAl03gjGDUqETjr4/ErZZNHDEtAY1NJkaltEakPRV8gqbB8epynudLYlGNGhVe2ezTb62w0sOzZEBxLma5nJD3a7GKcE8yFBwKt+ndW2N3ARqL6mLnf1UdcN6rAcXnDcp7/DkNZX08eL85fxXj7kO41+gg9XOT9MAlHQ/Pzq/FNsbYFKgAeu316Yrror+V4c/lz5PsCBYnu4skj1EuGnU1H7R4dbwFCNos9tpzkMeS6k7zFRVHpBVq0PlPMLuE+mBjzv7rWkyy4CE97B1V5a54x8F/yHIz4CU3KRR1+de4WKcEUYTbqGpKUQq4eko4KitdBlYtiB/gAylN7WCMeP5Ki4zB9xVi4E9CaTOgF36NWv4IINpXWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39840400004)(346002)(366004)(136003)(956004)(36756003)(2616005)(316002)(5660300002)(4326008)(8676002)(8936002)(186003)(26005)(66946007)(66476007)(66556008)(2906002)(52116002)(6486002)(966005)(478600001)(16576012)(83380400001)(31696002)(31686004)(86362001)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: gDEMyzr9KILxZIsZ6ocpqDNhmP+gxqSVjefCRtmPUJFl3KMNYewxjruCS3i9BD40aDLTgPqockJkoSGF11PeyUwmOlnO1w2uRUZCy6XQpfYQAQhi8htiR9iFZVeBTze5KMSSjMax++nYUEHthQP1h7ZUeDqySO8iP/GxczrzfUqbC4rn4IHuEl46ioL5YzQ+Lpkmgb0I7iTaWpYZpQ/K1gTXHebQHX5F/7ut+TyKjVSRqChl6gdnWGofc1JqDBOB5cfERTVJyXFF0FUkh3PdEu7dGavMMtx5xCH6qtclvY+5+FD/SdVTGb7I/5r41CXt2uN5B/Ot9FsKsIE6bxTVj9QDJ6mtPiV4qrzoe0Sm3m/YyqL70cpf1yqHEoYfGFBGhu1kzaaPifzzL79irFYdKVJwgERRTfKEfLS845JE+ru1a2DGUpVcF5HJjYSVULq73M3iqOav47nk0pg5PwXtmDsMosFSSCj6n/jbewJ0zpcUirTxB/xrhlZkxQy4rjSrYB2r4TrRrJ+omOQPh+YW4kvyox0EWjmdTZWWJnb5B3bcUlsKY9Zx/AVOeMKh5XX9m4brncTHX2yGuxTlzFn/gktAFaBxjzv9qZfL7Vcu5LmRhDx2i8gnrm9gZ3timjFXr7KJ3bkv6TGnLpMsHvJi+Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a773868-f486-42c2-7963-08d84fd59866
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 06:50:07.9203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkUKJ+lMV8fBKEep07LpgwZCIKJE8+LEF8q0E4TGfID2OfFBqkl/r3n2uGpxF7++3oXwLOWxFd5UPe8VE2fNtl4wNZIwEz2UyN3tak2GI8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2529
Received-SPF: pass client-ip=40.107.4.130;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 02:50:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.324, RCVD_ILLEGAL_IP=1.3,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

02.09.2020 21:18, Eric Blake wrote:
> This is NOT the final version of this patch series, but I'm posting it
> to revive conversation on the topic while fixing it to compile on top
> of meson changes.
> 
> v3 was: https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06258.html
> 
> 001/5:[0025] [FC] 'block: add bitmap-populate job'
> 002/5:[----] [--] 'blockdev: combine DriveBackupState and BlockdevBackupState'
> 003/5:[0004] [FC] 'qmp: expose block-dirty-bitmap-populate'
> 004/5:[----] [--] 'iotests: move bitmap helpers into their own file'
> 005/5:[----] [-C] 'iotests: add 298 for block-dirty-bitmap-populate'
> 
> I'm still trying to find the right QAPI contract (affects patch 1 and
> 3 for the qapi, and 5 for invoking the command in iotests), but right
> now, I'm leaning towards:
> 
> { "execute": "block-dirty-bitmap-populate", "arguments": {
>      "job-id": "job0", "node": "target_node", "name": "target_bitmap",
>      "sources": [ { "pattern": "allocation", "node": "from_node" } ] } }
> 
> which allows expansion into multiple sources, so that we can combine a
> populate action with a bitmap merge rather than having to do those as
> separate commands, like:
> 
> { "execute": "block-dirty-bitmap-populate", "arguments": {
>      "job-id": "job0", "node": "target_node", "name": "target_bitmap",
>      "sources": [ { "pattern": "allocation", "node": "from_node" },
>                   { "pattern": "bitmap", "node": "from_node",
> 		     "bitmap": "from_bitmap" } ] } }

(I see, this is not realized in v4)

What about multiple targets as well, as we discussed in v3?

> 
> John Snow (5):
>    block: add bitmap-populate job
>    blockdev: combine DriveBackupState and BlockdevBackupState
>    qmp: expose block-dirty-bitmap-populate
>    iotests: move bitmap helpers into their own file
>    iotests: add 298 for block-dirty-bitmap-populate
> 
>   qapi/block-core.json          |   66 +
>   qapi/job.json                 |    6 +-
>   qapi/transaction.json         |    2 +
>   include/block/block.h         |    1 +
>   include/block/block_int.h     |   21 +
>   block/bitmap-populate.c       |  207 ++
>   blockdev.c                    |  104 +-
>   blockjob.c                    |    3 +-
>   MAINTAINERS                   |    1 +
>   block/meson.build             |    1 +
>   tests/qemu-iotests/257        |  110 +-
>   tests/qemu-iotests/298        |  232 ++
>   tests/qemu-iotests/298.out    | 4544 +++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/bitmaps.py |  131 +
>   tests/qemu-iotests/group      |    1 +
>   15 files changed, 5301 insertions(+), 129 deletions(-)
>   create mode 100644 block/bitmap-populate.c
>   create mode 100755 tests/qemu-iotests/298
>   create mode 100644 tests/qemu-iotests/298.out
>   create mode 100644 tests/qemu-iotests/bitmaps.py
> 


-- 
Best regards,
Vladimir

