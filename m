Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4BFC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7022206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LVmUGubv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7022206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFL2-0002Hv-0O
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWFJZ-0000jP-Pt; Wed, 06 May 2020 04:22:01 -0400
Received: from mail-eopbgr00098.outbound.protection.outlook.com
 ([40.107.0.98]:63653 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWFJX-0004Vq-53; Wed, 06 May 2020 04:22:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPNV2XnClnr7/7TcXLdTKHjSjNYZSaromUOYb30QTqcQdflviOGpdJ8AFfETes4mJcSnZ5wzjwqA8KFsV9M2uUxMes50FkSm9MLO9yBKdLphlEjJ2auOyi1j5xLteSSYkOWwiRTABNf7WK/fZExS1d4t1KA+Z0AgrvQJ16FLBUejX2PQVW2PJlb/jYE8SOgCVk19Tfj9QpbKw/DnO3cdyvV8OinYqFa2ZSUDWREgBGQRJtwqXSylAREVMRTtXe9fdG495flHLv7enqf19jeFr3o3n1WIgBxTe3vGx+JoTIIsEEOthq1kuigEo6BMDMjAg33m6+kYLeu6L0tihfYqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5J4RZ7tR3bOQHGbxtK1aI3gDCG0quqBxR8b0JvaSh9A=;
 b=kFb3KQ68BA54XwlQdBx6zSunZFtTEGSQp/yYcS/uGlSSLxic3M5nAqFKPC9jYxgRMYXeTEP2tiwIgqz28nWDohpayZlVQ7XaJyqbpByX5rMLpfXkVHwcYkcgwR2p/9e5to+9g0L7/oF8RkOZCN8u9nm6/9Fj0DkSIaXkxdPg9nZm9JTK84X06odo3AlWQC3S1iXf/szEsxFk1y4qXGe2/sJY2qR/CBnUR/NUcxAuL4E9lwa8+GbRNBaiGmbDMtfOimSp92Z1WeA6E1B+I8yiPwdEmrowM1RsRtgXGS7H9yluv4My2qUobTrXBFp611aPjtrbWsPGA7bQ2rnd9sLzkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5J4RZ7tR3bOQHGbxtK1aI3gDCG0quqBxR8b0JvaSh9A=;
 b=LVmUGubv6nu2+4uBmbe+JX8OIDBVwUfQ3Tyli/uDU7/jMKtFIdu1hviv8I6I70OTYKEl1QMU97+4LE7FZb/9mFHdsf+1l/mYaoR32PmQfOeVlnpBh7HVhIfMPtEQMDX2mwZhHu7E7yVo2YSbVMkXn9z2y+ClpGtCSvFw9SB78Xo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5462.eurprd08.prod.outlook.com (2603:10a6:20b:10b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Wed, 6 May
 2020 08:21:55 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 08:21:55 +0000
Subject: Re: [PATCH v2 3/4] backup: Make sure that source and target size match
To: Kevin Wolf <kwolf@redhat.com>
References: <20200430142755.315494-1-kwolf@redhat.com>
 <20200430142755.315494-4-kwolf@redhat.com>
 <d5de1915-523b-fbdb-2ebe-8c31cf0e0cdf@virtuozzo.com>
 <20200505100334.GH5759@linux.fritz.box>
 <f91f3d3d-5c20-dfde-c9e0-506f8618c585@virtuozzo.com>
 <20200506080216.GA6333@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200506112153782
Message-ID: <abdb1914-d307-159c-e28f-237744d2f9be@virtuozzo.com>
Date: Wed, 6 May 2020 11:21:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200506080216.GA6333@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Wed, 6 May 2020 08:21:54 +0000
X-Tagtoolbar-Keys: D20200506112153782
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60b67f37-7ad6-4ee7-9ccb-08d7f1968992
X-MS-TrafficTypeDiagnostic: AM7PR08MB5462:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5462BDC1FD27FDFE0477123CC1A40@AM7PR08MB5462.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R67mxtyoKRkoMhXq5zQeN4s1lBipk2ae7PWPem91aauSeFjKufvth5RtPEFpantnGkd5G6N6daV2Zfn9sXCVV1keSSxbwjfEkrrjksF0H4Cl68HGN9OCf7BhRsbmcHYrpwEbUPYVkM0KCfUnbmwswlA5pYhFptEEqgKAQatVRSY/yjHZbmClTdy0BKt17LyCwVL1fw5xCDq3fOq4vPfnaB91Kryhm7MueuIzPX+WHLzIr8/1xj17pjL7idls6yiPfX8WkGyibadAYYd+JhWB5ZgmI9keEImnMQRwpGHZzRFvYIboCTXs0JWNTECooeWzhkC0r20TJrc4w7ARcR3Cf6zPi/VgeFCMEboL/c5jSH4NR8bDFa3y/A4Eauf464trfpxvPJRBY8SlY3CdlKa0FgjVGJsIh0BDdqV96BoOrotoBEQZmfwCL38PDERqyLFk4pu4yxAuhRhT6jwtbUibxrFmnzIuEREBuUMepFonHJgkINFAEGUlErgLLQnS/4fTFxSAbLy6NEIk7SSSgHlYtRyIhw+R7tv6md/qEXcegctZHRs9FXr66Ze3KLgbJsigdeB6Ee8HcmyW9QpxcMeOKA5yFCDUBYz4/fVkiP8nfPyym2/2ZHCdiao42z6dA2WB8zbJ4eXYjwWegZRYzIkJ7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(136003)(366004)(346002)(376002)(33430700001)(31696002)(8936002)(16526019)(186003)(66556008)(4326008)(8676002)(66946007)(26005)(2906002)(6486002)(66476007)(86362001)(33440700001)(5660300002)(16576012)(316002)(36756003)(966005)(52116002)(2616005)(6916009)(31686004)(956004)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cfD4Rdm+4AKmTf74gdy1ESNlGrkae8++WLTFBvb8x+ZF+MgdrZSvIcEnOVtX65KaAIrRDGfJdelUnjUvCPnnPefI0BKH5XoS2HetsBsziGC3azV/zALpsYtT3KzpOXvvZQ/p9HxaZ1m7XN9FTuzzvw2KcRVuWCBNukT66nyGlWkcVc89eoQw1tDxZGBVMfvb27f3PnF+NNKZa2kyoKPJxUxjGWUkNrmU3GaMYbZPgLniTRd9Ssvt8WL1MSucMeee5OMQxBa1CCAUEEAabPeJewJmBOxExS7hF3G1zA3jc+GEI9X3VSkNFgXyNtEvh90Hek6km4c+SAXCqbZThdv8O8/hgdDixrit6nND+E63tWdJUo5+aXcFUOJb/erZhxDHLuywL1TMNCSEImSeAZC+iGCyBCXaJ6gk0fhtkA5Jst90OTpoSOr7dI7twMD1ay86SyG6lXR/lGn7HnQmPsfytlxzcGNuLWrMLipTTxgtQw8po0JMU/YRbV0FpHPXGHFZPWyfcy0hV2yLBOB2Jf+h7hbRgLZcwfbh3ripqs2Lf3ntitoXw3sLoPC8PDg5UkdBt/uWVzDQesYhJQ2hnEJK0uAdlZhHh0oojOlCxa9+qNhYKooFGpS07ptRthf2xiL0EsC9oGOWFwVJ4sWqsHu+k/YDPv3qAYAE/XL6Pd7lcv6QlGkCrmcXv0ytPihDCuzpvJDc5z1Q1l2ZqDxSHQgO4zlfdcAM9nHptORdWrHxYxNGcXepwoEgQT+zi1MCLmPKljKwfYdW+hnk3KOVzIElTsqYRRikvYw5lM0HqAtUeOE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b67f37-7ad6-4ee7-9ccb-08d7f1968992
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 08:21:55.2595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOAizxDxKbfU0Sgsw0rxeYL8c3Dnm3XEdha3T7MMUr99qc4JaSbCI4eobnokHUmMPr5yYxLh2f00VIz4zT5modsRof7JWROTUlZI1JGKaV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5462
Received-SPF: pass client-ip=40.107.0.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:21:56
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.05.2020 11:02, Kevin Wolf wrote:
> Am 06.05.2020 um 08:07 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 05.05.2020 13:03, Kevin Wolf wrote:
>>> Am 30.04.2020 um 20:21 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> 30.04.2020 17:27, Kevin Wolf wrote:
>>>>> Since the introduction of a backup filter node in commit 00e30f05d, the
>>>>> backup block job crashes when the target image is smaller than the
>>>>> source image because it will try to write after the end of the target
>>>>> node without having BLK_PERM_RESIZE. (Previously, the BlockBackend layer
>>>>> would have caught this and errored out gracefully.)
>>>>>
>>>>> We can fix this and even do better than the old behaviour: Check that
>>>>> source and target have the same image size at the start of the block job
>>>>> and unshare BLK_PERM_RESIZE. (This permission was already unshared
>>>>> before the same commit 00e30f05d, but the BlockBackend that was used to
>>>>> make the restriction was removed without a replacement.) This will
>>>>> immediately error out when starting the job instead of only when writing
>>>>> to a block that doesn't exist in the target.
>>>>>
>>>>> Longer target than source would technically work because we would never
>>>>> write to blocks that don't exist, but semantically these are invalid,
>>>>> too, because a backup is supposed to create a copy, not just an image
>>>>> that starts with a copy.
>>>>>
>>>>> Fixes: 00e30f05de1d19586345ec373970ef4c192c6270
>>>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1778593
>>>>> Cc: qemu-stable@nongnu.org
>>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>>
>>>> I'm OK with it as is, as it fixes bug:
>>>>
>>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>
>>>> still, some notes below
>>>>
>>>>
>>>>> ---
>>>>>     block/backup-top.c | 14 +++++++++-----
>>>>>     block/backup.c     | 14 +++++++++++++-
>>>>>     2 files changed, 22 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/block/backup-top.c b/block/backup-top.c
>>>>> index 3b50c06e2c..79b268e6dc 100644
>>>>> --- a/block/backup-top.c
>>>>> +++ b/block/backup-top.c
>>>>> @@ -148,8 +148,10 @@ static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
>>>>>              *
>>>>>              * Share write to target (child_file), to not interfere
>>>>>              * with guest writes to its disk which may be in target backing chain.
>>>>> +         * Can't resize during a backup block job because we check the size
>>>>> +         * only upfront.
>>>>>              */
>>>>> -        *nshared = BLK_PERM_ALL;
>>>>> +        *nshared = BLK_PERM_ALL & ~BLK_PERM_RESIZE;
>>>>>             *nperm = BLK_PERM_WRITE;
>>>>>         } else {
>>>>>             /* Source child */
>>>>> @@ -159,7 +161,7 @@ static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
>>>>>             if (perm & BLK_PERM_WRITE) {
>>>>>                 *nperm = *nperm | BLK_PERM_CONSISTENT_READ;
>>>>>             }
>>>>> -        *nshared &= ~BLK_PERM_WRITE;
>>>>> +        *nshared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
>>>>>         }
>>>>>     }
>>>>> @@ -192,11 +194,13 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
>>>>>     {
>>>>>         Error *local_err = NULL;
>>>>>         BDRVBackupTopState *state;
>>>>> -    BlockDriverState *top = bdrv_new_open_driver(&bdrv_backup_top_filter,
>>>>> -                                                 filter_node_name,
>>>>> -                                                 BDRV_O_RDWR, errp);
>>>>> +    BlockDriverState *top;
>>>>>         bool appended = false;
>>>>> +    assert(source->total_sectors == target->total_sectors);
>>>>
>>>> May be better to error-out, just to keep backup-top independent. Still, now it's not
>>>> really needed, as we have only one caller. And this function have to be refactored
>>>> anyway, when publishing this filter (open() and close() should appear, so this code
>>>> will be rewritten anyway.)
>>>
>>> Yes, the whole function only works because it's used in this restricted
>>> context today. For example, we only know that total_sectors is up to
>>> date because the caller has called bdrv_getlength() just a moment ago.
>>>
>>> I think fixing this would be beyond the scope of this patch, but
>>> certainly a good idea anyway.
>>>
>>>> And the other thought: the permissions we declared above, will be activated only after
>>>> successful bdrv_child_refresh_perms(). I think some kind of race is possible, so that
>>>> size is changed actual permission activation. So, may be good to double check sizes after
>>>> bdrv_child_refresh_perms().. But it's a kind of paranoia.
>>>
>>> We're not in coroutine context, so we can't yield. I don't see who could
>>> change the size in parallel (apart from an external process, but an
>>> external process can mess up anything).
>>>
>>> When we make backup-top an independent driver, instead of double
>>> checking (what would you do on error?), maybe we could move the size
>>> initialisation (then with bdrv_getlength()) to after
>>> bdrv_child_refresh_perms().
>>>
>>>> Also, third thought: the restricted permissions doesn't save us from resizing
>>>> of the source through exactly this node, does it? Hmm, but your test works somehow. But
>>>> (I assume) it worked in a previous patch version without unsharing on source..
>>>>
>>>> Ha, but bdrv_co_truncate just can't work on backup-top, because it doesn't have file child.
>>>> But, if we fix bdrv_co_truncate to skip filters, we'll need to define .bdrv_co_truncate in
>>>> backup_top, which will return something like -EBUSY.. Or just -ENOTSUP, doesn't matter.
>>>
>>> Maybe this is a sign that bdrv_co_truncate shouldn't automatically skip
>>> filters because filters might depend on a fixed size?
>>>
>>> Or we could make the automatic skipping depend on having BLK_PERM_RESIZE
>>> for the child. If the filter doesn't have the permission, we must not
>>> call truncate for its child (it would crash). Then backup-top and
>>> similar filters must just be careful not to take RESIZE permissions.
>>>
>>
>> Hmm this should work.. Still it's a workaround, seems out of the
>> concept of permission system..
> 
> I'm not sure about this. I see the problem more with unconditionally
> skipping the filter without checking whether the operation is even
> allowed on the filtered child.

Agree. Blindly skipping the filter is wrong anyway.

> 
>> I think, that the problem is that .bdrv_top_child_perm can't return an
>> error.  The handler answers the question:
>>
>> - Hi, we are your owners and we want the following cumulative
>> permissions on you. Then, which permissions do you want on your child?
>>
>> And the handler can't answer: "Hi, you guys want too much, I refuse to
>> play by your rules"..
> 
> It can implement .bdrv_check_perm to do that. It's just a bit more work
> for each driver to do that.
> 

OK, so, it actually can.


-- 
Best regards,
Vladimir

