Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9AFC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7762054F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYKhHS9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7762054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfLXr-00051i-Vl
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 05:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60625)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hfLWq-0004XJ-MM
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hfLWp-0004nf-GJ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:44:48 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:37597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hfLWp-0004i8-5P
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:44:47 -0400
Received: by mail-qt1-x842.google.com with SMTP id y57so13784038qtk.4
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 02:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cwVaTavaFcB1gDcn+aK865cHXBOxe1yV45EQN5mazq8=;
 b=jYKhHS9f2+XrD9H3BgQkpPmnhz2uN7VZmN/BoWjsieAjEFALrthuFboavCjzpLmeit
 UEMvtYnlQu4nlvHPGI5MM6LdXy5Ga2DMEkvqWE+qWzai4KuAnTunzxEjd1DZJkuJJ/9f
 rxRrTrbZKfS23p7oKS3YjMRmv75shcBzOMX/IIZc08DOaRZ7bINhPAWxvC5g0qWE2ou6
 Cnd2pDqlaZtZXCB6evrM5i8NqyCozU7NsGKbfLIzAipAu16MK4nlMwrcsWoAo9U+SYtw
 Cf1Pziz9jWN+NzrcuL+S5V5a01W/v0MpKYGvcsQwL0+WFB9gwAUZmVDNaXdxYCengjz7
 HvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cwVaTavaFcB1gDcn+aK865cHXBOxe1yV45EQN5mazq8=;
 b=d7v8EeYiwuXrH6i09GY9486lwCyu7DdEb12AE5vENFZb2N5x8n09mBOeDz+ZwqsF8M
 Ju9OTga6N5o8aYXqCTcI8fPzEj32M7WLFvzuddCDJc57Y/p/p3Gim+AEGDye65LL0ejB
 juHwt+aBcUwKTWVnK/RoIzp/RGO52IRB/ClG84CdolEuIVgsPFu2wn+zn5J7pc9Erki7
 78Zn/99H3YRGxKw7xtdNbLx6vTbklQ1EeRKi4vFTr58QGtqNl5DAdDPTZCP1Gv0KiJ3b
 JlcWZOmvlK9xoMSkBAtXlaIvrGf9uKQnKlFWdXX5wR2xuAgOpf8UK398VUlcPp2pF2oO
 JZEw==
X-Gm-Message-State: APjAAAWRrq7sGCpcPCMBkP7EaORp2coj0tl6DN5lHdiGI+bnXYdxS1d8
 uHQkmoCcL6VSdu7DJsuvobWF0ML6Or7SDEJ3Nxg=
X-Google-Smtp-Source: APXvYqy+MD0VQRat1Z9d0x8hn8q6HWsp0Ku86Q3gKlugZ7naPWG9yXXfY6+K8EWNL2R0TFbmDwgf2gfd7zNeS9DV6CE=
X-Received: by 2002:ac8:3971:: with SMTP id
 t46mr109627428qtb.164.1561369484497; 
 Mon, 24 Jun 2019 02:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190614093121.5580-1-xieyongji@baidu.com>
 <20190614093121.5580-2-xieyongji@baidu.com>
 <20190614134452.7924f135@bahia.lan>
 <CAONzpcYMmw+4q-VmBOnrBBNbfrG4XeSggk3R2tAKmF5u6b1VcA@mail.gmail.com>
 <20190617072044.3e95124f@bahia.lan>
 <CAONzpcaPxf2aBrBhNYyFg11TFNLzjEE0qf1Hc_6ePPjb0CVYrA@mail.gmail.com>
 <20190622175140.5de328e2@bahia.lan>
In-Reply-To: <20190622175140.5de328e2@bahia.lan>
From: Yongji Xie <elohimes@gmail.com>
Date: Mon, 24 Jun 2019 17:44:33 +0800
Message-ID: <CAONzpcZQeEZCipfkyj-+nE3OmaALucVd7P3CqvTdWe6bcuMWKQ@mail.gmail.com>
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: Re: [Qemu-devel] [PATCH v3 1/5] virtio: add "use-started" property
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, pbonzini@redhat.com,
 Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 22 Jun 2019 at 23:51, Greg Kurz <groug@kaod.org> wrote:
>
> On Mon, 17 Jun 2019 14:04:10 +0800
> Yongji Xie <elohimes@gmail.com> wrote:
>
> > On Mon, 17 Jun 2019 at 13:24, Greg Kurz <groug@kaod.org> wrote:
> > >
> > > On Mon, 17 Jun 2019 10:14:30 +0800
> > > Yongji Xie <elohimes@gmail.com> wrote:
> > >
> > > > On Fri, 14 Jun 2019 at 19:45, Greg Kurz <groug@kaod.org> wrote:
> > > > >
> > > > > On Fri, 14 Jun 2019 17:31:17 +0800
> > > > > elohimes@gmail.com wrote:
> > > > >
> > > > > > From: Xie Yongji <xieyongji@baidu.com>
> > > > > >
> > > > > > In order to avoid migration issues, we introduce a "use-started"
> > > > > > property to the base virtio device to indicate whether use
> > > > > > "started" flag or not. This property will be true by default and
> > > > > > set to false when machine type <= 4.0.1.
> > > > > >
> > > > > > Suggested-by: Greg Kurz <groug@kaod.org>
> > > > > > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > > > > > ---
> > > > > >  hw/block/vhost-user-blk.c  |  4 ++--
> > > > > >  hw/core/machine.c          |  8 ++++++--
> > > > >
> > > > > This patch conflicts with latest upstream changes to hw_compat_4_0_1[].
> > > > >
> > > > > It seems you need to rebase. Also, I'm still not sure how we're supposed
> > > > > to handle hw_compat_4_0_1[] versus hw_compat_4_0[]... nobody commented
> > > > > on:
> > > > >
> > > > > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg00637.html
> > > > > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg00641.html
> > > > >
> > > > > Maybe worth to sort that out before re-posting.
> > > > >
> > > >
> > > > If hw_compat_4_0_1[] is introduced only for q35, I think this patch
> > > > should be OK. If not, maybe we should handle hw_compat_4_0_1[] in
> > > > other machine types (i440fx, arm, ppc, s390)?
> > > >
> > >
> > > It turns out that hw_compat_4_0_1[] isn't needed at all. Please see:
> > >
> > > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg03054.html
> > >
> >
> > Oh, great! I will rebase my patch after this commit is merged.
> >
> > Thanks,
> > Yongji
>
> You can proceed.
>
> https://git.qemu.org/?p=qemu.git;a=commit;h=8e8cbed09ad9d577955691b4c061b61b602406d1
>

OK, Thank you.

Thanks,
Yongji

