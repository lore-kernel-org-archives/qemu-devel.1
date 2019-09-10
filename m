Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABD1C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B6A20872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I4JMZtYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B6A20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jWm-0006CW-L4
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 13:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7jVB-0004sO-KL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7jVA-0004rh-D9
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:00:25 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38999)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7jVA-0004qm-5m
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:00:24 -0400
Received: by mail-ot1-x344.google.com with SMTP id n7so19653736otk.6
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=9NxTTZIkf4Ry49sqeWCLjcClirLTjRg9oXv+toI+LLs=;
 b=I4JMZtYIGysbWGYZnD5H9cJRdYh89C5d3ZiKzgw0e9egFam+P7crAT01g998Fudf/B
 sfTy8jIu/+L45dw8vFz2mV7xjC4ECMYVqeX/guPMXphLEs3YjliGIcKyp5sCEJ731J6w
 RHvsAyRvMphpRwJp9awGJhQzhyHL/qCkdGnWgEbS83nwKcim+n327myVbdtlljlF/LrQ
 uCcrcOBa3XpxuSLqKuxvnWKS9AT1fQsddxp2FrF1P84OGQQ8wiFRHsK2M/fB/a34ROn1
 dTAyL0uEtnU/mpenWoAtA5gPo7zFRmdC1VG/BXQTL03+ttlX8jreGmdFoINVa4CjbfXv
 u9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=9NxTTZIkf4Ry49sqeWCLjcClirLTjRg9oXv+toI+LLs=;
 b=i+z1wQwmDymFrtHNxDOIxodNGR007zOTwUV8YqbyNwQrUsOMmGSnuKks469mmMtDrU
 J3V+HrisHjtjxHBk30XpXWcv+gPZi1UpIVt5j30TS92ulw/WKvZE9ZLyQi7r/Ydn0Uym
 D9zlNHOZ5PYOX+KePJNe5Iert6J8Vgeh1t/jCHx+jmv8GEw+viCUnDij+38D7kVQNt6r
 0h6uEpy4gX0TMMccxrVLjFBzcdYriGQvamt8LwUTNjj+je7Kbe+KBrVXHxVFOwYiScHB
 TTOAguiRBfHMkza7a0/4sTlZxn75dRBv+uG46Qo6pF70fXOhragSyIfuoniCTTY9E/BP
 VbTw==
X-Gm-Message-State: APjAAAX+8WrYKojg+WBA5Umm0vmf0n7FeVEDLWzqnEhaDkZA8H8LYzMr
 wrqTuNVacedTwZTkWA1sqz1PxbFwAzWkoZ2WdsRVAA==
X-Google-Smtp-Source: APXvYqxsiTenBMnOEMoz8meJH/OZvq27cgtodoOVS6jniLhMVKyMZ0ZKorf3l/7UzVPcumk6OUUWnfSL9PEgzslqz7w=
X-Received: by 2002:a9d:68d6:: with SMTP id i22mr18309424oto.232.1568134823212; 
 Tue, 10 Sep 2019 10:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190910144428.32597-1-peter.maydell@linaro.org>
 <20190910144428.32597-12-peter.maydell@linaro.org>
In-Reply-To: <20190910144428.32597-12-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2019 18:00:12 +0100
Message-ID: <CAFEAcA_iYWMvJF2wy5P7_ddT95kuq9xWVFWcWpCMx6qAZihvig@mail.gmail.com>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 11/13] target/arm/arm-semi: Implement
 support for semihosting feature detection
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Sep 2019 at 15:44, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Version 2.0 of the semihosting specification added support for
> allowing a guest to detect whether the implementation supported
> particular features. This works by the guest opening a magic
> file ":semihosting-features", which contains a fixed set of
> data with some magic numbers followed by a sequence of bytes
> with feature flags. The file is expected to behave sensibly
> for the various semihosting calls which operate on files
> (SYS_FLEN, SYS_SEEK, etc).

> @@ -586,6 +679,18 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>              unlock_user(s, arg0, 0);
>              return guestfd;
>          }
> +        if (strcmp(s, ":semihosting-features") == 0) {
> +            unlock_user(s, arg0, 0);
> +            /* We must fail opens for modes other than 0 ('r') or 1 ('rb') */
> +            if (arg1 != 0 && arg1 != 1) {
> +                dealloc_guestfd(guestfd);
> +                errno = EINVAL;

The spec doesn't mandate any particular errno here, but
EACCES would probably be better, since that's the usual error
for trying to open a read-only file for writing.

thanks
-- PMM

