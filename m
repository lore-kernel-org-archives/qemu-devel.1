Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5FEC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA2D207BC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qnufvqoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA2D207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKHRb-0008Ga-BY
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kKHPT-00060D-P9
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:42:55 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:39817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kKHPR-000415-SP
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:42:55 -0400
Received: by mail-pj1-x102b.google.com with SMTP id v14so6764842pjd.4
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 01:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5NtaKEO/a3oN1/+TjZG82aOyq75NUbquYfSOeRKXfR0=;
 b=Qnufvqoej0YxOmnZy3i102b/GQjOYZRxBOiG64+ktCy5CNE4lDlg7SlIDVqXrdmAKm
 9Myjkupa2VcmDeUkrAgOIVp8KWyefJDoNqyXVfUM/YNsPHXYpRTWh0hk7bTR9q+gbJDI
 UITKZsZJ9UaU/8qNQhHQIkBVb/4Qdu8jEqacGsJoUbLspdi3avaTFuHxcU+c2c03nitu
 HEwUcrc4pAKWAkZL4KlyXUOTFVWWdCXGP6/gcD8Q7DOqsXzChH1bR2PfJ+xD74X0bO26
 ycm1p5qsWmuaCPmyMpSFzhqUqAl0Tf2FeaIiza8WIg0Bvv/3OsIBN6w27loXMn8U9UGh
 2/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5NtaKEO/a3oN1/+TjZG82aOyq75NUbquYfSOeRKXfR0=;
 b=ET7Yz/GAPB75mVyeMNF9D5XFImgqRgt3Vlkn88smbuXRohuSb1J4G/d6EESp+tCS8y
 LQEHJVFXveDh2sAi9b7usMX9NklK2XulkHVkwO5oUVUK3Na9GNtySiFroKt7aMJjjWv+
 voapQsxFXMg+++tJwfP3ZEu9k1oAdXDERSVMuXFbef8zQd1sAXiJaarEL1EpcYt0tExN
 Gr0vID0khj8Hkt7tb57OsfA/wGueYTNDHzodI6K3CsrSYxBFV9s6ciJXSyQYyOlxYUTV
 TqHZcIfWxLqJ9c5oHU8YuNQ7vro2Ewh6MNyHYg5VIESYoweOyC6SlfIdgBevrlIEcZJh
 XlbA==
X-Gm-Message-State: AOAM532JsnUug2SNfGx2dqBJYgtMenP1S4RPOpx4thrVao5SqhFrACIS
 oT5lTmoJANQmV8HW+uplbVF9R78qNOT/1hBhv0zXrB3FTRE=
X-Google-Smtp-Source: ABdhPJyJpOR4mgPNAz32kBklzhIQST44HKLsrg/BIhkAfdaKyFKPLOqdHWZ9T/nC/X8QLLXuZ1RmNiEtV9YPKXl5wTc=
X-Received: by 2002:a17:90b:1916:: with SMTP id
 mp22mr22351811pjb.132.1600677772013; 
 Mon, 21 Sep 2020 01:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200824134431.GA35623@stefanha-x1.localdomain>
 <CAJSP0QW3xniHzHS=_Ok1D-NuAViHUShCxYs38YDo-YjUxC_+ZA@mail.gmail.com>
 <709da6a3-d158-270b-fb63-43ef65dfe668@virtuozzo.com>
 <dd5d6d0f-cc52-d3d5-0bbc-c57dcfef6842@virtuozzo.com>
 <CAJSP0QVRMzw5AAJEPpOChyFK4hUuEe1VE909QvYb6HQGOV_8XA@mail.gmail.com>
 <ec0e4c0b-9570-de7c-66fd-5cb4085ab075@virtuozzo.com>
In-Reply-To: <ec0e4c0b-9570-de7c-66fd-5cb4085ab075@virtuozzo.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 21 Sep 2020 09:42:40 +0100
Message-ID: <CAJSP0QWQ_-9OPLiqS1xx1t3yt-U=D15xur4JV-Uf6wbYnR+pvA@mail.gmail.com>
Subject: Re: QEMU 5.0 virtio-blk performance regression with high queue depths
To: "Denis V. Lunev" <den@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=stefanha@gmail.com; helo=mail-pj1-x102b.google.com
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

On Fri, Sep 18, 2020 at 10:59 AM Denis V. Lunev <den@virtuozzo.com> wrote:
> On 9/17/20 3:41 PM, Stefan Hajnoczi wrote:
> > On Wed, Sep 16, 2020 at 5:43 PM Denis V. Lunev <den@virtuozzo.com> wrote:
> >> On 9/16/20 5:07 PM, Denis V. Lunev wrote:
> >>> I will make a check today.
> >>>
> >>> Talking about our performance measurements, we have not
> >>> seen ANY performance degradation, especially 30-40%.
> >>> This looking quite strange to me.
> >>>
> >>> Though there is quite important difference. We are always
> >>> using O_DIRECT and 'native' AIO engine.
> >>>
> >>> Den
> >> I have put my hands into this and it looks like you are right. There is
> >> a difference. It is not as significant for me as in your case, but I observe
> >> stable around 10% difference with 128 vs 256 queue size.
> >>
> >> I have checked with:
> >> - QEMU 5.1
> >> - Fedora 31 in guest
> >> - qcow2 (64k, 1Mb) and raw image on host
> >> - nocache and both threaded/native IO modes
> >>
> >> The test was run on Thinkpad Carbon X1 gen 6 laptop.
> >>
> >> For the reference, I have seen 330k IOPS for read
> >> at max which is looking awesome for native and 220k
> >> IOPS for threads.
> > Thanks for confirming! Reverting the commit is unattractive since it
> > does improve performance in some cases.
> >
> > It would be good to understand the root cause so the regression can be
> > fixed without reducing queue-size again.
> >
> > Do you have time to investigate?
> I will make a try next week.

Thanks!

Stefan

