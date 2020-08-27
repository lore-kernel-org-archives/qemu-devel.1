Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB064C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F4422B47
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="BPxC3I8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F4422B47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBDJM-0003Oc-P4
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kBDIQ-0002sT-Ua
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:30:10 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kBDIO-00059F-SL
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:30:10 -0400
Received: by mail-wr1-x443.google.com with SMTP id r15so4463309wrp.13
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=Xd8jV2EuKljqkFZCnuKljnsxEvipTvwQ7SBrt1N2yuI=;
 b=BPxC3I8DWWcDFY/GbMEmOom3kcp50G3Vdj9VIqyVbC7K2mZpUiG7XfcRBnPhoTU2LH
 snonBaF9td7B7cCdklXSq+VWc6guL0CizvGp+XGpTTPlfettP5KJ1HlNMAkMv5UaRU+f
 3JAbie1O9cGSz5eRnKYZ2TOp3etrVxEomQyxWHX6A+YybTafg93M09xH1V7r5PU//gwe
 hgKj65noKuuUbehtla67NGDLvxv2zYIeNoclI8V7HH3kI09gajhbdRmMcAB184d7DOP9
 Ejte9l91d5B0rGo5A346mVLXTDyKVjGkbhafWGJTTIzHFkZw7ZyAZCIF8HF7tlvuDjog
 MKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=Xd8jV2EuKljqkFZCnuKljnsxEvipTvwQ7SBrt1N2yuI=;
 b=khy56u9/nY/6rmdWB7R4ofQ5J6HoH2OYmSNuWKIj4w3EwFZgU7VoToQtlYebzAk4/t
 beQsU5kWdecLW3J0BMGWADRl7/T6/SkXDAXYnhYf5dTUxGMk6jWUJvqVhHAe1SRHPvV7
 jj8a+T7z9HxmTwYyEIRY2OeL8E2DtsGlFsKtCWNTJpW6YqSFvrtOyRr4YP0tUtN7E8Lu
 NkuIq73GkzFLnjBUTxxbwROGgSiMnEiQgPnx4WKU/0MTGUx56dDfRC9to9JLVGFBr+oT
 rfgTC022FzLP2M1+BrfLNYeMFLtbXCbPa32zmkSR9tAjlAJbYMk6LIriEo+98/+TAWgI
 P//g==
X-Gm-Message-State: AOAM5309EpsKJx6ecdmeD/fgzTXzdyWbG+SQjpsYUMZAZGSB0G36b/+q
 lWidgbsI6YZukuwdDZOXjxENZg==
X-Google-Smtp-Source: ABdhPJwP0I3DzaYQ2onS7LcgY0viRcRV0+pEBzg5iEnhs0TQ3TDS8zetodnSoec0wdzgN/v3u3AtdA==
X-Received: by 2002:a5d:45c8:: with SMTP id b8mr14104616wrs.381.1598517006016; 
 Thu, 27 Aug 2020 01:30:06 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id j8sm4523188wrs.22.2020.08.27.01.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 01:30:05 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id f7d79cc8;
 Thu, 27 Aug 2020 08:30:04 +0000 (UTC)
To: Zheng Chuan <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v5 09/12] migration/dirtyrate: Implement
 get_sample_page_period() and block_sample_page_period()
In-Reply-To: <c044b58d-a211-9494-70f1-2648c7891576@huawei.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-10-git-send-email-zhengchuan@huawei.com>
 <m23649lni4.fsf@dme.org> <c044b58d-a211-9494-70f1-2648c7891576@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Thu, 27 Aug 2020 09:30:04 +0100
Message-ID: <m2ft88jxtf.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::443;
 envelope-from=dme@dme.org; helo=mail-wr1-x443.google.com
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

On Thursday, 2020-08-27 at 16:01:37 +08, Zheng Chuan wrote:

> On 2020/8/26 18:17, David Edmondson wrote:
>> On Monday, 2020-08-24 at 17:14:37 +08, Chuan Zheng wrote:
>> 
>>> Implement get_sample_page_period() and set_sample_page_period() to
>>> sleep specific time between sample actions.
>>>
>>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>>> ---
>>>  migration/dirtyrate.c | 24 ++++++++++++++++++++++++
>>>  migration/dirtyrate.h |  2 ++
>>>  2 files changed, 26 insertions(+)
>>>
>>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>>> index bd398b7..d1c0a78 100644
>>> --- a/migration/dirtyrate.c
>>> +++ b/migration/dirtyrate.c
>>> @@ -28,6 +28,30 @@
>>>  static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
>>>  static struct DirtyRateStat DirtyStat;
>>>  
>>> +static int64_t set_sample_page_period(int64_t msec, int64_t initial_time)
>>> +{
>>> +    int64_t current_time;
>>> +
>>> +    current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>> +    if ((current_time - initial_time) >= msec) {
>>> +        msec = current_time - initial_time;
>>> +    } else {
>>> +        g_usleep((msec + initial_time - current_time) * 1000);
>>> +    }
>>> +
>>> +    return msec;
>>> +}
>>> +
>>> +static int64_t get_sample_page_period(int64_t sec)
>>> +{
>>> +    if (sec <= MIN_FETCH_DIRTYRATE_TIME_SEC ||
>> 
>> Shouldn't the minimum value be allowed?
>> 
>> That is, this test should be "sec < MIN_FETCH_DIRTYRATE_TIME_SEC" and
>> MIN_FETCH_DIRTYRATE_TIME_SEC should be 1.
>> 
> Well, Actually we could measure dirtyrate within duration below 1s, like 0.5s.
> Howerver, I am reconsider that maybe taking 0.5s as MIN_FETCH_DIRTYRATE_TIME_SEC is better in case of someone to do nasty thing like setting
> a meaningless time duration which is close to 0:)

I think that a minimum of 1 second is fine. My concern is only that if
you say "the minimum is X" but then don't let me choose X, it seems
weird.

>>> +        sec > MAX_FETCH_DIRTYRATE_TIME_SEC) {
>>> +        sec = DEFAULT_FETCH_DIRTYRATE_TIME_SEC;
>>> +    }
>>> +
>>> +    return sec;
>>> +}
>>> +
>>>  static int dirtyrate_set_state(int *state, int old_state, int new_state)
>>>  {
>>>      assert(new_state < DIRTY_RATE_STATUS__MAX);
>>> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
>>> index 41bc264..50a5636 100644
>>> --- a/migration/dirtyrate.h
>>> +++ b/migration/dirtyrate.h
>>> @@ -51,6 +51,8 @@
>>>  
>>>  /* Take 1s as default for calculation duration */
>>>  #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
>>> +#define MIN_FETCH_DIRTYRATE_TIME_SEC              0
>>> +#define MAX_FETCH_DIRTYRATE_TIME_SEC              60
>>>  
>>>  struct DirtyRateConfig {
>>>      uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
>>> -- 
>>> 1.8.3.1
>> 
>> dme.
>> 

dme.
-- 
Hello? Is anybody home? Well, you don't know me, but I know you.

