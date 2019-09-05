Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A616C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 08:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7002070C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 08:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7002070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5nPv-0004hL-D9
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 04:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1i5nOO-0003oP-Vb
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1i5nOJ-0005gr-4B
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:45:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1i5nOI-0005e7-2H
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:45:18 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 68751C059B80
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 08:45:15 +0000 (UTC)
Received: by mail-oi1-f197.google.com with SMTP id 18so752104oir.17
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 01:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2gGQQmYKdZZPvnDKpOgs+Cds1hFUPMvts3+Djjk9Frw=;
 b=al0XfgsaZmmbl817fNFWHfK+vRi0wdTfmSZ6Lslr5vubryuWmFReaAheEpvOM9SGBc
 lfM2OCcWIpA6jFMJayCydUKWgq9ZwkTeNsXL+rRzkYksX0IIE8UrZ3AWH/pFJSCj0Gv+
 pZ78DNL8HmVgl5YJ3hC5mjFaXNfCgF2Js1HjsnSgR9LtzVbUdHLEYO3FgfvT98GbFSAU
 tY8vTdLWNhdYZl29kKtEE6v7drphiP0E2AU0438Qaj4FBLDujgsU+q8n4dveFb8+ODcl
 bHZLFoafLrDge2o+ab/YQjHNmXebEY9UW/lP+plJ1lhkNEIOt0RUQ0bIxUURxqRBX0pX
 zOvQ==
X-Gm-Message-State: APjAAAUssIMzrcH60YXY9FhWCUv2/fz6YEXQq33k+TIgvHMVD3PKKkYI
 7ZafRWlYcSkrkK2H4wzVOI37qKwcD5+I1Qctuv6PP/y/BpzBYHmDu4gP5nn8i2KcIrwSXF4/xU4
 4zY0S+UMhnvVo+t9x3Z9FJdCnWJV8cZ0=
X-Received: by 2002:a9d:5cc4:: with SMTP id r4mr1597453oti.311.1567673114881; 
 Thu, 05 Sep 2019 01:45:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyHDiEf+Orsb5ZgxqgeLvSb+Df+o8kQExT/TO702n4knr1IS9nLhncRnQuI5wT7Ahhoz9WqQA2CrSaE34EsEZo=
X-Received: by 2002:a9d:5cc4:: with SMTP id r4mr1597437oti.311.1567673114644; 
 Thu, 05 Sep 2019 01:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190827185913.27427-1-nsoffer@redhat.com>
 <f75165f2-7b48-560e-13aa-059fdb00a1c0@redhat.com>
 <CAMRbyyvLAom+RD_VVyqvFPFJz8LkTeQZjN4T8qeHxTvdXANU7w@mail.gmail.com>
In-Reply-To: <CAMRbyyvLAom+RD_VVyqvFPFJz8LkTeQZjN4T8qeHxTvdXANU7w@mail.gmail.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 5 Sep 2019 11:45:03 +0300
Message-ID: <CAMRbyytuwqnnQGUQx38kxcb2c1SErSprccSiHF9tPbgUe66vKA@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/2] Alignment checks
 cleanup
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
Cc: Fam Zheng <fam@euphon.net>, Nir Soffer <nirsof@gmail.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max, can you review again?

On Fri, Aug 30, 2019 at 11:25 PM Nir Soffer <nsoffer@redhat.com> wrote:

> On Wed, Aug 28, 2019 at 11:14 PM John Snow <jsnow@redhat.com> wrote:
>
>>
>>
>> On 8/27/19 2:59 PM, Nir Soffer wrote:
>> > While working on 4k support, I noticed that there is lot of code using
>> > BDRV_SECTOR_SIZE (512) for checking alignment. I wonder how this can
>> work with
>> > 4k storage.
>> >
>> > Lets start by cleaning up to make the code easier to understand:
>> > - Use QEMU_IS_ALIGNED macro to check alignment
>> > - Remove unneeded masks based on BDRV_SECTOR_SIZE
>> >
>> > Nir Soffer (2):
>> >   block: Use QEMU_IS_ALIGNED
>> >   block: Remove unused masks
>> >
>> >  block/bochs.c         | 4 ++--
>> >  block/cloop.c         | 4 ++--
>> >  block/dmg.c           | 4 ++--
>> >  block/io.c            | 8 ++++----
>> >  block/qcow2-cluster.c | 4 ++--
>> >  block/qcow2.c         | 4 ++--
>> >  block/vvfat.c         | 8 ++++----
>> >  include/block/block.h | 2 --
>> >  migration/block.c     | 2 +-
>> >  qemu-img.c            | 2 +-
>> >  10 files changed, 20 insertions(+), 22 deletions(-)
>> >
>>
>> V2 changelog?
>
>
>> (Looks like adding patch 2 as a result of changing away users from the
>> BDRV_SECTOR_MASK.)
>>
>
> Right.
>
> Changes since v1:
> - Replace usage of BDRV_SECTOR_MASK in qcow2-cluster.c (Max)
> - Remove unused masks
>
> v1 was here:
> https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00875.html
>
>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>
>
> Thanks!
>
