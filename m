Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCAECA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A4D20675
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Xa6iZNc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A4D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYotQ-0003TZ-FF
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 06:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYosi-0002xc-81; Wed, 13 May 2020 06:44:56 -0400
Received: from mail-vi1eur05on2132.outbound.protection.outlook.com
 ([40.107.21.132]:46732 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYosf-0007VR-Mx; Wed, 13 May 2020 06:44:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0gl3pUlr/B8xD4/1sjoqt90I93XLDUU/4gQ4X8oc73YGZG3OWHdWspn3OLwIbcLE6TSdez/hnHQXJqrW15m3/AF9oSGnbwzIDs5fegvsOkuh6WiN+bE39HCGQ4bbyx+y+rEHnGlY4oBop/5RWI7g+LUiiXE7Vh4zqDjIyRqHsQP06C+3csRsODUFtj27Qqd/PCBATREoZA0TZniEYovpEQTTXh4cD4TWwj8YrJYrs1LoZr71nw4fXxolmHu5ivNQwezg0TtwoLnQ+843iXYDiDixT9VnTe86vToJiLAv9QwcO9Sm+G9wxVO4q9MgV09++JdMZojQvrKdCuhEkRBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GAM+9lZPpb8MU6NUQqRYL1lsnafV4Dk3QWPPDxBplg=;
 b=LIov3NJswkAHb/VknIBbelmCSydbp4mZu8sP90Br2MjaNH7zZCFDn9WnZVnSp9VgSSpJOKeRP/Jrx/NVJOIkZ5X73oLx0JBXEYMnB+e23INrr94rahLNDLjC1rxTfkCxg0fsie1ItJ7O+j825mkna2L0ghNzqj7a+YbWsoiNO7czVNQFvRRRLq1P8GSOshP9CYMobYug5Z1GwCSVc4WUyICT74DLNjtmso5eWRHF5dt0pdtgoskB3p/TN+DYrgF6uJB5PgM2xuhcLDKmnT342MpYA5Qzu9NLfcNqXy3vnKC2HN3ZCeRyJ7I7MK+XZDlz3lQ90xJOodon1ND00k+mPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GAM+9lZPpb8MU6NUQqRYL1lsnafV4Dk3QWPPDxBplg=;
 b=Xa6iZNc5fEgY2U/gUTiw6y34+OFn4VpOfk/umzRwa9yk33y2J8LBwW5qUDeLNVbiZvQ1kmWepycBEAp6+TML9wGbeLfyFnyzN9A/thESfD6F+bwjrvbuCvPwh3Nx8Q2ne0FK5c+pqlR5I4TK9uP3fInHnKyvsQLGCgRwd3vzrE4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5509.eurprd08.prod.outlook.com (2603:10a6:20b:10c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 13 May
 2020 10:44:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 10:44:49 +0000
Subject: Re: [PATCH v2 3/4] mirror: Make sure that source and target size match
To: Kevin Wolf <kwolf@redhat.com>
References: <20200511135825.219437-1-kwolf@redhat.com>
 <20200511135825.219437-4-kwolf@redhat.com>
 <cbeba850-5c46-e946-596a-c8f33140b898@virtuozzo.com>
 <20200512184804.GL5951@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1aee2ae7-96a6-a2be-dcc1-d7da489d4c40@virtuozzo.com>
Date: Wed, 13 May 2020 13:44:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200512184804.GL5951@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0144.eurprd07.prod.outlook.com
 (2603:10a6:207:8::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.179) by
 AM3PR07CA0144.eurprd07.prod.outlook.com (2603:10a6:207:8::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.12 via Frontend Transport; Wed, 13 May 2020 10:44:49 +0000
X-Originating-IP: [185.215.60.179]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d58bee5-1ae9-40f4-8a7f-08d7f72aa936
X-MS-TrafficTypeDiagnostic: AM7PR08MB5509:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5509E1BF4620F756E6D94FDFC1BF0@AM7PR08MB5509.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qkgmSa88GF+uzCrTr+Lw45Z0KR7Kp9eWVnJkySLm84Op/bj3Z28SljLrQAdDTrznKeRf6MlQ/gZ3rO7Kin3i/JU5EGEcdIImK94LQ3NZHa4aRMoFTDQebDNEH+JV25Ebp0YzcGUGnX+fTUep+f0T7hc+eYGbo/zFcy+J2SRTVIX2T3q1cdO3bfByfBgMXsgwUY+u4/F+mf4JVRyb6dz29TgUw3LqNUS1TyXWnV0YE6K1dJNx5khlmXXHhoQgsV8P4aEZVfMJVV7b2n1jlrBjIDwhR7uSxt7mGOWvwOXOKR2pAgCKAD8tcnR8q+jeBrXWIXKoRoy/4fBU34qsnSZtNAStoCOkb9+wAJJOVBvy1Qwi60I8ECceQGcqcRtYxk1Ut7RCTiV89PGOBYad87EK5eVTwFQeqMYOY1verDEX9Tb4PbHOTB0+k3x+cBMx3NZDfalX03Xn1M5MaYIXGvOnkVcvrREBjgElMMRaQXypFp7Mvf5EZFkV8q+mbOG5PhOO0Wr/F8/IhhrgydBw3cdSdlLl8+UJCuMM69f4k/74QH4+8f2th6ryIfrIQhaE59E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39840400004)(396003)(376002)(366004)(136003)(33430700001)(66946007)(86362001)(6916009)(4326008)(33440700001)(6486002)(31696002)(2906002)(478600001)(26005)(186003)(956004)(16576012)(52116002)(66476007)(16526019)(66556008)(8936002)(2616005)(316002)(6666004)(31686004)(5660300002)(36756003)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lPE+8YMow+pwGjPpFG5XIfZ0KXMMoS61fu7iHb4l6o8B2NlnpPH9iUbq+I3w3Ji0LGvSjbZGlG5rbCB8ravQPStkNHP9g1iumUFRQQcvWy00i5aNNatGptztBKZl34kWkJ4gsEWQ1PYSJly2BcZ/nbuTg14C1Whi1j2gkgmzBbEQ54XFpCwI8rO2AVMBgp+dG+hAzQq8RG10UFyuTaN30XdSklCgRnCUsx7WWXY7kkqBm8SpcUoAychyi7VgxDwKSYV+xcGNuIC2IuLIu7tx52C3zvjgKt7DJZ1jQmKDdH1KOU+XEu4NDMG72bxKgrDxcQp0NYpBl8PKtvA8ab3Ycr8H+PhwMBmOdKdYUocLiNWl9gizS+ZA2TVxLAbMbL7+j3p5BPcblMRcx3rUST+jgeUnRRWexVWp1rGsiqLfst1ukquzfZ479Zl5ZE0ErIrww5ZIchLW9NFBbg7W0m9DkBGYx96BemYgYht8PbRCRaded2UUWtwuj/V7iF8BcglO
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d58bee5-1ae9-40f4-8a7f-08d7f72aa936
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 10:44:49.7428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEECija7r+o8yWcxx2/j8FhBtWWpLuDj+ur7mLmJCz0ypzVHO02wEPFRQ3E9osyMNjLxhXJFJ7jxW5Zyd11qDakNjueiRBR1qoyEegvE7Cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5509
Received-SPF: pass client-ip=40.107.21.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 06:44:50
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

12.05.2020 21:48, Kevin Wolf wrote:
> Am 12.05.2020 um 19:15 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 11.05.2020 16:58, Kevin Wolf wrote:
>>> If the target is shorter than the source, mirror would copy data until
>>> it reaches the end of the target and then fail with an I/O error when
>>> trying to write past the end.
>>>
>>> If the target is longer than the source, the mirror job would complete
>>> successfully, but the target wouldn't actually be an accurate copy of
>>> the source image (it would contain some additional garbage at the end).
>>>
>>> Fix this by checking that both images have the same size when the job
>>> starts.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> Message-Id: <20200507145228.323412-3-kwolf@redhat.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>    block/mirror.c | 21 ++++++++++++---------
>>>    1 file changed, 12 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index aca95c9bc9..201ffa26f9 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -872,6 +872,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
>>>        BlockDriverState *target_bs = blk_bs(s->target);
>>>        bool need_drain = true;
>>>        int64_t length;
>>> +    int64_t target_length;
>>>        BlockDriverInfo bdi;
>>>        char backing_filename[2]; /* we only need 2 characters because we are only
>>>                                     checking for a NULL string */
>>> @@ -887,24 +888,26 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
>>>            goto immediate_exit;
>>>        }
>>> +    target_length = blk_getlength(s->target);
>>> +    if (target_length < 0) {
>>> +        ret = target_length;
>>> +        goto immediate_exit;
>>> +    }
>>> +
>>>        /* Active commit must resize the base image if its size differs from the
>>>         * active layer. */
>>>        if (s->base == blk_bs(s->target)) {
>>> -        int64_t base_length;
>>> -
>>> -        base_length = blk_getlength(s->target);
>>> -        if (base_length < 0) {
>>> -            ret = base_length;
>>> -            goto immediate_exit;
>>> -        }
>>> -
>>> -        if (s->bdev_length > base_length) {
>>> +        if (s->bdev_length > target_length) {
>>>                ret = blk_truncate(s->target, s->bdev_length, false,
>>>                                   PREALLOC_MODE_OFF, 0, NULL);
>>>                if (ret < 0) {
>>>                    goto immediate_exit;
>>>                }
>>>            }
>>
>> Hmm, interesting, if base is larger, is our behavior correct? Blockdev
>> becomes larger after commit and old data becomes available? I think we
>> should zero the tail after old EOF or shrink the target..
> 
> Yes, I agree, we should shrink it. But active commit is a different case
> than what I'm fixing in this patch, so I left it unmodified. We'll
> probably need a third series for commit after backup and mirror.
> 
>>> +    } else if (s->bdev_length != target_length) {
>>> +        error_setg(errp, "Source and target image have different sizes");
>>> +        ret = -EINVAL;
>>
>> Seems, the only case, when mirror_run() sets errp. And, therefore, the
>> only correct one..
> 
> job_update_rc() takes care to fill job->err (with strerror()) if it
> hasn't been set yet, so the other places aren't strictly wrong, but
> probably provide suboptimal error messages.
> 

Hmm. but I failed to find, where job->err is reported except for job_query_single(), which doesn't call job_update_rc().

block_job_event_completed() doesn't use job->err, but instead create a message using strerror(-job->job.ret).

Interesting also, that job_finish_sync may return error, not setting errp.. Still except for tests, it should influence only run_block_job() from qemu-img, which itself doesn't care too much about setting errp on failure, so it's broken anyway.

OK, seems this all is not very related to the series:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

