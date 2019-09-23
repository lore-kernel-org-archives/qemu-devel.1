Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE31AC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B674620673
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2Cb5iAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B674620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPYy-00026j-PQ
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCPXw-0000EK-Pb
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCPXv-0007YJ-Tb
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:42:36 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:46362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCPXv-0007Xq-Ok
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:42:35 -0400
Received: by mail-oi1-x236.google.com with SMTP id k25so7741640oiw.13
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5icTf85VfLkqyi9WYZPHM/9jzjFFZqvJQ9duujIOl5Y=;
 b=l2Cb5iAdjcp0LeIuYie+s8IsTol+50K0a29yKke1gGJVDrIzDE+Y5XNlta4K5gcUxd
 6IvFkWDBCrDPs6UNmUgo5nnT4iojXivTs5+WC+GCHsGQIfzH7mn3uCdXXWcEuiz1pRuG
 TS7zx0l0JT0U9lYXUvDbmrLnwAwYaf3zkvf0yC+evl863N/ApgmN8HjQwFtuv3AHo7De
 zSoIYsYWmCowkJfIrVN5HK7Hn7jrLgJQGemK1uQ7D2xNrJ0/cqJmDXKGuXeRRVaLzBii
 DWrRDdmIqTDq0BjuU9qaALM3oEHeOQXe+OZvW1Muo11KNjfnxrVHtdRkYj1m/9M6tC62
 75Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5icTf85VfLkqyi9WYZPHM/9jzjFFZqvJQ9duujIOl5Y=;
 b=qblsnasXo5w8JBYID96lZN0fpV5uBCtg8WBJgJt2tjtG2bR/AGDFooMjVsLId36d2z
 frSqvSxPsGjV9e31lMdeWjOMoJC0MVMTNP/H7xnGF4DYKVUg25LVNU6w73juila/+JDE
 RizRWhx+bwSTISjXcXmdhjwlUzZCQC/XaANueIkWimyB95ObMxuKInf4GKcEJ6e1QGUG
 8Zs/oqN5vzWbN3IdaA4g0qywVvJMkIn2O4lTAgjwJQBIGwVlYshWqiZvf+z/fWBsHq9Z
 VVLEcoNKKwjRR9VLjmKCUOPaheMGsCp5IHsftCu2BdlqX+5O/gHek86Hsq0/LIa2LoxO
 BHWQ==
X-Gm-Message-State: APjAAAW30eBhu1RamdqEfqu+45eW4BdCjo9S2x6G3ZABwxhLd6bqkGgy
 yfnL62Y5rjKxHOVso0NGdhU0qwScgrj9+CA0G5lseg==
X-Google-Smtp-Source: APXvYqzeA21yMzXzxDH6rmYfg2l1MtMItx/qQFgZV9dGbsNr7os3FQZoPH9LfKkYG3tI6Xn/8PhHcBeZzLiDBNfI/ZA=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr359213oib.48.1569249754767; 
 Mon, 23 Sep 2019 07:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_5D6D8ED31E83C5675AB8AA3C@qq.com>
 <c722d11e-e0ff-8a91-d8f3-ee0a31f1df33@redhat.com>
In-Reply-To: <c722d11e-e0ff-8a91-d8f3-ee0a31f1df33@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 15:42:24 +0100
Message-ID: <CAFEAcA-iiLihZp-W_kjO3bJXza-+Q-eofagv8N_DbhkbdCUwPA@mail.gmail.com>
Subject: Re: illegal hardware instruction during MIPS-I ELF linux user
 emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
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
Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Libo Zhou <zhlb29@foxmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Sep 2019 at 15:40, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> So currently there is no MIPS-I only CPU.
> Note that the code got written with MIPS32 in mind, and implementing
> MIPS-I requires a considerable amount of change in the codebase.

...but MIPS-I binaries should run on MIPS-II and newer CPUs, shouldn't
they?

> IMO it is likely the RFE (Return from Exception) instruction.

It seems unlikely that a linux userspace binary would be trying to
execute RFE...

thanks
-- PMM

