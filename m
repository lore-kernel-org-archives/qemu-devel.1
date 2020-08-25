Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D497C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE60C2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qt31tN8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE60C2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgnz-0003iF-3c
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAgOj-0001ps-MZ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:22:29 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:37736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAgOh-0004UR-L7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:22:29 -0400
Received: by mail-ed1-x544.google.com with SMTP id u1so2342859edi.4
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z+R4DS5qegSGsq8ZI8BxMYOvvF3kH3UXpp/f4rqf5HQ=;
 b=qt31tN8VFm33RKcvnxPXRsbBdESSyxNy0QOETF0XYHN2pGKkeUJzmDHw18802bdgsj
 Zi8rLwNfSJxunn0pxiVZ0pECJZbL4piS2eANmy2FGZQR0E2TCzs7b46umVXa3zfpwsBN
 43HUm2w+F9c5vsCTx0RIk3IzsR8ryU7dBT2H26Qv2yJv7YkIdyvVEO7owaQXzOqAhfER
 wvJ9p0XMI4SEMDBf+gCdFgB+H7ZrA4n1UbsRHvj/dF7xHkBLA91AZvSxffpUPrklRIdP
 QtBsruBwX8rXsbzqXYEbbd9U0FRTIaRy0llPAJJQIrPgEs4cwUXmxVAI3c+Tv3XH0k4N
 6YmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z+R4DS5qegSGsq8ZI8BxMYOvvF3kH3UXpp/f4rqf5HQ=;
 b=dqRlFveAA0eGJltbwzaJyA0DyQ+FJCL5cy8mdrAR2CPD8yXaKuVwxCrv4pwnFKyA7f
 XK9qN4ha8faTMly4kzd2zfdffR5b5ikib7etpWhOy5BRxFkjyhbTx2OD5kdtzDNFsUhs
 dqRvQHh4WUdrPHp8bYcHc5PRpEBbsvy01CTSwj0U30Fb6QeiGCSskgrh6Noc5SouJ0AY
 I+W0hhGq/N/j5dAyFACDV9l7L9zc6SafiAYJKY3kIG7REs2RAqzyeR6IqUljlsd9mRyd
 WPcJmLW1kFqygW/IwAm+yW1k3SIApDyJUDSf//deyF1l0rmTyNGpS5WU16TUn1Wv0Vdh
 vtmQ==
X-Gm-Message-State: AOAM531vaWUWSs6LDN1X8eZh/sPy06yP2Znr1knQGtSM3eT4uz/iDfNd
 hnJ7H4H1JdmX+vm+gT8+0JwtvWzl9K+xHyApTt89jQ==
X-Google-Smtp-Source: ABdhPJwZflkzIOmXmwxaVvSMt5+S99NfrzCnAzNAmXI5jvDnVWySzwzush22wJlJp00O2CK/pNft69ysPJVJGOBn/5w=
X-Received: by 2002:a50:da44:: with SMTP id a4mr12538993edk.36.1598390545579; 
 Tue, 25 Aug 2020 14:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <40710b94-094f-f91a-6ddb-94e51199a8c3@vivier.eu>
In-Reply-To: <40710b94-094f-f91a-6ddb-94e51199a8c3@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 22:22:14 +0100
Message-ID: <CAFEAcA-X-Z9adXzxunTJ=4Qu5wq7_oBreRVmO_T9nQSi=f4+rQ@mail.gmail.com>
Subject: Re: linux-user static build broken
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 21:37, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Hi,
>
> since we have switched to meson, the statically linked binaries of qemu
> linux-user are broken:
>
> cd $OBJ
> $SRC/configure --static --target-list=m68k-linux-user
> make
> ./qemu-m68k
> Segmentation fault (core dumped)

It can't be all static binaries, because part of my merge
tests is a config with
'../../configure' '--cc=ccache gcc' '--enable-debug' '--static'
'--disable-system' '--disable-gnutls'

and that works:
$ ./build/all-linux-static/qemu-m68k
qemu: no user program specified

So it must be something more specific, though I don't know what.

thanks
-- PMM

