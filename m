Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B705C2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1EED21582
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJCwUVoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EED21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kItHN-0007VE-LA
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 08:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kItEN-0003rV-MX
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:41:44 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:38334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kItEK-0005wi-DW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:41:43 -0400
Received: by mail-pf1-x431.google.com with SMTP id l126so1141404pfd.5
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 05:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2OdJQRLcdOum/QgVtr/P1Vx3YmopOHbavwZGRPWAftY=;
 b=rJCwUVoRuLNCbzr1KEP5QVECzw9BVWCXL8ciUkI1TBd/7M/c2bPHHtkmHZy3lXXs46
 XCew32pMks8tUIcL71VxE/28Zz0Z1n79ACsS2WASSylHiFcGHvxQRq9c1Pb98bHMsMEs
 abEcg1j0Wtpa/vMI1T45ssA9Kg5frBeGg61/3TX+n0XFByV2DQjF/HUhlVlDQaGzvTWS
 2nRcjIJW45xJf+/dXjx74KWv20LcCtPqltSgcgXyCDTeGnUUiC2ncQ1EmJOS+SV5Dua0
 rIfwlHKcr+SjuPj23vYU1gKvIIDBJXXsO1w9ilBOV3kkUKI/SoWc77Gd1ypSwzjFwV6P
 rrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2OdJQRLcdOum/QgVtr/P1Vx3YmopOHbavwZGRPWAftY=;
 b=XYBpjzWncthM18EdQ/2c6qQcT6W+s3gEQo+sXQEjy2KcJ2HEc4cdBbgDTuPsGfxWVf
 jI9mdew/VU3jy8qsTi3SPCc1kwDZuXeEXWVTQvGnGVkf96v+ien/vsSsh9Hi/wkxVeOj
 pZxQYnzKOVY+FOJiI2aeceXxeRd8jQbbSrvohl7CO3gJy4NgwheKTNL/IMh4IjJGMjui
 SEC/twAV0W0cLvZzws/wqcNelvFxPids2UZDKkmsnRj5A8W3CCob3e/4zGbHMeWHoeGC
 f0rkywMOat/T5kSPF9GI6vLge3ARhgUIF25cANbANa+K2ekn76HZDKmgMT3nITkgBLTK
 za9Q==
X-Gm-Message-State: AOAM532Og3w9vDJz8s0qHVn0Ghyatz8nGbhoECm0sf2q1wB+tgnXOkvc
 OiBos+PKEIZutwfUqwSB6zzJr2sSFBXn4vL2jsB0P5l+qt8=
X-Google-Smtp-Source: ABdhPJwxTnBu5K2lZGsDWA49dRqz3zdX1eLtixQmO5zEnRPDQAEqItICqQoSnbjSwet1O2AWlsBYTVVBlx9VgcGaoGA=
X-Received: by 2002:a63:6346:: with SMTP id x67mr22721848pgb.121.1600346497434; 
 Thu, 17 Sep 2020 05:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200824134431.GA35623@stefanha-x1.localdomain>
 <CAJSP0QW3xniHzHS=_Ok1D-NuAViHUShCxYs38YDo-YjUxC_+ZA@mail.gmail.com>
 <709da6a3-d158-270b-fb63-43ef65dfe668@virtuozzo.com>
 <dd5d6d0f-cc52-d3d5-0bbc-c57dcfef6842@virtuozzo.com>
In-Reply-To: <dd5d6d0f-cc52-d3d5-0bbc-c57dcfef6842@virtuozzo.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 17 Sep 2020 13:41:26 +0100
Message-ID: <CAJSP0QVRMzw5AAJEPpOChyFK4hUuEe1VE909QvYb6HQGOV_8XA@mail.gmail.com>
Subject: Re: QEMU 5.0 virtio-blk performance regression with high queue depths
To: "Denis V. Lunev" <den@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=stefanha@gmail.com; helo=mail-pf1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 16, 2020 at 5:43 PM Denis V. Lunev <den@virtuozzo.com> wrote:
> On 9/16/20 5:07 PM, Denis V. Lunev wrote:
> > I will make a check today.
> >
> > Talking about our performance measurements, we have not
> > seen ANY performance degradation, especially 30-40%.
> > This looking quite strange to me.
> >
> > Though there is quite important difference. We are always
> > using O_DIRECT and 'native' AIO engine.
> >
> > Den
>
> I have put my hands into this and it looks like you are right. There is
> a difference. It is not as significant for me as in your case, but I observe
> stable around 10% difference with 128 vs 256 queue size.
>
> I have checked with:
> - QEMU 5.1
> - Fedora 31 in guest
> - qcow2 (64k, 1Mb) and raw image on host
> - nocache and both threaded/native IO modes
>
> The test was run on Thinkpad Carbon X1 gen 6 laptop.
>
> For the reference, I have seen 330k IOPS for read
> at max which is looking awesome for native and 220k
> IOPS for threads.

Thanks for confirming! Reverting the commit is unattractive since it
does improve performance in some cases.

It would be good to understand the root cause so the regression can be
fixed without reducing queue-size again.

Do you have time to investigate?

Thanks,
Stefan

