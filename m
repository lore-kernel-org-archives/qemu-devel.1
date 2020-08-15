Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB5DC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3ABD23102
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFBjHLmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3ABD23102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6yaT-0004wG-Su
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jwsu1986@gmail.com>)
 id 1k6yZS-0004EL-Cl
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:58:14 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:41580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jwsu1986@gmail.com>)
 id 1k6yZQ-0000y5-FS
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:58:14 -0400
Received: by mail-oo1-xc41.google.com with SMTP id x6so2537567ooe.8
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0HvHiQb1V3eUFkfQxdrYwjGhgTwhAt664AGIbyX0pXg=;
 b=IFBjHLmUgkXhoBJPAXyqTvutblwzcvoqjcFoSgvK5t0ztIXyX2vzJ1Ve4wyZBeeE4j
 5r5iL0d2G4DIe6qDJtPBT341WaAl7u+GoPUxA4kVDXMtdWv7OP5RKhxOGVFPVTu42ELk
 Wb4kX6V6vsQivjFgJttpthqoz7mFt/5TPNZllNKY/wVVuLKDzy85KpCMP1pnh4YkqjH1
 KK2pJTxqTEJM/8P9uqHc5NpJzf9F77wkRnIx3R2VS1H5pIq94so2Nhoc7KIMbnESGkQ5
 guhTb3yonz0jOW0uv/XDxRdXqmxFrUlUWhsYJUz3b2tvqK8giZSdFvM7xii64B4jBkJW
 d7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0HvHiQb1V3eUFkfQxdrYwjGhgTwhAt664AGIbyX0pXg=;
 b=jBkAQ0kVGcCj5TnXGVRG7QWBUmaXSUWcKHMLqUbkjAmbwkHR7Y9CU1+95//8hVcTx3
 gUgUDeSReFB7wzaBO9b/TiS6eiL8bnQ13VEEieySGYj86OYqDN6MDkIt1MmViRwkLNiO
 G/LL90qFYWX46lYeuWJXR/6oT1HXDi+1rjaTkZkdn6xN+c5B+gpAW6d3VCT/itLHW7TP
 jmpAINv9rzqJ65/CFr/bi3AKHhmMZ2shbdc/tOXkq+o7kj1xGzjQWjoUmB13KUHqIOEP
 3/GSDzbunZzA8LDlKQL7SMYM3f0Kt+nV+3Ad+wZjoCjNtiuyPmnLI5i4L0qF1/+agBYs
 nd9A==
X-Gm-Message-State: AOAM533e5DTjkttsdaAsDFUjkuWeaEtED8iCOcZY2qcUejWVBwbvP4of
 3U6yK/eJFVZDJt9mOr19kt/axkVE6+cajBrIK6baVzAnVMx4cK9P
X-Google-Smtp-Source: ABdhPJznHnCNsDSC+BQXmIOzj+K3avcY+kBPcV+gmlaQ+woJF1vENWNO42/MyCjQcW9NzFi5ggcT3WUmqXgIyrm4dpA=
X-Received: by 2002:a25:cc50:: with SMTP id l77mr7873161ybf.84.1597459570435; 
 Fri, 14 Aug 2020 19:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200621021004.5559-1-dereksu@qnap.com>
 <20200731094940.7a26e583@luklap>
 <CAFKS8hWT1ieRkZcV4Q1ReC4X2wAXKteWB1VkEB7NesT2T-s_Kg@mail.gmail.com>
 <d42f662dc48c4e42b6bf687563bfc3c9@huawei.com>
In-Reply-To: <d42f662dc48c4e42b6bf687563bfc3c9@huawei.com>
From: Derek Su <jwsu1986@gmail.com>
Date: Sat, 15 Aug 2020 10:45:59 +0800
Message-ID: <CAFKS8hX7qqjUqCf-F8bKmiLnu21j7SdAaCDe=BZM+4y+aXZgCw@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] COLO: migrate dirty ram pages before colo
 checkpoint
To: Zhanghailiang <zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=jwsu1986@gmail.com; helo=mail-oo1-xc41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Lukas Straub <lukasstraub2@web.de>, "chyang@qnap.com" <chyang@qnap.com>,
 "quintela@redhat.com" <quintela@redhat.com>, Derek Su <dereksu@qnap.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ctcheng@qnap.com" <ctcheng@qnap.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 15, 2020 at 9:42 AM Zhanghailiang
<zhang.zhanghailiang@huawei.com> wrote:
>
> > -----Original Message-----
> > From: Derek Su [mailto:jwsu1986@gmail.com]
> > Sent: Thursday, August 13, 2020 6:28 PM
> > To: Lukas Straub <lukasstraub2@web.de>
> > Cc: Derek Su <dereksu@qnap.com>; qemu-devel@nongnu.org; Zhanghailiang
> > <zhang.zhanghailiang@huawei.com>; chyang@qnap.com; quintela@redhat.com;
> > dgilbert@redhat.com; ctcheng@qnap.com
> > Subject: Re: [PATCH v1 0/1] COLO: migrate dirty ram pages before colo
> > checkpoint
> >
> > On Fri, Jul 31, 2020 at 3:52 PM Lukas Straub <lukasstraub2@web.de> wrote:
> > >
> > > On Sun, 21 Jun 2020 10:10:03 +0800
> > > Derek Su <dereksu@qnap.com> wrote:
> > >
> > > > This series is to reduce the guest's downtime during colo checkpoint
> > > > by migrating dirty ram pages as many as possible before colo checkpoint.
> > > >
> > > > If the iteration count reaches COLO_RAM_MIGRATE_ITERATION_MAX or ram
> > > > pending size is lower than 'x-colo-migrate-ram-threshold', stop the
> > > > ram migration and do colo checkpoint.
> > > >
> > > > Test environment:
> > > > The both primary VM and secondary VM has 1GiB ram and 10GbE NIC for
> > > > FT traffic.
> > > > One fio buffer write job runs on the guest.
> > > > The result shows the total primary VM downtime is decreased by ~40%.
> > > >
> > > > Please help to review it and suggestions are welcomed.
> > > > Thanks.
> > >
> > > Hello Derek,
> > > Sorry for the late reply.
> > > I think this is not a good idea, because it unnecessarily introduces a delay
> > between checkpoint request and the checkpoint itself and thus impairs network
> > bound workloads due to increased network latency. Workloads that are
> > independent from network don't cause many checkpoints anyway, so it doesn't
> > help there either.
> > >
> >
>
> Hi Derek,
>
> Actually, There is a quit interesting question we should think:
> What will happen if VM continues to run after detected a mismatched state between PVM and SVM,
> According to the rules of COLO, we should stop VMs immediately to sync the state between PVM and SVM,
> But here, you choose them to continue to run for a while, then there may be more client's network packages
> Coming, and may cause more memory pages dirty, another side effect is the new network packages will not
> Be sent out with high probability, because their replies should be different since the state between PVM and SVM is different.
>
> So, IMHO, it makes non-sense to let VMs to continue to run after detected them in different state.
> Besides, I don't think it is easy to construct this case in tests.
>
>
> Thanks,
> Hailiang
>

Hello, Hailiang

Thanks. I got your point.
In my tests, the mismatch between packets does not happen, so the
network latency does not increase.

By the way, I've tried your commit addressing this issue.
It is useful for low dirty memory and low dirty rate workload.

But in high "buffered IO read/write" workload, it results in PVM
resends massive and same dirty ram pages  every cycle triggered
by DEFAULT_RAM_PENDING_CHECK (default 1 second) timer, so hurt the IO
performance and without improvement of downtime?
Do you have any thoughts about this?

Is it possible to separate the checkpoint invoked by the periodic
timer and the packet mismatch and to use a different strategy
to cope with the long downtime issue?

Thanks.

Regards,
Derek

> s> Hello, Lukas & Zhanghailiang
> >
> > Thanks for your opinions.
> > I went through my patch, and I feel a little confused and would like to dig into it
> > more.
> >
> > In this patch, colo_migrate_ram_before_checkpoint() is before
> > COLO_MESSAGE_CHECKPOINT_REQUEST, so the SVM and PVM should not enter
> > the pause state.
> >
> > In the meanwhile, the packets to PVM/SVM can still be compared and notify
> > inconsistency if mismatched, right?
> > Is it possible to introduce extra network latency?
> >
> > In my test (randwrite to disk by fio with direct=0), the ping from another client to
> > the PVM  using generic colo and colo used this patch are below.
> > The network latency does not increase as my expectation.
> >
> > generic colo
> > ```
> > 64 bytes from 192.168.80.18: icmp_seq=87 ttl=64 time=28.109 ms
> > 64 bytes from 192.168.80.18: icmp_seq=88 ttl=64 time=16.747 ms
> > 64 bytes from 192.168.80.18: icmp_seq=89 ttl=64 time=2388.779 ms
> > <----checkpoint start
> > 64 bytes from 192.168.80.18: icmp_seq=90 ttl=64 time=1385.792 ms
> > 64 bytes from 192.168.80.18: icmp_seq=91 ttl=64 time=384.896 ms
> > <----checkpoint end
> > 64 bytes from 192.168.80.18: icmp_seq=92 ttl=64 time=3.895 ms
> > 64 bytes from 192.168.80.18: icmp_seq=93 ttl=64 time=1.020 ms
> > 64 bytes from 192.168.80.18: icmp_seq=94 ttl=64 time=0.865 ms
> > 64 bytes from 192.168.80.18: icmp_seq=95 ttl=64 time=0.854 ms
> > 64 bytes from 192.168.80.18: icmp_seq=96 ttl=64 time=28.359 ms
> > 64 bytes from 192.168.80.18: icmp_seq=97 ttl=64 time=12.309 ms
> > 64 bytes from 192.168.80.18: icmp_seq=98 ttl=64 time=0.870 ms
> > 64 bytes from 192.168.80.18: icmp_seq=99 ttl=64 time=2371.733 ms
> > 64 bytes from 192.168.80.18: icmp_seq=100 ttl=64 time=1371.440 ms
> > 64 bytes from 192.168.80.18: icmp_seq=101 ttl=64 time=366.414 ms
> > 64 bytes from 192.168.80.18: icmp_seq=102 ttl=64 time=0.818 ms
> > 64 bytes from 192.168.80.18: icmp_seq=103 ttl=64 time=0.997 ms ```
> >
> > colo used this patch
> > ```
> > 64 bytes from 192.168.80.18: icmp_seq=72 ttl=64 time=1.417 ms
> > 64 bytes from 192.168.80.18: icmp_seq=73 ttl=64 time=0.931 ms
> > 64 bytes from 192.168.80.18: icmp_seq=74 ttl=64 time=0.876 ms
> > 64 bytes from 192.168.80.18: icmp_seq=75 ttl=64 time=1184.034 ms
> > <----checkpoint start
> > 64 bytes from 192.168.80.18: icmp_seq=76 ttl=64 time=181.297 ms
> > <----checkpoint end
> > 64 bytes from 192.168.80.18: icmp_seq=77 ttl=64 time=0.865 ms
> > 64 bytes from 192.168.80.18: icmp_seq=78 ttl=64 time=0.858 ms
> > 64 bytes from 192.168.80.18: icmp_seq=79 ttl=64 time=1.247 ms
> > 64 bytes from 192.168.80.18: icmp_seq=80 ttl=64 time=0.946 ms
> > 64 bytes from 192.168.80.18: icmp_seq=81 ttl=64 time=0.855 ms
> > 64 bytes from 192.168.80.18: icmp_seq=82 ttl=64 time=0.868 ms
> > 64 bytes from 192.168.80.18: icmp_seq=83 ttl=64 time=0.749 ms
> > 64 bytes from 192.168.80.18: icmp_seq=84 ttl=64 time=2.154 ms
> > 64 bytes from 192.168.80.18: icmp_seq=85 ttl=64 time=1499.186 ms
> > 64 bytes from 192.168.80.18: icmp_seq=86 ttl=64 time=496.173 ms
> > 64 bytes from 192.168.80.18: icmp_seq=87 ttl=64 time=0.854 ms
> > 64 bytes from 192.168.80.18: icmp_seq=88 ttl=64 time=0.774 ms ```
> >
> > Thank you.
> >
> > Regards,
> > Derek
> >
> > > Hailang did have a patch to migrate ram between checkpoints, which should
> > help all workloads, but it wasn't merged back then. I think you can pick it up again,
> > rebase and address David's and Eric's comments:
> > > https://lore.kernel.org/qemu-devel/20200217012049.22988-3-zhang.zhangh
> > > ailiang@huawei.com/T/#u
> > >
> > > Hailang, are you ok with that?
> > >
> > > Regards,
> > > Lukas Straub

