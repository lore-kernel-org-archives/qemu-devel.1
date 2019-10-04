Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F888C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED9BD215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LR33K7hs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9BD215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGLIJ-0004MD-5D
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 06:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iGKED-0000pJ-DP
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iGKE8-00088d-V6
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:50:25 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iGKE8-00088H-OQ
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:50:20 -0400
Received: by mail-oi1-x244.google.com with SMTP id t84so5210965oih.10
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 02:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0Gh5bS3+Vusgx4lGf85ASQrcc3Xoaer4bot7JE0j5Hg=;
 b=LR33K7hsuTq2HvwSVdvMzqIX9CFmP9yJTGFaBvwPhw11SGXwYRkeSjYaes5FKV84yj
 YNG0ljkZob9DH+ISI6itg2u7A9BJ/Qtqcw/LvV0PByam5EjUy6AP3EpegrB2IMzgcPAf
 gBU/Kp7bhB9to9IhHxDeJZZKWL/tjiBZRhawknvJwfoC+0SKNL9F1J6roB9JMiG9Oy8E
 cXTcnADXofkFBQmNy9HWqwj7sGdNNHOuMLVeWOmD1SwqWRq1Lku67Br8yrntgBGs2l83
 uXk6D2AP/ArBSh+1pMVRxhgNTDs/PlqxwLWt5dUsR9KljM8rzdIZH9DRrnLWSr+jjnuV
 WOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0Gh5bS3+Vusgx4lGf85ASQrcc3Xoaer4bot7JE0j5Hg=;
 b=qTfsTikS1irRzCaZsRlxHOWtKP834XHYqRSClIsZYYWCl/b82NWfXgUtuP0y7FuTq+
 OHqjeGX6FrETbeVmRYFXJYbGsH7hhSIm/l9BNJI7XFRhHUkpTTW9TBNOVZmMxsLCvX0L
 ITl65KEDNxsfoYPFV6AbFkdI+G9pIDC67eWG/pGFmQ1roWpsffomoQtnxx9hcO7s+gN1
 S58VHpaJoBPD+uyDuZZp+x3hhHmv/1U923eFj3mshNMSoyD0SERy8crr0fd2xNCOJizJ
 KPPi3yyo5om6EsRxb/HeZJfJIh+14UZiop6cVnbkKjjStRxiiZwK4cu+JDDwM4xwwcv+
 au/w==
X-Gm-Message-State: APjAAAUFiAQDLw8BRJW9FQcS3nE9EU5Tfh10qXQQrdo0Kq5RujJPAfeh
 RbKWYReXMvD3S5FYcK9TxjdcfkJcOJO3lfmm5Mm9cQ==
X-Google-Smtp-Source: APXvYqymo1MsrBEbyuEL5o0d6t29t00xq8Z+L2f3hPj3PbzVjRFs1cio2ZCB8ng2rcDrM0C4pT1pKM4b6kpLVdXUuYk=
X-Received: by 2002:aca:53d4:: with SMTP id h203mr6138543oib.146.1570182619719; 
 Fri, 04 Oct 2019 02:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190916141544.17540-1-peter.maydell@linaro.org>
 <20190916141544.17540-2-peter.maydell@linaro.org>
 <a10f43ac-82e8-7600-94d3-513feafaf325@redhat.com>
In-Reply-To: <a10f43ac-82e8-7600-94d3-513feafaf325@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2019 10:50:08 +0100
Message-ID: <CAFEAcA9Qt++kGXTHiArfigjoZNmL=uLvDbZ9pCbcRgHP269sRg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/15] target/arm/arm-semi: Capture errno
 in softmmu version of set_swi_errno()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Oct 2019 at 00:24, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> On 9/16/19 4:15 PM, Peter Maydell wrote:
> > The set_swi_errno() function is called to capture the errno
> > from a host system call, so that we can return -1 from the
> > semihosting function and later allow the guest to get a more
> > specific error code with the SYS_ERRNO function. It comes in
> > two versions, one for user-only and one for softmmu. We forgot
> > to capture the errno in the softmmu version; fix the error.
> >
> > (Semihosting calls directed to gdb are unaffected because
> > they go through a different code path that captures the
> > error return from the gdbstub call in arm_semi_cb() or
> > arm_semi_flen_cb().)
> >
>
> Fixes: 8e71621f784

That was the commit that added support for semihosting
to softmmu in 2007, so I don't think suggesting that this
is a 'fix' to that makes much sense. This has just been
broken forever. (It's also pretty unimportant as a bug because
the semihosting 'errno' is so ill-defined as to be unused,
I think.)

thanks
-- PMM

