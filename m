Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A86C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF782222F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF782222F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUekC-0006ai-2O
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kUehy-00066x-4z
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:36:54 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kUehw-0002Lp-FA
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:36:53 -0400
Received: by mail-il1-f196.google.com with SMTP id w17so2297244ilg.8
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 16:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eL1N9gVCU+0+w2+/G+LMSsNq7qs3JUFKLzg1VhkzvoY=;
 b=qOINsY9gXwCLSMNyZGO3+liRVswZmjwbCk/jSs53B0LfR6XsCGClV2c+Ld4GERMjGC
 Hl3Hy/bHNvmwR0KTKO25MMCL1CO7Sgn10muHDHU1aXs9GB4QQYzEKNcwmcaFDcBZAqEN
 zIBQh9vid9M7NeyrziaxmhLDf+z9+lG2YkwM36zWrzxHh96N61N+VPhvwT/uOG7KkOX4
 a0ZloeQCKnKrztJiSI3fdZ7jDhw+xbPC1RNz+b62g0iyUFGECHByyh484t6o8PFv3Oms
 D/VC/xx6FD1wlUzh82eaCaTcpuPConSJQs6te+Kon9HaMhAcaqH85yuNZb9CK1rx+zgK
 RdpA==
X-Gm-Message-State: AOAM532kIp/90iJMY95viZ1KunzAvBw1qyvUysRWq5Sm41bxpqzCDmkK
 HdrAbTGH/OIlzLtDthy4IGeXe7kvczg=
X-Google-Smtp-Source: ABdhPJxXvWtiyxqpqJ2z9h4uOzYkPN7wF7HajCK8Oz5Xet0QtOxs7Ge5fEO1svFMWF/gd6+gRfS39A==
X-Received: by 2002:a05:6e02:5c7:: with SMTP id
 l7mr2147995ils.43.1603150611287; 
 Mon, 19 Oct 2020 16:36:51 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com.
 [209.85.166.172])
 by smtp.gmail.com with ESMTPSA id 128sm8846iow.50.2020.10.19.16.36.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 16:36:51 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id w17so2297210ilg.8
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 16:36:51 -0700 (PDT)
X-Received: by 2002:a05:6e02:931:: with SMTP id
 o17mr2093939ilt.273.1603150610876; 
 Mon, 19 Oct 2020 16:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-6-j@getutm.app>
 <11912dd5-2740-1d7c-c691-1174fa7ef390@linaro.org>
In-Reply-To: <11912dd5-2740-1d7c-c691-1174fa7ef390@linaro.org>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 19 Oct 2020 16:36:40 -0700
X-Gmail-Original-Message-ID: <CA+E+eSBdg6ZMXOD2LQQfuv5DPBuah45SpwM8bL-Jn-c+FdKs9Q@mail.gmail.com>
Message-ID: <CA+E+eSBdg6ZMXOD2LQQfuv5DPBuah45SpwM8bL-Jn-c+FdKs9Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] tcg: add const hints for code pointers
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.166.196; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 19:36:51
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Seems like I missed a few. Sorry about that. Will fix.

-j

On Mon, Oct 19, 2020 at 4:27 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/18/20 6:39 PM, Joelle van Dyne wrote:
> > From: osy <osy86@users.noreply.github.com>
> >
> > We will introduce mirror mapping for JIT segment with separate RX and R=
W
> > access. Adding 'const' hints will make it easier to identify read-only
> > accesses and allow us to easier catch bugs at compile time in the futur=
e.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > ---
> >  include/tcg/tcg.h            |  8 ++++----
> >  tcg/tcg.c                    |  4 ++--
> >  tcg/aarch64/tcg-target.c.inc | 19 +++++++++++--------
> >  tcg/arm/tcg-target.c.inc     | 12 +++++++-----
> >  tcg/i386/tcg-target.c.inc    | 10 +++++-----
> >  tcg/mips/tcg-target.c.inc    | 33 +++++++++++++++++++--------------
> >  tcg/ppc/tcg-target.c.inc     | 21 +++++++++++++--------
> >  tcg/riscv/tcg-target.c.inc   | 11 ++++++-----
> >  tcg/s390/tcg-target.c.inc    |  9 +++++----
> >  tcg/sparc/tcg-target.c.inc   | 10 +++++-----
> >  tcg/tcg-ldst.c.inc           |  2 +-
> >  tcg/tci/tcg-target.c.inc     |  2 +-
> >  12 files changed, 79 insertions(+), 62 deletions(-)
>
> tcg/ppc/tcg-target.c.inc:2349:26: error: assignment discards =E2=80=98con=
st=E2=80=99 qualifier
> from pointer target type [-Werror]
>      s->code_gen_epilogue =3D tb_ret_addr =3D s->code_ptr;
>
> How many of the targets did you build?
>
>
> r~

