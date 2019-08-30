Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780ACC3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 20:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF072342E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 20:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF072342E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3nTc-000803-HF
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 16:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1i3nSg-0007SF-C4
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 16:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1i3nSe-0008O9-2O
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 16:25:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41018)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1i3nSd-0008N5-PX
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 16:25:31 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CDC017FDFE
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 20:25:29 +0000 (UTC)
Received: by mail-ot1-f72.google.com with SMTP id 88so4246022otc.19
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 13:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a7t4aHBdzRQNpUgFHDq8jbLVjCDsn+l6RX6QWoTWTzY=;
 b=cDymYIgKnuSmGvsvpY1LV0kwviuegH1/uBRcg4W8ajSxc9nE123eeJM+dkadA682En
 bz8pey9UhcVSadU7cGcyruO2x/73GauNLfOcPvlDEFXm0F9tLEvhOE1SAJU2eQs9Orio
 sx5ZrP41zZQfC9/YBbI9xfFswxRpKiJt1rFUB3HZOV7i8MOjTONSOkbutJaKZV5+Yejw
 X3DGqCGQvjXe3JIAaW2ZFIBfi8jYUOnT33YkQIW1WTEmob2zgKSv7qm5viUIiwj+1Vzd
 jDoAHbslbbJ5S8uDjoNtmYzHIwvLatSE0SPEefDsRcRHwlDHBvIW42eiuDjdmU6Jhb30
 n0jg==
X-Gm-Message-State: APjAAAXWkZGlyIqsUCJyUKgHrN1nx3669knYwqV5SGzwth7BPsCAZq71
 ytJ0A3mC+zauzG+vdoxwlz00SnBMf9nwGStFBymoQUB/4lk315q/G6v2eMcfPralIMcj0FYBQwK
 WqbX/y4r53Mc1I2QpVpf3CFLPuyjozF0=
X-Received: by 2002:a9d:77c4:: with SMTP id w4mr13999317otl.40.1567196729256; 
 Fri, 30 Aug 2019 13:25:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz2BB6Vpd1u0gKfNcmc0jJxGhxS/2Lr5CgYgtB9itNwQW2ggQA+kzCGtp4GEQy2ZGCVmVmqhT51pqZH/OfHvdc=
X-Received: by 2002:a9d:77c4:: with SMTP id w4mr13999298otl.40.1567196728962; 
 Fri, 30 Aug 2019 13:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190827185913.27427-1-nsoffer@redhat.com>
 <f75165f2-7b48-560e-13aa-059fdb00a1c0@redhat.com>
In-Reply-To: <f75165f2-7b48-560e-13aa-059fdb00a1c0@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Fri, 30 Aug 2019 23:25:18 +0300
Message-ID: <CAMRbyyvLAom+RD_VVyqvFPFJz8LkTeQZjN4T8qeHxTvdXANU7w@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nir Soffer <nirsof@gmail.com>, qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 28, 2019 at 11:14 PM John Snow <jsnow@redhat.com> wrote:

>
>
> On 8/27/19 2:59 PM, Nir Soffer wrote:
> > While working on 4k support, I noticed that there is lot of code using
> > BDRV_SECTOR_SIZE (512) for checking alignment. I wonder how this can
> work with
> > 4k storage.
> >
> > Lets start by cleaning up to make the code easier to understand:
> > - Use QEMU_IS_ALIGNED macro to check alignment
> > - Remove unneeded masks based on BDRV_SECTOR_SIZE
> >
> > Nir Soffer (2):
> >   block: Use QEMU_IS_ALIGNED
> >   block: Remove unused masks
> >
> >  block/bochs.c         | 4 ++--
> >  block/cloop.c         | 4 ++--
> >  block/dmg.c           | 4 ++--
> >  block/io.c            | 8 ++++----
> >  block/qcow2-cluster.c | 4 ++--
> >  block/qcow2.c         | 4 ++--
> >  block/vvfat.c         | 8 ++++----
> >  include/block/block.h | 2 --
> >  migration/block.c     | 2 +-
> >  qemu-img.c            | 2 +-
> >  10 files changed, 20 insertions(+), 22 deletions(-)
> >
>
> V2 changelog?


> (Looks like adding patch 2 as a result of changing away users from the
> BDRV_SECTOR_MASK.)
>

Right.

Changes since v1:
- Replace usage of BDRV_SECTOR_MASK in qcow2-cluster.c (Max)
- Remove unused masks

v1 was here:
https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00875.html


> Reviewed-by: John Snow <jsnow@redhat.com>


Thanks!
