Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599D3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E4720790
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mklLPzqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E4720790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYBKQ-0003WO-9a
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 13:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kYBJC-00032R-6b
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:01:54 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35]:37825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kYBJA-0001Ss-Dd
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:01:53 -0400
Received: by mail-io1-xd35.google.com with SMTP id q25so4309148ioh.4
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C+AoPG30kRGKndq9JQZzE2TVj54ETVc8nDZzZ+rtfzM=;
 b=mklLPzqsuUhi9Fl7cTF9DrECPR1s+AEea+gxHOsDhwh1zIADBhm/U5Jcws/+0T5WVF
 669VjVsvXd9713aKkF7PWj/qeEijTFMh5R0BRL+RieOFCZz+MlYxDCgwzzx0kT9stlA0
 0qtkI51S11l87x7zOmMVoBXehFlh7LykVVfe0I3TMT0D27DGu82j3yuDhr8ILTkMcioT
 qrkIngFkkp/Aqb4t4cjERd9mENhd0kRzM/nFZdNrC+Fok2MoMojedOzi0H/CyULNVyHO
 hGkdQwhvZseVzqG3xRbHLs+2WuB823f1u7aTJkG8KZv78tNQy3/gOVxM0/EI+hpqv9VB
 xavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C+AoPG30kRGKndq9JQZzE2TVj54ETVc8nDZzZ+rtfzM=;
 b=MlKeCQ+pYcA1jT/yZd/nbhWm/hLx9n/IMX8VwnHntoXXVtzUB+jludT/XuPjdAXY9/
 bOHHaqtIKtea57E4ZA91O+p+iIB/3KhWkPJzCD+sVRSCZAVc+W9zbl1pcw5/LP6RDQYy
 3suSo5z4duobUUWzc1NVCHDRDCPsJK6ys4EWIgsw5l71d8dIupPWoCtesLYVuYFwMQFq
 NFB3R6Ces32y/YQE7VYDIgmKZsUEGmdkms/v0NSpWlWOJcsYUTe5JwMVJMPNHfaxAJ4L
 tHa4vDCwf5BYNNyVWChOwNAq+YsoPCZ9ThwmR2+hdWU5ErEhOXmOhbpst4hheQpexXri
 4lkA==
X-Gm-Message-State: AOAM533EwtKk0Tv7ZiI1w/1rNEXBd1X4TxNlRXpWJfo8PK0wE+wBgiJl
 kbYMihq+YfHnbgdAAbsoeIavNo1TW50ADermsu8=
X-Google-Smtp-Source: ABdhPJx3OvCqqlUqmMI5RD31ZC9EvP1phn8MVMF4bAkMiRPUa36jhPjuz6k++8g/EV9XmotdXXbtTz5JLQ7D7Z4BwI0=
X-Received: by 2002:a02:84c3:: with SMTP id f61mr4542771jai.8.1603990911078;
 Thu, 29 Oct 2020 10:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <bda4f471-8ed6-3832-29ac-279a6d3bb7cc@redhat.com>
 <20201029174114.47e2b351.cohuck@redhat.com>
In-Reply-To: <20201029174114.47e2b351.cohuck@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 Oct 2020 09:49:58 -0700
Message-ID: <CAKmqyKOY+5WcxUg3Rvq2t3vYWOHrHQdhcv8PkiqZX2zVMdqJ3Q@mail.gmail.com>
Subject: Re: Migrating to the gitlab issue tracker
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd35.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 29, 2020 at 9:41 AM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Thu, 29 Oct 2020 12:01:27 -0400
> John Snow <jsnow@redhat.com> wrote:
>
> > If you're in the CC list, it's because you are listed in MAINTAINERS.
>
> <cleared the cc: list except for qemu-devel :)>
>
> >
> > Paolo's QEMU keynote this morning mentioned the possible use of the
> > Gitlab issue tracker instead of using Launchpad.
> >
> > I'm quite fond of the gitlab issue tracker, I think it works quite well
> > and it has pretty good and uncomplicated API access to it in order to
> > customize your workflow if you'd really like to.
> >
> > In experimenting with my mirror on gitlab though, I was unable to find a
> > way to configure it to send issue tracker notifications to the email
> > list. A move to gitlab would likely mean, then:
> >
> > 1. The cessation of (automatic) issue tracker mails to the list
> > 2. The loss of the ability to update the issue tracker by replying to
> > said emails
> > 3. Anyone listed in MAINTAINERS would be expected to have a gitlab
> > account in order to interact with the issue tracker.
>
> The gitlab issue tracker is almost certainly is an improvement over
> launchpad (and I do have a gitlab account); but not being able to
> interact via email is at least annoying. I expect that not only
> maintainers will want to interact with bug reports?
>
> >
> > However, once you have a gitlab account, you DO gain the ability to
> > receive emails for issues; possibly only those tagged with labels that
> > you cared about -- giving a nice filtering mechanism to receive only
> > bugs you care about.
> >
> > Gitlab also does support individual accounts updating issues using a
> > generated personalized email address, so if the email workflow is
> > crucial to you, it is still available.
>
> You mean that I can update via email, provided it's an address
> associated with my account?
>
> >
> > I'm for it, or at least for beginning a pilot program where we
> > experiment with the idea for interested parties. I wanted to send up a
> > trial balloon to see how we were feeling about this.

I'm not sure if you want Acks, but it sounds good to me.

Alistair

> >
> > --js
>
>

