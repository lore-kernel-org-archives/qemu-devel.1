Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDEAC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 00:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C8720724
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 00:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C8720724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXwCg-0004aY-9x
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 20:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kXwAQ-00047x-09
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 20:51:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kXwAO-0002nP-62
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 20:51:49 -0400
Received: by mail-io1-f68.google.com with SMTP id k6so1603158ior.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 17:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xz7A0Om8woUlfIYQuKKE/to1jFse3CB4MoAfqMWsTOA=;
 b=X8TXoWtLFs3ueCzFqM4xjDXciqyOElgYIOJuUJFp8bK2RXk6yKY0eDCoLOeUsQ7q2P
 I+vf9ZVfbxNgHRMwZrYfoyQbEr52FJUmM9YvFtQBDq/uvMHJaraRsdWtWJ2zaL4FvRGh
 SYhQgGBhBVOb2496Yqc5OgxdL/yWsq7ac/7KPKzxoVktrqW5XeH9Chu3URwxIWdTbqpR
 CtIBFQK4tYyxalwBmQ1UEmM+6hmF97J00UaN9xArpEp7OTH8xSDp2tPjTeChMfOKS216
 7no8gaZ3b8J7x8ocVSAiYNmGZIWcG/n2X+feYRfS0QjIWGUZQh3KmYt6GC0NOZk2dCtu
 npHA==
X-Gm-Message-State: AOAM531mvN/OyM1+TWeHihkMQsKi2LiLKcTl7yg/gBwTPslJ7G15wF3N
 hR96yr86Bf6VlFFjoGU9QBvLQIlEayo=
X-Google-Smtp-Source: ABdhPJycRqD7QDLLP2CRHIR5yWExDhzA5aIur9XORWfPq3z8Y4/xB+XCTvX+yeKK7oYhxh3agE3yxQ==
X-Received: by 2002:a05:6638:22c2:: with SMTP id
 j2mr1546247jat.25.1603932706606; 
 Wed, 28 Oct 2020 17:51:46 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com.
 [209.85.166.41])
 by smtp.gmail.com with ESMTPSA id e13sm920096ili.67.2020.10.28.17.51.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 17:51:46 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id k6so1603123ior.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 17:51:46 -0700 (PDT)
X-Received: by 2002:a5e:d719:: with SMTP id v25mr1699856iom.32.1603932705859; 
 Wed, 28 Oct 2020 17:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201028030701.14086-1-j@getutm.app>
 <20201028030701.14086-2-j@getutm.app>
 <20201028112200.GF221115@stefanha-x1.localdomain>
In-Reply-To: <20201028112200.GF221115@stefanha-x1.localdomain>
From: Joelle van Dyne <j@getutm.app>
Date: Wed, 28 Oct 2020 17:51:35 -0700
X-Gmail-Original-Message-ID: <CA+E+eSAes96zGAmr_FdVw5vcbTJ9vJPt+-wVDx4_8iCXcJgpLw@mail.gmail.com>
Message-ID: <CA+E+eSAes96zGAmr_FdVw5vcbTJ9vJPt+-wVDx4_8iCXcJgpLw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] configure: option to disable host block devices
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.68; envelope-from=osy86dev@gmail.com;
 helo=mail-io1-f68.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 20:51:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Joelle van Dyne <j@getutm.app>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 28, 2020 at 4:22 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Tue, Oct 27, 2020 at 08:06:55PM -0700, Joelle van Dyne wrote:
> > Some hosts (iOS) have a sandboxed filesystem and do not provide low-level
> > APIs for interfacing with host block devices.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > ---
> >  configure          | 4 ++++
> >  meson.build        | 1 +
> >  block/file-posix.c | 8 +++++++-
> >  3 files changed, 12 insertions(+), 1 deletion(-)
>
> A change along these lines is needed in qapi/block-core.json:
>
>   { 'enum': 'BlockdevDriver',
>     ...
>     { 'name': 'host_device', 'if': 'defined(CONFIG_HOST_BLOCK_DEVICE)' }
>
> That way the QAPI schema reflects the QEMU binary's actual features.
Will do.

>
> >
> > diff --git a/configure b/configure
> > index 71bbe82ac5..4e68a5fefe 100755
> > --- a/configure
> > +++ b/configure
> > @@ -448,6 +448,7 @@ ninja=""
> >  skip_meson=no
> >  gettext=""
> >  mirror_jit="no"
> > +host_block_device_support="yes"
> >
> >  bogus_os="no"
> >  malloc_trim="auto"
> > @@ -5901,6 +5902,9 @@ if test "$default_devices" = "yes" ; then
> >  else
> >    echo "CONFIG_MINIKCONF_MODE=--allnoconfig" >> $config_host_mak
> >  fi
> > +if test "$host_block_device_support" = "yes" ; then
> > +  echo "CONFIG_HOST_BLOCK_DEVICE=y" >> $config_host_mak
> > +fi
> >  if test "$debug_tcg" = "yes" ; then
> >    echo "CONFIG_DEBUG_TCG=y" >> $config_host_mak
> >  fi
>
> How do you disable CONFIG_HOST_BLOCK_DEVICE? There is no ./configure
> --disable-host-block-device option.
I don't see a value in disabling as an option. It's always enabled by
default and automatically disabled for iOS.

-j

