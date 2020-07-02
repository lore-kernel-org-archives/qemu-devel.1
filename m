Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787AAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE9320772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YkDnDqgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE9320772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqyob-0003eE-Fk
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqymr-0000cL-IU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:57:57 -0400
Received: from mail-eopbgr150104.outbound.protection.outlook.com
 ([40.107.15.104]:52158 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqymn-0004jm-RM
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:57:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnUNYFfHgqZKu1Ptk64zPPQgQilRSYRvQXxhm9j7hLfhPbV87vw1qMvNu3//+duHqPRfo/9L35a8dIcUP7imuK54bEWi3vSXedisgXI7OhXFMcBPCuoguvi4zHaS9FFm/ZHKKj8Wcz4pmoYzhrJIwlSdNNGW9OoCRORW50Nr5N3RjaSPPf+etNV9HHKrFgJN/p4i1HRfWyNhuIxarR8Z+kTWEx5C3tcVsG3mPCuo+h53pe66kqGKdUH8BpSBi0kO4+O02wc5DqL5Fz+1sDzR1b2dLPgwUPsFnMMRcgOY/6u0bACQWrQus8CujvhpUzST9PPeYj17nz629r3B+GVkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ho+wFrWYDPDA6Narqea8lctLkrUUm/SfFmoqWZ+tDQ0=;
 b=XniQOgnyKX4pAk2B1cxt30fV8xYHCgrh7zpEXbgDwLyHS/hy0PLBTZl7GaKMNSwPsjWj8BW1J0WzLDl+2rLdrok5RLcDX6s7ibpwMA/ve9vB2XEQ8Q98WahmfpQJal+uLuvrRHCCPIEpO80FiGKrz8C3Vg54nqoyBApg/beW85rdWYzCFK/MjwATcUM8hfdU0avRBWTcDGp2aYZ6nQ7vQSNXPuy9bOx9I2PE3kHwYUODSN1kqXCtZEJi0WA7eAwUEWE/I8ZhSw5PhKKb5dtRJvFsGL82WBbPWhTeLwdBKsiUhEhTDNs0q7jkFlKktmNBfw27S/okAFCDX3gTDZN0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ho+wFrWYDPDA6Narqea8lctLkrUUm/SfFmoqWZ+tDQ0=;
 b=YkDnDqghDZXWzLmDYPWIsTzi/odhI2B05Qt+vXns/GJ/PIw0tBR1wTueoO4NkgRrpR2YhvDMTVFUwaMKcOqhG7PPqFaTpve8qRw34eZstWQsa9ZAvBvf0E5PU7T68sKp0jJUKguPKJ7kSsn32247AfMgVm7Y4wmv1CSu+MWvX5E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1907.eurprd08.prod.outlook.com (2603:10a6:203:4a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Thu, 2 Jul
 2020 12:57:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Thu, 2 Jul 2020
 12:57:50 +0000
Subject: Re: Properly quitting qemu immediately after failing migration
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <0dce6c63-4b83-8b1a-6d00-07235f637997@redhat.com>
 <92ce741d-ef67-fbf9-a889-27d9ae218681@virtuozzo.com>
 <9eecca93-e7d9-d1da-7fcd-ee60978ec460@redhat.com>
 <61a5c813-d638-3e03-05a6-a7b0c27cc834@virtuozzo.com>
 <f166c770-7c5d-2854-1dfe-3a69300eca5f@redhat.com>
 <c1d6592a-980d-3aab-dcba-9cecfc1e0f2b@virtuozzo.com>
Message-ID: <aa4621d2-b0b1-af56-2a70-8be0b9fdff74@virtuozzo.com>
Date: Thu, 2 Jul 2020 15:57:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <c1d6592a-980d-3aab-dcba-9cecfc1e0f2b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR05CA0138.eurprd05.prod.outlook.com
 (2603:10a6:207:3::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.54) by
 AM3PR05CA0138.eurprd05.prod.outlook.com (2603:10a6:207:3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23 via Frontend Transport; Thu, 2 Jul 2020 12:57:50 +0000
X-Originating-IP: [185.215.60.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74aef1bb-97e0-43f2-ae27-08d81e8786e0
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1907:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB190741C626CF15421BD18E7DC16D0@AM5PR0801MB1907.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SUtBqh82Hggxu9Qq8sLPXiCjMeIfzwDUQmW/b+fLQqC9CEy+9+bfBtphhmUt+POE3a6O0w7dqgpSOl3/5DmvBRLT4zeDfUmkMl9Yxfsus5qr384CUBMkvFH7yEEStFOJHrFJoUSDL/qg/nCdooci7MWGb1XrDXcAX3lAn9qydxAl1AvNAAum4I/aDtdEPGTJ9I46d4VWRJI9E+u1eER9ZoIDjn8QKmPLJsWYClXulP0XZbwCwE9TIinrw9klpj22O4Tcs1Deu33QuLlX/FW9UaNxbHUHwyXChLGSqCsuOp85UnLb+LGLaFWnvJM43K1kzjZHB1S5G30Cy1GfPtcVaJadvURLBTxa0Z9Y0gcftzhK1+QQ/51ITyLbHcTlMToLvk+QKYI9F/RMhdDkuRiYbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39840400004)(136003)(366004)(376002)(26005)(86362001)(53546011)(8936002)(478600001)(66476007)(66946007)(16576012)(316002)(6486002)(31686004)(2906002)(83380400001)(2616005)(956004)(5660300002)(110136005)(8676002)(16526019)(66556008)(186003)(52116002)(31696002)(36756003)(14773001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: gEfUNcNqUXVbNGtoIJGDmxz4yFCCN1Z/R9dHit4Q9pPjl8nBCvCySBCvWagT93nTfAzrxRLtCDO6gsaYdJBWz7r1PKL+S3Njkyr7d/rpnrQCRwMDXwJ4U867/KAJ1jPmXd8iNOE0EpHfH6UaeTAZgeAmZ7hs1iRf5lNvAQDZmmF+GAQNdgE2sKXjNVeyBD0AjlHhU0Vo1i3UqCiOuImIu7BxIai8HmkysW62HbvvTrtegOIK7cRJWyJCPokvM3OBSigToOcAScpHFL+BjLLE2HfYw542Bg1u2C2hAZ6oGeXfQkMKDg6ICOTc5BcYMzhtgLvvpMWOW/m7Z1i3J/ylZZx0yElztQm26Wd7XJkXvyyxqSwS6o/vJVnPTxcX5JVomQ0kS9CudjOl/ntgxYHDbHI9apdzzWLO9zdkmdifEKQ4gnVh1wpzdPzbsJ6irocpAy8uC6l/jmGhQXK3ECXD0K736Bg/ZffjzH4fKxAbvs8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74aef1bb-97e0-43f2-ae27-08d81e8786e0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 12:57:50.7295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVl86aa9+sjfJ16PAT98zkB++Sxo1CoElPv8N+d3ctI7qxSImLt0PTu9t3SBnV/pMqezvfbUb20NZEpCIOedbRCVqxxwOGa9CiseBM2G/DA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1907
Received-SPF: pass client-ip=40.107.15.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 08:57:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.07.2020 14:44, Vladimir Sementsov-Ogievskiy wrote:
> 02.07.2020 10:23, Max Reitz wrote:
>> On 01.07.20 18:16, Vladimir Sementsov-Ogievskiy wrote:
>>> 29.06.2020 18:00, Max Reitz wrote:
>>>> On 29.06.20 16:18, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 29.06.2020 16:48, Max Reitz wrote:
>>>>>> Hi,
>>>>>>
>>>>>> In an iotest, I’m trying to quit qemu immediately after a migration has
>>>>>> failed.  Unfortunately, that doesn’t seem to be possible in a clean
>>>>>> way:
>>>>>> migrate_fd_cleanup() runs only at some point after the migration state
>>>>>> is already “failed”, so if I just wait for that “failed” state and
>>>>>> immediately quit, some cleanup functions may not have been run yet.
>>>>>>
>>>>>> This is a problem with dirty bitmap migration at least, because it
>>>>>> increases the refcount on all block devices that are to be migrated, so
>>>>>> if we don’t call the cleanup function before quitting, the refcount
>>>>>> will
>>>>>> stay elevated and bdrv_close_all() will hit an assertion because those
>>>>>> block devices are still around after blk_remove_all_bs() and
>>>>>> blockdev_close_all_bdrv_states().
>>>>>>
>>>>>> In practice this particular issue might not be that big of a problem,
>>>>>> because it just means qemu aborts when the user intended to let it quit
>>>>>> anyway.  But on one hand I could imagine that there are other clean-up
>>>>>> paths that should definitely run before qemu quits (although I don’t
>>>>>> know), and on the other, it’s a problem for my test.
>>>>>>
>>>>>> I tried working around the problem for my test by waiting on “Unable to
>>>>>> write” appearing on stderr, because that indicates that
>>>>>> migrate_fd_cleanup()’s error_report_err() has been reached.  But on one
>>>>>> hand, that isn’t really nice, and on the other, it doesn’t even work
>>>>>> when the failure is on the source side (because then there is no
>>>>>> s->error for migrate_fd_cleanup() to report).
>>>>
>>>> (I’ve now managed to work around it by invoking blockdev-del on a node
>>>> affected by bitmap migration until it succeeds, because blockdev-del can
>>>> only succeed once the bitmap migration code has dropped its reference to
>>>> it.)
>>>>
>>>>>> In all, I’m asking:
>>>>>> (1) Is there a nice solution for me now to delay quitting qemu until
>>>>>> the
>>>>>> failed migration has been fully resolved, including the clean-up?
>>>>>>
>>>>>> (2) Isn’t it a problem if qemu crashes when you issue “quit” via QMP at
>>>>>> the wrong time?  Like, maybe lingering subprocesses when using “exec”?
>>>>>>
>>>>>>
>>>>>
>>>>> I'll look more closely tomorrow, but as a short answer: try my series
>>>>> "[PATCH v2 00/22] Fix error handling during bitmap postcopy" it
>>>>> handles different problems around migration failures & qemu shutdown,
>>>>> probably it will help.
>>>>
>>>> Not, it doesn’t seem to.
>>>>
>>>> I’m not sure what exactly that series addresses, but FWIW I’m hitting
>>>> the problem in non-postcopy migration.  What my simplest reproducer
>>>> does is:
>>>
>>> Bitmaps migration is postcopy by nature (and it may not work without
>>> migrate-start-postcopy, but work in most simple cases, as when we have
>>> small bitmap data to migrate, it can migrate during migration downtime).
>>> Most complicated part of the series were about postcopy. Still it fixes
>>> some other things.
>>>
>>> It seems, that patch (see the second paragraph)
>>> "[PATCH v2 10/22] migration/block-dirty-bitmap: cancel migration on
>>> shutdown"
>>>
>>>>     If target is turned of prior to postcopy finished, target crashes
>>>>     because busy bitmaps are found at shutdown.
>>>>     Canceling incoming migration helps, as it removes all unfinished (and
>>>>     therefore busy) bitmaps.
>>>
>>>>     Similarly on source we crash in bdrv_close_all which asserts that all
>>>>     bdrv states are removed, because bdrv states involved into dirty
>>>> bitmap
>>>>     migration are referenced by it. So, we need to cancel outgoing
>>>>     migration as well.
>>>      should address exactly your issue.
>>
>> Hm.  I’ve tested your series and still hit the issue.
>>
>> I could imagine that my problem lies with a failed migration that is
>> automatically “cancelled” by nature, so the problem isn’t that it isn’t
>> cancelled, but that the clean-up runs after accepting further QMP
>> commands (like quit).
> 
> Looking at my patch I see
> 
> +void dirty_bitmap_mig_cancel_outgoing(void)
> +{
> +    dirty_bitmap_do_save_cleanup(&dbm_state.save);
> +}
> +
> 
> So, may be "cancel" is just a bad name. It should work, but it doesn't.
> 
>>
>>>>
>>>> On the source VM:
>>>>
>>>> blockdev-add node-name='foo' driver='null-co'
>>>> block-dirty-bitmap-add node='foo' name='bmap0'
>>>>
>>>> (Launch destination VM with some -incoming, e.g.
>>>> -incoming 'exec: cat /tmp/mig_file')
>>>>
>>>> Both on source and destination:
>>>>
>>>> migrate-set-capabilities capabilities=[
>>>>       {capability='events', state=true},
>>>>       {capability='dirty-bitmaps', state=true}
>>>> ]
>>>>
>>>> On source:
>>>>
>>>> migrate uri='exec: cat > /tmp/mig_file'
>>>>
>>>> Then wait for a MIGRATION event with data/status == 'failed', and then
>>>> issue 'quit'.
>>>>
>>>> Max
>>>>
>>>
>>> Can you post exact reproducer iotest?
>>
>> I didn’t have an iotest until now (because it was a simple test written
>> up in Ruby), but what I’ve attached should work.
>>
>> Note that you need system load to trigger the problem (or the clean-up
>> code is scheduled too quickly), so I usually just run like three
>> instances concurrently.
>>
>> (while TEST_DIR=/tmp/t$i ./check 400; do; done)
>>
>> Max
>>
> 
> Thanks! Aha, reporoduced on your branch, more than 500 rolls, several (5-6) instances.
> 
> Interesting, if drop failure-waiting loop, it crashes without any race, just crashes.
> 
> Move to my branch.
> 
> With dropped fail-waiting loop, it crashes in about 17 tries, with several instances.

very interesting: on crash-case dirty_bitmap_save_setup() is called after migration_shutdown().

So, migration_shutdown calls my dirty_bitmap_do_save_cleanup() which cleanups empty migration setup,
and then migration starts.

So, it's the race: If we do qmp migrate and then qmp quit, the actual sequence of operation may be changed. Not good.

I can hack it, just adding DBMSaveState.shutdown bool variable and set it to true in dirty_bitmap_do_save_cleanup
(probably, need distinguish shutdown from usual migration finish/cancel), and do nothing in all other bitmap
migration handlers, if shutdown is true.

But true way is ofcourse fixing generic migration code to not initiate a migration if it is already in shutdown..

Any ideas?

> 
> Ahahaha. and with fail-waiting loop as is, it crashes immediately, without a race.

Ok, this is another crash, simple to fix (and introduced by my series).

> 
> So my patch make it work visa-versa. Magic.
> 
> For me this looks like my patch just don't do what it should. I'll work on this and
> resend the series together with new test case. Or may be better to split the series,
> to address different issues separately.
> 


-- 
Best regards,
Vladimir

