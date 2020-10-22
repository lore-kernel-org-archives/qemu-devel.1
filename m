Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D63EC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755B621775
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="l7PuFiTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755B621775
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVWQM-00015F-6q
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 04:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVWP2-0000Fl-4Z; Thu, 22 Oct 2020 04:56:56 -0400
Received: from mail-eopbgr50119.outbound.protection.outlook.com
 ([40.107.5.119]:22257 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVWOw-0000lx-7Q; Thu, 22 Oct 2020 04:56:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lcs5C9nzCHqf+O6YRPn9s9nxuWitdeMad4Q/8CFZCph1sWyxkqMCRghVZYA/3ctBuZxm7zPksuW6sTzrucw29GwARMdVZCZFZKt7LfEcsGIDjEmEAVIZW37RyMQWn2ICb2DsN9ixrvv7KQICRNbpOjjMTFYEtAagCF3YF9jSJT9monQUjJySrmv/wztUdxFzktQwi/p3t0OwhPewq0iIQn8CcOXDPxQigut14itmiivmg1tlh/mmlUh8xBrBjCkpqC272zEtmXjIPBdHchtkdeWEiENS0Z2mBzz5K0B7IUOZtsCKq4rdcd2zQYkUiRCYwWHmYL9mq0z2EXgRuW+5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5zy/mg8mTzRSPXAAfUkqNvO1AmDzKl4uQoGCG9Qo68=;
 b=kpWbYnRZnpvdlUGtuukcdlgqAY2AE1+J2NIcaf+68kUYH/dUpOZB2sDCiO1HzwcXhqAjcndlyF7zDd5WE2PQ0VzCzafch5UDntc7tOQGKHvcsYRNaInWF7LbCIRIm3j8SN6awB83aeUbug7qbMQ+KccU5OvDNGXSix3hTIX9/0aybI0wita+1+1dfYbqdDPAy4SXc2BVS/Rrri9EMmGVmivfkmBJwVYnIVyPKmrhxCck8RbOALYDy7OYN5AU08Td9LHXUOlhxVkNBcQsBP/ibEvjKXU7PWFo7eL8DKbxsLZWSd0RlU6XAnJcSWEXFzsw/tpKHw8rWSNiV5s+QikALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5zy/mg8mTzRSPXAAfUkqNvO1AmDzKl4uQoGCG9Qo68=;
 b=l7PuFiTjbzpZ2WxMCyrHPVITPyw1sHHf7xaBv8HlorrGMnaSwNxq/ZgEVDOv3A9JvX0R/mFt1pvwpp8K126AWj2327EovzqdaH2zAZ3W0um8o0FNTitORQlVq7CNuRC+YV/XtCyns1k43w1KHfUYpPTFtH+nCdKm6KdxBXdJZxw=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6053.eurprd08.prod.outlook.com (2603:10a6:20b:292::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Thu, 22 Oct
 2020 08:56:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 08:56:43 +0000
Subject: Re: [PATCH v11 09/13] copy-on-read: skip non-guest reads if no copy
 needed
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <59ff1f29-149a-0870-b600-1a54f0421c05@redhat.com>
 <c363d263-1854-d766-e9d3-c8ae8008740f@virtuozzo.com>
 <519fd52f-cb9e-0ab1-6d50-a9b3004d86fe@virtuozzo.com>
 <4ae47559-af39-1dcc-5e22-f7259b55dfee@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <84e40ccd-a3a6-4676-d514-3535d1017c0f@virtuozzo.com>
Date: Thu, 22 Oct 2020 11:56:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
In-Reply-To: <4ae47559-af39-1dcc-5e22-f7259b55dfee@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR04CA0086.eurprd04.prod.outlook.com
 (2603:10a6:208:be::27) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.82) by
 AM0PR04CA0086.eurprd04.prod.outlook.com (2603:10a6:208:be::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 08:56:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2795b8ad-134c-4c27-2244-08d8766865b3
X-MS-TrafficTypeDiagnostic: AS8PR08MB6053:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB60536946923149FE53465BF1C11D0@AS8PR08MB6053.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vACukvmTDM7K7P/xtYUnWVGp69HWu++EgUHxjgKoQ5NwZcRxftrizbG9oaRnOGWYZ1Csf5+IggoBQM4PLBSzIZNyGZtABqgQk1EIt1dhSGtWpxe8vCKprqtuxM0IELdScLO/hVdRQTmUfZmc5My7YLleXVOVePZNffxAlxXDsFkrjAHU650sklkUo7vHidJq85M5QY3uoCOOVpu+V8tY26jD0KWJIoE9F0GQcdazUcvdES6quCiVwRm06yxFLs6M3j9X7Wt0oLNCgonsVRvQYV5rNzcw+dz/psJHYgvv15wEwuzOXDKp3KdffWwZuy7MCY5bB6g5g1mQVoIZgcwoC2bSAjjX0xllEfFNzQm1IYt5MZm6zWzm6SIEODhKTjUx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39840400004)(376002)(396003)(66476007)(31696002)(66556008)(6486002)(4326008)(2906002)(478600001)(5660300002)(83380400001)(107886003)(7416002)(956004)(16576012)(2616005)(8676002)(8936002)(110136005)(31686004)(316002)(66946007)(36756003)(52116002)(53546011)(186003)(86362001)(26005)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 89nR9jDrEaTU9N2jh8FHoB6fgkw5oPj7oq7CbhhY4G5iyRHfolv/tqcdNFdjSayYAhRlq+Si3kxtwePzTr/PCCk41P+452Ajt86SCk9q4xIf5bsWRp5n6OR/5a8K3DhztM72SF51mY82xgdagzdlt/snzbcszqftI+iWVpqrjKC5tr2n9DkHqFcLfQqoNty4A4hb5HkxYoKyTT5y2enJRyAFfl+OnnAKn9cXn163VA4oY931bjCzp7da2AMPTNOn0b3aefSoxSdZ5x0knhSNYVX/TeqKRXy0WNe9IaqsfPY3AnI81wSkiPOSlMG+9Wv7Uzx5ZWX2FQ57X0KWSXddKurTxusMrT44ojgzPXsFSmlnyG4rB9rb9kGZLh6zd+NknW463VTsZp7bWRNghMVcvTN9au/r75lDlfnmonu41O14hA9wOkCMVmrNKIQdQ7085nfvPu3HX0Te9GqYJYPX2cRCw8coDoJd9LIOu1w+UrPfarsF9pFEyDhJNV7R10G5ZdixQ5trqkaHV6JzGdvV1TD3DKzPg5foGuOrmH0+ahDU0eDCkJGIo4nN81ISBcHF0fG94zVZ9CYwdOBKDtrJFsmIxz/E6IWZSMHlSafxWrEp6Fwsxd2Jx5/KGrvdwJmII4RuWz2hMF5sMbKv/R6tdQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2795b8ad-134c-4c27-2244-08d8766865b3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 08:56:42.8945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAZnnp19qakGXSPT/SAOx1kFgyTo0Lxtd9+QrEYGMvmv3ENCt9u/Ptg2Sc1ZRA0Au6IOUczHKe1FfYovIbrfJEh40kLtTvjtsd0sF6E533k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6053
Received-SPF: pass client-ip=40.107.5.119;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 04:56:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

22.10.2020 10:50, Andrey Shinkevich wrote:
> 
> On 21.10.2020 23:43, Andrey Shinkevich wrote:
>> On 14.10.2020 18:22, Vladimir Sementsov-Ogievskiy wrote:
>>> 14.10.2020 15:51, Max Reitz wrote:
>>>> On 12.10.20 19:43, Andrey Shinkevich wrote:
>>>>> If the flag BDRV_REQ_PREFETCH was set, pass it further to the
>>>>> COR-driver to skip unneeded reading. It can be taken into account for
>>>>> the COR-algorithms optimization. That check is being made during the
>>>>> block stream job by the moment.
>>>>>
>>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>>> ---
> 
> [...]
> 
>>>>> diff --git a/block/io.c b/block/io.c
>>>>> index 11df188..bff1808 100644
>>>>> --- a/block/io.c
>>>>> +++ b/block/io.c
>>>>> @@ -1512,7 +1512,8 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
>>>>>       max_bytes = ROUND_UP(MAX(0, total_bytes - offset), align);
>>>>>       if (bytes <= max_bytes && bytes <= max_transfer) {
>>>>> -        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset, 0);
>>>>> +        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset,
>>>>> +                                 flags & bs->supported_read_flags);
>>>
>>>
>>> When BDRV_REQ_PREFETCH is passed, qiov may be (and generally should be) NULL. This means, that we can't just drop the flag when call the driver that doesn't support it.
>>>
>>> Actually, if driver doesn't support the PREFETCH flag we should do nothing.
>>>
>>>
>>>>
>>>> Ah, OK.  I see.  I expected this to be a separate patch.  I still wonder
>>>> why it isn’t.
>>>>
>>>
>>>
>>> Could it be part of patch 07? I mean introduce new field supported_read_flags and handle it in generic code in one patch, prior to implementing support for it in COR driver.
>>>
>>>
>>
>> We have to add the supported flags for the COR driver in the same patch. Or before handling the supported_read_flags at the generic layer (handling zero does not make a sence). Otherwise, the test #216 (where the COR-filter is applied) will not pass.
>>
>> Andrey
> 
> I have found a workaround and am going to send all the related patches as a separate series.
> 

What is the problem?

If in a separate patch prior to modifying COR driver, we add new field supported_read_flags and add a support for it in generic layer, when no driver support it yet, nothing should be changed and all tests should pass..



-- 
Best regards,
Vladimir

