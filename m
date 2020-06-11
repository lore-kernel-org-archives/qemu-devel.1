Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3945CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034482063A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="hMQ+Kb55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034482063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjKvF-0002Bw-7M
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 06:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1jjKuN-0001BV-Ks
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:58:07 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40481)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1jjKuM-0008Cv-Jl
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:58:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id h5so5683345wrc.7
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 03:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=TGEysEym/r9mkXU6aBSqwx7SOJ/Ch+nknE4tNvEv2Kk=;
 b=hMQ+Kb5569TCLrYLD7anQ4dX0Ah2JUvbY1mPFW9tHeo6N5TKakwwL8j1nuRRAMVou6
 arDSv/lNfJJ2H+aID+8Vxl6qXb1BsZWtQNZMn2oibZE2DKkWeiOU1jkwlUdB2f8YcgCG
 UQmqTeUutLEk0DQjO8GqB5Id3EAQZ3eDJ3agughZZ7fxZOGukngraDwaaGrEgXIqbtND
 glmMVOVTYabmwl5v9bYkJld7eteTf8XUgb1/UoLlduAcRS0ogibZo+a6dHE8IHn23W7s
 2o2J7xVyqrA1olFZv4MobD3cS952EHXT3SJ4DE7ypQEQtKmjsyJe1jC/Es+lmJbex/Ju
 J0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=TGEysEym/r9mkXU6aBSqwx7SOJ/Ch+nknE4tNvEv2Kk=;
 b=CxrAbsxJfLrjd2dhnVMgCgteXIgy+5u6xrQmNCxNUJYydpLKf91457ht4/4P+P08yF
 nM3yZ6H4acT0rlLf66zKIRahw4eJD9FbANX7JJ2Dhs8tnJ+OVKK7D2JORSrNd/WLJBLl
 JoGiFjg6keM6IonSvuVCsr9CEsSx7DzSm+qjVS7jn/e5FK1CTKokZGC/OlLSHPAIlnMm
 uRGyyJq3+0i7SaNKhDHBFjIMWcRQpHGhHj6lvzAf3cmM5Zd2GG+viieX6J/qrA9JKTML
 lafoEQA4ZEtVJpbCzEPZLNVNIJdlb4wGgxICLZZ/EBCd42pFsc0/tQOr899DRo5kAg2T
 0KdQ==
X-Gm-Message-State: AOAM531qyoANXA8yjuj2hm/NEn76iAi56Sn5oy0ah1SaAGThu8X/rb4X
 T6BY1ikDKzuKJHl9InqkL9JwEA==
X-Google-Smtp-Source: ABdhPJwgT7yWAaocAka2VD+rwe2IaaFQ85IFfsk36FMlHGkAZbOXvjrbH5dhvrUg2RaAebOudbk/+Q==
X-Received: by 2002:adf:e4d1:: with SMTP id v17mr8785845wrm.224.1591873084666; 
 Thu, 11 Jun 2020 03:58:04 -0700 (PDT)
Received: from disaster-area.hh.sledj.net (disaster-area.hh.sledj.net.
 [2001:8b0:bb71:7140:64::1])
 by smtp.gmail.com with ESMTPSA id h15sm4209708wrt.73.2020.06.11.03.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 03:58:03 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 0d3e0be9;
 Thu, 11 Jun 2020 10:58:02 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, Sam Eiderman <sameid@google.com>, Kevin
 Wolf <kwolf@redhat.com>
Subject: Re: Clarification regarding new qemu-img convert --target-is-zero flag
In-Reply-To: <03718921-c988-98e2-3a72-3f10b9f14fcd@redhat.com>
References: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
 <m2imfz877v.fsf@dme.org>
 <CAFr6bUk5LrEL8BPXYkNOqj_jsbxHBfbj_NYryUjszMtG89L+2w@mail.gmail.com>
 <20200610140620.GE6947@linux.fritz.box>
 <CAFr6bU=aD=AXnoR-qSdQtQC690FYFqFsDRHHGxdUDkTh2ho1cA@mail.gmail.com>
 <CAFr6bUksp1Nm4nL69na5WDj6A5iXzwcc4K3=JNnyP4xZ+HKJHA@mail.gmail.com>
 <m2bllr7wrg.fsf@dme.org> <999a1a74-d082-bcdb-e3f9-6c44b2526433@redhat.com>
 <m28sgu9ame.fsf@dme.org> <03718921-c988-98e2-3a72-3f10b9f14fcd@redhat.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Thu, 11 Jun 2020 11:58:02 +0100
Message-ID: <m25zbx98ed.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::444;
 envelope-from=dme@dme.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: Tony Zhang <tzz@google.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-06-10 at 11:21:27 -05, Eric Blake wrote:

> On 6/10/20 10:57 AM, David Edmondson wrote:
>> On Wednesday, 2020-06-10 at 10:48:52 -05, Eric Blake wrote:
>> 
>>> On 6/10/20 10:42 AM, David Edmondson wrote:
>>>> On Wednesday, 2020-06-10 at 18:29:33 +03, Sam Eiderman wrote:
>>>>
>>>>> Excuse me,
>>>>>
>>>>> Vladimir already pointed out in the first comment that it will skip
>>>>> writing real zeroes later.
>>>>
>>>> Right. That's why you want something like "--no-need-to-zero-initialise"
>>>> (the name keeps getting longer!), which would still write zeroes to the
>>>> blocks that should contain zeroes, as opposed to writing zeroes to
>>>> prepare the device.
>>>
>>> Or maybe something like:
>>>
>>> qemu-img convert --skip-unallocated
>> 
>> This seems fine.
>> 
>>> which says that a pre-zeroing pass may be attempted, but it if fails,
>> 
>> This bit puzzles me. In what circumstances might we attempt but fail?
>> Does it really mean "if it can be done instantly, it will be done, but
>> not if it costs something"?
>
> A fast pre-zeroing pass is faster than writing explicit zeroes.  If such 
> a fast pass works, then you can avoid further I/O for all subsequent 
> zero sections; the unallocated sections will now happen to read as zero, 
> but that is not a problem since the content of unallocated portions is 
> not guaranteed.
>
> But if pre-zeroing is not fast, then you have to spend the extra I/O to 
> explicitly zero the portions that are allocated but read as zero, while 
> still skipping the unallocated portions.

The lack of deterministic behaviour would worry me. If the caller can't
be sure whether the unallocated portions of the device will be zeroed or
not, it feels as though the number of potential use cases is reduced.

The optimisation is focused on images where there are a significant
number of allocated zero blocks. Is that a common case? (It obviously
exists, because many images generated before "--target-is-zero" will be
like that, but perhaps they would be better cleaned by an unallocator.)

>> I'd be more inclined to go for "unallocated blocks will not be written",
>> without any attempts to pre-zero.
>
> But that can be slower, when pre-zeroing is fast.  "Unallocated blocks 
> need not be written" allows for optimizations, "unallocated blocks must 
> not be touched" does not.

"unallocated blocks may not be written" would be fine.

dme.
-- 
There is love in you.

