Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECD0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5726824A5F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5726824A5F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSMEo-0004vM-7f
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kSMBM-0003Bu-N0
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:25:45 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kSMBK-0001dv-RR
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:25:44 -0400
Received: by mail-il1-f196.google.com with SMTP id l16so189081ilj.9
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 08:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9Sw5RZgjW8IrluiS/u4RnZE7n3Ot9y4ZWsbqTOApHV4=;
 b=HaTvmJzVqbHjN2OHrUwoPcYPnQc3n7dRHlN/xbzP7LlgQovVE19TCkBKDFmnH5182r
 j5jfCSetugRPaauVzgiBnhh4sRYTauIzTdZYfLZI2Y1i8Mq1LIqe8fO5FcajmmS2ZKGV
 QAgKNhnRPaDnJutHYCqEvIP1FEdEB7NJUtgq/X9dkF9IArHHwOlaWFjj+JiLqqxFiNrw
 o5Pxfhkru6F1kgQjYkB2kS/qWP88fKdY7natWBargP/bhT5O/VOJDh7s1tG7MWst8siC
 fz4fNkCiOawIVhe/iUpaovF57r4B42swC+ZcCkCXW/INZO1mxwQMe3sqqX1ExJaOBkG2
 fBYA==
X-Gm-Message-State: AOAM530gFKE8x1eO4ATmmtnz06Gw+CxwqWEEbtNl1rlTL4ZS4VaXX4M5
 m3nzVYUWDSu4w9n0WoNyq/s+wjNEHlI=
X-Google-Smtp-Source: ABdhPJwcb0Y5aXm9tqsuwdeRuy/lW4MnL8/QdzZkx2CYU5pUKSqWVRB2F/PSw5/OiITZQNQ0jIuAqg==
X-Received: by 2002:a05:6e02:543:: with SMTP id i3mr442816ils.22.1602602741531; 
 Tue, 13 Oct 2020 08:25:41 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com.
 [209.85.166.48])
 by smtp.gmail.com with ESMTPSA id s23sm159773iol.23.2020.10.13.08.25.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 08:25:41 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id u19so23123552ion.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 08:25:41 -0700 (PDT)
X-Received: by 2002:a5d:9243:: with SMTP id e3mr20238813iol.193.1602602741080; 
 Tue, 13 Oct 2020 08:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-7-j@getutm.app>
 <20201013133135.GH164611@stefanha-x1.localdomain>
 <ff84b94c-42ff-c1ba-cb28-644678c09a21@eik.bme.hu>
In-Reply-To: <ff84b94c-42ff-c1ba-cb28-644678c09a21@eik.bme.hu>
From: Joelle van Dyne <j@getutm.app>
Date: Tue, 13 Oct 2020 08:25:30 -0700
X-Gmail-Original-Message-ID: <CA+E+eSBugfLVb7wk_8TxkczgvsJCGm2s8tYx=Go1QxcitXgL+g@mail.gmail.com>
Message-ID: <CA+E+eSBugfLVb7wk_8TxkczgvsJCGm2s8tYx=Go1QxcitXgL+g@mail.gmail.com>
Subject: Re: [PATCH 06/10] coroutine: add libucontext as external library
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.196; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 11:25:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Joelle van Dyne <j@getutm.app>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for providing the link.

I'm not sure what license that is/if it is compatible with GPLv2. Can
someone provide guidance on what to update in QEMU's license? I am not
too familiar with all this license stuff.

Regarding building for iOS, as Balaton said it is possible with an OSX
host. However, it does require some work to set up all the right
environment variables (Apple does not follow standard conventions for
cross compiling). You can see the build script we use for UTM:
https://github.com/utmapp/UTM/blob/master/scripts/build_dependencies.sh

However, a lot of the changes does work on other platforms
(libucontext and bulletproof (mirror mapped) JIT are two major ones).
We used iOS build to guard these features because they are only useful
for iOS, but we can make it a configure option if that's desired?

-j

On Tue, Oct 13, 2020 at 7:49 AM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Tue, 13 Oct 2020, Stefan Hajnoczi wrote:
> > On Mon, Oct 12, 2020 at 04:29:35PM -0700, Joelle van Dyne wrote:
> >> From: osy <osy86@users.noreply.github.com>
> >>
> >> iOS does not support ucontext natively for aarch64 and the sigaltstack is
> >> also unsupported (even worse, it fails silently, see:
> >> https://openradar.appspot.com/13002712 )
> >>
> >> As a workaround we include a library implementation of ucontext and add it
> >> as a build option.
> >>
> >> Signed-off-by: Joelle van Dyne <j@getutm.app>
> >
> > Hi,
> > Thanks for sending posting this!
> >
> > Please indicate what license libucontext is under, that it is compatible
> > with QEMU's overall GPL v2 license, and update QEMU license
>
> https://github.com/utmapp/libucontext/blob/master/LICENSE
>
> Maybe the submodule repo should be mirrored in qemu.git eventually.
>
> > documentation (LICENSE, etc), if necessary.
> >
> > Please update .gitlab-ci.yml with build tests. Is there a way to test
> > building QEMU for iOS? If not, then it's difficult for the upstream QEMU
> > project to carry iOS-specific features since we cannot test them.
>
> Build testing should be possible on OS X host that I think we already have
> provided it has the right XCode version installed. (Running it is
> difficult due to app deployment requirements of iOS devices.) But I don't
> know much about these, just trying to point at some possible directions to
> solve this.
>
> Regards,
> BALATON Zoltan

