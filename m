Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A83C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9BD206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6uO4Qp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9BD206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj2yZ-0006KM-2G
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 11:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sameid@google.com>) id 1jj2xE-0005Cu-Jn
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 11:47:52 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:38805)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sameid@google.com>) id 1jj2xA-0002QM-Rs
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 11:47:50 -0400
Received: by mail-qt1-x841.google.com with SMTP id g62so2108239qtd.5
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZXy5rDV+/gBroVvYDAaZO9Q2vQ6kwiPA1LrDGQb03tY=;
 b=i6uO4Qp8sKb4YEc+rY3Ke1g0bXleJihL292v+FaZa/Fi2DTxXxEzc/JhTSao3XnZxB
 FQETd0GaDWRW/uKBF4FBJEPuZ5K9avTM0HXg5xe+JiZDwK84+CLuxATRBkjEEioIpkoU
 zXtVB9ooRYa1BwowLaDZ6T68VsChxIMhLsCg02M2+A/M/vpVX7WED5DDvm2D+DGlBPPU
 1AS7iDhhxmW4SQmo7/UX2UzX56hJOKUMY2Jrf2fZaeOUeJcbKg/vlz4B5wsSwP2Q5LKB
 9iLnvO5mI/qCmnkqBaNH0/QHitTpjpV0KWhblR3nOFV+Wjk3crQBM0Zowzw0sbHE1Li/
 maKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZXy5rDV+/gBroVvYDAaZO9Q2vQ6kwiPA1LrDGQb03tY=;
 b=t+dumjfEr/4PPslO8uPDB8wZht9jlwuSPEng0AavTrUR1MxEYhfk5TMpgJb4Zz+0xg
 p3PcbUlxbKrfQA5rv28DCApdug57VxKRXk+gbtNNxEpbP+1WwmaN+Gjxzzgyy6XhIJJN
 NiscqxtvWscN3yCOHtpUPHOh6c6uYNEaxRysWm/3XTv3/dTV0hNoYRv9XhvUV8r4yE81
 QGw4qzu/jjxl9K4qjkK9Mb0fmnnhR+1HDPzr1APmHH5OyfjGOPqyqyx+VqvcQImOnSlP
 quA04Z/lWCwp+CDvqGtDHa0t1WFE2AU6D+mk/oMzpolFf3xIpEKwVUe1wDROdP6acHM+
 ClUA==
X-Gm-Message-State: AOAM530MIygLA2D9eAqyDA4Gafo97DtsjtgxHEH++elpqXarztirnY1Z
 iA4o9ec02mmuE7i4zO1pmQ/ItO4bOMgFxHRDFWZGgA==
X-Google-Smtp-Source: ABdhPJzE2YZ4w7fXpBfaRISEkdjwYDvzGQkdumc8ZaaYCDXmapWoW7eukTqexeCLjMFd9pZn821cgUhkJlzXo2hzm14=
X-Received: by 2002:ac8:18b9:: with SMTP id s54mr3918803qtj.176.1591804061401; 
 Wed, 10 Jun 2020 08:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
 <m2imfz877v.fsf@dme.org>
 <CAFr6bUk5LrEL8BPXYkNOqj_jsbxHBfbj_NYryUjszMtG89L+2w@mail.gmail.com>
 <20200610140620.GE6947@linux.fritz.box>
 <CAFr6bU=aD=AXnoR-qSdQtQC690FYFqFsDRHHGxdUDkTh2ho1cA@mail.gmail.com>
 <CAFr6bUksp1Nm4nL69na5WDj6A5iXzwcc4K3=JNnyP4xZ+HKJHA@mail.gmail.com>
 <m2bllr7wrg.fsf@dme.org>
In-Reply-To: <m2bllr7wrg.fsf@dme.org>
From: Sam Eiderman <sameid@google.com>
Date: Wed, 10 Jun 2020 18:47:30 +0300
Message-ID: <CAFr6bU=ZU-3m1BP-Tnma+0jDbrD8Fqa6JboszNk5a3Ga0NJPFA@mail.gmail.com>
Subject: Re: Clarification regarding new qemu-img convert --target-is-zero flag
To: David Edmondson <dme@dme.org>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, eblake@redhat.com,
 Max Reitz <mreitz@redhat.com>, Tony Zhang <tzz@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=sameid@google.com; helo=mail-qt1-x841.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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

Ok great, thanks for making it clear.

On Wed, Jun 10, 2020 at 6:42 PM David Edmondson <dme@dme.org> wrote:
>
> On Wednesday, 2020-06-10 at 18:29:33 +03, Sam Eiderman wrote:
>
> > Excuse me,
> >
> > Vladimir already pointed out in the first comment that it will skip
> > writing real zeroes later.
>
> Right. That's why you want something like "--no-need-to-zero-initialise"
> (the name keeps getting longer!), which would still write zeroes to the
> blocks that should contain zeroes, as opposed to writing zeroes to
> prepare the device.
>
> > Sam
> >
> > On Wed, Jun 10, 2020 at 6:26 PM Sam Eiderman <sameid@google.com> wrote:
> >>
> >> Thanks for the clarification Kevin,
> >>
> >> Well first I want to discuss unallocated blocks.
> >> From my understanding operating systems do not rely on disks to be
> >> zero initialized, on the contrary, physical disks usually contain
> >> garbage.
> >> So an unallocated block should never be treated as zero by any real
> >> world application.
> >>
> >> Now assuming that I only care about the allocated content of the
> >> disks, I would like to save io/time zeroing out unallocated blocks.
> >>
> >> A real world example would be flushing a 500GB vmdk on a real SSD
> >> disk, if the vmdk contained only 2GB of data, no point in writing
> >> 498GB of zeroes to that SSD - reducing its lifespan for nothing.
> >>
> >> Now from what I understand --target-is-zero will give me this behavior
> >> even though that I really use it as a "--skip-prezeroing-target"
> >> (sorry for the bad name)
> >> (This is only true if later *allocated zeroes* are indeed copied correctly)
> >>
> >> Sam
> >>
> >> On Wed, Jun 10, 2020 at 5:06 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >> >
> >> > Am 10.06.2020 um 14:19 hat Sam Eiderman geschrieben:
> >> > > Thanks David,
> >> > >
> >> > > Yes, I imaging the following use case:
> >> > >
> >> > > disk.vmdk is a 50 GB disk that contains 12 MB binary of zeroes in its beginning.
> >> > > /dev/sda is a raw disk containing garbage
> >> > >
> >> > > I invoke:
> >> > > qemu-img convert disk.vmdk -O raw /dev/sda
> >> > >
> >> > > Required output:
> >> > > The first 12 MB of /dev/sda contain zeros, the rest garbage, qemu-img
> >> > > finishes fast.
> >> > >
> >> > > Kevin, from what I understood from you, this is the default behavior.
> >> >
> >> > Sorry, I misunderstood what you want. qemu-img will write zeros to all
> >> > unallocated parts, too. If it didn't do that, the resulting image on
> >> > /dev/sda wouldn't be a copy of disk.vmdk.
> >> >
> >> > As the metadata (which blocks are allocated) cannot be preserved in raw
> >> > images, you wouldn't be able to tell which part of the image contains
> >> > valid data and which part needs to be interpreted as zeros even though
> >> > it contains random garbage.
> >> >
> >> > What is your use case for this result where the actual virtual disk
> >> > content is mixed with garbage?
> >> >
> >> > Kevin
> >> >
>
> dme.
> --
> He caught a fleeting glimpse of a man, moving uphill pursued by a bus.

