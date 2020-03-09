Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7BBC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03B120727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnXua6EZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03B120727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBIZx-0001yy-QG
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 09:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBIZ7-0001CL-T0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBIZ6-0004qe-Ny
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:35:29 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBIZ6-0004qR-Hr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:35:28 -0400
Received: by mail-oi1-x244.google.com with SMTP id k21so3221961oij.5
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oBD6zMZ3/A1XQ82CnQ5bJnjoI9sExy80KKinIwyaFIo=;
 b=dnXua6EZQUkka6qnXpu8wPecyLUdA5wnP+riA9D9HryWi1EOXZwIMIrRSjMxZ1RRkj
 SqIfxJAllVVA7tvEAcEIhmd7UNXjCgYnvY1f4yRimFDA+6rS+jGDoBt4qQbg8cF3EuEd
 ugqKv5xFkNEIL6CJWpz85HjCajKDP9x2w48IGl7h3SbROUBX/nwOrQ0syJMagMmgGkyB
 QAPWp945ZIzpj6oJ6vlNADELBwvlIZZQ2gKlUoDZ0fJ2XhAYrkl5PpMAQLk+4TdBbC92
 haY0af+lq5VtOzzbg92ie2knVwZvhf0Vcu1IT6YJjU3znPoMDHJ/tburljiZpKv+b3Ml
 wAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oBD6zMZ3/A1XQ82CnQ5bJnjoI9sExy80KKinIwyaFIo=;
 b=kWIZtSSc5GRN7MOL5HdAUR0iZ8Sy1FiwpIEbNN6qRZpJR+sGpBWubEvUIW+om1uSdU
 gx4jfiPZouYnyfy/t3YsOREYM0N5BBdASIWGJ5ReQGhHOPjwrHHZA0eo6jFw/S4bWhuW
 lo1uRAXFpLVKtKAQgTm2D0+Nh1ctPRdGBrz1++cVIusbYEFMqsHGubFGGbqTTFnIYdRJ
 LbtAIQoIYF9Gdc3+JhE3eZsbHQMVKS+4+4zA9lBSCCogUGawoDohy+c3nclZ2ktqhpCD
 SSn4jA6CzDaqArNWE2W1F8f9cd3vS0Sh0St6jpMqIUNGm1mzx9Vu+J7vgh2FTl1fNL9L
 ajug==
X-Gm-Message-State: ANhLgQ0Gu745OCPQaRrfxKZIvz0F8/zLgkq5mJaZIvwJcvOaVer87ch6
 NeIHIp8gR7B51qoqzHMU36VDCSqD8RXA9/y7MZeqZQ==
X-Google-Smtp-Source: ADFU+vvgw5WiaGCYjO7uHgENNgLcNIp414nUloULJ/W54crrItR62BqSHrZDfpgVpyA/ctj8zUUpLuiFT7oojQDgtw4=
X-Received: by 2002:aca:c695:: with SMTP id w143mr1183737oif.98.1583760927046; 
 Mon, 09 Mar 2020 06:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200305154142.63070-1-jingqi.liu@intel.com>
 <20200305161047.GB3627464@lpt>
 <CAFEAcA-OQncMrU_-DJJ9g5rEcrJvbhTOjOVs0YqO3NS_Y413OQ@mail.gmail.com>
 <f774652b-5145-1e47-62c4-99a69a037506@intel.com>
In-Reply-To: <f774652b-5145-1e47-62c4-99a69a037506@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 13:35:15 +0000
Message-ID: <CAFEAcA8HMSg8nS27YGPEQsPeGW2UicWRxeJDQf3oKbyHH2TY6Q@mail.gmail.com>
Subject: Re: [PATCH] util: fix to get configuration macros in util/mmap-alloc.c
To: "Liu, Jingqi" <jingqi.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?J=C3=A1n_Tomko?= <jtomko@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 at 13:23, Liu, Jingqi <jingqi.liu@intel.com> wrote:
>
> On 3/6/2020 12:40 AM, Peter Maydell wrote:
> > On Thu, 5 Mar 2020 at 16:11, J=C3=A1n Tomko <jtomko@redhat.com> wrote:
> >> On a Thursday in 2020, Jingqi Liu wrote:
> >>> The CONFIG_LINUX symbol is always not defined in this file.
> >>> This fixes that "config-host.h" header file is not included
> >>> for getting macros.
> >>>
> >>> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> >>> ---
> >>> util/mmap-alloc.c | 2 ++
> >>> 1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> >>> index 27dcccd8ec..24c0e380f3 100644
> >>> --- a/util/mmap-alloc.c
> >>> +++ b/util/mmap-alloc.c
> >>> @@ -10,6 +10,8 @@
> >>>   * later.  See the COPYING file in the top-level directory.
> >>>   */
> >>>
> >>> +#include "config-host.h"
> >>> +
> >> According to CODING_STYLE.rst, qemu/osdep.h is the header file
> >> that should be included first, before all the other includes.
> >>
> >> So the minimal fix would be moving qemu/osdep.h up here.
> > Yes, osdep must always be first.
> >
> >>> #ifdef CONFIG_LINUX
> >>> #include <linux/mman.h>
> >>> #else  /* !CONFIG_LINUX */
> > Do we really need this? osdep.h will pull in sys/mman.h
> > for you, which should define the MAP_* constants.
> >
> > Also, you have no fallbmack for "I'm on Linux but the
> > system headers don't define MAP_SHARED_VALIDATE or
> > MAP_SYNC". Wouldn't it be better to just have
> > #ifndef MAP_SYNC
> > #define MAP_SYNC 0
> > #endif
> >
> > etc ?
> osdep.h pulls in sys/mman.h, which defines the MAP_* constants
>
> except for MAP_SYNC and MAP_SHARED_VALIDATE on Linux.

Why not? Is this just "not yet in the version of glibc
we're using", or is it a bug/missed feature in glibc
that needs to be addressed there ?

> How about just adding the following code in util/mmap-alloc.c ?

> #ifndef MAP_SYNC
> #define MAP_SYNC 0x80000
> #endif
>
> #ifndef MAP_SHARED_VALIDATE
> #define MAP_SHARED_VALIDATE 0x03
> #endif

You don't want to do that for non-Linux systems, so there
you need to fall back to defining them to be 0.

Are there any systems (distros) where the standard system
sys/mman.h does not define these new MAP_* constants but we
still really really need to use them? If not, then we
could just have the fallback-to-0 fallback everywhere.

thanks
-- PMM

