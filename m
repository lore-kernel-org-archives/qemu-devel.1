Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CAFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA07206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="oc0DtddH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA07206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHdB-0002h4-F9
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kBHcW-0001rO-F9
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:07:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kBHcU-00020r-A8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:07:12 -0400
Received: by mail-wm1-x341.google.com with SMTP id t2so5124166wma.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=mCbMx6m17QXOBpd3j4dXLw3eWKa+tUYrEz0nEFTXHSM=;
 b=oc0DtddHCxNGqpJsF3ukSc4rerfaVLtLgbzlpYTaaUJ5oAIo8m1fQV8dSNuNs/AvLh
 TZ+oxsld8G9YEcldmygBgDATlDhAy6ZxzG53j0mX8lW42EeOVRqnfwrMlaYXVBt+M/TA
 1HOP+tnMFY2W1S0D2T27MR/Cz/oov/1tzzFPPMHzsVyjs55zHI8NTNfJUD2lfIw43EzQ
 w9a4tEdUlhrnlBeR1z/wKU8ZKv0/Qet81zPOQF/d5WlU2SCXWoO99J5oVsSVBR3v+3W9
 MPcD2G2s5YxlqaRtgI0H1xTsFX1MhpSQlgan1nkdVmmTyOxKVxai9IeMZTZC0BiIPIc6
 cwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=mCbMx6m17QXOBpd3j4dXLw3eWKa+tUYrEz0nEFTXHSM=;
 b=D6CJfLKU0RhkddkOwnudL6DZxBmO06kWMXU7jl6c91dthnCa2C4QQUrRq63Py1GAJG
 stzWWlbqbCjFKIq6/sJA/fanqs6UdgvLvDwJmc5S50wC6XIzJtIWuesc9JdzUOEt1fkM
 IOeOcSkn3BYDadQYFyDeS+itgOgH+5VcfYRDxcFrbI/DL+qF5WNQzbmEfTTTuYev/hTX
 ik7xRDqxquaZWGW69Gcq+0cfC3ryMWuFfcFCtaT0clC0hE6S24JBvSN1Yqankbid6/qr
 OY++1p8fZRk0085gPlaPNKpaJINgYWF/sySDr84EHxPWUaTf89lmjWuYYXhjQTL6Gj+p
 5WFw==
X-Gm-Message-State: AOAM5311HT6X9PqawRNsvT+3Y4zTyVg05RmNpl3ZDDsT5cAaLmAn8YhD
 meE8htIRpfROJb19OVeUI8RVRiMnI7FAgpR8Z00=
X-Google-Smtp-Source: ABdhPJzhFV6On9HIigVdHkO3xTclDmFccAqQPGtKZ6OelOt5jkCcmBzPfNb7FlJf/U8kLKQpry0GKA==
X-Received: by 2002:a1c:1bc2:: with SMTP id
 b185mr12829835wmb.168.1598533627681; 
 Thu, 27 Aug 2020 06:07:07 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id a13sm5836768wrp.45.2020.08.27.06.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 06:07:06 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id b44b2343;
 Thu, 27 Aug 2020 13:07:05 +0000 (UTC)
To: Zheng Chuan <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v5 11/12] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
In-Reply-To: <e578c320-4864-863a-f54c-be1d6ab9d1bd@huawei.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-12-git-send-email-zhengchuan@huawei.com>
 <m2wo1lk8j9.fsf@dme.org> <1a23d60c-186b-d5b5-c43a-a8512826409b@huawei.com>
 <m2d03cjo5j.fsf@dme.org> <e578c320-4864-863a-f54c-be1d6ab9d1bd@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
X-Playing: Floating Points: Environments
Date: Thu, 27 Aug 2020 14:07:05 +0100
Message-ID: <m2a6ygjkzq.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::341;
 envelope-from=dme@dme.org; helo=mail-wm1-x341.google.com
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

On Thursday, 2020-08-27 at 20:55:51 +08, Zheng Chuan wrote:

> On 2020/8/27 19:58, David Edmondson wrote:
>> On Thursday, 2020-08-27 at 17:34:13 +08, Zheng Chuan wrote:
>> 
>>>>> +    /*
>>>>> +     * Only support query once for each calculation,
>>>>> +     * reset as DIRTY_RATE_STATUS_UNSTARTED after query
>>>>> +     */
>>>>> +    (void)dirtyrate_set_state(&CalculatingState, CalculatingState,
>>>>> +                              DIRTY_RATE_STATUS_UNSTARTED);
>>>>
>>>> Is there a reason for this restriction? Removing it would require
>>>> clarifying the state model, I suppose.
>>>>
>>> We only support query once for each calculation.
>>> Otherwise, it could always query dirtyrate, but maybe the dirtyrate is calculated
>>> long time ago.
>> 
>> There's nothing in the current interface that prevents this from being
>> the case already - the caller could initiate a 1 second sample, then
>> wait 24 hours to query the result.
>> 
>> Obviously this would generally be regarded as "d'oh - don't do that",
>> but the same argument would apply if the caller is allowed to query the
>> results multiple times.
>> 
>> Perhaps a complete solution would be to include information about the
>> sample period with the result. The caller could then determine whether
>> the sample is of adequate quality (sufficiently recent, taken over a
>> sufficiently long time period) for its' intended use.
>> 
> You mean add timestamp when i calculate?

You already have a timestamp, though I'm not sure if it is one that is
appropriate to report to a user.

I was thinking that you would include both the start time and duration
of the sample in the output of the query-dirty-rate QMP command, as well
as the dirty rate itself. That way the caller can make a decision about
whether the data is useful.

> Actually, I do not want make it complicate for qemu code,
> maybe it could be left for user to implement both two qmp commands
> like in libvirt-api.

Sorry, I didn't understand this comment.

> On the other hand, it really bother me that we need to reset calculating state
> to make sure the state model could be restart in next calculation.
>
> For now, i put it after query_dirty_rate_info is finished as you see, it should not be a good idea:(
>
> Maybe it is better to initialize at the beginning of qmp_calc_dirty_rate().
>
>> dme.
>> 

dme.
-- 
Another lonely day, no one here but me-o.

