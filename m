Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C95C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 08:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3151E2177B
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 08:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BALh30wE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3151E2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kM5Yx-0005Ur-3D
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 04:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1kM5YJ-0004yS-Fv; Sat, 26 Sep 2020 04:27:32 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:36809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1kM5YG-0003k0-5b; Sat, 26 Sep 2020 04:27:31 -0400
Received: by mail-ej1-x643.google.com with SMTP id e23so1758792eja.3;
 Sat, 26 Sep 2020 01:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aLT5Tr+qY+bS33oT4GgjLOMJ1Mn//nK1Vk8VVjgX1J4=;
 b=BALh30wE4/WHrw+haP1Y9B1mLRKZfheKs+ZSWIA3VQJSxXTKtv6/xbpEaIJfvhiHXu
 lMzgiM/wFaAGP6ihFW8H8YOdZhgQP0todNzYsF24G6yDLWHZqLgugTitbT9Nk78NbTsb
 CTuXeJJ9fAP2bl3O/GE9rLn9gtyMlUDoD5GgafLSRpOWKKx2eNH1vqos+SKqURS/qlQg
 0bP4IB41BrX63qeHj0mIe6TjV8Qsmbjw5gZV0XwVvIpalg83XYplwLhM2jYoBI3zWyWy
 gwqyuxiwBF/tLjJgzew8trtFi3ptifxsjNRSz3rT/CUOUeerDxXJVZmfvAj+rdk9f2r/
 Ez8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aLT5Tr+qY+bS33oT4GgjLOMJ1Mn//nK1Vk8VVjgX1J4=;
 b=ZpKyG9UoNB3Obgra99RasRABYVFwev9Cq0nfRlvKMbYTMeG7W9EsQppDQ4zarjHyys
 KBIeCYXbLqfntxKxaFDRQ/CeFjJphn5Uom7CUp2bgPGX4Ns8TWeePdOXxHx3jQyBSHoR
 VxYtouQ3QxF0yUMQXs1O+EyJ/wOeKesB9iW9S+9JTq6DYiPaU37d9Bbu2/CTFJYv3j21
 Ay9/YMFfdD5WE2npr/pFoK56yuTbn2g3s3wMIwXrRPpLYFBvViSi01QxyW21+pEdb0vW
 uJIbLSViWG8bxWDZbOg3KwVxlc2RSqxWa+065I+IEVLJLX+yjmRNPGvPy+MI9IOeqNjb
 dcag==
X-Gm-Message-State: AOAM530I3J5gCZkvvVBfvd8UoutD7wDKc5Rn9y9rePaX9jGQm19mCZvR
 MNs+68mbKAbePGMMYJWJGxoeapgrW1/FWg8dY5w=
X-Google-Smtp-Source: ABdhPJySzuNpXR7DYj0skIjOB4tSX0urf9NqlX5Ks4BiPNbzSIzVOGVJlgWq6bdFdLSCPrWoelIriU9WdhjISBzXqvo=
X-Received: by 2002:a17:906:c045:: with SMTP id
 bm5mr6255805ejb.311.1601108845151; 
 Sat, 26 Sep 2020 01:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqxQ3o_h7_Fwho7gu9x9Pw5jCw=z-goVMyzJgQYqZR-cgA@mail.gmail.com>
 <CAP+75-XwpLiutpW6-J3DLKFGXOVd=tLF2fG2=0=nP9+KZ0UYug@mail.gmail.com>
In-Reply-To: <CAP+75-XwpLiutpW6-J3DLKFGXOVd=tLF2fG2=0=nP9+KZ0UYug@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 26 Sep 2020 09:27:14 +0100
Message-ID: <CA+XhMqwWuMrnUsFx7re5K6Yo7UP5xdF5kNaPmVsabf-4LU9Rfw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Include endian.h for Haiku to solve bswap* macros
 build
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x643.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi the last image available the beta 2.

Regards.

On Sat, 26 Sep 2020 at 08:56, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi David,
>
> On Fri, Jun 26, 2020 at 4:08 PM David CARLIER <devnexen@gmail.com> wrote:
> >
> > From 95ef79ddff73eebd1f1bec6673c2c68209fab107 Mon Sep 17 00:00:00 2001
> > From: David Carlier <devnexen@gmail.com>
> > Date: Fri, 26 Jun 2020 13:56:14 +0000
> > Subject: [PATCH 1/3] Include endian.h for Haiku to solve bswap* macros =
build
> >  failure.
>
> Back to this patch, what version of Haiku are you using?
> I couldn't find this information in your other emails.
> Thanks,
> Phil.
>
> >
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  include/qemu/bswap.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> > index 2a9f3fe783..1d3e4c24e4 100644
> > --- a/include/qemu/bswap.h
> > +++ b/include/qemu/bswap.h
> > @@ -8,6 +8,8 @@
> >  # include <machine/bswap.h>
> >  #elif defined(__FreeBSD__)
> >  # include <sys/endian.h>
> > +#elif defined(__HAIKU__)
> > +# include <endian.h>
> >  #elif defined(CONFIG_BYTESWAP_H)
> >  # include <byteswap.h>
> >
> > --
> > 2.26.0
> >
>

