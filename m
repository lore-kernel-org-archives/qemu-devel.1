Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03B8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B83207D0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="l3nJl0Ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B83207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYTa-0002xH-1K
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtYSg-0001sN-G4; Thu, 09 Jul 2020 11:27:46 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com
 ([40.107.8.90]:6976 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtYSd-0002JB-Hr; Thu, 09 Jul 2020 11:27:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXCkGjGto0zef+SSjDemr1ERFyvqDw46udZNDYPb8B7DSsUrnbty/fmALEcxPexTOCYcx2buh/1wwLiQn1Zu1h4ly+25swYAJ+yN7t0+qUSoxvvMHIhgN9qDdT+e/664HynQdZvIP8UEyMybIz4HUyDTSA5mUUb2DR9mCfI+2hThxLBYWfbBZIZfU/uWJEWVCYLMfxbcG8bjWbZj11XjZGOh+xWpZrMIJoNuAY7HqbV/OUv7OKK8sHsL7d5NJJG4oOG1OdKWPNsrFNNn4aTTJkpiAN0KPFhtICVh/c/dFiTpgkQorcAC9oxa7G7VeP7R8oailhnEk1Hx8T9Hv5P8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdT+P9niMP1ycnT/vTvg1vEdSFGI+Yb9eT9fMcPQW0s=;
 b=m+6SAHbAK+bmeaYQfm3Jla34Hmf4NSPkyuvGbwQ84jg/VFpbVw17sFAmQ0p3QDI+pEtfG2ONZGq7bFUEOrCjAYeRKCE78+yCF/jiFxbuLaAUCfuKCjliu+QF1G36J7H+FIqhixikVBqt/ATjJ9/h4Ag2NdyA3s+IfgfdKjWhYKpUeNXKMr2kwNselJhM0Zzl2KHMPe8gxQWRQORq1ogDs+BnQDVQV1wN8nodxwiZQIXt6suRAHVvVUN+UDblv0O6TmFCmwc5bOqPWuy5VX3g6NdaXboTZLCbFcb+5d6ZJ1KcSC21B0H99lWGg7xkH8dakBr1Y3Os0KNEz+l+Sdlk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdT+P9niMP1ycnT/vTvg1vEdSFGI+Yb9eT9fMcPQW0s=;
 b=l3nJl0AhERyxrIU1FLGIoF6GdWD5FwmBJyCqHZK+DnvwGBKBFMDGMtvtbHWKjpJEXw2NLXmXmVVY5YSjLX43iMj7eNWTTco5WwiPsMUElTKKKgSLcJDo96SLTm/PvS5xCQ/mzzDJUOR5Z5Hio3RGViSsaEYqS1UGdD2M53ykvfM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4721.eurprd08.prod.outlook.com (2603:10a6:20b:c7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 9 Jul
 2020 15:27:40 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 15:27:40 +0000
Subject: Re: [PATCH v7 14/47] stream: Deal with filters
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-15-mreitz@redhat.com>
 <ed502f80-f4a2-bfb8-7395-5842f8103991@virtuozzo.com>
Message-ID: <e60d230b-d064-2533-5e25-d6e58bd5deea@virtuozzo.com>
Date: Thu, 9 Jul 2020 18:27:35 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <ed502f80-f4a2-bfb8-7395-5842f8103991@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:208:1::24) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR04CA0047.eurprd04.prod.outlook.com (2603:10a6:208:1::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20 via Frontend Transport; Thu, 9 Jul 2020 15:27:38 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfd158c9-f3d9-4af5-e95a-08d8241c9dd2
X-MS-TrafficTypeDiagnostic: AM6PR08MB4721:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4721BF5BDD976ABDDF35351DF4640@AM6PR08MB4721.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0ZBR6kBGzAqrp8p2bVXOtsRknz9I0FZpETd7ycTjQDXDWC/tddLpkot+HxYd5Y0pzCKvo1Vz0z4a2PaoW1qENbqofrGv4RNj8qBXfVA6PQEFQAvI24/fTfXH7+3IruJ1pjPSEhGvGX3hdQaDVXEI09LN6ZscrIwKegFJPioWWWvKUDfgReVnnyhiQ54hSicrcfDX6oZqy17eZWpWoGziqbrxjUmZu/Wvr7KIbGrIb6bKjtvoGcQBnTvIQ7A5jPW2tTzUdKBV1UUbqOdDOSpIUBH5bee1ftyNWzNI+cfcL8b9QCp1eG1c9vKKbNG/nKFD59BO1ksnkeTjJhgDUy2n0oARIn73AovnxI7do+DmfcptW8PBJDgOBBQdwPG8u8R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(39840400004)(376002)(396003)(366004)(54906003)(66556008)(66476007)(66946007)(52116002)(31696002)(83380400001)(4326008)(2906002)(86362001)(8936002)(31686004)(8676002)(478600001)(6512007)(316002)(16526019)(956004)(6666004)(6486002)(5660300002)(36756003)(2616005)(26005)(53546011)(186003)(6506007)(44832011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pYUQ1hK+Um3sjwPuRWWLs2D0+9cBQCSa2LRirgt8hm9xV4J7ZY9apny33B9GDOptp8dMn2h59qQX0qiHnN6qHfeJRZxPZJqQ0+34EDPMmkmTmtTAUN2AVujVU/eN0e/LExPW9jOHxg5RcyPL+NXUOUk+09co0lOiWdj7ezKC21edE9LOljqPZ2RJhSDHTM/KEzIxLNo1IUu0I0zBOjnwTFw+X0LvgEZJ6Gp+x7TMWOX7yQg+oNJvxBOM6R8JIfXDVPFPgYuCTqmVDkI1FGVS/b+XsEtRsfpg6KA7KdOy653Egg2/J52Wx+iEBLCUgjItXkpgwrVDCzmTjSZbzKzfR4krqEB3a5MHt9cffo9mw1GgM3k/HHMcPRH+zXpcad4veb9O/C9EgifOWWRDxJU3O4IWrbCkud57yP5T73NUjDzMKDXevWgo27bHnpo0R8edbVUdFW+642GEsuWMLEHzEZkcaF6/oZ+44q4aNSY+tZ8hAAyzcozP0Fgrf1PmO2EQ
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd158c9-f3d9-4af5-e95a-08d8241c9dd2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 15:27:39.9444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGp1fuTOQ5U1RtwXOwi930RTTKcVhyNZ8sksa/klCaniqvZZKvxgWDZPTXt5ado2dsPtl4fm+gSPu7/cdkOZw7RKl0sScZuZKbdeUs58DmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4721
Received-SPF: pass client-ip=40.107.8.90;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:27:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.07.2020 17:52, Andrey Shinkevich wrote:
> On 25.06.2020 18:21, Max Reitz wrote:
>> Because of the (not so recent anymore) changes that make the stream job
>> independent of the base node and instead track the node above it, we
>> have to split that "bottom" node into two cases: The bottom COW node,
>> and the node directly above the base node (which may be an R/W filter
>> or the bottom COW node).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   qapi/block-core.json |  4 +++
>>   block/stream.c       | 63 ++++++++++++++++++++++++++++++++------------
>>   blockdev.c           |  4 ++-
>>   3 files changed, 53 insertions(+), 18 deletions(-)
>>
...
>> +    BlockDriverState *base_overlay = bdrv_find_overlay(bs, base);
>> +    BlockDriverState *above_base;
>>   -    if (bdrv_freeze_backing_chain(bs, bottom, errp) < 0) {
>> +    if (!base_overlay) {
>> +        error_setg(errp, "'%s' is not in the backing chain of '%s'",
>> +                   base->node_name, bs->node_name);
>
> Sorry, I am not clear with the error message.
>
> In this case, there is no an intermediate COW node but the base, if 
> not NULL, is
>
> in the backing chain of bs, isn't it?
>
I am discarding this question. No need to answer.

Andrey


>> +        return;
>> +    }
>> +


