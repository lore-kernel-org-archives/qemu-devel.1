Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1075BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C770B20768
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7OC7EaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C770B20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ATH-0007fy-1m
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jwsu1986@gmail.com>)
 id 1k6ASZ-0007Fq-J5
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:27:47 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:42377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jwsu1986@gmail.com>)
 id 1k6ASX-0006DI-Md
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:27:47 -0400
Received: by mail-yb1-xb43.google.com with SMTP id a34so3020409ybj.9
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kOlta3RtVWhJDmv6PKP0PlqBpkyEBT2kG0o2TcOR2l8=;
 b=U7OC7EaGl2RSNMQqxc3jvsLcMvguYHwFLPsK2f2T9cMty4WAmlNBIIMuLxinSwkC1n
 ieNAvTULglZfHFEVLW9rG7FLz/Be5Wn77Lna+WM54nczz/vZdDkV8LWqsEnUKf4WJgGt
 E9e0oG4Mbi8Wm59MgTmM18qRHS7iBS4fmYEWId2H4+H6BvvTZtfYoj4yCVzHEFVkolHA
 eGlQaceSLFhnMHSPwvK0nhZcQWWJQ8KL6qFaJ5igAwjLAdj1F6vHhf0iw7tQzeDUUNh9
 aBfxKdIyR8lPEcOQPuc8+VGyNKUReLGmn7TX8ZJOZitHRMMuOe6k93QllI1i2vYEk9An
 VoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kOlta3RtVWhJDmv6PKP0PlqBpkyEBT2kG0o2TcOR2l8=;
 b=ECxiVySn3QKMohSERYvBHvAUi0YF2QXvzZDtXIqNrQhqqHBbakpW8B+C1Km0c01fuM
 EtXAXfUyWGMGE8PndDmYLOCejCwa2z3UMOCPor+7nRLSS+Pirvs7JxIw9JYz/Wqndxuc
 sB0SV4J6pyzc5BT+D8u3OF+4xL1vEIZ88WnkiooqTKPslU1nqPjtc9fO5pgPqtVPSu66
 wttOYe1+h9sbqJXKZqmhU47ABqH1R1RLo146MWBNBic6DUsIcEKzj2/RNyJHfrnuCBCc
 CRMeQowV/O2y1VZ6OyKoCmmG7TVJi8Fd2WQoXb03lkXoIaD8HALcAPhtHB3cMyJfmki4
 8DwA==
X-Gm-Message-State: AOAM532adlH4+Q2JwV5wtMk/rgFu5FBV68nZRGLsue4ge81kMnaDEUjx
 2B9ZzllOyDoodrx1PZSBKLTPwzzamD1SQ+Qw0yQ=
X-Google-Smtp-Source: ABdhPJwDKn8z2yOv0JUqqt6wR4ED5tGshvsP1PrGVD/EOq7JE7FPu3+rqw4bKTWEi6U8pQvyJAGgnawyG4mzxBiYmSQ=
X-Received: by 2002:a25:fc22:: with SMTP id v34mr5395627ybd.393.1597314463158; 
 Thu, 13 Aug 2020 03:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200621021004.5559-1-dereksu@qnap.com>
 <20200731094940.7a26e583@luklap>
In-Reply-To: <20200731094940.7a26e583@luklap>
From: Derek Su <jwsu1986@gmail.com>
Date: Thu, 13 Aug 2020 18:27:32 +0800
Message-ID: <CAFKS8hWT1ieRkZcV4Q1ReC4X2wAXKteWB1VkEB7NesT2T-s_Kg@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] COLO: migrate dirty ram pages before colo
 checkpoint
To: Lukas Straub <lukasstraub2@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=jwsu1986@gmail.com; helo=mail-yb1-xb43.google.com
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
Cc: zhang.zhanghailiang@huawei.com, chyang@qnap.com, quintela@redhat.com,
 Derek Su <dereksu@qnap.com>, dgilbert@redhat.com, qemu-devel@nongnu.org,
 ctcheng@qnap.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 31, 2020 at 3:52 PM Lukas Straub <lukasstraub2@web.de> wrote:
>
> On Sun, 21 Jun 2020 10:10:03 +0800
> Derek Su <dereksu@qnap.com> wrote:
>
> > This series is to reduce the guest's downtime during colo checkpoint
> > by migrating dirty ram pages as many as possible before colo checkpoint=
.
> >
> > If the iteration count reaches COLO_RAM_MIGRATE_ITERATION_MAX or
> > ram pending size is lower than 'x-colo-migrate-ram-threshold',
> > stop the ram migration and do colo checkpoint.
> >
> > Test environment:
> > The both primary VM and secondary VM has 1GiB ram and 10GbE NIC
> > for FT traffic.
> > One fio buffer write job runs on the guest.
> > The result shows the total primary VM downtime is decreased by ~40%.
> >
> > Please help to review it and suggestions are welcomed.
> > Thanks.
>
> Hello Derek,
> Sorry for the late reply.
> I think this is not a good idea, because it unnecessarily introduces a de=
lay between checkpoint request and the checkpoint itself and thus impairs n=
etwork bound workloads due to increased network latency. Workloads that are=
 independent from network don't cause many checkpoints anyway, so it doesn'=
t help there either.
>

Hello, Lukas & Zhanghailiang

Thanks for your opinions.
I went through my patch, and I feel a little confused and would like
to dig into it more.

In this patch, colo_migrate_ram_before_checkpoint() is before
COLO_MESSAGE_CHECKPOINT_REQUEST,
so the SVM and PVM should not enter the pause state.

In the meanwhile, the packets to PVM/SVM can still be compared and
notify inconsistency if mismatched, right?
Is it possible to introduce extra network latency?

In my test (randwrite to disk by fio with direct=3D0),
the ping from another client to the PVM  using generic colo and colo
used this patch are below.
The network latency does not increase as my expectation.

generic colo
```
64 bytes from 192.168.80.18: icmp_seq=3D87 ttl=3D64 time=3D28.109 ms
64 bytes from 192.168.80.18: icmp_seq=3D88 ttl=3D64 time=3D16.747 ms
64 bytes from 192.168.80.18: icmp_seq=3D89 ttl=3D64 time=3D2388.779 ms
<----checkpoint start
64 bytes from 192.168.80.18: icmp_seq=3D90 ttl=3D64 time=3D1385.792 ms
64 bytes from 192.168.80.18: icmp_seq=3D91 ttl=3D64 time=3D384.896 ms
<----checkpoint end
64 bytes from 192.168.80.18: icmp_seq=3D92 ttl=3D64 time=3D3.895 ms
64 bytes from 192.168.80.18: icmp_seq=3D93 ttl=3D64 time=3D1.020 ms
64 bytes from 192.168.80.18: icmp_seq=3D94 ttl=3D64 time=3D0.865 ms
64 bytes from 192.168.80.18: icmp_seq=3D95 ttl=3D64 time=3D0.854 ms
64 bytes from 192.168.80.18: icmp_seq=3D96 ttl=3D64 time=3D28.359 ms
64 bytes from 192.168.80.18: icmp_seq=3D97 ttl=3D64 time=3D12.309 ms
64 bytes from 192.168.80.18: icmp_seq=3D98 ttl=3D64 time=3D0.870 ms
64 bytes from 192.168.80.18: icmp_seq=3D99 ttl=3D64 time=3D2371.733 ms
64 bytes from 192.168.80.18: icmp_seq=3D100 ttl=3D64 time=3D1371.440 ms
64 bytes from 192.168.80.18: icmp_seq=3D101 ttl=3D64 time=3D366.414 ms
64 bytes from 192.168.80.18: icmp_seq=3D102 ttl=3D64 time=3D0.818 ms
64 bytes from 192.168.80.18: icmp_seq=3D103 ttl=3D64 time=3D0.997 ms
```

colo used this patch
```
64 bytes from 192.168.80.18: icmp_seq=3D72 ttl=3D64 time=3D1.417 ms
64 bytes from 192.168.80.18: icmp_seq=3D73 ttl=3D64 time=3D0.931 ms
64 bytes from 192.168.80.18: icmp_seq=3D74 ttl=3D64 time=3D0.876 ms
64 bytes from 192.168.80.18: icmp_seq=3D75 ttl=3D64 time=3D1184.034 ms
<----checkpoint start
64 bytes from 192.168.80.18: icmp_seq=3D76 ttl=3D64 time=3D181.297 ms
<----checkpoint end
64 bytes from 192.168.80.18: icmp_seq=3D77 ttl=3D64 time=3D0.865 ms
64 bytes from 192.168.80.18: icmp_seq=3D78 ttl=3D64 time=3D0.858 ms
64 bytes from 192.168.80.18: icmp_seq=3D79 ttl=3D64 time=3D1.247 ms
64 bytes from 192.168.80.18: icmp_seq=3D80 ttl=3D64 time=3D0.946 ms
64 bytes from 192.168.80.18: icmp_seq=3D81 ttl=3D64 time=3D0.855 ms
64 bytes from 192.168.80.18: icmp_seq=3D82 ttl=3D64 time=3D0.868 ms
64 bytes from 192.168.80.18: icmp_seq=3D83 ttl=3D64 time=3D0.749 ms
64 bytes from 192.168.80.18: icmp_seq=3D84 ttl=3D64 time=3D2.154 ms
64 bytes from 192.168.80.18: icmp_seq=3D85 ttl=3D64 time=3D1499.186 ms
64 bytes from 192.168.80.18: icmp_seq=3D86 ttl=3D64 time=3D496.173 ms
64 bytes from 192.168.80.18: icmp_seq=3D87 ttl=3D64 time=3D0.854 ms
64 bytes from 192.168.80.18: icmp_seq=3D88 ttl=3D64 time=3D0.774 ms
```

Thank you.

Regards,
Derek

> Hailang did have a patch to migrate ram between checkpoints, which should=
 help all workloads, but it wasn't merged back then. I think you can pick i=
t up again, rebase and address David's and Eric's comments:
> https://lore.kernel.org/qemu-devel/20200217012049.22988-3-zhang.zhanghail=
iang@huawei.com/T/#u
>
> Hailang, are you ok with that?
>
> Regards,
> Lukas Straub

