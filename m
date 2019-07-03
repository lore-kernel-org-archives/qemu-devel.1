Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5655C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 20:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B15218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 20:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjFGujho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B15218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hilsk-0006Xc-Cd
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 16:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59306)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hilsD-0005ws-Sx
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hilsC-0002te-VM
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:29:01 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:41235)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hilsC-0002tA-Oo
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:29:00 -0400
Received: by mail-ot1-x32e.google.com with SMTP id o101so3746299ota.8
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=//v7Mu2kGVRSZgK0v4W7WEx0L4gVzEcg7Zoa/v3sw+I=;
 b=XjFGujhomxc2GDKBSdMzuQGY1ImwuxZI5pEAsGNRFx1UsfNUhPxOZRkFBNCXnFIrmX
 UeV2gyQZnI7dYb8j9g8kRaMdLAikKeOOC50YsqDTIYzctIYMDcXf6rm8OQRpIR+/6xal
 FSiPfRoWgbKSsQG10KiaARDgVObrCFJRwYzVsrP6wG8jNj/ArLe13lG8XbHFyKufQZJJ
 88LwGlmxYXMQGh5LCghNbXXFzOhN/WuHZQdj7HUEY6IEoUEILMJK9r7ncFCvaqDFuTFq
 fEdkyDqbUf1+c0QMC/AqAdXm61wRZqptzP/sHuqrShKx/tclY5BR9J6l8GY2nw3JbVGx
 JK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=//v7Mu2kGVRSZgK0v4W7WEx0L4gVzEcg7Zoa/v3sw+I=;
 b=uYgJkfaZgOdVYo8Ei1aXatluP3w9wVjU5YW8DiKddfWdkNaf0ZmHT7dCNDGRS2ARbZ
 Xe32Roqwj4IyVQHfYQsl/I1ORWFIXO2+KCBw0rR7BEN/PFl4wU1K9J3QR4bLWHvjC46o
 KxPHW5wqhzoAhzJMIZ0iiPOyVeF7sRqHrbK4ttsY2QHYhNMpb7i7sbsUysDHHpWwQf5Y
 jQJRSTWk40qR0RsksqwOvH0zXtXzziGVtMi33JZ9/5k1UQfdb1djierZ+xHiEQX7ubBy
 XAFT5q6+H0RZZ6pTkEt0DzzIajax8XvXN7rdCzrLZszd7mC0nyhiLYl/1prE9RPFshAM
 2C3g==
X-Gm-Message-State: APjAAAWSuvYv/f5sO3uYsxRkb5geuKcHjmG43q10qUNJkoIFOIPn14X2
 xyEpd/WJxd+K0YTzP2GAe+c4cHASYz55+mz4my/LBA==
X-Google-Smtp-Source: APXvYqwPUW3Be3X4CClUPkW9PaTkbfFvS+YkodkfwM/GGTF4eNsuU9FAWzBUfTb8C5maf99EAVBfpd3I5YtoZPFNEXY=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr31459880oti.91.1562185739741; 
 Wed, 03 Jul 2019 13:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <BN6PR2201MB12513A40434D1750AAF40020C6FB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <c2660cf1-d23d-69ed-0f6b-2c450542cb18@vivier.eu>
 <BN6PR2201MB1251AE1CACDAD8DC61CDC39CC6FB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB1251AE1CACDAD8DC61CDC39CC6FB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Jul 2019 21:28:48 +0100
Message-ID: <CAFEAcA9n+NqrOvejcCe5aNAOEai+9gRQQtforjKDMMJnNBLxOw@mail.gmail.com>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [BUG] Inappropriate size of target_sigset_t
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jul 2019 at 21:20, Aleksandar Markovic <amarkovic@wavecomp.com> wrote:
>
> From: Laurent Vivier <laurent@vivier.eu>
> > If I compare with kernel, it looks good:
> > ...
> > I think there is no problem.
>
> Sure, thanks for such fast response - again, I am glad if you are right. However, for some reason, glibc (and musl too) define sigset_t differently than kernel. Please take a look. I am not sure if this is covered fine in our code.

Yeah, the libc definitions of sigset_t don't match the
kernel ones (this is for obscure historical reasons IIRC).
We're providing implementations of the target
syscall interface, so our target_sigset_t should be the
target kernel's version (and the target libc's version doesn't
matter to us). On the other hand we will be using the
host libc version, I think, so a little caution is required
and it's possible we have some bugs in our code.

thanks
-- PMM

