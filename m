Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8528C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 08:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B3A2078B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 08:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slZB8vHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B3A2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGIDn-0001N9-Kl
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 04:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kGID1-0000t9-3f
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 04:45:35 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:36654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kGICz-0007Sd-7k
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 04:45:34 -0400
Received: by mail-io1-xd42.google.com with SMTP id d190so6217687iof.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 01:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2G8d7GpEYR72XsC3fazoIBLIi91oIi7F7w1mOlNzTSw=;
 b=slZB8vHMVPuDWm6iIWK2dW0zioc7QBdefBVyRewCN5TTNHi493NxFPqZfsEBAi6aH6
 N87IU31wYqxbL3xpD8SZ19RJctuek5NXM+tHRZyUJFUcKhuhVsRxTb4+mA4qbtL1hSS0
 kplK0/R9EeiyRGS6tKu4lkY+JmcCKpuHosSS7kuGjsgpMJFjr6d/f/8QenBrzCe+IQZ1
 xf+VK5WXFJHW17rK3IPP5oGQvBXzpDuR7Qw+bF3afirkSzbhlIB5GmspL8f4mat9FM12
 wsskQSWUUJ6zmyoAesIeRU9WLe/USjE3yqbY4xBnSIAOSL3RWvi7yUvRZOeWhn05Zca3
 zang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2G8d7GpEYR72XsC3fazoIBLIi91oIi7F7w1mOlNzTSw=;
 b=Rd9JmcefJzt74qAZQG5S1ihw59z/OguUr3W6aIRSuXyiGzuTku1eXI7AqYlvZzWzF/
 KF6L+iwLGpneOBLWEF9YFofxLwakmmUwCxNUWzlMTTUcgb7BNB2JdSQ3gBXItCTa8DI8
 ss3+qBxTn1FbnB/1xOnYXQMXTTtkefA3NxYkaMls+8AR6tWSXZYGsPnjT4XzD1S3umtJ
 O3looM7xoujCa5NqzutmLRs7re87iSVovSx730lrmpBIBd8sgUSngW0gTT2zeE66kIaF
 j1q9j1fKZF5p1HMo7dzosx68HGwp57iaX9vECTYQSsBYsCZOicEb3oziz0uR4Ap+3SgG
 EFUg==
X-Gm-Message-State: AOAM530vGwCSL9BMWhJSTZmZAIYLJ9kBT0orCJVYcse/lBWMuA+2I7co
 4Is1LD9zU4uYIewKewQVVjZhCBLE50vc0cDv6BM=
X-Google-Smtp-Source: ABdhPJwW+/aEsfyFBw2QPLi9paog0VMOnaQFPa4qlPyHh9W69FXVUiice/2BMkNhNdy0Wc4PcmCXL0hKYCoizS2UyoY=
X-Received: by 2002:a5e:8707:: with SMTP id y7mr6839371ioj.49.1599727531284;
 Thu, 10 Sep 2020 01:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200813165125.59928-1-liq3ea@163.com>
 <CAKXe6SL3myrx1XcoOVxkD6RxpDMRiOOVorXQrfPnShC0+Y6WUg@mail.gmail.com>
 <CAKXe6S+r1SNCBm_daBRqX-m50rNPwRHR_ZmuxdBoU_Mum-oesQ@mail.gmail.com>
In-Reply-To: <CAKXe6S+r1SNCBm_daBRqX-m50rNPwRHR_ZmuxdBoU_Mum-oesQ@mail.gmail.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 10 Sep 2020 10:45:19 +0200
Message-ID: <CAM9Jb+gm7+m7=9p3jwYKQ+cC564hvr4hnFidF=4iiJYn_30eHQ@mail.gmail.com>
Subject: Re: [PATCH] hw: virtio-pmem: detach the element fromt the virtqueue
 when error occurs
To: Li Qiang <liq3ea@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

Please add while applying the patch.

fixes: 5f503cd9f3 ("virtio-pmem: add virtio device")

On Mon, 7 Sep 2020 at 03:38, Li Qiang <liq3ea@gmail.com> wrote:
>
> ping!
>
> Li Qiang <liq3ea@gmail.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8828=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=889:21=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Kindly ping.
> >
> > Li Qiang <liq3ea@163.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8814=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:52=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > If error occurs while processing the virtio request we should call
> > > 'virtqueue_detach_element' to detach the element from the virtqueue
> > > before free the elem.
> > >
> > > Signed-off-by: Li Qiang <liq3ea@163.com>
> > > ---
> > >  hw/virtio/virtio-pmem.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
> > > index 1e0c137497..ddb0125901 100644
> > > --- a/hw/virtio/virtio-pmem.c
> > > +++ b/hw/virtio/virtio-pmem.c
> > > @@ -77,6 +77,7 @@ static void virtio_pmem_flush(VirtIODevice *vdev, V=
irtQueue *vq)
> > >
> > >      if (req_data->elem.out_num < 1 || req_data->elem.in_num < 1) {
> > >          virtio_error(vdev, "virtio-pmem request not proper");
> > > +        virtqueue_detach_element(vq, (VirtQueueElement *)req_data, 0=
);
> > >          g_free(req_data);
> > >          return;
> > >      }
> > > --
> > > 2.17.1
> > >
> > >
>

