Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75437C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 00:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80D820724
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 00:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80D820724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXwFQ-0005cH-GJ
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 20:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kXwDp-0004zm-P0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 20:55:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kXwDn-0003NX-V4
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 20:55:21 -0400
Received: by mail-io1-f67.google.com with SMTP id r9so1572777ioo.7
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 17:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9Bhulmnu3aYAPAqFGqmQW4J0uMzDRp1nj5tnQGnw9v8=;
 b=t0Lu96WJEqJ4OvLg6An50LgHKl+lWhdZe+AkboZVfMcrpW0hUQlxa+ivgVaHshM2iE
 Ue1pzg8Ktp5UL3BfgaJQY8Sf6Z4xAcPudOwjEKULs5S3dOiGbS+mco24ploVb+o71nvA
 TIKrJpFIq9nHLALUg+XHUasFWZnXs21pCPlvqKP/1+4TARIY68OPcn2eUSbR8TAyKcc+
 gWwLYq3lTkINFX9eGUlx/S2ZwM0F8EPd7KuG1tkurnYftZV8CA2lz6Fb/0fGKZeZWvOl
 zj5thdoVc3Xj43FJTurP6143VJQGDhDpmpNWArEZukhhO1aCk+g7rnvDR62vmNyHMEg6
 SVRg==
X-Gm-Message-State: AOAM531qmlGL1RwdEWAZb+OvohFaGdPWoA6SiUesRLrRQX4dztd+BgER
 CFA6m49OvSswcC+S9Sk5VyfYRbgoksk=
X-Google-Smtp-Source: ABdhPJymdnAqmHUhFcFGVkYANfOOQUnwPnLXSK81gs9f89G8BB4YyUx55cj0RtdfCb9BusWVQQlfEA==
X-Received: by 2002:a05:6602:2f90:: with SMTP id
 u16mr1685138iow.23.1603932918873; 
 Wed, 28 Oct 2020 17:55:18 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com.
 [209.85.166.45])
 by smtp.gmail.com with ESMTPSA id s127sm1043417ilc.66.2020.10.28.17.55.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 17:55:18 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id u62so1571591iod.8
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 17:55:18 -0700 (PDT)
X-Received: by 2002:a05:6638:525:: with SMTP id
 j5mr1589970jar.14.1603932918544; 
 Wed, 28 Oct 2020 17:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201028030701.14086-1-j@getutm.app>
 <20201028030701.14086-4-j@getutm.app>
 <20201028113928.GG221115@stefanha-x1.localdomain>
In-Reply-To: <20201028113928.GG221115@stefanha-x1.localdomain>
From: Joelle van Dyne <j@getutm.app>
Date: Wed, 28 Oct 2020 17:55:07 -0700
X-Gmail-Original-Message-ID: <CA+E+eSCifetWs=MHW+Q-QkTWJC8a1hj1cc=4krMbC1W+pizr6Q@mail.gmail.com>
Message-ID: <CA+E+eSCifetWs=MHW+Q-QkTWJC8a1hj1cc=4krMbC1W+pizr6Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] qemu: add support for iOS host
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.67; envelope-from=osy86dev@gmail.com;
 helo=mail-io1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 20:55:19
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 28, 2020 at 4:39 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Tue, Oct 27, 2020 at 08:06:57PM -0700, Joelle van Dyne wrote:
> > This introduces support for building for iOS hosts. When the correct Xcode
> > toolchain is used, iOS host will be detected automatically.
> >
> > block: disable features not supported by iOS sandbox
> > slirp: disable SMB features for iOS
> > target: disable system() calls for iOS
> > tcg: use sys_icache_invalidate() instead of GCC builtin for iOS
> > tests: disable tests on iOS which uses system()
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > ---
> >  configure                      | 43 +++++++++++++++++++++++++++++++++-
> >  meson.build                    |  2 +-
> >  tcg/aarch64/tcg-target.h       |  7 ++++++
> >  block.c                        |  2 +-
> >  block/file-posix.c             | 31 ++++++++++++++----------
> >  net/slirp.c                    | 16 ++++++-------
> >  qga/commands-posix.c           |  6 +++++
> >  target/arm/arm-semi.c          |  2 ++
> >  target/m68k/m68k-semi.c        |  2 ++
> >  target/nios2/nios2-semi.c      |  2 ++
> >  tests/qtest/libqos/virtio-9p.c |  8 +++++++
> >  tests/qtest/meson.build        |  7 +++---
> >  12 files changed, 101 insertions(+), 27 deletions(-)
>
> Please add a ./MAINTAINERS file entry for iOS host support.
>
> Maintainership duties involve:
> 1. Respond to emails and review patches for their subsystem.
> 2. Send pull requests with the patches they have merged.
> 3. Participate in keeping their subsystem functional, e.g. ensuring CI
>    coverage and testing is working.
>
> These are not strictly defined, people do them in different ways.
Will do.

>
> It is beneficial to get continuous integration working for iOS.
> Otherwise other maintainers may merge patches that break iOS compilation
> and you'll find out later and be left solving the issues.
If we want to do this it may come in another patch set. Reason is that
to build QEMU for iOS, you have to build all the dependencies as well,
which means downloading and building tar.gz from various sources for
specific versions. We run a CI for UTM that uses this script to build
QEMU, as you can see it's rather involved:
https://github.com/utmapp/UTM/blob/master/scripts/build_dependencies.sh

>
> > diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
> > index d7a80dd303..bb029070d3 100644
> > --- a/target/nios2/nios2-semi.c
> > +++ b/target/nios2/nios2-semi.c
> > @@ -426,6 +426,7 @@ void do_nios2_semihosting(CPUNios2State *env)
> >              result = isatty(arg0);
> >          }
> >          break;
> > +#if !defined(CONFIG_IOS) /* iOS does not have system() */
> >      case HOSTED_SYSTEM:
> >          GET_ARG(0);
> >          GET_ARG(1);
> > @@ -444,6 +445,7 @@ void do_nios2_semihosting(CPUNios2State *env)
> >              }
> >          }
> >          break;
> > +#endif
> >      default:
> >          qemu_log_mask(LOG_GUEST_ERROR, "nios2-semihosting: unsupported "
> >                        "semihosting syscall %d\n", nr);
>
> Another option is to define a system() that always returns ENOSYS. Then
> the #ifdefs can be avoided.
Done.

-j

