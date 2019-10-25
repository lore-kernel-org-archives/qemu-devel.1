Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CA5CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F28206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F28206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNttV-0004Tt-T6
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eperezma@redhat.com>) id 1iNtem-0004tX-ID
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eperezma@redhat.com>) id 1iNtek-0002eV-GP
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:05:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eperezma@redhat.com>) id 1iNtek-0002e6-7v
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:05:06 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3560A8553A
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:05:05 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id i25so1141522qtm.17
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jaU+a1DOZ+2dLUMLmjJ8bYnnb76fIjnC6aZYWl0Rw1E=;
 b=t6EHK/YmVDdcx+AQMf578d6SylH1mex+axd8CcCIggvh9VMoySXVT/It1fmPCMajQs
 o5HGFjjowo2d+l663pRcK/mmf/ob/ffKB7XJ8KdwpyKUjUJI4FGRvSvVuEuypqgpcXhp
 g0aFKnK42KbvPpp0fCiqybQWqcFmBTwr7Dx5G/D3S+YIoybyOue1EYTNTTUT4SdfOChz
 GXTW3EfbQaLlanhIvEs/uuYMOnMsv3+hqRtw1Bv2zT2Eb+/GfW4TRPau7bVyRnfqRtiy
 zaJg/Wrma3iD1j7vhVatFvSXVspv/zSTr3tsdFfY6RMBsteWXnJg6SGXV0QMSIa9hMgD
 swuQ==
X-Gm-Message-State: APjAAAXeZ9mLF7Hg+vbBzlMmMWSCZEbtnYSF73M+mOOVNCKfvjFxbU73
 BTBvrDtEeJtpKTNCvtJ/xhDBgBErnOOThmbMttUG224+hu9WZtEF+VMC+tAuf3fdsKQHLkmNiqW
 i+TzWUapxPnPQBBoqWOA0QCACzkjvmB4=
X-Received: by 2002:ad4:50a8:: with SMTP id d8mr1858778qvq.8.1571987104446;
 Fri, 25 Oct 2019 00:05:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzSXwDLSczTCfxlMDfxDxVCO5uH4a6g5+b0UcgRwvXlzQXcPlZQ02uVwTLs95eq9NNx/6PJKk7nUMgx7H5CZBI=
X-Received: by 2002:ad4:50a8:: with SMTP id d8mr1858757qvq.8.1571987104182;
 Fri, 25 Oct 2019 00:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191024171406.12504-1-eperezma@redhat.com>
 <118b31fe-d1c1-9e96-84ac-c76829dd3ada@redhat.com>
In-Reply-To: <118b31fe-d1c1-9e96-84ac-c76829dd3ada@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 25 Oct 2019 09:04:27 +0200
Message-ID: <CAJaqyWe0Cdb38uiGaPHtu_M_LPCve9yoD3Lgj+2yBz6wcu=Vrg@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Packed virtqueue for virtio
To: Jason Wang <jasowang@redhat.com>
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jason!

I can post a new version. You will have it in a moment.

Thanks!

On Fri, Oct 25, 2019 at 5:20 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2019/10/25 =E4=B8=8A=E5=8D=881:13, Eugenio P=C3=A9rez wrote:
> > Hi:
> >
> > This is an updated version of packed virtqueue support based on Wei and=
 Jason's
> > V5, mainly solving the clang leak detector error CI gave.
> >
> > Please review.
> >
> > Changes from V5:
> > - Fix qemu's CI asan error.
> > - Move/copy rcu comments.
> > - Merge duplicated vdev->broken check between split and packet version.
> >
> > Eugenio P=C3=A9rez (3):
> >    virtio: Free rng and blk virqueues
> >    virtio: add some rcu comments
> >    virtio: Move vdev->broken check to dispatch drop_all
> >
> > Jason Wang (4):
> >    virtio: basic packed virtqueue support
> >    virtio: event suppression support for packed ring
> >    vhost_net: enable packed ring support
> >    virtio: add property to enable packed virtqueue
> >
> > Wei Xu (2):
> >    virtio: basic structure for packed ring
> >    virtio: device/driverr area size calculation refactor for split ring
>
>
> Looks good to me.
>
> Just two nits:
>
> I tend to squash patch 8 and patch 9 into the patch that introduces
> those issues and split patch 3 into two parts.
>
> Btw, if you wish you can add your s-o-b to the series.
>
> Do you want to post a new version or I can tweak them by myself?
>
> Thanks
>
>
> >
> >   hw/block/virtio-blk.c       |    7 +-
> >   hw/char/virtio-serial-bus.c |    2 +-
> >   hw/net/vhost_net.c          |    2 +
> >   hw/scsi/virtio-scsi.c       |    3 +-
> >   hw/virtio/virtio-rng.c      |    1 +
> >   hw/virtio/virtio.c          | 1154 ++++++++++++++++++++++++++++++++++=
++++-----
> >   include/hw/virtio/virtio.h  |   14 +-
> >   7 files changed, 1045 insertions(+), 138 deletions(-)
> >

