Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47535C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8827F221E5
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="n1CpqMm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8827F221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGmkN-0001qi-Fb
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 13:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kGmio-0000Uf-K8; Fri, 11 Sep 2020 13:20:27 -0400
Received: from mail-eopbgr20132.outbound.protection.outlook.com
 ([40.107.2.132]:48336 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kGmim-0007rm-2h; Fri, 11 Sep 2020 13:20:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cknd/Q6GxbYgIinRfx0mN96yOeRdalGsAQOQCqbW6Noq1rSqEQPwUYjWLpDgFGYIGTWK9QeQsXTb7XfzTuzE81Jw7yPi1BQ08KJeZGWaBP7Oa/q4NobKA/ldNmJjRgp0o/8ZYKWnvmdceRCjsWDRatba2hYbn/iVNeUQRPe3L+tLPlPfGuFXvHxCTjQuIMM/TErawL2ZyllwjSzWFMN7BuezsBeAnYvzr5nxi48+SC4P5xd6xRGZ0QnGp8eP3yVe4VIkxq289eMcIejJMiQ45IBv/705y6vZ4Sso592Uggx0uFSk/yfP5zq54O+jjtVXTP9B0N2cEi4rJTT3kIiPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BME0o8JmwmBEy4y+ATgiOyJ+uCrGvCFsI234RvJEhis=;
 b=LDSvHkwbjpZd1qC0biGQDm8IIWUFuR1BsXgv884CxWpA71PVHmZ0ZP4JKAvLkfH/SW6q2pMQpVVvNvYWq2BGEeRCjfH8N2v3DzH+brOXPpCzjTxWpUei8Mqv/sbDJ3GJteLBOZ87ko9YC3Lrj4BSbOuVHUnpzFoyWmnPhkpbmQsrj/HRbS8aARJ1XobhSwvOaYSnfGtttZC7kCAdC5/XOgOsZ6iYvO7dJXQIWF/5w20j13ozBsTREssIRaL+IWR0i9OHX2EeKx4u0xv5UwMNxqKiyxVImuX28liqEbopYKStYTyBX6YXo/BiYY3nJH84XuDtL+UpHJP9mdTKGKWwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BME0o8JmwmBEy4y+ATgiOyJ+uCrGvCFsI234RvJEhis=;
 b=n1CpqMm8/wpHBiCzoBhovWyBQ3AEMXskC5cRoVIsZuJfgXp2a4udDn8H7X283K7e17tnTJubMZtAMKO8zut7j7ZI4sgnU8etoXGstQfr13YqIaXT9YIO/IHg9hsOxho2sXfj6jwz9YLa47o+TIT6E5nyiNUqno/hnjqSgJyo75k=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4024.eurprd08.prod.outlook.com (2603:10a6:20b:a5::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 17:20:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 17:20:20 +0000
Subject: Re: [PATCH 11/14] block/qcow2-bitmap: return startus from
 qcow2_store_persistent_dirty_bitmaps
To: Markus Armbruster <armbru@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 berto@igalia.com, eblake@redhat.com, jsnow@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, pavel.dovgaluk@ispras.ru, ari@tuxera.com,
 mreitz@redhat.com, kwolf@redhat.com
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-12-vsementsov@virtuozzo.com>
 <20200911113838.482b062e@bahia.lan>
 <2d8099d0-c04c-8b91-fd1e-f988cbba14ce@virtuozzo.com>
 <20200911132152.01855289@bahia.lan>
 <12a7ab93-6545-a221-e9ff-4328c781fbb3@virtuozzo.com>
 <87r1r8cp8e.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7863ba25-250e-a562-4925-6c5f992e587c@virtuozzo.com>
Date: Fri, 11 Sep 2020 20:20:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <87r1r8cp8e.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0134.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::39) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM0PR01CA0134.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Fri, 11 Sep 2020 17:20:19 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4d99edc-c3ab-41e3-4d53-08d85676f598
X-MS-TrafficTypeDiagnostic: AM6PR08MB4024:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4024AB8D2C714BEC0CC3B721C1240@AM6PR08MB4024.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Wi32inUkwbzI5TIIwONxR4lXREnXvoJ0rHg/mlkTyZ1Pl05umhvM+VSzYaArnx8MJb1HNHgW24MHQtRJX8EUYgecQueRYB0b7YUsLa6KPuIbggoLoOaYig6yF+6M6gKgWql7wZFvC/1LyJsSybHXL8/FtA7vhGbv6CylL84dN2YrfNTrCiRiRHX76kcf2B39bcAHolmRkwXdygXCE1gT4Gooc8G3TG6JuGPHgrKVQBfQ6mb70h4fAwCiKy2Fy7ICppdWqpeklw36rcebVxTPGtfZ3K30Cm0oupGQ4F13wLukIlj6fb3x5X1u6EOk1qispk25E9IfjV9Vk7glydHCU+CuYy2srl5OHZJj9yE5dyXk/2gW9WRcE+E2ZW4C0D0xGvdUr6rqNF/Ot6Obhh54w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39840400004)(6916009)(36756003)(6486002)(5660300002)(8936002)(31696002)(2616005)(956004)(86362001)(478600001)(7416002)(66946007)(31686004)(4326008)(16526019)(186003)(26005)(19627235002)(66476007)(66574015)(8676002)(316002)(52116002)(83380400001)(2906002)(66556008)(16576012)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: aAYg4ulHMX8ctggpbEN39wj5HujMU/T+Sv4IVBtcc3wBFnh2RuVLHT22npUZtGS1f56b0uVSykCPsL0YvmC0IFOLqbPwtgKt1rMsYKStKMdNXr0ULtKM2z96/UDkKXFfrmJtm/k2CqDSrT8Kf9lvtrJUf30212eGbMzi9Er8LqhfSWqlunfondhiwZnCsC+s0CkPuZIECNbIyShkZ+xIuskAdl2kIF6Ni+FxHqu5cs96FUdjvpAjhrMUMGNSOdjcJB4TxcEWHJeVbtO3/vHV8VlD3M8+UKq/TrtTPd8LiKOzj8FzuBsl9FL6nWwSAto8RtWjOqt0x5PV2CHU5HVcYaAq/elOozty0O5qNuZeuYrfqXqYjlbfW96YTTaD57WMF0irfD/581uI1Z/SbvhE0Czbe41rkTl9nQuLksppYOC/xTfspNK5pYFRvwI+vI4ahrXpGLFl5SOaZhPPi0Hw2IGjuAVPvKMwGup5tQU+btoLFyBikE3o5QqKjBjjHkeKeAtsU6q6QdROkYTFaMd+MjTP6xX3RY6ib7ni7VQZ0CJW8GSQDRRcK1Cvg51lNiJUaq0xjRJI9ORLhGTWGJEvznxsKSSEDQNZlUjMmNg2FlFCUhmvQj5uvBi496IuZEDkjJoU1917beTPTxKzIlypWQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d99edc-c3ab-41e3-4d53-08d85676f598
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 17:20:20.0977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiHfXf3OA0+lXTbZyvnNB7MxYw0zDaVmQCjzvXPl7sOQJj/sYjCIaRQHWEQlPs+6QBR5BgIo2/VFgBPcvTOKLvHIQWHHtxEPDnsqJJeRbmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4024
Received-SPF: pass client-ip=40.107.2.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 13:20:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

11.09.2020 18:22, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
>> 11.09.2020 14:21, Greg Kurz wrote:
>>> On Fri, 11 Sep 2020 13:18:32 +0300
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>>>
>>>> 11.09.2020 12:38, Greg Kurz wrote:
>>>>> s/startus/status
>>>>>
>>>>> On Wed,  9 Sep 2020 21:59:27 +0300
>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>>>>>
>>>>>> It's better to return status together with setting errp. It makes
>>>>>> possible to avoid error propagation.
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>>> ---
>>>>>>     block/qcow2.h        |  2 +-
>>>>>>     block/qcow2-bitmap.c | 13 ++++++-------
>>>>>>     2 files changed, 7 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/block/qcow2.h b/block/qcow2.h
>>>>>> index e7e662533b..49824be5c6 100644
>>>>>> --- a/block/qcow2.h
>>>>>> +++ b/block/qcow2.h
>>>>>> @@ -972,7 +972,7 @@ bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
>>>>>>                                     Qcow2BitmapInfoList **info_list, Error **errp);
>>>>>>     int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
>>>>>>     int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
>>>>>> -void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>>>>> +bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>>>>>                                               bool release_stored, Error **errp);
>>>>>>     int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
>>>>>>     bool qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
>>>>>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>>>>>> index f58923fce3..5eeff1cb1c 100644
>>>>>> --- a/block/qcow2-bitmap.c
>>>>>> +++ b/block/qcow2-bitmap.c
>>>>>> @@ -1524,9 +1524,10 @@ out:
>>>>>>      * readonly to begin with, and whether we opened directly or reopened to that
>>>>>>      * state shouldn't matter for the state we get afterward.
>>>>>>      */
>>>>>> -void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>>>>> +bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>>>>>                                               bool release_stored, Error **errp)
>>>>>>     {
>>>>>> +    ERRP_GUARD();
>>>>>
>>>>> Maybe worth mentioning in the changelog that this ERRP_GUARD() fixes
>>>>> an error_prepend(errp, ...) not visible in the patch context.
>>>>
>>>> Ah yes. Actually this is occasional thing I didn't want to include into this patch
>>>> (and int this part I). So we can just drop it and leave for part II or part III,
>>>> or add a note into commit message
> 
> Either works for me.
> 
>>>>>
>>>>> Anyway,
>>>>>
>>>>> Reviewed-by: Greg Kurz <groug@kaod.org>
>>>>
>>>> Thanks a lot for reviewing :)
>>>>
>>> Don't mention it :)
>>>
>>>> Hmm.. With this series I understand the following:
>>>>
>>>> 1. It's no sense in simple applying scripts/coccinelle/errp-guard.cocci to the whole code-base, because:
>>>>
>>>>      - it produces a lot of "if (*errp)" in places where it is really simple to avoid error propagation at all, like in this series
>>>>      - reviewing is the hardest part of the process
>>>>
>>>> So, if we have to review these changes anyway, it's better to invest a bit more time into patch creation, and make code correspond to our modern error API recommendations.
> 
> Yes, going the extra mile is better.
> 
> I recommend it for code that is actively maintained.  Making the code
> simpler and thus easier to maintain is an investment that'll pay off.
> 
> We may have code where it won't pay off.  Do you think a blind
> application of errp-guard.cocci might be better than nothing there?

I think, careful review is needed anyway. And it may be too large effort for dead (or almost dead) code.
So, let's start from popular subsystems. And make a decision for the rest later.

> 
>>>> 2. So, the process turns into following steps:
>>>>
>>>>      - apply scripts/coccinelle/errp-guard.cocci
>>>>      - look through patches and do obvious refactorings (like this series)
>>>>      - keep ERRP_GUARD where necessary (appending info to error, or where refactoring of function return status is too invasive and not simple)
>>>>
>>> I've started to follow this process for the spapr code and, indeed,
>>> I
>>> can come up with better changes by refactoring some code manually.
>>> Some of these changes are not that obvious that they could be made
>>> by someone who doesn't know the code, so I tend to agree with your
>>> arguments in 1.
>>> This is also the reason I didn't review patches 10, 13 and 14
>>> because
>>> they looked like I should understand the corresponding code a bit more.
>>>
>>>> 3. Obviously, that's too much for me :) Of course, I will invest some time into making the series like this one, and reviewing them, but I can't do it for weeks and months. (My original сunning plan to simply push ~100 generated commits with my s-o-b and become the greatest contributor failed:)
> 
> LOL
> 
> A lesser craftsman than you would've peddled the generated commits
> anyway.  Props!
> 
>>> Ha ha :D ... as a consolation prize, maybe we can reach a fair
>>> number
>>> of r-b by reviewing each other's _simple_ cleanups ;-)
>>>
>>>> The good thing is that now, with ERRP_GUARD finally merged, we can produce parallel series like this, and they will be processed in parallel by different maintainers (and Markus will have to merge series for subsystems with unavailable maintainers).
> 
> If people care enough about [2] to submit patches, I'll feel obliged to
> help merging them.
> 
>>> This sounds nice. My only concern would be to end up fixing code
>>> nobody
>>> uses or cares for, so I guess it would be better that active maintainers
>>> or supporters give impetus on that.
> 
> A bit of weeding on the side is always appreciated, but please don't
> feel obliged to sink lots of time into code you don't care about.
> 
>>>> So, everybody is welcome to the process [2]. Probably we want to make a separate announcement in a list with short recommendations and instructions? But who read announcements..
>>
>>> I don't :) but the very massive series that were posted on the topic
>>> the last few months look like an announcement to me, at least for
>>> active maintainers and supporters.
>>
>> Aha, I know. Better than announcement is improving checkpatch.
> 
> Yes, automated feedback works best.
> 
> Relentless pressure from reviewers can also work in the long, long run.
> But it's tiresome.
> 
> Of course, checkpatch.pl checks only new or changed code.  Any ideas on
> how to make people aware of the opportunity to simplify their existing
> code?  Obvious: posting more patches simplifying existing code we care
> about.  Any other smart ideas?
> 

I think it would be great for checkpatch to warn about some code problems in function touched by checked patch. Code-style, error-api, etc. This will attract developers to improve existing code they are interested in.


-- 
Best regards,
Vladimir

