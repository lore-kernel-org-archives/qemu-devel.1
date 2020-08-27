Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E19C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 15:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE0A2177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 15:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="URfusXV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE0A2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBJyc-0007GK-1T
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 11:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kBJxL-0006VS-FO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 11:36:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kBJxI-0007yl-Tv
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 11:36:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id b18so5804494wrs.7
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=BeOcvmwAWgnHeFQeBo35PZI2Sg6m4dhDarRj4GCNKHY=;
 b=URfusXV//BbSgQr1OUBrGS0bK/XzyTvXxY3/rGoKwUfejqih031TGvNiAkoy3Bjbeh
 CRytncjzYBhPxmpM2B8c4sQcYkouloqDkjx+5P/zthJTEEYXrRL6oMt/mhdBAZ0MfpIk
 FCurhZNliz9TezITqMggZKnZdFqwvFbWRygwkeO2iLeAQ0Q25/Eup/NfFJbouW+7WnY8
 cYPxfF6YfeDsRySnT7urWfYbsl3TvPIILEgCSQ3zEPC7N8qufmrjDBKXyIpTvujLvca9
 RZCfSQKMus5XktBvlSKG0pSPRgi/zgI/Zb2XqkJN8gI8T4+LQGJGLvOZJtPcnqpCxaCv
 +VfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=BeOcvmwAWgnHeFQeBo35PZI2Sg6m4dhDarRj4GCNKHY=;
 b=evLxS59COxDntWI+EpdRhG76sdI1KKaYkagXZpiuIL12PxfKmKyL2F2DO9ixdvDbq2
 7dRJKmGxqWSEs6lcg1Z/qvCFLR6nTkNjQ9gY07gA8GQhwjTDljz+DWB2/P6mK8LQfoiR
 rh2PED5Q0wBGALBXrpOophz7YePqWk0DweEcj0l0RWVSQKmo9JJGh165xQ9nYO0GyjE7
 V8XOpGmfbmif12ip4+lLIaSRKs5z0wQAWdsOBvFckFogAzu9QCwd02sTa5yU8CLmsY5G
 kZg16hygUy3TScsYbu1OMP8+D9tHrIEvNp/UU/qv2xrroukWTsgnpT4PHnzuSruT8GcZ
 WLeQ==
X-Gm-Message-State: AOAM530LdIDdOhekzMzH5XxOF+LlBf+ksmKldPX21x7wN2jwxDtQIhhC
 0Y5Bm5qlrNVGvxPeEmqVlK26nw==
X-Google-Smtp-Source: ABdhPJxRODa8wZT7CDYuH90aukH4TXfXiyZ7oFnHNxN4VO3K+0ghECRXjvS18eBXRU2Ndvy8TDv/3g==
X-Received: by 2002:a5d:4210:: with SMTP id n16mr21656339wrq.426.1598542606813; 
 Thu, 27 Aug 2020 08:36:46 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id g14sm5436299wmk.37.2020.08.27.08.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 08:36:46 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 3dd9d397;
 Thu, 27 Aug 2020 15:36:45 +0000 (UTC)
To: Zheng Chuan <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v5 11/12] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
In-Reply-To: <5e3fc626-531a-4383-2f61-f274e2c1357a@huawei.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-12-git-send-email-zhengchuan@huawei.com>
 <m2wo1lk8j9.fsf@dme.org> <1a23d60c-186b-d5b5-c43a-a8512826409b@huawei.com>
 <m2d03cjo5j.fsf@dme.org> <e578c320-4864-863a-f54c-be1d6ab9d1bd@huawei.com>
 <m2a6ygjkzq.fsf@dme.org> <5e3fc626-531a-4383-2f61-f274e2c1357a@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Thu, 27 Aug 2020 16:36:45 +0100
Message-ID: <m23648je2a.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::442;
 envelope-from=dme@dme.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, 2020-08-27 at 22:47:15 +08, Zheng Chuan wrote:

> On 2020/8/27 21:07, David Edmondson wrote:
>> On Thursday, 2020-08-27 at 20:55:51 +08, Zheng Chuan wrote:
>> 
>>> On 2020/8/27 19:58, David Edmondson wrote:
>>>> On Thursday, 2020-08-27 at 17:34:13 +08, Zheng Chuan wrote:
>>>>
>>>>>>> +    /*
>>>>>>> +     * Only support query once for each calculation,
>>>>>>> +     * reset as DIRTY_RATE_STATUS_UNSTARTED after query
>>>>>>> +     */
>>>>>>> +    (void)dirtyrate_set_state(&CalculatingState, CalculatingState,
>>>>>>> +                              DIRTY_RATE_STATUS_UNSTARTED);
>>>>>>
>>>>>> Is there a reason for this restriction? Removing it would require
>>>>>> clarifying the state model, I suppose.
>>>>>>
>>>>> We only support query once for each calculation.
>>>>> Otherwise, it could always query dirtyrate, but maybe the dirtyrate is calculated
>>>>> long time ago.
>>>>
>>>> There's nothing in the current interface that prevents this from being
>>>> the case already - the caller could initiate a 1 second sample, then
>>>> wait 24 hours to query the result.
>>>>
>>>> Obviously this would generally be regarded as "d'oh - don't do that",
>>>> but the same argument would apply if the caller is allowed to query the
>>>> results multiple times.
>>>>
>>>> Perhaps a complete solution would be to include information about the
>>>> sample period with the result. The caller could then determine whether
>>>> the sample is of adequate quality (sufficiently recent, taken over a
>>>> sufficiently long time period) for its' intended use.
>>>>
>>> You mean add timestamp when i calculate?
>> 
>> You already have a timestamp, though I'm not sure if it is one that is
>> appropriate to report to a user.
>> 
>> I was thinking that you would include both the start time and duration
>> of the sample in the output of the query-dirty-rate QMP command, as well
>> as the dirty rate itself. That way the caller can make a decision about
>> whether the data is useful.
>> 
> OK, i understand.
> I may add it like this:
> +##
> +{ 'struct': 'DirtyRateInfo',
> +  'data': {'dirty-rate': 'int64',
> +           'status': 'DirtyRateStatus',
> +           'start-timestamp': 'int64',
> +           'calc-time': 'int64'} }
> +
> +##
> the stat-timestamp would be initial_time which gets from qemu_clock_get_ms(QEMU_CLOCK_REALTIME)
> at the beginning of calculation while calc_time is time-duration in microsecond.

The calc-time reported here should be in the same units as when it is
specified in calc-dirty-rate (seconds for both seems fine).

I suspect that providing the start-timestamp in seconds would also be
fine - it's not obvious that knowing the value in milliseconds adds much
value.

> But i reconsider that, it maybe still need to reset the CalculatingState as DIRTY_RATE_STATUS_UNSTARTED
> here?
>
> Initialization like:
> void qmp_calc_dirty_rate(int64_t calc_time, Error **errp)
> {
>    XXXX
>
>     if (CalculatingState == DIRTY_RATE_STATUS_MEASURING) {
>         return;
>     }
>
>
>     (void)dirtyrate_set_state(&CalculatingState, CalculatingState,
>                               DIRTY_RATE_STATUS_UNSTARTED);
>     XXXX
> }
>
> It could not prevent concurrent scene which may lead to disorder state:(

It should be possible to initiate measurement when the state is either
UNSTARTED or MEASURED - only MEASURING should rule it out.

>
>
>>> Actually, I do not want make it complicate for qemu code,
>>> maybe it could be left for user to implement both two qmp commands
>>> like in libvirt-api.
>> 
>> Sorry, I didn't understand this comment.
>> 
>>> On the other hand, it really bother me that we need to reset calculating state
>>> to make sure the state model could be restart in next calculation.
>>>
>>> For now, i put it after query_dirty_rate_info is finished as you see, it should not be a good idea:(
>>>
>>> Maybe it is better to initialize at the beginning of qmp_calc_dirty_rate().
>>>
>>>> dme.
>>>>
>> 
>> dme.
>> 

dme.
-- 
Everyone I know, goes away in the end.

