Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DCAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FAF9206E2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="H6heK5Ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAF9206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtSY0-0007eS-Em
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 05:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtSXI-000775-5c; Thu, 09 Jul 2020 05:08:08 -0400
Received: from mail-eopbgr80102.outbound.protection.outlook.com
 ([40.107.8.102]:62171 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtSXE-00064F-8Z; Thu, 09 Jul 2020 05:08:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUltvagGG40qLH74NGQwGmhtJst+ytVaPDn0FweFmxR3VCE67RbF4PJqFTLoQCbPhPDZaTzDB42LNr1i9mNrCen6VJG3Rv3VEcnqTrr3X62cSv/YKuHNHF3FBEK2ky8qMrvI0S09+0xvSaXMLb/3rgmrL1J7+jlG/ho1hghmmKyg26zjf8HxXgbKA8UF5bAbAhWn5pD76mfDvaY/iG0+9g0dEAv4PRWKGA295RbgPcLaP0ze8tvoKDlCSKs0DevjeT/ABQw1vAtB1iZJSsQgKJlXiFw8zp0dID98JKCRNpcANOscmJvykx7wodCB6sNoRhI9xKeKLJxwYtLIzmf95Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU/XVa2xNpW5HQKZ8hXqHJUhCdx/NnqeRdEJ3RM07HI=;
 b=LNj04rmEveykddX1pLeBUGF2ZdGFtyhvy4TwH29PdzhSSfk7BUc+D8vm9T53jYZl3yTzLRXt30ZAqagvhEwWesEZs9h7N18TMxrNCyzYWpp7FKKBN0o4JEQdTHx0NJHvLaYTY1PoLz29VMcKG4PuknN/XCQLRvInoGW8+YCBFUviDljJR4dSWEln/lU5w8cUoYnF+mL8T5SgIwZR5FsZo3BMHrylrMdREl41GSfCXKRIWNFwmTjwiKr0o/alMEnNbeU61Td9lClDDQCSZUdL3Jto0y5CV2XIXSDfz7/QjZgfYr+fW18Cu+K8hVMVqWyPLQsC8PkOCBU10hmhJhCfzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU/XVa2xNpW5HQKZ8hXqHJUhCdx/NnqeRdEJ3RM07HI=;
 b=H6heK5SsfE7gMPgRw6mrU2er260pU54F4cxQqmMTbh5GqmuzWbWrYfoV2cGDzo++3Y2LDkEQFdm2l1oueFDs0s96xipYhn3ace+CZMedTs9y/dZuLgJUj922+QK94shpzemJR1Ru620x9P9FuNVH+tlnwnks++7DOkLm/n+HHUo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3957.eurprd08.prod.outlook.com (2603:10a6:20b:a2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Thu, 9 Jul
 2020 09:08:00 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 09:08:00 +0000
Subject: Re: [PATCH v7 02/47] block: Add chain helper functions
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-3-mreitz@redhat.com>
 <5c2a81c7-851c-aeb4-84b7-3bd61417495e@virtuozzo.com>
 <7244733b-3092-a1f1-55f1-35a964a7c791@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <3f648f72-3161-9570-05ea-66cc45a3f2c0@virtuozzo.com>
Date: Thu, 9 Jul 2020 12:07:58 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <7244733b-3092-a1f1-55f1-35a964a7c791@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR01CA0116.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::21) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR01CA0116.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Thu, 9 Jul 2020 09:07:59 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 697b889b-426d-45eb-2153-08d823e7943d
X-MS-TrafficTypeDiagnostic: AM6PR08MB3957:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB395736E3DE0138BBB2F8FFB4F4640@AM6PR08MB3957.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04599F3534
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtgB8OMXPpEjqwH5rQO3Ff9/IbbzGB6IWL1yKnaS4JX13e80GirZrcTtix+iAJySNBQ5nRaueIdhsWKyW2/pGfRYwQZfq42cwimPz98UjgVk9c9PIKBufEaMNKAJJ1sNzLsg8wHt3EqEZMhG6JWowCNKz094MOyDJpmNYRmPwlkPj/LQ1DH4rKxG6RyU6AiMAvYZdeYpl0+JFPmUAHggR4863p02QGkpSaLtcnCgmDYbfCn+o1DIsVLcp0ShdhZsF4Zvf8pwvywkj8WUgiSzV0Nk0HSUnullCS0k4nwic3DtG6gVqxXJhh09y9HR8wegvJgXrIZGUtAkGkSlra7KJgse9kfi8GNXtuYYdR/GZ4WpsEzqxw/agNhhAOTct5MR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39850400004)(26005)(6506007)(8936002)(5660300002)(186003)(4326008)(31686004)(6512007)(86362001)(16526019)(2906002)(6486002)(2616005)(31696002)(956004)(8676002)(44832011)(52116002)(36756003)(66556008)(83380400001)(66476007)(53546011)(66946007)(54906003)(478600001)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rtqQ4Cu1JEs8bBk1dyIZif47yD/bm7MKWpD06j2xv8XloaxL4MtWSXyLXvt/fS31JAWgayzan2Z6rCK+TRM3ppcCn8u0E/4JhbFR+/4PUD4JrrAFVNOGBaRTwKeNw93QiFfDzjk8xag+i+kQRvXjpqX2Ex7nWkz1HCq9R8LRLzGzL5z5ETj+6b2frA6rPnE7bxLpJkV5e4YrTH8AGNQ0SiuZlmudBMHPP0T37/cItM+TkBa6De0VlaZxpYcPyIZVtIS/lNk41Hu0okbyZW4kfuPQS5wTzvGdIq7AFk/nx4xK3INRicR5+jL53HQQnmfeP+M0wvVT44ocKYO91RUzm0a54668S06jVsqJ0y1mM4hDUId7NInCLbjYfbdZLZYZNqQ/uWOTRbmNGxZwOkKJAel5g7aCEbnhHAkHotpt4cd6NNjeATMlgxilUUPCHt2jmFNMVs4AtUkan+N4WD2ICovgvGIx3AbWkPtG1bc6BNNuXwUANfartO1eUTM98MRn
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697b889b-426d-45eb-2153-08d823e7943d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 09:08:00.5346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkUY7OB9ccyB1SpVobk4lzXTJoCpI91SWhLLbdjnOtJe5W8xcQ3PVrD9m7cPFIhMK8EZAZVx6PU/cc0KPKSqzsXTBgUkb7yIft3sYL6eplY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3957
Received-SPF: pass client-ip=40.107.8.102;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 05:08:01
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

On 09.07.2020 11:24, Max Reitz wrote:
> On 08.07.20 19:20, Andrey Shinkevich wrote:
>> On 25.06.2020 18:21, Max Reitz wrote:
>>> Add some helper functions for skipping filters in a chain of block
>>> nodes.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>    include/block/block_int.h |  3 +++
>>>    block.c                   | 55 +++++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 58 insertions(+)
>>>
>>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>>> index bb3457c5e8..5da793bfc3 100644
>>> --- a/include/block/block_int.h
>>> +++ b/include/block/block_int.h
>>> @@ -1382,6 +1382,9 @@ BdrvChild *bdrv_cow_child(BlockDriverState *bs);
>>>    BdrvChild *bdrv_filter_child(BlockDriverState *bs);
>>>    BdrvChild *bdrv_filter_or_cow_child(BlockDriverState *bs);
>>>    BdrvChild *bdrv_primary_child(BlockDriverState *bs);
>>> +BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs);
>>> +BlockDriverState *bdrv_skip_filters(BlockDriverState *bs);
>>> +BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs);
>>>      static inline BlockDriverState *child_bs(BdrvChild *child)
>>>    {
>>> diff --git a/block.c b/block.c
>>> index 5a42ef49fd..0a0b855261 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -7008,3 +7008,58 @@ BdrvChild *bdrv_primary_child(BlockDriverState
>>> *bs)
>>>          return NULL;
>>>    }
>>> +
>>> +static BlockDriverState *bdrv_do_skip_filters(BlockDriverState *bs,
>>> +                                              bool
>>> stop_on_explicit_filter)
>>> +{
>>> +    BdrvChild *c;
>>> +
>>> +    if (!bs) {
>>> +        return NULL;
>>> +    }
>>> +
>>> +    while (!(stop_on_explicit_filter && !bs->implicit)) {
>>> +        c = bdrv_filter_child(bs);
>>> +        if (!c) {
>>> +            break;
>>> +        }
>>> +        bs = c->bs;
>> Could it be child_bs(bs) ?
> Well, in a sense, but not really.  We need to check whether there is a
> child before overwriting @bs (because @bs must stay a non-NULL pointer),
> so we wouldn’t have fewer lines of code if we replaced “BdrvChild *c” by
> “BlockDriverState *child_bs”, and then used bdrv_child() to set child_bs.
>
> (And because we have to check whether @c is NULL anyway, there is no
> real reason to use child_bs(c) instead of c->bs afterwards.)

Got it, thanks.

Andrey

>>> +    }
>> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Thanks a lot for reviewing!

Pleasure!

Andrey


