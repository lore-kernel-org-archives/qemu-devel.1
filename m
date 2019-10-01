Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0487C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBEB21906
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jWO4VB6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBEB21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFFVa-0005Ew-NR
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 06:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iFFUQ-0004ho-Ki
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iFFUP-0006V7-6x
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:34:42 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34896)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iFFUO-0006UH-UQ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:34:41 -0400
Received: by mail-oi1-x242.google.com with SMTP id x3so13954301oig.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 03:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NylpNVV6PMIcDWWobfsZBmbmXSQKbW6h2hQ8yLCg8U8=;
 b=jWO4VB6V4XeH6wd+e4KXpDjZnIaMQ/yWTXIkoEBta9SahwgjsJspTVxoN8uLdi7Cu3
 okNVCVesJDqfc+cxGXce+c8RSzMM6JyshKcyVGqlqo6EqU5342DXzVydgaL5Msct6nVD
 qHh09AOqOvtEaA3Akh2iy5WZqtIL4QvTtvTQmGKNfE4YVGE/pGGHGeUO1RME62WMOc1E
 8+6TiakrNexOEiRD6e9lxjzBG84202XgSU/pdvbmHST7FgvR9mvXDpd1WoNNfdzHG9KQ
 D9k/roZU8BWmR1aZKlbW06bpIPANzKDiKUC/0DysT8CU8yvxIJEwEebHgW9kUN10McZ1
 Mqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NylpNVV6PMIcDWWobfsZBmbmXSQKbW6h2hQ8yLCg8U8=;
 b=j8OZJ17qkGD6ABef5xpTPczyL6QppB3Bwz96/p81gATzCriXmURHx65mRuhJ8f+Air
 9Pibs31iwi5T1yk+pxZKjw3N6w9AKa265PJmFY+I987RkSE1AOsHRL61kM3UWFKRm1pL
 9DvHEXfEudGPzq44pNLpD5bL41ei6f6gvl8iJMbFBl2txkxw5x3l3rdND4xpRowfrsxd
 QAAur/Abce0BlvwIORqJBjjJZNvu5PdOhJleQ86pqMnoCz2dWiAmoapjQIlGjOGNcE7i
 JaFDqKIUlcl91S9m2UAk0cvnvLilwQCfSNah7mHhTh6MDieuVqKvxzqZwxmX2upX9wZl
 CCFw==
X-Gm-Message-State: APjAAAXkVPp6dZhPBNwnNYKYlgFWlrMMSwiIu0Cf3Z87js+G1/IomeWJ
 JCaWjKiuiMjTJJ+cB56HZ9y9HsumfjZUfgc6QckARA==
X-Google-Smtp-Source: APXvYqy3RLAaNFkLb/Nql7qcbg+FmurvwJXq0WsgOYwgzUhDz4lxGA5iiavvHixgd+mOl5dSMdcjgcJi4lw3Vd8OsFk=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr2986430oib.48.1569926079110; 
 Tue, 01 Oct 2019 03:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190930192931.20509-1-richard.henderson@linaro.org>
 <ec1ace6c-49db-e769-e43e-6b0e059d6705@linaro.org>
In-Reply-To: <ec1ace6c-49db-e769-e43e-6b0e059d6705@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Oct 2019 11:34:28 +0100
Message-ID: <CAFEAcA9r+N5Q076kWYyu0a+_VvnzU0FRXZK7hZ4t52JO=a3qTA@mail.gmail.com>
Subject: Re: [PATCH] user-exec: Do not filter the signal on si_code
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
 David Gibson <david@gibson.dropbear.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Sep 2019 at 22:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/30/19 12:29 PM, Richard Henderson wrote:
> > This is a workaround for a ppc64le host kernel bug.

> > However, the host kernel has supplied si_code == SEGV_MAPERR,
> > which is obviously incorrect.

> It is disappointing about the kernel bug.  But since this affects Centos 7,
> which is what *all* of the gcc compile farm ppc64 machines use, I think we need
> to work around it somehow.

We knew about the ppc kernel bug in 2018:
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06049.html
and the decision at that time was to say "kernel bug, update your
kernel" :-)

thanks
-- PMM

