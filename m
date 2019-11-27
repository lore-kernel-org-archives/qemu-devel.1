Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33980C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FF0205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK1Yuqwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FF0205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia3TO-0004yK-7j
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 14:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ia3SO-0004Up-6c
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ia3SL-0005qR-Va
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:58:35 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37657)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ia3SD-0005XC-4E; Wed, 27 Nov 2019 14:58:27 -0500
Received: by mail-oi1-x244.google.com with SMTP id 128so13152412oih.4;
 Wed, 27 Nov 2019 11:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Iw9Ff9dmklpcip4VKFMBIaY65CCA8wLqZxVHwXtpmis=;
 b=aK1YuqwlipxEdJegY0AAQLOqm1+uPU+3p7lUhOc8J/vuHpazmA/rXoxx7itH7ATr7i
 NMNzAw3ACuoKdNiO3S3z8zHmo0NLDYsipzGzV8e9pDrLlq1FAZ3vGkp+thbAk4r7mbsS
 12ZzNRxEIPzfsbiczLKQ0hX2IngbLg9UuvK3AYvk5Iq7oS1DuDysXgLuWtTpCVVw2CTR
 ias6/dUjh0/aNke2qtZDAvGyXuOAH4xQfjxMeHhjh6JW6IaQmwRSRXk2ymO8ad+Za8Hd
 DxtFlRq1El8KInmwo6jbDdgaQIyoSH9936Dk/ebKBp47gUt+Kc5GpxgD+L2yhMGvCzjG
 XyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Iw9Ff9dmklpcip4VKFMBIaY65CCA8wLqZxVHwXtpmis=;
 b=kyE2mS74vALBksnhFXBGddksT+myt02wZuX1QLIAOx3lWAudEIztg/oTJsnJ8z6cl/
 lgU9mnOnKi7c9q9g+WpZdcUDW9cuPB6f9krbkQwsVJjDR2Dal+o/QgoP1FzP8kYSs83e
 g5CA2inoWhgtRvfUaKkUvtUvKvonkMx7aWPIYLN0Wg7rLA5M5Ivb7Ctgo5F3LEgFz+Az
 7L4J4tes3+ZoGmXSi/w7eJVuk4/4d2VsMtY1Y9dirkLktv7nCRbLzo/8d9vglBuMxb7T
 qOHLpzrGPvdwUp6dcOOFk/J3DKNTMxwwdVZG18QDsDL8WSZLYR7YTzydMQe+clIoWTy9
 QBXw==
X-Gm-Message-State: APjAAAWKQNzVqdYwied5ZTuZGvN0v1e6jgzORw9yGijTeh5dCfHxpbid
 koF2mqQadns9xCFlC4Fc8fPoBePsdyZPxFK4sGk=
X-Google-Smtp-Source: APXvYqyRvSLKdRx96UJOQFhiCly2LqmnY0OFbb2PyyNqiAKdmcL/0yXrIshrXKJkjwoqzEH7VlYN/06CXS6sXV+1w9Y=
X-Received: by 2002:aca:d17:: with SMTP id 23mr5660527oin.136.1574884698830;
 Wed, 27 Nov 2019 11:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20191126154848.193407-1-vsementsov@virtuozzo.com>
In-Reply-To: <20191126154848.193407-1-vsementsov@virtuozzo.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 27 Nov 2019 20:58:07 +0100
Message-ID: <CAL1e-=ixsfP5tYb0MHf1qLTR=4qLJO4hjjHtyU==Sdk0TcE7hg@mail.gmail.com>
Subject: Re: [PATCH for-5.0 v2 0/3] benchmark util
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "open list:bochs" <qemu-block@nongnu.org>, stefanha@gmail.com,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 26, 2019 at 4:49 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> Hi all!
>
> Here is simple benchmarking utility, to generate performance
> comparison tables, like the following:
>
> ----------  -------------  -------------  -------------
>             backup-1       backup-2       mirror
> ssd -> ssd  0.43 +- 0.00   4.48 +- 0.06   4.38 +- 0.02
> ssd -> hdd  10.60 +- 0.08  10.69 +- 0.18  10.57 +- 0.05
> ssd -> nbd  33.81 +- 0.37  10.67 +- 0.17  10.07 +- 0.07
> ----------  -------------  -------------  -------------
>
> This is a v2, as v1 was inside
>  "[RFC 00/24] backup performance: block_status + async"
>
> I'll use this benchmark in other series, hope someone
> will like it.
>

Vladimir,

I really like this idea, even though I am interested in benchmarks of
different nature. Certainly a beautiful and handy tool for doing
detection of performance regressions (and also confirmation of
performance optimizations).

Did you run the tool on the previous QEMU versions, to detect change
in numbers between QEMU versions? Do you have the results of the same
benchmark for QEMU 2.12, 3.0, 4.0,... ?

What are units used in the table? Seconds, minutes? Hopefully, not hours?

Yours,
Aleksandar

> Vladimir Sementsov-Ogievskiy (3):
>   python: add simplebench.py
>   python: add qemu/bench_block_job.py
>   python: add example usage of simplebench
>
>  python/bench-example.py        |  80 +++++++++++++++++++++
>  python/qemu/bench_block_job.py | 115 +++++++++++++++++++++++++++++
>  python/simplebench.py          | 128 +++++++++++++++++++++++++++++++++
>  3 files changed, 323 insertions(+)
>  create mode 100644 python/bench-example.py
>  create mode 100755 python/qemu/bench_block_job.py
>  create mode 100644 python/simplebench.py
>
> --
> 2.18.0
>
>

