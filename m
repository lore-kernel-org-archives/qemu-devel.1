Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E49C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6717220734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jsE4zwCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6717220734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiuZs-0004eM-NY
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 02:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jiuZE-00042e-8I; Wed, 10 Jun 2020 02:50:32 -0400
Received: from mail-eopbgr150122.outbound.protection.outlook.com
 ([40.107.15.122]:61921 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jiuZC-00027u-40; Wed, 10 Jun 2020 02:50:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAGAUk893C/zPdPig/0BME0p6uJL1q+ETfcIxj/pu8bZJMflUqu27EoBJNWEA8SebuYikynrPlbLfWErZR6+h0bo3lQ3Q+976kRZIRgpIENZxFMgGZzZnob4LhfMnbyhiibgicc1qm47/5eWOkRAJzkHs9c3JOyVHpIPmtn4j82XnO6DbHlTwrzrWU2C/zrDq/oo3hvOPtxcjqQvByyYrOp1qadV6D++ctLkwHkSDW2ZJxe777XlzGEv+HHlfTPNuW5hzxpkTQD3xReWnP9otvdo9fspYljpVKXlVMCb/G3jBTGQKanUztMR6GOL7v2KdsjTfUNgv5quOipctRVy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SqbUeZpWWy75RvhOmo+N9n7To1RBLVSkjJE6gbmbFg=;
 b=X2ZLQmIRId5XM51i5VGJBiGqDELE+pJaKSyxg98U8aLx5ZmasIncgFkvrVrFnyFWf2NmMZYxjAn1h5H6+6v1jebQlD36aEeuE+SEJg32f645hiu1Sd6husjmI02ZWHddN4jCKvgZmenQQIodglJsXgjRk3sEJGngzpncuits12DIcHTqPE+jozllj/fHWaUF38UBQCxWX1Dc/lw3CD+vF7WRu5c7L3Q4k01dxhUJfQgqPnHoiugWVf74Z1esltDzImreQRMmxOkIZ/n+qubC5xuxsFTDTBjmyLCSVvV5Yzvl94xWQs21tjgdsUzM/+NAV2LmNqK/b7P9DycGxnuYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SqbUeZpWWy75RvhOmo+N9n7To1RBLVSkjJE6gbmbFg=;
 b=jsE4zwCodIE5DAJE0AhAR+47Lqx5rbg6czvWfi3ImZU79kqarTDi1kzR+BAreK+k3gVAIiQ92Ol7Rkf/EKPTuD1JjSTaEChJ6yNbTBpHYWuW6vpi31LZDjS68gGIqAqMEbDDt6KVE7JarFsgRyvrMg8uY2AJ7WewLNvHBV6+sYc=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5464.eurprd08.prod.outlook.com (2603:10a6:20b:10a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Wed, 10 Jun
 2020 06:50:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 06:50:26 +0000
Subject: Re: [PATCH] qcow2: Reduce write_zeroes size in handle_alloc_space()
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200609140859.142230-1-kwolf@redhat.com>
 <02e24dca-99da-873d-8425-09a07571e675@virtuozzo.com>
 <042f0b8f-dd51-acc3-8498-ac9a5532df15@redhat.com>
 <20200609151810.GD11003@linux.fritz.box>
 <b2c59302-2c14-474b-3bb8-3b48806f2689@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <07251d29-538b-82a0-2bf4-975127274127@virtuozzo.com>
Date: Wed, 10 Jun 2020 09:50:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <b2c59302-2c14-474b-3bb8-3b48806f2689@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0056.eurprd04.prod.outlook.com
 (2603:10a6:208:1::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.166) by
 AM0PR04CA0056.eurprd04.prod.outlook.com (2603:10a6:208:1::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Wed, 10 Jun 2020 06:50:25 +0000
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 779b05d4-340e-40ed-7e26-08d80d0a8e59
X-MS-TrafficTypeDiagnostic: AM7PR08MB5464:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5464CA05A4F27526586F94BEC1830@AM7PR08MB5464.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: euRYl0WBks0RxcFrGmjCX/7pnD8hLo5lDM2MvbaGmZoksf0N2WiAKknFDsCg9NRqqLzIt6l7JaQMRUSdhawjEwQ+3M5+jY/ECh/FJKx83sxaCUAFr/Og/vUXejhX5aMZnrE+6l4F5ufbbUL19MbZhvB/G79qB3sx+nYZZinMTS7lq/rMWUzCdGcQFv001vNvM+Gsm0LcqSwrSDbldAO28tbCDMDsy2b+MsAWOkZKbrGgIXI2QXOh5hQi01rAUfl0HwhS8jeoSr0y7h+agq1MLLE00PBcXlAYcOZZWvuqWbPevC1q9QHNVPAaRfa0MBW09bTsR9i+RYduMFdV+3gqtvcalXRJuFz8BgbRU806oYekeCY3Gt+wgUBrXbA1qoHe7wSUYso09ByC99mN3aTGWo0IjeEiWHElQZWiWkp1ROBY4gD87agt9URSm6RforA0HrJr1gXvyoSFWrvP8hwfMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(346002)(396003)(376002)(39840400004)(52116002)(4326008)(2906002)(66476007)(66556008)(66946007)(186003)(2616005)(5660300002)(956004)(53546011)(6486002)(966005)(36756003)(478600001)(54906003)(8676002)(107886003)(110136005)(26005)(8936002)(316002)(83380400001)(16576012)(31686004)(16526019)(86362001)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: j3rgwADh7N72YOoVjbHdSAadnRPNaoMoWHuKvwBvkAxAfvO13WnJpJ3A61AQYPi2D225RW8lf7ib7dIv0A97Via3rGEVno82XAhfzTR+sirZC9L7nXawmCQqC05h0lkfFVP9lThl780Pd8Gfd3L5TfeGlnHy0IwHdh/fxlXhL/R0q05Z8Mr80trVs2KTywAPp64E94KGgqZV4e8q7Grr/frMP/FqTa9T0Ps0+IR+CW5pTYlEsnYQOXTPB2QJHRXk342KHjFgtebJbZPPrOmcrYq+0imMFogcLOd5gBBHOrp0PaWmsTYSjt7KqpgL1RnqvUWJbaEJpJz5vzTn7MWAVVr2F+xENFCvaGrkj++JzkmUnw73XW9ftbcuun2h7hcelHb/OyFRWFYSKB0ZK6aZviMvmSQr0ejvsRlpqy2YQxh4Amg4oYKuqORAPtLUNLkDohMNwBHRAuP1JyxF7NKvQ2RfXH4pvUiYdlSv1I6J9oh3dsCv1kET3YojWEV7A+vj
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779b05d4-340e-40ed-7e26-08d80d0a8e59
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 06:50:26.3014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYSPKxThSV3zdnCiW9q2dTKfuZbncZqD8WEKO36P0TjbK6k2Xk2j45MH8d1QqGisEvsZ5pWQj2lV4CTXjPu4dODdiScJHj3JokpGK8OFOw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5464
Received-SPF: pass client-ip=40.107.15.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 02:50:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: anton.nefedov@virtuozzo.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "Denis V. Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.06.2020 19:19, Eric Blake wrote:
> On 6/9/20 10:18 AM, Kevin Wolf wrote:
> 
>>>>> -        ret = bdrv_co_pwrite_zeroes(s->data_file, m->alloc_offset,
>>>>> -                                    m->nb_clusters * s->cluster_size,
>>>>> +        ret = bdrv_co_pwrite_zeroes(s->data_file, start, len,
>>>>>                                        BDRV_REQ_NO_FALLBACK);
>>>
>>> Good point.  If we weren't using BDRV_REQ_NO_FALLBACK, then avoiding a
>>> pre-zero pass over the middle is essential.  But since we are insisting that
>>> the pre-zero pass be fast or else immediately fail, the time spent in
>>> pre-zeroing should not be a concern.  Do you have benchmark numbers stating
>>> otherwise?
>>
>> I stumbled across this behaviour (write_zeros for 2 MB, then overwrite
>> almost everything) in the context of a different bug, and it just didn't
>> make much sense to me. Is there really a file system where fragmentation
>> is introduced by not zeroing the area first and then overwriting it?
>>
>> I'm not insisting on making this change because the behaviour is
>> harmless if odd, but if we think that writing twice to some blocks is an
>> optimisation, maybe we should actually measure and document this.
>>
>>
>> Anyway, let's talk about the reported bug that made me look at the
>> strace that showed this behaviour because I feel it supports my last
>> point. It's a bit messy, but anyway:
>>
>>      https://bugzilla.redhat.com/show_bug.cgi?id=1666864
>>
>> So initially, bad performance on a fragmented image file was reported.
>> Not much to do there, but then in comment 16, QA reported a performance
>> regression in this case between 4.0 and 4.2. And this change caused by
>> c8bb23cbdbe, i.e. the commit that introduced handle_alloc_space().
>>
>> Turns out that BDRV_REQ_NO_FALLBACK doesn't always guarantee that it's
>> _really_ fast. fallocate(FALLOC_FL_ZERO_RANGE) causes some kind of flush
>> on XFS and buffered writes don't. So with the old code, qemu-img convert
>> to a file on a very full filesystem that will cause fragmentation, was
>> much faster with writing a zero buffer than with write_zeroes (because
>> it didn't flush the result).
> 
> Wow. That makes it sound like we should NOT attempt fallocate(FALLOC_FL_ZERO_RANGE) on the fast path, because we don't have guarantees that it is fast.
> 
> I really wish the kernel would give us fallocate(FALLOC_FL_ZERO_RANGE|FALLOC_FL_NO_FALLBACK) which would fail fast rather than doing a flush or other slow fallback.
> 
>>
>> I don't fully understand why this is and hope that XFS can do something
>> about it. I also don't really think we should revert the change in QEMU,
>> though I'm not completely sure. But I just wanted to share this to show
>> that "obvious" characteristics of certain types of requests aren't
>> always true and doing obscure optimisations based on what we think
>> filesystems may do can actually achieve the opposite in some cases.
> 
> It also goes to show us that the kernel does NOT yet give us enough fine-grained control over what we really want (which is: 'pre-zero this if it is fast, but don't waste time if it is not).  Most of the kernel interfaces end up being 'pre-zero this, and it might be fast, fail fast, or even fall back to something safe but slow, and you can't tell the difference short of trying'.
> 

Hmm, actually, for small cow areas (several bytes? several sectors?), I'm not surprised that direct writing zeroed buffer may work faster than any kind of WRITE_ZERO request. Especially, expanding write-request for a small amount of bytes may be faster than doing intead two requests. Possibly, we need some heuristics here. And I think, it would be good to add some benchmarks based on scripts/simplebench to have real numbers (we'll try).

-- 
Best regards,
Vladimir

