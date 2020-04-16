Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822B1C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 18:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A73F2222D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 18:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzPh3SrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A73F2222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP9BB-0000IR-G4
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 14:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1jP99I-0006L1-Px
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 14:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1jP99G-00041p-Q3
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 14:22:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30548
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1jP99G-00041D-Ig
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 14:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587061321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=70alt/7B+24bnmtlAVFkzdPqViYaJh7M0VeENCRicXw=;
 b=fzPh3SrTGDUav4OovmRWwy/BjI7zgSlTa28bIZlXqq2EboVhGNBK70pfDl98yLM+VRSOwT
 qmUjJ/YrRZeqfwD/oNReDjoyqzpJMykYm7QrNKjLyeJH4wAr8K0us6MI+1UAwdqbXjRkka
 8n8MXR4RIxmOUEAexce293coAjKK3zw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-tBqapK32OJuAwDOg9bPK3w-1; Thu, 16 Apr 2020 14:20:40 -0400
X-MC-Unique: tBqapK32OJuAwDOg9bPK3w-1
Received: by mail-ot1-f72.google.com with SMTP id 22so2174874otg.7
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 11:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B6TPwGF0EGrZE8IelXtzU2VyQIFJTMj9QaAqWrqJP48=;
 b=AGLO8sDv65g5ZMMbAt+dJ4hcBe+YCkv0qsMrhNwsPHxm9uNbFp3/M+PDFGPX6QMziN
 YvcOLsVon+Yaz7mBGkIBliuEheTysp+l4qveYEhqVB+7CIlMwBHN11dInaQtYvc4Umzo
 FSF/1Fhx5W0hpxc5s6e80cPA52ogFH8iCi/yfTu+duq7svJzv1+RytcqLOIHUoFCgu60
 pbbYuqLvRgAdFPozWJ2v+91GYdmk5CYZjnCpilayNXrOPWgvl99bVGkEfqxuiTImOotx
 z1+qX5xwc+4WryY3vkOGHTqnohFU4N7D7tDc9trq89k1WJko1ocgM0e31w+xOStDT9uD
 IJiQ==
X-Gm-Message-State: AGi0Pua89UnBdqkAjGndLgMPcdgyE4g2cRF3ZmaXmgoLXIbYwfwM7J6v
 M7y6lFAJz3wIvD4NV3gDmbjYEj994mM1y3wUDHfjXYoD7qkredfBwLYaic1hh+Q9v0n6ZuC6pqq
 nNNbq7KsvCt+U7g3yBYMcHfoj3Ud64Mg=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr3690080oih.156.1587061239107; 
 Thu, 16 Apr 2020 11:20:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypKXh/eH9h9WgxhIgenWorF4nmNVkyyl1cd47ipFOAO9ScioAvX+CKidL7oE+1KPPGFW2hsKfPS3+leB+uoEpIQ=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr3690059oih.156.1587061238751; 
 Thu, 16 Apr 2020 11:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200416145115.699033-1-eblake@redhat.com>
In-Reply-To: <20200416145115.699033-1-eblake@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 16 Apr 2020 21:20:22 +0300
Message-ID: <CAMRbyyv5=AsFLsaaWg9hEWo4NgR=OMzLgvG5=spcHXmNJGebUA@mail.gmail.com>
Subject: Re: [PATCH 0/3] qemu-img: Add convert --bitmaps
To: Eric Blake <eblake@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Eyal Shenitzky <eshenitz@redhat.com>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Benny Zlotnik <bzlotnik@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 16, 2020 at 5:51 PM Eric Blake <eblake@redhat.com> wrote:
>
> Without this series, the process for copying one qcow2 image to
> another including all of its bitmaps involves running qemu and doing
> the copying by hand with a series of QMP commands.  This makes the
> process a bit more convenient.

This seems good for copying an image chain from one storage to another,
but I think we need a similar --bitmaps option to qemu-img measure to make
this really useful.

Here is example use case showing how qemu-img measure is related:

Source chain:
/dev/vg1/base
/dev/vg1/top

Destination chain:
/dev/vg2/base
/dev/vg2/top

We create empty lvs with the same name on destination storage (/dev/vg2).

We measure the base lv using qemu-img measure for creating the target lv:

    qemu-img measure -f qcow2 -O qcow2 /dev/vg1/base
    lvcreate -L required_size /dev/vg2/base
    qemu-img create -f qcow2 /dev/vg2/base 10g

For the top lv we use the current size of the source lv - I think we
should measure it instead but
I'm not sure if qemu-img measure supports measuring a single image in a cha=
in
(maybe -o backing_file?).

    lvcreate -L current_size /dev/vg2/top
    qemu-img create -f qcow2 -b /dev/vg2/base -F qcow2 /dev/vg2/top 10g

And then convert the lvs one by one:

    qemu-img convert -f qcow2 -O qcow2 -n --bitmaps /dev/vg1/base /dev/vg2/=
base
    qemu-img convert -f qcow2 -O qcow2 -n --bitmaps -B /dev/vg2/base
/dev/vg1/top /dev/vg2/top

The first copy may fail with ENOSPC since qemu-img measure of the base
does not consider the
bitmaps in the required size.

So I think we need to add a similar --bitmaps option to qemu-img
measure, hopefully reusing the
same code to find and estimate the size of the bitmaps.

Maybe we can estimate the size using qemu-img info --bitmaps, but I
think the right way to
do this is in qemu-img measure.

We have also another use case when we collapsed an image chain to single im=
age:

Source chain:
/dev/vg1/base
/dev/vg1/top

Destination:
/dev/vg2/collapsed

In this case we measure the size of the entire chain (/dev/vg1/base <-
/dev/vg1/top) and create
/dev/vg2/collapsed in the correct size, and then we convert the chain using=
:

   qemu-img convert /dev/vg1/top /dev/vg2/collapsed

Currently we use this for exporting images, for example when creating
templates, or as a simple
backup. In this case we don't need to copy the bitmaps in the target
image - this is a new image
not used by any VM. Copying the bitmaps may also be non-trivial since
we may have the bitmaps
with the same names in several layers (e.g. result of live snapshot).

So I think using --bitmaps should be disabled when doing this kind of
convert. We can handle this
on our side easily, but I think this should fail or log a warning on
qemu-img, or require merging of
bitmaps with same names during the copy. I did not check if you
already handle this.

Finally we also have a use case when we copy the chain as is to new or
same storage, but
we create a new vm. In this case I don't think the backup history
makes sense for the new
vm, so we don't need to copy the bitmaps.

I will review the rest of the patches next week and can maybe give
this some testing.

Nir

> I still think that someday we will need a 'qemu-img bitmap' with
> various subcommands for manipulating bitmaps within an offline image,
> but in the meantime, this seems like a useful addition on its own.
>
> Series can also be downloaded at:
> https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/qemu-img-bitmaps-v1
>
> Eric Blake (3):
>   blockdev: Split off basic bitmap operations for qemu-img
>   qemu-img: Add convert --bitmaps option
>   iotests: Add test 291 to for qemu-img convert --bitmaps
>
>  docs/tools/qemu-img.rst    |   6 +-
>  Makefile.objs              |   2 +-
>  include/sysemu/blockdev.h  |  10 ++
>  blockbitmaps.c             | 217 +++++++++++++++++++++++++++++++++++++
>  blockdev.c                 | 184 -------------------------------
>  qemu-img.c                 |  81 +++++++++++++-
>  MAINTAINERS                |   1 +
>  qemu-img-cmds.hx           |   4 +-
>  tests/qemu-iotests/291     | 143 ++++++++++++++++++++++++
>  tests/qemu-iotests/291.out |  56 ++++++++++
>  tests/qemu-iotests/group   |   1 +
>  11 files changed, 514 insertions(+), 191 deletions(-)
>  create mode 100644 blockbitmaps.c
>  create mode 100755 tests/qemu-iotests/291
>  create mode 100644 tests/qemu-iotests/291.out
>
> --
> 2.26.0
>


