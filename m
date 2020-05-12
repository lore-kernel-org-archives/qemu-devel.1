Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BA7CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1913C206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XBJdGGbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1913C206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZA3-0005CL-AQ
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 13:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYZ98-0004Lc-Cy; Tue, 12 May 2020 13:56:50 -0400
Received: from mail-db8eur05on2113.outbound.protection.outlook.com
 ([40.107.20.113]:1042 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYZ96-00026Y-4V; Tue, 12 May 2020 13:56:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luHxjiDhC4u3vSEnxIgsk9D9TFXHgtRBMji1Papbi7qui+cFwculWM3cjc7FXt/4P8UyPgCzb/bLBuOpf783oQYCGdvTZWrzEr6xU5JlcUrAcFK3FHpTdRM5TVZxa9pPku6oGOUtydbqO9AZIjPm5Hr58ZhiWcYHhHHjkRUiiMG4uwDZv/m5bEcnpnxFh8wdUz0d4FQXk/gvKhz81pgtCNpya/JpQT35jC3G340U1T+KtEe4ZQt9wZqcPIpHGqa0R+LmAyQABuYuIrE8tHzWlxNljPx+mFe8siaFjcYdnjyldLhkOzSgAqLGOAQwlbKR58C05ZFco4eHzp4YEJsj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=monM/eH3WsarkYI4a9Jm/1sG5vLBdUGQSfWrsO5k/2Y=;
 b=WRbqVZi97seJd+MzP2ALMl1S/luSnWZZyyHLqKg3+ErrSXqAr22Zhgg6N8hYKzfT4Y1sosxfbpIaPmD0G2AihV4GPnE6JJy/Z27kCcXFiVjV2p7xGUtOIAEeTwgMjfrpC+G8sos5V7jmIBNNcBdsr8vjsrTdb1hGesbv5efxrsv/jVuNqjTanx/jetqb5vtaks0BrmBePKeOM4dxzuWIF+7Sgj/5bvY8XhwYgfaYq8dnUUaBUOqBUzM6KELYay6rtHc98Cz4rEOMbYm+mhknAsJMTL0vBXOtm7uQsjVuSEPpc4HO9jGFJm2GTebCUeZxgeD0Hf5vEFDTBx2/1tLZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=monM/eH3WsarkYI4a9Jm/1sG5vLBdUGQSfWrsO5k/2Y=;
 b=XBJdGGbU5Vf/D0cx4Yu3PtnxbsEk8wHpkfOYxQJag9cwh/zU4zgZ+1BoES6QpB/TKUIPw46FwvNW0R+4yfVp5V9pJdZg5Jw/e4Z/qtwZK6j5gpWo2z4sjQsmDUvWOMtfiwAXPDyQaSpBZwZHpPPIs7eU/2A7Cmxw7OWSINfcMUU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5334.eurprd08.prod.outlook.com (2603:10a6:20b:10b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Tue, 12 May
 2020 17:56:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 17:56:44 +0000
Subject: Re: [PATCH v4 00/15] Apply COR-filter to the block-stream permanently
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1589302245-893269-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <25e15785-97d9-ae94-a7c4-88a4e699af75@virtuozzo.com>
Date: Tue, 12 May 2020 20:56:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <1589302245-893269-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0701CA0010.eurprd07.prod.outlook.com
 (2603:10a6:200:42::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.163) by
 AM4PR0701CA0010.eurprd07.prod.outlook.com (2603:10a6:200:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.12 via Frontend
 Transport; Tue, 12 May 2020 17:56:43 +0000
X-Originating-IP: [185.215.60.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5150a3e2-ef78-4a2c-c684-08d7f69dd4e9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53345492B5B8BACFBA258DABC1BE0@AM7PR08MB5334.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ezKYL/8JJ3bCWzXLRQXPDUJ/2fUf9V1hLQLcx5pHnOKgA/gHF6AEkifVGay6hRB6TA0Mu+J6IeiE4khAOvBmnsomeoZXEzhuw90zi58DR7orTZXmGVEBEmVE2iA0G34uV9jx+09mL+1E59qV5PoCj06ysvhPId0rlXn5ll6HBoyG4DKaJCK9+WaKvZkXDK4OqsSVOshxZiYoOgqASbP8a6xh7AGj+RgX3AFbL2pYLbvoL0BXp2yTvKVTu4ULCVqkYx0WeKxkq2yg33KSWjN9EMc1ZGygSgF8AGYKlO4TyDhOSZ65O/nfkRMDfpnYBr+7gGKIJZ7AcsWf0XSy8NRGFlTna+x1LZIRxqxi9IVg71xzmizF2abjQcThhZSHZ4OAtPXnmEdb4xHEUyPVJLr/QoEehLB9BzrSuxuGkeNVHas2GL9qjoMofe5sQz5LKDmB4YkGLAZi0xfhNUJuaezKTei9dYgiEhHdJ4jlDrfuxOTFyPHK+iI919eti0vtjyuF6HfK76Dr8xuTIhBztiZxQ3KnjHoIqC1Pw2a/q6TSJ8xjBQTOpSvX2ILtnMlyCdBsfT2jT33ZJWUz5nXp9e8gq985smiKkmMxoWd5MtgK23Izkpzj1Dhxc3PvtfBl5s4k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(376002)(396003)(136003)(346002)(33430700001)(6486002)(31686004)(86362001)(8676002)(8936002)(4326008)(31696002)(966005)(26005)(186003)(66946007)(2906002)(66476007)(66556008)(33440700001)(16526019)(478600001)(36756003)(107886003)(5660300002)(2616005)(16576012)(316002)(52116002)(956004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rMF8y2rmpJ9y7qQxhN85dnBTIJh0UsTzy2IFwS8Ewn/18ornI3uNoMUr9rVX5kq6rxXUryXrAKIBEmhIU6XOragmDOfIWicg2yR2fo6W5s+vOaGqJhAyz/tNHY3CAILfoeJfbo/ErLeoFalkQpt+t6nT8mHalPoZuL8+gjo7TejmDBzSQNiWX4GbV8/wWM0NwkUKlIEJmcaHqSzzMi/Ry4DiroO4yo29HA6nO6/71rSxssUpOOy39fOmbdqbOeVFz+N2laE0kBEp82Maj71p74lHDWfWN4a6Dv71E+W+ZEDdMVNz7HA1Kbayl9fTJ0s72Kj4Mkz2yYMfYsEQJCt74n0YfdtoIdKPIVt6KHRa9YCKWNHnWz70JTIWE0KZAOZl6QtjuPEUjBUKVRnOMjBYS8Wi3YBaDyoSWwTXTXh2cX+nkL92FyNx3I/6UTJk9Et5cf+K/FIUQIi5VrCXjsE3CS6KGJxHF3mCkTUR3SXIZmD5fkL0POzZ7jDAnc6ky8FO
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5150a3e2-ef78-4a2c-c684-08d7f69dd4e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 17:56:44.0126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jp8ObIFWJY8jAp/uUY+eUqLKz8kSYlcBnM77glYI5aTzK2Ek7Mk50XLzkTD5G96blEEKnK6E4PHx5oGpvmyoRoFEp5AlOxybWPq4Uzzx0s4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5334
Received-SPF: pass client-ip=40.107.20.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 13:56:45
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
Cc: kwolf@redhat.com, fam@euphon.net, armbru@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

12.05.2020 19:50, Andrey Shinkevich wrote:
> With this series, all the block-stream COR operations pass through
> the COR-filter. The patches 01-08/15 are taken from the series
> "block: Deal with filters" by Max Reitz, the full version of that
> can be found in the branches:
> 
>        https://git.xanclic.moe/XanClic/qemu child-access-functions-v6
>        https://github.com/XanClic/qemu child-access-functions-v6
> 
>        When running iotests, apply "char-socket: Fix race condition"
>        to avoid sporadic segmentation faults.
> v4:
>    01: Initialization of the COR-filter BDRVStateCOR member.

Hmm... but 01 doesn't touch COR-filter

> 
> v3:
>    01: The COR filter insert/remove functions moved to block/copy-on-read.c
>        to be a part of API.
>    02: block/stream.c code refactoring.
>    03: The separate call to block_job_add_bdrv() is used to block operations
>        on the active node after the filter inserted and the job created.
>    04: The iotests case 030::test_overlapping_4 was modified to unbound
>        the block-stream job from the base node.
>    05: The COR driver functions preadv/pwritev replaced with their analogous
>        preadv/pwritev_part.

I assume, these changes are about your patches, which are 09-15, and Max's patches
are unchanged, right?

> 
> v2:
>    01: No more skipping filters while checking for operation blockers.
>        However, we exclude filters between the bottom node and base
>        because we do not set the operation blockers for filters anymore.
>    02: As stated above, we do not set the operation blockers for filters
>        anymore. So, skip filters when we block operations for the target
>        node.
>    03: The comment added for the patch 4/7.
>    04: The QAPI target version changed to 5.1.
>    05: The 'filter-node-name' now excluded from using in the test #030.
>        If we need it no more in a final version of the series, the patch
>        5/7 may be removed.
>    06: The COR-filter included into the frozen chain of a block-stream job.
>        The 'above_base' node pointer is left because it is essential for
>        finding the base node in case of filters above.
> 
> 
> Andrey Shinkevich (7):
>    block: prepare block-stream for using COR-filter
>    copy-on-read: Support change filename functions
>    copy-on-read: Support preadv/pwritev_part functions
>    copy-on-read: add filter append/drop functions
>    qapi: add filter-node-name to block-stream
>    iotests: prepare 245 for using filter in block-stream
>    block: apply COR-filter to block-stream jobs
> 
> Max Reitz (8):
>    block: Mark commit and mirror as filter drivers

this is for commit

>    copy-on-read: Support compressed writes

for stream

>    block: Add child access functions

I do think, that for these series we need only filtered child and nothing more

>    block: Add chain helper functions
>    block: Include filters when freezing backing chain
>    block: Use CAFs in block status functions
>    commit: Deal with filters when blocking intermediate nodes
>    block: Use CAFs when working with backing chains

So, fix stream, commit and some thing used in it.


Hi Max! Could you take a brief look and say, could we proceed in this way, taking part of your old series? How much it conflicts with your plans?

Let me clarify. This all is needed, as we have old proposed feature (and patches): discarding blocks from intermediate images during block-stream. It helps to save disk space during stream process. And the correct way to get access to intermediate nodes (to be able to discard from them) is to append a filter. Firstly we proposed our own filter, but that was proposed on list to use existing COR filter for stream and it seemed a correct way. So we are trying to insert this COR filter.

And the problem with it that without your series it breaks iotest 30, which does different magic with parallel stream and commit on the same backing chain.

So, it was my proposal to extract something from your series, to make this test work. And the result is here. I thought that the necessary part of your series for stream/commit is smaller.. But still, 8 patches is not too much. The feature for stream is being postponed already for more than a year due to this trouble. We need to proceed somehow. And the feature is useful.


-- 
Best regards,
Vladimir

