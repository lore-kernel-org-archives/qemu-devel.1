Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E13CC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3712067B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikmIvkS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3712067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKR4R-0001zi-GE
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 13:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iKR32-0000Zw-Ul
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iKR31-0005H1-Ow
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:55:52 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:36247)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iKR31-0005Ga-KC
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:55:51 -0400
Received: by mail-oi1-x229.google.com with SMTP id k20so17611157oih.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UtgQbDEIT3AnXLjNatW+1jc+eSxwFYQ/2SMoeXO3OXQ=;
 b=ikmIvkS1PnzT0Tcf/yoRX+rehgW1PIqknvTZGaBZk8g+/Ke70AwWOCwX4T4L4TUCAt
 gWgr6eK1XfuIpdEVKZBMump1fPMKQ8lJJqt2h7E5/7c7ET7+QDbvCSNKarBczfAF6lLj
 4S+AcnrMSz8wasyED0PYmZrBrq5k6R9x/XnASubhD70xI8NgLAMQZsSlomQQEj66jg9F
 8Xnj3YK/dhQWYtkXKytdDf3JIWfvZg1m4vlplKCVXjOSUf10KLGaZ/lafrQoyZLUhM1e
 WrIJR4eFdXxCUol8/4wHxvvO/dHPEZ5Q+SxOYL5UF9F9btnBVxVO3d3VaX0yxa0ja6Ps
 hQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UtgQbDEIT3AnXLjNatW+1jc+eSxwFYQ/2SMoeXO3OXQ=;
 b=TTJG2VYEvfDVEXiuRXRnjDJhs2m1/0IIsMVhFNpe0IbfS8QOro+SeMsOJlVZ3lHHVv
 +bvr5suQuwpB4r1HcIu7ft+SWLPNb+Q15W6szdhTRk23BbszNKaXCCi83y5qdbCRgOiz
 hc0rHJBv6XuC7CD8QY6dYPSlOCgVh8E/YkhZ8p0HaItfQaRzJ46+zqqoxVU7pkVza/Yy
 dlvxu+eWklavXJu81LY7GdWIBzQYrfgkjGl+BUm6fJjWQ+xUh0gpNJFIy4z33OnbTMJ9
 kmh/ODaIX/WjlN5eAkP5mF/YWLGXUnMhqWDQVJRoj1wv8GbuB3oir4FZ97aum0/xmxro
 fVqg==
X-Gm-Message-State: APjAAAXYz5zxw5Hvg92p/+htTco2EPU64Tbd7WU6yoQ0Cx9PZZJCs8D3
 Usu0k/L8x5goVFfI/xDdqjtBwBBlBFaCFOwUGTPeuQ==
X-Google-Smtp-Source: APXvYqwMU0mQtUaGerPZyM0lJconuzlstnuUX9jqUwZXKzz/cZyrM3W9ITzZjm8pXyKyq+mzhTqjzmFuTC9dFsFa8YY=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr28463124oik.146.1571162150551; 
 Tue, 15 Oct 2019 10:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191014160404.19553-1-peter.maydell@linaro.org>
 <20191014160404.19553-60-peter.maydell@linaro.org>
 <CAFEAcA-2EZnnrYViQUQK-mR0=JqR9mXNzfVNa_WR5HoCTJ+tag@mail.gmail.com>
 <a888142d-7c9e-bc15-84d3-80bd01df1d11@kaod.org>
In-Reply-To: <a888142d-7c9e-bc15-84d3-80bd01df1d11@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2019 18:55:39 +0100
Message-ID: <CAFEAcA9uFL8JVwrcWMP63tZcFK7nWSZZnaUHj0ZC1Qh0BdKijg@mail.gmail.com>
Subject: Re: [PULL 59/68] aspeed: Add an AST2600 eval board
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Oct 2019 at 18:43, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 15/10/2019 19:03, Peter Maydell wrote:
> > On Mon, 14 Oct 2019 at 17:05, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> > (armhf)pmaydell@mustang-maydell:~/qemu$
> > ./build/all-a32/arm-softmmu/qemu-system-arm -M ast2600-evb
> > qemu-system-arm: at most 2047 MB RAM can be simulated
> >
> > It's also a pretty rudely large amount of RAM to allocate
> > by default: it caused 'make check' to fail on my OSX
> > box, which is 64-bits but doesn't have huge swathes
> > of free RAM.
> >
> > I'm going to drop this patch from my queue and redo
> > the pullreq.
>
> ok. We do have such a board.
>
> What do you suggest ? We can lower the RAM to 1G for QEMU.

1GB is OK -- we have several machines that set default_ram_size to that.

If we want to handle more generally boards which have a
larger ram size by default then we probably need to
work on the 'make check' infrastructure -- right now we
have a generic test that just checks "can we instantiate
every machine model", which is what's falling over.

thanks
-- PMM

