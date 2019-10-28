Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9108CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B154C20B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B154C20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP04Q-0007tC-HV
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 04:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eperezma@redhat.com>) id 1iP01i-00018k-P8
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eperezma@redhat.com>) id 1iP01h-0001Uw-1q
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:05:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eperezma@redhat.com>) id 1iP01e-0001Sb-NA
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:05:19 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DE3074ACA7
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:05:14 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id s3so9564468qkd.6
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 01:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=r7hTAQ1WgoU+NAucRbsF5ze0sj+UvC4uJvFMhrJBTz4=;
 b=JJi9Y6ku0+TvTyRm3x6kQfH9gjygVmrVMFNCDbUyl9DeOj5n+NFX2nRtroP+pkQY38
 qiFEy9dmzi7w9Z9qhNd7G75FfHeGpRp8e/7z3qEybYsTjIiWkO51b5+z7cpDCnqW6Eoc
 fB2EbvBlXUQwpD7NjaCy3NNAj5I5F6+gtY8J3Ia96xV3lkUkulotx+uppBWI2uWw0H4D
 5KJezPziLQnHQjZF+ywX31lnPLh6H5YD3ExRqYHoiuYLg1/Zh1ztjIPOBhQEJLgfVXio
 GaYwchDJMK0hLBz5x1skwMhlzsD73rs2xj9NwyZfsqk1uL6cQ+NqG9pN4WeIN548N79C
 BROg==
X-Gm-Message-State: APjAAAXoDyvNNolRbpHu7jbzk1yBlwdYCCTjF5EWDnh5GQqXIqxkEgQc
 ZX3I4i+A1imcX/qCErKc8NuJRodbtqkA9O8uVjxT+xmYkBb05sMcc3qjuYtwQLIvf+DxsEN6tKU
 iT2Prf/3AHOFfvbP7pXeLsMQy1r8Wuks=
X-Received: by 2002:a0c:fb0c:: with SMTP id c12mr15675369qvp.96.1572249914131; 
 Mon, 28 Oct 2019 01:05:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw9e7+cWoT89ESLVOKmUIwcxQzNzjFd0XTmGOBwNo0UW+0kbqcy/+2Dq5oJqz8ywlybCkIAbdboBdQ+RzeEpOg=
X-Received: by 2002:a0c:fb0c:: with SMTP id c12mr15675347qvp.96.1572249913908; 
 Mon, 28 Oct 2019 01:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191025083527.30803-1-eperezma@redhat.com>
 <20191025073257-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191025073257-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 28 Oct 2019 09:04:37 +0100
Message-ID: <CAJaqyWceninjEU6RWdObW6FNx45j9bMs9j13xK=C2UkWssGrNg@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Packed virtqueue for virtio
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Amit Shah <amit@kernel.org>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael.

Totally agree with you. I investigated that for a short time but in
the end I tested manually with the coverage instrumentation, trying to
exercise the same "code" as current tests touches in split virtqueues.

I will automate at least these paths.

Thanks!


On Fri, Oct 25, 2019 at 1:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Oct 25, 2019 at 10:35:19AM +0200, Eugenio P=C3=A9rez wrote:
> > Hi:
> >
> > This is an updated version of packed virtqueue support based on Wei and=
 Jason's
> > V6, mainly solving the clang leak detector error CI gave.
>
>
> Looks good, I will queue this up.
>
> It would be nice to add libqos based tests on top,
> based on Stefan's work.
>
>
> > Please review.
> >
> > Changes from V6:
> > - Commit reorder: Squash bugfix and sepparate big changes into smaller =
commits.
> >
> > Changes from V5:
> > - Fix qemu's CI asan error.
> > - Move/copy rcu comments.
> > - Merge duplicated vdev->broken check between split and packet version.
> >
> > Eugenio P=C3=A9rez (2):
> >   virtio: Free blk virqueues at unrealize()
> >   virtio: Free rnd virqueue at unrealize()
> >
> > Jason Wang (4):
> >   virtio: basic packed virtqueue support
> >   virtio: event suppression support for packed ring
> >   vhost_net: enable packed ring support
> >   virtio: add property to enable packed virtqueue
> >
> > Wei Xu (2):
> >   virtio: basic structure for packed ring
> >   virtio: device/driver area size calculation refactor for split ring
> >
> >  hw/block/virtio-blk.c       |    7 +-
> >  hw/char/virtio-serial-bus.c |    2 +-
> >  hw/net/vhost_net.c          |    2 +
> >  hw/scsi/virtio-scsi.c       |    3 +-
> >  hw/virtio/virtio-rng.c      |    1 +
> >  hw/virtio/virtio.c          | 1154 +++++++++++++++++++++++++++++++++++=
+++-----
> >  include/hw/virtio/virtio.h  |   14 +-
> >  7 files changed, 1045 insertions(+), 138 deletions(-)
> >
> > --
> > 2.16.5

