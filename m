Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995E6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6303E206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="dzt9HczA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6303E206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj38E-0001OR-Ku
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 11:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1jj36u-0008Mr-TB
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 11:57:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:38181)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1jj36q-0005nO-S6
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 11:57:52 -0400
Received: by mail-wm1-x332.google.com with SMTP id f185so2307098wmf.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=4iHLLkaTMw+Fs7Tw3i/Ez9jjSoP1kgzn2esxGEAE0/M=;
 b=dzt9HczAPIZW+kfU7QRkt/ZxbbbXZuAxnE/gApJRiHeRVIbeI5lthWmkDu54zIfdIv
 eQ4zG47Wt5vOHxHDkU+/DKo0TPn+XRVnvuRTI+/NNmFFzgwkK0nJ41fG8rBKdd207Uns
 iLav7Ehgkjvf/JUWHEiWFP4JAf/xMKHHZLcJsb3xXEyqrvNQvzjpPIRNYAuruKGp05Q6
 17ZnbHefgd3LI0qaOBs4TvPusy+lqtlSGMdzit8BSD03KjjAWsYRCa0CMoIyPK0toIRt
 0a6zfZclhW8L9iPqSxU6Gl7do03AHMVvKRmWDkgNXHwAH9M+CT7PPZnlgzqm4nzyqOLM
 wXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=4iHLLkaTMw+Fs7Tw3i/Ez9jjSoP1kgzn2esxGEAE0/M=;
 b=Xv3OII3Y04XdIyQQ02z2cRYATpaFxfXdKrSNQkGFDrQaJcNz8ynP3aCuKHzhg0n9TT
 sugiPgggWDmjSsNr70ff27nfOgQtkB+AN+necAqtP6xUYWp1H8UJzqK2NN1lCrOa/3Sx
 hiExgsjuRblmJJhG9MhHyaXAK2Dj2xIXC7jalC8i7tq1lBIJ5k979cr2lGxpOJL055k4
 BGj2ewLvTekJzpvsZ92zorwRWidV1p15MynxldjlNFDVTb0pHQBMqafIIDXl8w6UXDB8
 QwHWYZbnyrhg6TqUQW4aMe3J3YnHfC+aWWDLVeT/iGGsOyuFOCPESG5VED9N/uUEwP8L
 /Pfw==
X-Gm-Message-State: AOAM531VLTDPT9ofmuEFHmaG/oDcUSdI15QZsDMZ4NUA5OBkKe6iRn0A
 YFeNggoiTp4KQCqhziz+i8mS9r2QxeDX7fvA
X-Google-Smtp-Source: ABdhPJyXBvaaQ4sGafET9iJQ6aDXPN0RPVjRme3q8NuLYaciya5OinmCDC0ABWJwwNJeOj06lIhyOg==
X-Received: by 2002:a1c:7517:: with SMTP id o23mr3722367wmc.7.1591804666952;
 Wed, 10 Jun 2020 08:57:46 -0700 (PDT)
Received: from disaster-area.hh.sledj.net (disaster-area.hh.sledj.net.
 [2001:8b0:bb71:7140:64::1])
 by smtp.gmail.com with ESMTPSA id p9sm140774wma.48.2020.06.10.08.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 08:57:46 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 82013950;
 Wed, 10 Jun 2020 15:57:45 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, Sam Eiderman <sameid@google.com>, Kevin
 Wolf <kwolf@redhat.com>
Subject: Re: Clarification regarding new qemu-img convert --target-is-zero flag
In-Reply-To: <999a1a74-d082-bcdb-e3f9-6c44b2526433@redhat.com>
References: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
 <m2imfz877v.fsf@dme.org>
 <CAFr6bUk5LrEL8BPXYkNOqj_jsbxHBfbj_NYryUjszMtG89L+2w@mail.gmail.com>
 <20200610140620.GE6947@linux.fritz.box>
 <CAFr6bU=aD=AXnoR-qSdQtQC690FYFqFsDRHHGxdUDkTh2ho1cA@mail.gmail.com>
 <CAFr6bUksp1Nm4nL69na5WDj6A5iXzwcc4K3=JNnyP4xZ+HKJHA@mail.gmail.com>
 <m2bllr7wrg.fsf@dme.org> <999a1a74-d082-bcdb-e3f9-6c44b2526433@redhat.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Wed, 10 Jun 2020 16:57:45 +0100
Message-ID: <m28sgu9ame.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::332;
 envelope-from=dme@dme.org; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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

On Wednesday, 2020-06-10 at 10:48:52 -05, Eric Blake wrote:

> On 6/10/20 10:42 AM, David Edmondson wrote:
>> On Wednesday, 2020-06-10 at 18:29:33 +03, Sam Eiderman wrote:
>> 
>>> Excuse me,
>>>
>>> Vladimir already pointed out in the first comment that it will skip
>>> writing real zeroes later.
>> 
>> Right. That's why you want something like "--no-need-to-zero-initialise"
>> (the name keeps getting longer!), which would still write zeroes to the
>> blocks that should contain zeroes, as opposed to writing zeroes to
>> prepare the device.
>
> Or maybe something like:
>
> qemu-img convert --skip-unallocated

This seems fine.

> which says that a pre-zeroing pass may be attempted, but it if fails, 

This bit puzzles me. In what circumstances might we attempt but fail?
Does it really mean "if it can be done instantly, it will be done, but
not if it costs something"?

I'd be more inclined to go for "unallocated blocks will not be written",
without any attempts to pre-zero.

> only the explicit zeroes need to be written rather than zeroes for all
> unallocated areas in the source (so the resulting image will NOT be an
> identical copy if there were any unallocated areas, but that the user
> is okay with that).

dme.
-- 
Too much information, running through my brain.

